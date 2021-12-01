/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_THE_BOTANICA_H
#define DEF_THE_BOTANICA_H

#include "CreatureAIImpl.h"

#define BotanicaScriptName "instance_the_botanica"
#define DataHeader "BC"

uint32 const EncounterCount = 5;

enum BCDataTypes
{
    DATA_COMMANDER_SARANNIS             = 0,
    DATA_HIGH_BOTANIST_FREYWINN         = 1,
    DATA_THORNGRIN_THE_TENDER           = 2,
    DATA_LAJ                            = 3,
    DATA_WARP_SPLINTER                  = 4
};

enum BCCreatureIds
{
    NPC_COMMANDER_SARANNIS              = 17976,
    NPC_HIGH_BOTANIST_FREYWINN          = 17975,
    NPC_THORNGRIN_THE_TENDER            = 17978,
    NPC_LAJ                             = 17980,
    NPC_WARP_SPLINTER                   = 17977
};

template<typename AI>
inline AI* GetBotanicaAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, BotanicaScriptName);
}

#endif
