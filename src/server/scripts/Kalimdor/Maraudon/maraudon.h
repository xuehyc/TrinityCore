/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef maraudon_h__
#define maraudon_h__

#include "CreatureAIImpl.h"

#define MaraudonScriptName "instance_maraudon"

template<typename AI>
inline AI* GetMaraudonAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, MaraudonScriptName);
}

#endif // maraudon_h__
