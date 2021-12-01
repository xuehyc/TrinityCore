/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "AreaBoundary.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "obsidian_sanctum.h"

/* Obsidian Sanctum encounters:
0 - Sartharion
*/

BossBoundaryData const boundaries =
{
    { DATA_SARTHARION, new RectangleBoundary(3218.86f, 3275.69f, 484.68f, 572.4f) }
};

class instance_obsidian_sanctum : public InstanceMapScript
{
public:
    instance_obsidian_sanctum() : InstanceMapScript(OSScriptName, 615) { }

    struct instance_obsidian_sanctum_InstanceMapScript : public InstanceScript
    {
        instance_obsidian_sanctum_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadBossBoundaries(boundaries);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SARTHARION:
                    sartharionGUID = creature->GetGUID();
                    break;
                // Three dragons below set to active state once created.
                // We must expect bigger raid to encounter main boss, and then three dragons must be active due to grid differences
                case NPC_TENEBRON:
                    tenebronGUID = creature->GetGUID();
                    creature->setActive(true);
                    break;
                case NPC_SHADRON:
                    shadronGUID = creature->GetGUID();
                    creature->setActive(true);
                    break;
                case NPC_VESPERON:
                    vesperonGUID = creature->GetGUID();
                    creature->setActive(true);
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                 return false;

            switch (type)
            {
                case DATA_SARTHARION:
                case DATA_TENEBRON:
                case DATA_SHADRON:
                case DATA_VESPERON:
                    break;
                default:
                    break;
            }
            return true;
        }

        ObjectGuid GetGuidData(uint32 Data) const override
        {
            switch (Data)
            {
                case DATA_SARTHARION:
                    return sartharionGUID;
                case DATA_TENEBRON:
                    return tenebronGUID;
                case DATA_SHADRON:
                    return shadronGUID;
                case DATA_VESPERON:
                    return vesperonGUID;
            }
            return ObjectGuid::Empty;
        }

    protected:
        ObjectGuid sartharionGUID;
        ObjectGuid tenebronGUID;
        ObjectGuid shadronGUID;
        ObjectGuid vesperonGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_obsidian_sanctum_InstanceMapScript(map);
    }
};

void AddSC_instance_obsidian_sanctum()
{
    new instance_obsidian_sanctum();
}
