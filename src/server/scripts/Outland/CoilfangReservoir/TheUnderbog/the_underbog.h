/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef the_underbog_h__
#define the_underbog_h__

#include "CreatureAIImpl.h"

#define TheUndebogScriptName "instance_the_underbog"

template<typename AI>
inline AI* GetTheUnderbogAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, TheUndebogScriptName);
}

#endif // the_underbog_h__
