/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_WAILING_CAVERNS_H
#define DEF_WAILING_CAVERNS_H

#include "CreatureAIImpl.h"

#define WCScriptName "instance_wailing_caverns"
#define DataHeader "WC"

enum WCDataTypes
{
    TYPE_LORD_COBRAHN         = 1,
    TYPE_LORD_PYTHAS          = 2,
    TYPE_LADY_ANACONDRA       = 3,
    TYPE_LORD_SERPENTIS       = 4,
    TYPE_NARALEX_EVENT        = 5,
    TYPE_NARALEX_PART1        = 6,
    TYPE_NARALEX_PART2        = 7,
    TYPE_NARALEX_PART3        = 8,
    TYPE_MUTANUS_THE_DEVOURER = 9,
    TYPE_NARALEX_YELLED       = 10,

    DATA_NARALEX              = 3679,
};

template<typename AI>
inline AI* GetWailingCavernsAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, WCScriptName);
}

#endif
