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
#include "violet_hold.h"

enum Spells
{
    SPELL_SHROUD_OF_DARKNESS                    = 54524,
    H_SPELL_SHROUD_OF_DARKNESS                  = 59745,
    SPELL_SUMMON_VOID_SENTRY                    = 54369,
    SPELL_VOID_SHIFT                            = 54361,
    H_SPELL_VOID_SHIFT                          = 59743,

    SPELL_ZURAMAT_ADD_2                         = 54342,
    H_SPELL_ZURAMAT_ADD_2                       = 59747
};

enum ZuramatCreatures
{
    CREATURE_VOID_SENTRY                        = 29364
};

enum Yells
{
    SAY_AGGRO                                   = -1608037,
    SAY_SLAY_1                                  = -1608038,
    SAY_SLAY_2                                  = -1608039,
    SAY_SLAY_3                                  = -1608040,
    SAY_DEATH                                   = -1608041,
    SAY_SPAWN                                   = -1608042,
    SAY_SHIELD                                  = -1608043,
    SAY_WHISPER                                 = -1608044
};

enum eActions
{
    ACTION_VOID_DEAD,
};

enum eAchievements
{
    ACHIEVEMENTS_THE_VOID_DANCE                 = 2153,
};

class boss_zuramat : public CreatureScript
{
public:
    boss_zuramat() : CreatureScript("boss_zuramat") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_zuramatAI (pCreature);
    }

    struct boss_zuramatAI : public ScriptedAI
    {
        boss_zuramatAI(Creature *c) : ScriptedAI(c), Summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        SummonList Summons;

        uint32 SpellVoidShiftTimer;
        uint32 SpellSummonVoidTimer;
        uint32 SpellShroudOfDarknessTimer;

        bool bVoidWalkerKilled;

        void Reset()
        {
            Summons.DespawnAll();
            if (pInstance)
            {
                if (pInstance->GetData(DATA_WAVE_COUNT) == 6)
                    pInstance->SetData(DATA_1ST_BOSS_EVENT, NOT_STARTED);
                else if (pInstance->GetData(DATA_WAVE_COUNT) == 12)
                    pInstance->SetData(DATA_2ND_BOSS_EVENT, NOT_STARTED);
            }

            SpellShroudOfDarknessTimer = 22000;
            SpellVoidShiftTimer = 15000;
            SpellSummonVoidTimer = 12000;

            bVoidWalkerKilled = false;
        }

        void DoAction(int32 const action)
        {
            switch(action)
            {
            case ACTION_VOID_DEAD:
                bVoidWalkerKilled = true;
                break;
            }
        }

        void AttackStart(Unit* pWho)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                return;

            if (me->Attack(pWho, true))
            {
                me->AddThreat(pWho, 0.0f);
                me->SetInCombatWith(pWho);
                pWho->SetInCombatWith(me);
                DoStartMovement(pWho);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
            if (pInstance)
            {
                if (GameObject *pDoor = pInstance->instance->GetGameObject(pInstance->GetData64(DATA_ZURAMAT_CELL)))
                    if (pDoor->GetGoState() == GO_STATE_READY)
                    {
                        EnterEvadeMode();
                        return;
                    }
                if (pInstance->GetData(DATA_WAVE_COUNT) == 6)
                    pInstance->SetData(DATA_1ST_BOSS_EVENT, IN_PROGRESS);
                else if (pInstance->GetData(DATA_WAVE_COUNT) == 12)
                    pInstance->SetData(DATA_2ND_BOSS_EVENT, IN_PROGRESS);
            }
        }

        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (SpellSummonVoidTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_SUMMON_VOID_SENTRY, false);
                SpellSummonVoidTimer = 20000;
            } else SpellSummonVoidTimer -=diff;

            if (SpellVoidShiftTimer <= diff)
            {
                 if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(pUnit, SPELL_VOID_SHIFT);
                SpellVoidShiftTimer = 20000;
            } else SpellVoidShiftTimer -=diff;

            if (SpellShroudOfDarknessTimer <= diff)
            {
                DoCast(me->getVictim(), SPELL_SHROUD_OF_DARKNESS);
                SpellShroudOfDarknessTimer = 20000;
            } else SpellShroudOfDarknessTimer -=diff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
            {
                if (pInstance->GetData(DATA_WAVE_COUNT) == 6)
                {
                    if(IsHeroic() && pInstance->GetData(DATA_1ST_BOSS_EVENT) == DONE)
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);

                    pInstance->SetData(DATA_1ST_BOSS_EVENT, DONE);
                    pInstance->SetData(DATA_WAVE_COUNT, 7);
                }
                else if (pInstance->GetData(DATA_WAVE_COUNT) == 12)
                {
                    if(IsHeroic() && pInstance->GetData(DATA_2ND_BOSS_EVENT) == DONE)
                        me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);

                    pInstance->SetData(DATA_2ND_BOSS_EVENT, DONE);
                    pInstance->SetData(DATA_WAVE_COUNT, 13);
                }

                if(GetDifficulty() == DUNGEON_DIFFICULTY_HEROIC && !bVoidWalkerKilled)
                    pInstance->DoCompleteAchievement(ACHIEVEMENTS_THE_VOID_DANCE);
            }

            Summons.DespawnAll();
        }

        void KilledUnit(Unit * victim)
        {
            if (victim == me)
                return;

            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), me);
        }

        void JustSummoned(Creature* summon)
        {
            Summons.Summon(summon);
        }
    };

};

class npc_void_sentry : public CreatureScript
{
public:
    npc_void_sentry() : CreatureScript("npc_void_sentry") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_void_sentryAI (pCreature);
    }

    struct npc_void_sentryAI : public ScriptedAI
    {
        npc_void_sentryAI(Creature *c) : ScriptedAI(c)
        {
            m_pInstance = c->GetInstanceScript();
            me->setFaction(14);

            if(m_pInstance)
                if(Creature* Zuramat = Creature::GetCreature((*me),m_pInstance->GetData64(DATA_ZURAMAT)))
                    Zuramat->AI()->JustSummoned(me);
        }

        InstanceScript* m_pInstance;

        Unit* SelectPlayerTargetInRange(float range)
        {
            Player *target = NULL;
            Trinity::AnyPlayerInObjectRangeCheck u_check(me, range, true);
            Trinity::PlayerSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, target, u_check);
            me->VisitNearbyObject(range, searcher);
            return target;
        }

        void Reset()
        {
            if(Unit* target = SelectPlayerTargetInRange(100.0f))
                me->AI()->AttackStart(target);

            DoCastAOE(DUNGEON_MODE(SPELL_ZURAMAT_ADD_2,H_SPELL_ZURAMAT_ADD_2),true);
            me->SetPhaseMask(17,true);
        }

        void JustDied(Unit* /*killer*/)
        {
            if(Creature* Zuramat = Creature::GetCreature((*me),m_pInstance->GetData64(DATA_ZURAMAT)))
                Zuramat->AI()->DoAction(ACTION_VOID_DEAD);
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;
        }
    };
};

/*
UPDATE creature_template SET scriptname = 'npc_void_sentry' WHERE entry = 29364;
*/

void AddSC_boss_zuramat()
{
    new boss_zuramat();
    new npc_void_sentry();
}
