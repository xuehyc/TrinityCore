/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef OBSIDIAN_SANCTUM_H_
#define OBSIDIAN_SANCTUM_H_

#include "CreatureAIImpl.h"

#define OSScriptName "instance_obsidian_sanctum"
#define DataHeader "OS"

uint32 const EncounterCount = 5;

enum OSDataTypes
{
    DATA_SARTHARION             = 0,
    DATA_TENEBRON               = 1,
    DATA_SHADRON                = 2,
    DATA_VESPERON               = 3,
    DATA_PORTAL_OPEN            = 4,
    TWILIGHT_ACHIEVEMENTS       = 5
};

enum OSCreaturesIds
{
    NPC_SARTHARION              = 28860,
    NPC_TENEBRON                = 30452,
    NPC_SHADRON                 = 30451,
    NPC_VESPERON                = 30449
};

enum OSGameObjectIds
{
    GO_TWILIGHT_PORTAL          = 193988
};

template<typename AI>
inline AI* GetObsidianSanctumAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, OSScriptName);
}

#endif // OBSIDIAN_SANCTUM_H_
