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
SDName: Boss_Temporus
SD%Complete: 75
SDComment: More abilities need to be implemented
SDCategory: Caverns of Time, The Dark Portal
EndScriptData */

#include "ScriptPCH.h"
#include "dark_portal.h"

#define SAY_ENTER               -1269000
#define SAY_AGGRO               -1269001
#define SAY_BANISH              -1269002
#define SAY_SLAY1               -1269003
#define SAY_SLAY2               -1269004
#define SAY_DEATH               -1269005

#define SPELL_HASTE             31458
#define SPELL_MORTAL_WOUND      31464
#define SPELL_WING_BUFFET       31475
#define H_SPELL_WING_BUFFET     38593
#define SPELL_REFLECT           38592                       //Not Implemented (Heroic mod)

class boss_temporus : public CreatureScript
{
public:
    boss_temporus() : CreatureScript("boss_temporus") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_temporusAI (pCreature);
    }

    struct boss_temporusAI : public ScriptedAI
    {
        boss_temporusAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
            HeroicMode = me->GetMap()->IsHeroic();
        }

        InstanceScript *pInstance;

        bool HeroicMode;
        uint32 Haste_Timer;
        uint32 SpellReflection_Timer;

        void Reset()
        {
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT,SPELL_EFFECT_ATTACK_ME, true);

            Haste_Timer = 20000;
            SpellReflection_Timer = 40000;

            if (pInstance)
                if(!HeroicMode) pInstance->SetData(DATA_TEMPORUSDEATH, 0); 
        }

        void EnterCombat(Unit * /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
        }

        void KilledUnit(Unit * /*victim*/)
        {
            switch(rand()%2)
            {
                case 0: DoScriptText(SAY_SLAY1, me); break;
                case 1: DoScriptText(SAY_SLAY2, me); break;
            }
        }

        void JustDied(Unit * /*victim*/)
        {
            DoScriptText(SAY_DEATH, me);

            if (pInstance)
                pInstance->SetData(DATA_TEMPORUSDEATH, 1); 
        }

        void MoveInLineOfSight(Unit *who)
        {
            if (!who || me->getVictim())
                return;

            //Despawn Time Keeper
            if (who->GetTypeId() == TYPEID_UNIT)
            {
                if(((Creature*)who)->GetEntry() == 17918 && me->IsWithinDistInMap(who,20))
                {
                    //This is the wrong yell & sound for despawning time keepers!
                    DoScriptText(SAY_ENTER, me);

                    me->DealDamage(who, who->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                }
            }

            if (!me->getVictim() && who->isTargetableForAttack() && who->isInAccessiblePlaceFor(me) && me->IsHostileTo(who))
            {
                if (!me->canFly() && me->GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
                    return;

                float attackRadius = me->GetAttackDistance(who);
                if (me->IsWithinDistInMap(who, attackRadius) && me->IsWithinLOSInMap(who))
                {
                    //who->RemoveSpellsCausingAura(SPELL_AURA_MOD_STEALTH);
                    AttackStart(who);
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //Attack Haste
            if (Haste_Timer < diff)
            {
                DoCast(me, SPELL_HASTE);
                Haste_Timer = 20000+rand()%5000;
            }else Haste_Timer -= diff;

            //Spell Reflection
            if (SpellReflection_Timer < diff)
            {
                DoScriptText(SAY_BANISH, me);

                DoCast(me, SPELL_REFLECT);
                SpellReflection_Timer = 40000+rand()%10000;
            }else SpellReflection_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_temporus()
{
    new boss_temporus();
}
