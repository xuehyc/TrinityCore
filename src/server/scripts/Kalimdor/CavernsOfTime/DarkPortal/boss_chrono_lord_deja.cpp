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
SDName: Boss_Chrono_Lord_Deja
SD%Complete: 65
SDComment: All abilities not implemented
SDCategory: Caverns of Time, The Dark Portal
EndScriptData */

#include "ScriptPCH.h"
#include "dark_portal.h"

#define SAY_ENTER                   -1269006
#define SAY_AGGRO                   -1269007
#define SAY_BANISH                  -1269008
#define SAY_SLAY1                   -1269009
#define SAY_SLAY2                   -1269010
#define SAY_DEATH                   -1269011

#define SPELL_ARCANE_BLAST          31457
#define H_SPELL_ARCANE_BLAST        38538
#define SPELL_ARCANE_DISCHARGE      31472
#define H_SPELL_ARCANE_DISCHARGE    38539
#define SPELL_TIME_LAPSE            31467
#define SPELL_ATTRACTION            38540                       //Not Implemented (Heroic mode)

class boss_chrono_lord_deja : public CreatureScript
{
public:
    boss_chrono_lord_deja() : CreatureScript("boss_chrono_lord_deja") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_chrono_lord_dejaAI (pCreature);
    }

    struct boss_chrono_lord_dejaAI : public ScriptedAI
    {
        boss_chrono_lord_dejaAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            HeroicMode = me->GetMap()->IsHeroic();
        }
    
        InstanceScript *pInstance;

        bool HeroicMode;
        uint32 ArcaneBlast_Timer;
        uint32 TimeLapse_Timer;

        void Reset()
        {
            ArcaneBlast_Timer = 20000;
            TimeLapse_Timer = 15000;

            if (pInstance)
                if(!HeroicMode) pInstance->SetData(DATA_CHRONOLORDDEJADEATH, 0);

        }

        void EnterCombat(Unit *who)
        {
            DoScriptText(SAY_AGGRO, me);
        }

        void KilledUnit(Unit *victim)
        {
            switch(rand()%2)
            {
                case 0: DoScriptText(SAY_SLAY1, me); break;
                case 1: DoScriptText(SAY_SLAY2, me); break;
            }
        }

        void JustDied(Unit *victim)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
                pInstance->SetData(DATA_CHRONOLORDDEJADEATH, 1); 
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim() )
                return;

            //Arcane Blast
            if (ArcaneBlast_Timer < diff)
            {
                DoCast(me->getVictim(), SPELL_ARCANE_BLAST);
                ArcaneBlast_Timer = 20000+rand()%5000;
            }else ArcaneBlast_Timer -= diff;

            //Time Lapse
            if (TimeLapse_Timer < diff)
            {
                DoScriptText(SAY_BANISH, me);
                DoCast(me, SPELL_TIME_LAPSE);
                TimeLapse_Timer = 15000+rand()%10000;
            }else TimeLapse_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_chrono_lord_deja()
{
    new boss_chrono_lord_deja();
}
