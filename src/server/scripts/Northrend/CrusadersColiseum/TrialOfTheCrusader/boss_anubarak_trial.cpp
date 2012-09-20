/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: boss_anubarak_trial
SD%Complete: ??%
SDComment: based on /dev/rsa
SDCategory:
EndScriptData */

// Known bugs:
// Anubarak - underground phase partially not worked
//          - tele after impale hit a permafrost doesn't work (the entire tele spell should be better)
// Burrow   - visual is vanishing
// Burrower - Spider Frenzy not working as it should (frenzy not stacking)
// Scarab   - Kill credit isn't crediting?
// FrostSph - often they are casting Permafrost a little above the ground

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "trial_of_the_crusader.h"

enum Yells
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    EMOTE_SUBMERGE          = 2,
    EMOTE_BURROWER          = 3,
    SAY_EMERGE              = 4,
    SAY_LEECHING_SWARM      = 5,
    EMOTE_LEECHING_SWARM    = 6,
    SAY_KILL_PLAYER         = 7,
    SAY_DEATH               = 8,

    EMOTE_SPIKE             = 0,
};

enum Summons
{
    NPC_FROST_SPHERE     = 34606,
    NPC_BURROW           = 34862,
    NPC_BURROWER         = 34607,
    NPC_SCARAB           = 34605,
    NPC_SPIKE            = 34660,
};

enum BossSpells
{
    SPELL_FREEZE_SLASH      = 66012,
    SPELL_PENETRATING_COLD  = 66013,
    SPELL_LEECHING_SWARM    = 66118,
    SPELL_LEECHING_HEAL     = 66125,
    SPELL_LEECHING_DAMAGE   = 66240,
    SPELL_MARK              = 67574,
    SPELL_SPIKE_CALL        = 66169,
    SPELL_SUBMERGE_ANUBARAK = 65981,
    SPELL_CLEAR_ALL_DEBUFFS = 34098,
    SPELL_EMERGE_ANUBARAK   = 65982,
    SPELL_SUMMON_BEATLES    = 66339,
    SPELL_SUMMON_BURROWER   = 66332,

    // Burrow
    SPELL_CHURNING_GROUND   = 66969,

    // Scarab
    SPELL_DETERMINATION     = 66092,
    SPELL_TRIGGERED_ACID_MANDIBLE_0 = 65775,
    SPELL_TRIGGERED_ACID_MANDIBLE_1 = 67861,
    SPELL_TRIGGERED_ACID_MANDIBLE_2 = 67862,
    SPELL_TRIGGERED_ACID_MANDIBLE_3 = 67863,

    // Burrower
    SPELL_SPIDER_FRENZY     = 66129,
    SPELL_EXPOSE_WEAKNESS   = 67720, //Passive - Triggered
    SPELL_SHADOW_STRIKE     = 66134,
    SPELL_SUBMERGE_EFFECT   = 53421,
    SPELL_EMERGE_EFFECT     = 66947,

    SUMMON_SCARAB           = NPC_SCARAB,
    SUMMON_FROSTSPHERE      = NPC_FROST_SPHERE,
    SPELL_BERSERK           = 26662,

    //Frost Sphere
    SPELL_FROST_SPHERE      = 67539,
    SPELL_PERMAFROST_VISUAL = 65882,

    //Spike
    SPELL_SUMMON_SPIKE      = 66169,
    SPELL_SPIKE_SPEED1      = 65920,
    SPELL_SPIKE_TRAIL       = 65921,
    SPELL_SPIKE_SPEED2      = 65922,
    SPELL_SPIKE_SPEED3      = 65923,
    SPELL_SPIKE_FAIL        = 66181,
    SPELL_SPIKE_TELE        = 66170,
};

#define SPELL_PERMAFROST    RAID_MODE(66193, 67855, 67856, 67857)
#define SPELL_IMPALE        RAID_MODE(65919, 67858, 67859, 67860)

enum SummonActions
{
    ACTION_SHADOW_STRIKE,
};

const Position SphereSpawn[6] =
{
    { 776.8380f, 125.6795f, 155.6701f, 0 },
    { 786.4426f, 145.5566f, 155.6701f, 0 },
    { 759.1386f, 163.9654f, 155.6701f, 0 },
    { 744.3701f, 119.5211f, 155.6701f, 0 },
    { 710.0211f, 120.8152f, 155.6701f, 0 },
    { 706.6383f, 161.5266f, 155.6701f, 0 },
};

enum MovementPoints
{
    POINT_FALL_GROUND           = 1
};

class boss_anubarak_trial : public CreatureScript
{
public:
    boss_anubarak_trial() : CreatureScript("boss_anubarak_trial") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_anubarak_trialAI(creature);
    };

    struct boss_anubarak_trialAI : public ScriptedAI
    {
        boss_anubarak_trialAI(Creature* creature) : ScriptedAI(creature), Summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        SummonList Summons;

        uint32 m_uiFreezeSlashTimer;
        uint32 m_uiPenetratingColdTimer;
        uint32 m_uiSummonNerubianTimer;
        uint32 m_uiNerubianShadowStrikeTimer;
        uint32 m_uiSubmergeTimer;
        float m_posPursuingSpikePositionX;
        float m_posPursuingSpikePositionY;
        float m_posPursuingSpikePositionZ;
        uint32 m_uiPursuingSpikeTimer;
        uint32 m_uiSummonScarabTimer;
        uint32 m_uiSummonFrostSphereTimer;
        uint32 m_uiBerserkTimer;

        uint8  m_uiStage;
        bool   m_bIntro;
        bool   m_bReachedPhase3;
        uint64 m_uiTargetGUID;

        void Reset()
        {
            m_uiFreezeSlashTimer = 15*IN_MILLISECONDS;
            m_uiPenetratingColdTimer = 20*IN_MILLISECONDS;
            m_uiNerubianShadowStrikeTimer = 30*IN_MILLISECONDS;
            m_uiSummonNerubianTimer = 10*IN_MILLISECONDS;
            m_uiSubmergeTimer = 80*IN_MILLISECONDS;

            m_posPursuingSpikePositionX = 0.0f;
            m_posPursuingSpikePositionY = 0.0f;
            m_posPursuingSpikePositionZ = 0.0f;
            m_uiPursuingSpikeTimer = 2*IN_MILLISECONDS;

            m_uiSummonFrostSphereTimer = urand(20, 30)*1000;

            m_uiBerserkTimer = 10*MINUTE*IN_MILLISECONDS;
            m_uiStage = 0;
            m_bIntro = true;
            m_bReachedPhase3 = false;
            m_uiTargetGUID = 0;
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_PERMAFROST, true);
            Summons.DespawnAll();
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_KILL_PLAYER);
                if (instance)
                    instance->SetData(DATA_TRIBUTE_TO_IMMORTALITY_ELIGIBLE, 0);
            }
        }

        void MoveInLineOfSight(Unit* /*who*/)
        {
            if (!m_bIntro)
            {
                Talk(SAY_INTRO);
                m_bIntro = false;
            }
        }

        void JustReachedHome()
        {
            if (instance)
                instance->SetData(TYPE_ANUBARAK, FAIL);
        }

        void JustDied(Unit* /*killer*/)
        {
            Summons.DespawnAll();
            Talk(SAY_DEATH);
            if (instance)
                instance->SetData(TYPE_ANUBARAK, DONE);
        }

        void JustSummoned(Creature* summoned)
        {
            switch (summoned->GetEntry())
            {
                case NPC_BURROW:
                    summoned->SetReactState(REACT_PASSIVE);
                    summoned->CastSpell(summoned, SPELL_CHURNING_GROUND, false);
                    break;
                case NPC_SPIKE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                    {
                        summoned->AI()->AttackStart(target);
                        Talk(EMOTE_SPIKE, target->GetGUID());
                    }
                    else
                        m_uiPursuingSpikeTimer = 2000;
                    break;
                case NPC_BURROWER:
                case NPC_SCARAB:
                    summoned->setFaction(14);
                    DoZoneInCombat(summoned);
                    break;
            }
            Summons.Summon(summoned);
        }

        void SummonedCreatureDespawn(Creature* summoned)
        {
            switch (summoned->GetEntry())
            {
                case NPC_SPIKE:
                    m_posPursuingSpikePositionX = summoned->GetPositionX();
                    m_posPursuingSpikePositionY = summoned->GetPositionY();
                    m_posPursuingSpikePositionZ = summoned->GetPositionZ();
                    m_uiPursuingSpikeTimer = 2*IN_MILLISECONDS;
                    break;
            }

            Summons.Despawn(summoned);
        }

        uint32 GetPlayerCountInFrostSphereZones()
        {
            uint32 counter = 0;
            Map* map = me->GetMap();

            if (map && map->IsDungeon())
            {
                Map::PlayerList const &PlayerList = map->GetPlayers();

                if (PlayerList.isEmpty())
                    return 0;

                for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                {
                    if (i->getSource())
                    {
                        if (i->getSource()->isAlive())
                        {
                            if (i->getSource()->HasAura(SPELL_PERMAFROST))
                                counter++;
                        }
                    }
               }
            }

            return counter;
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            DoZoneInCombat();
            if (instance)
                instance->SetData(TYPE_ANUBARAK, IN_PROGRESS);

            //Spawn Frost Spheres
            for (int i=0; i < 6; i++)
                me->SummonCreature(NPC_FROST_SPHERE, SphereSpawn[i]);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (m_uiStage)
            {
                case 0:
                    if (m_uiFreezeSlashTimer <= uiDiff)
                    {
                        DoCastVictim(SPELL_FREEZE_SLASH);
                        m_uiFreezeSlashTimer = urand(8*1000, 10*1000);
                    } else m_uiFreezeSlashTimer -= uiDiff;

                    if (m_uiPenetratingColdTimer <= uiDiff)
                    {
                        me->CastCustomSpell(SPELL_PENETRATING_COLD, SPELLVALUE_MAX_TARGETS, RAID_MODE(2, 5, 2, 5));
                        m_uiPenetratingColdTimer = 18000;
                    } else m_uiPenetratingColdTimer -= uiDiff;

                    if (IsHeroic() || !m_bReachedPhase3)
                    {
                        if (m_uiSummonNerubianTimer <= uiDiff)
                        {
                            uint8 maxSpawns = RAID_MODE(1, 2, 2, 4);

                            for (uint8 i = 0; i < maxSpawns; i++)
                                me->SummonCreature(NPC_BURROWER, AnubarakLoc[i+2], TEMPSUMMON_CORPSE_DESPAWN);

                            m_uiSummonNerubianTimer = 40000;
                        } else m_uiSummonNerubianTimer -= uiDiff;
                    }

                    if (IsHeroic())
                    {
                        if (m_uiNerubianShadowStrikeTimer <= uiDiff)
                        {
                            EntryCheckPredicate pred(NPC_BURROWER);
                            Summons.DoAction(ACTION_SHADOW_STRIKE, pred);
                            m_uiNerubianShadowStrikeTimer = urand(20*1000, 30*1000);
                        } else m_uiNerubianShadowStrikeTimer -= uiDiff;
                    }

                    if (!m_bReachedPhase3 && !me->HasAura(SPELL_BERSERK))
                    {
                        if (m_uiSubmergeTimer <= uiDiff)
                        {
                            m_uiStage = 1;
                            m_uiSubmergeTimer = 60*1000;
                        } else m_uiSubmergeTimer -= uiDiff;
                    }
                    break;
                case 1:
                    DoCast(me, SPELL_SUBMERGE_ANUBARAK);
                    DoCast(me, SPELL_CLEAR_ALL_DEBUFFS);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    Talk(EMOTE_BURROWER);
                    m_uiPursuingSpikeTimer = 2000;
                    m_uiSummonScarabTimer = 4*IN_MILLISECONDS;
                    m_uiStage = 2;
                    break;
                case 2:
                    if (m_uiPursuingSpikeTimer <= uiDiff)
                    {
                        // replace spell with manual spawning so we can restart the spike where it left off.
                        //DoCast(SPELL_SPIKE_CALL);
                        if (m_posPursuingSpikePositionX == 0.0f || m_posPursuingSpikePositionY == 0.0f || m_posPursuingSpikePositionZ == 0.0f)
                            me->SummonCreature(NPC_SPIKE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                        else
                            me->SummonCreature(NPC_SPIKE, m_posPursuingSpikePositionX, m_posPursuingSpikePositionY, m_posPursuingSpikePositionZ);
                        // Just to make sure it won't happen again in this phase
                        m_uiPursuingSpikeTimer = 90*IN_MILLISECONDS;
                    } else m_uiPursuingSpikeTimer -= uiDiff;

                    if (m_uiSummonScarabTimer <= uiDiff)
                    {
                        uint32 playersInFrostSphere = GetPlayerCountInFrostSphereZones();

                        if (playersInFrostSphere > 0)
                        {
                            uint8 location = 2;
                            for (uint8 i = 0; i < playersInFrostSphere * RAID_MODE(1, 2, 2, 3); i++)
                            {
                                location++;

                                if (location >= 6)
                                    location = 2;

                                me->SummonCreature(NPC_SCARAB, AnubarakLoc[location], TEMPSUMMON_CORPSE_DESPAWN);
                            }
                        }
                        else
                        {
                            if (!me->GetMap())
                                return;

                            if (!me->GetMap()->IsDungeon())
                                return;

                            uint32 count = 0;

                            switch (me->GetMap()->GetDifficulty())
                            {
                                case RAID_DIFFICULTY_10MAN_NORMAL:
                                    count = urand(1, 2);
                                    break;
                                case RAID_DIFFICULTY_25MAN_NORMAL:
                                    count = 2;
                                    break;
                                case RAID_DIFFICULTY_10MAN_HEROIC:
                                    count = 2;
                                    break;
                                case RAID_DIFFICULTY_25MAN_HEROIC:
                                    count = urand(2, 3);
                                    break;
                            }

                            for (uint8 i = 0; i < count; i++)
                                me->SummonCreature(NPC_SCARAB, AnubarakLoc[i+2], TEMPSUMMON_CORPSE_DESPAWN);
                        }

                        m_uiSummonScarabTimer = 10000;
                    } else m_uiSummonScarabTimer -= uiDiff;

                    if (m_uiSubmergeTimer <= uiDiff)
                    {
                        m_uiStage = 3;
                        m_uiSubmergeTimer = 80*IN_MILLISECONDS;
                    } else m_uiSubmergeTimer -= uiDiff;
                    break;
                case 3:
                    m_uiStage = 0;
                    Summons.DespawnEntry(NPC_SPIKE);
                    m_posPursuingSpikePositionX = 0.0f;
                    m_posPursuingSpikePositionY = 0.0f;
                    m_posPursuingSpikePositionZ = 0.0f;
                    me->RemoveAurasDueToSpell(SPELL_SUBMERGE_ANUBARAK);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    DoCast(me, SPELL_EMERGE_ANUBARAK);
                    me->GetMotionMaster()->MoveChase(me->getVictim());
                    m_uiSummonNerubianTimer = 10*1000;
                    m_uiNerubianShadowStrikeTimer = urand(20*1000, 30*1000);
                    break;
            }

            if (!IsHeroic())
            {
                if (m_uiSummonFrostSphereTimer <= uiDiff)
                {
                    uint8 frostSpheresWithAuraCount = 0;
                    for(std::list<uint64>::const_iterator itr = Summons.begin(); itr != Summons.end(); ++itr)
                    {
                        if (Creature* temp = Unit::GetCreature(*me,* itr))
                        {
                            if (temp)
                            {
                                if (temp->GetEntry() == NPC_FROST_SPHERE)
                                {
                                    if (temp->HasAura(SPELL_FROST_SPHERE))
                                    {
                                        frostSpheresWithAuraCount++;
                                    }
                                }
                            }
                        }
                    }

                    for(uint8 i = 0; i < 6 - frostSpheresWithAuraCount; i++)
                        me->SummonCreature(NPC_FROST_SPHERE, SphereSpawn[urand(0, 5)]);

                    m_uiSummonFrostSphereTimer = urand(20, 30)*1000;
                } else m_uiSummonFrostSphereTimer -= uiDiff;
            }

            if (HealthBelowPct(30) && m_uiStage == 0 && !m_bReachedPhase3)
            {
                m_bReachedPhase3 = true;
                DoCastAOE(SPELL_LEECHING_SWARM, true);
                Talk(EMOTE_LEECHING_SWARM);
                Talk(SAY_LEECHING_SWARM);
            }

            if (m_uiBerserkTimer <= uiDiff && !me->HasAura(SPELL_BERSERK))
            {
                DoCast(me, SPELL_BERSERK);
            } else m_uiBerserkTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};

class mob_swarm_scarab : public CreatureScript
{
public:
    mob_swarm_scarab() : CreatureScript("mob_swarm_scarab") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_swarm_scarabAI(creature);
    };

    struct mob_swarm_scarabAI : public ScriptedAI
    {
        mob_swarm_scarabAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        uint32 m_uiDeterminationTimer;
        uint32 m_uiAcidMandibleTimer;

        void Reset()
        {
            me->SetCorpseDelay(0);
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_PERMAFROST, true);
            m_uiDeterminationTimer = urand(5*1000, 60*1000);
            m_uiAcidMandibleTimer = 3500;
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                me->AddThreat(target, 20000.0f);
        }

        void JustDied(Unit* killer)
        {
            DoCast(killer, RAID_MODE(SPELL_TRAITOR_KING_10, SPELL_TRAITOR_KING_25));
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            /* Bosskillers don't recognize */
            if (m_uiDeterminationTimer <= uiDiff)
            {
                DoCast(me, SPELL_DETERMINATION);
                m_uiDeterminationTimer = urand(10*IN_MILLISECONDS, 60*IN_MILLISECONDS);
            } else m_uiDeterminationTimer -= uiDiff;

            if (m_uiAcidMandibleTimer <= uiDiff)
            {
                m_uiAcidMandibleTimer = 3500;

                if (!me->getVictim() || !instance)
                    return;

                //If we are within range melee the target
                if (me->IsWithinMeleeRange(me->getVictim()))
                {
                    if (me->getVictim()->HasAura(RAID_MODE(SPELL_TRIGGERED_ACID_MANDIBLE_0, SPELL_TRIGGERED_ACID_MANDIBLE_1, SPELL_TRIGGERED_ACID_MANDIBLE_2, SPELL_TRIGGERED_ACID_MANDIBLE_3)))
                    {
                        if (Aura* aur = me->getVictim()->GetAura(RAID_MODE(SPELL_TRIGGERED_ACID_MANDIBLE_0, SPELL_TRIGGERED_ACID_MANDIBLE_1, SPELL_TRIGGERED_ACID_MANDIBLE_2, SPELL_TRIGGERED_ACID_MANDIBLE_3)))
                        {
                            if (aur->GetStackAmount() < 40)
                                aur->SetStackAmount(aur->GetStackAmount() + 1);

                            if (aur->GetStackAmount() == 40)
                                aur->SetStackAmount(40);
                        }
                    }
                    else
                    {
                        if (Creature* anubarak = Unit::GetCreature(*me, instance->GetData64(NPC_ANUBARAK)))
                            me->CastSpell(me->getVictim(), RAID_MODE(SPELL_TRIGGERED_ACID_MANDIBLE_0, SPELL_TRIGGERED_ACID_MANDIBLE_1, SPELL_TRIGGERED_ACID_MANDIBLE_2, SPELL_TRIGGERED_ACID_MANDIBLE_3), true, 0, 0, instance->GetData64(NPC_ANUBARAK));
                    }
                }
            } else m_uiAcidMandibleTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};

class mob_nerubian_burrower : public CreatureScript
{
public:
    mob_nerubian_burrower() : CreatureScript("mob_nerubian_burrower") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_nerubian_burrowerAI(creature);
    };

    struct mob_nerubian_burrowerAI : public ScriptedAI
    {
        mob_nerubian_burrowerAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        uint32 m_uiSpiderFrenzyTimer;
        uint32 m_uiSubmergeTimer;

        void Reset()
        {
            me->SetCorpseDelay(0);
            m_uiSpiderFrenzyTimer = 2000;
            m_uiSubmergeTimer = 30*1000;
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_PERMAFROST, true);
            DoCast(me, SPELL_EXPOSE_WEAKNESS);
        }

        void DoAction(const int32 actionId)
        {
            switch (actionId)
            {
                case ACTION_SHADOW_STRIKE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        DoCast(target, SPELL_SHADOW_STRIKE);
                    break;
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (m_uiSubmergeTimer <= uiDiff)
            {
                if (me->HasAura(SPELL_SUBMERGE_EFFECT))
                {
                    me->RemoveAurasDueToSpell(SPELL_SUBMERGE_EFFECT);
                    DoCast(me, SPELL_EMERGE_EFFECT);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                }
                else
                {
                    // Just for security purposes, sometimes they get stuck unattackable, this one should solve the problem
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);

                    if (HealthBelowPct(80))
                    {
                        std::list<Creature*> sphereList;
                        me->GetCreatureListWithEntryInGrid(sphereList, NPC_FROST_SPHERE, 6.0f);

                        bool readyToSubmerge = true;

                        if (!sphereList.empty())
                        {
                            for (std::list<Creature*>::const_iterator itr = sphereList.begin(); itr != sphereList.end(); ++itr)
                            {
                                if (Creature* creature = (*itr))
                                {
                                    if (creature->GetDynObject(SPELL_PERMAFROST))
                                    {
                                        readyToSubmerge = false;
                                    }
                                }
                            }
                        }

                        if (readyToSubmerge)
                        {
                            uint32 setHealthVal = 0;

                            uint32 percentageAddVal = (uint32)(me->GetMaxHealth() * 0.4);
                            uint32 currentHealthVal = me->GetHealth();

                            setHealthVal = percentageAddVal + currentHealthVal;

                            if (setHealthVal > me->GetMaxHealth())
                                setHealthVal = me->GetMaxHealth();

                            me->SetHealth(setHealthVal);

                            DoCast(me, SPELL_SUBMERGE_EFFECT);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                        }
                    }
                }
                m_uiSubmergeTimer = 20*1000;
            } else m_uiSubmergeTimer -= uiDiff;

            if (m_uiSpiderFrenzyTimer <= uiDiff)
            {
                std::list<Creature*> burrowerCreatureList;
                me->GetCreatureListWithEntryInGrid(burrowerCreatureList, me->GetEntry(), 12.0f);

                bool doCastFrenzy = false;

                if (!burrowerCreatureList.empty())
                {
                    for (std::list<Creature*>::const_iterator itr = burrowerCreatureList.begin(); itr != burrowerCreatureList.end(); ++itr)
                    {
                        if (Creature* creature = (*itr))
                        {
                            if (creature->GetGUID() != me->GetGUID())
                            {
                                if (!creature->HasAura(SPELL_SUBMERGE_EFFECT))
                                {
                                    doCastFrenzy = true;
                                    break;
                                }
                            }
                        }
                    }
                }

                if (doCastFrenzy)
                    me->AddAura(SPELL_SPIDER_FRENZY, me);

                m_uiSpiderFrenzyTimer = 2000;
            } else m_uiSpiderFrenzyTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};

class mob_frost_sphere : public CreatureScript
{
    public:
        mob_frost_sphere() : CreatureScript("mob_frost_sphere") { }

        struct mob_frost_sphereAI : public ScriptedAI
        {
            mob_frost_sphereAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                _isFalling = false;
                me->SetReactState(REACT_PASSIVE);
                //! Confirmed sniff 3.3.5.a
                me->SetDisableGravity(true);
                me->SetByteValue(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_ALWAYS_STAND | UNIT_BYTE1_FLAG_HOVER);
                //! end
                me->SetDisplayId(me->GetCreatureTemplate()->Modelid2);
                me->SetSpeed(MOVE_FLIGHT, 0.5f, false);
                me->GetMotionMaster()->MoveRandom(20.0f);
                DoCast(SPELL_FROST_SPHERE);
            }

            void DamageTaken(Unit* /*who*/, uint32& damage)
            {
                if (me->GetHealth() <= damage)
                {
                    damage = 0;
                    if (!_isFalling)
                    {
                        _isFalling = true;
                        me->GetMotionMaster()->MoveIdle();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        //At hit the ground
                        me->HandleEmoteCommand(EMOTE_ONESHOT_FLYDEATH);

                        // In this case MoveFall might fail, but we are close to ground, so create permafrost now
                        float tz = me->GetMap()->GetHeight(me->GetPhaseMask(), me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), true, MAX_FALL_DISTANCE);
                        if (tz > INVALID_HEIGHT)
                        {
                            if (fabs(me->GetPositionZ() - tz) < 0.1f)
                            {
                                DoTeleportTo(me->GetPositionX(), me->GetPositionY(), tz);
                                me->StopMoving();
                                me->GetMotionMaster()->Clear();
                                me->GetMotionMaster()->MoveIdle();
                                me->RemoveAurasDueToSpell(SPELL_FROST_SPHERE);
                                me->SetDisplayId(me->GetCreatureTemplate()->Modelid2);
                                DoCast(SPELL_PERMAFROST_VISUAL);
                                DoCast(SPELL_PERMAFROST);
                                me->SetObjectScale(2.0f);
                                return;
                            }
                        }

                        me->GetMotionMaster()->MoveFall(POINT_FALL_GROUND);
                    }
                }
            }

            void MovementInform(uint32 type, uint32 pointId)
            {
                if (type != EFFECT_MOTION_TYPE)
                    return;

                switch (pointId)
                {
                    case POINT_FALL_GROUND:
                        me->RemoveAurasDueToSpell(SPELL_FROST_SPHERE);
                        me->SetDisplayId(me->GetCreatureTemplate()->Modelid2);
                        DoCast(SPELL_PERMAFROST_VISUAL);
                        DoCast(SPELL_PERMAFROST);
                        me->SetObjectScale(2.0f);
                        break;
                }
            }

            // Empty EnterEvadeMode and UpdateAI, so it will not reset if victim died, will be despawned by Anub'Arak anyways
            void EnterEvadeMode()
            {
            }

            void UpdateAI(const uint32 /*diff*/)
            {
            }

        private:
            bool _isFalling;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_frost_sphereAI(creature);
        };
};

class mob_anubarak_spike : public CreatureScript
{
public:
    mob_anubarak_spike() : CreatureScript("mob_anubarak_spike") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_anubarak_spikeAI(creature);
    };

    struct mob_anubarak_spikeAI : public ScriptedAI
    {
        mob_anubarak_spikeAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 m_uiIncreaseSpeedTimer;
        uint8  m_uiSpeed;
        uint64 m_uiTargetGUID;

        void Reset()
        {
            m_uiTargetGUID = 0;
        }

        bool CanAIAttack(Unit const* victim) const
        {
            return victim->GetTypeId() == TYPEID_PLAYER;
        }

        void AttackStart(Unit* who)
        {
            if (!who)
                return;

            me->AddThreat(who, 5000000.0f);
            m_uiTargetGUID = who->GetGUID();
            DoCast(me, SPELL_SPIKE_TRAIL, true);
            Talk(EMOTE_SPIKE, who->GetGUID());
            me->SetSpeed(MOVE_RUN, 0.5f);
            m_uiSpeed = 0;
            m_uiIncreaseSpeedTimer = 1*1000;
            UnitAI::AttackStart(who);
        }

        void DamageTaken(Unit* /*who*/, uint32& uiDamage)
        {
            uiDamage = 0;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            std::list<Creature*> sphereList;
            me->GetCreatureListWithEntryInGrid(sphereList, NPC_FROST_SPHERE, 6.0f);

            if (!sphereList.empty())
            {
                for (std::list<Creature*>::const_iterator itr = sphereList.begin(); itr != sphereList.end(); ++itr)
                {
                    if (Creature* creature = (*itr))
                    {
                        if (creature->GetDynObject(SPELL_PERMAFROST))
                        {
                            creature->DisappearAndDie();
                            me->DisappearAndDie();
                            break;
                        }
                    }
                }
            }

            if (m_uiTargetGUID)
            {
                Unit* target = Unit::GetUnit((*me), m_uiTargetGUID);

                if (!target || !target->isAlive())
                {
                    me->DisappearAndDie();
                    return;
                }

                if (target)
                {
                    if (!target->HasAura(SPELL_MARK))
                    {
                        DoCast(target, SPELL_MARK, true);
                    }

                    if (!me->getVictim())
                    {
                        AttackStart(target);
                        me->AddThreat(target, 5000000.0f);
                    }
                }
            }

            if (m_uiIncreaseSpeedTimer)
            {
                if (m_uiIncreaseSpeedTimer <= uiDiff)
                {
                    switch (m_uiSpeed)
                    {
                        case 0:
                            DoCast(me, SPELL_SPIKE_SPEED1, true);
                            m_uiSpeed = 1;
                            m_uiIncreaseSpeedTimer = 7*IN_MILLISECONDS;
                            break;
                        case 1:
                            DoCast(me, SPELL_SPIKE_SPEED2, true);
                            m_uiSpeed = 2;
                            m_uiIncreaseSpeedTimer = 7*IN_MILLISECONDS;
                            break;
                        case 2:
                            DoCast(me, SPELL_SPIKE_SPEED3, true);
                            m_uiIncreaseSpeedTimer = 0;
                            break;
                    }
                } else m_uiIncreaseSpeedTimer -= uiDiff;
            }
        }
    };

};

void AddSC_boss_anubarak_trial()
{
    new boss_anubarak_trial();
    new mob_swarm_scarab();
    new mob_nerubian_burrower();
    new mob_anubarak_spike();
    new mob_frost_sphere();
}
