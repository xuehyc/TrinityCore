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
  SPELL_CAUTERIZING_FLAMES                      = 59466, //Only in heroic
  SPELL_FIREBOLT                                = 54235,
  H_SPELL_FIREBOLT                              = 59468,
  SPELL_FLAME_BREATH                            = 54282,
  H_SPELL_FLAME_BREATH                          = 59469,
  SPELL_LAVA_BURN                               = 54249,
  H_SPELL_LAVA_BURN                             = 59594
};

class boss_lavanthor : public CreatureScript
{
public:
    boss_lavanthor() : CreatureScript("boss_lavanthor") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_lavanthorAI (pCreature);
    }

    struct boss_lavanthorAI : public ScriptedAI
    {
        boss_lavanthorAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        uint32 uiFireboltTimer;
        uint32 uiFlameBreathTimer;
        uint32 uiLavaBurnTimer;
        uint32 uiCauterizingFlamesTimer;

        InstanceScript* pInstance;

        void Reset()
        {
            uiFireboltTimer = 1000;
            uiFlameBreathTimer = 5000;
            uiLavaBurnTimer = 10000;
            uiCauterizingFlamesTimer = 3000;
            if (pInstance)
            {
                if (pInstance->GetData(DATA_WAVE_COUNT) == 6)
                    pInstance->SetData(DATA_1ST_BOSS_EVENT, NOT_STARTED);
                else if (pInstance->GetData(DATA_WAVE_COUNT) == 12)
                    pInstance->SetData(DATA_2ND_BOSS_EVENT, NOT_STARTED);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (pInstance)
            {
            if (GameObject *pDoor = pInstance->instance->GetGameObject(pInstance->GetData64(DATA_LAVANTHOR_CELL)))
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

        void MoveInLineOfSight(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (uiFlameBreathTimer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(me->getVictim(), SPELL_FLAME_BREATH);
                    uiFlameBreathTimer = urand(10000,15000);
                }
            } else uiFlameBreathTimer -= diff;

            if (uiLavaBurnTimer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(me->getVictim(), DUNGEON_MODE(SPELL_LAVA_BURN, H_SPELL_LAVA_BURN));
                    uiLavaBurnTimer = urand(10000,20000);
                }
            }

            if (IsHeroic())
            {
                if (uiCauterizingFlamesTimer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_CAUTERIZING_FLAMES);
                    uiCauterizingFlamesTimer = urand(10000,16000);
                } else uiCauterizingFlamesTimer -= diff;
            }

            if (uiFireboltTimer <= diff)
            {
                if(!me->IsNonMeleeSpellCasted(false))
                {
                    DoCast(me->getVictim(), DUNGEON_MODE(SPELL_FIREBOLT, H_SPELL_FIREBOLT));
                    uiFireboltTimer = urand(5000,13000);
                }
            } else uiFireboltTimer -= diff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
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
            }
        }
    };

};

void AddSC_boss_lavanthor()
{
    new boss_lavanthor();
}
