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
#include "gundrak.h"

enum Spells
{
    SPELL_ECK_BERSERK                             = 55816, //Eck goes berserk, increasing his attack speed by 150% and all damage he deals by 500%.
    SPELL_ECK_BITE                                = 55813, //Eck bites down hard, inflicting 150% of his normal damage to an enemy.
    SPELL_ECK_SPIT                                = 55814, //Eck spits toxic bile at enemies in a cone in front of him, inflicting 2970 Nature damage and draining 220 mana every 1 sec for 3 sec.
    SPELL_ECK_SPRING_1                            = 55815, //Eck leaps at a distant target.  --> Drops aggro and charges a random player. Tank can simply taunt him back.
    SPELL_ECK_SPRING_2                            = 55837  //Eck leaps at a distant target.
};

enum Events
{
    EVENT_ECK_BITE,
    EVENT_ECK_SPIT,
    EVENT_ECK_SPRING,
    EVENT_ECK_BERSERK
};

static Position EckSpawnPoint = { 1643.877930f, 936.278015f, 107.204948f, 0.668432f };

class boss_eck : public CreatureScript
{
public:
    boss_eck() : CreatureScript("boss_eck") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_eckAI (creature);
    }

    struct boss_eckAI : public ScriptedAI
    {

        EventMap events;
        bool IsBerserk;
        InstanceScript* instanceRef;

        boss_eckAI(Creature* c) : ScriptedAI(c), IsBerserk(false)
        {            
            this->instanceRef = c->GetInstanceScript();
        }        

        void Reset()
        {
            this->events.Reset();
            this->IsBerserk = false;

            if (this->instanceRef)
                this->instanceRef->SetData(DATA_ECK_THE_FEROCIOUS_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (this->instanceRef)
                this->instanceRef->SetData(DATA_ECK_THE_FEROCIOUS_EVENT, IN_PROGRESS);

            this->events.ScheduleEvent(EVENT_ECK_BITE, 5*IN_MILLISECONDS);
            this->events.ScheduleEvent(EVENT_ECK_SPRING, 8*IN_MILLISECONDS);
            this->events.ScheduleEvent(EVENT_ECK_SPIT, 10*IN_MILLISECONDS);
            this->events.ScheduleEvent(EVENT_ECK_BERSERK, urand(60*IN_MILLISECONDS, 90*IN_MILLISECONDS)); //60-90 secs according to wowwiki
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!this->UpdateVictim())
                return;
            this->events.Update(diff);            

            while(uint32 event = this->events.ExecuteEvent()) 
            {
                switch(event)
                {
                case EVENT_ECK_BITE:
                    {
                        this->DoCast(me->getVictim(), SPELL_ECK_BITE);
                        this->events.ScheduleEvent(EVENT_ECK_BITE, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
                    }
                    break;
                case EVENT_ECK_SPIT:
                    {
                        this->DoCast(me->getVictim(), SPELL_ECK_SPIT);
                        this->events.ScheduleEvent(EVENT_ECK_SPIT, urand(6*IN_MILLISECONDS, 14*IN_MILLISECONDS));
                    }
                    break;
                case EVENT_ECK_SPRING:
                    {
                        if(Unit* target = this->SelectTarget(SELECT_TARGET_RANDOM, 1))
                        {
                            if (target->GetTypeId() == TYPEID_PLAYER)
                            {
                                this->DoCast(target, RAND(SPELL_ECK_SPRING_1, SPELL_ECK_SPRING_2));
                                this->events.ScheduleEvent(EVENT_ECK_SPRING, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            }
                        }
                    }
                    break;
                case EVENT_ECK_BERSERK:
                    {
                        if(!IsBerserk)
                        {
                            this->DoCast(me, SPELL_ECK_BERSERK);
                            this->IsBerserk = true;
                        }
                    }
                    break;
                }
            }

            if(this->HealthBelowPct(20))    // Automatically go into berserk once we have less than 20% of maximum health.
            {
                this->DoCast(me, SPELL_ECK_BERSERK);
                this->events.CancelEvent(EVENT_ECK_BERSERK); // If it's still in there; just to avoid its usage later on.
                this->IsBerserk = true;
            }
            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            if (instanceRef)
                instanceRef->SetData(DATA_ECK_THE_FEROCIOUS_EVENT, DONE);
        }
    };
};

class npc_ruins_dweller : public CreatureScript
{
public:
    npc_ruins_dweller() : CreatureScript("npc_ruins_dweller") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ruins_dwellerAI (creature);
    }

    struct npc_ruins_dwellerAI : public ScriptedAI
    {
        npc_ruins_dwellerAI(Creature* c) : ScriptedAI(c)
        {
            instance = c->GetInstanceScript();
        }

        InstanceScript* instance;

        void JustDied(Unit* /*who*/)
        {
            if (instance)
            {
                instance->SetData64(DATA_RUIN_DWELLER_DIED, me->GetGUID());
                if (instance->GetData(DATA_ALIVE_RUIN_DWELLERS) == 0)
                    me->SummonCreature(CREATURE_ECK, EckSpawnPoint, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 300*IN_MILLISECONDS);
            }
        }
    };

};

void AddSC_boss_eck()
{
    new boss_eck();
    new npc_ruins_dweller();
}
