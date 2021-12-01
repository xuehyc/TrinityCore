/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_SHADOWFANG_H
#define DEF_SHADOWFANG_H

#include "CreatureAIImpl.h"

#define SFKScriptName "instance_shadowfang_keep"
#define DataHeader "SK"

enum SKDataTypes
{
    TYPE_FREE_NPC               = 1,
    TYPE_RETHILGORE             = 2,
    TYPE_FENRUS                 = 3,
    TYPE_NANDOS                 = 4,
    BOSS_ARUGAL                 = 5,
    DATA_APOTHECARY_HUMMEL      = 6
};

template<typename AI, typename T>
inline AI* GetShadowfangKeepAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SFKScriptName);
}

#endif
