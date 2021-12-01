/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scarlet_monastery.h"

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_SPECIALAE               = 1
};

enum Spells
{
    SPELL_SILENCE               = 8988,
    SPELL_ARCANE_EXPLOSION      = 9433,
    SPELL_DETONATION            = 9435,
    SPELL_ARCANE_BUBBLE         = 9438,
    SPELL_POLYMORPH             = 13323
};

enum Events
{
    EVENT_SILENCE               = 1,
    EVENT_ARCANE_EXPLOSION      = 2,
    EVENT_ARCANE_BUBBLE         = 3,
    EVENT_POLYMORPH             = 4
};

class boss_arcanist_doan : public CreatureScript
{
    public:
        boss_arcanist_doan() : CreatureScript("boss_arcanist_doan") { }

        struct boss_arcanist_doanAI : public BossAI
        {
            boss_arcanist_doanAI(Creature* creature) : BossAI(creature, DATA_ARCANIST_DOAN)
            {
                _healthAbove50Pct = true;
            }

            void Reset() override
            {
                _Reset();
                _healthAbove50Pct = true;
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_SILENCE,         15 * IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, 3 * IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_POLYMORPH,       30 * IN_MILLISECONDS);
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
                        case EVENT_SILENCE:
                            DoCastVictim(SPELL_SILENCE);
                            events.ScheduleEvent(EVENT_SILENCE, urand(15, 20) * IN_MILLISECONDS);
                            break;
                        case EVENT_ARCANE_EXPLOSION:
                            DoCastVictim(SPELL_ARCANE_EXPLOSION);
                            events.ScheduleEvent(EVENT_SILENCE, 8 * IN_MILLISECONDS);
                            break;
                        case EVENT_POLYMORPH:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 30.0f, true))
                                DoCast(target, SPELL_POLYMORPH);
                            events.ScheduleEvent(EVENT_POLYMORPH, 20 * IN_MILLISECONDS);
                            break;
                        default:
                            break;
                    }

                    if (me->HasUnitState(UNIT_STATE_CASTING))
                        return;
                }

                if (_healthAbove50Pct && HealthBelowPct(50))
                {
                    _healthAbove50Pct = false;
                    Talk(SAY_SPECIALAE);
                    DoCast(me, SPELL_ARCANE_BUBBLE);
                    DoCastAOE(SPELL_DETONATION);
                }

                DoMeleeAttackIfReady();
            }

        private:
            bool _healthAbove50Pct;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetScarletMonasteryAI<boss_arcanist_doanAI>(creature);
        }
};

void AddSC_boss_arcanist_doan()
{
    new boss_arcanist_doan();
}
