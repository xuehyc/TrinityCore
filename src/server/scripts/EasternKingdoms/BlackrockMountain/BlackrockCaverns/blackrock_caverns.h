/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef BLACKROCKCAVERNS_H_
#define BLACKROCKCAVERNS_H_

#include "CreatureAIImpl.h"

#define BCScriptName "instance_blackrock_caverns"
#define DataHeader "BRC"

uint32 const EncounterCount             = 5;

enum BRCDataTypes
{
    // Encounter States // Boss GUIDs
    DATA_ROMOGG_BONECRUSHER             = 0,
    DATA_CORLA                          = 1,
    DATA_KARSH_STEELBENDER              = 2,
    DATA_BEAUTY                         = 3,
    DATA_ASCENDANT_LORD_OBSIDIUS        = 4,

    // Additional Objects
    DATA_RAZ_THE_CRAZED                 = 5
};

enum BRCCreatureIds
{
    NPC_TWILIGHT_FLAME_CALLER           = 39708,
    NPC_RAZ_THE_CRAZED                  = 39670,
    NPC_ROMOGG_BONECRUSHER              = 39665
};

template<typename AI>
inline AI* GetBlackrockCavernsAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, BCScriptName);
}

#endif // BLACKROCKCAVERNS_H_
