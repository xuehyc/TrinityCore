/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_caverns.h"

enum Text
{
    YELL_AGGRO                     = 0,
    YELL_KILL                      = 1,
    YELL_EVOLVED_ZEALOT            = 2,
    YELL_DEATH                     = 3,
    EMOTE_EVOLVED_ZEALOT           = 4
};

enum Spells
{
    SPELL_EVOLUTION                = 75610,
    SPELL_DRAIN_ESSENSE            = 75645,
    SPELL_SHADOW_POWER             = 35322,
    H_SPELL_SHADOW_POWER           = 39193
};

enum Events
{
    // Out of combat events
    EVENT_DRAIN_ESSENSE            = 1,
    EVENT_STOP_DRAIN_ESSENSE       = 2,
    EVENT_EVOLUTION                = 3
    // Combat events
};

class boss_corla : public CreatureScript
{
    public:
        boss_corla(): CreatureScript("boss_corla") { }

        struct boss_corlaAI : public BossAI
        {
            boss_corlaAI(Creature* creature) : BossAI(creature, DATA_CORLA) { }

            void Reset() override
            {
                _Reset();
                combatPhase = false;
                events.ScheduleEvent(EVENT_DRAIN_ESSENSE, 2000);
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                Talk(YELL_AGGRO);
                events.Reset();
                combatPhase = true;
            }

            void KilledUnit(Unit* who) override
            {
                if (who->GetTypeId() == TYPEID_PLAYER)
                    Talk(YELL_KILL);
            }

            void JustDied(Unit* /*killer*/) override
            {
                _JustDied();
                Talk(YELL_DEATH);
            }

            void UpdateAI(uint32 diff) override
            {
                events.Update(diff);

                if (!combatPhase)
                {
                    while (uint32 eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case EVENT_DRAIN_ESSENSE:
                                DoCast(me, SPELL_DRAIN_ESSENSE);
                                events.ScheduleEvent(EVENT_STOP_DRAIN_ESSENSE, 15000);
                                break;
                            case EVENT_STOP_DRAIN_ESSENSE:
                                me->InterruptSpell(CURRENT_CHANNELED_SPELL);
                                events.ScheduleEvent(EVENT_EVOLUTION, 2000);
                                break;
                            case EVENT_EVOLUTION:
                                DoCast(me, SPELL_EVOLUTION);
                                events.ScheduleEvent(EVENT_DRAIN_ESSENSE, 2000);
                                break;
                            default:
                                break;
                        }
                    }
                    return;
                }

                DoMeleeAttackIfReady();
            }

        private:
            bool combatPhase = false;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetBlackrockCavernsAI<boss_corlaAI>(creature);
        }
};

void AddSC_boss_corla()
{
    new boss_corla();
}
