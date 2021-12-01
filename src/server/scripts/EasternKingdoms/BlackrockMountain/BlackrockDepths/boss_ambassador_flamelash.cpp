/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_FIREBLAST                                        = 15573
};

enum Events
{
    EVENT_FIREBLAST                                        = 1,
    EVENT_SUMMON_SPIRITS                                   = 2
};

class boss_ambassador_flamelash : public CreatureScript
{
    public:
        boss_ambassador_flamelash() : CreatureScript("boss_ambassador_flamelash") { }

        struct boss_ambassador_flamelashAI : public ScriptedAI
        {
            boss_ambassador_flamelashAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset() override
            {
                _events.Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _events.ScheduleEvent(EVENT_FIREBLAST, 2000);
                _events.ScheduleEvent(EVENT_SUMMON_SPIRITS, 24000);
            }

            void SummonSpirit(Unit* victim)
            {
                if (Creature* spirit = DoSpawnCreature(9178, frand(-9, 9), frand(-9, 9), 0, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000))
                    spirit->AI()->AttackStart(victim);
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
                        case EVENT_FIREBLAST:
                            DoCastVictim(SPELL_FIREBLAST);
                            _events.ScheduleEvent(EVENT_FIREBLAST, 7000);
                            break;
                        case EVENT_SUMMON_SPIRITS:
                            for (uint32 i = 0; i < 4; ++i)
                                SummonSpirit(me->GetVictim());
                            _events.ScheduleEvent(EVENT_SUMMON_SPIRITS, 30000);
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
            return new boss_ambassador_flamelashAI(creature);
        }
};

void AddSC_boss_ambassador_flamelash()
{
    new boss_ambassador_flamelash();
}
