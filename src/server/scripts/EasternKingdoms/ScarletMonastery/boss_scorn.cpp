/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scarlet_monastery.h"

enum Spells
{
    SPELL_LICHSLAP                  = 28873,
    SPELL_FROSTBOLT_VOLLEY          = 8398,
    SPELL_MINDFLAY                  = 17313,
    SPELL_FROSTNOVA                 = 15531
};

enum Events
{
    EVENT_LICH_SLAP                 = 1,
    EVENT_FROSTBOLT_VOLLEY,
    EVENT_MIND_FLAY,
    EVENT_FROST_NOVA
};

class boss_scorn : public CreatureScript
{
    public:
        boss_scorn() : CreatureScript("boss_scorn") { }

        struct boss_scornAI : public BossAI
        {
            boss_scornAI(Creature* creature) : BossAI(creature, DATA_SCORN) { }

            void Reset() override
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_LICH_SLAP, 45000);
                events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, 30000);
                events.ScheduleEvent(EVENT_MIND_FLAY, 30000);
                events.ScheduleEvent(EVENT_FROST_NOVA, 30000);
            }

            void JustDied(Unit* /*killer*/) override
            {
                _JustDied();
            }

            void ExecuteEvent(uint32 eventId) override
            {
                switch (eventId)
                {
                    case EVENT_LICH_SLAP:
                        DoCastVictim(SPELL_LICHSLAP);
                        events.ScheduleEvent(EVENT_LICH_SLAP, 45000);
                        break;
                    case EVENT_FROSTBOLT_VOLLEY:
                        DoCastVictim(SPELL_FROSTBOLT_VOLLEY);
                        events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, 20000);
                        break;
                    case EVENT_MIND_FLAY:
                        DoCastVictim(SPELL_MINDFLAY);
                        events.ScheduleEvent(EVENT_MIND_FLAY, 20000);
                        break;
                    case EVENT_FROST_NOVA:
                        DoCastVictim(SPELL_FROSTNOVA);
                        events.ScheduleEvent(EVENT_FROST_NOVA, 15000);
                        break;
                    default:
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetScarletMonasteryAI<boss_scornAI>(creature);
        }
};

void AddSC_boss_scorn()
{
    new boss_scorn();
}
