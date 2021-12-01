/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_MAP_INSTANCED_H
#define SERVER_MAP_INSTANCED_H

#include "Map.h"
#include "InstanceSaveMgr.h"
#include "DBCEnums.h"

class GarrisonMap;

class GAME_API MapInstanced : public Map
{
    friend class MapManager;
    public:
        typedef std::unordered_map< uint32, Map*> InstancedMaps;

        MapInstanced(uint32 id, time_t expiry);
        ~MapInstanced() { }

        // functions overwrite Map versions
        void Update(const uint32) override;
        void DelayedUpdate(const uint32 diff) override;
        //void RelocationNotify();
        void UnloadAll() override;
        EnterState CannotEnter(Player* /*player*/) override;

        Map* CreateInstanceForPlayer(const uint32 mapId, Player* player, uint32 loginInstanceId=0);
        Map* FindInstanceMap(uint32 instanceId) const
        {
            InstancedMaps::const_iterator i = m_InstancedMaps.find(instanceId);
            return(i == m_InstancedMaps.end() ? nullptr : i->second);
        }
        bool DestroyInstance(InstancedMaps::iterator &itr);

        InstancedMaps &GetInstancedMaps() { return m_InstancedMaps; }
        virtual void InitVisibilityDistance() override;

    private:
        InstanceMap* CreateInstance(uint32 InstanceId, InstanceSave* save, Difficulty difficulty, TeamId team);
        BattlegroundMap* CreateBattleground(uint32 InstanceId, Battleground* bg);
        GarrisonMap* CreateGarrison(uint32 instanceId, Player* owner);

        InstancedMaps m_InstancedMaps;
};
#endif
