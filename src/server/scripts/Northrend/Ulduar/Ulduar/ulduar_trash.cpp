/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "ulduar.h"
#include "InstanceScript.h"

/* SQL
-- UPDATE `creature_template` SET `AIName`='', `ScriptName`= WHERE `entry`=;

UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_steelforged_defender' WHERE `entry`=33236;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ironwork_cannon' WHERE `entry`=33264;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_corrupted_servitor' WHERE `entry`=33354;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_misguided_nymph' WHERE `entry`=33355;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_guardian_lasher' WHERE `entry`=33430;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_forest_swarmer' WHERE `entry`=33431;


DELETE FROM `spell_script_names` WHERE `spell_id`=63059;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (63059, 'spell_pollinate');
  
*/

// class npc_ : public CreatureScript
// {
// private:
//     enum MyEvents
//     {
// 
//     };
//     enum Spells
//     {
// 
//     };
// public:
//     npc_ () : CreatureScript("") {}
// 
//     struct npc_AI: public ScriptedAI
//     {
//         npc_AI(Creature* creature) : ScriptedAI(creature) {}
// 
//         void Reset()
//         {
//             events.Reset();
//         }
// 
//         void UpdateAI(uint32 const diff)
//         {
//             if (!UpdateVictim())
//                 return;
// 
//             events.Update(diff);
// 
//             while (uint32 event = events.ExecuteEvent())
//             {
//                 switch (event)
//                 {
// 
//                 }
//             }
// 
//             DoMeleeAttackIfReady();
//         }
// 
//     private:
//         EventMap events;
//     };
// 
//     CreatureAI* GetAI(Creature* creature) const
//     {
//         return new npc_AI(creature);
//     }
// };

/************************************************************************/
/*                       Predicates                                     */
/************************************************************************/

struct RangeCheck : public std::unary_function<Unit*, bool>
{
    RangeCheck(Unit* base, float min, float max) : __base(base), __mindist(min), __maxdist(max) {}

    bool operator()(Unit const* other) const
    {
        float dist = __base->GetDistance(other->GetPositionX(), other->GetPositionY(), other->GetPositionZ());
        if ( dist >= __mindist && dist <= __maxdist)
            return true;
        return false;
    }

    private:
        Unit* __base;
        float __mindist;
        float __maxdist;
};

template<bool IsApplied>
struct AuraAppliedCheck : public std::unary_function<Unit*, bool>
{
    AuraAppliedCheck(uint32 spellId) : __spellId(spellId) {}
    bool operator()(Unit* const target) const
    {
        return (target->HasAura(__spellId) == IsApplied);
    }
    private:
        uint32 __spellId;
};

/************************************************************************/
/*                       The Grand Approach                             */
/************************************************************************/

class npc_steelforged_defender : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_HAMSTRING         = 1,
            EVENT_LIGHTNING_BOLT,
            EVENT_SUNDER_ARMOR,
        };
        enum Spells
        {
            SPELL_HAMSTRING         = 62845,
            SPELL_LIGHTNING_BOLT    = 57780,
            SPELL_SUNDER_ARMOR      = 50370,
        };
    public:
        npc_steelforged_defender () : CreatureScript("npc_steelforged_defender") {}

        struct npc_steelforged_defenderAI: public ScriptedAI
        {
            npc_steelforged_defenderAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();

                events.ScheduleEvent(EVENT_HAMSTRING, 10*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_LIGHTNING_BOLT, RAND<uint32>(9*IN_MILLISECONDS, 12*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_SUNDER_ARMOR, 2*IN_MILLISECONDS);
            }

            void JustDied(Unit* /*killer*/)
            {
                if (InstanceScript* instance = me->GetInstanceScript())
                    if (instance->GetBossState(BOSS_LEVIATHAN) == DONE)
                        me->SetRespawnTime(604800); // Once the levi died, we will not spawn again
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_HAMSTRING:
                            DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0, 5.0f), SPELL_HAMSTRING);
                            events.ScheduleEvent(EVENT_HAMSTRING, 10*IN_MILLISECONDS);                          
                            break;
                        case EVENT_LIGHTNING_BOLT:
                            DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f), SPELL_LIGHTNING_BOLT);
                            events.ScheduleEvent(EVENT_LIGHTNING_BOLT, 9*IN_MILLISECONDS);
                            break;
                        case EVENT_SUNDER_ARMOR:                            
                            DoCast(me->getVictim(), SPELL_SUNDER_ARMOR);
                            if (Unit* vic = me->getVictim())
                                if (Aura* sunder = vic->GetAura(SPELL_SUNDER_ARMOR))
                                    if (sunder->GetStackAmount() == 5)  // If stacks are maximized, we will take a longer delay.
                                    {
                                        events.ScheduleEvent(EVENT_SUNDER_ARMOR, 15*IN_MILLISECONDS);
                                        break;
                                    }
                            events.ScheduleEvent(EVENT_SUNDER_ARMOR, 2*IN_MILLISECONDS);
                            break;
                    }
                }
                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_steelforged_defenderAI(creature);
        }
};

class npc_ironwork_cannon : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_FLAME_CANNON = 1,
        };
        enum Spells
        {
            SPELL_FLAME_CANNON = 62395,
        };
    public:
        npc_ironwork_cannon () : CreatureScript("npc_ironwork_cannon") {}

        struct npc_ironwork_cannonAI: public ScriptedAI
        {
            npc_ironwork_cannonAI(Creature* creature) : ScriptedAI(creature) 
            {
                me->SetFloatValue(UNIT_FIELD_COMBATREACH, 200.0f);
            }

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_FLAME_CANNON, 1200);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_FLAME_CANNON:
                            if ( Unit* dest = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 30.0f, 200.0f)) )
                                DoCast(dest, SPELL_FLAME_CANNON);
                            events.ScheduleEvent(EVENT_FLAME_CANNON, 1500);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_ironwork_cannonAI(creature);
        }
};


/************************************************************************/
/*                          Outer Sanctuary                             */
/************************************************************************/


/************************************************************************/
/*                          Inner Sanctuary                             */
/************************************************************************/


/************************************************************************/
/*                      Inner Sanctuary - Freya                         */
/************************************************************************/

class npc_corrupted_servitor : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_VIOLENT_EARTH     = 1,
            EVENT_PETRIFY_JOINTS,
        };
        enum Spells
        {
            SPELL_VIOLENT_EARTH     = 63149,
            SPELL_PETRIFY_JOINTS_10 = 63169,
            SPELL_PETRIFY_JOINTS_25 = 63549,
        };
    public:
        npc_corrupted_servitor () : CreatureScript("npc_corrupted_servitor") {}

        struct npc_corrupted_servitorAI: public ScriptedAI
        {
            npc_corrupted_servitorAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_VIOLENT_EARTH, RAND<uint32>(6*IN_MILLISECONDS, 9*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_PETRIFY_JOINTS, 5*IN_MILLISECONDS);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_VIOLENT_EARTH:
                            DoCast(SelectTarget(SELECT_TARGET_RANDOM), SPELL_VIOLENT_EARTH);
                            events.ScheduleEvent(EVENT_VIOLENT_EARTH, RAND<uint32>(6*IN_MILLISECONDS, 9*IN_MILLISECONDS));
                            break;
                        case EVENT_PETRIFY_JOINTS:
                            DoCast( SelectTarget(SELECT_TARGET_RANDOM, 0, AuraAppliedCheck<false>(RAID_MODE(SPELL_PETRIFY_JOINTS_10, SPELL_PETRIFY_JOINTS_25))), RAID_MODE(SPELL_PETRIFY_JOINTS_10, SPELL_PETRIFY_JOINTS_25) );
                            events.ScheduleEvent(EVENT_PETRIFY_JOINTS, 5*IN_MILLISECONDS);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_corrupted_servitorAI(creature);
        }
};

class npc_misguided_nymph : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_BIND_LIFE         = 1,
            EVENT_FROST_SPEAR,
            EVENT_WINTERS_EMBRACE,
        };
        enum Spells
        {
            SPELL_BIND_LIFE_10       = 63082,
            SPELL_BIND_LIFE_25       = 63559,
            SPELL_FROST_SPEAR_10     = 63111,
            SPELL_FROST_SPEAR_25     = 63562,
            SPELL_WINTERS_EMBRACE_10 = 63136,
            SPELL_WINTERS_EMBRACE_25 = 63564,
        };
    public:
        npc_misguided_nymph () : CreatureScript("npc_misguided_nymph") {}

        struct npc_misguided_nymphAI: public ScriptedAI
        {
            npc_misguided_nymphAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_BIND_LIFE, 6*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_FROST_SPEAR, 8*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_WINTERS_EMBRACE, 1*IN_MILLISECONDS);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_BIND_LIFE:
                            if (me->GetHealthPct() < 80.0f)
                                DoCast(me, RAID_MODE(SPELL_BIND_LIFE_10, SPELL_BIND_LIFE_25));
                            events.ScheduleEvent(EVENT_BIND_LIFE, 6*IN_MILLISECONDS);
                            break;
                        case EVENT_FROST_SPEAR:
                            DoCast(me->getVictim(), RAID_MODE(SPELL_FROST_SPEAR_10, SPELL_FROST_SPEAR_25), true);
                            events.ScheduleEvent(EVENT_FROST_SPEAR, 8*IN_MILLISECONDS);
                            break;
                        case EVENT_WINTERS_EMBRACE:
                            if (!me->HasAura(RAID_MODE(SPELL_WINTERS_EMBRACE_10, SPELL_WINTERS_EMBRACE_25)))
                                DoCast(me, RAID_MODE(SPELL_WINTERS_EMBRACE_10, SPELL_WINTERS_EMBRACE_25));
                            events.ScheduleEvent(EVENT_WINTERS_EMBRACE, 30*IN_MILLISECONDS);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_misguided_nymphAI(creature);
        }
};

class npc_guardian_lasher : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_GUARDIANS_LASH = 1,
        };
        enum Spells
        {
            SPELL_GUARDIANS_LASH_10     = 63047,
            SPELL_GUARDIANS_LASH_25     = 63550,
            SPELL_GUARDIAN_PHEROMONES   = 63007 
        };
    public:
        npc_guardian_lasher () : CreatureScript("npc_guardian_lasher") {}

        struct npc_guardian_lasherAI: public ScriptedAI
        {
            npc_guardian_lasherAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                DoCast(SPELL_GUARDIAN_PHEROMONES);
                events.Reset();                
                events.ScheduleEvent(EVENT_GUARDIANS_LASH, 2*IN_MILLISECONDS);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (!me->HasAura(SPELL_GUARDIAN_PHEROMONES))
                    DoCast(SPELL_GUARDIAN_PHEROMONES);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_GUARDIANS_LASH:
                            DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0, 5.0f), RAID_MODE(SPELL_GUARDIANS_LASH_10, SPELL_GUARDIANS_LASH_25));
                            events.ScheduleEvent(EVENT_GUARDIANS_LASH, 6*IN_MILLISECONDS);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_guardian_lasherAI(creature);
        }
};

class npc_forest_swarmer : public CreatureScript
{
    private:
        enum MyEvents
        {   
            EVENT_POLLINATE = 1,
        };
        enum Spells
        {
            SPELL_POLLINATE = 63059 // TODO: Maybe this spell requires a script for target selection, the below is possibly not was is intended.
        };
    public:
        npc_forest_swarmer () : CreatureScript("npc_forest_swarmer") {}

        struct npc_forest_swarmerAI: public ScriptedAI
        {
            npc_forest_swarmerAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_POLLINATE, 5*IN_MILLISECONDS);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_POLLINATE:   
                            DoCast(SPELL_POLLINATE);    // Targeting is done by spell-script
                            events.ScheduleEvent(EVENT_POLLINATE, 30*IN_MILLISECONDS);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_forest_swarmerAI(creature);
        }
};

/************************************************************************/
/*                          Spells                                      */
/************************************************************************/

class spell_pollinate : public SpellScriptLoader
{
    public:
        spell_pollinate() : SpellScriptLoader("spell_pollinate") {}

        class spell_pollinate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_pollinate_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(63059))
                    return false;
                return true;
            }

            void FilterTargets(std::list<Unit*>& unitList)
            {
                for (std::list<Unit*>::iterator it = unitList.begin(); it != unitList.end(); ++it)
                {
                    if (Creature* creature = (*it)->ToCreature())
                        if (creature->GetEntry() != NPC_GUARDIAN_LASHER)
                            it = unitList.erase(it);
                    it = unitList.erase(it);
                }
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_pollinate_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_pollinate_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ALLY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_pollinate_SpellScript::FilterTargets, EFFECT_2, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_pollinate_SpellScript();
        }
};

void AddSC_ulduar_trash()
{
    new npc_steelforged_defender();
    new npc_ironwork_cannon();
    new npc_corrupted_servitor();
    new npc_misguided_nymph();
    new npc_guardian_lasher();
    new npc_forest_swarmer();

    new spell_pollinate();
}