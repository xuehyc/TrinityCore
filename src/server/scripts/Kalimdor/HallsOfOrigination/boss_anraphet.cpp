/*
* Copyright (C) 2012-2013 HTCore <http://cata.vfire-core.com/>
* Copyright (C) 2012-2013 WoW Source <http://wow.amgi-it.ro/>
* by Shee Shen
*/

#include "ScriptMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"

#define mob_alpha_rayon 41144

enum Spells
{
    // Anraphet
    SPELL_ALPHA_BEAMS = 76912,
    SPELL_ALPHA_BEAMS_SUMMON = 91201,
    SPELL_CRUMBLING_RUIN = 75609,
    H_SPELL_CRUMBLING_RUIN = 91206,
    SPELL_DESTRUCTION_PROTOCOL = 77437,
    SPELL_NEMESIS_STRIKE = 75604,
    H_SPELL_NEMESIS_STRIKE = 91175,
    SPELL_OMEGA_STANCE = 75622,
    H_SPELL_OMEGA_STANCE = 91208,
	// Mob Rayon Alpha
    SPELL_ALPHA_BEAMS_EFFECT = 76184,
    SPELL_ALPHA_BEAMS_VISUAL = 91205,
};

enum Texts
{
	SAY_INTRO = 0,
    SAY_AGGRO = 1,
    SAY_SLAY = 2,
    SAY_EVENT = 3,
    SAY_DEATH = 4,
};

/**********
** Anraphet
***********/
class boss_anraphet: public CreatureScript
{
public: 
 boss_anraphet() : CreatureScript("boss_anraphet") { } 

 struct boss_anraphetAI : public ScriptedAI
    {
        boss_anraphetAI(Creature *c) : ScriptedAI(c) {}

		uint32 nemesis;
		uint32 rayon;
		uint32 omega;
		uint32 ruine;

        void Reset()
        {
           nemesis = 12000; 
		   rayon = 10000;
		   omega = 14000;
		   ruine = urand(16000, 22000);
        }

        void EnterCombat(Unit* /*who*/) 
        {
			Talk(SAY_AGGRO);
			Talk(SAY_INTRO);
        }

        void JustDied(Unit* /*killer*/)
        {
			Talk(SAY_DEATH);
        }
		
		void KilledUnit(Unit* victim)
		{
		    Talk(SAY_SLAY);
		}
		
        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
            return;
           
            if (nemesis <= diff)
            {
                DoCast(me->getVictim(), DUNGEON_MODE(SPELL_NEMESIS_STRIKE,H_SPELL_NEMESIS_STRIKE));
                nemesis = 12000;
            } else nemesis -= diff;
				
            if (omega <= diff)
            {
				Talk(SAY_EVENT);
                DoCast(me, DUNGEON_MODE(SPELL_OMEGA_STANCE,H_SPELL_OMEGA_STANCE));
                omega = 14000;
            } else omega -= diff;
				
            if (rayon <= diff)
            {
                if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
                DoCast(pTarget, SPELL_ALPHA_BEAMS);
                rayon = 10000;
            } else rayon -= diff;
				
            if (ruine <= diff)
            {
                DoCastAOE(DUNGEON_MODE(SPELL_CRUMBLING_RUIN,H_SPELL_CRUMBLING_RUIN));
                ruine = urand(16000, 22000);
            } else ruine -= diff;
			
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_anraphetAI (pCreature);
    }
};

/*************
** Alpha Beams
**************/
class npc_alpha_beam : public CreatureScript
{
    public:
        npc_alpha_beam() : CreatureScript("npc_alpha_beam") { }

        struct npc_alpha_beamAI : public ScriptedAI
        {
			npc_alpha_beamAI(Creature * pCreature) : ScriptedAI(pCreature) {}
			
			void Reset()
			{
				me->AddAura(SPELL_ALPHA_BEAMS_VISUAL, me);
			}

			void UpdateAI(uint32 diff)
			{
                if (!UpdateVictim())
                    return;
				
				me->AddAura(SPELL_ALPHA_BEAMS_EFFECT, me);
			}
		};

    CreatureAI* GetAI(Creature* creature) const
	{
        return new npc_alpha_beamAI(creature);
    }
};

void AddSC_boss_anraphet()
{
    new boss_anraphet();
	new npc_alpha_beam();
}