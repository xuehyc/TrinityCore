/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_ZULAMAN_H
#define DEF_ZULAMAN_H

#include "CreatureAIImpl.h"

uint32 const EncounterCount = 6;
#define ZulAmanScriptName "instance_zulaman"
#define DataHeader "ZA"

enum ZADataTypes
{
    // BossState
    DATA_AKILZON                = 0,
    DATA_NALORAKK               = 1,
    DATA_JANALAI                = 2,
    DATA_HALAZZI                = 3,
    DATA_HEXLORD                = 4,
    DATA_DAAKARA                = 5,

    // Data64
    DATA_HEXLORD_TRIGGER,

    DATA_STRANGE_GONG,
    DATA_MASSIVE_GATE,

    // SetData
    DATA_ZULAMAN_STATE
};

enum ZACreatureIds
{
    NPC_AKILZON                 = 23574,
    NPC_NALORAKK                = 23576,
    NPC_JANALAI                 = 23578,
    NPC_HALAZZI                 = 23577,
    NPC_HEXLORD                 = 24239,
    NPC_DAAKARA                 = 23863,

    NPC_VOLJIN                  = 52924,
    NPC_HEXLORD_TRIGGER         = 24363
};

enum ZAGameObjectIds
{
    GO_STRANGE_GONG             = 187359,
    GO_MASSIVE_GATE             = 186728,
};

enum ZAEvents
{
    EVENT_START_ZULAMAN         = 15897,
    EVENT_UPDATE_ZULAMAN_TIMER  = 1,
};

enum ZAAction
{
    ACTION_START_ZULAMAN        = 1
};

enum ZAWorldStates
{
    WORLD_STATE_ZULAMAN_TIMER_ENABLED   = 3104,
    WORLD_STATE_ZULAMAN_TIMER           = 3106,
};

template<typename AI>
CreatureAI* GetZulAmanAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, ZulAmanScriptName);
}

#endif
