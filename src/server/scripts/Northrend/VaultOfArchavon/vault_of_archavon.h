/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_ARCHAVON_H
#define DEF_ARCHAVON_H

#include "CreatureAIImpl.h"

#define VoAScriptName "instance_vault_of_archavon"
#define DataHeader "VA"

uint32 const EncounterCount = 4;

enum VAData
{
    DATA_ARCHAVON       = 0,
    DATA_EMALON         = 1,
    DATA_KORALON        = 2,
    DATA_TORAVON        = 3,
};

enum VACreatureIds
{
    NPC_ARCHAVON        = 31125,
    NPC_EMALON          = 33993,
    NPC_KORALON         = 35013,
    NPC_TORAVON         = 38433
};

enum VAAchievementCriteriaIds
{
    CRITERIA_EARTH_WIND_FIRE_10 = 12018,
    CRITERIA_EARTH_WIND_FIRE_25 = 12019,
};

enum VAAchievementSpells
{
    SPELL_EARTH_WIND_FIRE_ACHIEVEMENT_CHECK = 68308,
};

template<typename AI>
inline AI* GetVaultOfArchavonAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, VoAScriptName);
}

#endif
