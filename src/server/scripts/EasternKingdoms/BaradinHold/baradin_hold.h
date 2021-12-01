/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_BARADIN_HOLD_H_
#define DEF_BARADIN_HOLD_H_

#include "CreatureAIImpl.h"

#define DataHeader "BH"
#define BHScriptName "instance_baradin_hold"

uint32 const EncounterCount = 3;

enum BHDataTypes
{
    DATA_ARGALOTH           = 0,
    DATA_OCCUTHAR           = 1,
    DATA_ALIZABAL           = 2
};

enum BHCreatureIds
{
    BOSS_ARGALOTH           = 47120,
    BOSS_OCCUTHAR           = 52363,
    BOSS_ALIZABAL           = 55869,

    NPC_EYE_OF_OCCUTHAR     = 52389,
    NPC_FOCUS_FIRE_DUMMY    = 52369,
    NPC_OCCUTHAR_EYE        = 52368
};

enum BHGameObjectIds
{
    GO_ARGALOTH_DOOR        = 207619,
    GO_OCCUTHAR_DOOR        = 208953,
    GO_ALIZABAL_DOOR        = 209849
};

template<typename AI>
CreatureAI* GetBaradinHoldAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, BHScriptName);
}

#endif
