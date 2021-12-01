/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/*
Name: Boss_Doctor_Theolen_Krastinov
%Complete: 100
Comment:
Category: Scholomance
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scholomance.h"

enum Say
{
    EMOTE_FRENZY_KILL           = 0,
};

enum Spells
{
    SPELL_REND                  = 16509,
    SPELL_BACKHAND              = 18103,
    SPELL_FRENZY                = 8269
};

enum Events
{
    EVENT_REND                  = 1,
    EVENT_BACKHAND              = 2,
    EVENT_FRENZY                = 3
};

class boss_doctor_theolen_krastinov : public CreatureScript
{
    public: boss_doctor_theolen_krastinov() : CreatureScript("boss_doctor_theolen_krastinov") { }

        struct boss_theolenkrastinovAI : public BossAI
        {
            boss_theolenkrastinovAI(Creature* creature) : BossAI(creature, DATA_DOCTORTHEOLENKRASTINOV) { }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_REND, 8000);
                events.ScheduleEvent(EVENT_BACKHAND, 9000);
                events.ScheduleEvent(EVENT_FRENZY, 1000);
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
                        case EVENT_REND:
                            DoCastVictim(SPELL_REND, true);
                            events.ScheduleEvent(EVENT_REND, 10000);
                            break;
                        case EVENT_BACKHAND:
                            DoCastVictim(SPELL_BACKHAND, true);
                            events.ScheduleEvent(EVENT_BACKHAND, 10000);
                            break;
                        case EVENT_FRENZY:
                            DoCast(me, SPELL_FRENZY, true);
                            Talk(EMOTE_FRENZY_KILL);
                            events.ScheduleEvent(EVENT_FRENZY, 120000);
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
            return GetScholomanceAI<boss_theolenkrastinovAI>(creature);
        }

};

void AddSC_boss_theolenkrastinov()
{
    new boss_doctor_theolen_krastinov();
}
