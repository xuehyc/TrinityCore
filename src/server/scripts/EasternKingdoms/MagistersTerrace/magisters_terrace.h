/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_MAGISTERS_TERRACE_H
#define DEF_MAGISTERS_TERRACE_H

#include "CreatureAIImpl.h"

#define MGTScriptName "instance_magisters_terrace"
#define DataHeader "MT"

uint32 const EncounterCount = 4;

enum MTDataTypes
{
    DATA_SELIN,
    DATA_VEXALLUS,
    DATA_DELRISSA,
    DATA_KAELTHAS,

    DATA_KAEL_STATUE_LEFT,
    DATA_KAEL_STATUE_RIGHT,

    DATA_DELRISSA_DEATH_COUNT,
    DATA_KAELTHAS_STATUES,
    DATA_ESCAPE_ORB
};

enum MTCreatureIds
{
    NPC_SELIN               = 24723,
    NPC_DELRISSA            = 24560,
    NPC_FEL_CRYSTAL         = 24722,
    NPC_KALECGOS            = 24844,
    NPC_HUMAN_KALECGOS      = 24848
};

enum MTGameObjectIds
{
    GO_VEXALLUS_DOOR        = 187896,
    GO_SELIN_DOOR           = 187979,
    GO_SELIN_ENCOUNTER_DOOR = 188065,
    GO_DELRISSA_DOOR        = 187770,
    GO_KAEL_DOOR            = 188064,
    GO_KAEL_STATUE_1        = 188165,
    GO_KAEL_STATUE_2        = 188166,
    GO_ESCAPE_ORB           = 188173
};

enum MTInstanceEventIds
{
    EVENT_SPAWN_KALECGOS    = 16547
};

enum MTInstanceText
{
    SAY_KALECGOS_SPAWN      = 0
};

enum MTMovementData
{
    PATH_KALECGOS_FLIGHT    = 248440
};

template<typename AI>
inline AI* GetMagistersTerraceAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, MGTScriptName);
}

#endif
