/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "halls_of_lightning.h"
#include "InstanceScript.h"
#include "Map.h"

DoorData const doorData[] =
{
    { GO_VOLKHAN_DOOR, DATA_VOLKHAN, DOOR_TYPE_PASSAGE },
    { GO_IONAR_DOOR,   DATA_IONAR,   DOOR_TYPE_PASSAGE },
    { GO_LOKEN_DOOR,   DATA_LOKEN,   DOOR_TYPE_PASSAGE },
    { 0,               0,            DOOR_TYPE_ROOM } // END
};

class instance_halls_of_lightning : public InstanceMapScript
{
    public:
        instance_halls_of_lightning() : InstanceMapScript(HoLScriptName, 602) { }

        struct instance_halls_of_lightning_InstanceMapScript : public InstanceScript
        {
            instance_halls_of_lightning_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
            {
                SetHeaders(DataHeader);
                SetBossNumber(EncounterCount);
                LoadDoorData(doorData);
            }

            void OnCreatureCreate(Creature* creature) override
            {
                switch (creature->GetEntry())
                {
                    case NPC_BJARNGRIM:
                        GeneralBjarngrimGUID = creature->GetGUID();
                        break;
                    case NPC_VOLKHAN:
                        VolkhanGUID = creature->GetGUID();
                        break;
                    case NPC_IONAR:
                        IonarGUID = creature->GetGUID();
                        break;
                    case NPC_LOKEN:
                        LokenGUID = creature->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go) override
            {
                switch (go->GetEntry())
                {
                    case GO_VOLKHAN_DOOR:
                    case GO_IONAR_DOOR:
                    case GO_LOKEN_DOOR:
                        AddDoor(go, true);
                        break;
                    case GO_LOKEN_THRONE:
                        LokenGlobeGUID = go->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectRemove(GameObject* go) override
            {
                switch (go->GetEntry())
                {
                    case GO_VOLKHAN_DOOR:
                    case GO_IONAR_DOOR:
                    case GO_LOKEN_DOOR:
                        AddDoor(go, false);
                        break;
                    default:
                        break;
                }
            }

            bool SetBossState(uint32 type, EncounterState state) override
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                switch (type)
                {
                    case DATA_LOKEN:
                        if (state == DONE)
                            if (GameObject* globe = instance->GetGameObject(LokenGlobeGUID))
                                globe->SendCustomAnim(0);
                        break;
                    default:
                        break;
                }

                return true;
            }

            ObjectGuid GetGuidData(uint32 type) const override
            {
                switch (type)
                {
                    case DATA_BJARNGRIM:
                        return GeneralBjarngrimGUID;
                    case DATA_VOLKHAN:
                        return VolkhanGUID;
                    case DATA_IONAR:
                        return IonarGUID;
                    case DATA_LOKEN:
                        return LokenGUID;
                    default:
                        break;
                }
                return ObjectGuid::Empty;
            }

        protected:
            ObjectGuid GeneralBjarngrimGUID;
            ObjectGuid VolkhanGUID;
            ObjectGuid IonarGUID;
            ObjectGuid LokenGUID;

            ObjectGuid LokenGlobeGUID;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const override
        {
            return new instance_halls_of_lightning_InstanceMapScript(map);
        }
};

void AddSC_instance_halls_of_lightning()
{
    new instance_halls_of_lightning();
}
