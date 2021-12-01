/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef HALLS_OF_LIGHTNING_H_
#define HALLS_OF_LIGHTNING_H_

#include "CreatureAIImpl.h"

#define HoLScriptName "instance_halls_of_lightning"
#define DataHeader    "HOL"

uint32 const EncounterCount = 4;

enum HOLDataTypes
{
    // Encounter States/Boss GUIDs
    DATA_BJARNGRIM          = 0,
    DATA_VOLKHAN            = 1,
    DATA_IONAR              = 2,
    DATA_LOKEN              = 3
};

enum HOLCreaturesIds
{
    NPC_BJARNGRIM           = 28586,
    NPC_VOLKHAN             = 28587,
    NPC_IONAR               = 28546,
    NPC_LOKEN               = 28923
};

enum HOLGameObjectIds
{
    GO_BJARNGRIM_DOOR       = 191416,
    GO_VOLKHAN_DOOR         = 191325,
    GO_IONAR_DOOR           = 191326,
    GO_LOKEN_DOOR           = 191324,
    GO_LOKEN_THRONE         = 192654
};

template<typename AI>
inline AI* GetHallsOfLightningAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, HoLScriptName);
}

#endif // HALLS_OF_LIGHTNING_H_
