/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_GNOMEREGAN_H
#define DEF_GNOMEREGAN_H

#include "CreatureAIImpl.h"

#define GNOScriptName "instance_gnomeregan"
#define DataHeader "GNO"

enum GNOGameObjectIds
{
    GO_CAVE_IN_LEFT     = 146085,
    GO_CAVE_IN_RIGHT    = 146086,
    GO_RED_ROCKET       = 103820
};

enum GNOCreatureIds
{
    NPC_BLASTMASTER_EMI_SHORTFUSE   = 7998,
    NPC_CAVERNDEEP_AMBUSHER         = 6207,
    NPC_GRUBBIS                     = 7361,
    NPC_CHOMPER                     = 6215
};

enum GNOData
{
    TYPE_EVENT = 1
};

enum GNOData64
{
    DATA_GO_CAVE_IN_LEFT,
    DATA_GO_CAVE_IN_RIGHT,
    DATA_NPC_BASTMASTER_EMI_SHORTFUSE
};

template<typename AI>
inline AI* GetGnomereganAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, GNOScriptName);
}

#endif
