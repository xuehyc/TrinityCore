/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef THE_STOCKADE_H
#define THE_STOCKADE_H

#include "CreatureAIImpl.h"

#define StormwindStockadeScriptName "instance_the_stockade"
#define DataHeader "SS"

uint32 const EncounterCount = 3;

enum SSDataTypes
{
    DATA_RANDOLPH_MOLOCH = 0,
    DATA_LORD_OVERHEAT   = 1,
    DATA_HOGGER          = 2
};

enum SSCreatureIds
{
    NPC_RANDOLPH_MOLOCH  = 46383,
    NPC_LORD_OVERHEAT    = 46264,
    NPC_HOGGER           = 46254,
    NPC_WARDEN_THELWATER = 46409,
    NPC_MORTIMER_MOLOCH  = 46482
};

template<typename AI>
inline AI* GetStormwindStockadeAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, StormwindStockadeScriptName);
}

#endif
