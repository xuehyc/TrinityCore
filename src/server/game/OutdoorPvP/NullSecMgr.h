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

#define MAX_NULLSEC_ZONES 12
#define NO_OWNER NULL

class Player;
class ZoneScript;
class Guild;

struct NullSecZoneData
{
    uint32 ZoneId;
    std::string ZoneName;
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
    Guild* GetNullSecZoneOwner(uint32 zoneId);
    void SetNullSecZoneOwner(uint32 zoneId, Guild* guild);
    void SetNullSecZoneOwner(uint32 zoneId, uint32 guildId);
    void OnPlayerEnterNullSecZone(Player* player, uint32 zoneId);
    void OnPlayerLeaveNullSecZone(Player* player);

private:
    typedef std::map<uint32, NullSecZoneData> NullSecZoneDataMap;

    NullSecZoneDataMap m_nullSecZones;
};

#define sNullSecMgr ACE_Singleton<NullSecMgr, ACE_Null_Mutex>::instance()

#endif /* NULL_SEC_MGR_H_ */