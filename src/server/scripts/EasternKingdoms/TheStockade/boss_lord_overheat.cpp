/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_stockade.h"

enum Spells
{
    SPELL_FIREBALL           = 12466, //starts 1-2 secs from pull
    SPELL_OVERHEAT           = 86633, //probably cast every 10 secs, need to confirm.
    SPELL_RAIN_OF_FIRE       = 86636  //probably cast every 10 secs, need to confirm
};

enum Events
{
    EVENT_OVERHEAT = 1,
    EVENT_RAIN_OF_FIRE,
    EVENT_FIREBALL
};

enum Says
{
    SAY_PULL  = 0, //Yell: ALL MUST BURN!
    SAY_DEATH = 1  //Yell: FIRE... EXTINGUISHED!
};

class boss_lord_overheat : public CreatureScript
{
public:
    boss_lord_overheat() : CreatureScript("boss_lord_overheat") {}

    struct boss_lord_overheatAI : public BossAI
    {
        boss_lord_overheatAI(Creature* creature) : BossAI(creature, DATA_LORD_OVERHEAT) { }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_PULL);
            events.ScheduleEvent(EVENT_FIREBALL, Seconds(2));
            events.ScheduleEvent(EVENT_OVERHEAT, Seconds(9), Seconds(11));
            events.ScheduleEvent(EVENT_RAIN_OF_FIRE, Seconds(10), Seconds(13));
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
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
                case EVENT_FIREBALL:
                    DoCastVictim(SPELL_FIREBALL);
                    events.Repeat(Seconds(2));
                    break;
                case EVENT_OVERHEAT:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                        DoCast(target, SPELL_OVERHEAT);
                    events.Repeat(Seconds(9), Seconds(10));
                    break;
                case EVENT_RAIN_OF_FIRE:
                    DoCastAOE(SPELL_RAIN_OF_FIRE);
                    events.Repeat(Seconds(15), Seconds(20));
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
        return GetStormwindStockadeAI<boss_lord_overheatAI>(creature);
    }
};

void AddSC_boss_lord_overheat()
{
    new boss_lord_overheat();
}
