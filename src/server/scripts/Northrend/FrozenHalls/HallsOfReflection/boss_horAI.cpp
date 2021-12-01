/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "boss_horAI.h"
#include "halls_of_reflection.h"
#include "InstanceScript.h"

boss_horAI::boss_horAI(Creature* creature, uint32 bossId) : BossAI(creature, bossId)
{
}

void boss_horAI::Reset()
{
    _Reset();
    me->SetVisible(false);
    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
    me->SetReactState(REACT_PASSIVE);
    if (instance->GetData(DATA_WAVE_COUNT) != NOT_STARTED)
        instance->ProcessEvent(NULL, EVENT_DO_WIPE);
}

void boss_horAI::DoAction(int32 actionId)
{
    switch (actionId)
    {
        case ACTION_ENTER_COMBAT: // called by InstanceScript when boss shall enter in combat.
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
            me->SetReactState(REACT_AGGRESSIVE);
            DoZoneInCombat(me, 150.0f);
            break;
        default:
            break;
    }
}

void boss_horAI::JustSummoned(Creature* summon)
{
    summons.Summon(summon);
}
