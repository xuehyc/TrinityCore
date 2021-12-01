/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "blackfathom_deeps.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_MIND_BLAST    = 15587,
    SPELL_SLEEP         = 8399,
};

enum Texts
{
    SAY_AGGRO    = 0,
    SAY_SLEEP    = 1,
    SAY_DEATH    = 2
};

enum Events
{
    EVENT_MIND_BLAST = 1,
    EVENT_SLEEP
};

class boss_kelris : public CreatureScript
{
public:
    boss_kelris() : CreatureScript("boss_kelris") { }

    struct boss_kelrisAI : public BossAI
    {
        boss_kelrisAI(Creature* creature) : BossAI(creature, DATA_KELRIS) { }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_MIND_BLAST, urand(2000, 5000));
            events.ScheduleEvent(EVENT_SLEEP, urand(9000, 12000));
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            _JustDied();
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
                    case EVENT_MIND_BLAST:
                        DoCastVictim(SPELL_MIND_BLAST);
                        events.ScheduleEvent(EVENT_MIND_BLAST, urand(7000, 9000));
                        break;
                    case EVENT_SLEEP:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        {
                            Talk(SAY_SLEEP);
                            DoCast(target, SPELL_SLEEP);
                        }
                        events.ScheduleEvent(EVENT_SLEEP, urand(15000, 20000));
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
        return GetBlackfathomDeepsAI<boss_kelrisAI>(creature);
    }
};

void AddSC_boss_kelris()
{
    new boss_kelris();
}
