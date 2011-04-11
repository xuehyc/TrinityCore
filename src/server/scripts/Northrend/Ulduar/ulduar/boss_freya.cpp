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

#include "ScriptPCH.h"
#include "ulduar.h"

/*
LandofLegends - Entwicklungsnotizen:
DoTo:
Freya:
    Spawn Trunk at the End of the Fight
    Nature bombs spawnen(phase 2)
Adds:
    Elemental Adds Revive if not killed in the same timeframe

Elders:
Elder Brightleaf: - finished
Elder Ironbranch - finished
Elder Stonebark - finished
*/

enum Yells
{
    SAY_AGGRO                                   = -1603180,
    SAY_AGGRO_WITH_ELDER                        = -1603181,
    SAY_SLAY_1                                  = -1603182,
    SAY_SLAY_2                                  = -1603183,
    SAY_DEATH                                   = -1603184,
    SAY_BERSERK                                 = -1603185,
    SAY_SUMMON_CONSERVATOR                      = -1603186,
    SAY_SUMMON_TRIO                             = -1603187,
    SAY_SUMMON_LASHERS                          = -1603188,
    SAY_YS_HELP                                 = -1603189,

    // Elder Brightleaf
    SAY_BRIGHTLEAF_AGGRO                        = -1603190,
    SAY_BRIGHTLEAF_SLAY_1                       = -1603191,
    SAY_BRIGHTLEAF_SLAY_2                       = -1603192,
    SAY_BRIGHTLEAF_DEATH                        = -1603193,

    // Elder Ironbranch
    SAY_IRONBRANCH_AGGRO                        = -1603194,
    SAY_IRONBRANCH_SLAY_1                       = -1603195,
    SAY_IRONBRANCH_SLAY_2                       = -1603196,
    SAY_IRONBRANCH_DEATH                        = -1603197,

    // Elder Stonebark
    SAY_STONEBARK_AGGRO                         = -1603198,
    SAY_STONEBARK_SLAY_1                        = -1603199,
    SAY_STONEBARK_SLAY_2                        = -1603200,
    SAY_STONEBARK_DEATH                         = -1603201,
};

enum Events
{
    // Con-speed-atory timed achievement.
    // TODO Should be started when 1st trash is killed.
    ACHIEV_CON_SPEED_ATORY_START_EVENT          = 21597,
    SPELL_ACHIEVEMENT_CHECK                     = 65074,

    // Lumberjacked timed achievement.
    // TODO should be started when 1st elder is killed.
    // Spell should be casted when 3rd elder is killed.
    ACHIEV_LUMBERJACKED                         = 21686,
    SPELL_LUMBERJACKED_ACHIEVEMENT_CHECK        = 65296,
};

enum Archievments
{
    ACHIEVMENT_CON_SPEED_ATORY_10               = 2980,
    ACHIEVMENT_CON_SPEED_ATORY_25               = 2981,

    ACHIEVMENT_GETTING_BACK_TO_NATURE_10        = 2982,
    ACHIEVMENT_GETTING_BACK_TO_NATURE_25        = 2983,

    ACHIEVMENT_KNOCK_ON_THE_WOOD_10             = 3177, // Defeat Freya while leaving at least 1 Elder alive
    ACHIEVMENT_KNOCK_ON_THE_WOOD_25             = 3185,
    ACHIEVMENT_KNOCK_KNOCK_ON_THE_WOOD_10       = 3178, // Defeat Freya while leaving at least 2 Elder alive
    ACHIEVMENT_KNOCK_KNOCK_ON_THE_WOOD_25       = 3186,
    ACHIEVMENT_KNOCK_KNOCK_KNOCK_ON_THE_WOOD_10 = 3179, // Defeat Freya while leaving at least 3 Elder alive
    ACHIEVMENT_KNOCK_KNOCK_KNOCK_ON_THE_WOOD_25 = 3187,

    ACHIEVMENT_LUMBERJACKED_10                  = 2979,
    ACHIEVMENT_LUMBERJACKED_25                  = 3118,
};

enum Spells
{
    // Freya
    SPELL_BERSERK                               = 82395,
    SPELL_TOUCH_OF_EONAR_10                     = 62528,
    SPELL_TOUCH_OF_EONAR_25                     = 62892,
    SPELL_ATTUNED_TO_NATURE                     = 62519,
    SPELL_SUNBEAM_10                            = 62623,
    SPELL_SUNBEAM_25                            = 62872,

    SPELL_NATURE_BOMB_VISUAL                    = 64648, // Projectile Visual ... Dummy
    SPELL_NATURE_BOMB_SUMMON                    = 64606, // castet from player ...

    SPELL_SUMMON_WAVE_10                        = 62688, // Trigger 62687 in Spell Effekt
    SPELL_SUMMON_WAVE_10_SUMMON                 = 62687,
    SPELL_SUMMON_WAVE_3                         = 62686,
    SPELL_SUMMON_WAVE_1                         = 62685,

    SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_1    = 62572, // works
    SPELL_LIFEBINDERS_GIFT_SUMMON_1             = 62568,
    SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_2    = 62870, // works
    SPELL_LIFEBINDERS_GIFT_SUMMON_2             = 62869,
    SPELL_LIFEBINDERS_GIFT_VISUAL               = 62579,

    // Hardmode
    SPELL_BRIGHTLEAFS_ESSENCE                   = 62385, // triggers 62968 //alt 65585 -> triggers 65761
    SPELL_BRIGHTLEAFS_ESSENCE_AURA              = 62968, // 65761
    SPELL_IRONBRANCHS_ESSENCE                   = 62387, // alt 65586 triggers both 62713
    SPELL_IRONBRANCHS_ESSENCE_AURA              = 62713,
    SPELL_STONEBARKS_ESSENCE_AURA               = 62386, // alt 62386

    SPELL_FREYA_UNSTABLE_ENERGY_10              = 62451,
    SPELL_FREYA_UNSTABLE_ENERGY_25              = 62865,
    SPELL_FREYA_IRON_ROOTS_10                   = 62283,
    SPELL_FREYA_IRON_ROOTS_25                   = 62930,
    SPELL_FREYA_GROUND_TREMOR_10                = 62437,
    SPELL_FREYA_GROUND_TREMOR_25                = 62859,

    //Nature Bomb
    SPELL_NATURE_BOMB_VISUAL_OBJECT             = 64600, // Gameobjectspawn 194902
    SPELL_NATURE_BOMB_EXPLOSION                 = 64587,
    SPELL_NATURE_BOMB_EXPLOSION_H               = 64650,

    // Freya Adds
    SPELL_ATTUNED_TO_NATURE_REMOVE_2            = 62524,
    SPELL_ATTUNED_TO_NATURE_REMOVE_10           = 62525,
    SPELL_ATTUNED_TO_NATURE_REMOVE_25           = 62521,
    // Eonar's Gift
    SPELL_LIFEBINDERS_GIFT_10                   = 62584,
    SPELL_LIFEBINDERS_GIFT_25                   = 64185,

    // Test
    SPELL_PHEROMONES                            = 62619,

    // ???
    SUMMON_FREYA_CHEST                          = 62950, // 62952-62958

    //Adds
    //detonating lasher
    SPELL_DETONATE_10                           = 62598,
    SPELL_DETONATE_25                           = 62937,
    SPELL_FLAME_LASH                            = 62608,

    //ancient water spirit
    SPELL_TIDAL_WAVE_10                         = 62653,
    SPELL_TIDAL_WAVE_25                         = 62935,

    //storm lasher
    SPELL_LIGHTNING_LASH_10                     = 62648,
    SPELL_LIGHTNING_LASH_25                     = 62939,
    SPELL_STORMBOLT_10                          = 62649,
    SPELL_STORMBOLT_25                          = 62938,

    //snaplasher
    SPELL_HARDENED_BARK_10                      = 62664,
    SPELL_HARDENED_BARK_25                      = 64191,

    //ancient conservator
    SPELL_CONSERVATORS_GRIP                     = 62532,
    SPELL_NATURES_FURY_10                       = 62589,
    SPELL_NATURES_FURY_25                       = 63571,

    //healthy spore
    SPELL_POTENT_PHEROMONES                     = 62541,
    SPELL_GROW                                  = 31698, //grow visual

    // Elder
    SPELL_DRAINED_OF_POWER                      = 62467, //while freya encounter in progress
    // Elder Brightleaf
    // all spells are triggered
    SPELL_SOLAR_FLARE_10                        = 62240, // Target Amount is affected by stackamount of Brightleaf flux
    SPELL_SOLAR_FLARE_25                        = 62920, // Target Amount is affected by stackamount of Brightleaf flux
    SPELL_UNSTABLE_ENERGY_10                    = 62217, // Remove Unstable Sun Beam Buff
    SPELL_UNSTABLE_ENERGY_25                    = 62922,
    SPELL_PHOTOSYNTHESIS                        = 62209, // While standing in Beam
    SPELL_BRIGHTLEAF_FLUX                       = 62262, // script effect needs to trigger 62239
    SPELL_BRIGHTLEAF_FLUX_BUFF                  = 62239, // randomstack 1-8
    SPELL_FLUX_PLUS                             = 62251, // randomspell with flux
    SPELL_FLUX_MINUS                            = 62252, // randomspell with flux
    SPELL_UNSTABLE_SUN_BEAM_SUMMON              = 62207, // 62921, 62221, 64088
    SPELL_UNSTABLE_SUN_BEAM_PERIODIC            = 62211, // Triggers the Beam, triggers 62243
    SPELL_UNSTABLE_SUN_BEAM_TRIGGERD            = 62243,
    SPELL_UNSTABLE_SUN_BEAM_VISUAL              = 62216,

    //Elder Ironbranch
    //only impale is not triggered
    SPELL_IMPALE_10                             = 62310,
    SPELL_IMPALE_25                             = 62928,
    SPELL_THORN_SWARM_10                        = 62285, // Need Target fix ?
    SPELL_THORN_SWARM_25                        = 62931,
    SPELL_IRON_ROOTS_10                         = 62438,
    SPELL_IRON_ROOTS_25                         = 62861,

    //Elder Stonebark
    //every spell is not triggered
    SPELL_FISTS_OF_STONE                        = 62344,
    SPELL_GROUND_TREMOR_10                      = 62325,
    SPELL_GROUND_TREMOR_25                      = 62932,
    SPELL_PETRIFIED_BARK_10                     = 62337,
    SPELL_PETRIFIED_BARK_25                     = 62933,
};

enum Entrys
{
    ENTRY_CREATURE_FREYA                        = 32906,
    ENTRY_CREATURE_ELDER_BRIGHTLEAF             = 32915,

    ENTRY_GAMEOBJECT_NATURE_BOMB                = 194902,


    ENTRY_CREATURE_SNAPLASHER                   = 32916,
    ENTRY_CREATURE_STORM_LASHER                 = 32919,
    ENTRY_CREATURE_DETONATING_LASHER            = 32918,
    ENTRY_CREATURE_ANCIENT_WATER_SPIRIT         = 33202,

    ENTRY_CREATURE_HEALTHY_SPORE_VISUAL         = 62538,
    ENTRY_CREATURE_FREYA_ROOTS                  = 33088,

    ENTRY_CREATURE_UNSTABLE_SUN_BEAM            = 33050,
    ENTRY_CREATURE_EONARS_GIFT                  = 33228,
    ENTRY_CREATURE_SUNBEAM                      = 33170,
};

enum Models
{
    MODEL_INVISIBLE                             = 11686,
};

enum Phase
{
    PHASE_SPAWNING,
    PHASE_NOT_SPAWNING
};

const uint32 WaveSpells[3] =
{
    SPELL_SUMMON_WAVE_10,
    SPELL_SUMMON_WAVE_3,
    SPELL_SUMMON_WAVE_1
};

enum Actions
{
    ACTION_ELEMENTAL_DEAD,
};

class boss_freya : public CreatureScript
{
public:
    boss_freya() : CreatureScript("boss_freya") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_freyaAI(pCreature);
    }

    struct boss_freyaAI : public ScriptedAI
    {
        boss_freyaAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            if(pInstance)
                EncounterFinished = (pInstance->GetData(TYPE_FREYA) == DONE);
        }

        InstanceScript* pInstance;
        bool EncounterFinished;

        uint32 SpawnWaves[3];
        uint32 WaveCount;

        uint32 uiWave_Timer;
        uint32 Berserk_Timer;
        uint32 Lifebinders_Gift_Timer;
        uint32 uiSunbeam_Timer;
        uint32 Ground_Tremor_Timer;
        uint32 Iron_Roots_Timer;

        uint32 uiNaturalBomb_Timer;


        bool bIsElderBrightleafAlive;
        bool bIsElderIronbranchAlive;
        bool bIsElderStonebarkAlive;

        // Dont know yet if needet
        //Phase m_Phase;

        void Reset()
        {
            if(EncounterFinished)
            {
                me->setFaction(35);
            }else
            {
                //m_Phase = PHASE_SPAWNING;

                pInstance->SetData(TYPE_FREYA,NOT_STARTED);
                InitSpawnWaves();

                WaveCount = 0;
                uiWave_Timer = 60000;
                Ground_Tremor_Timer = 30000;
                Iron_Roots_Timer = 22000;
                uiSunbeam_Timer = urand(20000,30000);
                Berserk_Timer = 600000;
                Lifebinders_Gift_Timer = 30000;
                uiNaturalBomb_Timer = 30000;

                bIsElderBrightleafAlive = bIsElderIronbranchAlive = bIsElderStonebarkAlive = false;
            }
        }

        void KilledUnit(Unit * /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
        }

        void DamageTaken(Unit* attacker, uint32 &amount)
        {
            if(amount > me->GetHealth())
            {
                amount = 0;
                EncounterIsDone();
            }
        }

        void InitSpawnWaves()
        {
             memset(&SpawnWaves, 0, sizeof(SpawnWaves));
             uint32 i_rand = urand(0,2);
             switch(i_rand)
             {
             case 0:
                 SpawnWaves[0] = i_rand;
                 if(urand(0,1) == 0)
                 {
                     SpawnWaves[1] = 1;
                     SpawnWaves[2] = 2;
                 }else
                 {
                     SpawnWaves[1] = 2;
                     SpawnWaves[2] = 1;
                 }
                 break;
             case 1:
                 SpawnWaves[0] = i_rand;
                 if(urand(0,1) == 0)
                 {
                      SpawnWaves[1] = 0;
                      SpawnWaves[2] = 2;
                 }else
                 {
                      SpawnWaves[1] = 2;
                      SpawnWaves[2] = 0;
                 }
                 break;
             case 2:
                 SpawnWaves[0] = i_rand;
                 if(urand(0,1) == 0)
                 {
                      SpawnWaves[1] = 0;
                      SpawnWaves[2] = 1;
                 }else
                 {
                      SpawnWaves[1] = 1;
                      SpawnWaves[2] = 0;
                 }
                 break;
             }
        }

        void DoSummonWave()
        {
            uint32 spawntype = WaveCount % 3;
            DoCast(WaveSpells[SpawnWaves[spawntype]]);
            WaveCount++;
        }

        uint32 GetElderCount()
        {
            uint32 i = 0;
            if(bIsElderBrightleafAlive) i++;
            if(bIsElderIronbranchAlive) i++;
            if(bIsElderStonebarkAlive) i++;
            return i;
        }

        void EncounterIsDone()
        {
            EncounterFinished = true;
            DoScriptText(SAY_DEATH, me);
            if(pInstance)
                pInstance->SetData(TYPE_FREYA,DONE);

            switch(GetElderCount())
            {
            case 3:
                pInstance->DoCompleteAchievement(RAID_MODE(ACHIEVMENT_KNOCK_KNOCK_KNOCK_ON_THE_WOOD_10, ACHIEVMENT_KNOCK_KNOCK_KNOCK_ON_THE_WOOD_25));
            case 2:
                pInstance->DoCompleteAchievement(RAID_MODE(ACHIEVMENT_KNOCK_KNOCK_ON_THE_WOOD_10, ACHIEVMENT_KNOCK_KNOCK_ON_THE_WOOD_25));
            case 1:
                pInstance->DoCompleteAchievement(RAID_MODE(ACHIEVMENT_KNOCK_ON_THE_WOOD_10, ACHIEVMENT_KNOCK_ON_THE_WOOD_25));
                break;
            }

            if(me->GetAuraCount(SPELL_ATTUNED_TO_NATURE) >= 25)
                pInstance->DoCompleteAchievement(RAID_MODE(ACHIEVMENT_GETTING_BACK_TO_NATURE_10, ACHIEVMENT_GETTING_BACK_TO_NATURE_25));

            me->AI()->EnterEvadeMode();
            // cast is not rewarding the achievement.
            // DoCast(SPELL_ACHIEVEMENT_CHECK);
            pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_ACHIEVEMENT_CHECK);
        }

        void SetAttunedToNatureAura()
        {
            DoCast(RAID_MODE(SPELL_TOUCH_OF_EONAR_10,SPELL_TOUCH_OF_EONAR_25));
            me->AddAura(SPELL_ATTUNED_TO_NATURE,me);
            me->SetAuraStack(SPELL_ATTUNED_TO_NATURE,me,150);
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoScriptText(SAY_AGGRO, me);

            SetAttunedToNatureAura();

            if(pInstance)
            {
                pInstance->SetBossState(TYPE_FREYA,IN_PROGRESS);

                if(Creature* elder = Creature::GetCreature(*me,pInstance->GetData64(TYPE_ELDER_BRIGHTLEAF)))
                {
                    if(bIsElderBrightleafAlive = elder->isAlive())
                    {
                        //me->AddAura(SPELL_BRIGHTLEAFS_ESSENCE_AURA,me);
                        me->CastSpell(me,SPELL_BRIGHTLEAFS_ESSENCE_AURA,true);
                        elder->CastSpell(elder,SPELL_DRAINED_OF_POWER,false);
                    }
                }
                if(Creature* elder = Creature::GetCreature(*me,pInstance->GetData64(TYPE_ELDER_IRONBRANCH)))
                {
                    if(bIsElderIronbranchAlive = elder->isAlive())
                    {
                        //me->AddAura(SPELL_IRONBRANCHS_ESSENCE_AURA,me);
                        me->CastSpell(me,SPELL_IRONBRANCHS_ESSENCE_AURA,true);
                        elder->CastSpell(elder,SPELL_DRAINED_OF_POWER,false);
                    }
                }
                if(Creature* elder = Creature::GetCreature(*me,pInstance->GetData64(TYPE_ELDER_STONEBARK)))
                {
                    if(bIsElderStonebarkAlive = elder->isAlive())
                    {
                        me->AddAura(SPELL_STONEBARKS_ESSENCE_AURA,me);
                        //me->CastSpell(me,SPELL_STONEBARKS_ESSENCE_AURA,true);
                        elder->CastSpell(elder,SPELL_DRAINED_OF_POWER,false);
                    }
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if(WaveCount < 6)
                if(uiWave_Timer < diff)
                {
                    if(!me->IsNonMeleeSpellCasted(false))
                    {
                        DoSummonWave();
                        uiWave_Timer = 60000;
                    }
                }else uiWave_Timer -= diff;
            else
            {
                if(uiNaturalBomb_Timer <= diff)
                {
                    std::list<Player*> plrList = me->GetNearestPlayersList(500);
                    int max = urand(10,15);
                    for (std::list<Player*>::const_iterator itr = plrList.begin(); itr != plrList.end(); ++itr)
                    {
                        if((*itr))
                        {
                            me->CastSpell((*itr),SPELL_NATURE_BOMB_VISUAL,true);
                            if(max <= 0)
                                break;
                            else
                                max--;
                        }
                    }
                    uiNaturalBomb_Timer = urand(20000,30000);
                }else uiNaturalBomb_Timer -= diff;
            }

            if(Berserk_Timer <= diff)
            {
                if(!me->HasAura(SPELL_BERSERK))
                    DoCast(me,SPELL_BERSERK,true);
            } else Berserk_Timer -= diff;

            //Hardmode Elder Stonebark
            if(bIsElderStonebarkAlive)
            {
                if(Ground_Tremor_Timer <= diff)
                {
                    if(!me->IsNonMeleeSpellCasted(false))
                    {
                        DoCast(RAID_MODE(SPELL_FREYA_GROUND_TREMOR_10, SPELL_FREYA_GROUND_TREMOR_25));
                        Ground_Tremor_Timer = 30000;
                    }
                    else Ground_Tremor_Timer = 3000;
                }
                else Ground_Tremor_Timer -= diff;	
            }

            //Hardmode Elder Ironbranch
            if(bIsElderIronbranchAlive)
            {
                if(Iron_Roots_Timer <= diff)
                {
                    if(!me->IsNonMeleeSpellCasted(false))
                    {
                        Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0);
                        pTarget->CastSpell(pTarget, RAID_MODE(SPELL_FREYA_IRON_ROOTS_10, SPELL_FREYA_IRON_ROOTS_25), false);
                        Iron_Roots_Timer = urand(25000,30000);
                    }
                    else Iron_Roots_Timer = 3000;
                }
                else Iron_Roots_Timer -= diff;
            }

            if(Lifebinders_Gift_Timer <= diff)
            {
                DoCastAOE(RAID_MODE(SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_1,SPELL_LIFEBINDERS_GIFT_TRIGGER_MISSILE_2),true);
                Lifebinders_Gift_Timer = 35000 + urand(2000, 10000);
            } else Lifebinders_Gift_Timer -= diff;

            if(uiSunbeam_Timer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    if(Unit* target = SelectTarget(SELECT_TARGET_RANDOM,1,500,true))
                        DoCast(target,RAID_MODE(SPELL_SUNBEAM_10,SPELL_SUNBEAM_25));
                    else
                        DoCast(me->getVictim(),RAID_MODE(SPELL_SUNBEAM_10,SPELL_SUNBEAM_25));
                    uiSunbeam_Timer = urand(20000,30000);
                }
                else uiSunbeam_Timer = 3000;
            } else uiSunbeam_Timer -= diff;

            DoMeleeAttackIfReady();

            //EnterEvadeIfOutOfCombatArea(diff);
        }
    };
};


class mob_natural_bomb : public CreatureScript
{
public:
    mob_natural_bomb() : CreatureScript("mob_natural_bomb") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_natural_bombAI(pCreature);
    }

    struct mob_natural_bombAI : public ScriptedAI
    {
        mob_natural_bombAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
        }

        uint32 uiExplosion_Timer;

        void Reset()
        {
            me->SetReactState(REACT_PASSIVE);
            me->setFaction(14);
            DoCast(SPELL_NATURE_BOMB_VISUAL_OBJECT);
            uiExplosion_Timer = 10000;
        }

        void UpdateAI(const uint32 diff)
        {
            if(uiExplosion_Timer < diff)
            {
                if (GameObject *go_bomb = me->FindNearestGameObject(ENTRY_GAMEOBJECT_NATURE_BOMB, 20.0f))
                    go_bomb->Use(me);

                    DoCast(RAID_MODE(SPELL_NATURE_BOMB_EXPLOSION,SPELL_NATURE_BOMB_EXPLOSION_H));
                    me->DealDamage(me,me->GetHealth());
                    me->RemoveCorpse();
                uiExplosion_Timer = 10000;
            }else uiExplosion_Timer -= diff;
        }
    };
};

class spell_freya_natural_bomb_spell : public SpellScriptLoader
{
public:
    spell_freya_natural_bomb_spell() : SpellScriptLoader("spell_freya_natural_bomb_spell") { }

    class spell_freya_natural_bomb_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_freya_natural_bomb_SpellScript);

        void OnHitEffect()
        {
            if (Player* target = GetHitPlayer())
            {
                target->CastSpell(target,SPELL_NATURE_BOMB_SUMMON,true);
            }
        }

        void Register()
        {
            OnHit += SpellHitFn(spell_freya_natural_bomb_SpellScript::OnHitEffect);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_freya_natural_bomb_SpellScript();
    }
};

class spell_attuned_to_nature_remove_spell : public SpellScriptLoader
{
public:
    spell_attuned_to_nature_remove_spell() : SpellScriptLoader("spell_attuned_to_nature_remove") { }

    class spell_attuned_to_nature_remove_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_attuned_to_nature_remove_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (!GetCaster() || GetCaster()->GetTypeId() != TYPEID_UNIT)
                    return;

            if (Unit* unitTarget = GetHitUnit())
            {
                uint8 count = 0;
                switch(GetSpellInfo()->Id)
                {
                case SPELL_ATTUNED_TO_NATURE_REMOVE_2 : count = 2; break;
                case SPELL_ATTUNED_TO_NATURE_REMOVE_10 : count = 10; break;
                case SPELL_ATTUNED_TO_NATURE_REMOVE_25 : count = 25; break;
                }
                if(Aura* aur = unitTarget->GetAura(SPELL_ATTUNED_TO_NATURE, unitTarget->GetGUID()))
                    aur->ModStackAmount(-count);
            }
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_attuned_to_nature_remove_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_attuned_to_nature_remove_SpellScript();
    }
};

class spell_summon_wave_effect_10mob_spell : public SpellScriptLoader
{
public:
    spell_summon_wave_effect_10mob_spell() : SpellScriptLoader("spell_summon_wave_effect_10mob") { }

    class spell_summon_wave_effect_10mob_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_summon_wave_effect_10mob_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (!GetCaster() || GetCaster()->GetTypeId() != TYPEID_UNIT)
                    return;

            for(uint8 i = 0; i < 10; i++)
                GetCaster()->CastSpell(GetCaster(),SPELL_SUMMON_WAVE_10_SUMMON,true);
        }

        void Register()
        {
            OnEffect += SpellEffectFn(spell_summon_wave_effect_10mob_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_summon_wave_effect_10mob_SpellScript();
    }
};

class mob_detonating_lasher : public CreatureScript
{
public:
    mob_detonating_lasher() : CreatureScript("mob_detonating_lasher") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_detonating_lasherAI (pCreature);
    }

    struct mob_detonating_lasherAI : public ScriptedAI
    {
        mob_detonating_lasherAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        };

        InstanceScript* m_pInstance;
        uint32 Flame_Lash_Timer;

        void Reset()
        {
            if(Unit* target = me->SelectNearbyTarget(100))
                me->AI()->AttackStart(target);
            Flame_Lash_Timer = urand(6000,10000);
        }

        void JustDied(Unit* )
        {
            DoCast(me,RAID_MODE(SPELL_DETONATE_10, SPELL_DETONATE_25),true);
            if (Creature* freya = me->FindNearestCreature(ENTRY_CREATURE_FREYA, 10000))
                DoCast(freya, SPELL_ATTUNED_TO_NATURE_REMOVE_2,true);
        }

        void JustSummoned(Unit* )
        {
            me->CombatStart(me->SelectNearestTarget(), true);
        }

        void updateAI(const uint32 diff)
        {
            if(m_pInstance && m_pInstance->GetBossState(TYPE_FREYA) != IN_PROGRESS)
            {
                me->DealDamage(me,me->GetMaxHealth());
                me->RemoveCorpse();
            }

            if (!UpdateVictim())
                return;

            if(Flame_Lash_Timer <= diff)
            {
                DoCast(me->getVictim(),SPELL_FLAME_LASH);
                Flame_Lash_Timer = urand(6000,10000);
            }
            else Flame_Lash_Timer -= diff;
        }

    };
};

class mob_ancient_water_spirit : public CreatureScript
{
public:
    mob_ancient_water_spirit() : CreatureScript("mob_ancient_water_spirit") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_ancient_water_spiritAI (pCreature);
    }

    struct mob_ancient_water_spiritAI : public ScriptedAI
    {
        mob_ancient_water_spiritAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            alreadyKilled = false;
        };

        InstanceScript* m_pInstance;
        uint32 Tidal_Wave_Timer;
        bool alreadyKilled;

        void Reset()
        {
            Tidal_Wave_Timer = 20000;

            if(Unit* target = me->SelectNearbyTarget(100))
                me->AI()->AttackStart(target);
        }

        void JustDied(Unit* )
        {
            if (Creature* Freya = me->GetCreature(*me, m_pInstance->GetData64(TYPE_FREYA)))
            {
                if(!alreadyKilled) DoCast(Freya, SPELL_ATTUNED_TO_NATURE_REMOVE_10,true);
                alreadyKilled = true;
                Freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(m_pInstance && m_pInstance->GetBossState(TYPE_FREYA) != IN_PROGRESS)
            {
                me->DealDamage(me,me->GetMaxHealth());
                me->RemoveCorpse();
            }

            if (!UpdateVictim())
                return;

            if(Tidal_Wave_Timer <= diff)
            {
                DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_TIDAL_WAVE_10, SPELL_TIDAL_WAVE_25));
                Tidal_Wave_Timer = 20000;
            }
            else {Tidal_Wave_Timer -= diff;}

            DoMeleeAttackIfReady();
        }

    };
};

class mob_storm_lasher : public CreatureScript
{
public:
    mob_storm_lasher() : CreatureScript("mob_storm_lasher") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_storm_lasherAI (pCreature);
    }
    
    struct mob_storm_lasherAI : public ScriptedAI
    {
        mob_storm_lasherAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            alreadyKilled = false;
        };

        InstanceScript* m_pInstance;
        uint32 Lightning_Lash_Timer;
        uint32 Stormbolt_Timer;
        bool alreadyKilled;

        void Reset()
        {
            Lightning_Lash_Timer = 6000;
            Stormbolt_Timer = 3000;

            if(Unit* target = me->SelectNearbyTarget(100))
                me->AI()->AttackStart(target);
        }

        void JustDied(Unit* )
        {
            if (Creature* Freya = me->GetCreature(*me, m_pInstance->GetData64(TYPE_FREYA)))
            {
                if(!alreadyKilled) DoCast(Freya, SPELL_ATTUNED_TO_NATURE_REMOVE_10,true);
                alreadyKilled = true;
                Freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if(m_pInstance && m_pInstance->GetBossState(TYPE_FREYA) != IN_PROGRESS)
            {
                me->DealDamage(me,me->GetMaxHealth());
                me->RemoveCorpse();
            }

            if (!UpdateVictim())
                return;

            if(Lightning_Lash_Timer <= diff)
            {
                DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_LIGHTNING_LASH_10, SPELL_LIGHTNING_LASH_25));
                Lightning_Lash_Timer = 6000;
            }
            else { Lightning_Lash_Timer -= diff; }

            if(Stormbolt_Timer <= diff)
            {
                DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_STORMBOLT_10, SPELL_STORMBOLT_25));
                Stormbolt_Timer = 3000;
            }
            else { Stormbolt_Timer -= diff; }

            DoMeleeAttackIfReady();
        }
    };
};

class mob_snaplasher : public CreatureScript
{
public:
    mob_snaplasher() : CreatureScript("mob_snaplasher") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_snaplasherAI (pCreature);
    }

    struct mob_snaplasherAI : public ScriptedAI
    {
        mob_snaplasherAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
            alreadyKilled = false;
        };

        InstanceScript* m_pInstance;
        bool alreadyKilled;

        void Reset()
        {
            if(Unit* target = me->SelectNearbyTarget(100))
                me->AI()->AttackStart(target);
        }

        void EnterCombat(Unit* )
        {
            DoCast(me, RAID_MODE(SPELL_HARDENED_BARK_10, SPELL_HARDENED_BARK_25));
        }

        void JustDied(Unit* )
        {
            if (Creature* Freya = me->GetCreature(*me, m_pInstance->GetData64(TYPE_FREYA)))
            {
                if(!alreadyKilled) DoCast(Freya, SPELL_ATTUNED_TO_NATURE_REMOVE_10,true);
                alreadyKilled = true;
                Freya->AI()->DoAction(ACTION_ELEMENTAL_DEAD);
            }
        }

        void JustSummoned(Unit* )
        {
            me->CombatStart(me->SelectNearestTarget(), true);
        }

        void UpdateAI(const uint32 diff)
        {
            if(m_pInstance && m_pInstance->GetBossState(TYPE_FREYA) != IN_PROGRESS)
            {
                me->DealDamage(me,me->GetMaxHealth());
                me->RemoveCorpse();
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_ancient_conservator : public CreatureScript
{
public:
    mob_ancient_conservator() : CreatureScript("mob_ancient_conservator") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_ancient_conservatorAI (pCreature);
    }

    struct mob_ancient_conservatorAI : public ScriptedAI
    {
        mob_ancient_conservatorAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        };

        InstanceScript* m_pInstance;
        uint32 Natures_Fury_Timer;
        uint32 Healthy_Spore_Spawn_Timer;
        Position pos;
        Creature* freya;

        void Reset()
        {
            Natures_Fury_Timer = 10000;
            Healthy_Spore_Spawn_Timer = 15000+(rand()%8000);

            if(Unit* target = me->SelectNearbyTarget(100))
                me->AI()->AttackStart(target);
        }

        void EnterCombat(Unit* )
        {
            DoCast(SPELL_CONSERVATORS_GRIP);

            for(int i = 1; i <= 6; ++i)
            {
                me->GetRandomNearPosition(pos, 35);
                me->SummonCreature(33215, pos, TEMPSUMMON_TIMED_DESPAWN, 30000+(rand()%6000));
            }
        }

        void JustDied(Unit* )
        {
            if (Creature* freya = me->FindNearestCreature(ENTRY_CREATURE_FREYA, 10000))
                DoCast(freya, SPELL_ATTUNED_TO_NATURE_REMOVE_25,true);
        }

        void JustSummoned(Unit* )
        {
            me->CombatStart(me->SelectNearestTarget(), true);
        }

        void UpdateAI(const uint32 diff)
        {
            if(m_pInstance && m_pInstance->GetBossState(TYPE_FREYA) != IN_PROGRESS)
            {
                me->DealDamage(me,me->GetMaxHealth());
                me->RemoveCorpse();
            }

            if (!UpdateVictim())
                return;

            if(Natures_Fury_Timer <= diff)
            {
                DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_NATURES_FURY_10, SPELL_NATURES_FURY_25));
                Natures_Fury_Timer = 15000;
            }
            else {Natures_Fury_Timer -= diff;}

            if(Healthy_Spore_Spawn_Timer <= diff)
            {
                me->GetRandomNearPosition(pos, 35);
                me->SummonCreature(33215, pos, TEMPSUMMON_TIMED_DESPAWN, 30000);
                Healthy_Spore_Spawn_Timer = 1500 + urand(1000,3500);
            }
            else {Healthy_Spore_Spawn_Timer -= diff;}

            DoMeleeAttackIfReady();
        }
    };
};

class mob_healthy_spore : public CreatureScript
{
public:
    mob_healthy_spore() : CreatureScript("mob_healthy_spore") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_healthy_sporeAI(pCreature);
    }

    struct mob_healthy_sporeAI : public ScriptedAI
    {
        mob_healthy_sporeAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        };

        InstanceScript* m_pInstance;
        uint8 Counter;
        uint16 Grow_Timer;
        uint16 Shrink_Timer;

        bool Shrink;

        void Reset()
        {
            Counter = 0;
            Grow_Timer = 1000+(rand()%4000);
            Shrink_Timer = 2000;
            DoCast(me, ENTRY_CREATURE_HEALTHY_SPORE_VISUAL);
            me->AddAura(SPELL_POTENT_PHEROMONES, me);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->setFaction(35);
            Shrink = false;
        }

        void UpdateAI(const uint32 diff)
        {
            if(m_pInstance && m_pInstance->GetBossState(TYPE_FREYA) != IN_PROGRESS)
            {
                me->DealDamage(me,me->GetMaxHealth());
                me->RemoveCorpse();
            }

            if(Grow_Timer <= diff && Counter < 9 && Shrink == false)
            {
                ++Counter;
                DoCast(me, SPELL_GROW);
                Grow_Timer = 2000+(urand(300, 1000));
            }
            else if(Grow_Timer > diff && Counter < 9 && Shrink == false)
            {
                Grow_Timer -= diff;
            }

            if(Shrink_Timer <= diff && Counter >= 9)
            {
                me->DisappearAndDie();
            }

            if(Shrink_Timer >= diff && Counter >= 9)
            {
                Shrink_Timer -= diff;
                Shrink = true;
                me->RemoveAurasDueToSpell(SPELL_GROW);
            }
        }
    };
};


class mob_elder_brightleaf : public CreatureScript
{
public:
    mob_elder_brightleaf() : CreatureScript("mob_elder_brightleaf") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_elder_brightleafAI(pCreature);
    }

    struct mob_elder_brightleafAI : public ScriptedAI
    {
        mob_elder_brightleafAI(Creature *pCreature) : ScriptedAI(pCreature) { };

        uint32 Solar_Flare_Timer;
        uint32 Flux_Timer;
        uint32 Unstable_Sunbeam_Timer;
        uint32 Unstable_Energy_Timer;

        void Reset()
        {
            Solar_Flare_Timer = 10000;
            Flux_Timer = 1000;
            Unstable_Sunbeam_Timer = 5000;
        }

        void EnterCombat(Unit* )
        {
            DoScriptText(SAY_BRIGHTLEAF_AGGRO, me);
        }

        void KilledUnit(Unit* )
        {
            DoScriptText(RAND(SAY_BRIGHTLEAF_SLAY_1, SAY_BRIGHTLEAF_SLAY_2), me);
        }

        void JustDied(Unit* )
        {
            DoScriptText(SAY_IRONBRANCH_AGGRO, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(Solar_Flare_Timer <= diff)
            {
                uint32 target_count = me->GetAuraCount(SPELL_BRIGHTLEAF_FLUX_BUFF);
                me->CastCustomSpell(RAID_MODE(SPELL_SOLAR_FLARE_10, SPELL_SOLAR_FLARE_25),SPELLVALUE_MAX_TARGETS,target_count,me,true);
                //DoCastAOE(RAID_MODE(SPELL_SOLAR_FLARE_10, SPELL_SOLAR_FLARE_25),true);
                Solar_Flare_Timer = 10000 + urand(1500, 6000);
            }
            else { Solar_Flare_Timer -= diff; }

            if (Unstable_Sunbeam_Timer <= diff)
            {
                // Das gefaellt mir nicht
                Unit* target[2];
                target[0] = SelectTarget(SELECT_TARGET_RANDOM, 0);
                target[1] = SelectTarget(SELECT_TARGET_RANDOM, 0);

                if(target[0])
                    me->SummonCreature(ENTRY_CREATURE_UNSTABLE_SUN_BEAM, target[0]->GetPositionX(), target[0]->GetPositionY(), target[0]->GetPositionZ());
                if(target[1])
                    me->SummonCreature(ENTRY_CREATURE_UNSTABLE_SUN_BEAM, target[1]->GetPositionX(), target[1]->GetPositionY(), target[1]->GetPositionZ());
                Unstable_Sunbeam_Timer = 30000;
            }
            else {Unstable_Sunbeam_Timer -= diff;}

            // Workaround for Spellscript
            if(Flux_Timer <= diff)
            {
                me->RemoveAurasDueToSpell(SPELL_FLUX_PLUS);
                me->RemoveAurasDueToSpell(SPELL_FLUX_MINUS);

                me->CastSpell(me,SPELL_BRIGHTLEAF_FLUX,true);
                if(!me->HasAura(SPELL_BRIGHTLEAF_FLUX_BUFF))
                    me->CastSpell(me,SPELL_BRIGHTLEAF_FLUX_BUFF,true);
                me->SetAuraStack(SPELL_BRIGHTLEAF_FLUX_BUFF,me,urand(1,10));
                uint8 flux = rand() %2;
                if(flux == 1)
                    me->AddAura(SPELL_FLUX_PLUS, me);
                else
                    me->AddAura(SPELL_FLUX_MINUS, me);
                Flux_Timer = 5000;
            }else Flux_Timer -= diff;

            DoMeleeAttackIfReady();
        }

    };
};

// Need more work
class mob_unstable_sunbeam : public CreatureScript
{
public:
    mob_unstable_sunbeam() : CreatureScript("mob_unstable_sunbeam") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_unstable_sunbeamAI(pCreature);
    }

    struct mob_unstable_sunbeamAI : public Scripted_NoMovementAI
    {
        mob_unstable_sunbeamAI(Creature* pCreature) : Scripted_NoMovementAI(pCreature) {}

        //uint32 Despawn_Timer;
        //uint16 Aura_Timer;
        //uint32 Range_Check_Timer;
        //Unit* sb_old;
        //Unit* sb_new;

        void Reset()
        {
            //sb_old = NULL;
            //sb_new = NULL;
            //me->AddAura(VISUAL_UNSTABLE_SUNBEAM, me);
            //DoCast(SPELL_PHOTOSYNTHESIS);
            //Despawn_Timer = 20000;
            //Aura_Timer = 1000;
            //Range_Check_Timer = 500;
            //me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE );
            //me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            //me->SetDisplayId(MODEL_INVISIBLE);
        }

        void UpdateAI(const uint32 diff)
        {

            //if(Despawn_Timer <= diff)
            //{
            // Aura_Timer = 5000;
            // DoCast(RAID_MODE(SPELL_UNSTABLE_ENERGY_10, SPELL_UNSTABLE_ENERGY_25));
            // me->RemoveAura(SPELL_UNSTABLE_SUN_BEAM_VISUAL);
            // if(sb_new)
            // sb_new->RemoveAura(AURA_UNSTABLE_SUNBEAM);
            // me->ForcedDespawn();
            //}
            //else {Despawn_Timer -= diff;}

            //if(Aura_Timer <= diff)
            //{
            // if(sb_new = me->SelectNearestTarget(1))
            // {
            // if(sb_old != NULL && sb_new != sb_old)
            // {
            // sb_old->RemoveAura(AURA_UNSTABLE_SUNBEAM);
            // }
            // sb_new->AddAura(AURA_UNSTABLE_SUNBEAM, sb_new);
            // sb_old = sb_new;
            // }
            // Aura_Timer = 1000;
            //} else Aura_Timer -= diff;

            //if(Range_Check_Timer <= diff)
            //{

            // if(sb_new && !sb_new->IsInRange(me, 0, 1))
            // {
            // sb_new->RemoveAura(AURA_UNSTABLE_SUNBEAM);
            // }
            // Range_Check_Timer = 200;
            //} else Range_Check_Timer -= diff;
        }
    };
};


class mob_elder_ironbranch : public CreatureScript
{
public:
   mob_elder_ironbranch() : CreatureScript("mob_elder_ironbranch") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_elder_ironbranchAI(pCreature);
    }

    struct mob_elder_ironbranchAI : public ScriptedAI
    {
        mob_elder_ironbranchAI(Creature *pCreature) : ScriptedAI(pCreature) { };

        uint32 Impale_Timer;
        uint32 Iron_Roots_Timer;
        uint32 Thorn_Swarm_Timer;

        void EnterCombat(Unit* )
        {
            DoScriptText(SAY_IRONBRANCH_AGGRO, me);
        }

        void Reset()
        {
            Impale_Timer = 45000;
            Iron_Roots_Timer = 15000;
            Thorn_Swarm_Timer = 2000;
        }

        void KilledUnit(Unit* )
        {
            DoScriptText(RAND(SAY_IRONBRANCH_SLAY_1, SAY_IRONBRANCH_SLAY_2), me);
        }

        void JustDied(Unit* )
        {
            DoScriptText(SAY_IRONBRANCH_DEATH, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(Impale_Timer <= diff)
            {
                DoScriptText(SAY_IRONBRANCH_DEATH, me);
                DoCast(me->getVictim(), RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25));
                Impale_Timer = 20000;
            }
            else { Impale_Timer -= diff; }

            if(Iron_Roots_Timer <= diff)
            {
                Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM);
                pTarget->CastSpell(pTarget, RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25), true);
                Iron_Roots_Timer = urand(20000, 30000);
            }
            else Iron_Roots_Timer -= diff;

            if(Thorn_Swarm_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_THORN_SWARM_10, SPELL_THORN_SWARM_25));
                Thorn_Swarm_Timer = 20000;
            }
            else {Thorn_Swarm_Timer -= diff;}

            DoMeleeAttackIfReady();
        }

    };
};


class mob_elder_stonebark : public CreatureScript
{
public:
   mob_elder_stonebark() : CreatureScript("mob_elder_stonebark") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_elder_stonebarkAI(pCreature);
    }

    struct mob_elder_stonebarkAI : public ScriptedAI
    {
        mob_elder_stonebarkAI(Creature *pCreature) : ScriptedAI(pCreature) { };

        uint32 Fists_Of_Stone_Timer;
        uint32 Ground_Tremor_Timer;
        uint32 Petrified_Bark_Timer;

        void EnterCombat(Unit* )
        {
            DoScriptText(SAY_STONEBARK_AGGRO, me);
        }

        void Reset()
        {
            Fists_Of_Stone_Timer = 25000;
            Ground_Tremor_Timer = 12000;
            Petrified_Bark_Timer = 17000;
        }

        void KilledUnit(Unit* )
        {
            DoScriptText(RAND(SAY_STONEBARK_SLAY_1, SAY_STONEBARK_SLAY_2), me);
        }

        void JustDied(Unit* )
        {
            DoScriptText(SAY_STONEBARK_DEATH, me);
        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            if(Fists_Of_Stone_Timer <= diff)
            {
                DoCast(SPELL_FISTS_OF_STONE);
                Fists_Of_Stone_Timer = 45000;
            }
            else {Fists_Of_Stone_Timer -= diff;}

            if(Ground_Tremor_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_GROUND_TREMOR_10, SPELL_GROUND_TREMOR_25));
                Ground_Tremor_Timer = 200000 + urand(3000, 10000);
            }
            else {Ground_Tremor_Timer -= diff;}

            if(Petrified_Bark_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_PETRIFIED_BARK_10, SPELL_PETRIFIED_BARK_25));
                Petrified_Bark_Timer = 40000;
            }
            else {Petrified_Bark_Timer -= diff;}

            DoMeleeAttackIfReady();
        }
    };
};

class mob_eonars_gift : public CreatureScript
{
public:
   mob_eonars_gift() : CreatureScript("mob_eonars_gift") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_eonars_giftAI (pCreature);
    }

    struct mob_eonars_giftAI : public ScriptedAI
    {
        mob_eonars_giftAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;

        uint32 Grow_Timer;
        uint32 Lifebinders_Gift_Timer;
        uint8 GrowCount;

        void Reset()
        {
            me->setFaction(16);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            Grow_Timer = 100;
            Lifebinders_Gift_Timer = 12000;
            GrowCount = 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if(m_pInstance && m_pInstance->GetBossState(TYPE_FREYA) != IN_PROGRESS)
            {
                me->DealDamage(me,me->GetMaxHealth());
                me->RemoveCorpse();
            }

            if(GrowCount < 6)
                if(Grow_Timer <= diff && GrowCount < 6)
                {
                    DoCast(me, SPELL_GROW);
                    Grow_Timer = 2000;
                    ++GrowCount;
                }
                else Grow_Timer -= diff;

            if(Lifebinders_Gift_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_LIFEBINDERS_GIFT_10, SPELL_LIFEBINDERS_GIFT_25));
                Lifebinders_Gift_Timer = 6000;
            }
            else {Lifebinders_Gift_Timer -= diff;}
        }
    };
};


//Hardmode Elder Brightleaf
class spell_freya_sunbeam : public SpellScriptLoader
{
public:
    spell_freya_sunbeam() : SpellScriptLoader("spell_freya_sunbeam") { }

    class spell_freya_sunbeam_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_freya_sunbeam_SpellScript);

        Unit* Caster;
        Unit* Target;

        void OnHitEffect()
        {
            Caster = GetCaster();
            Target = GetHitUnit();
            if(Caster->FindNearestCreature(ENTRY_CREATURE_ELDER_BRIGHTLEAF, 5000, true))
                Caster->SummonCreature(ENTRY_CREATURE_SUNBEAM, Target->GetPositionX(), Target->GetPositionY(), Target->GetPositionZ());
        }

        void Register()
        {
            OnHit += SpellHitFn(spell_freya_sunbeam_SpellScript::OnHitEffect);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_freya_sunbeam_SpellScript();
    }
};


//Sunbeam Freya
class mob_freya_sunbeam : public CreatureScript
{
public:
  mob_freya_sunbeam() : CreatureScript("mob_freya_sunbeam") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_freya_sunbeamAI(pCreature);
    }

    struct mob_freya_sunbeamAI : public ScriptedAI
    {
        mob_freya_sunbeamAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        uint32 Despawn_Timer;
        uint32 Unstable_Energy_Timer;

        void Reset()
        {
            Unstable_Energy_Timer = 2000;
            Despawn_Timer = 12000;
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE );
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->SetDisplayId(MODEL_INVISIBLE);
            me->setFaction(16);
        }

        void UpdateAI(const uint32 diff)
        {
            if(Despawn_Timer <= diff)
                me->ForcedDespawn();
            else Despawn_Timer -= diff;

            if(Unstable_Energy_Timer <= diff)
            {
                DoCast(RAID_MODE(SPELL_FREYA_UNSTABLE_ENERGY_10, SPELL_FREYA_UNSTABLE_ENERGY_25));
                Unstable_Energy_Timer = 15000;
                me->AddAura(SPELL_UNSTABLE_SUN_BEAM_VISUAL, me);
            }
            else Unstable_Energy_Timer -= diff;
        }
    };
};

//Freya HM and Elder Ironbranch
class mob_iron_roots : public CreatureScript
{
public:
   mob_iron_roots() : CreatureScript("mob_iron_roots") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_iron_rootsAI(pCreature);
    }

    struct mob_iron_rootsAI : public ScriptedAI
    {
        mob_iron_rootsAI(Creature *pCreature) : ScriptedAI(pCreature) { };

        uint64 RootsGUID;

        void EnterCombat(Unit* )
        {
            Unit* pTarget = me->SelectNearestTarget(1);
            RootsGUID = me->GetGUID();
        }

        void JustDied(Unit* )
        {
            Unit* Roots = Unit::GetUnit((*me),RootsGUID);
            if(Roots->HasAura(RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25)))
                Roots->RemoveAura(RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25));
            if(Roots->HasAura(RAID_MODE(SPELL_FREYA_IRON_ROOTS_10, SPELL_FREYA_IRON_ROOTS_25)))
                Roots->RemoveAura(RAID_MODE(SPELL_FREYA_IRON_ROOTS_10, SPELL_FREYA_IRON_ROOTS_25));
        }
    };
};



/*
UPDATE creature_template SET ScriptName = "boss_freya" WHERE Entry = 32906;
UPDATE creature_template SET ScriptName = "mob_detonating_lasher" WHERE Entry = 32918;
UPDATE creature_template SET ScriptName = "mob_ancient_water_spirit" WHERE Entry = 33202;
UPDATE creature_template SET ScriptName = "mob_storm_lasher" WHERE Entry = 32919;
UPDATE creature_template SET ScriptName = "mob_snaplasher" WHERE Entry = 32916;
UPDATE creature_template SET ScriptName = "mob_ancient_conservator" WHERE Entry = 33203;
UPDATE creature_template SET ScriptName = "mob_healthy_spore" WHERE Entry = 33215;
UPDATE creature_template SET ScriptName = "mob_elder_brightleaf" WHERE Entry = 32915;
UPDATE creature_template SET ScriptName = "mob_elder_ironbranch" WHERE Entry = 32913;
UPDATE creature_template SET ScriptName = "mob_elder_stonebark" WHERE Entry = 32914;
UPDATE creature_template SET ScriptName = "mob_unstable_sunbeam" WHERE Entry = 33050;
UPDATE creature_template SET ScriptName = "mob_eonars_gift" WHERE Entry = 33228;
UPDATE gameobject_template SET ScriptName = "mob_natural_bomb" WHERE ENTRY = 194902;
UPDATE creature_template SET ScriptName = "mob_iron_roots" WHERE Entry = 33168;
UPDATE creature_template SET ScriptName = "mob_iron_roots" WHERE Entry = 33088;
UPDATE creature_template SET ScriptName = "mob_freya_sunbeam" WHERE Entry = 33170;
UPDATE creature_template SET unit_flags = 4 WHERE ENTRY = 33168;
UPDATE creature_template SET unit_flags = 4 WHERE ENTRY = 33088;
UPDATE creature_template SET faction_A = 16 WHERE Entry = 33168;
UPDATE creature_template SET faction_H = 16 WHERE Entry = 33168;

DELETE FROM spell_script_names WHERE spell_id IN (62623,62872);
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES
(62623, "spell_freya_sunbeam"),
(62872, "spell_freya_sunbeam");
DELETE FROM spell_script_names WHERE spell_id = 64648;
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES (64648,"spell_freya_natural_bomb_spell");
DELETE FROM spell_script_names WHERE spell_id IN (62524,62525,62521);
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES
(62524,"spell_attuned_to_nature_remove"),
(62525,"spell_attuned_to_nature_remove"),
(62521,"spell_attuned_to_nature_remove");
DELETE FROM spell_script_names WHERE spell_id = 62688;
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES (62688,"spell_summon_wave_effect_10mob");
*/

void AddSC_boss_freya()
{
    new boss_freya();
    new mob_natural_bomb();
    new spell_freya_natural_bomb_spell();
    new spell_attuned_to_nature_remove_spell();
    new spell_summon_wave_effect_10mob_spell();
    new mob_detonating_lasher();
    new mob_ancient_water_spirit();
    new mob_storm_lasher();
    new mob_snaplasher();
    new mob_ancient_conservator();
    new mob_elder_ironbranch();
    new mob_elder_stonebark();
    new mob_elder_brightleaf();
    new mob_unstable_sunbeam();
    new mob_eonars_gift();
    new mob_healthy_spore();
    new spell_freya_sunbeam();
    new mob_freya_sunbeam();
    new mob_iron_roots();
}