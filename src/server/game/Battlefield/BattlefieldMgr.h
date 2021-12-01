/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef BATTLEFIELD_MGR_H_
#define BATTLEFIELD_MGR_H_

#include "Battlefield.h"

class Player;
class ZoneScript;

// class to handle player enter / leave / areatrigger / GO use events
class GAME_API BattlefieldMgr
{
    public:
        static BattlefieldMgr* instance();

        // create battlefield events
        void InitBattlefield();

        // called when a player enters an battlefield area
        void HandlePlayerEnterZone(Player* player, uint32 zoneId);
        // called when player leaves an battlefield area
        void HandlePlayerLeaveZone(Player* player, uint32 zoneId);

        // return assigned battlefield
        Battlefield* GetBattlefieldToZoneId(uint32 zoneId);
        Battlefield* GetBattlefieldByBattleId(uint32 battleId);
        Battlefield* GetBattlefieldByQueueId(uint64 queueId);

        ZoneScript* GetZoneScript(uint32 zoneId);

        void AddZone(uint32 zoneId, Battlefield* bf);

        void Update(uint32 diff);

    private:
        BattlefieldMgr();
        ~BattlefieldMgr();

        typedef std::vector<Battlefield*> BattlefieldSet;
        typedef std::map<uint32 /*zoneId*/, Battlefield*> BattlefieldMap;
        // contains all initiated battlefield events
        // used when initing / cleaning up
        BattlefieldSet _battlefieldSet;
        // maps the zone ids to an battlefield event
        // used in player event handling
        BattlefieldMap _battlefieldMap;
        // update interval
        uint32 _updateTimer;
};

#define sBattlefieldMgr BattlefieldMgr::instance()

#endif // BATTLEFIELD_MGR_H_
