/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scarlet_monastery.h"

enum Yells
{
    SAY_AGGRO                       = 0,
};

enum Spells
{
    SPELL_SUMMONSCARLETHOUND        = 17164,
    SPELL_BLOODLUST                 = 6742
};

enum Events
{
    EVENT_BLOODLUST                 = 1
};

class boss_houndmaster_loksey : public CreatureScript
{
    public:
        boss_houndmaster_loksey() : CreatureScript("boss_houndmaster_loksey") { }

        struct boss_houndmaster_lokseyAI : public BossAI
        {
            boss_houndmaster_lokseyAI(Creature* creature) : BossAI(creature, DATA_HOUNDMASTER_LOKSEY) { }

            void Reset() override
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                Talk(SAY_AGGRO);
                _EnterCombat();
                events.ScheduleEvent(EVENT_BLOODLUST, 20000);
            }

            void JustDied(Unit* /*killer*/) override
            {
                _JustDied();
            }

            void ExecuteEvent(uint32 eventId) override
            {
                switch (eventId)
                {
                    case EVENT_BLOODLUST:
                        DoCast(me, SPELL_BLOODLUST);
                        events.ScheduleEvent(EVENT_BLOODLUST, 20000);
                        break;
                    default:
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetScarletMonasteryAI<boss_houndmaster_lokseyAI>(creature);
        }
};

void AddSC_boss_houndmaster_loksey()
{
    new boss_houndmaster_loksey();
}
