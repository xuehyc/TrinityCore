/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SCARLET_M_
#define SCARLET_M_

#include "CreatureAIImpl.h"

#define SMScriptName "instance_scarlet_monastery"
#define DataHeader "SM"

uint32 const EncounterCount = 10;

enum SMDataTypes
{
    DATA_MOGRAINE_AND_WHITE_EVENT   = 1,
    DATA_MOGRAINE                   = 2,
    DATA_WHITEMANE                  = 3,

    DATA_HORSEMAN_EVENT             = 4,
    DATA_PUMPKIN_SHRINE             = 5,

    DATA_VORREL                     = 6,
    DATA_ARCANIST_DOAN              = 7,
    DATA_AZSHIR                     = 8,
    DATA_BLOODMAGE_THALNOS          = 9,
    DATA_HEROD                      = 10,
    DATA_HIGH_INQUISITOR_FAIRBANKS  = 11,
    DATA_HOUNDMASTER_LOKSEY         = 12,
    DATA_INTERROGATOR_VISHAS        = 13,
    DATA_SCORN                      = 14
};

enum SMCreatureIds
{
    NPC_MOGRAINE                    = 3976,
    NPC_WHITEMANE                   = 3977,
    NPC_VORREL                      = 3981,

    NPC_HORSEMAN                    = 23682,
    NPC_HEAD                        = 23775,
    NPC_PUMPKIN                     = 23694
};

enum SMGameObjectIds
{
    GO_HIGH_INQUISITORS_DOOR        = 104600,
    GO_PUMPKIN_SHRINE               = 186267
};

template<typename AI>
inline AI* GetScarletMonasteryAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, SMScriptName);
}

#endif // SCARLET_M_
