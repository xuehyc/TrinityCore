/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SETHEKK_HALLS_H_
#define SETHEKK_HALLS_H_

#include "CreatureAIImpl.h"

#define SHScriptName "instance_sethekk_halls"
#define DataHeader "SH"

uint32 const EncounterCount             = 3;

enum SHDataTypes
{
    // Encounter States/Boss GUIDs
    DATA_DARKWEAVER_SYTH                = 0,
    DATA_TALON_KING_IKISS               = 1,
    DATA_ANZU                           = 2,

    // Additional Data
    DATA_TALON_KING_COFFER              = 3
};

enum SHCreatureIds
{
    NPC_ANZU                            = 23035,
    NPC_BROOD_OF_ANZU                   = 23132
};

enum SHGameObjectIds
{
    GO_IKISS_DOOR                       = 177203,
    GO_TALON_KING_COFFER                = 187372
};

template<typename AI>
inline AI* GetSethekkHallsAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, SHScriptName);
}

#endif // SETHEKK_HALLS_H_
