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

#define MAX_NULLSEC_ZONES 5
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
	Position StandardPositions[3];
    Position LowSecRespawnPosition;
    Guild* Owners[3];
    Guild* Attacker;
    bool IsUnderAttack;
	bool IsContested;
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
    Guild* GetNullSecZoneOwner(uint32 guildZoneId);
    void SetNullSecZoneOwner(uint32 guildZoneId, Guild* guild);
    void SetNullSecZoneOwner(uint32 guildZoneId, uint32 guildId);
    void RemoveGuildZoneOwner(uint32 guildZoneId);
    bool IsNullSecZone(uint32 zoneId);
    uint32 GetNullSecGuildZone(uint32 zoneId, uint32 areaId);
    uint32* GetVitalAreasByGuildZoneId(uint32 guildZoneId);
    Position GetStandardPositionByVitalArea(uint32 guildZoneId, uint32 vitalArea);
    Position GetLowSecRespawnPositionByGuildZoneId(uint32 guildZoneId);
    bool IsGuildZoneUnderAttack(uint32 guildZoneId);
    void SetGuildZoneUnderAttack(uint32 guildZoneId, bool underAttack, Guild* attacker);
    Guild* GetGuildZoneAttacker(uint32 guildZoneId);
    std::string GetGuildZoneName(uint32 guildZone);
    void OnPlayerEnterNullSecGuildZone(Player* player);
    void OnPlayerLeaveNullSecGuildZone(Player* player);
    Position GetNearestRespawnPointForPlayer(Player* player);
    bool IsAllowedTaxiNode(Player* player, uint32 taxiNodeId);
    void OnGuildDisband(Guild* guild);

private:
    typedef std::map<uint32, NullSecGuildZoneData> NullSecGuildZoneDataMap;

    // Stores data about each of the conquerable zones
    NullSecGuildZoneDataMap m_guildZones;
    std::vector<uint32> m_nullSecZones;
};

#define sNullSecMgr NullSecMgr::instance()

#endif /* NULL_SEC_MGR_H_ */