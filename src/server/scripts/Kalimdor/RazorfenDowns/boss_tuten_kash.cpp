/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "razorfen_downs.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_THRASH             = 8876,
    SPELL_WEB_SPRAY          = 12252,
    SPELL_VIRULENT_POISON    = 12254,
    SPELL_CURSE_OF_TUTENKASH = 12255
};

enum Events
{
    EVENT_WEB_SPRAY          = 1,
    EVENT_CURSE_OF_TUTENKASH = 2
};

class boss_tuten_kash : public CreatureScript
{
public:
    boss_tuten_kash() : CreatureScript("boss_tuten_kash") { }

    struct boss_tuten_kashAI : public BossAI
    {
        boss_tuten_kashAI(Creature* creature) : BossAI(creature, DATA_TUTEN_KASH) { }

        void Reset() override
        {
            _Reset();
            if (!me->HasAura(SPELL_THRASH))
                DoCast(me, SPELL_THRASH);
            if (!me->HasAura(SPELL_VIRULENT_POISON))
                DoCast(me, SPELL_VIRULENT_POISON);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_WEB_SPRAY, urand(3000, 5000));
            events.ScheduleEvent(EVENT_CURSE_OF_TUTENKASH, urand(9000, 14000));
        }

        void JustDied(Unit* /*killer*/) override
        {
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
                    case EVENT_WEB_SPRAY:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, false))
                        {
                            if (!target->HasAura(SPELL_WEB_SPRAY))
                                DoCast(target, SPELL_WEB_SPRAY);
                        }
                        events.ScheduleEvent(EVENT_WEB_SPRAY, urand(6000, 8000));
                        break;
                    case EVENT_CURSE_OF_TUTENKASH:
                        DoCast(me, SPELL_CURSE_OF_TUTENKASH);
                        events.ScheduleEvent(EVENT_CURSE_OF_TUTENKASH, urand(15000, 25000));
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
        return GetRazorfenDownsAI<boss_tuten_kashAI>(creature);
    }
};

void AddSC_boss_tuten_kash()
{
    new boss_tuten_kash();
}
