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
#include "gundrak.h"

enum eSpells
{
    // troll form
    SPELL_DETERMINED_STAB                         = 55104,
    SPELL_GROUND_TREMOR                           = 55142,
    SPELL_NUMBING_SHOUT                           = 55106,
    SPELL_MOJO_FRENZY                             = 55163,
    SPELL_MOJO_FRENZY_HASTE                       = 55096,
    SPELL_TRANSFORMATION                          = 55098, //Periodic, The caster transforms into a powerful mammoth, increasing Physical damage done by 25% and granting immunity to Stun effects.
    // mammoth
    SPELL_DETERMINED_GORE                         = 55102,
    H_SPELL_DETERMINED_GORE                       = 59444,
    SPELL_QUAKE                                   = 55101,
    SPELL_NUMBING_ROAR                            = 55100
};

enum eAchievements
{
    ACHIEV_LESS_RABI                              = 2040
};

enum eSays
{
    SAY_AGGRO                                     = -1604011,
    SAY_QUAKE                                     = -1604012,
    SAY_TRANSFORM                                 = -1604013,
    SAY_SLAY_1                                    = -1604014,
    SAY_SLAY_2                                    = -1604015,
    SAY_SLAY_3                                    = -1604016,
    SAY_DEATH                                     = -1604017,
    EMOTE_TRANSFORM                               = -1604018,
    EMOTE_TRANSFORMED                             = -1604029,
};

class boss_moorabi : public CreatureScript
{
public:
    boss_moorabi() : CreatureScript("boss_moorabi") { }

    CreatureAI* GetAI(Creature *pCreature) const
    {
        return new boss_moorabiAI(pCreature);
    }

    struct boss_moorabiAI : public ScriptedAI
    {
        boss_moorabiAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        
            // make 55098 interruptable
            SpellEntry *TempSpell;
            TempSpell = GET_SPELL(SPELL_TRANSFORMATION);
            if (TempSpell)
                TempSpell->InterruptFlags = 13;
        }

        InstanceScript* pInstance;

        bool bPhase;

        uint32 uiNumblingShoutTimer;
        uint32 uiGroundTremorTimer;
        uint32 uiDeterminedStabTimer;
        uint32 uiTransformationTimer;

        void Reset()
        {
            uiGroundTremorTimer = 18*IN_MILLISECONDS;
            uiNumblingShoutTimer = 10*IN_MILLISECONDS;
            uiDeterminedStabTimer = 20*IN_MILLISECONDS;
            uiTransformationTimer = 12*IN_MILLISECONDS;

            bPhase = false;

            if (pInstance)
                pInstance->SetData(DATA_MOORABI_EVENT, NOT_STARTED);
        }

        void EnterCombat(Unit* /*pWho*/)
        {
            DoScriptText(SAY_AGGRO, me);
            DoCast(me, SPELL_MOJO_FRENZY, true);

            if (pInstance)
                pInstance->SetData(DATA_MOORABI_EVENT, IN_PROGRESS);
        }

        void AdjustCastSpeed()
        {
            // bad workaround for mojo frenzy aura
            SpellEntry *TempSpell;
            TempSpell = GET_SPELL(SPELL_TRANSFORMATION);
            uint32 value = 15;  //spell 55098 default
        
            if (HealthBelowPct(80)) value = 28;
            if (HealthBelowPct(65)) value = 21;
            if (HealthBelowPct(50)) value = 5;
            if (HealthBelowPct(40)) value = 130;
            if (HealthBelowPct(30)) value = 206;
            if (HealthBelowPct(20)) value = 110;
            if (HealthBelowPct(15)) value = 3;
            if (HealthBelowPct(10)) value = 2;

            if (TempSpell && value)
                TempSpell->CastingTimeIndex = value;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                 return;
        
            if (!bPhase && me->HasAura(SPELL_TRANSFORMATION))
            {
                bPhase = true;
                me->RemoveAura(SPELL_MOJO_FRENZY);
                DoScriptText(EMOTE_TRANSFORMED, me);
            }

            if (uiGroundTremorTimer <= uiDiff)
            {
                DoScriptText(SAY_QUAKE, me);
                if (bPhase)
                    DoCast(me->getVictim(), SPELL_QUAKE);
                else
                    DoCast(me->getVictim(), SPELL_GROUND_TREMOR);
                uiGroundTremorTimer = urand(10*IN_MILLISECONDS, 15*IN_MILLISECONDS);
            } else uiGroundTremorTimer -= uiDiff;

            if (uiNumblingShoutTimer <= uiDiff)
            {
                if (bPhase)
                    DoCast(me->getVictim(), SPELL_NUMBING_ROAR, true);
                else
                    DoCast(me->getVictim(), SPELL_NUMBING_SHOUT, true);
                uiNumblingShoutTimer = 10*IN_MILLISECONDS;
            } else uiNumblingShoutTimer -=uiDiff;

            if (uiDeterminedStabTimer <= uiDiff)
            {
                if (bPhase)
                    DoCast(me->getVictim(), DUNGEON_MODE(SPELL_DETERMINED_GORE, H_SPELL_DETERMINED_GORE), true);
                else
                    DoCast(me->getVictim(), SPELL_DETERMINED_STAB, true);
                uiDeterminedStabTimer = 7*IN_MILLISECONDS;
            } else uiDeterminedStabTimer -=uiDiff;

            if (!bPhase && uiTransformationTimer <= uiDiff)
            {
                DoScriptText(EMOTE_TRANSFORM, me);
                DoScriptText(SAY_TRANSFORM, me);
                AdjustCastSpeed(); //FIXME
                DoCast(me, SPELL_TRANSFORMATION, false);
                uiTransformationTimer = 10*IN_MILLISECONDS;
            } else uiTransformationTimer -= uiDiff;

            DoMeleeAttackIfReady();
         }

         void JustDied(Unit* /*pKiller*/)
         {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
            {
                pInstance->SetData(DATA_MOORABI_EVENT, DONE);
            
                if (IsHeroic() && !bPhase)
                    pInstance->DoCompleteAchievement(ACHIEV_LESS_RABI);
            }
        }

        void KilledUnit(Unit* pVictim)
        {
            if (pVictim == me)
                return;

            DoScriptText(RAND(SAY_SLAY_1,SAY_SLAY_2,SAY_SLAY_3), me);
        }
    };

};

void AddSC_boss_moorabi()
{
    new boss_moorabi();
}
