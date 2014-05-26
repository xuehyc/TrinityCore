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

    //                                                   0                1                  2        3          4
    QueryResult result = CharacterDatabase.Query("SELECT a.guild_zone_id, a.guild_zone_name, a.owner, b.zone_id, b.area_id FROM custom_nullsec_guild_zones AS a, custom_nullsec_guild_areas AS b WHERE a.guild_zone_id = b.guild_zone_id ORDER BY a.guild_zone_id");

    if (!result)
    {
        TC_LOG_ERROR("server.loading", ">> Loaded 0 Null Sec Guild Zones. DB table `custom_nullsec_guild_zones` or `cutom_nullsec_guild_areas` is empty.");
        return;
    }

    uint32 guildZoneId = MAX_NULLSEC_ZONES + 1;
    uint32 countZones = 0;
    uint32 countAreas = 0;

    do
    {
        Field* fields = result->Fetch();

        // Load only an area...
        if (fields[0].GetUInt32() == guildZoneId)
        {
            m_guildZones[guildZoneId].Areas.push_back(fields[4].GetUInt16());
            ++countAreas;
        }
        // ... or zone and area
        else
        {
            guildZoneId = fields[0].GetUInt32();

            if (guildZoneId > MAX_NULLSEC_ZONES)
            {
                TC_LOG_ERROR("sql.sql", "Invalid Guild Zone ID value %u in custom_nullsec_zones, skipped.", guildZoneId);
                continue;
            }

            NullSecGuildZoneData nullSecGuildZoneData;
            nullSecGuildZoneData.GuildZoneId = guildZoneId;
            nullSecGuildZoneData.GuildZoneName = fields[1].GetString();
            nullSecGuildZoneData.ZoneId = fields[3].GetUInt16();
            if (!fields[2].GetUInt32())
                nullSecGuildZoneData.Owner = NO_OWNER;
            else
                nullSecGuildZoneData.Owner = sGuildMgr->GetGuildById(fields[2].GetUInt32());

            m_guildZones[guildZoneId] = nullSecGuildZoneData;
            ++countZones;
            ++countAreas;
        }
    } while (result->NextRow());

    TC_LOG_INFO("server.loading", ">> Loaded %u custom Null Sec Guild Zones with %u Null Sec Guild Areas in %u ms.", countZones, countAreas, GetMSTimeDiffToNow(oldMSTime));

    oldMSTime = getMSTime();

    //                                                0
    result = CharacterDatabase.Query("SELECT DISTINCT zone_id FROM custom_nullsec_guild_areas");

    if (!result)
    {
        TC_LOG_ERROR("server.loading", ">> Loaded 0 Null Sec Zones. DB table `cutom_nullsec_guild_areas` is empty.");
        return;
    }

    countZones = 0;

    do
    {
        Field* fields = result->Fetch();
        // Add new zone to the null sec list.
        m_nullSecZones.push_back(fields[0].GetUInt16());
        ++countZones;
    } while (result->NextRow());

    TC_LOG_INFO("server.loading", ">> Loaded %u custom Null Sec Zones in %u ms.", countZones, GetMSTimeDiffToNow(oldMSTime));
}

Guild* NullSecMgr::GetNullSecZoneOwner(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES)
        return NO_OWNER;

    return m_guildZones[guildZoneId].Owner;
}

void NullSecMgr::SetNullSecZoneOwner(uint32 guildZoneId, Guild* guild)
{
    if (guildZoneId > MAX_NULLSEC_ZONES)
        return;

    // 1st case: The zone owner lost the territory.
    if (guild == NO_OWNER || !guild)
    {
        m_guildZones[guildZoneId].Owner = NO_OWNER;
        CharacterDatabase.DirectPExecute("UPDATE custom_nullsec_zones SET owner = NULL WHERE zone_id = %u", guildZoneId);
        sWorld->SendWorldText(LANG_NULLSEC_ZONE_LOST, m_guildZones[guildZoneId].Owner->GetName(), m_guildZones[guildZoneId].GuildZoneName.c_str());
    }
    // 2nd case: The zone has been conquered by a new guild.
    else
    {
        m_guildZones[guildZoneId].Owner = guild;
        CharacterDatabase.DirectPExecute("UPDATE custom_nullsec_zones SET owner = %u WHERE zone_id = %u", guild->GetId(), guildZoneId);
        sWorld->SendWorldText(LANG_NULLSEC_ZONE_TAKEN, guild->GetName(), m_guildZones[guildZoneId].GuildZoneName.c_str());
    }
}

void NullSecMgr::SetNullSecZoneOwner(uint32 guildZoneId, uint32 guildId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES)
        return;

    Guild* guild = sGuildMgr->GetGuildById(guildId);
    if (guild)
        SetNullSecZoneOwner(guildZoneId, guild);
}

void NullSecMgr::OnPlayerEnterNullSecGuildZone(Player* player)
{
    uint32 guildZoneId, zoneId, areaId;

    player->GetZoneAndAreaId(zoneId, areaId);
    guildZoneId = GetNullSecGuildZone(zoneId, areaId);

    // This should never happen anyway...
    if (guildZoneId > MAX_NULLSEC_ZONES)
        return;

    // OnPlayerEnterNullSecGuildZone() will be called only when entering an area 
    // inside null sec, but there are areas like seas that can't have owner, so 
    // update the player as if he has left the guild zone.
    if (guildZoneId == GUILD_ZONE_NONE)
    {
        OnPlayerLeaveNullSecGuildZone(player);
        return;
    }

    // Send the neccessary messages, only if the player is changing zone, not area.
    if (player->GetGuildZoneId() != guildZoneId)
    {
        // Zone is controlled by the player's guild.
        if (player->GetGuild() != NULL && player->GetGuild() == m_guildZones[guildZoneId].Owner)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_FRIENDLY_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str(), m_guildZones[guildZoneId].Owner->GetName().c_str());
        // Zone is neutral.
        else if (m_guildZones[guildZoneId].Owner == NO_OWNER)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_NEUTRAL_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str());
        // Zone is controlled by other guild.
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_HOSTILE_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str(), m_guildZones[guildZoneId].Owner->GetName().c_str());
            // TODO: Send message to the online players that own the zone.
        }
    }
    // Update the player, he is now in a guild owned zone.
    player->InGuildZone(true);
    player->SetGuildZoneId(guildZoneId);
}

void NullSecMgr::OnPlayerLeaveNullSecGuildZone(Player* player)
{
    if (!player->GetGuildZoneId() || player->GetGuildZoneId() > MAX_NULLSEC_ZONES)
        return;

    ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_LEAVE, m_guildZones[player->GetGuildZoneId()].GuildZoneName.c_str());
    player->InGuildZone(false);
    player->SetGuildZoneId(GUILD_ZONE_NONE);
}

bool NullSecMgr::IsNullSecZone(uint32 zoneId)
{
    for (std::vector<uint32>::iterator itr = m_nullSecZones.begin(); itr != m_nullSecZones.end(); ++itr)
    {
        if (*itr == zoneId)
            return true;
    }
    return false;
}

uint32 NullSecMgr::GetNullSecGuildZone(uint32 zoneId, uint32 areaId)
{
    if (!IsNullSecZone(zoneId))
        return GUILD_ZONE_NONE;

    for (std::map<uint32, NullSecGuildZoneData>::iterator itr = m_guildZones.begin(); itr != m_guildZones.end(); ++itr)
    {
        if (itr->second.ZoneId == zoneId)
        {
            for (std::vector<uint32>::iterator itr2 = itr->second.Areas.begin(); itr2 != itr->second.Areas.end(); ++itr2)
            {
                if (*itr2 == areaId)
                    return itr->second.GuildZoneId;
            }
        }
    }

    return GUILD_ZONE_NONE;
}