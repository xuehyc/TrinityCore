/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "gundrak.h"
#include "ScriptedCreature.h"

enum Texts
{
    EMOTE_SPAWN                 = 0
};

enum Spells
{
    SPELL_ECK_BERSERK           = 55816, // Eck goes berserk, increasing his attack speed by 150% and all damage he deals by 500%.
    SPELL_ECK_BITE              = 55813, // Eck bites down hard, inflicting 150% of his normal damage to an enemy.
    SPELL_ECK_SPIT              = 55814, // Eck spits toxic bile at enemies in a cone in front of him, inflicting 2970 Nature damage and draining 220 mana every 1 sec for 3 sec.
    SPELL_ECK_SPRING_1          = 55815, // Eck leaps at a distant target.  --> Drops aggro and charges a random player. Tank can simply taunt him back.
    SPELL_ECK_SPRING_2          = 55837  // Eck leaps at a distant target.
};

enum Events
{
    EVENT_BITE = 1,
    EVENT_SPIT,
    EVENT_SPRING,
    EVENT_BERSERK
};

class boss_eck : public CreatureScript
{
    public:
        boss_eck() : CreatureScript("boss_eck") { }

        struct boss_eckAI : public BossAI
        {
            boss_eckAI(Creature* creature) : BossAI(creature, DATA_ECK_THE_FEROCIOUS)
            {
                Initialize();
                Talk(EMOTE_SPAWN);
            }

            void Initialize()
            {
                _berserk = false;
            }

            void Reset() override
            {
                _Reset();
                Initialize();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_BITE, 5 * IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_SPIT, 10 * IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_SPRING, 8 * IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_BERSERK, urand(60 * IN_MILLISECONDS, 90 * IN_MILLISECONDS)); // 60-90 secs according to wowwiki
            }

            void DamageTaken(Unit* /*attacker*/, uint32& damage) override
            {
                if (!_berserk && me->HealthBelowPctDamaged(20, damage))
                {
                    events.RescheduleEvent(EVENT_BERSERK, 1000);
                    _berserk = true;
                }
            }

            void ExecuteEvent(uint32 eventId) override
            {
                switch (eventId)
                {
                    case EVENT_BITE:
                        DoCastVictim(SPELL_ECK_BITE);
                        events.ScheduleEvent(EVENT_BITE, urand(8 * IN_MILLISECONDS, 12 * IN_MILLISECONDS));
                        break;
                    case EVENT_SPIT:
                        DoCastVictim(SPELL_ECK_SPIT);
                        events.ScheduleEvent(EVENT_SPIT, urand(6 * IN_MILLISECONDS, 14 * IN_MILLISECONDS));
                        break;
                    case EVENT_SPRING:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 35.0f, true))
                            DoCast(target, RAND(SPELL_ECK_SPRING_1, SPELL_ECK_SPRING_2));
                        events.ScheduleEvent(EVENT_SPRING, urand(5 * IN_MILLISECONDS, 10 * IN_MILLISECONDS));
                        break;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_ECK_BERSERK);
                        _berserk = true;
                        break;
                    default:
                        break;
                }
            }

        private:
            bool _berserk;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetGundrakAI<boss_eckAI>(creature);
        }
};

void AddSC_boss_eck()
{
    new boss_eck();
}
