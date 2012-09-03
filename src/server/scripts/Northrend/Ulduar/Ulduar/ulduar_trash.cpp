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

#include <limits>

/* SQL
-- UPDATE `creature_template` SET `AIName`='', `ScriptName`= WHERE `entry`=;

-- TODO: 34194

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
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_pyromancer' WHERE `entry`=33820;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_enslaved_fire_elemental' WHERE `entry`=33838;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_guardian' WHERE `entry`=33822;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_slayer' WHERE `entry`=33823;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_shadowblade' WHERE `entry`=33824;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_molten_colossus' WHERE `entry`=34069;   
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_forge_construct' WHERE `entry`=34085;  
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_magma_rager' WHERE `entry`=34086; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_champion_of_hodir' WHERE `entry`=34133; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_winter_revenant' WHERE `entry`=34134; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_winter_rumbler' WHERE `entry`=34135;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_winter_jormungar' WHERE `entry`=34137;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_mechagnome_battletank' WHERE `entry`=34164;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_arachnopod_destroyer' WHERE `entry`=34183;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_clockwork_mechanic' WHERE `entry`=34184;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ice_turret' WHERE `entry`=34224;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_hardened_iron_golem' WHERE `entry`=34190; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_clockwork_sapper' WHERE `entry`=34193; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_rune_etched_forged_sentry' WHERE `entry` IN (34196, 34234); 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_chamber_overseer' WHERE `entry`=34197; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_iron_mender' WHERE `entry`=34198; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_lightning_charged_iron_dwarf' WHERE `entry`=34199; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_parts_recovery_technician' WHERE `entry`=34267; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_XR949_salvagebot' WHERE `entry`=34269; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_salvagebot_sawblade' WHERE `entry`=34288;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_XD175_compactobot' WHERE `entry`=34271; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_XB488_disposalbot' WHERE `entry`=34273; 

DELETE FROM `spell_script_names` WHERE `spell_id`=63059;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (63059, 'spell_pollinate');

DELETE FROM `spell_linked_spell` WHERE  `spell_trigger`=62317 AND `spell_effect`=57807 AND `type`=1;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (62317, 57807, 1, 'Twilight Guardian - Link Devastate to Sunder Armor');


*/
// helper template - basic script stuff
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
                            DoCastVictim( SPELL_SUNDER_ARMOR);
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

class npc_molten_colossus : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_EARTHQUAKE = 1,
            EVENT_MAGMA_SPLASH,
            EVENT_PYROBLAST,
        };
        enum Spells
        {
            SPELL_EARTHQUAKE    = 64697,
            SPELL_MAGMA_SPLASH  = 64699,
            SPELL_PYROBLAST     = 64698,
        };
    public:
        npc_molten_colossus () : CreatureScript("npc_molten_colossus") {}

        struct npc_molten_colossusAI: public ScriptedAI
        {
            npc_molten_colossusAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_EARTHQUAKE, urand(4*IN_MILLISECONDS, 8*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_MAGMA_SPLASH, urand(3*IN_MILLISECONDS, 4*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_PYROBLAST, urand(6*IN_MILLISECONDS, 9*IN_MILLISECONDS));
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
                        case EVENT_EARTHQUAKE:
                            DoCastAOE(SPELL_EARTHQUAKE);
                            events.ScheduleEvent(EVENT_EARTHQUAKE, urand(4*IN_MILLISECONDS, 8*IN_MILLISECONDS));
                            break;
                        case EVENT_MAGMA_SPLASH:
                            DoCastVictim(SPELL_MAGMA_SPLASH);
                            events.ScheduleEvent(EVENT_MAGMA_SPLASH, urand(3*IN_MILLISECONDS, 4*IN_MILLISECONDS));
                            break;
                        case EVENT_PYROBLAST:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f))
                                DoCast(target, SPELL_PYROBLAST);
                            events.ScheduleEvent(EVENT_PYROBLAST, urand(6*IN_MILLISECONDS, 9*IN_MILLISECONDS));
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
            return new npc_molten_colossusAI(creature);
        }
};

class npc_forge_construct : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_CHARGE            = 1,
            EVENT_FLAME_EMISSION,
        };
        enum Spells
        {
            SPELL_CHARGE            = 64719,
            SPELL_FLAME_EMISSION_10 = 64720,
            SPELL_FLAME_EMISSION_25 = 64721,
        };
    public:
        npc_forge_construct () : CreatureScript("npc_forge_construct") {}

        struct npc_forge_constructAI: public ScriptedAI
        {
            npc_forge_constructAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_CHARGE, urand(8, 10)*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_FLAME_EMISSION, urand(4, 6)*IN_MILLISECONDS);
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
                        case EVENT_CHARGE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 5.0f, 100.0f)))
                                DoCast(target, SPELL_CHARGE);
                            events.ScheduleEvent(EVENT_CHARGE, urand(8*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            break;
                        case EVENT_FLAME_EMISSION:
                            DoCast(RAID_MODE(SPELL_FLAME_EMISSION_10, SPELL_FLAME_EMISSION_25));
                            events.ScheduleEvent(EVENT_FLAME_EMISSION, urand(4*IN_MILLISECONDS, 6*IN_MILLISECONDS));
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
            return new npc_forge_constructAI(creature);
        }
};

class npc_magma_rager : public CreatureScript
{
    private:
        enum MyEvents
        {   
            EVENT_FIREBLAST         = 1,
            EVENT_SUPERHEATED_WINDS,
        };
        enum Spells
        {
            SPELL_FIREBLAST         = 64773,
            SPELL_SUPERHEATED_WINDS = 64746,
        };
    public:
        npc_magma_rager () : CreatureScript("npc_magma_rager") {}

        struct npc_magma_ragerAI: public ScriptedAI
        {
            npc_magma_ragerAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_FIREBLAST, urand(4*IN_MILLISECONDS,6*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_SUPERHEATED_WINDS, 3*IN_MILLISECONDS);
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
                        case EVENT_FIREBLAST:
                            DoCastVictim(SPELL_FIREBLAST);
                            events.ScheduleEvent(EVENT_FIREBLAST, urand(4*IN_MILLISECONDS,6*IN_MILLISECONDS));
                            break;
                        case EVENT_SUPERHEATED_WINDS:
                            DoCast(SPELL_SUPERHEATED_WINDS);
                            events.ScheduleEvent(EVENT_SUPERHEATED_WINDS, 12*IN_MILLISECONDS);
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
            return new npc_magma_ragerAI(creature);
        }
};

class npc_mechagnome_battletank : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_FLAME_CANNON = 1,
            EVENT_JUMP_ATTACK,
        };
        enum Spells
        {
            SPELL_FLAME_CANNON = 64692,
            SPELL_JUMP_ATTACK = 64953,
        };
    public:
        npc_mechagnome_battletank () : CreatureScript("npc_mechagnome_battletank") {}

        struct npc_mechagnome_battletankAI: public ScriptedAI
        {
            npc_mechagnome_battletankAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_FLAME_CANNON, urand(2*IN_MILLISECONDS, 3*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_JUMP_ATTACK, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
                        case EVENT_FLAME_CANNON:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 30.0f, 200.0f)))
                                DoCast(target, SPELL_FLAME_CANNON);
                            events.ScheduleEvent(EVENT_FLAME_CANNON, urand(2*IN_MILLISECONDS, 3*IN_MILLISECONDS));
                            break;
                        case EVENT_JUMP_ATTACK:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 5.0f, 35.0f)))
                                DoCast(target, SPELL_JUMP_ATTACK); // TODO: check if the jump effect works correctly
                            events.ScheduleEvent(EVENT_JUMP_ATTACK, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
            return new npc_mechagnome_battletankAI(creature);
        }
};

class npc_parts_recovery_technician : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_MECHANO_KICK = 1,
        };
        enum Spells
        {
            SPELL_DEFENSE_MATRIX = 65070,
            SPELL_MECHANO_KICK = 65071,
        };
    public:
        npc_parts_recovery_technician () : CreatureScript("npc_parts_recovery_technician") {}

        struct npc_parts_recovery_technicianAI: public ScriptedAI
        {
            npc_parts_recovery_technicianAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_MECHANO_KICK, urand(5*IN_MILLISECONDS, 6*IN_MILLISECONDS));
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (!me->HasAura(SPELL_DEFENSE_MATRIX))
                    DoCast(SPELL_DEFENSE_MATRIX);

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_MECHANO_KICK:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, SPELL_MECHANO_KICK); // Possibly triggered=true? Damage appeared strange during test
                            events.ScheduleEvent(EVENT_MECHANO_KICK, urand(5*IN_MILLISECONDS, 6*IN_MILLISECONDS));
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
            return new npc_parts_recovery_technicianAI(creature);
        }
};

class npc_XR949_salvagebot : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_DEPLOY_SALVAGE_SAWs = 1,
        };
        enum Spells
        {
            SPELL_DEPLOY_SALVAGE_SAWS = 65099,
        };
    public:
        npc_XR949_salvagebot () : CreatureScript("npc_XR949_salvagebot") {}

        struct npc_XR949_salvagebotAI: public ScriptedAI
        {
            npc_XR949_salvagebotAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_DEPLOY_SALVAGE_SAWs, urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS));
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
                        case EVENT_DEPLOY_SALVAGE_SAWs:
                            DoCast(SPELL_DEPLOY_SALVAGE_SAWS);
                            events.ScheduleEvent(EVENT_DEPLOY_SALVAGE_SAWs, urand(5*IN_MILLISECONDS,10*IN_MILLISECONDS));
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
            return new npc_XR949_salvagebotAI(creature);
        }
};

class npc_salvagebot_sawblade : public CreatureScript
{
    private:
        enum Spells
        {
            SPELL_SAWBLADES_10 = 65089,
            SPELL_SAWBLADES_25 = 65102,
        };
    public:
        npc_salvagebot_sawblade () : CreatureScript("npc_salvagebot_sawblade") {}

        struct npc_salvagebot_sawbladeAI: public Scripted_NoMovementAI
        {
            npc_salvagebot_sawbladeAI(Creature* creature) : Scripted_NoMovementAI(creature) {}

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;
                
                DoSpellAttackIfReady(RAID_MODE(SPELL_SAWBLADES_10, SPELL_SAWBLADES_25)); // Hope this works, otherwise, we need to cast manually...
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_salvagebot_sawbladeAI(creature);
        }
};

class npc_XD175_compactobot : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_COMPACTED = 1,
            EVENT_TRASH_COMPACTOR, 
        };
        enum Spells
        {
            SPELL_COMPACTED_10          = 65078,
            SPELL_COMPACTED_25          = 65105,
            SPELL_TRASH_COMPACTOR_10    = 65073,
            SPELL_TRASh_COMPACTOR_25    = 65106,
        };
    public:
        npc_XD175_compactobot () : CreatureScript("npc_XD175_compactobot") {}

        struct npc_XD175_compactobotAI: public ScriptedAI
        {
            npc_XD175_compactobotAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_COMPACTED, urand(5*IN_MILLISECONDS, 7*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_TRASH_COMPACTOR, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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
                        case EVENT_COMPACTED:
                            DoCast(RAID_MODE(SPELL_COMPACTED_10, SPELL_COMPACTED_25));
                            events.ScheduleEvent(EVENT_COMPACTED, urand(5*IN_MILLISECONDS, 7*IN_MILLISECONDS));
                            break;
                        case EVENT_TRASH_COMPACTOR:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 10.0f, 40.0f)))
                            {
                                DoResetThreat();
                                DoCast(target, RAID_MODE(SPELL_TRASH_COMPACTOR_10, SPELL_TRASh_COMPACTOR_25));
                                me->AddThreat(target, 2000.0f);
                            }
                            events.ScheduleEvent(EVENT_TRASH_COMPACTOR, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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
            return new npc_XD175_compactobotAI(creature);
        }
};

class npc_XB488_disposalbot : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_CUT_SCRAP_METAL = 1,
        };
        enum Spells
        {
            SPELL_CUT_SCRAP_METAL_10 = 65080,
            SPELL_CUT_SCRAP_METAL_25 = 65104,
            SPELL_SELF_DESTRCUT = 65084,
        };
    public:
        npc_XB488_disposalbot () : CreatureScript("npc_XB488_disposalbot") {}

        struct npc_XB488_disposalbotAI: public ScriptedAI
        {
            npc_XB488_disposalbotAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                gotDest = false;
                events.Reset();
                events.ScheduleEvent(EVENT_CUT_SCRAP_METAL, urand(1*IN_MILLISECONDS, 2*IN_MILLISECONDS));
            }

            void DamageTaken(Unit* /*damager*/, uint32& damage)
            {
                if (damage >= me->GetHealth())
                {
                    if (gotDest)
                        return;
                    gotDest = true;
                    DoCast(SPELL_SELF_DESTRCUT);
                }
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
                        case EVENT_CUT_SCRAP_METAL:
                            DoCastVictim(RAID_MODE(SPELL_CUT_SCRAP_METAL_10, SPELL_CUT_SCRAP_METAL_25));
                            events.ScheduleEvent(EVENT_CUT_SCRAP_METAL, urand(4*IN_MILLISECONDS, 5*IN_MILLISECONDS));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
                bool gotDest;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_XB488_disposalbotAI(creature);
        }
};

/************************************************************************/
/*                          Outer Sanctuary                             */
/************************************************************************/

class npc_hardened_iron_golem : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_HARDEN_FISTS = 1,
            EVENT_RUNE_PUNCH,
        };
        enum Spells
        {
            SPELL_HARDEN_FIST   = 64877,
            SPELL_RUNE_PUNCH_10 = 64874,
            SPELL_RUNE_PUNCH_25 = 64967,
        };
    public:
        npc_hardened_iron_golem () : CreatureScript("npc_hardened_iron_golem") {}

        struct npc_hardened_iron_golemAI: public ScriptedAI
        {
            npc_hardened_iron_golemAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_HARDEN_FISTS, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_RUNE_PUNCH, urand(6*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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
                        case EVENT_HARDEN_FISTS:
                            DoCast(SPELL_HARDEN_FIST);
                            if (me->GetHealthPct() > 50.0f)
                                events.ScheduleEvent(EVENT_HARDEN_FISTS, urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS));
                            else
                                events.ScheduleEvent(EVENT_HARDEN_FISTS, urand(10*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                            break;
                        case EVENT_RUNE_PUNCH:
                            DoCastVictim(RAID_MODE(SPELL_RUNE_PUNCH_10, SPELL_RUNE_PUNCH_25));
                            events.ScheduleEvent(EVENT_RUNE_PUNCH, urand(6*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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
            return new npc_hardened_iron_golemAI(creature);
        }
};

class npc_rune_etched_forged_sentry : public CreatureScript // For NPC_RUNE_ETCHED_SENTRY (outer sanctuary) and NPC_RUNE_FORGED_SENTRY (grand approach)
{
    private:
        enum MyEvents
        {
            EVENT_FLAMING_RUNE = 1,
            EVENT_LAVABURST,
            EVENT_RUNED_FLAME_JETS,
        };
        enum Spells
        {
            SPELL_FLAMING_RUNE          = 64852,
            SPELL_LAVA_BURST_10         = 64870,
            SPELL_LAVA_BURST_25         = 64991,
            SPELL_RUNED_FLAME_JETS_10   = 64847,
            SPELL_RUNED_FLAME_JETS_25   = 64988,
        };
    public:
        npc_rune_etched_forged_sentry () : CreatureScript("npc_rune_etched_forged_sentry") {}

        struct npc_rune_etched_forged_sentryAI: public ScriptedAI
        {
            npc_rune_etched_forged_sentryAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_FLAMING_RUNE, urand(3*IN_MILLISECONDS, 5*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_LAVABURST, urand(7*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_RUNED_FLAME_JETS, urand(4*IN_MILLISECONDS, 6*IN_MILLISECONDS));
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
                        case EVENT_FLAMING_RUNE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, SPELL_FLAMING_RUNE);
                            events.ScheduleEvent(EVENT_FLAMING_RUNE, urand(3*IN_MILLISECONDS, 5*IN_MILLISECONDS));
                            break;
                        case EVENT_LAVABURST:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, RAID_MODE(SPELL_LAVA_BURST_10, SPELL_LAVA_BURST_25));
                            events.ScheduleEvent(EVENT_LAVABURST, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
                            break;
                        case EVENT_RUNED_FLAME_JETS:
                            DoCastVictim(RAID_MODE(SPELL_RUNED_FLAME_JETS_10, SPELL_RUNED_FLAME_JETS_25));
                            events.ScheduleEvent(EVENT_RUNED_FLAME_JETS, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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
            return new npc_rune_etched_forged_sentryAI(creature);
        }
};

class npc_chamber_overseer : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_STAGGERING_ROAR = 1,
            EVENT_DEVASTATING_LEAP,
        };
        enum Spells
        {
            SPELL_DEVASTATING_LEAP_10   = 64820,
            SPELL_DEVASTATING_LEAP_25   = 64943,
            SPELL_STAGGERING_ROAR_10    = 64825,
            SPELL_STAGGERING_ROAR_25    = 64944,
            // SPELL_DISPLACEMENT_DEVICE = 64783, // Sense of this spell ? The summoned npc does not do anything
        };
    public:
        npc_chamber_overseer () : CreatureScript("npc_chamber_overseer") {}

        struct npc_chamber_overseerAI: public ScriptedAI
        {
            npc_chamber_overseerAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_STAGGERING_ROAR, urand(4*IN_MILLISECONDS, 8*IN_MILLISECONDS));
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
                        case EVENT_STAGGERING_ROAR:
                            DoCastVictim(RAID_MODE(SPELL_STAGGERING_ROAR_10, SPELL_STAGGERING_ROAR_25));
                            events.ScheduleEvent(EVENT_STAGGERING_ROAR, urand(4*IN_MILLISECONDS, 8*IN_MILLISECONDS));
                            break;
                        case EVENT_DEVASTATING_LEAP:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 10.0f, 80.0f)))
                            {
                                DoResetThreat();
                                DoCast(target, RAID_MODE(SPELL_DEVASTATING_LEAP_10, SPELL_DEVASTATING_LEAP_25));
                                me->AddThreat(target, 2000.0f);
                            }
                            events.ScheduleEvent(EVENT_DEVASTATING_LEAP, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
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
            return new npc_chamber_overseerAI(creature);
        }
};

class npc_iron_mender : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_FUSE_LIGHTNING = 1,
            EVENT_FUSE_METAL,
            EVENT_CHANGE_TARGET,
        };
        enum Spells
        {
            SPELL_ELECTRO_SHOCK_10  = 64918,
            SPELL_ELECTRO_SHOCK_25  = 64971,
            SPELL_FUSE_LIGHTNING_10 = 64903,
            SPELL_FUSE_LIGHTNING_25 = 64970,
            SPELL_FUSE_METAL_10     = 64897,
            SPELL_FUSE_METAL_25     = 64968,
        };
    public:
        npc_iron_mender () : CreatureScript("npc_iron_mender") {}

        struct npc_iron_menderAI: public ScriptedAI
        {
            npc_iron_menderAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();                
                events.ScheduleEvent(EVENT_CHANGE_TARGET, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS)); // Change target periodically, target gets auto-casted
                events.ScheduleEvent(EVENT_FUSE_LIGHTNING, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FUSE_METAL, urand(1500, 2500));
            }

            void AttackStart(Unit* target)
            {
                AttackStartCaster(target, 50.0f);
            }

            void EnterCombat(Unit* target)
            {
                if (Unit* newtarget = SelectTarget(SELECT_TARGET_RANDOM))
                {
                    me->AddThreat(newtarget, std::numeric_limits<float>::max());
                    ScriptedAI::EnterCombat(newtarget);
                }
                else
                    ScriptedAI::EnterCombat(target);                
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
                        case EVENT_CHANGE_TARGET:
                            DoResetThreat();
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                me->AddThreat(target, std::numeric_limits<float>::max());
                            events.ScheduleEvent(EVENT_CHANGE_TARGET, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            break;
                        case EVENT_FUSE_LIGHTNING:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, RAID_MODE(SPELL_FUSE_LIGHTNING_10, SPELL_FUSE_LIGHTNING_25));
                            events.ScheduleEvent(EVENT_FUSE_LIGHTNING, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
                            break;
                        case EVENT_FUSE_METAL:
                            {
                                std::list<Unit*> allies;
                                Trinity::AnyFriendlyUnitInObjectRangeCheck checker(me, me, 30.0f);
                                Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(me, allies, checker);
                                me->VisitNearbyObject(30.0f, searcher);
                                allies.sort(Trinity::HealthPctOrderPred());
                                DoCast((*allies.begin()), RAID_MODE(SPELL_FUSE_METAL_10, SPELL_FUSE_METAL_25));
                            }
                            events.ScheduleEvent(EVENT_FUSE_METAL, urand(1500, 2500));
                            break;
                    }
                }

                DoSpellAttackIfReady(RAID_MODE(SPELL_ELECTRO_SHOCK_10, SPELL_ELECTRO_SHOCK_25));
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_iron_menderAI(creature);
        }
};

class npc_lightning_charged_iron_dwarf : public CreatureScript
{
    private:
        enum Spells
        {
            SPELL_LIGHTNING_CHARGED_10 = 64889,
            SPELL_LIGHTNING_CHARGED_25 = 64975,
        };
    public:
        npc_lightning_charged_iron_dwarf () : CreatureScript("npc_lightning_charged_iron_dwarf") {}

        struct npc_lightning_charged_iron_dwarfAI: public ScriptedAI
        {
            npc_lightning_charged_iron_dwarfAI(Creature* creature) : ScriptedAI(creature) {}

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (!me->HasAura(RAID_MODE(SPELL_LIGHTNING_CHARGED_10, SPELL_LIGHTNING_CHARGED_25)))
                    DoCast(RAID_MODE(SPELL_LIGHTNING_CHARGED_10, SPELL_LIGHTNING_CHARGED_25));

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_lightning_charged_iron_dwarfAI(creature);
        }
};

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
                            me->DespawnOrUnsummon(500);
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
/*                      Inner Sanctuary - Hodir                         */
/************************************************************************/

class npc_champion_of_hodir : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_FREEZING_BREATH = 1,
            EVENT_STOMP,
        };
        enum Spells
        {
            SPELL_FREEZING_BREATH   = 64649,
            SPELL_STOMP_10          = 64652,
            SPELL_STOMP_25          = 64639,
        };
    public:
        npc_champion_of_hodir () : CreatureScript("npc_champion_of_hodir") {}

        struct npc_champion_of_hodirAI: public ScriptedAI
        {
            npc_champion_of_hodirAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_STOMP, 5*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_FREEZING_BREATH, urand(5, 8)*IN_MILLISECONDS);
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
                    case EVENT_FREEZING_BREATH:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        {
                            me->SetFacingToObject(target);
                            DoCastVictim(SPELL_FREEZING_BREATH);
                        }
                        events.ScheduleEvent(EVENT_FREEZING_BREATH, urand(5*IN_MILLISECONDS, 8*IN_MILLISECONDS));
                        break;
                    case EVENT_STOMP:
                        DoCastAOE(RAID_MODE(SPELL_STOMP_10, SPELL_STOMP_25));
                        events.ScheduleEvent(EVENT_STOMP, 5*IN_MILLISECONDS);
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
            return new npc_champion_of_hodirAI(creature);
        }
};

class npc_winter_revenant : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_BLIZZARD = 1,
            EVENT_WHIRLING_STRIKE,
            EVENT_SHIELD,
        };
        enum Spells
        {
            SPELL_BLIZZARD_10                   = 64642,
            SPELL_BLIZZARD_25                   = 64653,
            SPELL_WHIRLING_STRIKE               = 64643,
            SPELL_SHIELD_OF_THE_WINTER_REVENANT = 64644,
        };
    public:
        npc_winter_revenant () : CreatureScript("npc_winter_revenant") {}

        struct npc_winter_revenantAI: public ScriptedAI
        {
            npc_winter_revenantAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                DoCast(SPELL_SHIELD_OF_THE_WINTER_REVENANT);
                events.Reset();
                events.ScheduleEvent(EVENT_WHIRLING_STRIKE, urand(5,8)*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_BLIZZARD, 3*IN_MILLISECONDS);
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
                        case EVENT_BLIZZARD:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, RAID_MODE(SPELL_BLIZZARD_10, SPELL_BLIZZARD_25));
                            events.ScheduleEvent(EVENT_BLIZZARD, 6*IN_MILLISECONDS);
                            break;
                        case EVENT_WHIRLING_STRIKE:
                            DoCastAOE(SPELL_WHIRLING_STRIKE);
                            events.ScheduleEvent(EVENT_WHIRLING_STRIKE, urand(5*IN_MILLISECONDS,8*IN_MILLISECONDS));
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
            return new npc_winter_revenantAI(creature);
        }
};

class npc_winter_rumbler : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_CONE_OF_COLD = 1,
            EVENT_SNOW_BLINDNESS,
        };
        enum Spells
        {
            SPELL_CONE_OF_COLD_10 = 64645,
            SPELL_CONE_OF_COLD_25 = 64655,
            SPELL_SNOW_BLINDNESS_10 = 64647,
            SPELL_SNOW_BLINDNESS_25 = 64654,
        };
    public:
        npc_winter_rumbler () : CreatureScript("npc_winter_rumbler") {}

        struct npc_winter_rumblerAI: public ScriptedAI
        {
            npc_winter_rumblerAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_CONE_OF_COLD, 8*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_SNOW_BLINDNESS, urand(2*IN_MILLISECONDS,3*IN_MILLISECONDS));
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
                        case EVENT_CONE_OF_COLD:
                            DoCastVictim(RAID_MODE(SPELL_CONE_OF_COLD_10, SPELL_CONE_OF_COLD_25));
                            events.ScheduleEvent(EVENT_CONE_OF_COLD, 8*IN_MILLISECONDS);
                            break;
                        case EVENT_SNOW_BLINDNESS:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, RAID_MODE(SPELL_SNOW_BLINDNESS_10, SPELL_SNOW_BLINDNESS_25));
                            events.ScheduleEvent(EVENT_SNOW_BLINDNESS, urand(2*IN_MILLISECONDS,3*IN_MILLISECONDS));
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
            return new npc_winter_rumblerAI(creature);
        }
};

class npc_winter_jormungar : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_ACIDIC_BITE = 1
        };
        enum Spells
        {
            SPELL_ACIDIC_BITE = 64638,
        };
    public:
        npc_winter_jormungar () : CreatureScript("npc_winter_jormungar") {}

        struct npc_winter_jormungarAI: public ScriptedAI
        {
            npc_winter_jormungarAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
                events.Reset();
                events.ScheduleEvent(EVENT_ACIDIC_BITE, urand(2*IN_MILLISECONDS, 3*IN_MILLISECONDS));
            }

            void EnterCombat(Unit* target)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                ScriptedAI::EnterCombat(target);
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
                        case EVENT_ACIDIC_BITE:
                            if (Aura* acidic = me->getVictim()->GetAura(SPELL_ACIDIC_BITE))
                                if (acidic->GetStackAmount() >= 5)
                                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                    {
                                        DoCast(target, SPELL_ACIDIC_BITE);
                                        return;
                                    }
                            DoCastVictim(SPELL_ACIDIC_BITE); // Fallthrough
                            events.ScheduleEvent(EVENT_ACIDIC_BITE, urand(2*IN_MILLISECONDS, 3*IN_MILLISECONDS));
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
            return new npc_winter_jormungarAI(creature);
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
                            DoCastVictim( RAID_MODE(SPELL_LIGHTNING_BRAND_10, SPELL_LIGHTNING_BRAND_25));
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
                        DoCastVictim( SPELL_RAVAGE_ARMOR);
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
                            DoCastVictim( RAID_MODE(SPELL_FROST_SPEAR_10, SPELL_FROST_SPEAR_25), true);
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
                            DoCast(Trinity::Containers::SelectRandomContainerElement(allies), RAID_MODE(SPELL_IRONROOT_THORNS_10, SPELL_IRONROOT_THORNS_25) );
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
/*                      Inner Sanctuary - Mimiron                       */
/************************************************************************/

class npc_arachnopod_destroyer : public CreatureScript // TODO: Add mind-ctrl-handling, once mind-ctrl works fine :D
{
    private:
        enum MyEvents
        {
            EVENT_CHARGED_LEAP = 1,
            EVENT_FLAME_SPRAY,
            EVENT_MACHINE_GUN,
        };
        enum Spells
        {
            SPELL_CHARGED_LEAP      = 64779,
            // SPELL_CHARGED_LEAP_DMG  = 64781, // Gets triggered by the spell above
            SPELL_FLAME_SPRAY       = 64717,
            SPELL_MACHINE_GUN       = 64776,
        };
    public:
        npc_arachnopod_destroyer () : CreatureScript("npc_arachnopod_destroyer") {}

        struct npc_arachnopod_destroyerAI: public ScriptedAI
        {
            npc_arachnopod_destroyerAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_CHARGED_LEAP, urand(20*IN_MILLISECONDS, 25*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FLAME_SPRAY, urand(6*IN_MILLISECONDS, 8*IN_MILLISECONDS));
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
                        case EVENT_CHARGED_LEAP:                            
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, RangeCheck(me, 10.0f, 40.0f)))
                            {
                                DoResetThreat();
                                DoCast(target, SPELL_CHARGED_LEAP);
                            }
                            events.ScheduleEvent(EVENT_CHARGED_LEAP, urand(20*IN_MILLISECONDS, 25*IN_MILLISECONDS));
                            break;
                        case EVENT_FLAME_SPRAY:
                            DoCastVictim(SPELL_FLAME_SPRAY);
                            events.ScheduleEvent(EVENT_FLAME_SPRAY, urand(6*IN_MILLISECONDS, 8*IN_MILLISECONDS));
                            break;
                        case EVENT_MACHINE_GUN:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, SPELL_MACHINE_GUN);
                            events.ScheduleEvent(EVENT_MACHINE_GUN, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
            return new npc_arachnopod_destroyerAI(creature);
        }
};

class npc_clockwork_mechanic : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_ICE_TURRET = 1,
        };
        enum Spells
        {
            SPELL_ICE_TURRET = 64966,
        };
    public:
        npc_clockwork_mechanic () : CreatureScript("npc_clockwork_mechanic") {}

        struct npc_clockwork_mechanicAI: public ScriptedAI
        {
            npc_clockwork_mechanicAI(Creature* creature) : ScriptedAI(creature), summons(me) {}

            void Reset()
            {
                gotDowned = false;
                summons.DespawnAll();
                events.Reset();
                events.ScheduleEvent(EVENT_ICE_TURRET, urand(7*IN_MILLISECONDS, 10*IN_MILLISECONDS));
            }

            void DamageTaken(Unit* damager, uint32& damage)
            {
                if (damage >= me->GetHealth())
                {
                    if (gotDowned)
                        return;
                    gotDowned = true;
                    DoCastAOE(SPELL_ICE_TURRET, true); // Instantly spawn one before dying
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summons.size() >= RAID_MODE<SummonList::size_type>(4, 8)) // Limit adds
                    events.CancelEvent(EVENT_ICE_TURRET);
            }

            void SummonedCreatureDies(Creature* summon, Unit* /*killer*/)
            {
                summons.Despawn(summon);
                if (summons.size() <= RAID_MODE<SummonList::size_type>(4, 8)) // if limit is not fulfilled, scheduled again
                    events.RescheduleEvent(EVENT_ICE_TURRET, urand(7*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
                        case EVENT_ICE_TURRET:
                            DoCastAOE(SPELL_ICE_TURRET);
                            events.ScheduleEvent(EVENT_ICE_TURRET, urand(7*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
                SummonList summons;
                bool gotDowned;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_clockwork_mechanicAI(creature);
        }
};

class npc_ice_turret: public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_FROST_NOVA = 1
        };
        enum Spells
        {
            SPELL_ICE_NOVA_10 = 66346,
            SPELL_ICE_NOVA_25 = 64919,
        };
    public:
        npc_ice_turret () : CreatureScript("npc_ice_turret") {}

        struct npc_ice_turretAI: public Scripted_NoMovementAI
        {
            npc_ice_turretAI(Creature* creature) : Scripted_NoMovementAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_FROST_NOVA, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
                        case EVENT_FROST_NOVA:
                            DoCastAOE(RAID_MODE(SPELL_ICE_NOVA_10, SPELL_ICE_NOVA_25));
                            events.ScheduleEvent(EVENT_FROST_NOVA, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            break;
                    }
                }

                // Does not melee
            }

            private:
                EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_ice_turretAI(creature);
        }
};

class npc_clockwork_sapper : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_ENERGY_SAP = 1
        };
        enum Spells
        {
            SPELL_ENERGY_SAP = 64740,
        };
    public:
        npc_clockwork_sapper () : CreatureScript("npc_clockwork_sapper") {}

        struct npc_clockwork_sapperAI: public ScriptedAI
        {
            npc_clockwork_sapperAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_ENERGY_SAP, urand(1*IN_MILLISECONDS, 2*IN_MILLISECONDS));
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
                        case EVENT_ENERGY_SAP:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                                DoCast(target, SPELL_ENERGY_SAP);
                            events.ScheduleEvent(EVENT_ENERGY_SAP, urand(6*IN_MILLISECONDS, 8*IN_MILLISECONDS));
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
            return new npc_clockwork_sapperAI(creature);
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
            EVENT_VOID_BARRIER_BEGIN,
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

                if (me->GetHealthPct()<30.0f && events.GetNextEventTime(EVENT_VOID_BARRIER_BEGIN)==0 && events.GetNextEventTime(EVENT_VOID_BARRIER_END)==0) // If on low health and skills not yet scheduled...
                {
                    events.ScheduleEvent(EVENT_VOID_BARRIER_BEGIN, 0);
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
                        case EVENT_VOID_BARRIER_BEGIN:
                            DoCast(SPELL_VOID_BARRIER);
                            events.ScheduleEvent(EVENT_VOID_BARRIER_END, 10*IN_MILLISECONDS);
                            break;
                        case EVENT_VOID_BARRIER_END:
                            me->RemoveAurasDueToSpell(SPELL_VOID_BARRIER);
                            events.ScheduleEvent(EVENT_VOID_BARRIER_BEGIN, 10*IN_MILLISECONDS);
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
                            DoCast( SelectTarget(SELECT_TARGET_FARTHEST, 0, 150.0f), SPELL_BLINK );
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
                            DoCast( SelectTarget(SELECT_TARGET_FARTHEST, 0, 150.0f), SPELL_BLINK );
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

class npc_twilight_pyromancer : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_ARCANE_BURST = 1,
            EVENT_BLINK,
            EVENT_FIREBALL,
            EVENT_FLAME_STRIKE,
            EVENT_SUMMON_FIRE_ELE,
        };
        enum Spells
        {
            SPELL_ARCANE_BURST      = 64663,
            SPELL_BLINK             = 64662,
            SPELL_FIREBALL          = 63789,
            SPELL_FLAME_STRIKE      = 63775,
            SPELL_SUMMON_FIRE_ELE   = 63774
        };
    public:
        npc_twilight_pyromancer () : CreatureScript("npc_twilight_pyromancer") {}

        struct npc_twilight_pyromancerAI: public ScriptedAI
        {
            npc_twilight_pyromancerAI(Creature* creature) : ScriptedAI(creature), summons(me) {}

            void Reset()
            {
                summons.DespawnAll();
                events.Reset();

                DoCast(SPELL_SUMMON_FIRE_ELE);

                events.ScheduleEvent(EVENT_BLINK, urand(8*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FIREBALL, urand(3*IN_MILLISECONDS, 5*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FLAME_STRIKE, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
            }

            void SummonedCreatureDies(Creature* creature, Unit* /*killer*/)
            {
                summons.Despawn(creature);
                if (creature->GetEntry() == 33838) // Enslaved fire elemental
                    events.ScheduleEvent(EVENT_SUMMON_FIRE_ELE, 1*IN_MILLISECONDS);
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
                        case EVENT_ARCANE_BURST:
                            DoCast(SPELL_ARCANE_BURST); // is paired with blink, so no need to reschedule this
                            break;
                        case EVENT_BLINK:
                            DoCast( SelectTarget(SELECT_TARGET_FARTHEST, 0, 150.0f), SPELL_BLINK );
                            events.ScheduleEvent(EVENT_BLINK, urand(8*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                            events.ScheduleEvent(EVENT_ARCANE_BURST, 1*IN_MILLISECONDS);
                            break;
                        case EVENT_SUMMON_FIRE_ELE:
                            DoCast(SPELL_SUMMON_FIRE_ELE);
                            break;
                        case EVENT_FIREBALL:
                            DoCast( SelectTarget(SELECT_TARGET_RANDOM), SPELL_FIREBALL );
                            events.ScheduleEvent(EVENT_FIREBALL, urand(3*IN_MILLISECONDS, 5*IN_MILLISECONDS));
                            break;
                        case EVENT_FLAME_STRIKE:
                            DoCast( SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f), SPELL_FLAME_STRIKE );
                            events.ScheduleEvent(EVENT_FLAME_STRIKE, urand(5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                EventMap events;
                SummonList summons;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_twilight_pyromancerAI(creature);
        }
};

class npc_enslaved_fire_elemental : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_FIRE_SHIELD_CHECK = 1,
            EVENT_BLAST_WAVE,
        };
        enum Spells
        {
            SPELL_FIRE_SHIELD   = 63778,
            SPELL_BLAST_WAVE    = 38064
        };
    public:
        npc_enslaved_fire_elemental () : CreatureScript("npc_enslaved_fire_elemental") {}

        struct npc_enslaved_fire_elementalAI: public ScriptedAI
        {
            npc_enslaved_fire_elementalAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                DoCast(me, SPELL_FIRE_SHIELD);
                events.Reset();
                events.ScheduleEvent(EVENT_FIRE_SHIELD_CHECK, 1*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_BLAST_WAVE, 6*IN_MILLISECONDS);
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
                        case EVENT_FIRE_SHIELD_CHECK:
                            {
                                std::list<Unit*> allies;
                                Trinity::AnyFriendlyUnitInObjectRangeCheck checker(me, me, 20.0f);
                                Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(me, allies, checker);
                                me->VisitNearbyObject(20.0f, searcher);
                                allies.push_back(me->ToUnit());                // Add me to list
                                allies.remove_if(Trinity::UnitAuraCheck(true, SPELL_FIRE_SHIELD)); // Fulfills here, since the call-to-predicate does not require a const one
                                if (!allies.empty())
                                    DoCast(Trinity::Containers::SelectRandomContainerElement(allies), SPELL_FIRE_SHIELD);
                                events.ScheduleEvent(EVENT_FIRE_SHIELD_CHECK, 1*IN_MILLISECONDS);
                            }
                            break;
                        case EVENT_BLAST_WAVE:
                            DoCast(SPELL_BLAST_WAVE);
                            events.ScheduleEvent(EVENT_BLAST_WAVE, 6*IN_MILLISECONDS);
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
            return new npc_enslaved_fire_elementalAI(creature);
        }
};

class npc_twilight_guardian : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_CONCUSSION_BLOW = 1,
            EVENT_DEVASTATE,
            EVENT_SUNDER_ARMOR,
            EVENT_THUNDERCLAP,
        };
        enum Spells
        {
            SPELL_CONCUSSION_BLOW   = 52719,
            SPELL_DEVASTATE         = 62317,
            SPELL_SUNDER_ARMOR      = 57807,
            SPELL_THUNDERCLAP       = 63757,
        };
    public:
        npc_twilight_guardian () : CreatureScript("npc_twilight_guardian") {}

        struct npc_twilight_guardianAI: public ScriptedAI
        {
            npc_twilight_guardianAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_CONCUSSION_BLOW, urand(3*IN_MILLISECONDS, 6*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_DEVASTATE, urand(1500, 2500));
                events.ScheduleEvent(EVENT_THUNDERCLAP, urand (5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
                        case EVENT_CONCUSSION_BLOW:
                            DoCastVictim(SPELL_CONCUSSION_BLOW);
                            DoResetThreat();
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                            {
                                me->AddThreat(target, 1000.0f);
                                AttackStart(target);
                            }
                            events.ScheduleEvent(EVENT_CONCUSSION_BLOW, urand(3*IN_MILLISECONDS, 6*IN_MILLISECONDS));
                            break;
                        case EVENT_DEVASTATE:
                            DoCastVictim(SPELL_DEVASTATE);
                            events.ScheduleEvent(EVENT_DEVASTATE, urand(1500, 2500));
                            break;
                        case EVENT_THUNDERCLAP:
                            DoCast(SPELL_THUNDERCLAP);
                            events.ScheduleEvent(EVENT_THUNDERCLAP, urand (5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
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
            return new npc_twilight_guardianAI(creature);
        }
};

// I hope that this one will really slay Twilight :)
class npc_twilight_slayer : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_BLADESTORM = 1,
            EVENT_MORTAL_STRIKE
        };
        enum Spells
        {
            SPELL_BLADESTORM = 63784,
            SPELL_MORTAL_STRIKE = 35054,
        };
    public:
        npc_twilight_slayer () : CreatureScript("npc_twilight_slayer") {}

        struct npc_twilight_slayerAI: public ScriptedAI
        {
            npc_twilight_slayerAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
                events.ScheduleEvent(EVENT_BLADESTORM, urand(4*IN_MILLISECONDS, 8*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_MORTAL_STRIKE, urand(3*IN_MILLISECONDS, 6*IN_MILLISECONDS));
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))   // for bladestorm
                    return;

                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_BLADESTORM:
                            DoCastVictim(SPELL_BLADESTORM, true);
                            events.DelayEvents(8*IN_MILLISECONDS);
                            events.ScheduleEvent(EVENT_BLADESTORM, urand(12*IN_MILLISECONDS, 16*IN_MILLISECONDS));
                            break;
                        case EVENT_MORTAL_STRIKE:
                            DoCastVictim(SPELL_MORTAL_STRIKE);
                            events.ScheduleEvent(EVENT_MORTAL_STRIKE, urand(4*IN_MILLISECONDS, 6*IN_MILLISECONDS));
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
            return new npc_twilight_slayerAI(creature);
        }
};

class npc_twilight_shadowblade : public CreatureScript
{
    private:
        enum MyEvents
        {
            EVENT_SHADOWSTEP = 1,
            EVENT_BACKSTAB,
            EVENT_FAN_OF_KNIVES,
            EVENT_DEADLY_POSION,
        };
        enum Spells
        {
            SPELL_STEALTH = 30831,
            SPELL_SHADOWSTEP = 36554,
            SPELL_BACKSTAB = 63754,
            SPELL_FAN_OF_KNIVES = 63753,
            SPELL_DEADLY_POSION = 63755,
        };
    public:
        npc_twilight_shadowblade () : CreatureScript("npc_twilight_shadowblade") {}

        struct npc_twilight_shadowbladeAI: public ScriptedAI
        {
            npc_twilight_shadowbladeAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                me->SetReactState(REACT_DEFENSIVE);
                events.Reset();

                events.ScheduleEvent(EVENT_DEADLY_POSION, urand(12*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FAN_OF_KNIVES, urand(6*IN_MILLISECONDS, 10*IN_MILLISECONDS));
            }

            void MoveInLineOfSight(Unit* target)
            {
                if (Player* player = target->ToPlayer())
                    if (me->IsWithinDist(player, 25.0f))
                        events.ScheduleEvent(EVENT_SHADOWSTEP, 500);
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
                        case EVENT_DEADLY_POSION:
                            DoCastVictim(SPELL_DEADLY_POSION);
                            events.ScheduleEvent(EVENT_DEADLY_POSION, urand(12*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                            break;
                        case EVENT_FAN_OF_KNIVES:
                            DoCast(SPELL_FAN_OF_KNIVES);
                            events.ScheduleEvent(EVENT_FAN_OF_KNIVES, urand(6*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            break;
                        case EVENT_SHADOWSTEP:
                            DoResetThreat();
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                            {
                                DoCast(target, SPELL_SHADOWSTEP);
                                AttackStart(target);
                                events.ScheduleEvent(EVENT_BACKSTAB, 300);
                            }
                            events.ScheduleEvent(EVENT_SHADOWSTEP, urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS));
                            break;
                        case EVENT_BACKSTAB:
                            DoCastVictim(SPELL_BACKSTAB);
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
            return new npc_twilight_shadowbladeAI(creature);
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

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                for (std::list<WorldObject*>::iterator it = targets.begin(); it != targets.end(); ++it)
                {
                    if (Creature* creature = (*it)->ToCreature())
                    {
                        if (creature->GetEntry() != NPC_GUARDIAN_LASHER)
                            it = targets.erase(it);
                    }
                    else
                        it = targets.erase(it);
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pollinate_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_NEARBY_ENTRY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pollinate_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_NEARBY_ENTRY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pollinate_SpellScript::FilterTargets, EFFECT_2, TARGET_UNIT_NEARBY_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_pollinate_SpellScript();
        }
};

void AddSC_ulduar_trash()
{
    // GA
    new npc_steelforged_defender();
    new npc_ironwork_cannon();
    new npc_molten_colossus();
    new npc_forge_construct();
    new npc_magma_rager();
    new npc_mechagnome_battletank();
    new npc_parts_recovery_technician();
    new npc_XR949_salvagebot();
    new npc_salvagebot_sawblade();
    new npc_XD175_compactobot();
    new npc_XB488_disposalbot();

    // OS
    new npc_hardened_iron_golem();
    new npc_rune_etched_forged_sentry();
    new npc_chamber_overseer();
    new npc_iron_mender();
    new npc_lightning_charged_iron_dwarf();
    
    // IS
    new npc_storm_tempered_keeper();
    new npc_charged_sphere();

    // IS - Hodir
    new npc_champion_of_hodir();
    new npc_winter_revenant();
    new npc_winter_rumbler();
    new npc_winter_jormungar();

    // IS - Thorim
    new npc_dark_rune_thunderer();
    new npc_dark_rune_ravager();

    // IS - Vezax
    new npc_faceless_horror();
    new npc_twilight_adherent();
    new npc_twilight_frost_mage();
    new npc_twilight_pyromancer();
    new npc_enslaved_fire_elemental();
    new npc_twilight_guardian();
    new npc_twilight_slayer();
    new npc_twilight_shadowblade();

    // IS - Freya
    new npc_corrupted_servitor();
    new npc_misguided_nymph();
    new npc_guardian_lasher();
    new npc_forest_swarmer();
    new npc_mangrove_ent();
    new npc_ironroot_lasher();
    new npc_natures_blade();
    new npc_guardian_of_life();

    // IS - Mimiron
    new npc_arachnopod_destroyer();
    new npc_clockwork_mechanic();
    new npc_ice_turret();
    new npc_clockwork_sapper();

    new spell_pollinate();
}