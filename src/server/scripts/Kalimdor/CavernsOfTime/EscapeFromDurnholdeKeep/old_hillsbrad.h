/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_OLD_HILLSBRAD_H
#define DEF_OLD_HILLSBRAD_H

#include "CreatureAIImpl.h"

#define OHScriptName "instance_old_hillsbrad"
#define DataHeader "OH"

enum OHDataTypes
{
    TYPE_BARREL_DIVERSION   = 1,
    TYPE_THRALL_EVENT       = 2,
    TYPE_THRALL_PART1       = 3,
    TYPE_THRALL_PART2       = 4,
    TYPE_THRALL_PART3       = 5,
    TYPE_THRALL_PART4       = 6,

    DATA_THRALL             = 7,
    DATA_TARETHA            = 8,
    DATA_EPOCH              = 9

};

enum OHWorldStateIds
{
    WORLD_STATE_OH              = 2436
};


template<typename AI>
inline AI* GetOldHillsbradAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, OHScriptName);
}


#endif
