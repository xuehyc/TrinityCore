/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_MECHANAR_H
#define DEF_MECHANAR_H

#include "CreatureAIImpl.h"

#define MechanarScriptName "instance_mechanar"
#define DataHeader "MR"

uint32 const EncounterCount             = 5;

enum MRDataTypes
{
    DATA_GATEWATCHER_GYROKILL           = 0,
    DATA_GATEWATCHER_IRON_HAND          = 1,
    DATA_MECHANOLORD_CAPACITUS          = 2,
    DATA_NETHERMANCER_SEPRETHREA        = 3,
    DATA_PATHALEON_THE_CALCULATOR       = 4
};

enum MRGameobjectIds
{
    GO_DOOR_MOARG_1                     = 184632,
    GO_DOOR_MOARG_2                     = 184322,
    GO_DOOR_NETHERMANCER                = 184449
};

template<typename AI>
inline AI* GetMechanarAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, MechanarScriptName);
}

#endif
