/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptPCH.h"
#include "vault_of_archavon.h"

enum Events
{
    EVENT_NONE,

    // Koralon
    EVENT_BURNING_BREATH,
    EVENT_FLAME_CINDER,
    EVENT_METEOR_FISTS,

    // Flame Warder
    EVENT_FW_LAVA_BURST,
    EVENT_FW_METEOR_FISTS,
};

enum Spells
{
    // Spells Koralon
    SPELL_BURNING_BREATH                        = 66670,
    SPELL_BURNING_BREATH_H                      = 67329,
    SPELL_BURNING_FURY_REPEAT                   = 66895,
    SPELL_FLAME_CINDER                          = 66684,
    SPELL_FLAME_CINDER_H                        = 67332,
    SPELL_METEOR_FISTS_VISUAL                   = 66725,
    SPELL_METEOR_FISTS_VISUAL_H                 = 68161,
    SPELL_METEOR_FISTS                          = 66809,
    SPELL_METEOR_FISTS_H                        = 67331,

    // Spells Flame Warder
    SPELL_FW_METEOR_FISTS_VISUAL                = 66808,
    SPELL_FW_METEOR_FISTS_VISUAL_H              = 68160,
    SPELL_FW_METEOR_FISTS                       = 66765,
    SPELL_FW_METEOR_FISTS_H                     = 67333,
    SPELL_FW_LAVA_BURST                         = 66813,
    SPELL_FW_LAVA_BURST_H                       = 67330,
};

class boss_koralon : public CreatureScript
{
    public:
        boss_koralon() : CreatureScript("boss_koralon") { }

        struct boss_koralonAI : public BossAI
        {
            boss_koralonAI(Creature* creature) : BossAI(creature, DATA_KORALON)
            {
            }

            uint8 breathCount;

            void Reset()
            {
                breathCount = 0;
                _Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoCast(me, SPELL_BURNING_FURY_REPEAT);

                events.ScheduleEvent(EVENT_BURNING_BREATH, 15000);  // 1st after 15sec, then every 45sec
                events.ScheduleEvent(EVENT_METEOR_FISTS, 75000);  // 1st after 75sec, then every 45sec
                events.ScheduleEvent(EVENT_FLAME_CINDER, 30000);  // TODO check timer

                _EnterCombat();
            }

            void UpdateAI(const uint32 diff)
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
                        case EVENT_BURNING_BREATH:
                            DoCast(me->getVictim(), RAID_MODE(SPELL_BURNING_BREATH, SPELL_BURNING_BREATH_H));
                            breathCount++;
                            if (breathCount == 3)
                            {
                                breathCount = 0;
                                events.ScheduleEvent(EVENT_BURNING_BREATH, 45000);
                            }
                            else
                                events.ScheduleEvent(EVENT_BURNING_BREATH, 1000);
                            break;
                        case EVENT_METEOR_FISTS:
                            DoCast(me, SPELL_METEOR_FISTS_VISUAL);
                            events.ScheduleEvent(EVENT_METEOR_FISTS, 45000);
                            break;
                        case EVENT_FLAME_CINDER:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, RAID_MODE(SPELL_FLAME_CINDER, SPELL_FLAME_CINDER_H));
                            events.ScheduleEvent(EVENT_FLAME_CINDER, 30000);
                            break;
                    }
                }

                // Meele check for Meteor Fists, if has visual aura and mainhand equipped
                if(me->HasAura(RAID_MODE(SPELL_METEOR_FISTS_VISUAL, SPELL_METEOR_FISTS_VISUAL_H)))
                    if (me->isAttackReady())
                        if (me->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0))
                            if (me->IsWithinMeleeRange(me->getVictim()))
                                DoCast(me->getVictim(), RAID_MODE(SPELL_METEOR_FISTS, SPELL_METEOR_FISTS_H));

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_koralonAI(creature);
        }
};

/*######
##  Mob Flame Warder
######*/
class mob_flame_warder : public CreatureScript
{
    public:
        mob_flame_warder() : CreatureScript("mob_flame_warder") { }

        struct mob_flame_warderAI : public ScriptedAI
        {
            mob_flame_warderAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                events.Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoZoneInCombat();

                events.ScheduleEvent(EVENT_FW_LAVA_BURST, 5000);
                events.ScheduleEvent(EVENT_FW_METEOR_FISTS, 10000);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_FW_LAVA_BURST:
                            DoCastVictim(SPELL_FW_LAVA_BURST);
                            events.ScheduleEvent(EVENT_FW_LAVA_BURST, 15000);
                            break;
                        case EVENT_FW_METEOR_FISTS:
                            DoCast(me, SPELL_METEOR_FISTS_VISUAL);
                            events.ScheduleEvent(EVENT_FW_METEOR_FISTS, 20000);
                            break;
                    }
                }

                // Meele check for Meteor Fists, if has visual aura and mainhand equipped
                if(me->HasAura(RAID_MODE(SPELL_FW_METEOR_FISTS_VISUAL, SPELL_FW_METEOR_FISTS_VISUAL_H)))
                    if (me->isAttackReady())
                        if (me->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0))
                            if (me->IsWithinMeleeRange(me->getVictim()))
                                DoCast(me->getVictim(), RAID_MODE(SPELL_FW_METEOR_FISTS, SPELL_FW_METEOR_FISTS_H));

                DoMeleeAttackIfReady();
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_flame_warderAI(creature);
        }
};

void AddSC_boss_koralon()
{
    new boss_koralon();
    new mob_flame_warder();
}
