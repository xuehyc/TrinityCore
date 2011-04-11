/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
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

/* ScriptData
SDName: Boss_Viscidus
SD%Complete: 0
SDComment: place holder
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptPCH.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_TOXIN_CLOUD               = 26575, // Aura

    SPELL_POISON_SHOCK              = 25993,
    SPELL_POISONBOLT_VOLLEY         = 25991,

    SPELL_VISCIDUS_FREEZE_1         = 26034,
    SPELL_VISCIDUS_FREEZE_2         = 26036,
    SPELL_VISCIDUS_FREEZE_3         = 25937,
};

uint32 Spell_Summon_glob[20] =
{
    25865, //HP > 5%
    25866, //HP > 10%
    25867, //HP > 15%
    25868, //HP > 20%
    25869, //HP > 25%
    25870, //HP > 30%
    25871, //HP > 35%
    25872, //HP > 40%
    25873, //HP > 45%
    25874, //HP > 50%
    25875, //HP > 55%
    25876, //HP > 45%
    25877, //HP > 65%
    25878, //HP > 70%
    25879, //HP > 75%
    25880, //HP > 80%
    25881, //HP > 85%
    25882, //HP > 90%
    25883, //HP > 95%
    25884, //HP == 100% ???
};

#define EMOTE_VISCIDUS_FREEZE_1         "begins to slow."
#define EMOTE_VISCIDUS_FREEZE_2         "begins to freeze."
#define EMOTE_VISCIDUS_FREEZE_3         "is frozen solid."

#define EMOTE_VISCIDUS_CRACK_1          "begins to crack."
#define EMOTE_VISCIDUS_CRACK_2          "looks ready to shatter."
#define EMOTE_VISCIDUS_CRACK_3          "explodes."

enum ViscidusState
{
    NORMAL_STATE_1 = 0,
    NORMAL_STATE_2,
    NORMAL_STATE_3,
    FROZEN_STATE_1,
    FROZEN_STATE_2,
    FROZEN_STATE_3,
    SHATTRED_STATE,
};

class boss_viscidus : public CreatureScript
{
public:
    boss_viscidus() : CreatureScript("boss_viscidus") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_viscidusAI (pCreature);
    }

    struct boss_viscidusAI : public ScriptedAI
    {
        boss_viscidusAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        ViscidusState state;
        uint32 HitCounter;

        void Reset()
        {
            state = NORMAL_STATE_1;
        }

        void Aggro(Unit *who)
        {
        }

        void DamageTaken(Unit *Done_by, uint32 &Damage)
        {
            if(Damage > 0) Damage = Damage/2;
        }

        void NextState(ViscidusState &state)
        {
            switch(state)
            {
            case NORMAL_STATE_1:
                state = NORMAL_STATE_2;
                break;
            case NORMAL_STATE_2:
                state = NORMAL_STATE_3;
                break;
            case NORMAL_STATE_3:
                state = FROZEN_STATE_1;
                break;
            case FROZEN_STATE_2:
                state = FROZEN_STATE_3;
            case FROZEN_STATE_3:
                state = SHATTRED_STATE;
                break;
            case SHATTRED_STATE:
                state = NORMAL_STATE_1;
                break;
            }
        }

        void ElementalDamageTaken(Unit *Done_by, uint32 &Damage,SpellSchoolMask damageSchoolMask)
        {
            if(Done_by->GetTypeId() == TYPEID_PLAYER)
            {
                switch(state)
                {
                case NORMAL_STATE_1:
                case NORMAL_STATE_2:
                case NORMAL_STATE_3:
                    if(damageSchoolMask == SPELL_SCHOOL_MASK_FROST) //Nur Frostschaden
                    {
                        if(++HitCounter >= 200)
                        {
                            NextState(state);
                            HitCounter = 0;
                            ChangePhase(state);
                        }
                    }
                    break;
                case FROZEN_STATE_1:
                case FROZEN_STATE_2:
                case FROZEN_STATE_3:
                    if(damageSchoolMask == SPELL_SCHOOL_MASK_NORMAL) //Nur Physischer Schden
                    {
                        if(++HitCounter >= 200)
                        {
                            NextState(state);
                            HitCounter = 0;
                            ChangePhase(state);
                        }
                    }
                    break;
                }
            }
        }

        void ChangePhase(ViscidusState NextPhase)
        {
            switch(NextPhase)
            {
                case NORMAL_STATE_1:
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_1);
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_2);
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_3);
                    break;
                case NORMAL_STATE_2:
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_2);
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_3);

                    me->CastSpell(me,SPELL_VISCIDUS_FREEZE_1,true);
                    me->MonsterTextEmote(EMOTE_VISCIDUS_FREEZE_1,0,true);
                    break;
                case NORMAL_STATE_3:
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_1);
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_3);

                    me->CastSpell(me,SPELL_VISCIDUS_FREEZE_2,true);
                    me->MonsterTextEmote(EMOTE_VISCIDUS_FREEZE_2,0,true);
                    break;
                case FROZEN_STATE_1:
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_1);
                    me->RemoveAurasDueToSpell(SPELL_VISCIDUS_FREEZE_2);

                    me->CastSpell(me,SPELL_VISCIDUS_FREEZE_3,true);
                    me->MonsterTextEmote(EMOTE_VISCIDUS_FREEZE_3,0,true);
                    break;
                case FROZEN_STATE_2:
                    me->MonsterTextEmote(EMOTE_VISCIDUS_CRACK_1,0,true);
                    break;
                case FROZEN_STATE_3:
                    me->MonsterTextEmote(EMOTE_VISCIDUS_CRACK_2,0,true);
                    break;
                case SHATTRED_STATE:
                    me->MonsterTextEmote(EMOTE_VISCIDUS_CRACK_3,0,true);
                    DoSummonGlobs();
                    break;
            }
        }

        void DoSummonGlobs()
        {
            //if((me->GetHealth()*100) / me->GetMaxHealth() >= 5)
            //    me->CastSpell(

            uint32 hpborder = 5;
            for(int i = 0; i < 20; i++)
            {
                if((me->GetHealth()*100) / me->GetMaxHealth() >= hpborder)
                {
                    me->CastSpell(me,Spell_Summon_glob[i],true);
                    hpborder += 5;
                }else
                    break;
            }

        }

        void JustDied(Unit* Killer)
        {

        }

        void UpdateAI(const uint32 diff)
        {
            if(!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_viscidus()
{
    new boss_viscidus();
}
