/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_caverns.h"

enum Text
{
    YELL_AGGRO                          = 0,
    YELL_KILL                           = 1,
    YELL_QUICKSILVER_ARMOR              = 2,
    YELL_DEATH                          = 3,
    EMOTE_QUICKSILVER_ARMOR             = 4
};

enum Spells
{
    SPELL_CLEAVE                        = 15284,
    SPELL_QUICKSILVER_ARMOR             = 75842,
    SPELL_SUPERHEATED_QUICKSILVER_ARMOR = 75846
};

enum Events
{
    EVENT_CLEAVE                        = 1,
    EVENT_QUICKSILVER_ARMOR             = 2,
    EVENT_SUPERHEATED_QUICKSILVER_ARMOR = 3
};

class boss_karsh_steelbender : public CreatureScript
{
    public:
        boss_karsh_steelbender() : CreatureScript("boss_karsh_steelbender") { }

        struct boss_karsh_steelbenderAI : public BossAI
        {
            boss_karsh_steelbenderAI(Creature* creature) : BossAI(creature, DATA_KARSH_STEELBENDER) { }

            void Reset() override
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                Talk(YELL_AGGRO);
                events.ScheduleEvent(EVENT_CLEAVE, 10000);
            }

            void KilledUnit(Unit* who) override
            {
                if (who->GetTypeId() == TYPEID_PLAYER)
                    Talk(YELL_KILL);
            }

            void JustDied(Unit* /*victim*/) override
            {
                _JustDied();
                Talk(YELL_DEATH);
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
                        case EVENT_CLEAVE:
                            DoCastVictim(SPELL_CLEAVE);
                            events.ScheduleEvent(EVENT_CLEAVE, 10000);
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetBlackrockCavernsAI<boss_karsh_steelbenderAI>(creature);
        }
};

void AddSC_boss_karsh_steelbender()
{
    new boss_karsh_steelbender();
}
