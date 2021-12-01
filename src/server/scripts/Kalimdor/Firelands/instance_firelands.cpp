/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "Creature.h"
#include "firelands.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Map.h"

class instance_firelands : public InstanceMapScript
{
    public:
        instance_firelands() : InstanceMapScript(FirelandsScriptName, 720) { }

        struct instance_firelands_InstanceScript : public InstanceScript
        {
            instance_firelands_InstanceScript(InstanceMap* map) : InstanceScript(map)
            {
                SetHeaders(DataHeader);
                SetBossNumber(EncounterCount);
            }

            void OnCreatureCreate(Creature* creature) override
            {
                switch (creature->GetEntry())
                {
                    case NPC_SMOULDERING_HATCHLING:
                        // Cannot directly start attacking here as the creature is not yet on map
                        creature->m_Events.AddEvent(new DelayedAttackStartEvent(creature), creature->m_Events.CalculateTime(500));
                        break;
                    case NPC_BALEROC:
                        BalerocGUID = creature->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go) override
            {
                switch (go->GetEntry())
                {
                    case GO_BALEROC_FIREWALL:
                        BalerocDoorGUID = go->GetGUID();
                        if (GetBossState(DATA_SHANNOX) == DONE || GetBossState(DATA_BALEROC) == DONE)
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    default:
                        break;
                }
            }

            bool SetBossState(uint32 type, EncounterState state) override
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                if ((type == DATA_SHANNOX && state == DONE) || (type == DATA_BALEROC && state != IN_PROGRESS))
                {
                    if (GameObject* door = instance->GetGameObject(BalerocDoorGUID))
                        door->SetGoState(GO_STATE_ACTIVE);
                }
                else if (type == DATA_BALEROC && state == IN_PROGRESS)
                    if (GameObject* door = instance->GetGameObject(BalerocDoorGUID))
                        door->SetGoState(GO_STATE_READY);

                return true;
            }

            ObjectGuid GetGuidData(uint32 type) const override
            {
                switch (type)
                {
                    case DATA_BALEROC:
                        return BalerocGUID;
                    default:
                        break;
                }
                return ObjectGuid::Empty;
            }

            protected:
                ObjectGuid BalerocDoorGUID;
                ObjectGuid BalerocGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const override
        {
            return new instance_firelands_InstanceScript(map);
        }
};

void AddSC_instance_firelands()
{
    new instance_firelands();
}
