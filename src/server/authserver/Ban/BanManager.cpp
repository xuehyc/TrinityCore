/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

/**
 *  @file
 *  @brief   Implementation of BanManager.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#include "BanManager.h"

#include "Timer.h"
#include "LogTrace.h"
#include "IPBan.h"
#include "Database/DatabaseEnv.h"

BanManager::~BanManager()
{
    for (IPBanMap_ConstItr itr = _ipBans.begin(); itr != _ipBans.end(); ++itr)
        delete itr->second;
    _ipBans.clear();
}

void BanManager::LoadBans()
{
    LOG_TRACE("Loading bans...");
    uint32 oldMSTime = getMSTime();

    LoadIPBans();

    std::ostringstream oss;
    oss << GetBansCount() << " bans loaded in " << GetMSTimeDiffToNow(oldMSTime) << " ms.";
    LOG_TRACE(oss.str());
}

void BanManager::LoadIPBans()
{
    LOG_TRACE("Loading IP bans...");
    uint32 oldMSTime = getMSTime();
    _ipBans.clear();

    PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_LOAD_IP_BANS);
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    if (!result)
    {
        LOG_TRACE("0 IP ban loaded.");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        IPBan* ipBan = new IPBan();
        ipBan->SetIP(fields[0].GetString());
        ipBan->SetBanDate(fields[1].GetUInt32());
        ipBan->SetUnbanDate(fields[2].GetUInt32());

        AddIPBan(ipBan);
    } while (result->NextRow());

    std::ostringstream oss;
    oss << GetIPBansCount() << " IP bans loaded in " << GetMSTimeDiffToNow(oldMSTime) << " ms.";
    LOG_TRACE(oss.str());
}
