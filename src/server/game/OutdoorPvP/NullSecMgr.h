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

#include <ace/Singleton.h>

#define MAX_NULLSEC_ZONES 11
#define NO_OWNER NULL
#define NO_GUILD_ZONE NULL

class Player;
class ZoneScript;
class Guild;

struct NullSecGuildZoneData
{
    uint32 GuildZoneId;
    std::string GuildZoneName;
    uint32 ZoneId;
    std::vector<uint32> Areas;
    Guild* Owner;
};

class NullSecMgr
{
    friend class ACE_Singleton<NullSecMgr, ACE_Null_Mutex>;

private:
    NullSecMgr();
    ~NullSecMgr();

public:
    void InitNullSecMgr();
    Guild* GetNullSecZoneOwner(uint32 guildZoneId);
    void SetNullSecZoneOwner(uint32 guildZoneId, Guild* guild);
    void SetNullSecZoneOwner(uint32 guildZoneId, uint32 guildId);
    bool IsNullSecZone(uint32 zoneId);
    uint32 GetNullSecGuildZone(uint32 zoneId, uint32 areaId);
    void OnPlayerEnterNullSecZone(Player* player);
    void OnPlayerEnterNullSecGuildZone(Player* player);
    void OnPlayerLeaveNullSecGuildZone(Player* player);

private:
    typedef std::map<uint32, NullSecGuildZoneData> NullSecGuildZoneDataMap;

    // Stores data about each of the conquerable zones
    NullSecGuildZoneDataMap m_guildZones;
    std::vector<uint32> m_nullSecZones;
};

#define sNullSecMgr ACE_Singleton<NullSecMgr, ACE_Null_Mutex>::instance()

#endif /* NULL_SEC_MGR_H_ */