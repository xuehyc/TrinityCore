/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
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

#include "firelands.h"

DoorData const doorData[] =
{
    {GO_RAGNAROS_DOOR,                  DATA_RAGNAROS,                  DOOR_TYPE_ROOM,         BOUNDARY_N      },
    {0,                                 0,                              DOOR_TYPE_ROOM,         BOUNDARY_NONE   }, // END
};

class instance_firelands : public InstanceMapScript
{
public:
    instance_firelands() : InstanceMapScript("instance_firelands", 720) { }

    struct instance_firelands_InstanceMapScript : public InstanceScript
    {
        instance_firelands_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
        {
            Initialize();
        }

        uint64 _ragnarosGUID;
        uint64 _cacheOfTheFirelordGUID;


        void Initialize()
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
            _ragnarosGUID = 0;
            _cacheOfTheFirelordGUID = 0;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case BOSS_RAGNAROS:
                    _ragnarosGUID = creature->GetGUID();
                    break;
                case NPC_SMOULDERING_HATCHLING:
                    // Cannot directly start attacking here as the creature is not yet on map
                    creature->m_Events.AddEvent(new DelayedAttackStartEvent(creature), creature->m_Events.CalculateTime(500));
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case GO_RAGNAROS_DOOR:
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    AddDoor(go, true);
                    break;
                case GO_CACHE_OF_THE_FIRELORD:
                    go->SetPhaseMask(2, true);
                    _cacheOfTheFirelordGUID = go->GetGUID();
                    break;
                case GO_CACHE_OF_THE_FIRELORD_HC:
                    go->SetPhaseMask(2, true);
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case GO_RAGNAROS_DOOR:
                    AddDoor(go, false);
                    break;
                default:
                    break;
            }
        }

        bool SetBossState(uint32 data, EncounterState state)
        {
            if (!InstanceScript::SetBossState(data, state))
                return false;

            return true;
        }

        uint64 GetData64(uint32 data) const
        {
            switch (data)
            {
                case DATA_RAGNAROS:
                    return _ragnarosGUID;
                default:
                    break;
            }
            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "F L " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'F' && dataHead2 == 'L')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;

                    SetBossState(i, EncounterState(tmpState));
                }

            } else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_firelands_InstanceMapScript(map);
    }
};

void AddSC_instance_firelands()
{
    new instance_firelands();
}