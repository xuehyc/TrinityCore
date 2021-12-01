/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_RAZORFEN_KRAUL_H
#define DEF_RAZORFEN_KRAUL_H

#include "CreatureAIImpl.h"

#define RFKScriptName "instance_razorfen_kraul"
#define DataHeader "RFK"

#define EVENT_WARD_KEEPER 1

template<typename AI>
inline AI* GetRazorfenKraulAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, RFKScriptName);
}

#endif
