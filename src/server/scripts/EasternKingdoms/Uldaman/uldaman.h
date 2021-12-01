/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_ULDAMAN_H
#define DEF_ULDAMAN_H

#include "CreatureAIImpl.h"

#define UldamanScriptName "instance_uldaman"
#define DataHeader "UD"

#define MAX_ENCOUNTER                   3

enum UDDataTypes
{
    DATA_ALTAR_DOORS                    = 1,
    DATA_ANCIENT_DOOR                   = 2,
    DATA_IRONAYA_DOOR                   = 3,
    DATA_STONE_KEEPERS                  = 4,
    DATA_MINIONS                        = 5,
    DATA_IRONAYA_SEAL                   = 6,
};

enum UDGameObjectIds
{
    GO_ARCHAEDAS_TEMPLE_DOOR            = 141869,
    GO_ALTAR_OF_THE_KEEPER_TEMPLE_DOOR  = 124367,
    GO_ANCIENT_VAULT_DOOR               = 124369,
    GO_IRONAYA_SEAL_DOOR                = 124372,
    GO_KEYSTONE                         = 124371,
};

template<typename AI>
inline AI* GetUldamanAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, UldamanScriptName);
}

#endif
