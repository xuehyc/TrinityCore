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
SDName: trial_of_the_crusader
SD%Complete: ??%
SDComment: based on /dev/rsa
SDCategory: Crusader Coliseum
EndScriptData */

// Known bugs:
// Some visuals aren't appearing right sometimes
//
// TODO:
// Redone summon's scripts in SAI
// Add immunities to the boss and summons

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "trial_of_the_crusader.h"

enum Yells
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    EMOTE_LEGION_FLAME      = 2,
    EMOTE_NETHER_PORTAL     = 3,
    SAY_MISTRESS_OF_PAIN    = 4,
    EMOTE_INCINERATE        = 5,
    SAY_INCINERATE          = 6,
    EMOTE_INFERNAL_ERUPTION = 7,
    SAY_INFERNAL_ERUPTION   = 8,
    SAY_KILL_PLAYER         = 9,
    SAY_DEATH               = 10,
    SAY_BERSERK             = 11,
};

enum Equipment
{
    EQUIP_MAIN           = 47266,
    EQUIP_OFFHAND        = 46996,
    EQUIP_RANGED         = 47267,
    EQUIP_DONE           = EQUIP_NO_CHANGE,
};

enum Summons
{
    NPC_LEGION_FLAME     = 34784,
    NPC_INFERNAL_VOLCANO = 34813,
    NPC_FEL_INFERNAL     = 34815, // immune to all CC on Heroic (stuns, banish, interrupt, etc)
    NPC_NETHER_PORTAL    = 34825,
    NPC_MISTRESS_OF_PAIN = 34826,
};

enum BossSpells
{
    SPELL_LEGION_FLAME          = 66197, // player should run away from raid because he triggers Legion Flame
    SPELL_LEGION_FLAME_EFFECT   = 66201, // used by trigger npc
    SPELL_NETHER_POWER          = 67108, // +20% of spell damage per stack, stackable up to 5/10 times, must be dispelled/stealed
    SPELL_FEL_LIGHTING          = 66528, // jumps to nearby targets
    SPELL_FEL_FIREBALL          = 66532, // does heavy damage to the tank, interruptable
    SPELL_INCINERATE_FLESH_0    = 66237, // target must be healed or will trigger Burning Inferno
    SPELL_INCINERATE_FLESH_1    = 67049,
    SPELL_INCINERATE_FLESH_2    = 67050,
    SPELL_INCINERATE_FLESH_3    = 67051,
    SPELL_BURNING_INFERNO       = 66242, // triggered by Incinerate Flesh
    SPELL_INFERNAL_ERUPTION     = 66255,
    SPELL_INFERNAL              = 66258,
    SPELL_NETHER_PORTAL         = 66264,

    SPELL_BERSERK                     = 64238, // unused

    // Mistress of Pain spells
    SPELL_SHIVAN_SLASH          = 67098,
    SPELL_SPINNING_STRIKE       = 66316,
    SPELL_MISTRESS_KISS         = 66359,
    SPELL_FEL_INFERNO           = 67047,
    SPELL_FEL_STREAK_0          = 66519,
    SPELL_FEL_STREAK_1          = 67042,
    SPELL_FEL_STREAK_2          = 67043,
    SPELL_FEL_STREAK_3          = 67044,
};

/*######
## boss_jaraxxus
######*/

class boss_jaraxxus : public CreatureScript
{
public:
    boss_jaraxxus() : CreatureScript("boss_jaraxxus") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_jaraxxusAI(creature);
    }

    struct boss_jaraxxusAI : public ScriptedAI
    {
        boss_jaraxxusAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            Reset();
        }

        InstanceScript* instance;

        uint32 m_uiFelFireballTimer;
        uint32 m_uiFelLightningTimer;
        uint32 m_uiIncinerateFleshTimer;
        uint32 m_uiNetherPowerTimer;
        uint32 m_uiLegionFlameTimer;
        uint32 m_uiSummonNetherPortalTimer;
        uint32 m_uiSummonInfernalEruptionTimer;

        void Reset()
        {
            DespawnAdds();
            me->SetReactState(REACT_PASSIVE);

            if (instance)
                instance->SetData(TYPE_JARAXXUS, NOT_STARTED);
            SetEquipmentSlots(false, EQUIP_MAIN, EQUIP_OFFHAND, EQUIP_RANGED);
            m_uiFelFireballTimer = 5*IN_MILLISECONDS;
            m_uiFelLightningTimer = urand(8*IN_MILLISECONDS, 12*IN_MILLISECONDS);
            m_uiIncinerateFleshTimer = urand(18*IN_MILLISECONDS, 23*IN_MILLISECONDS);
            m_uiNetherPowerTimer = urand(16*IN_MILLISECONDS, 20*IN_MILLISECONDS);
            m_uiLegionFlameTimer = urand(25*IN_MILLISECONDS, 35*IN_MILLISECONDS);
            m_uiSummonNetherPortalTimer = 1*MINUTE*IN_MILLISECONDS;
            m_uiSummonInfernalEruptionTimer = 2*MINUTE*IN_MILLISECONDS;
        }

        void JustReachedHome()
        {
            if (instance)
                instance->SetData(TYPE_JARAXXUS, FAIL);
            DoCast(me, SPELL_JARAXXUS_CHAINS);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
        }

        void DespawnAdds()
        {
            std::list<Creature*> despawnCreatureList;
            me->GetCreatureListWithEntryInGrid(despawnCreatureList, NPC_LEGION_FLAME, 150.0f);
            me->GetCreatureListWithEntryInGrid(despawnCreatureList, NPC_INFERNAL_VOLCANO, 150.0f);
            me->GetCreatureListWithEntryInGrid(despawnCreatureList, NPC_FEL_INFERNAL, 150.0f);
            me->GetCreatureListWithEntryInGrid(despawnCreatureList, NPC_NETHER_PORTAL, 150.0f);
            me->GetCreatureListWithEntryInGrid(despawnCreatureList, NPC_MISTRESS_OF_PAIN, 150.0f);
    
            if (!despawnCreatureList.empty())
            {
                for (std::list<Creature*>::const_iterator itr = despawnCreatureList.begin(); itr != despawnCreatureList.end(); ++itr)
                {
                    if (Creature* creature = (*itr))
                    {
                        creature->DespawnOrUnsummon();
                    }
                }
            }
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (instance)
                    instance->SetData(DATA_TRIBUTE_TO_IMMORTALITY_ELIGIBLE, 0);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            DespawnAdds();
            DoScriptText(SAY_DEATH, me);
            if (instance)
                instance->SetData(TYPE_JARAXXUS, DONE);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoZoneInCombat();

            if (instance)
                instance->SetData(TYPE_JARAXXUS, IN_PROGRESS);
            DoScriptText(SAY_AGGRO, me);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (m_uiSummonInfernalEruptionTimer <= uiDiff)
            {
                DoScriptText(EMOTE_INFERNAL_ERUPTION, me);
                DoScriptText(SAY_INFERNAL_ERUPTION, me);
                uint8 i = urand(2, 3);
                me->SummonCreature(NPC_INFERNAL_VOLCANO, JaraxxusLoc[i].GetPositionX(), JaraxxusLoc[i].GetPositionY(), JaraxxusLoc[i].GetPositionZ(), TEMPSUMMON_MANUAL_DESPAWN);
                m_uiSummonInfernalEruptionTimer = 2*MINUTE*IN_MILLISECONDS;
            } else m_uiSummonInfernalEruptionTimer -= uiDiff;

            if (m_uiSummonNetherPortalTimer <= uiDiff)
            {
                Talk(EMOTE_NETHER_PORTAL);
                Talk(SAY_MISTRESS_OF_PAIN);
                uint8 i = urand(2, 3);
                me->SummonCreature(NPC_NETHER_PORTAL, JaraxxusLoc[i].GetPositionX(), JaraxxusLoc[i].GetPositionY(), JaraxxusLoc[i].GetPositionZ(), TEMPSUMMON_MANUAL_DESPAWN);
                m_uiSummonNetherPortalTimer = 2*MINUTE*IN_MILLISECONDS;
            } else m_uiSummonNetherPortalTimer -= uiDiff;

            if (m_uiFelFireballTimer <= uiDiff)
            {
                DoCastVictim(SPELL_FEL_FIREBALL);
                m_uiFelFireballTimer = urand(9*IN_MILLISECONDS, 16*IN_MILLISECONDS);
            } else m_uiFelFireballTimer -= uiDiff;

            if (m_uiFelLightningTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                    DoCast(target, SPELL_FEL_LIGHTING);
                m_uiFelLightningTimer = urand(10*IN_MILLISECONDS, 15*IN_MILLISECONDS);
            } else m_uiFelLightningTimer -= uiDiff;

            if (m_uiIncinerateFleshTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0, true))
                {
                    if (me->IsValidAttackTarget(target) && target->isAlive())
                    {
                        DoScriptText(EMOTE_INCINERATE, me, target);
                        DoScriptText(SAY_INCINERATE, me);
                        me->AddAura(RAID_MODE(SPELL_INCINERATE_FLESH_0, SPELL_INCINERATE_FLESH_1, SPELL_INCINERATE_FLESH_2, SPELL_INCINERATE_FLESH_3), target);
                        m_uiIncinerateFleshTimer = urand(20*IN_MILLISECONDS, 25*IN_MILLISECONDS);
                    }
                    else
                    {
                        // Try to find a good target in 1 second again - target not attackable
                        m_uiIncinerateFleshTimer = 1000;
                    }
                }
                else
                {
                    // Try to find a good target in 1 second again - no target found
                    m_uiIncinerateFleshTimer = 1000;
                }
            } else m_uiIncinerateFleshTimer -= uiDiff;

            if (m_uiNetherPowerTimer <= uiDiff)
            {
                if (m_uiFelLightningTimer < 5*IN_MILLISECONDS) // prevent instant (buffed) fel lightning, give players time to purge
                    m_uiFelLightningTimer = 5*IN_MILLISECONDS;

                if (!me->HasAura(SPELL_NETHER_POWER))
                {
                    if (Aura* netherAura = me->AddAura(SPELL_NETHER_POWER, me))
                    {
                        netherAura->SetStackAmount(RAID_MODE(5, 10, 5, 10));
                        netherAura->SetCharges(RAID_MODE(5, 10, 5, 10));
                    }
                }
                m_uiNetherPowerTimer = urand(30*IN_MILLISECONDS, 40*IN_MILLISECONDS);
            } else m_uiNetherPowerTimer -= uiDiff;

            if (m_uiLegionFlameTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0, true))
                {
                    DoScriptText(EMOTE_LEGION_FLAME, me, target);
                    DoCast(target, SPELL_LEGION_FLAME);
                }
                m_uiLegionFlameTimer = urand(20*IN_MILLISECONDS, 30*IN_MILLISECONDS);
            } else m_uiLegionFlameTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

};

class mob_legion_flame : public CreatureScript
{
public:
    mob_legion_flame() : CreatureScript("mob_legion_flame") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_legion_flameAI(creature);
    }

    struct mob_legion_flameAI : public Scripted_NoMovementAI
    {
        mob_legion_flameAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            Reset();
        }

        void Reset()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            DoCast(SPELL_LEGION_FLAME_EFFECT);
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            UpdateVictim();
        }
    };

};

class mob_infernal_volcano : public CreatureScript
{
public:
    mob_infernal_volcano() : CreatureScript("mob_infernal_volcano") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_infernal_volcanoAI(creature);
    }

    struct mob_infernal_volcanoAI : public Scripted_NoMovementAI
    {
        mob_infernal_volcanoAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            instance = (InstanceScript*)creature->GetInstanceScript();
            Reset();
        }

        InstanceScript* instance;

        uint8 m_Count;
        uint8 m_CountMax;
        uint32 m_Timer;

        void Reset()
        {
            me->SetReactState(REACT_PASSIVE);
            m_Count = 0;
            m_Timer = 3*1000;

            if (!IsHeroic())
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                m_CountMax = 3;
            }
            else
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                m_CountMax = 0;
            }
        }

        void JustSummoned(Creature* summoned)
        {
            m_Count++;
            summoned->SetCorpseDelay(0);
        }

        void JustDied(Unit* /*killer*/)
        {
            me->DespawnOrUnsummon();
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_CountMax)
            {
                if (m_CountMax == m_Count)
                    me->DespawnOrUnsummon();
            }

            if (m_Timer <= uiDiff)
            {
                DoCast(SPELL_INFERNAL_ERUPTION);
                m_Timer = 10*1000;
            } else m_Timer -= uiDiff;
        }
    };

};

class mob_fel_infernal : public CreatureScript
{
public:
    mob_fel_infernal() : CreatureScript("mob_fel_infernal") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_fel_infernalAI(creature);
    }

    struct mob_fel_infernalAI : public ScriptedAI
    {
        mob_fel_infernalAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = (InstanceScript*)creature->GetInstanceScript();
            Reset();
        }

        InstanceScript* instance;
        uint32 m_uiFelStreakStartTimer;

        bool doFelStreaks;
        uint32 m_uiFelStreakTimer;
        uint32 m_uiFelInfernoTimer;

        void Reset()
        {
            m_uiFelStreakTimer = 1000;
            m_uiFelStreakStartTimer = urand(15*1000, 25*1000);
            m_uiFelInfernoTimer = 8000;
    
            doFelStreaks = false;
    
            if (Unit* target = me->SelectNearestTarget(150))
                AttackStart(target);
    
            DoZoneInCombat();
        }

        void MovementInform(uint32 uiType, uint32 uiId)
        {
            if (uiType != POINT_MOTION_TYPE) return;
    
            if (uiId == 1)
            {
                doFelStreaks = false;
                m_uiFelStreakTimer = 1000;
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;
    
            if (m_uiFelStreakStartTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                {
                    DoResetThreat();
                    me->AddThreat(target, 1.0f);
    
                    if (me->GetMotionMaster())
                    {
                        me->InterruptNonMeleeSpells(false);
                        me->GetMotionMaster()->MoveCharge(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 10.0f, 1);
                        doFelStreaks = true;
                    }
                }
                m_uiFelStreakStartTimer = urand(15*1000, 25*1000);
            } else m_uiFelStreakStartTimer -= uiDiff;
    
            if (doFelStreaks)
            {
                if (m_uiFelStreakTimer <= uiDiff)
                {
                    DoCastAOE(RAID_MODE(SPELL_FEL_STREAK_0, SPELL_FEL_STREAK_1, SPELL_FEL_STREAK_2, SPELL_FEL_STREAK_3), true);
                    m_uiFelStreakTimer = 1000;
                } else m_uiFelStreakTimer -= uiDiff;
            }
    
            if (!doFelStreaks)
            {
                if (m_uiFelInfernoTimer <= uiDiff)
                {
                    DoCastAOE(SPELL_FEL_INFERNO);
                    m_uiFelInfernoTimer = urand(15000, 23000);
                } else m_uiFelInfernoTimer -= uiDiff;
            }
    
            DoMeleeAttackIfReady();
        }
    };

};

class mob_nether_portal : public CreatureScript
{
public:
    mob_nether_portal() : CreatureScript("mob_nether_portal") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_nether_portalAI(creature);
    }

    struct mob_nether_portalAI : public ScriptedAI
    {
        mob_nether_portalAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = (InstanceScript*)creature->GetInstanceScript();
            Reset();
        }

        InstanceScript* instance;

        uint32 m_Timer;
        uint8  m_Count;
        uint8  m_CountMax;

        void Reset()
        {
            DoCast(me, SPELL_WILFRED_PORTAL, true);
            me->SetReactState(REACT_PASSIVE);
            m_Timer = 5*1000;
            m_Count = 0;
            if (!IsHeroic())
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                m_CountMax = 1;
            }
            else
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                m_CountMax = 0;
            }
        }

        void JustSummoned(Creature* summoned)
        {
            m_Count++;
            summoned->SetCorpseDelay(0);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (m_CountMax)
            {
                if (m_CountMax == m_Count)
                    me->DespawnOrUnsummon();
            }
            if (m_Timer <= uiDiff)
            {
                DoCast(SPELL_NETHER_PORTAL);
                m_Timer = 15*1000;
            } else m_Timer -= uiDiff;
        }
    };

};

class mob_mistress_of_pain : public CreatureScript
{
public:
    mob_mistress_of_pain() : CreatureScript("mob_mistress_of_pain") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_mistress_of_painAI(creature);
    }

    struct mob_mistress_of_painAI : public ScriptedAI
    {
        mob_mistress_of_painAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = (InstanceScript*)creature->GetInstanceScript();
            if (instance)
                instance->SetData(DATA_MISTRESS_OF_PAIN_COUNT, INCREASE);
            Reset();
        }

        InstanceScript* instance;
        uint32 m_uiShivanSlashTimer;
        uint32 m_uiSpinningStrikeTimer;
        uint32 m_uiMistressKissTimer;

        void Reset()
        {
            m_uiShivanSlashTimer = urand(8*1000, 12*1000);
            m_uiSpinningStrikeTimer = urand(25*1000, 35*1000);
            m_uiMistressKissTimer = urand(10*1000, 20*1000);
    
            if (Unit* target = me->SelectNearestTarget(150))
                AttackStart(target);
    
            DoZoneInCombat();
        }

        void JustDied(Unit* /*killer*/)
        {
            if (instance)
                instance->SetData(DATA_MISTRESS_OF_PAIN_COUNT, DECREASE);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (m_uiShivanSlashTimer <= uiDiff)
            {
                DoCastVictim(SPELL_SHIVAN_SLASH);
                m_uiShivanSlashTimer = urand(15*IN_MILLISECONDS, 35*IN_MILLISECONDS);
            } else m_uiShivanSlashTimer -= uiDiff;

            if (m_uiSpinningStrikeTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                {
                    int32 damage = target->GetMaxHealth() / 2;
                    target->CastCustomSpell(target, SPELL_SPINNING_STRIKE, &damage, 0, 0, true, 0, 0, me->GetGUID());
                }
                m_uiSpinningStrikeTimer = urand(15*IN_MILLISECONDS, 35*IN_MILLISECONDS);
            } else m_uiSpinningStrikeTimer -= uiDiff;

            if (IsHeroic())
            {
                if (m_uiMistressKissTimer <= uiDiff)
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        DoCast(target, SPELL_MISTRESS_KISS);
                    m_uiMistressKissTimer = urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS);
                } else m_uiMistressKissTimer -= uiDiff;
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_jaraxxus()
{
    new boss_jaraxxus();
    new mob_legion_flame();
    new mob_infernal_volcano();
    new mob_fel_infernal();
    new mob_nether_portal();
    new mob_mistress_of_pain();
}
