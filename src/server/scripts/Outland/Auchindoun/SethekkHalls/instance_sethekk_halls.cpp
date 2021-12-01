/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "sethekk_halls.h"

DoorData const doorData[] =
{
    { GO_IKISS_DOOR, DATA_TALON_KING_IKISS, DOOR_TYPE_PASSAGE },
    { 0,             0,                     DOOR_TYPE_ROOM } // END
};

ObjectData const gameObjectData[] =
{
    { GO_TALON_KING_COFFER, DATA_TALON_KING_COFFER },
    { 0,                    0                      } // END
};

class instance_sethekk_halls : public InstanceMapScript
{
    public:
        instance_sethekk_halls() : InstanceMapScript(SHScriptName, 556) { }

        struct instance_sethekk_halls_InstanceMapScript : public InstanceScript
        {
            instance_sethekk_halls_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
            {
                SetHeaders(DataHeader);
                SetBossNumber(EncounterCount);
                LoadDoorData(doorData);
                LoadObjectData(nullptr, gameObjectData);
            }

            void OnCreatureCreate(Creature* creature) override
            {
                if (creature->GetEntry() == NPC_ANZU)
                {
                    if (GetBossState(DATA_ANZU) == DONE)
                        creature->DisappearAndDie();
                    else
                        SetBossState(DATA_ANZU, IN_PROGRESS);
                }
            }

            bool SetBossState(uint32 type, EncounterState state) override
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                switch (type)
                {
                    case DATA_TALON_KING_IKISS:
                        if (state == DONE)
                        {
                            /// @workaround: GO_FLAG_INTERACT_COND remains on the gob, but it is not handled correctly in this case
                            ///              gameobject should have GO_DYNFLAG_LO_ACTIVATE too, which makes gobs interactable with GO_FLAG_INTERACT_COND
                            ///              so just removed GO_FLAG_INTERACT_COND
                            if (GameObject* coffer = GetGameObject(DATA_TALON_KING_COFFER))
                                coffer->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_INTERACT_COND | GO_FLAG_NOT_SELECTABLE);
                        }
                        break;
                    default:
                        break;
                }
                return true;
            }
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const override
        {
            return new instance_sethekk_halls_InstanceMapScript(map);
        }
};

void AddSC_instance_sethekk_halls()
{
    new instance_sethekk_halls();
}
