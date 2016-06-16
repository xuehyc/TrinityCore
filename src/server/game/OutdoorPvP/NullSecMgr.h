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

#ifndef NULL_SEC_MGR_H_
#define NULL_SEC_MGR_H_

#define NO_GUILD_ZONE NULL
#define ITEM_STANDARD_OF_CONQUEST 25555
#define NPC_STANDARD_OF_CONQUEST 50000

class Player;
class ZoneScript;
class Guild;

struct NullSecGuildZoneData
{
    uint32 GuildZoneId;
    std::string GuildZoneName;
    uint32 ZoneId;
	uint32 VitalAreas[3];
	uint8 VitalAreasStatus[3];
    Guild* VitalAreasAttackers[3];
    Guild* Owners[3];
	Position StandardPositions[3];
    Position LowSecRespawnPosition;
    uint32 IntrudersCount;
	std::vector<uint32> TaxiNodes;
};

class NullSecMgr
{

private:
    NullSecMgr();
    ~NullSecMgr();

public:
    static NullSecMgr* instance()
    {
        static NullSecMgr instance;
        return &instance;
    }
    void InitNullSecMgr();

    bool IsNullSecVitalArea(uint32 guildZoneId, uint32 area);
    Guild* GetNullSecVitalAreaOwner(uint32 guildZoneId, uint32 vitalAreaId);
    void SetNullSecVitalAreaOwner(uint32 guildZoneId, Guild* guild, uint32 vitalAreaId);
    void RemoveNullSecVitalAreaOwner(uint32 guildZoneId, uint32 vitalAreaId);
    void SetNullSecVitalAreaStatus(uint32 guildZoneId, uint32 areaId, uint8 status);
    uint8 GetNullSecVitalAreaStatus(uint32 guildZoneId, uint32 areaId);
    void SetNullSecVitalAreaAttacker(uint32 guildZoneId, uint32 areaId, Guild* attacker);
    Guild* GetNullSecVitalAreaAttacker(uint32 guildZoneId, uint32 areaId);
    Position GetStandardPositionByVitalArea(uint32 guildZoneId, uint32 vitalArea);

    uint32 GetNullSecGuildZoneId(uint32 zoneId);
    bool IsNullSecZone(uint32 zoneId);
    Guild* GetNullSecOwner(uint32 guildZoneId);
    bool IsNullSecUnderAttack(uint32 guildZoneId);
    std::string GetNullSecName(uint32 guildZone);
    
    void OnPlayerEnterNullSec(Player* player);
    void OnPlayerLeaveNullSec(Player* player);
    void OnGuildDisband(Guild* guild);

    Position GetLowSecRespawnPositionByGuildZoneId(uint32 guildZoneId);
    Position GetNearestRespawnPointForPlayer(Player* player);
    bool IsAllowedTaxiNode(Player* player, uint32 taxiNodeId);
    

private:
    typedef std::map<uint32, NullSecGuildZoneData> NullSecGuildZoneDataMap;

    // Stores data about each of the conquerable zones
    NullSecGuildZoneDataMap m_guildZones;
    std::vector<uint32> m_nullSecZones;
};

#define sNullSecMgr NullSecMgr::instance()

#endif /* NULL_SEC_MGR_H_ */