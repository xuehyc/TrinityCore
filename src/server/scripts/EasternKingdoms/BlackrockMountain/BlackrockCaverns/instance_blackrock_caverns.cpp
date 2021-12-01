/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "blackrock_caverns.h"
#include "InstanceScript.h"

ObjectData const creatureData[] =
{
    { NPC_RAZ_THE_CRAZED, DATA_RAZ_THE_CRAZED },
    { 0,                  0                   }
};

class instance_blackrock_caverns : public InstanceMapScript
{
    public:
        instance_blackrock_caverns(): InstanceMapScript(BCScriptName, 645) { }

        struct instance_blackrock_caverns_InstanceMapScript : public InstanceScript
        {
            instance_blackrock_caverns_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
            {
                SetHeaders(DataHeader);
                SetBossNumber(EncounterCount);
                LoadObjectData(creatureData, nullptr);
            }

            bool SetBossState(uint32 type, EncounterState state) override
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                switch (type)
                {
                    case DATA_ROMOGG_BONECRUSHER:
                    case DATA_CORLA:
                    case DATA_KARSH_STEELBENDER:
                    case DATA_BEAUTY:
                    case DATA_ASCENDANT_LORD_OBSIDIUS:
                        break;
                    default:
                        break;
                }

                return true;
            }
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const override
        {
            return new instance_blackrock_caverns_InstanceMapScript(map);
        }
};

void AddSC_instance_blackrock_caverns()
{
    new instance_blackrock_caverns();
}
