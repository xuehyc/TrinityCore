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

#include "OnlineReward.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "GameConfig.h"
#include "Log.h"
#include "MailExternal.h"
#include "ModuleLocale.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "StringConvert.h"
#include "Util.h"
#include "World.h"
#include "WorldSession.h"

enum StringLocales : uint8
{
    OR_LOCALE_SUBJECT = 1,
    OR_LOCALE_TEXT,
    OR_LOCALE_MESSAGE,

    OR_LOCALE_MAX
};

#define MODULE_NAME "mod-online-reward"

OnlineReward* OnlineReward::instance()
{
    static OnlineReward instance;
    return &instance;
}

void OnlineReward::InitSystem()
{
    if (CONF_GET_BOOL("OnlineReward.Enable") && !CONF_GET_BOOL("OnlineReward.PerOnline.Enable") && !CONF_GET_BOOL("OnlineReward.PerTime.Enable"))
        sGameConfig->SetOption<bool>("OnlineReward.Enable", false);

    sModuleLocale->CheckStrings(MODULE_NAME, OR_LOCALE_MAX);

    LoadRewards();
}

void OnlineReward::LoadRewards()
{
    LOG_INFO("scripts.warhead", "Loading online rewards...");

    _rewards.clear();
    uint32 msTime = getMSTime();

    QueryResult result = CharacterDatabase.Query("SELECT RewardPlayedTime, ItemID, Count FROM online_reward");
    if (!result)
    {
        LOG_WARN("scripts.warhead", "> DB table `online_reward` is empty!");
        LOG_WARN("scripts.warhead", "");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 seconds = fields[0].GetUInt32();

        RewardPlayedTime RPT;
        RPT.ItemID = fields[1].GetUInt32();
        RPT.ItemCount = fields[2].GetUInt32();

        // Проверка
        if (!seconds)
        {
            LOG_ERROR("scripts.warhead", "-> Time = 0? Really? Skip...");
            continue;
        }

        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(RPT.ItemID);
        if (!itemTemplate)
        {
            LOG_ERROR("scripts.warhead", "-> Item with number %u not found. Skip", RPT.ItemID);
            continue;
        }

        if (!RPT.ItemCount)
        {
            LOG_ERROR("scripts.warhead", "-> Item count for number %u - 0. Set to 1", RPT.ItemID);
            RPT.ItemCount = 1;
        }

        _rewards.emplace(seconds, RPT);

    } while (result->NextRow());

    LOG_INFO("scripts.warhead", ">> Loaded %u reward in %u ms", static_cast<uint32>(_rewards.size()), GetMSTimeDiffToNow(msTime));
    LOG_INFO("scripts.warhead", "");
}

void OnlineReward::AddRewardHistory(ObjectGuid::LowType guid)
{
    if (IsExistHistory(guid))
        return;

    QueryResult result = CharacterDatabase.PQuery("SELECT `RewardedPerOnline`, `RewardedPerHour` FROM `online_reward_history` WHERE `PlayerGuid` = %u", guid);
    if (!result)
        return;

    auto fields = result->Fetch();

    RewardTimeHistory _data;

    for (auto const& itr : Warhead::Tokenize(fields[0].GetStringView(), ',', true))
        _data.PerOnline.emplace(Warhead::StringTo<uint32>(itr).value_or(0));

    _data.PerTime = fields[1].GetUInt32();

    _rewardHistoryDB.emplace(guid, _data);
}

void OnlineReward::DeleteRewardHistory(ObjectGuid::LowType guid)
{
    if (!IsExistHistory(guid))
        return;

    _rewardHistoryDB.erase(guid);
}

void OnlineReward::RewardPlayers()
{
    if (!CONF_GET_BOOL("OnlineReward.Enable"))
        return;

    auto sessions = sWorld->GetAllSessions();
    if (sessions.empty())
        return;

    // Send reward
    for (auto const& itr : sessions)
    {
        auto player = itr.second->GetPlayer();
        if (!player || !player->IsInWorld())
            continue;

        if (CONF_GET_BOOL("OnlineReward.PerOnline.Enable"))
            RewardPerOnline(player);

        if (CONF_GET_BOOL("OnlineReward.PerTime.Enable"))
            RewardPerTime(player);
    }

    // Save data to DB
    SaveRewardDB();
}

void OnlineReward::RewardPerOnline(Player* player)
{
    ChatHandler handler(player->GetSession());
    uint32 playedTimeSec = player->GetTotalPlayedTime();
    ObjectGuid::LowType lowGuid = player->GetGUID().GetCounter();

    auto IsRewarded = [&](uint32 rewardSeconds)
    {
        if (!IsExistHistory(lowGuid))
            return false;

        auto const& history = GetHistoryPerOnline(lowGuid);
        if (!history)
            return false;

        auto const& secondsFind = history->find(rewardSeconds);
        if (secondsFind != history->end())
            return true;

        return false;
    };

    for (auto const& [seconds, data] : _rewards)
    {
        // Go next is rewarded
        if (IsRewarded(seconds))
            continue;

        // End reward :/
        if (seconds > playedTimeSec)
            continue;

        SendRewardForPlayer(player, data.ItemID, data.ItemCount, seconds);
    }
}

void OnlineReward::RewardPerTime(Player* player)
{
    ObjectGuid::LowType lowGuid = player->GetGUID().GetCounter();
    uint32 LastRewarded = GetHistoryPerTime(lowGuid);
    uint32 playedTimeSec = player->GetTotalPlayedTime();
    uint32 diffTime = 0;

    while (diffTime < playedTimeSec)
    {
        if (LastRewarded < diffTime)
            SendRewardForPlayer(player, CONF_GET_INT("OnlineReward.PerTime.ItemID"), CONF_GET_INT("OnlineReward.PerTime.ItemCount"), diffTime, false);

        diffTime += CONF_GET_INT("OnlineReward.PerTime.Time");
    }
}

void OnlineReward::SaveRewardDB()
{
    auto trans = CharacterDatabase.BeginTransaction();

    // Save data for exist history
    for (auto const& itr : _rewardHistoryDB)
    {
        auto lowGuid = itr.first;

        auto GetRewardedData = [&]() -> RewardTimeHistory *
        {
            auto const& _historyData = _rewardHistoryDB.find(lowGuid);
            if (_historyData != _rewardHistoryDB.end())
                return &_historyData->second;

            return nullptr;
        };

        auto _saveData = GetRewardedData();

        // Check data
        if (!_saveData)
            return;

        uint32 dataPerTime = _saveData->PerTime;
        std::string dataPerOnline;

        if (!_saveData->PerOnline.empty())
        {
            // Add rewarded seconds
            for (auto const& itr : _saveData->PerOnline)
                dataPerOnline += std::to_string(itr) + ',';

            // Delete last (,)
            if (!dataPerOnline.empty())
                dataPerOnline.erase(dataPerOnline.end() - 1, dataPerOnline.end());
        }

        // Delele old data
        trans->PAppend("DELETE FROM `online_reward_history` WHERE `PlayerGuid` = %u", lowGuid);

        // Insert new data
        trans->PAppend("INSERT INTO `online_reward_history`(`PlayerGuid`, `RewardedPerOnline`, `RewardedPerHour`) VALUES (%u, '%s', %u)", lowGuid, dataPerOnline.c_str(), dataPerTime);
    }

    CharacterDatabase.CommitTransaction(trans);
}

std::unordered_set<uint32>* OnlineReward::GetHistoryPerOnline(ObjectGuid::LowType guid)
{
    if (_rewardHistoryDB.empty())
        return nullptr;

    auto const& itr = _rewardHistoryDB.find(guid);
    if (itr != _rewardHistoryDB.end())
        return &itr->second.PerOnline;

    return nullptr;
}

uint32 OnlineReward::GetHistoryPerTime(ObjectGuid::LowType guid)
{
    if (_rewardHistoryDB.empty())
        return 0;

    auto const& itr = _rewardHistoryDB.find(guid);
    if (itr != _rewardHistoryDB.end())
        return itr->second.PerTime;

    return 0;
}

void OnlineReward::SendRewardForPlayer(Player* player, uint32 itemID, uint32 itemCount, uint32 secondsOnine, bool isPerOnline /*= true*/)
{
    ChatHandler handler(player->GetSession());
    std::string playedTimeSecStr = Warhead::Time::ToTimeString<Seconds>(secondsOnine, TimeOutput::Seconds, TimeFormat::FullText);
    uint8 localeIndex = static_cast<uint8>(player->GetSession()->GetSessionDbLocaleIndex());

    std::string subject = Warhead::StringFormat(*sModuleLocale->GetModuleString(MODULE_NAME, StringLocales::OR_LOCALE_SUBJECT, localeIndex), playedTimeSecStr.c_str());
    std::string text = Warhead::StringFormat(*sModuleLocale->GetModuleString(MODULE_NAME, StringLocales::OR_LOCALE_TEXT, localeIndex), player->GetName().c_str(), playedTimeSecStr.c_str());

    // Send External mail
    sMailExternal->AddMail(player->GetName(), subject, text, 0, itemID, itemCount, 37688);

    // Save data to DB
    SaveDataForDB(player->GetGUID().GetCounter(), secondsOnine, isPerOnline);

    // Send chat text
    sModuleLocale->SendPlayerMessage(player, MODULE_NAME, StringLocales::OR_LOCALE_MESSAGE, playedTimeSecStr.c_str());
}

void OnlineReward::SaveDataForDB(ObjectGuid::LowType guid, uint32 seconds, bool isPerOnline /*= true*/)
{
    auto const& _historyData = _rewardHistoryDB.find(guid);
    if (_historyData == _rewardHistoryDB.end())
    {
        RewardTimeHistory _data;

        if (isPerOnline)
        {
            _data.PerOnline.emplace(seconds);
            _data.PerTime = 0;
        }
        else
            _data.PerTime = seconds;

        _rewardHistoryDB.emplace(guid, _data);
    }
    else
    {
        auto& __data = _historyData->second;

        if (isPerOnline)
            __data.PerOnline.emplace(seconds);
        else
            __data.PerTime = seconds;
    }
}

bool OnlineReward::IsExistHistory(ObjectGuid::LowType guid)
{
    return _rewardHistoryDB.find(guid) != _rewardHistoryDB.end();
}
