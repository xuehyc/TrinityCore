/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef AUCHENAI_CRYPTS_H_
#define AUCHENAI_CRYPTS_H_

#include "CreatureAIImpl.h"

#define ACScriptName "instance_auchenai_crypts"
#define DataHeader   "AC"

uint32 const EncounterCount = 2;

enum ACDataTypes
{
    // Encounter States/Boss GUIDs
    DATA_SHIRRAK_THE_DEAD_WATCHER   = 0,
    DATA_EXARCH_MALADAAR            = 1
};

template<typename AI>
inline AI* GetAuchenaiCryptsAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, ACScriptName);
}

#endif // AUCHENAI_CRYPTS_H_
