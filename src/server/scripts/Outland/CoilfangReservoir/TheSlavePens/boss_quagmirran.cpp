/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/* ScriptData
SDName: boss_quagmirran
SD%Complete: 100%
SDComment:
SDCategory: Coilfang Reservoir, The Slave Pens
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_slave_pens.h"

enum Spells
{
    SPELL_ACID_SPRAY                = 38153,
    SPELL_CLEAVE                    = 40504,
    SPELL_UPPERCUT                  = 32055,
    SPELL_POISON_BOLT_VOLLEY        = 34780 // 39340
};

enum Events
{
    EVENT_ACID_SPRAY                = 1,
    EVENT_CLEAVE                    = 2,
    EVENT_UPPERCUT                  = 3,
    EVENT_POISON_BOLT_VOLLEY        = 4
};

class boss_quagmirran : public CreatureScript
{
    public:
        boss_quagmirran() : CreatureScript("boss_quagmirran") { }

        struct boss_quagmirranAI : public BossAI
        {
            boss_quagmirranAI(Creature* creature) : BossAI(creature, DATA_QUAGMIRRAN) { }

            void Reset() override
            {
                _Reset();
            }

            void JustDied(Unit* /*killer*/) override
            {
                _JustDied();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_ACID_SPRAY, 25000);
                events.ScheduleEvent(EVENT_CLEAVE, 9000);
                events.ScheduleEvent(EVENT_UPPERCUT, 20000);
                events.ScheduleEvent(EVENT_POISON_BOLT_VOLLEY, 31000);
            }

            void KilledUnit(Unit* /*victim*/) override { }

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
                        case EVENT_ACID_SPRAY:
                            DoCastAOE(SPELL_ACID_SPRAY);
                            events.ScheduleEvent(EVENT_ACID_SPRAY, urand(20000, 25000));
                            break;
                        case EVENT_CLEAVE:
                            DoCastVictim(SPELL_CLEAVE, true);
                            events.ScheduleEvent(EVENT_CLEAVE, urand(18000, 34000));
                            break;
                        case EVENT_UPPERCUT:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 10.0f, true))
                            DoCast(target, SPELL_UPPERCUT);
                            events.ScheduleEvent(EVENT_UPPERCUT, 22000);
                            break;
                        case EVENT_POISON_BOLT_VOLLEY:
                            DoCast(me, SPELL_POISON_BOLT_VOLLEY);
                            events.ScheduleEvent(EVENT_POISON_BOLT_VOLLEY, 24000);
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
            return GetSlavePensAI<boss_quagmirranAI>(creature);
        }
};

void AddSC_boss_quagmirran()
{
    new boss_quagmirran();
}
