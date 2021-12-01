/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Map.h"
#include "nexus.h"
#include "Player.h"

enum Factions
{
    FACTION_HOSTILE_FOR_ALL                       = 16
};

class instance_nexus : public InstanceMapScript
{
    public:
        instance_nexus() : InstanceMapScript(NexusScriptName, 576) { }

        struct instance_nexus_InstanceMapScript : public InstanceScript
        {
            instance_nexus_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
            {
                SetHeaders(DataHeader);
                SetBossNumber(EncounterCount);
                _teamInInstance = 0;
            }

            void OnPlayerEnter(Player* player) override
            {
                if (!_teamInInstance)
                    _teamInInstance = player->GetTeam();
            }

            void OnCreatureCreate(Creature* creature) override
            {
                switch (creature->GetEntry())
                {
                    case NPC_ANOMALUS:
                        AnomalusGUID = creature->GetGUID();
                        break;
                    case NPC_KERISTRASZA:
                        KeristraszaGUID = creature->GetGUID();
                        break;
                    // Alliance npcs are spawned by default, if you are alliance, you will fight against horde npcs.
                    case NPC_ALLIANCE_BERSERKER:
                        if (ServerAllowsTwoSideGroups())
                            creature->setFaction(FACTION_HOSTILE_FOR_ALL);
                        if (_teamInInstance == ALLIANCE)
                            creature->UpdateEntry(NPC_HORDE_BERSERKER);
                        break;
                    case NPC_ALLIANCE_RANGER:
                        if (ServerAllowsTwoSideGroups())
                            creature->setFaction(FACTION_HOSTILE_FOR_ALL);
                        if (_teamInInstance == ALLIANCE)
                            creature->UpdateEntry(NPC_HORDE_RANGER);
                        break;
                    case NPC_ALLIANCE_CLERIC:
                        if (ServerAllowsTwoSideGroups())
                            creature->setFaction(FACTION_HOSTILE_FOR_ALL);
                        if (_teamInInstance == ALLIANCE)
                            creature->UpdateEntry(NPC_HORDE_CLERIC);
                        break;
                    case NPC_ALLIANCE_COMMANDER:
                        if (ServerAllowsTwoSideGroups())
                            creature->setFaction(FACTION_HOSTILE_FOR_ALL);
                        if (_teamInInstance == ALLIANCE)
                            creature->UpdateEntry(NPC_HORDE_COMMANDER);
                        break;
                    case NPC_COMMANDER_STOUTBEARD:
                        if (ServerAllowsTwoSideGroups())
                            creature->setFaction(FACTION_HOSTILE_FOR_ALL);
                        if (_teamInInstance == ALLIANCE)
                            creature->UpdateEntry(NPC_COMMANDER_KOLURG);
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go) override
            {
                switch (go->GetEntry())
                {
                    case GO_ANOMALUS_CONTAINMET_SPHERE:
                        AnomalusContainmentSphere = go->GetGUID();
                        if (GetBossState(DATA_ANOMALUS) == DONE)
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    case GO_ORMOROKS_CONTAINMET_SPHERE:
                        OrmoroksContainmentSphere = go->GetGUID();
                        if (GetBossState(DATA_ORMOROK) == DONE)
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        break;
                    case GO_TELESTRAS_CONTAINMET_SPHERE:
                        TelestrasContainmentSphere = go->GetGUID();
                        if (GetBossState(DATA_MAGUS_TELESTRA) == DONE)
                            go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
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
                    case DATA_MAGUS_TELESTRA:
                        if (state == DONE)
                        {
                            if (GameObject* sphere = instance->GetGameObject(TelestrasContainmentSphere))
                                sphere->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        }
                        break;
                    case DATA_ANOMALUS:
                        if (state == DONE)
                        {
                            if (GameObject* sphere = instance->GetGameObject(AnomalusContainmentSphere))
                                sphere->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        }
                        break;
                    case DATA_ORMOROK:
                        if (state == DONE)
                        {
                            if (GameObject* sphere = instance->GetGameObject(OrmoroksContainmentSphere))
                                sphere->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                        }
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
                    case DATA_ANOMALUS:
                        return AnomalusGUID;
                    case DATA_KERISTRASZA:
                        return KeristraszaGUID;
                    case ANOMALUS_CONTAINMET_SPHERE:
                        return AnomalusContainmentSphere;
                    case ORMOROKS_CONTAINMET_SPHERE:
                        return OrmoroksContainmentSphere;
                    case TELESTRAS_CONTAINMET_SPHERE:
                        return TelestrasContainmentSphere;
                    default:
                        break;
                }

                return ObjectGuid::Empty;
            }

        private:
            ObjectGuid AnomalusGUID;
            ObjectGuid KeristraszaGUID;
            ObjectGuid AnomalusContainmentSphere;
            ObjectGuid OrmoroksContainmentSphere;
            ObjectGuid TelestrasContainmentSphere;
            uint32 _teamInInstance;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const override
        {
            return new instance_nexus_InstanceMapScript(map);
        }
};

void AddSC_instance_nexus()
{
    new instance_nexus();
}
