/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/*
Name: Boss_the_ravenian
%Complete: 100
Comment:
Category: Scholomance
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scholomance.h"

enum Spells
{
    SPELL_TRAMPLE                   = 15550,
    SPELL_CLEAVE                    = 20691,
    SPELL_SUNDERINCLEAVE            = 25174,
    SPELL_KNOCKAWAY                 = 10101
};

enum Events
{
    EVENT_TRAMPLE                   = 1,
    EVENT_CLEAVE                    = 2,
    EVENT_SUNDERINCLEAVE            = 3,
    EVENT_KNOCKAWAY                 = 4
};

class boss_the_ravenian : public CreatureScript
{
    public: boss_the_ravenian() : CreatureScript("boss_the_ravenian") { }

        struct boss_theravenianAI : public BossAI
        {
            boss_theravenianAI(Creature* creature) : BossAI(creature, DATA_THERAVENIAN) { }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_TRAMPLE, 24000);
                events.ScheduleEvent(EVENT_CLEAVE, 15000);
                events.ScheduleEvent(EVENT_SUNDERINCLEAVE, 40000);
                events.ScheduleEvent(EVENT_KNOCKAWAY, 32000);
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_TRAMPLE:
                            DoCastVictim(SPELL_TRAMPLE, true);
                            events.ScheduleEvent(EVENT_TRAMPLE, 10000);
                            break;
                        case EVENT_CLEAVE:
                            DoCastVictim(SPELL_CLEAVE, true);
                            events.ScheduleEvent(EVENT_CLEAVE, 7000);
                            break;
                        case EVENT_SUNDERINCLEAVE:
                            DoCastVictim(SPELL_SUNDERINCLEAVE, true);
                            events.ScheduleEvent(EVENT_SUNDERINCLEAVE, 20000);
                            break;
                        case EVENT_KNOCKAWAY:
                            DoCastVictim(SPELL_KNOCKAWAY, true);
                            events.ScheduleEvent(EVENT_KNOCKAWAY, 12000);
                            break;
                        default:
                            break;
                    }

                    if (me->HasUnitState(UNIT_STATE_CASTING))
                        return;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetScholomanceAI<boss_theravenianAI>(creature);
        }
};

void AddSC_boss_theravenian()
{
    new boss_the_ravenian();
}
