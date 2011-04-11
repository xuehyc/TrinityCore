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
SDName: Boss_Aeonus
SD%Complete: 80
SDComment: Some spells not implemented
SDCategory: Caverns of Time, The Dark Portal
EndScriptData */

#include "ScriptPCH.h"
#include "dark_portal.h"

#define CORRUPT_MEDIVH    31326

#define SAY_ENTER         -1269012
#define SAY_AGGRO         -1269013
#define SAY_BANISH        -1269014
#define SAY_SLAY1         -1269015
#define SAY_SLAY2         -1269016
#define SAY_DEATH         -1269017

#define SPELL_CLEAVE        40504
#define SPELL_TIME_STOP     31422
#define SPELL_ENRAGE        37605
#define SPELL_SAND_BREATH   31473
#define H_SPELL_SAND_BREATH 39049

class boss_aeonus : public CreatureScript
{
public:
    boss_aeonus() : CreatureScript("boss_aeonus") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_aeonusAI (pCreature);
    }

    struct boss_aeonusAI : public ScriptedAI
    {
        boss_aeonusAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            HeroicMode = me->GetMap()->IsHeroic();
        }

        InstanceScript *pInstance;

        bool HeroicMode;
        bool MayNotCastCorrupt;
        bool IsChanneling;

        uint32 Corrupt_Timer;
        uint32 SandBreath_Timer;
        uint32 TimeStop_Timer;
        uint32 Frenzy_Timer;

        void Reset()
        {
            SandBreath_Timer = 30000;
            TimeStop_Timer = 40000;
            Frenzy_Timer = 120000;
            Corrupt_Timer = 1000;
            IsChanneling = false;

            if (pInstance)
                pInstance->SetData(DATA_AEONUSDEATH, 0); 

            Creature *pMedivh = (Creature*)(Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH)));
            if(pMedivh)
            {
                float x,y;
                pMedivh->GetNearPoint2D(x,y,10,pMedivh->GetAngle(me));
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                (*me).GetMotionMaster()->MovePoint(1,x,y,pMedivh->GetPositionZ());
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if(type != POINT_MOTION_TYPE)
                    return;

            if(id == 1)
            {
                Creature *pMedivh = (Creature*)(Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH)));
                if(pMedivh)
                {
                    DoCast(pMedivh, CORRUPT_MEDIVH);
                }
                IsChanneling = true;
            }
        }

        void EnterCombat(Unit * /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
            me->InterruptNonMeleeSpells(false);
            IsChanneling = false;
        }

        void JustDied(Unit * /*victim*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
                pInstance->SetData(DATA_AEONUSDEATH, 1); 
        }

        void KilledUnit(Unit * /*victim*/)
        {
            switch(rand()%2)
            {
                case 0: DoScriptText(SAY_SLAY1, me); break;
                case 1: DoScriptText(SAY_SLAY2, me); break;
            }
        }

        void UpdateWorldState(uint32 field, uint32 value)
        {
            Map * map = me->GetMap();
            if(!map->IsDungeon()) return;

            WorldPacket data(SMSG_UPDATE_WORLD_STATE, 8);

            data << field;
            data << value;

            ((InstanceMap*)map)->SendToPlayers(&data);

            // TODO: Uncomment and remove everything above this line only when the core patch for this is accepted
            //me->GetMap()->UpdateWorldState(field, value);
        }

        void UpdateAI(const uint32 diff)
        {
            Creature *pMedivh = (Creature*)(Unit::GetUnit((*me), pInstance->GetData64(DATA_MEDIVH)));

            // If we channel corrupt on Medivh, lower Shield by 1% every second
            if(IsChanneling)
            {
                if(Corrupt_Timer < diff)
                {
                    if(pInstance)
                    {
                        uint32 ShieldPercent = pInstance->GetData(DATA_SHIELDPERCENT);
                        pInstance->SetData(DATA_SHIELDPERCENT, ShieldPercent-1);
                        UpdateWorldState(2540, ShieldPercent-1);
                        //me->GetMap()->UpdateWorldState(2540, ShieldPercent-1);
                        if(pMedivh && !pMedivh->isDead() && ShieldPercent <= 0)
                            me->DealDamage(pMedivh, pMedivh->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                        }

                    Corrupt_Timer = 1000;
                }else Corrupt_Timer -= diff;
            }

            //Return since we have no target
            if (!UpdateVictim() )
                return;

            //Sand Breath
            if (SandBreath_Timer < diff)
            {
                Unit* target = NULL;
                target = me->getVictim();
                if (target)
                    DoCast(target, SPELL_SAND_BREATH);
                SandBreath_Timer = 30000;
            }else SandBreath_Timer -= diff;

            //Time Stop
            if (TimeStop_Timer < diff)
            {
                DoScriptText(SAY_BANISH, me);

                DoCast(me->getVictim(), SPELL_TIME_STOP);
                TimeStop_Timer = 40000;
            }else TimeStop_Timer -= diff;

            //Frenzy
            if (Frenzy_Timer < diff)
            {
                DoCast(me, SPELL_ENRAGE);
                Frenzy_Timer = 120000;
            }else Frenzy_Timer -= diff;
        
            if (!IsChanneling)
                DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_aeonus()
{
    new boss_aeonus();
}
