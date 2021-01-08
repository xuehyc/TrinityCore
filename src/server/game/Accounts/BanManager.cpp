/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "BanManager.h"
#include "AccountMgr.h"
#include "CharacterCache.h"
#include "DatabaseEnv.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "Language.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldSession.h"
#include "GameTime.h"
#include "GameConfig.h"
#include "Timer.h"

BanManager* BanManager::instance()
{
    static BanManager instance;
    return &instance;
}

/// Ban an account, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanAccount(std::string const& accountName, std::string_view duration, std::string const& reason, std::string const& author)
{
    if (accountName.empty() || duration.empty())
        return BAN_SYNTAX_ERROR;

    // Prevent banning an already banned account
    if (AccountMgr::IsBannedAccount(accountName))
        return BAN_EXISTS;

    uint32 durationSecs = Warhead::Time::TimeStringTo<Seconds>(duration);
    uint32 accountID = AccountMgr::GetId(accountName);

    if (!accountID)
        return BAN_SYNTAX_ERROR;

    ///- Disconnect all affected players (for IP it can be several)
    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

    // make sure there is only one active ban
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->setUInt32(0, accountID);
    trans->Append(stmt);

    // No SQL injection with prepared statements
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_BANNED);
    stmt->setUInt32(0, accountID);
    stmt->setUInt32(1, durationSecs);
    stmt->setString(2, author);
    stmt->setString(3, reason);
    trans->Append(stmt);

    if (WorldSession* session = sWorld->FindSession(accountID))
        if (session->GetPlayerName() != author)
            session->KickPlayer("Ban Account at condition 'FindSession(account)->GetPlayerName() != author'");

    LoginDatabase.CommitTransaction(trans);

    if (CONF_GET_BOOL("ShowBanInWorld"))
    {
        if (durationSecs)
            sWorld->SendWorldText(LANG_BAN_ACCOUNT_MESSAGE_WORLD, author.c_str(), accountName.c_str(), Warhead::Time::ToTimeString<Seconds>(durationSecs).c_str(), reason.c_str());
        else
            sWorld->SendWorldText(LANG_BAN_ACCOUNT_PERM_MESSAGE_WORLD, author.c_str(), accountName.c_str(), reason.c_str());
    }

    return BAN_SUCCESS;
}

/// Ban an account by player name, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanAccountByPlayerName(std::string const& characterName, std::string_view duration, std::string const& reason, std::string const& author)
{
    if (characterName.empty() || duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 accountID = sCharacterCache->GetCharacterAccountIdByName(characterName);
    if (!accountID)
        return BAN_SYNTAX_ERROR;

    std::string accountName;

    if (!sAccountMgr->GetName(accountID, accountName))
        return BAN_SYNTAX_ERROR;

    return BanAccount(accountName, duration, reason, author);
}

/// Ban an IP address, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanIP(std::string const& IP, std::string_view duration, std::string const& reason, std::string const& author)
{
    if (IP.empty() || duration.empty())
        return BAN_SYNTAX_ERROR;

    uint32 durationSecs = Warhead::Time::TimeStringTo<Seconds>(duration);

    // No SQL injection with prepared statements
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BY_IP);
    stmt->setString(0, IP);

    PreparedQueryResult resultAccounts = LoginDatabase.Query(stmt);
    stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_IP_BANNED);
    stmt->setString(0, IP);
    stmt->setUInt32(1, durationSecs);
    stmt->setString(2, author);
    stmt->setString(3, reason);
    LoginDatabase.Execute(stmt);

    if (CONF_GET_BOOL("ShowBanInWorld"))
    {
        if (durationSecs)
            sWorld->SendWorldText(LANG_BAN_IP_MESSAGE_WORLD, author.c_str(), IP.c_str(), Warhead::Time::ToTimeString<Seconds>(durationSecs).c_str(), reason.c_str());
        else
            sWorld->SendWorldText(LANG_BAN_IP_PERM_MESSAGE_WORLD, author.c_str(), IP.c_str(), reason.c_str());
    }

    if (!resultAccounts)
        return BAN_SUCCESS;

    ///- Disconnect all affected players (for IP it can be several)
    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();

    do
    {
        Field* fields = resultAccounts->Fetch();
        uint32 accountID = fields[0].GetUInt32();

        if (WorldSession* session = sWorld->FindSession(accountID))
            if (session->GetPlayerName() != author)
                session->KickPlayer("Ban IP at condition 'FindSession(account)->GetPlayerName() != author'");

    } while (resultAccounts->NextRow());

    LoginDatabase.CommitTransaction(trans);

    return BAN_SUCCESS;
}

/// Ban an character, duration will be parsed using TimeStringToSecs if it is positive, otherwise permban
BanReturn BanManager::BanCharacter(std::string const& characterName, std::string_view duration, std::string const& reason, std::string const& author)
{
    Player* targetPlayer = ObjectAccessor::FindConnectedPlayerByName(characterName);
    ObjectGuid::LowType targetGuid = 0;
    uint32 durationSecs = Warhead::Time::TimeStringTo<Seconds>(duration);

    /// Pick a player to ban if not online
    if (!targetPlayer)
    {
        ObjectGuid fullGuid = sCharacterCache->GetCharacterGuidByName(characterName);
        if (fullGuid.IsEmpty())
            return BAN_NOTFOUND; // Nobody to ban

        targetGuid = fullGuid.GetCounter();
    }
    else
        targetGuid = targetPlayer->GetGUID().GetCounter();

    // Use transaction in order to ensure the order of the queries
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    // make sure there is only one active ban
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_BAN);
    stmt->setUInt32(0, targetGuid);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_BAN);
    stmt->setUInt32(0, targetGuid);
    stmt->setUInt32(1, durationSecs);
    stmt->setString(2, author);
    stmt->setString(3, reason);
    trans->Append(stmt);
    CharacterDatabase.CommitTransaction(trans);

    if (targetPlayer)
        targetPlayer->GetSession()->KickPlayer("Ban");

    if (CONF_GET_BOOL("ShowBanInWorld"))
    {
        if (durationSecs)
            sWorld->SendWorldText(LANG_BAN_CHARACTER_MESSAGE_WORLD, author.c_str(), characterName.c_str(), Warhead::Time::ToTimeString<Seconds>(durationSecs).c_str(), reason.c_str());
        else
            sWorld->SendWorldText(LANG_BAN_CHARACTER_PERM_MESSAGE_WORLD, author.c_str(), characterName.c_str(), reason.c_str());
    }

    return BAN_SUCCESS;
}

/// Remove a ban from an account
bool BanManager::RemoveBanAccount(std::string const& accountName)
{
    uint32 accountID = AccountMgr::GetId(accountName);
    if (!accountID)
        return false;

    // NO SQL injection as account is uint32
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->setUInt32(0, accountID);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from an player name
bool BanManager::RemoveBanAccountByPlayerName(std::string const& characterName)
{
    uint32 accountID = sCharacterCache->GetCharacterAccountIdByName(characterName);
    if (!accountID)
        return false;

    // NO SQL injection as account is uint32
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED);
    stmt->setUInt32(0, accountID);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from an account
bool BanManager::RemoveBanIP(std::string const& IP)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_IP_NOT_BANNED);
    stmt->setString(0, IP);
    LoginDatabase.Execute(stmt);

    return true;
}

/// Remove a ban from a character
bool BanManager::RemoveBanCharacter(std::string const& characterName)
{
    Player* playerBanned = ObjectAccessor::FindConnectedPlayerByName(characterName);
    ObjectGuid::LowType playerGuid = 0;

    /// Pick a player to ban if not online
    if (!playerBanned)
    {
        ObjectGuid fullGuid = sCharacterCache->GetCharacterGuidByName(characterName);
        if (fullGuid.IsEmpty())
            return false;

        playerGuid = fullGuid.GetCounter();
    }
    else
        playerGuid = playerBanned->GetGUID().GetCounter();

    if (!playerGuid)
        return false;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_BAN);
    stmt->setUInt32(0, playerGuid);
    CharacterDatabase.Execute(stmt);
    return true;
}

Optional<std::tuple<uint32, uint32, std::string, std::string>> BanManager::GetBanInfoIP(std::string_view characterName)
{
    uint32 accountID = sCharacterCache->GetCharacterAccountIdByName(std::string(characterName));
    if (!accountID)
        return std::nullopt;

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_IP_INFO_BY_ACC_ID);
    stmt->setUInt32(0, accountID);

    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
        return std::nullopt;

    Field* fields = result->Fetch();

    return std::make_tuple(fields[0].GetUInt32(), fields[1].GetUInt32(), fields[2].GetString(), fields[3].GetString());
}

Optional<std::tuple<uint32, uint32, std::string, std::string>> BanManager::GetBanInfoAccount(std::string_view characterName)
{
    uint32 accountID = sCharacterCache->GetCharacterAccountIdByName(std::string(characterName));
    if (!accountID)
        return std::nullopt;

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED_INFO);
    stmt->setUInt32(0, accountID);

    PreparedQueryResult result = LoginDatabase.Query(stmt);
    if (!result)
        return std::nullopt;

    Field* fields = result->Fetch();

    return std::make_tuple(fields[0].GetUInt32(), fields[1].GetUInt32(), fields[2].GetString(), fields[3].GetString());
}

Optional<std::tuple<uint32, uint32, std::string, std::string>> BanManager::GetBanInfoCharacter(std::string_view characterName)
{
    if (characterName.empty())
        return std::nullopt;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_BAN_INFO_BY_NAME);
    stmt->setStringView(0, characterName);

    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
        return std::nullopt;

    Field* fields = result->Fetch();

    return std::make_tuple(fields[0].GetUInt32(), fields[1].GetUInt32(), fields[2].GetString(), fields[3].GetString());
}
