/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
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

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_SUMMON_WORM           = 25832,
    SPELL_MORTAL_WOUND          = 25646,
    SPELL_ENRAGE                = 28798,
};

const uint32 SPELL_ENTANGLE[]   = {720, 731, 1121};

enum Events
{
    EVENT_MORTAL_WOUND          = 1,
    EVENT_SPAWN_HATCHLING       = 2,
    EVENT_SPAWN_WORM            = 3,
    EVENT_HATCHLING_TIMER       = 4,
};

class boss_fankriss : public CreatureScript
{
    public:
        boss_fankriss() : CreatureScript("boss_fankriss") { }

        struct boss_fankrissAI : public BossAI
        {
            boss_fankrissAI(Creature* creature) : BossAI(creature, BOSS_FANKRISS) { }

            void Reset()
            {
                BossAI::Reset();
                summonCount = 0;
                events.ScheduleEvent(EVENT_MORTAL_WOUND, urand(10000, 15000));
                events.ScheduleEvent(EVENT_SPAWN_HATCHLING, 12000);
                events.ScheduleEvent(EVENT_SPAWN_WORM, urand(30000, 45000));
            }

            void EnterCombat(Unit* victim)
            {
                BossAI::EnterCombat(victim);
            }

            void SpawnHatchling(Unit* target, uint8 number)
            {
                if (!target)
                    return;
                Position pos;
                // Reset aggro, but dont get target out of combat
                if (DoGetThreat(target))
                    DoModifyThreatPercent(target, -99);
                // Three spells - three different teleport locations
                DoCast(target, SPELL_ENTANGLE[number]);
                target->GetPosition(&pos);
                // Spawn 4 Hatchlings
                for (uint8 i = 0; i < 4; ++i)
                    DoSummon(NPC_VEKNISS_HATCHLING, pos, 90000, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN);
            }
                            
            void UpdateAI(const uint32 diff)
            {
                //Return since we have no target
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_MORTAL_WOUND:
                            DoCastVictim(SPELL_MORTAL_WOUND);
                            events.ScheduleEvent(EVENT_MORTAL_WOUND, urand(10000, 15000));
                            break;
                        case EVENT_SPAWN_HATCHLING:
                            summonCount = urand(0,2);
                            events.ScheduleEvent(EVENT_HATCHLING_TIMER, 500);
                            events.ScheduleEvent(EVENT_SPAWN_HATCHLING, urand(45000, 60000));
                            break;
                        case EVENT_HATCHLING_TIMER:
                            if (summonCount >= 0)
                                SpawnHatchling(SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true), summonCount);
                            summonCount--;
                            events.ScheduleEvent(EVENT_HATCHLING_TIMER, 1500);
                            break;
                        case EVENT_SPAWN_WORM:
                            // Spawn 1-3 worms
                            for (uint8 j = 0; j < urand(1,3); j++)
                                DoCast(me, SPELL_SUMMON_WORM, true);
                            events.ScheduleEvent(EVENT_SPAWN_WORM, urand(30000, 45000));
                            break;
                        default:
                            break;
                    }
                }
 
                DoMeleeAttackIfReady();
            }
            private:
                int8 summonCount;
                EventMap events;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_fankrissAI (pCreature);
        }
};


void AddSC_boss_fankriss()
{
    new boss_fankriss();
}
