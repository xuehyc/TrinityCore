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
SDName: Boss_Majordomo_Executus
SD%Complete: 30
SDComment: Correct spawning and Event NYI
SDCategory: Molten Core
EndScriptData */

#include "ScriptPCH.h"
#include "molten_core.h"

#define SAY_AGGRO           -1409003
#define SAY_SPAWN           -1409004
#define SAY_SLAY            -1409005
#define SAY_SPECIAL         -1409006
#define SAY_DEFEAT          -1409007

#define SAY_SUMMON_MAJ      -1409008
#define SAY_ARRIVAL1_RAG    -1409009
#define SAY_ARRIVAL2_MAJ    -1409010
#define SAY_ARRIVAL3_RAG    -1409011
#define SAY_ARRIVAL5_RAG    -1409012

#define SPAWN_RAG_X         838.51
#define SPAWN_RAG_Y         -829.84
#define SPAWN_RAG_Z         -232.00
#define SPAWN_RAG_O         1.70

#define SPAWN_DOMO_X         830.64
#define SPAWN_DOMO_Y         -814.08
#define SPAWN_DOMO_Z         -228.92
#define SPAWN_DOMO_O         5.21

#define SPELL_MAGIC_REFLECTION      20619
#define SPELL_DAMAGE_REFLECTION     21075

#define SPELL_BLASTWAVE             20229
#define SPELL_AEGIS                 20620                   //This is self casted whenever we are below 50%
#define SPELL_TELEPORT              20618
#define SPELL_SUMMON_RAGNAROS       19774

#define ENTRY_FLAMEWALKER_HEALER    11663
#define ENTRY_FLAMEWALKER_ELITE     11664

class boss_majordomo : public CreatureScript
{
public:
    boss_majordomo() : CreatureScript("boss_majordomo") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_majordomoAI (pCreature);
    }

    struct boss_majordomoAI : public ScriptedAI
    {
        boss_majordomoAI(Creature *c) : ScriptedAI(c)
        {
            m_pInstance = c->GetInstanceScript();
            AddsKillCounter = 0;
        }

        InstanceScript *m_pInstance;

        uint32 MagicReflection_Timer;
        uint32 DamageReflection_Timer;
        uint32 Blastwave_Timer;
        uint32 Teleport_Timer;
        uint32 Spawn_Timer;

        uint32 AddsKillCounter;

        void Reset()
        {
            MagicReflection_Timer =  30000;
            DamageReflection_Timer = 15000;
            Teleport_Timer = 15000;
            Blastwave_Timer = 10000;
            Spawn_Timer = 10000;

            if (m_pInstance)
                m_pInstance->SetData(DATA_MAJORDOMOISDEAD,NOT_STARTED);


            if(!AreBossesDown())
            {
                me->SetVisible(false);
                me->setFaction(35);
            }

            if(m_pInstance && m_pInstance->GetData(DATA_MAJORDOMOISDEAD) != DONE)
            {
                std::list<Creature*> list;
                GetCreatureListWithEntryInGrid(list,me,ENTRY_FLAMEWALKER_HEALER,150.0f);

                for (std::list<Creature*>::iterator iter = list.begin(); iter != list.end(); ++iter)
                {
                    Creature *c = *iter;
                    if (c)
                    {
                        if(c->isAlive())
                            c->AI()->EnterEvadeMode();
                        else
                            c->Respawn(true);
                    }
                }
            
                GetCreatureListWithEntryInGrid(list,me,ENTRY_FLAMEWALKER_ELITE,150.0f);
                for (std::list<Creature*>::iterator iter = list.begin(); iter != list.end(); ++iter)
                {
                    Creature *c = *iter;
                    if (c)
                    {
                        if(c->isAlive())
                            c->AI()->EnterEvadeMode();
                        else
                            c->Respawn(true);
                    }
                }

                AddsKillCounter = 0;
            }else
            {
                me->setFaction(35);
            }
        }

        void AddKilled()
        {
            if(m_pInstance && m_pInstance->GetData(DATA_MAJORDOMOISDEAD) == IN_PROGRESS)
                AddsKillCounter += 1;
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (rand()%5)
                    return;

                DoScriptText(SAY_SLAY, me);
            }

            void EnterCombat(Unit * /*who*/)
            {
                DoScriptText(SAY_AGGRO, me);

            if (m_pInstance)
                m_pInstance->SetData(DATA_MAJORDOMOISDEAD,IN_PROGRESS);
        }

        bool AreBossesDown()
        {
            if(m_pInstance)
            {
                return m_pInstance->GetData(DATA_GARRISDEAD) == DONE && m_pInstance->GetData(DATA_GEDDONISDEAD) == DONE && m_pInstance->GetData(DATA_GEHENNASISDEAD) == DONE &&
                    m_pInstance->GetData(DATA_GOLEMAGGISDEAD) == DONE && m_pInstance->GetData(DATA_LUCIFRONISDEAD) == DONE && m_pInstance->GetData(DATA_MAGMADARISDEAD) == DONE &&
                    m_pInstance->GetData(DATA_SHAZZRAHISDEAD) == DONE && m_pInstance->GetData(DATA_SULFURONISDEAD) == DONE;
            }

            return false;
        }

        void UpdateAI(const uint32 diff)
        {
            if(!me->IsVisible())
            {
                if(AreBossesDown())
                {
                    me->SetVisible(true);
                    me->setFaction(14);
                }
            }

            if(m_pInstance && m_pInstance->GetData(DATA_MAJORDOMOISDEAD) == DONE)
            {
                if(me->GetPositionY() < -1000)
                {
                    if(Spawn_Timer <= diff)
                    {
                        me->SetVisible(false);
                        me->DealDamage(me,me->GetHealth());
                        me->RemoveCorpse();
                        //DoTeleportTo(SPAWN_DOMO_X,SPAWN_DOMO_Y,SPAWN_DOMO_Z);
                        //me->Relocate(SPAWN_DOMO_X,SPAWN_DOMO_Y,SPAWN_DOMO_Z,SPAWN_DOMO_O);
                        //me->SetHomePosition(SPAWN_DOMO_X,SPAWN_DOMO_Y,SPAWN_DOMO_Z,SPAWN_DOMO_O);
                    }else Spawn_Timer -= diff;
                }
            }

            if (!UpdateVictim())
                return;

            if(AddsKillCounter >= 8)
            {
                m_pInstance->SetData(DATA_MAJORDOMOISDEAD,DONE);
                me->AI()->EnterEvadeMode();
            }

            //Cast Ageis if less than 50% hp
            if (HealthBelowPct(50))
            {
                DoCast(me, SPELL_AEGIS);
            }

            if (MagicReflection_Timer <= diff)
            {
                if(Unit* target = DoSelectLowestHpFriendly(100))
                {
                    if(target->isAlive())
                        DoCast(target, SPELL_MAGIC_REFLECTION);
                    MagicReflection_Timer = 30000;
                }
            } else MagicReflection_Timer -= diff;

            if (DamageReflection_Timer <= diff)
            {
                if(Unit* target = DoSelectLowestHpFriendly(100))
                {
                    if(target->isAlive())
                        DoCast(target, SPELL_DAMAGE_REFLECTION);
                    DamageReflection_Timer = 30000;
                }
            } else DamageReflection_Timer -= diff;

            //Blastwave_Timer
            if (Blastwave_Timer <= diff)
            {
                DoCast(me->getVictim(), SPELL_BLASTWAVE);
                Blastwave_Timer = 10000;
            } else Blastwave_Timer -= diff;

            if (Teleport_Timer <= diff)
            {
                DoCast(me->getVictim(),SPELL_TELEPORT);
                Teleport_Timer = 30000;
            }else Teleport_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

class mob_flamewalker : public CreatureScript
{
public:
    mob_flamewalker() : CreatureScript("mob_flamewalker") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_flamewalkerAI (pCreature);
    }

    struct mob_flamewalkerAI : public ScriptedAI
    {
        mob_flamewalkerAI(Creature *c) : ScriptedAI(c)
        {
            m_pInstance = c->GetInstanceScript();
        }

        InstanceScript *m_pInstance;

        void Reset()
        {
            if(!AreBossesDown())
            {
                me->SetVisible(false);
                me->setFaction(35);
            }
        }

        void EnterCombat(Unit *who)
        {
            if (m_pInstance)
                m_pInstance->SetData(DATA_MAJORDOMOISDEAD,IN_PROGRESS);
        }

        void JustDied(Unit *killer)
        {
            if(m_pInstance)
            {
                Creature* Majodomo = Creature::GetCreature((*me),m_pInstance->GetData64(DATA_MAJORDOMO));
                if(Majodomo)
                    CAST_AI(boss_majordomo::boss_majordomoAI,Majodomo->AI())->AddKilled();
            }
        }

        bool AreBossesDown()
        {
            if(m_pInstance)
            {
                return m_pInstance->GetData(DATA_GARRISDEAD) == DONE && m_pInstance->GetData(DATA_GEDDONISDEAD) == DONE && m_pInstance->GetData(DATA_GEHENNASISDEAD) == DONE &&
                    m_pInstance->GetData(DATA_GOLEMAGGISDEAD) == DONE && m_pInstance->GetData(DATA_LUCIFRONISDEAD) == DONE && m_pInstance->GetData(DATA_MAGMADARISDEAD) == DONE &&
                    m_pInstance->GetData(DATA_SHAZZRAHISDEAD) == DONE && m_pInstance->GetData(DATA_SULFURONISDEAD) == DONE;
            }

            return false;
        }

        void UpdateAI(const uint32 diff)
        {
            if(!me->IsVisible())
            {
                if(AreBossesDown())
                {
                    me->SetVisible(true);
                    me->setFaction(14);
                }
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_majordomo()
{
    new boss_majordomo();
    new mob_flamewalker(); //UPDATE creature_template SET scriptname = 'mob_flamewalker' WHERE entry IN (11664,11663);
}
