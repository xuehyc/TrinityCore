/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CORRUPTING_BLIGHT                     = 60588,
    SPELL_VOID_STRIKE                           = 60590
};

enum Yells
{
    SAY_AGGRO                                   = -1595045,
    SAY_FAIL                                    = -1595046,
    SAY_DEATH                                   = -1595047
};

class boss_infinite_corruptor : public CreatureScript
{
public:
    boss_infinite_corruptor() : CreatureScript("boss_infinite_corruptor") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_infinite_corruptorAI(creature);
    }

    struct boss_infinite_corruptorAI : public ScriptedAI
    {
        boss_infinite_corruptorAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        uint32 uiCorruptingBlightTimer;
        uint32 uiVoidStrikeTimer;

        void Reset()
        {
            uiVoidStrikeTimer = urand(2000, 5000);
            uiCorruptingBlightTimer = urand(3000, 8000);

            if (instance)
                instance->SetData(DATA_INFINITE_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoZoneInCombat();

            DoScriptText(SAY_AGGRO, me, 0);

            if (instance)
                instance->SetData(DATA_INFINITE_EVENT, IN_PROGRESS);
        }

        void UpdateAI(const uint32 diff)
        {
            if (instance)
            {
                if (instance->GetData(DATA_TIMER) == 0)
                {
                    DoScriptText(SAY_FAIL, me, 0);
                    me->DisappearAndDie();
                }
            }

            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (uiCorruptingBlightTimer < diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM,0))
                    DoCast(target, SPELL_CORRUPTING_BLIGHT);
                uiCorruptingBlightTimer = urand(3000, 8000);
            } else uiCorruptingBlightTimer -= diff;

            if (uiVoidStrikeTimer < diff)
            {
                DoCast(me->getVictim(), SPELL_VOID_STRIKE);
                uiVoidStrikeTimer = urand(3000, 6000);
            } else uiVoidStrikeTimer -= diff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            DoScriptText(SAY_DEATH, me, 0);

            std::list<HostileReference*>& m_threatlist = me->getThreatManager().getThreatList();

            if (!m_threatlist.empty())
            {
                for (std::list<HostileReference*>::const_iterator itr = m_threatlist.begin(); itr != m_threatlist.end(); ++itr)
                {
                    if ((*itr))
                    {
                        if (Unit* pUnit = Unit::GetUnit((*me), (*itr)->getUnitGuid()))
                        {
                            if (pUnit->HasAura(SPELL_CORRUPTING_BLIGHT))
                                pUnit->RemoveAurasDueToSpell(SPELL_CORRUPTING_BLIGHT);
                        }
                    }
                }
            }

            if (instance)
                instance->SetData(DATA_INFINITE_EVENT, DONE);
        }
    };

};

void AddSC_boss_infinite_corruptor()
{
    new boss_infinite_corruptor();
}
