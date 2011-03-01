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
    SPELL_CLEAVE           = 40504,
    SPELL_TOXIC_VOLLEY     = 25812,
    SPELL_POISON_CLOUD     = 26590,

    SPELL_ENRAGE           = 25790,

    SPELL_CHARGE           = 26561,
    SPELL_KNOCKBACK        = 18670,
    SPELL_KNOCKDOWN        = 19128,

    SPELL_HEAL             = 25807,
    SPELL_FEAR             = 26580,
    SPELL_RAVAGE           = 3242
};
/*
Waypoint 0: X: -8584.493 Y: 2146.365 Z: -7.919866
Waypoint 1: X: -8584.978 Y: 2149.038 Z: -7.783845
Waypoint 2: X: -8585.478 Y: 2151.538 Z: -8.033845
Waypoint 3: X: -8586.728 Y: 2163.788 Z: -5.033845
Waypoint 4: X: -8587.728 Y: 2171.788 Z: -4.533845
*/
enum Events
{
    EVENT_CLEAVE            = 1,
    EVENT_TOXIC_VOLLEY      = 2,
    EVENT_CHARGING          = 3,
    EVENT_KNOCKDOWN         = 4,
    EVENT_KNOCKBACK         = 5,
    EVENT_HEAL              = 6,
    EVENT_FEAR              = 7,
    EVENT_RAVAGE            = 8
};

bool IsBugsEncounterComplete(InstanceScript* instance, Creature* me)
{
    if (!instance || !me)
        return false;

    if (Creature* vem = Unit::GetCreature(*me, instance->GetData64(BOSS_VEM)))
        if (vem->isAlive())
            return false;

    if (Creature* kri = Unit::GetCreature(*me, instance->GetData64(BOSS_KRI)))
        if (kri->isAlive())
            return false;

    if (Creature* yauj = Unit::GetCreature(*me, instance->GetData64(BOSS_YAUJ)))
        if (yauj->isAlive())
            return false;

    return true;
}

class boss_kri : public CreatureScript
{
    public:
        boss_kri() : CreatureScript("boss_kri") { }

        struct boss_kriAI : public BossAI
        {
            boss_kriAI(Creature* creature) : BossAI(creature, BOSS_KRI)
            {
                instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                if (instance)
                {
                    if (instance->GetBossState(BOSS_KRI) == IN_PROGRESS || instance->GetBossState(BOSS_KRI) == DONE)
                    {
                        instance->SetBossState(BOSS_YAUJ, NOT_STARTED);
                        instance->SetBossState(BOSS_VEM, NOT_STARTED);
                    }
                }
                BossAI::Reset();

                events.ScheduleEvent(EVENT_CLEAVE, 8000);
                events.ScheduleEvent(EVENT_TOXIC_VOLLEY, 10000);
            }

            void JustDied(Unit* /*killer*/)
            {
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                if (instance)
                {
                    instance->SetBossState(BOSS_KRI, DONE);
                    if (IsBugsEncounterComplete(instance, me))
                        instance->SetBossState(BOSS_BUG_TRIO, DONE);
                    else
                        DoCast(me, SPELL_POISON_CLOUD);
                }
                if (Creature* yauj = Unit::GetCreature(*me, instance->GetData64(BOSS_YAUJ)))
                    yauj->BossAI::summons.DespawnAll();
            }

            void EnterCombat(Unit* victim)
            {
                BossAI::EnterCombat(victim);

                if (instance)
                {
                    instance->SetBossState(BOSS_KRI, IN_PROGRESS);
                    if (Creature* vem = Unit::GetCreature(*me, instance->GetData64(BOSS_VEM)))
                        vem->SetInCombatWithZone();
                    if (Creature* yauj = Unit::GetCreature(*me, instance->GetData64(BOSS_YAUJ)))
                        yauj->SetInCombatWithZone();
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_TOXIC_VOLLEY:
                            DoCastAOE(SPELL_TOXIC_VOLLEY);
                            events.ScheduleEvent(EVENT_TOXIC_VOLLEY, urand(10000,20000));
                            break;
                        case EVENT_CLEAVE:
                            DoCastVictim(SPELL_CLEAVE);
                            events.ScheduleEvent(EVENT_CLEAVE, urand(8000, 13000));
                            break;
                        default:
                            break;
                    }
                }
 
                DoMeleeAttackIfReady();
            }
            private:
                InstanceScript* instance;
                EventMap events;
                bool encounterActionReset;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_kriAI (pCreature);
        }
};

class boss_vem: public CreatureScript
{
    public:
        boss_vem() : CreatureScript("boss_vem") { }

        struct boss_vemAI : public BossAI
        {
            boss_vemAI(Creature* creature) : BossAI(creature, BOSS_VEM)
            {
                instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                if (instance->GetBossState(BOSS_VEM) == IN_PROGRESS || instance->GetBossState(BOSS_VEM) == DONE)
                {
                    instance->SetBossState(BOSS_KRI, NOT_STARTED);
                    instance->SetBossState(BOSS_YAUJ, NOT_STARTED);
                }
                BossAI::Reset();

                events.ScheduleEvent(EVENT_CHARGING, 11000);
                events.ScheduleEvent(EVENT_KNOCKDOWN, 20000);
                events.ScheduleEvent(EVENT_KNOCKBACK, 30000);
            }

            void JustDied(Unit* /*killer*/)
            {
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                if (instance)
                {
                    instance->SetBossState(BOSS_VEM, DONE);
                    if (IsBugsEncounterComplete(instance, me))
                        instance->SetBossState(BOSS_BUG_TRIO, DONE);
                    else
                    {
                        // Yauj and Kri enrages when Vem dies.
                        if (Creature* yauj = Unit::GetCreature(*me, instance->GetData64(BOSS_YAUJ)))
                            yauj->CastSpell(yauj, SPELL_ENRAGE, false);
                        if (Creature* kri = Unit::GetCreature(*me, instance->GetData64(BOSS_KRI)))
                            kri->CastSpell(kri, SPELL_ENRAGE, false);
                    }
                }
                if (Creature* yauj = Unit::GetCreature(*me, instance->GetData64(BOSS_YAUJ)))
                    yauj->BossAI::summons.DespawnAll();
            }

            void EnterCombat(Unit* victim)
            {
                BossAI::EnterCombat(victim);

                if (instance)
                {
                    instance->SetBossState(BOSS_VEM, IN_PROGRESS);
                    if (Creature* yauj = Unit::GetCreature(*me, instance->GetData64(BOSS_YAUJ)))
                        yauj->SetInCombatWithZone();
                    if (Creature* kri = Unit::GetCreature(*me, instance->GetData64(BOSS_KRI)))
                        kri->SetInCombatWithZone();
                }
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_CHARGING:
                            DoCastVictim(SPELL_CHARGE);
                            events.ScheduleEvent(EVENT_CHARGING, urand(12000, 20000));
                            break;
                        case EVENT_KNOCKDOWN:
                            DoCastVictim(SPELL_KNOCKDOWN);
                            events.ScheduleEvent(EVENT_KNOCKDOWN, 15000);
                            break;
                        case EVENT_KNOCKBACK:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                                DoCast(target, SPELL_KNOCKBACK);
                            events.ScheduleEvent(EVENT_KNOCKBACK, 35000);
                            break;
                        default:
                            break;
                    }
                }
 
                DoMeleeAttackIfReady();
            }
            private:
                InstanceScript* instance;
                EventMap events;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_vemAI (pCreature);
        }
};

class boss_yauj : public CreatureScript
{
    public:
        boss_yauj() : CreatureScript("boss_yauj") { }

        struct boss_yaujAI : public BossAI
        {
            boss_yaujAI(Creature* creature) : BossAI(creature, BOSS_YAUJ)
            {
                instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                if (instance)
                {
                    if (instance->GetBossState(BOSS_YAUJ) == IN_PROGRESS || instance->GetBossState(BOSS_YAUJ) == DONE)
                    {
                        instance->SetBossState(BOSS_KRI, NOT_STARTED);
                        instance->SetBossState(BOSS_VEM, NOT_STARTED);
                    }
                }
                BossAI::Reset();

                events.ScheduleEvent(EVENT_FEAR, 10000);
                events.ScheduleEvent(EVENT_HEAL, 16000);
                events.ScheduleEvent(EVENT_RAVAGE, 10000);
            }

            void JustDied(Unit* killer)
            {
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                if (instance)
                {
                    instance->SetBossState(BOSS_YAUJ, DONE);
                    if (IsBugsEncounterComplete(instance, me))
                        instance->SetBossState(BOSS_BUG_TRIO, DONE);
                    else
                    {
                        Position pos;
                        me->GetPosition(&pos);
                        for (uint8 i = 0; i < 7; ++i)
                            DoSummon(NPC_YAUJ_BROOD, pos, 90000, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN);
                    }
                }
            }

            void EnterCombat(Unit* victim)
            {
                BossAI::EnterCombat(victim);

                if (instance)
                {
                    instance->SetBossState(BOSS_YAUJ, IN_PROGRESS);
                    if (Creature* vem = Unit::GetCreature(*me, instance->GetData64(BOSS_VEM)))
                        vem->SetInCombatWithZone();
                    if (Creature* kri = Unit::GetCreature(*me, instance->GetData64(BOSS_KRI)))
                        kri->SetInCombatWithZone();
                }
            }

            void CastFearOnAllPlayers()
            {
                Map* map = me->GetMap();
                if (!map->IsDungeon())
                    return;
                Map::PlayerList const &PlayerList = map->GetPlayers();
                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    if (Player* i_pl = i->getSource())
                        if (i_pl->isAlive())
                            DoCast(i_pl, SPELL_FEAR);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_FEAR:
                            CastFearOnAllPlayers();
                            DoResetThreat();
                            events.ScheduleEvent(EVENT_FEAR, 20000);
                            break;
                        case EVENT_HEAL:
                            // Set my hp to default, so if kri or vem isn't alive or in dist - i will heal myself
                            if (Unit* target = DoSelectLowestHpFriendly(20.0f, 20000))
                                DoCast(target, SPELL_HEAL);
                            else if (HealthBelowPct(95))
                                DoCast(me, SPELL_HEAL);
                            events.ScheduleEvent(EVENT_HEAL, urand(10000, 20000));
                            break;
                        case EVENT_RAVAGE:
                            DoCastVictim(SPELL_RAVAGE);
                            events.ScheduleEvent(EVENT_RAVAGE, 35000);
                            break;
                        default:
                            break;
                    }
                }
 
                DoMeleeAttackIfReady();
            }
            private:
                InstanceScript* instance;
                EventMap events;
        };

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return new boss_yaujAI (pCreature);
        }
};

void AddSC_bug_trio()
{
    new boss_kri();
    new boss_vem();
    new boss_yauj();
}
