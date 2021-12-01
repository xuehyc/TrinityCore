/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "blackfathom_deeps.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_NET         = 6533
};

enum Events
{
    EVENT_THROW_NET   = 1
};

class boss_gelihast : public CreatureScript
{
public:
    boss_gelihast() : CreatureScript("boss_gelihast") { }

    struct boss_gelihastAI : public BossAI
    {
        boss_gelihastAI(Creature* creature) : BossAI(creature, DATA_GELIHAST) { }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_THROW_NET, urand(2000, 4000));
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                if (eventId == EVENT_THROW_NET)
                {
                    DoCastVictim(SPELL_NET);
                    events.ScheduleEvent(EVENT_THROW_NET, urand(4000, 7000));
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackfathomDeepsAI<boss_gelihastAI>(creature);
    }
};

void AddSC_boss_gelihast()
{
    new boss_gelihast();
}
