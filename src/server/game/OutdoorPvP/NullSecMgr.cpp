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
	//                                                   9             10            11            12            13            14            15            16            17            18            19            20
												        "standard_x_1, standard_x_2, standard_x_3, standard_y_1, standard_y_2, standard_y_3, standard_z_1, standard_z_2, standard_z_3, standard_o_1, standard_o_2, standard_o_3, "
	//                                                   21                  22                  23                  24                25                26                 27             28              29              30
														"vital_area_owner_1, vital_area_owner_2, vital_area_owner_3, lowsec_respawn_x, lowsec_respawn_y, lowsec_respawn_z, taxi_node_id_1, taxi_node_id_2, taxi_node_id_3, taxi_node_id_4 FROM custom_nullsec_guild_zones ORDER BY guild_zone_id");

    if (!result)
    {
        TC_LOG_ERROR("server.loading", ">> Loaded 0 Null Sec Guild Zones. DB table `custom_nullsec_guild_zones` is empty.");
        return;
    }

    uint32 guildZoneId = TOTAL_GUILD_ZONES + 1;
    uint32 countZones = 0;
    uint32 countAreas = 0;

    do
    {
        Field* fields = result->Fetch();
        guildZoneId = fields[0].GetUInt32();

        if (guildZoneId > TOTAL_GUILD_ZONES)
        {
            TC_LOG_ERROR("sql.sql", "Invalid Guild Zone ID value %u in custom_nullsec_zones, skipped.", guildZoneId);
            continue;
        }
        
        NullSecGuildZoneData nullSecGuildZoneData;
        nullSecGuildZoneData.GuildZoneId = guildZoneId;
        nullSecGuildZoneData.GuildZoneName = fields[1].GetString();
        nullSecGuildZoneData.ZoneId = fields[2].GetUInt32();

		for (uint8 i = 0; i < 3; ++i)
		{
			nullSecGuildZoneData.VitalAreas[i] = fields[i + 3].GetUInt32();
			nullSecGuildZoneData.VitalAreasStatus[i] = fields[i + 6].GetUInt8();
            nullSecGuildZoneData.StandardPositions[i] = Position{ fields[i + 9].GetFloat(), fields[i + 12].GetFloat(), fields[i + 15].GetFloat(), fields[i + 18].GetFloat() };
            if (fields[i + 21].GetUInt32())
            {
                nullSecGuildZoneData.Owners[i] = sGuildMgr->GetGuildById(fields[i + 21].GetUInt32());
                nullSecGuildZoneData.VitalAreasStatus[i] = VITAL_AREA_STATUS_CONQUERED;
            }
            else
            {
                nullSecGuildZoneData.Owners[i] = NULL;
                nullSecGuildZoneData.VitalAreasStatus[i] = VITAL_AREA_STATUS_UNCONQUERED;
            }
            nullSecGuildZoneData.VitalAreasAttackers[i] = NULL;
		}

        nullSecGuildZoneData.LowSecRespawnPosition = Position { fields[25].GetFloat(), fields[26].GetFloat(), fields[27].GetFloat() };
        nullSecGuildZoneData.Attacker = NULL;
        nullSecGuildZoneData.IsUnderAttack = false;
        nullSecGuildZoneData.IntrudersCount = 0;

        for (uint8 i = 27; i < 31; ++i)
            nullSecGuildZoneData.TaxiNodes.push_back(fields[i].GetUInt32());

        m_guildZones[guildZoneId] = nullSecGuildZoneData;
        m_nullSecZones.push_back(fields[2].GetUInt32());
        ++countZones;

    } while (result->NextRow());
}

Guild* NullSecMgr::GetNullSecVitalAreaOwner(uint32 guildZoneId, uint32 vitalAreaId)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId || !vitalAreaId)
        return NULL;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == vitalAreaId)
            return m_guildZones[guildZoneId].Owners[i];
    }

    return NULL;
}

Guild* NullSecMgr::GetNullSecOwner(uint32 guildZoneId)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId)
        return NULL;

    if (m_guildZones[guildZoneId].Owners[0] == m_guildZones[guildZoneId].Owners[1] ||
        m_guildZones[guildZoneId].Owners[0] == m_guildZones[guildZoneId].Owners[2])
        return m_guildZones[guildZoneId].Owners[0];

    if (m_guildZones[guildZoneId].Owners[1] == m_guildZones[guildZoneId].Owners[2])
        return m_guildZones[guildZoneId].Owners[1];

    return NULL;
}

void NullSecMgr::SetNullSecVitalAreaOwner(uint32 guildZoneId, Guild* guild, uint32 vitalAreaId)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guild || !vitalAreaId)
        return;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == vitalAreaId)
        {
            m_guildZones[guildZoneId].Owners[i] = guild;
            uint32 owner1 = (m_guildZones[guildZoneId].Owners[0] ? m_guildZones[guildZoneId].Owners[0]->GetId() : NULL);
            uint32 owner2 = (m_guildZones[guildZoneId].Owners[1] ? m_guildZones[guildZoneId].Owners[1]->GetId() : NULL);
            uint32 owner3 = (m_guildZones[guildZoneId].Owners[2] ? m_guildZones[guildZoneId].Owners[2]->GetId() : NULL);

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NULLSEC_VITAL_AREA_OWNER);
            stmt->setUInt32(0, owner1);
            stmt->setUInt32(1, owner2);
            stmt->setUInt32(2, owner3);
            stmt->setUInt32(3, guildZoneId);
            CharacterDatabase.Execute(stmt);

            break;
        }
    }
    
    // Inform all players that a strategic point has been taken and the new owner of the zone if necessary
    if (GetNullSecOwner(guildZoneId) == guild)
        sWorld->SendWorldText(LANG_NULLSEC_ZONE_TAKEN, guild->GetName().c_str(), m_guildZones[guildZoneId].GuildZoneName.c_str());
    else
        sWorld->SendWorldText(LANG_NULLSEC_VITAL_AREA_TAKEN, guild->GetName().c_str(), m_guildZones[guildZoneId].GuildZoneName.c_str());
}

void NullSecMgr::RemoveNullSecVitalAreaOwner(uint32 guildZoneId, uint32 vitalAreaId)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !vitalAreaId)
        return;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == vitalAreaId)
        {
            // Remove ownership
            Guild* oldOwner = m_guildZones[guildZoneId].Owners[i]; // To broadcast later the name of the defeated guild.
            m_guildZones[guildZoneId].Owners[i] = NULL;
            uint32 owner1 = (m_guildZones[guildZoneId].Owners[0] ? m_guildZones[guildZoneId].Owners[0]->GetId() : NULL);
            uint32 owner2 = (m_guildZones[guildZoneId].Owners[1] ? m_guildZones[guildZoneId].Owners[1]->GetId() : NULL);
            uint32 owner3 = (m_guildZones[guildZoneId].Owners[2] ? m_guildZones[guildZoneId].Owners[2]->GetId() : NULL);

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NULLSEC_VITAL_AREA_OWNER);
            stmt->setUInt32(0, owner1);
            stmt->setUInt32(1, owner2);
            stmt->setUInt32(2, owner3);
            stmt->setUInt32(3, guildZoneId);
            CharacterDatabase.Execute(stmt);

            // Inform all players that a vital area has been lost, and that the owner has lost control if that's the case.
            if (!GetNullSecOwner(guildZoneId))
                sWorld->SendWorldText(LANG_NULLSEC_ZONE_LOST, oldOwner->GetName().c_str(), m_guildZones[guildZoneId].GuildZoneName.c_str());
            else
                sWorld->SendWorldText(LANG_NULLSEC_VITAL_AREA_LOST, oldOwner->GetName().c_str(), m_guildZones[guildZoneId].GuildZoneName.c_str());

            break;
        }
    }
}

void NullSecMgr::OnPlayerEnterNullSec(Player* player)
{
    uint32 guildZoneId;

    guildZoneId = GetNullSecGuildZoneId(player->GetZoneId());
    // This should never happen anyway...
    if (guildZoneId > TOTAL_GUILD_ZONES)
        return;

    // OnPlayerEnterNullSecGuildZone() will be called only when entering an area 
    // inside null sec, but there are areas like seas that can't have owner, so 
    // update the player as if he has left the guild zone.
    if (!guildZoneId)
    {
        OnPlayerLeaveNullSec(player);
        return;
    }

    // Send the neccessary messages, only if the player is changing zone, not area.
    if (player->GetGuildZoneId() != guildZoneId)
    {
        Guild* zoneOwner = GetNullSecOwner(guildZoneId);
        // Zone is neutral.
        if (!zoneOwner)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_NEUTRAL_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str());
        // Zone is controlled by the player's guild.
        else if (player->GetGuild() && player->GetGuild() == zoneOwner)
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_FRIENDLY_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str(), zoneOwner->GetName().c_str());
        // Zone is controlled by other guild.
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_HOSTILE_ENTER, m_guildZones[guildZoneId].GuildZoneName.c_str(), zoneOwner->GetName().c_str());
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

                    if (itr->second->GetPlayer()->GetGuild() == zoneOwner)
                        ChatHandler(itr->second).PSendSysMessage(LANG_NULLSEC_INTRUDER, m_guildZones[guildZoneId].GuildZoneName.c_str());
                }
            }
        }
    }
    // Update the player, he is now in a guild owned zone.
    player->InGuildZone(true);
    player->SetGuildZoneId(guildZoneId);
}

void NullSecMgr::OnPlayerLeaveNullSec(Player* player)
{
    uint32 guildZoneId = player->GetGuildZoneId();

    if (!guildZoneId || guildZoneId > TOTAL_GUILD_ZONES)
        return;

    ChatHandler(player->GetSession()).PSendSysMessage(LANG_NULLSEC_LEAVE, m_guildZones[guildZoneId].GuildZoneName.c_str());
    if (GetNullSecOwner(guildZoneId) != player->GetGuild())
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
    for (std::map<uint32, NullSecGuildZoneData>::iterator itr = m_guildZones.begin(); itr != m_guildZones.end(); ++itr)
    {
        if (itr->second.ZoneId == zoneId)
            return itr->second.GuildZoneId;
    }

    return GUILD_ZONE_NONE;
}

bool NullSecMgr::IsNullSecVitalArea(uint32 guildZoneId, uint32 area)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId || !area)
        return false;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == area)
            return true;
    }

    return false;
}

Position NullSecMgr::GetStandardPositionByVitalArea(uint32 guildZoneId, uint32 vitalArea)
{
    if (!vitalArea || !guildZoneId || guildZoneId > TOTAL_GUILD_ZONES)
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
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].LowSecRespawnPosition;
}

bool NullSecMgr::IsNullSecUnderAttack(uint32 guildZoneId)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId)
        return false;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreasStatus[i] == VITAL_AREA_STATUS_UNDER_ATTACK)
            return true;
    }

    return false;
}

void NullSecMgr::SetNullSecUnderAttack(uint32 guildZoneId, bool underAttack, Guild* attacker)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId)
        return;

    if (underAttack && !attacker)
        return;

    if (underAttack && m_guildZones[guildZoneId].IsUnderAttack && attacker == m_guildZones[guildZoneId].Attacker)
        return;

    m_guildZones[guildZoneId].IsUnderAttack = underAttack;

    if (underAttack)
    {
        m_guildZones[guildZoneId].Attacker = attacker;
        Guild* owner = GetNullSecOwner(guildZoneId);
        if (owner)
        {
            // Inform only the owners of the zone
            const SessionMap worldSessions = sWorld->GetAllSessions();
            for (SessionMap::const_iterator itr = worldSessions.begin(); itr != worldSessions.end(); ++itr)
            {
                if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld() || !itr->second->GetPlayer()->GetGuild())
                    continue;

                if (itr->second->GetPlayer()->GetGuild() == owner)
                    ChatHandler(itr->second).PSendSysMessage(LANG_NULLSEC_UNDER_ATTACK, m_guildZones[guildZoneId].GuildZoneName.c_str());
            }
        }
    }
    else
        m_guildZones[guildZoneId].Attacker = NULL;
}

Guild* NullSecMgr::GetNullSecAttacker(uint32 guildZoneId)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].Attacker;
}

std::string NullSecMgr::GetNullSecName(uint32 guildZoneId)
{
    if (guildZoneId > TOTAL_GUILD_ZONES || !guildZoneId)
        return NULL;

    return m_guildZones[guildZoneId].GuildZoneName;
}

void NullSecMgr::SetNullSecVitalAreaStatus(uint32 guildZoneId, uint32 areaId, uint8 status)
{
    if (!guildZoneId || guildZoneId > TOTAL_GUILD_ZONES || !areaId || status > VITAL_AREA_STATUS_UNDER_ATTACK)
        return;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == areaId)
            m_guildZones[guildZoneId].VitalAreasStatus[i] = status;
    }
}

uint8 NullSecMgr::GetNullSecVitalAreaStatus(uint32 guildZoneId, uint32 areaId)
{
    if (!guildZoneId || guildZoneId > TOTAL_GUILD_ZONES || !areaId)
        return VITAL_AREA_STATUS_UNKNOWN;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == areaId)
            return m_guildZones[guildZoneId].VitalAreasStatus[i];
    }

    return VITAL_AREA_STATUS_UNKNOWN;
}

void NullSecMgr::SetNullSecVitalAreaAttacker(uint32 guildZoneId, uint32 areaId, Guild* attacker = NULL)
{
    if (!guildZoneId || guildZoneId > TOTAL_GUILD_ZONES || !areaId)
        return;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == areaId)
        {
            m_guildZones[guildZoneId].VitalAreasAttackers[i] = attacker;
            if (attacker && IsNullSecUnderAttack(guildZoneId))
            {
                Guild* owner = GetNullSecOwner(guildZoneId);
                // Inform only the owners of the zone or everyone on the server if the zone hasn't been conquered
                const SessionMap worldSessions = sWorld->GetAllSessions();
                for (SessionMap::const_iterator itr = worldSessions.begin(); itr != worldSessions.end(); ++itr)
                {
                    if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld() || !itr->second->GetPlayer()->GetGuild())
                        continue;

                    if (owner)
                    {
                        if (itr->second->GetPlayer()->GetGuild() == owner)
                            ChatHandler(itr->second).PSendSysMessage(LANG_NULLSEC_UNDER_ATTACK, m_guildZones[guildZoneId].GuildZoneName.c_str());
                    }
                    else
                        ChatHandler(itr->second).PSendSysMessage(LANG_NULLSEC_UNDER_ATTACK, m_guildZones[guildZoneId].GuildZoneName.c_str());
                }
            }
        }
    }
}

Guild* NullSecMgr::GetNullSecVitalAreaAttacker(uint32 guildZoneId, uint32 areaId)
{
    if (!guildZoneId || guildZoneId > TOTAL_GUILD_ZONES || !areaId)
        return NULL;

    for (uint8 i = 0; i < 3; ++i)
    {
        if (m_guildZones[guildZoneId].VitalAreas[i] == areaId)
            return m_guildZones[guildZoneId].VitalAreasAttackers[i];
    }

    return NULL;
}

Position NullSecMgr::GetNearestRespawnPointForPlayer(Player* player)
{
    if (!player->IsInGuildZone())
        return player->GetPosition();

    // Check first distance to all posible null sec respawn points, if the
    // player's guild has conquered them, and select the nearest possible.
    uint32 guildZoneId = player->GetGuildZoneId();
    float nearestNullSecDistance = 0.0f;
    Position nearestNullSecPosition = NULL;
    if (player->GetGuild())
    {
        for (uint8 i = GUILD_ZONE_NONE + 1; i <= TOTAL_GUILD_ZONES; ++i)
        {
            if (GetNullSecOwner(i) == player->GetGuild())
            {
                for (uint8 j = 0; j < 3; ++j)
                {
                    Position nullSecPos = GetStandardPositionByVitalArea(i, m_guildZones[i].VitalAreas[j]);
                    float distance = player->GetDistance2d(nullSecPos.GetPositionX(), nullSecPos.GetPositionY());
                    if (distance < nearestNullSecDistance || nearestNullSecDistance == 0.0f)
                    {
                        nearestNullSecDistance = distance;
                        nearestNullSecPosition = nullSecPos;
                    }
                }
            }
        }
    }
    // Now check what's nearer, the low sec respawn point or the null sec respawn point (if any)
    Position lowSecPos = GetLowSecRespawnPositionByGuildZoneId(guildZoneId);
    if (nearestNullSecPosition != NULL && player->GetDistance2d(lowSecPos.GetPositionX(), lowSecPos.GetPositionY()) > nearestNullSecDistance)
        return nearestNullSecPosition;
    
    return GetLowSecRespawnPositionByGuildZoneId(guildZoneId);
}

bool NullSecMgr::IsAllowedTaxiNode(Player* player, uint32 taxiNodeId)
{
    // Check if this player is allowed to fly to this node (ergo his guild has the zone conquered)
    // If player is in null sec, he can't fly nowhere
    if (player->IsInGuildZone())
        return false;

    // Get zone by the taxi node ID
    for (uint8 guildZoneId = GUILD_ZONE_NONE + 1; guildZoneId <= TOTAL_GUILD_ZONES; ++guildZoneId)
    {
        for (std::vector<uint32>::iterator itr = m_guildZones[guildZoneId].TaxiNodes.begin(); itr != m_guildZones[guildZoneId].TaxiNodes.end(); ++itr)
        {
            if (*itr == taxiNodeId)
            {
                if (player->GetGuild() == GetNullSecOwner(guildZoneId))
                    return true;

                return false;
            }
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
        for (uint8 i = 0; i < 3; ++i)
        {
            if (itr->second.Owners[i] == guild)
                RemoveNullSecVitalAreaOwner(itr->second.GuildZoneId, itr->second.VitalAreas[i]);
        }
    }
}