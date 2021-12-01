/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scarlet_monastery.h"

enum Yells
{
    SAY_AGGRO               = 0,
    SAY_HEALTH              = 1,
    SAY_KILL                = 2
};

enum Spells
{
    SPELL_FLAMESHOCK        = 8053,
    SPELL_SHADOWBOLT        = 1106,
    SPELL_FLAMESPIKE        = 8814,
    SPELL_FIRENOVA          = 16079
};

enum Events
{
    EVENT_FLAME_SHOCK       = 1,
    EVENT_SHADOW_BOLT,
    EVENT_FLAME_SPIKE,
    EVENT_FIRE_NOVA
};

class boss_bloodmage_thalnos : public CreatureScript
{
    public:
        boss_bloodmage_thalnos() : CreatureScript("boss_bloodmage_thalnos") { }

        struct boss_bloodmage_thalnosAI : public BossAI
        {
            boss_bloodmage_thalnosAI(Creature* creature) : BossAI(creature, DATA_BLOODMAGE_THALNOS)
            {
                _hpYell = false;
            }

            void Reset() override
            {
                _hpYell = false;
                _Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                Talk(SAY_AGGRO);
                _EnterCombat();
                events.ScheduleEvent(EVENT_FLAME_SHOCK, 10000);
                events.ScheduleEvent(EVENT_SHADOW_BOLT, 2000);
                events.ScheduleEvent(EVENT_FLAME_SPIKE, 8000);
                events.ScheduleEvent(EVENT_FIRE_NOVA, 40000);
            }

            void JustDied(Unit* /*killer*/) override
            {
                _JustDied();
            }

            void KilledUnit(Unit* /*victim*/) override
            {
                Talk(SAY_KILL);
            }

            void DamageTaken(Unit* /*attacker*/, uint32& damage) override
            {
                if (!_hpYell && me->HealthBelowPctDamaged(35, damage))
                {
                    Talk(SAY_HEALTH);
                    _hpYell = true;
                }
            }

            void ExecuteEvent(uint32 eventId) override
            {
                switch (eventId)
                {
                    case EVENT_FLAME_SHOCK:
                        DoCastVictim(SPELL_FLAMESHOCK);
                        events.ScheduleEvent(EVENT_FLAME_SHOCK, urand(10000, 15000));
                        break;
                    case EVENT_SHADOW_BOLT:
                        DoCastVictim(SPELL_SHADOWBOLT);
                        events.ScheduleEvent(EVENT_SHADOW_BOLT, 2000);
                        break;
                    case EVENT_FLAME_SPIKE:
                        DoCastVictim(SPELL_FLAMESPIKE);
                        events.ScheduleEvent(EVENT_FLAME_SPIKE, 30000);
                        break;
                    case EVENT_FIRE_NOVA:
                        DoCastVictim(SPELL_FIRENOVA);
                        events.ScheduleEvent(EVENT_FIRE_NOVA, 40000);
                        break;
                    default:
                        break;
                }
            }

            private:
                bool _hpYell;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetScarletMonasteryAI<boss_bloodmage_thalnosAI>(creature);
        }
};

void AddSC_boss_bloodmage_thalnos()
{
    new boss_bloodmage_thalnos();
}
