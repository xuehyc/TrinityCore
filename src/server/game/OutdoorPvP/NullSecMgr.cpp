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

    //                                                   0              1                2        3                4                5                6                    7                    8
    QueryResult result = CharacterDatabase.Query("SELECT guild_zone_id, guild_zone_name, zone_id, vital_area_id_1, vital_area_id_2, vital_area_id_3, vital_area_1_status, vital_area_2_status, vital_area_3_status, "
	//                                                   9             10            11           12           13           14           15           16           17           18           19      20            21
												        "standard_x_1, standard_x_2, standard_x_3, standard_y_1, standard_y_2, standard_y_3, standard_z_1, standard_z_2, standard_z_3, standard_o_1, standard_o_2, standard_o_3, "
	//                                                   22     23                24                25                26              27              28              29       
														"owner, lowsec_respawn_x, lowsec_respawn_y, lowsec_respawn_z, taxi_node_id_1, taxi_node_id_2, taxi_node_id_3, taxi_node_id_4 FROM custom_nullsec_guild_zones ORDER BY guild_zone_id");

    if (!result)
    {
        TC_LOG_ERROR("server.loading", ">> Loaded 0 Null Sec Guild Zones. DB table `custom_nullsec_guild_zones` is empty.");
        return;
    }

    uint32 guildZoneId = MAX_NULLSEC_ZONES + 1;
    uint32 countZones = 0;
    uint32 countAreas = 0;

    do
    {
        Field* fields = result->Fetch();

        guildZoneId = fields[0].GetUInt32();

        if (guildZoneId > MAX_NULLSEC_ZONES)
        {
            TC_LOG_ERROR("sql.sql", "Invalid Guild Zone ID value %u in custom_nullsec_zones, skipped.", guildZoneId);
            continue;
        }
        
        NullSecGuildZoneData nullSecGuildZoneData;
        nullSecGuildZoneData.GuildZoneId = guildZoneId;
        nullSecGuildZoneData.GuildZoneName = fields[1].GetString();
        nullSecGuildZoneData.ZoneId = fields[8].GetUInt32();

		for (uint8 i = 0; i < 3; ++i)
		{
			nullSecGuildZoneData.VitalAreas[i] = fields[i + 3].GetUInt32();
			nullSecGuildZoneData.VitalAreasStatus[i] = fields[i + 6].GetUInt8();
            nullSecGuildZoneData.StandardPositions[0] = Position{ fields[i + 9].GetFloat(), fields[i + 12].GetFloat(), fields[i + 15].GetFloat(), fields[i + 18].GetFloat() };
		}

        nullSecGuildZoneData.LowSecRespawnPosition = Position { fields[23].GetFloat(), fields[24].GetFloat(), fields[25].GetFloat() };
        if (!fields[22].GetUInt32())
            nullSecGuildZoneData.Owner = NULL;
        else
            nullSecGuildZoneData.Owner = sGuildMgr->GetGuildById(fields[22].GetUInt32());
        nullSecGuildZoneData.Attacker = NULL;
        nullSecGuildZoneData.IsUnderAttack = false;
        nullSecGuildZoneData.IntrudersCount = 0;

        for (uint8 i = 26; i < 30; ++i)
            nullSecGuildZoneData.TaxiNodes.push_back(fields[i].GetUInt32());

        m_guildZones[guildZoneId] = nullSecGuildZoneData;
        m_nullSecZones.push_back(fields[2].GetUInt32());
        ++countZones;

    } while (result->NextRow());
}

Guild* NullSecMgr::GetNullSecZoneOwner(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].Owner;
}

void NullSecMgr::SetNullSecZoneOwner(uint32 guildZoneId, Guild* guild)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guild)
        return;

    m_guildZones[guildZoneId].Owner = guild;
    CharacterDatabase.DirectPExecute("UPDATE custom_nullsec_guild_zones SET owner = %u WHERE guild_zone_id = %u", guild->GetId(), guildZoneId);
    
    // Inform all players that the zone has been conquered
    sWorld->SendWorldText(LANG_NULLSEC_ZONE_TAKEN, guild->GetName().c_str(), m_guildZones[guildZoneId].GuildZoneName.c_str());
}

void NullSecMgr::SetNullSecZoneOwner(uint32 guildZoneId, uint32 guildId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES)
        return;

    Guild* guild = sGuildMgr->GetGuildById(guildId);
    if (guild)
        SetNullSecZoneOwner(guildZoneId, guild);
}

void NullSecMgr::RemoveGuildZoneOwner(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES)
        return;

    // Inform all players that a new territory is available
    sWorld->SendWorldText(LANG_NULLSEC_ZONE_LOST, m_guildZones[guildZoneId].Owner->GetName().c_str(), m_guildZones[guildZoneId].GuildZoneName.c_str());
    // Remove ownership
    m_guildZones[guildZoneId].Owner = NULL;
    CharacterDatabase.DirectPExecute("UPDATE custom_nullsec_guild_zones SET owner = NULL WHERE guild_zone_id = %u", guildZoneId);

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
    if (!guildZoneId)
    {
        OnPlayerLeaveNullSecGuildZone(player);
        return;
    }

    // Send the neccessary messages, only if the player is changing zone, not area.
    if (player->GetGuildZoneId() != guildZoneId)
    {
        // Zone is controlled by the player's guild.
        if (player->GetGuild() && player->GetGuild() == m_guildZones[guildZoneId].Owner)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_FRIENDLY_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str(), m_guildZones[guildZoneId].Owner->GetName().c_str());
        // Zone is neutral.
        else if (m_guildZones[guildZoneId].Owner == NULL)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_NEUTRAL_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str());
        // Zone is controlled by other guild.
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_HOSTILE_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str(), m_guildZones[guildZoneId].Owner->GetName().c_str());
            m_guildZones[guildZoneId].IntrudersCount += 1;
            // Inform all online players of the guild that owns the territory that an intruder has just entered
            // only if there were no more intruders previously so we can prevent chat spam.
            // TODO: Inform that there's intruders in his guild's territory to a player that has just logged in.
            if (m_guildZones[guildZoneId].IntrudersCount == 1)
            {
                const SessionMap worldSessions = sWorld->GetAllSessions();
                for (SessionMap::const_iterator itr = worldSessions.begin(); itr != worldSessions.end(); ++itr)
                {
                    if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld() || !itr->second->GetPlayer()->GetGuild())
                        continue;

                    if (itr->second->GetPlayer()->GetGuild() == m_guildZones[guildZoneId].Owner)
                        ChatHandler(itr->second).PSendSysMessage(LANG_NULLSEC_INTRUDER, m_guildZones[guildZoneId].GuildZoneName.c_str());
                }
            }
        }
    }
    // Update the player, he is now in a guild owned zone.
    player->InGuildZone(true);
    player->SetGuildZoneId(guildZoneId);
}

void NullSecMgr::OnPlayerLeaveNullSecGuildZone(Player* player)
{
    uint32 guildZoneId = player->GetGuildZoneId();

    if (!guildZoneId || guildZoneId > MAX_NULLSEC_ZONES)
        return;

    ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_LEAVE, m_guildZones[guildZoneId].GuildZoneName.c_str());
    if (m_guildZones[guildZoneId].Owner != player->GetGuild())
        m_guildZones[guildZoneId].IntrudersCount -= 1;
    // TODO: May be inform the members of the guild that owns the zone that it's clear (intruders == 0)?
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

uint32 NullSecMgr::GetNullSecGuildZoneId(uint32 zoneId)
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

uint32* NullSecMgr::GetVitalAreasByGuildZoneId(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].VitalAreas;
}

Position NullSecMgr::GetStandardPositionByVitalArea(uint32 guildZoneId, uint32 vitalArea)
{
    if (!vitalArea || !guildZoneId || guildZoneId > MAX_NULLSEC_ZONES)
        return NULL;

    for (uint8 i = 0; i < MAX_VITAL_AREAS; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == vitalArea)
            return m_guildZones[guildZoneId].StandardPositions[i];
    }

    return NULL;
}

Position NullSecMgr::GetLowSecRespawnPositionByGuildZoneId(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].LowSecRespawnPosition;
}

bool NullSecMgr::IsGuildZoneUnderAttack(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guildZoneId)
        return false;

    return m_guildZones[guildZoneId].IsUnderAttack;
}

void NullSecMgr::SetGuildZoneUnderAttack(uint32 guildZoneId, bool underAttack, Guild* attacker)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guildZoneId)
        return;

    if (underAttack && !attacker)
        return;

    m_guildZones[guildZoneId].IsUnderAttack = underAttack;

    if (underAttack)
    {
        m_guildZones[guildZoneId].Attacker = attacker;
        if (!m_guildZones[guildZoneId].Owner)
            sWorld->SendWorldText(LANG_NULLSEC_UNDER_ATTACK, m_guildZones[guildZoneId].GuildZoneName.c_str());
        else
        {
            // Inform only the owners of the zone
            const SessionMap worldSessions = sWorld->GetAllSessions();
            for (SessionMap::const_iterator itr = worldSessions.begin(); itr != worldSessions.end(); ++itr)
            {
                if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld() || !itr->second->GetPlayer()->GetGuild())
                    continue;

                if (itr->second->GetPlayer()->GetGuild() == m_guildZones[guildZoneId].Owner)
                    ChatHandler(itr->second).PSendSysMessage(LANG_NULLSEC_UNDER_ATTACK, m_guildZones[guildZoneId].GuildZoneName.c_str());
            }
        }
    }
    else
        m_guildZones[guildZoneId].Attacker = NULL;
}

Guild* NullSecMgr::GetGuildZoneAttacker(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].Attacker;
}

std::string NullSecMgr::GetGuildZoneName(uint32 guildZoneId)
{
    if (guildZoneId > MAX_NULLSEC_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].GuildZoneName;
}

Position NullSecMgr::GetNearestRespawnPointForPlayer(Player* player)
{
    if (!player->IsInGuildZone())
        return player->GetPosition();

    // Check first distance to all posible null sec respawn points, if the
    // player's guild has conquered them, and select the nearest possible.
    uint32 guildZoneId = player->GetGuildZoneId();
    float nearestNullSecDistance = 0.0f;
    uint32 nearestNullSecLocation = GUILD_ZONE_NONE;
    if (player->GetGuild())
    {
        for (uint8 i = GUILD_ZONE_NONE + 1; i < TOTAL_GUILD_ZONES; ++i)
        {
            if (GetNullSecZoneOwner(i) == player->GetGuild())
            {
                Position nullSecPos = GetStandardPositionByGuildZoneId(i);
                float distance = player->GetDistance2d(nullSecPos.GetPositionX(), nullSecPos.GetPositionY());
                if (distance < nearestNullSecDistance || nearestNullSecDistance == 0.0f)
                {
                    nearestNullSecDistance = distance;
                    nearestNullSecLocation = i;
                }
            }
        }
    }
    // Now check what's nearer, the low sec respawn point or the null sec respawn point (if any)
    Position lowSecPos = GetLowSecRespawnPositionByGuildZoneId(guildZoneId);
    if (nearestNullSecLocation != GUILD_ZONE_NONE && player->GetDistance2d(lowSecPos.GetPositionX(), lowSecPos.GetPositionY()) > nearestNullSecDistance)
        return GetStandardPositionByGuildZoneId(nearestNullSecLocation);
    
    return GetLowSecRespawnPositionByGuildZoneId(guildZoneId);
}

bool NullSecMgr::IsAllowedTaxiNode(Player* player, uint32 taxiNodeId)
{
    // Check if this player is allowed to fly to this node (ergo his guild has the zone conquered)
    // If player is in null sec, he can't fly nowhere
    if (player->IsInGuildZone())
        return false;

    // Get zone by the taxi node ID
    for (uint8 i = GUILD_ZONE_NONE; i < TOTAL_GUILD_ZONES; ++i)
    {
        if (m_guildZones[i].TaxiNode == taxiNodeId || m_guildZones[i].TaxiNode2 == taxiNodeId)
        {
            if (player->GetGuild() == m_guildZones[i].Owner)
                return true;
            
            return false;
        }
    }
    // The destination is not in null sec
    return true;
}

void NullSecMgr::OnGuildDisband(Guild* guild)
{
    if (!guild)
        return;

    // Remove the guild's conquested territories if any.
    for (std::map<uint32, NullSecGuildZoneData>::iterator itr = m_guildZones.begin(); itr != m_guildZones.end(); ++itr)
    {
        if (itr->second.Owner == guild)
            RemoveGuildZoneOwner(itr->second.GuildZoneId);
    }
}