/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_SHADOWWORDPAIN                                   = 10894,
    SPELL_MANABURN                                         = 10876,
    SPELL_PSYCHICSCREAM                                    = 8122,
    SPELL_SHADOWSHIELD                                     = 22417
};

enum Events
{
    EVENT_SHADOW_WORD_PAIN                                 = 1,
    EVENT_MANABURN                                         = 2,
    EVENT_PSYCHIC_SCREAM                                   = 3,
    EVENT_SHADOWSHIELD                                     = 4
};

class boss_high_interrogator_gerstahn : public CreatureScript
{
    public:
        boss_high_interrogator_gerstahn() : CreatureScript("boss_high_interrogator_gerstahn") { }

        struct boss_high_interrogator_gerstahnAI : public ScriptedAI
        {
            boss_high_interrogator_gerstahnAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset() override
            {
                _events.Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 4000);
                _events.ScheduleEvent(EVENT_MANABURN, 14000);
                _events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, 32000);
                _events.ScheduleEvent(EVENT_SHADOWSHIELD, 8000);
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SHADOW_WORD_PAIN:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                                DoCast(target, SPELL_SHADOWWORDPAIN);
                            _events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 7000);
                            break;
                        case EVENT_PSYCHIC_SCREAM:
                            DoCastVictim(SPELL_PSYCHICSCREAM);
                            _events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, 30000);
                            break;
                        case EVENT_MANABURN:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                                DoCast(target, SPELL_MANABURN);
                            _events.ScheduleEvent(EVENT_MANABURN, 10000);
                            break;
                        case EVENT_SHADOWSHIELD:
                            DoCast(me, SPELL_SHADOWSHIELD);
                            _events.ScheduleEvent(EVENT_SHADOWSHIELD, 25000);
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new boss_high_interrogator_gerstahnAI(creature);
        }
};

void AddSC_boss_high_interrogator_gerstahn()
{
    new boss_high_interrogator_gerstahn();
}
