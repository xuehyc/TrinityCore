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

#define MODEL_INVISIBLE    11686

//strength of the pack fixen
//



enum Spells
{
    //Auriaya 
    SPELL_TERRIFYING_SCREECH                    = 64386,
    SPELL_SENTINEL_BLAST_10                     = 64389,
    SPELL_SENTINEL_BLAST_25                     = 64678,
    SPELL_SONIC_SCREECH_10                      = 64422,
    SPELL_SONIC_SCREECH_25                      = 64688,
    SPELL_SUMMON_SWARMING_GUARDIAN              = 64396,
    SPELL_FERAL_DEFENDER_TRIGGER                = 64449,
    SPELL_FERAL_DEFENDER_SUMMON                 = 64447,

    //Feral Defender
    SPELL_FERAL_ESSENCE                         = 64455,
    SPELL_FERAL_RUSH_10                         = 64496,
    SPELL_FERAL_RUSH_25                         = 64674,
    SPELL_FERAL_POUNCE_10                       = 64478,
    SPELL_FERAL_POUNCE_25                       = 64669,
    SPELL_SLEEPING_FERAL_ESSENCE_10             = 64458,
    SPELL_SLEEPING_FERAL_ESSENCE_25             = 64676,

    //Sanctum Sentry
    SPELL_SAVAGE_POUNCE_10                      = 64666,
    SPELL_SAVAGE_POUNCE_25                      = 64374,
    SPELL_RIP_FLESH_10                          = 64375,
    SPELL_RIP_FLESH_25                          = 64667,
    SPELL_STRENGH_OF_THE_PACK                   = 64369,
};

enum Yells
{
    SAY_AGGRO                                    = -1603050,
    SAY_SLAY_1                                   = -1603051,
    SAY_SLAY_2                                   = -1603052,
    SAY_DEATH                                    = -1603053,
    SAY_BERSERK                                  = -1603054,
};

enum Creatures
{
    ENTRY_CREATURE_AURIAYA_SEEPING_ESSENCE_STALKER        = 34098,
    ENTRY_CREATURE_FERAL_DEFENDER                         = 34035,
    ENTRY_CREATURE_AURIAYA                                = 33515,
};

enum Achievements
{
    ACHIEV_AURIAYA_KILLS_10                               = 2868,
    ACHIEV_AURIAYA_KILLS_25                               = 2882,
    ACHIEV_CRAZY_CAT_LADY_10                              = 3006,
    ACHIEV_CRAZY_CAT_LADY_25                              = 3007,
    ACHIEV_NINE_LIVES_10                                  = 3076,
    ACHIEV_NINE_LIVES_25                                  = 3077,
};


class mob_feral_defender: public CreatureScript
{
public:
    mob_feral_defender() : CreatureScript("mob_feral_defender") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_feral_defenderAI(pCreature);
    }

    struct mob_feral_defenderAI : public ScriptedAI
    {
        mob_feral_defenderAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        uint32 Feral_Rush_Timer;
        uint32 Feral_Pounce_Timer;

        void Reset()
        {
            Feral_Rush_Timer = 4000;
            Feral_Pounce_Timer = 6000;
        }

        void JustDied(Unit*)
        {
            me->SummonCreature(ENTRY_CREATURE_AURIAYA_SEEPING_ESSENCE_STALKER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
        }
        

        void UpdateAI(const uint32 diff)
        {
            if(Feral_Rush_Timer <= diff)
            {
                if(Unit *target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(target, RAID_MODE(SPELL_FERAL_RUSH_10, SPELL_FERAL_RUSH_25));
                Feral_Rush_Timer = 5000;
            }
            else Feral_Rush_Timer -= diff;

            if(Feral_Pounce_Timer <= diff)
            {
                if(Unit *target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(target, RAID_MODE(SPELL_FERAL_POUNCE_10, SPELL_FERAL_POUNCE_25));
                Feral_Pounce_Timer = 5000;
            }
            else Feral_Pounce_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class boss_auriaya : public CreatureScript
{
public:
    boss_auriaya() : CreatureScript("boss_auriaya") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_auriayaAI(pCreature);
    }

    struct boss_auriayaAI : public ScriptedAI
    {
        boss_auriayaAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 Terrifying_Screech_Timer;
        uint32 Sonic_Screech_Timer;
        uint32 Guardian_Swarm_Timer;
        uint32 Sentinel_Blast_Timer;
        uint32 Feral_Defender_Summon_Timer;
        uint32 Feral_Defender_Ressurrection_Timer;
        uint32 Berserk_Timer;

        uint8 DefenderLifeCount;

        bool Defender_Summon;

        void Reset()
        {
            pInstance->SetData(TYPE_AURIAYA, NOT_STARTED);

            Terrifying_Screech_Timer = 40000;
            Sonic_Screech_Timer = 60000;
            Guardian_Swarm_Timer = 30000;
            Sentinel_Blast_Timer = 35000;
            Feral_Defender_Summon_Timer = 60000;
            Feral_Defender_Ressurrection_Timer = 35000;
            Berserk_Timer = 600000;

            DefenderLifeCount = 8;
            Defender_Summon = false;
        }


        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO,me);
            pInstance->SetData(TYPE_AURIAYA, IN_PROGRESS);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2), me);
        }

        void JustDied(Unit * /*victim*/)
        {
            pInstance->SetData(TYPE_AURIAYA, DONE);
            if(DefenderLifeCount == 0)
                pInstance->DoCompleteAchievement(RAID_MODE(ACHIEV_NINE_LIVES_10, ACHIEV_NINE_LIVES_25));
            pInstance->DoCompleteAchievement(RAID_MODE(ACHIEV_AURIAYA_KILLS_10, ACHIEV_AURIAYA_KILLS_25));
            DoScriptText(SAY_DEATH, me);
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (Terrifying_Screech_Timer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(SPELL_TERRIFYING_SCREECH);
                    Terrifying_Screech_Timer = 35000;
                }
                else Terrifying_Screech_Timer = 2000;
            } 
            else Terrifying_Screech_Timer -= diff;

            if (Sonic_Screech_Timer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCastVictim(RAID_MODE(SPELL_SONIC_SCREECH_10, SPELL_SONIC_SCREECH_25));
                    Sonic_Screech_Timer = 28000;
                }
                else Sonic_Screech_Timer = 2000;
            } 
            else Sonic_Screech_Timer -= diff;

            if(Guardian_Swarm_Timer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(me->getVictim(), SPELL_SUMMON_SWARMING_GUARDIAN);
                    Guardian_Swarm_Timer = 35000;
                }
                else Guardian_Swarm_Timer = 2000;
            }
            else Guardian_Swarm_Timer -= diff;

            if(Sentinel_Blast_Timer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(RAID_MODE(SPELL_SENTINEL_BLAST_10, SPELL_SENTINEL_BLAST_25));
                    Sentinel_Blast_Timer = 27000;
                }
                else Sentinel_Blast_Timer = 2000;
            }
            else Sentinel_Blast_Timer -= diff;

            if(Feral_Defender_Summon_Timer <= diff && Defender_Summon == false)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(SPELL_FERAL_DEFENDER_SUMMON);
                    if(Creature* pDefender = me->FindNearestCreature(ENTRY_CREATURE_FERAL_DEFENDER, 100, true))
                    {
                        pDefender->AddAura(SPELL_FERAL_ESSENCE, pDefender);
                        pDefender->SetAuraStack(SPELL_FERAL_ESSENCE, pDefender, DefenderLifeCount);
                    }
                    Defender_Summon = true;
                }
                else Feral_Defender_Summon_Timer = 2000;
            }
            else Feral_Defender_Summon_Timer -= diff;

            if(Creature* pDefender = me->FindNearestCreature(ENTRY_CREATURE_FERAL_DEFENDER, 15000, false))
            {
                if(Feral_Defender_Ressurrection_Timer <= diff)
                {
                    if(DefenderLifeCount > 0)
                    {
                        pDefender->Respawn();
                        Feral_Defender_Ressurrection_Timer = 35000;
                        DefenderLifeCount--;

                        if(DefenderLifeCount > 0)
                        {
                            pDefender->AddAura(SPELL_FERAL_ESSENCE, pDefender);
                            pDefender->SetAuraStack(SPELL_FERAL_ESSENCE, pDefender, DefenderLifeCount);    
                        }
                    }
                }
                else Feral_Defender_Ressurrection_Timer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };

};


class mob_sanctum_sentry: public CreatureScript
{
public:
    mob_sanctum_sentry() : CreatureScript("mob_sanctum_sentry") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_sanctum_sentryAI(pCreature);
    }

    struct mob_sanctum_sentryAI : public ScriptedAI
    {
        mob_sanctum_sentryAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        uint32 Rip_Flesh_Timer;

        void Reset()
        {
            Rip_Flesh_Timer = 10000;
        }

        void EnterCombat(Unit* )
        {
            me->AddAura(SPELL_STRENGH_OF_THE_PACK, me);
            DoCast(RAID_MODE(SPELL_SAVAGE_POUNCE_10, SPELL_SAVAGE_POUNCE_25));
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if(Rip_Flesh_Timer <= diff)
            {
                DoCast(me->getVictim(), RAID_MODE(SPELL_RIP_FLESH_10, SPELL_RIP_FLESH_25));
                Rip_Flesh_Timer = 10000;
            }
            else Rip_Flesh_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_seeping_essence_stalker: public CreatureScript
{
public:
    mob_seeping_essence_stalker() : CreatureScript("mob_seeping_essence_stalker") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_seeping_essence_stalkerAI(pCreature);
    }

    struct mob_seeping_essence_stalkerAI : public ScriptedAI
    {
        mob_seeping_essence_stalkerAI(Creature *pCreature) : ScriptedAI(pCreature) { }

        void Reset()
        {
            me->SetDisplayId(MODEL_INVISIBLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            DoCast(RAID_MODE(SPELL_SLEEPING_FERAL_ESSENCE_10, SPELL_SLEEPING_FERAL_ESSENCE_25));
        }

        void UpdateAI(const uint32 diff)
        {
            if(!me->FindNearestCreature(ENTRY_CREATURE_AURIAYA, 15000, true))
            {
                me->RemoveAura(RAID_MODE(SPELL_SLEEPING_FERAL_ESSENCE_10, SPELL_SLEEPING_FERAL_ESSENCE_25));
                me->DisappearAndDie();
            }
        }
    };
};

/*
UPDATE creature_template SET ScriptName = "boss_auriaya" WHERE Entry = 33515;
UPDATE creature_template SET ScriptName = "mob_feral_defender" WHERE Entry = 34035;
UPDATE creature_template SET ScriptName = "mob_sanctum_sentry" WHERE Entry = 34014;
UPDATE creature_template SET ScriptName = "mob_seeping_essence_stalker" WHERE Entry = 34098;
*/

void AddSC_boss_auriaya()
{
    new boss_auriaya();
    new mob_feral_defender();
    new mob_seeping_essence_stalker();
    new mob_sanctum_sentry();
}