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
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_mangrove_ent' WHERE `entry`=33525;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ironroot_lasher' WHERE `entry`=33526;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_natures_blade' WHERE `entry`=33527;  
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_guardian_of_life' WHERE `entry`=33528; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_storm_tempered_keeper' WHERE `entry` IN (33699, 33722); 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_charged_sphere' WHERE `entry`=33715;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_dark_rune_thunderer' WHERE `entry`=33754; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_dark_rune_ravager' WHERE `entry`=33755; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_faceless_horror' WHERE `entry`=33772; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_adherent' WHERE `entry`=33818; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_frost_mage' WHERE `entry`=33819;  

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

    bool operator()(Unit* const other) const
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

// Note: This predicate also works in SelectTarget(...), while Trinity::UnitAuraCheck does not (due to missing const-specifier)
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
                events.ScheduleEvent(EVENT_LIGHTNING_BOLT, urand(9*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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

enum
{
    NPC_STORM_TEMPERED_KEEPER_1 = 33699,
    NPC_STORM_TEMPERED_KEEPER_2 = 33722,
};

class npc_storm_tempered_keeper : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_FORKED_LIGHTNING          = 1,
            EVENT_SUMMONS_CHARGED_SPHERE,
        };
        enum Spells
        {
            SPELL_FORKED_LIGHTNING      = 63527,
            SPELL_SEPARATION_ANXIETY    = 63539,
            SPELL_SUMMON_CHARGED_SPHERE = 63527,    // Summons 33715, script below
            SPELL_VENGEFUL_SURGE        = 33699,
        };
        enum Misc
        {
            ACTION_VENGEFUL_SURGE = 1,            
        };
    public:
        npc_storm_tempered_keeper () : CreatureScript("npc_storm_tempered_keeper") {}

        struct npc_storm_tempered_keeperAI: public ScriptedAI
        {
            npc_storm_tempered_keeperAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_FORKED_LIGHTNING, 6*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_SUMMONS_CHARGED_SPHERE, 10*IN_MILLISECONDS);
            }

            void DoAction(int32 const action)
            {
                switch (action)
                {
                    case ACTION_VENGEFUL_SURGE:
                        DoCast(SPELL_VENGEFUL_SURGE);
                        break;
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                std::list<Creature*> targets;
                GetCreatureListWithEntryInGrid(targets, me, NPC_STORM_TEMPERED_KEEPER_1, 30.0f);
                GetCreatureListWithEntryInGrid(targets, me, NPC_STORM_TEMPERED_KEEPER_2, 30.0f);
                for (std::list<Creature*>::iterator it = targets.begin(); it != targets.end(); ++it)
                {
                    if (Creature* c = (*it))
                        if (c->IsAIEnabled)
                            c->AI()->DoAction(ACTION_VENGEFUL_SURGE);
                }
            }

            void DoSeparationCheck()
            {
                if (me->HasAura(SPELL_SEPARATION_ANXIETY))
                    return;
                std::list<Creature*> targets;
                GetCreatureListWithEntryInGrid(targets, me, NPC_STORM_TEMPERED_KEEPER_1, 30.0f);
                GetCreatureListWithEntryInGrid(targets, me, NPC_STORM_TEMPERED_KEEPER_2, 30.0f);
                targets.sort(Trinity::ObjectDistanceOrderPred(me));
                if ( !me->IsInRange( (*targets.begin()), 0.0f, 15.0f) )
                    DoCast(SPELL_SEPARATION_ANXIETY);                
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                DoSeparationCheck();

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_FORKED_LIGHTNING:
                            DoCast(SPELL_FORKED_LIGHTNING);
                            events.ScheduleEvent(EVENT_FORKED_LIGHTNING, 6*IN_MILLISECONDS);
                            break;
                        case EVENT_SUMMONS_CHARGED_SPHERE:
                            DoCast(SPELL_SUMMON_CHARGED_SPHERE);
                            events.ScheduleEvent(EVENT_SUMMONS_CHARGED_SPHERE, 30*IN_MILLISECONDS);
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
            return new npc_storm_tempered_keeperAI(creature);
        }
};

class npc_charged_sphere : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_START_DEST_CHASE = 1,
            EVENT_END_DEST_CHASE
        };
        enum Spells
        {
            SPELL_SUPERCHARGED = 63528,
        };
    public:
        npc_charged_sphere () : CreatureScript("npc_charged_sphere") {}

        struct npc_charged_sphereAI: public ScriptedAI
        {
            npc_charged_sphereAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                me->GetMotionMaster()->MoveRandom(30.0f);   // Move random for 10 seconds, since the sphere spawns directly in front of the npc
                events.ScheduleEvent(EVENT_START_DEST_CHASE, 5*IN_MILLISECONDS);
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
                        case EVENT_START_DEST_CHASE:
                            if (Creature* dest = me->FindNearestCreature(NPC_STORM_TEMPERED_KEEPER_1, 50.0f))
                                me->GetMotionMaster()->MoveChase(dest, 150.0f);
                            else if (Creature* dest = me->FindNearestCreature(NPC_STORM_TEMPERED_KEEPER_2, 50.0f))
                                me->GetMotionMaster()->MoveChase(dest, 150.0f);
                            else
                                me->DisappearAndDie();
                            events.ScheduleEvent(EVENT_END_DEST_CHASE, 5*IN_MILLISECONDS);
                            break;
                        case EVENT_END_DEST_CHASE:
                            if (Creature* dest = me->FindNearestCreature(NPC_STORM_TEMPERED_KEEPER_1, 5.0f))
                                DoCast(dest, SPELL_SUPERCHARGED);
                            else if (Creature* dest = me->FindNearestCreature(NPC_STORM_TEMPERED_KEEPER_2, 5.0f))
                                DoCast(dest, SPELL_SUPERCHARGED);
                            me->ForcedDespawn(500);
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
            return new npc_charged_sphereAI(creature);
        }
};

/************************************************************************/
/*                      Inner Sanctuary - Thorim                        */
/************************************************************************/

class npc_dark_rune_thunderer : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_LIGHTNING_BRAND = 1
        };
        enum Spells
        {
            SPELL_LIGHTNING_BRAND_10 = 63612,
            SPELL_LIGHTNING_BRAND_25 = 63673
        };
    public:
        npc_dark_rune_thunderer () : CreatureScript("npc_dark_rune_thunderer") {}

        struct npc_dark_rune_thundererAI: public ScriptedAI
        {
            npc_dark_rune_thundererAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_LIGHTNING_BRAND, 3*IN_MILLISECONDS);
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
                        case EVENT_LIGHTNING_BRAND:
                            DoCast(me->getVictim(), RAID_MODE(SPELL_LIGHTNING_BRAND_10, SPELL_LIGHTNING_BRAND_25));
                            events.ScheduleEvent(EVENT_LIGHTNING_BRAND, urand(2*IN_MILLISECONDS, 3*IN_MILLISECONDS));
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
            return new npc_dark_rune_thundererAI(creature);
        }
};

class npc_dark_rune_ravager : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_RAVAGE_ARMOR = 1
        };
        enum Spells
        {
            SPELL_RAVAGE_ARMOR = 63615,
        };
    public:
        npc_dark_rune_ravager () : CreatureScript("npc_dark_rune_ravager") {}

        struct npc_dark_rune_ravagerAI: public ScriptedAI
        {
            npc_dark_rune_ravagerAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_RAVAGE_ARMOR, 2*IN_MILLISECONDS);
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
                    case EVENT_RAVAGE_ARMOR:
                        DoCast(me->getVictim(), SPELL_RAVAGE_ARMOR);
                        events.ScheduleEvent(EVENT_RAVAGE_ARMOR, 2*IN_MILLISECONDS);
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
            return new npc_dark_rune_ravagerAI(creature);
        }
};

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
                events.ScheduleEvent(EVENT_VIOLENT_EARTH, urand(6*IN_MILLISECONDS, 9*IN_MILLISECONDS));
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
                            events.ScheduleEvent(EVENT_VIOLENT_EARTH, urand(6*IN_MILLISECONDS, 9*IN_MILLISECONDS));
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

class npc_mangrove_ent : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_HURRICANE = 1,
            EVENT_NOURISH,
            EVENT_TRANQUILITY,
        };
        enum Spells
        {
            SPELL_HURRICANE      = 63272,
            SPELL_NOURISH_10     = 63242,
            SPELL_NOURISH_25     = 63556,
            SPELL_TRANQUILITY_10 = 63241,
            SPELL_TRANQUILITY_25 = 63554,
        };
    public:
        npc_mangrove_ent () : CreatureScript("npc_mangrove_ent") {}

        struct npc_mangrove_entAI: public ScriptedAI
        {
            npc_mangrove_entAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_HURRICANE, 3*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_NOURISH, 1*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_TRANQUILITY, 5*IN_MILLISECONDS);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))   // Hurricane and Tranquility are channeled, so...
                    return;

                while (uint32 event = events.ExecuteEvent())
                {                    
                    switch (event)
                    {
                        case EVENT_HURRICANE:
                            DoCast( SelectTarget(SELECT_TARGET_RANDOM), SPELL_HURRICANE );
                            events.ScheduleEvent(EVENT_HURRICANE, 10*IN_MILLISECONDS);
                            break;
                        case EVENT_NOURISH:
                            {
                                std::list<Unit*> allies;
                                Trinity::AnyFriendlyUnitInObjectRangeCheck checker(me, me, 40.0f);
                                Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(me, allies, checker);
                                me->VisitNearbyObject(40.0f, searcher);
                                allies.push_back(me->ToUnit());                // Add me to list
                                allies.sort(Trinity::HealthPctOrderPred());     // Sort ascending to current hp-percentage - the target with the lowest hp should be healed
                                DoCast( (*allies.begin()), RAID_MODE(SPELL_NOURISH_10, SPELL_NOURISH_25) );
                                events.ScheduleEvent(EVENT_NOURISH, 1500);      // Cast takes 1500ms
                            }
                            break;
                        case EVENT_TRANQUILITY:
                            events.DelayEvents(10*IN_MILLISECONDS);
                            DoCast(RAID_MODE(SPELL_TRANQUILITY_10, SPELL_TRANQUILITY_25));
                            events.ScheduleEvent(EVENT_TRANQUILITY, 30*IN_MILLISECONDS);
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
            return new npc_mangrove_entAI(creature);
        }
};

class npc_ironroot_lasher : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_IRONROOT_THORNS = 1
        };
        enum Spells
        {
            SPELL_IRONROOT_THORNS_10 = 63240,
            SPELL_IRONROOT_THORNS_25 = 63553,
        };
    public:
        npc_ironroot_lasher () : CreatureScript("npc_ironroot_lasher") {}

        struct npc_ironroot_lasherAI: public ScriptedAI
        {
            npc_ironroot_lasherAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_IRONROOT_THORNS, 2*IN_MILLISECONDS);
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
                        case EVENT_IRONROOT_THORNS:
                            std::list<Unit*> allies;
                            Trinity::AnyFriendlyUnitInObjectRangeCheck checker(me, me, 40.0f);
                            Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(me, allies, checker);
                            me->VisitNearbyObject(40.0f, searcher);
                            allies.push_back(me->ToUnit());
                            DoCast( SelectRandomContainerElement(allies), RAID_MODE(SPELL_IRONROOT_THORNS_10, SPELL_IRONROOT_THORNS_25) );
                            events.ScheduleEvent(EVENT_IRONROOT_THORNS, 2*IN_MILLISECONDS);
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
            return new npc_ironroot_lasherAI(creature);
        }
};

class npc_natures_blade : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_LIVING_TSUNAMI = 1
        };
        enum Spells
        {
            SPELL_LIVING_TSUNAMI_10 = 63247,
            SPELL_LIVING_TSUNAMI_25 = 63568,
        };
    public:
        npc_natures_blade () : CreatureScript("npc_natures_blade") {}

        struct npc_natures_bladeAI: public ScriptedAI
        {
            npc_natures_bladeAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_LIVING_TSUNAMI, 3*IN_MILLISECONDS);
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
                        case EVENT_LIVING_TSUNAMI:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, AuraAppliedCheck<false>(RAID_MODE(SPELL_LIVING_TSUNAMI_10, SPELL_LIVING_TSUNAMI_25))))
                            {
                                me->SetFacingToObject(target);  // Note: Spell is casted into current orientation
                                DoCast( RAID_MODE(SPELL_LIVING_TSUNAMI_10, SPELL_LIVING_TSUNAMI_25) );
                            }
                            events.ScheduleEvent(EVENT_LIVING_TSUNAMI, 3*IN_MILLISECONDS);
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
            return new npc_natures_bladeAI(creature);
        }
};

class npc_guardian_of_life : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_POISON_BREATH = 1,
        };
        enum Spells
        {
            SPELL_POISON_BREATH_10 = 63226,
            SPELL_POISON_BREATH_25 = 63551,
        };
    public:
        npc_guardian_of_life () : CreatureScript("npc_guardian_of_life") {}

        struct npc_guardian_of_lifeAI: public ScriptedAI
        {
            npc_guardian_of_lifeAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_POISON_BREATH, 3*IN_MILLISECONDS);
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
                        case EVENT_POISON_BREATH:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, AuraAppliedCheck<false>(RAID_MODE(SPELL_POISON_BREATH_10, SPELL_POISON_BREATH_25))))
                            {
                                me->SetFacingToObject(target);  // Note: Spell is casted into current orientation
                                DoCast( RAID_MODE(SPELL_POISON_BREATH_10, SPELL_POISON_BREATH_25) );
                            }
                            events.ScheduleEvent(EVENT_POISON_BREATH, 5*IN_MILLISECONDS);
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
            return new npc_guardian_of_lifeAI(creature);
        }
};

/************************************************************************/
/*                      Inner Sanctuary - Vezax                         */
/************************************************************************/

class npc_faceless_horror : public CreatureScript
{
    private:
        enum MyEvents
        {   
            EVENT_DEATH_GRIP = 1,
            EVENT_SHADOW_CRASH,
            EVENT_VOID_BARRIER_END,
            EVENT_VOID_WAVE
        };
        enum Spells
        {
            SPELL_DEATH_GRIP_FH = 64429,
            SPELL_SHADOW_CRASH  = 63722,
            SPELL_VOID_BARRIER  = 63710,
            SPELL_VOID_WAVE     = 63703,
        };
    public:
        npc_faceless_horror () : CreatureScript("npc_faceless_horror") {}

        struct npc_faceless_horrorAI: public ScriptedAI
        {
            npc_faceless_horrorAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                DoCast(me, SPELL_VOID_WAVE);
                events.Reset();
                events.ScheduleEvent(EVENT_DEATH_GRIP, urand(8*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_SHADOW_CRASH, urand(6*IN_MILLISECONDS, 12*IN_MILLISECONDS));
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->GetHealthPct() < 30.0f)
                {
                    DoCast(SPELL_VOID_BARRIER);
                    events.ScheduleEvent(EVENT_VOID_BARRIER_END, 10*IN_MILLISECONDS);
                }

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_DEATH_GRIP:
                            DoResetThreat();
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                            {
                                me->AddThreat(target, 10000.0f);
                                DoCast(target, SPELL_DEATH_GRIP_FH, true);
                            }
                            events.ScheduleEvent(EVENT_DEATH_GRIP, urand(8*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            break;
                        case EVENT_SHADOW_CRASH:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 10.0f, 70.0f)))
                            {
                                DoCast(target, SPELL_SHADOW_CRASH);
                            }
                            events.ScheduleEvent(EVENT_SHADOW_CRASH, urand(6*IN_MILLISECONDS, 12*IN_MILLISECONDS));
                            break;
                        case EVENT_VOID_BARRIER_END:
                            me->RemoveAurasDueToSpell(SPELL_VOID_BARRIER);
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
            return new npc_faceless_horrorAI(creature);
        }
};

class npc_twilight_adherent : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_ARCANE_BURST = 1,
            EVENT_BLINK,
            EVENT_GREATER_HEAL,
            EVENT_PSYCHIC_SCREAM,
            EVENT_RENEW,
        };
        enum Spells
        {
            SPELL_ARCANE_BURST      = 64663,
            SPELL_BLINK             = 64662,
            SPELL_GREATER_HEAL      = 63760,
            SPELL_PSYCHIC_SCREAM    = 13704,
            SPELL_RENEW             = 37978,  
        };
    public:
        npc_twilight_adherent () : CreatureScript("npc_twilight_adherent") {}

        struct npc_twilight_adherentAI: public ScriptedAI
        {
            npc_twilight_adherentAI(Creature* creature) : ScriptedAI(creature) {}

            Unit* GetLowestHPAllyOrMe(float range)
            {
                std::list<Unit*> allies;
                Trinity::AnyFriendlyUnitInObjectRangeCheck checker(me, me, range);
                Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(me, allies, checker);
                me->VisitNearbyObject(range, searcher);
                allies.push_back(me->ToUnit());                // Add me to list
                allies.sort(Trinity::HealthPctOrderPred());    // Sort ascending to current hp-percentage - the target with the lowest hp should be healed
                return (*allies.begin());
            }

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_BLINK, urand(8*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_GREATER_HEAL, urand(5*IN_MILLISECONDS, 7*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_RENEW, urand(6*IN_MILLISECONDS, 12*IN_MILLISECONDS));
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (me->GetHealthPct()<40 && events.GetNextEventTime(EVENT_PSYCHIC_SCREAM)==0)
                    events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, 500);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_ARCANE_BURST:
                            DoCast(SPELL_ARCANE_BURST); // is paired with blink, so no need to reschedule this
                            break;
                        case EVENT_BLINK:
                            DoCast( SelectTarget(SELECT_TARGET_FARTHEST, 0, RangeCheck(me, 0.0f, 150.0f)), SPELL_BLINK );
                            events.ScheduleEvent(EVENT_BLINK, urand(8*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                            events.ScheduleEvent(EVENT_ARCANE_BURST, 1*IN_MILLISECONDS);
                            break;
                        case EVENT_GREATER_HEAL:
                            if (Unit* ally = GetLowestHPAllyOrMe(40.0f))
                                DoCast(ally, SPELL_GREATER_HEAL);
                            events.ScheduleEvent(EVENT_GREATER_HEAL, urand(5*IN_MILLISECONDS, 7*IN_MILLISECONDS));
                            break;
                        case EVENT_PSYCHIC_SCREAM:
                            DoCast(SPELL_PSYCHIC_SCREAM);
                            break;
                        case EVENT_RENEW:
                            if (Unit* ally = GetLowestHPAllyOrMe(40.0f))
                                DoCast(ally, SPELL_RENEW);
                            events.ScheduleEvent(EVENT_RENEW, urand(6*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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
            return new npc_twilight_adherentAI(creature);
        }
};

class npc_twilight_frost_mage : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_ARCANE_BURST = 1,
            EVENT_BLINK,
            EVENT_FROST_NOVA,
            EVENT_FROSTBOLT,
            EVENT_FROSTBOLT_VOLLEY,
        };
        enum Spells
        {
            SPELL_ARCANE_BURST      = 64663,
            SPELL_BLINK             = 64662,
            SPELL_FROST_NOVA        = 63912,
            SPELL_FROSTBOLT         = 63913,
            SPELL_FROSTBOLT_VOLLEY  = 63758,
        };
    public:
        npc_twilight_frost_mage () : CreatureScript("npc_twilight_frost_mage") {}

        struct npc_twilight_frost_mageAI: public ScriptedAI
        {
            npc_twilight_frost_mageAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_FROST_NOVA, urand(8*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FROSTBOLT, urand(3*IN_MILLISECONDS, 5*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        // Spell order: Frostnova -> Blink -> Arcane Burst
                        case EVENT_ARCANE_BURST:
                            DoCast(SPELL_ARCANE_BURST); // is paired with blink, so no need to reschedule this
                            break;
                        case EVENT_BLINK:
                            DoCast( SelectTarget(SELECT_TARGET_FARTHEST, 0, RangeCheck(me, 0.0f, 150.0f)), SPELL_BLINK );                            
                            events.ScheduleEvent(EVENT_ARCANE_BURST, 1*IN_MILLISECONDS);
                            break;
                        case EVENT_FROST_NOVA:
                            events.ScheduleEvent(EVENT_FROST_NOVA, urand(8*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                            events.ScheduleEvent(EVENT_BLINK, 1*IN_MILLISECONDS);
                            break;
                        case EVENT_FROSTBOLT:
                            DoCast( SelectTarget(SELECT_TARGET_RANDOM), SPELL_FROSTBOLT );
                            events.ScheduleEvent(EVENT_FROSTBOLT, urand(3*IN_MILLISECONDS, 5*IN_MILLISECONDS));
                            break;
                        case EVENT_FROSTBOLT_VOLLEY:
                            DoCast(SPELL_FROSTBOLT_VOLLEY);
                            events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
            return new npc_twilight_frost_mageAI(creature);
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
                    {
                        if (creature->GetEntry() != NPC_GUARDIAN_LASHER)
                            it = unitList.erase(it);
                    }
                    else 
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
    // OS
    new npc_steelforged_defender();
    new npc_ironwork_cannon();

    // IS
    new npc_storm_tempered_keeper();
    new npc_charged_sphere();

    // IS - Thorim
    new npc_dark_rune_thunderer();
    new npc_dark_rune_ravager();

    // IS - Vezax
    new npc_faceless_horror();
    new npc_twilight_adherent();
    new npc_twilight_frost_mage();

    // IS - Freya
    new npc_corrupted_servitor();
    new npc_misguided_nymph();
    new npc_guardian_lasher();
    new npc_forest_swarmer();
    new npc_mangrove_ent();
    new npc_ironroot_lasher();
    new npc_natures_blade();
    new npc_guardian_of_life();

    new spell_pollinate();
}