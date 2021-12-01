/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_ZULGURUB_H
#define DEF_ZULGURUB_H

#include "CreatureAIImpl.h"

#define DataHeader "ZG"
#define ZGScriptName "instance_zulgurub"

uint32 const EncounterCount = 5;

enum ZGDataTypes
{
    DATA_VENOXIS                    = 0,
    DATA_MANDOKIR                   = 1,
    DATA_KILNARA                    = 2,
    DATA_ZANZIL                     = 3,
    DATA_JINDO                      = 4,

    // Cache of Madness
    DATA_HAZZARAH                   = 5,
    DATA_RENATAKI                   = 6,
    DATA_WUSHOOLAY                  = 7,
    DATA_GRILEK                     = 8,

    // Jin'do the Godbreaker
    DATA_JINDOR_TRIGGER,
};

enum ZGCreatureIds
{
    NPC_VENOXIS                     = 52155,
    NPC_MANDOKIR                    = 52151,
    NPC_KILNARA                     = 52059,
    NPC_ZANZIL                      = 52053,
    NPC_JINDO                       = 52148,

    // Cache of Madness
    NPC_HAZZARAH                    = 52271,
    NPC_RENATAKI                    = 52269,
    NPC_WUSHOOLAY                   = 52286,
    NPC_GRILEK                      = 52258,

    // Bloodlord Mandokir
    NPC_CHAINED_SPIRIT              = 52156,
    NPC_OHGAN                       = 52157,

    // Jin'do the Godbreaker
    NPC_JINDO_TRIGGER               = 52150,
    NPC_SPIRIT_OF_HAKKAR            = 52222,
    NPC_SHADOW_OF_HAKKAR            = 52650
};

enum ZGGameObjectIds
{
    // High Priest Venoxis
    GO_VENOXIS_COIL                 = 208844,

    // Bloodlord Mandokir
    GO_ARENA_DOOR_1                 = 208845,
    GO_ARENA_DOOR_2                 = 208847,
    GO_ARENA_DOOR_3                 = 208848,
    GO_ARENA_DOOR_4                 = 208846,
    GO_ARENA_DOOR_5                 = 208849,

    // High Priestess Kilnara
    GO_FORCEFIELD                   = 180497,

    // Zanzil
    GO_ZANZIL_DOOR                  = 208850,

    // Cache of Madness
    GO_THE_CACHE_OF_MADNESS_DOOR    = 208843
};

template<typename AI>
inline AI* GetZulGurubAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, ZGScriptName);
}

#endif
