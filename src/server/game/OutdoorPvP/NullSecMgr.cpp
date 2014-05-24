/*
* Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2014 Steel Gamers Community <http://www.steelgamers.es/>
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

#include "NullSecMgr.h"
#include "ObjectMgr.h"
#include "GuildMgr.h"
#include "Player.h"
#include "Language.h"
#include "Chat.h"

NullSecMgr::NullSecMgr()
{
}

NullSecMgr::~NullSecMgr()
{
}

void NullSecMgr::InitNullSecMgr()
{
    uint32 oldMSTime = getMSTime();

    //                                                   0        1          2
    QueryResult result = CharacterDatabase.Query("SELECT zone_id, zone_name, owner FROM custom_nullsec_zones ORDER BY zone_id");

    if (!result)
    {
        TC_LOG_ERROR("server.loading", ">> Loaded 0 Null Sec zones. DB table `custom_nullsec_zones` is empty.");
        return;
    }

    uint32 zoneId;
    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        zoneId = fields[0].GetUInt32();

        if (zoneId > MAX_NULLSEC_ZONES)
        {
            TC_LOG_ERROR("sql.sql", "Invalid Zone ID value %u in custom_nullsec_zones, skipped.", zoneId);
            continue;
        }

        NullSecZoneData nullSecZoneData;
        nullSecZoneData.ZoneId = zoneId;
        nullSecZoneData.ZoneName = fields[1].GetString();
        if (!fields[2].GetUInt32())
            nullSecZoneData.Owner = NO_OWNER;
        else
            nullSecZoneData.Owner = sGuildMgr->GetGuildById(fields[2].GetUInt32());
        
        m_nullSecZones[zoneId] = nullSecZoneData;
        ++count;
    } while (result->NextRow());

    TC_LOG_INFO("server.loading", ">> Loaded %u custom Null Sec Zones in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

Guild* NullSecMgr::GetNullSecZoneOwner(uint32 zoneId)
{
    if (zoneId > MAX_NULLSEC_ZONES)
        return NO_OWNER;

    return m_nullSecZones[zoneId].Owner;
}

void NullSecMgr::SetNullSecZoneOwner(uint32 zoneId, Guild* guild)
{
    if (zoneId > MAX_NULLSEC_ZONES)
        return;

    // 1st case: The zone owner lost the territory.
    if (guild == NO_OWNER || !guild)
    {
        m_nullSecZones[zoneId].Owner = NO_OWNER;
        CharacterDatabase.DirectPExecute("UPDATE custom_nullsec_zones SET owner = NULL WHERE zone_id = %u", zoneId);
        sWorld->SendWorldText(LANG_NULLSEC_ZONE_LOST, m_nullSecZones[zoneId].Owner->GetName(), m_nullSecZones[zoneId].ZoneName);    
    }
    // 2nd case: The zone has been conquered by a new guild.
    else
    {
        m_nullSecZones[zoneId].Owner = guild;
        CharacterDatabase.DirectPExecute("UPDATE custom_nullsec_zones SET owner = %u WHERE zone_id = %u", guild->GetId(), zoneId);
        sWorld->SendWorldText(LANG_NULLSEC_ZONE_TAKEN, guild->GetName(), m_nullSecZones[zoneId].ZoneName);
    }
}

void NullSecMgr::SetNullSecZoneOwner(uint32 zoneId, uint32 guildId)
{
    if (zoneId > MAX_NULLSEC_ZONES)
        return;

    Guild* guild = sGuildMgr->GetGuildById(guildId);
    if (guild)
        SetNullSecZoneOwner(zoneId, guild);
}

void NullSecMgr::OnPlayerEnterNullSecZone(Player* player, uint32 zoneId)
{
    if (zoneId > MAX_NULLSEC_ZONES)
        return;

    // Send the neccessary messages, only if the player is changing zone, not area.
    if (player->GetGuildZoneId() != zoneId)
    {
        // Zone is controlled by the player's guild.
        if (player->GetGuild() != NULL && player->GetGuild() == m_nullSecZones[zoneId].Owner)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_FRIENDLY_ENTER, m_nullSecZones[zoneId].ZoneName.c_str(), m_nullSecZones[zoneId].Owner->GetName().c_str());
        // Zone is neutral.
        else if (m_nullSecZones[zoneId].Owner == NO_OWNER)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_NEUTRAL_ENTER, m_nullSecZones[zoneId].ZoneName.c_str());
        // Zone is controlled by other guild.
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_HOSTILE_ENTER, m_nullSecZones[zoneId].ZoneName.c_str(), m_nullSecZones[zoneId].Owner->GetName().c_str());
            // TODO: Send message to the online players that own the zone.
        }
    }
    // Update the player, he is now in a guild owned zone.
    player->InGuildZone(true);
    player->SetGuildZoneId(zoneId);
}

void NullSecMgr::OnPlayerLeaveNullSecZone(Player* player)
{
    if (!player->GetGuildZoneId() || player->GetGuildZoneId() > MAX_NULLSEC_ZONES)
        return;

    ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_LEAVE, m_nullSecZones[player->GetGuildZoneId()].ZoneName.c_str());
    player->InGuildZone(false);
    player->SetGuildZoneId(GUILD_ZONE_NONE);
}