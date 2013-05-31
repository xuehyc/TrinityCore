/*
* Copyright (C) 2012-2013 HTCore <http://cata.vfire-core.com/>
* Copyright (C) 2012-2013 WoW Source <http://wow.amgi-it.ro/>
* by Shee Shen
*/

#include "ScriptMgr.h"
#include "the_stonecore.h"

#define SAY_AGGRO          "None may pass into the World's Heart!"
#define SAY_DEATH          "A protector has fallen. The World's Heart lies exposed!"
#define SAY_ELEMENTIUM     "Break yourselves upon my body. Feel the strength of the earth"
#define SAY_ENRAGE         "The cycle is complete."

#define SPELL_ELEMENTIUM_BULWARK          92659  //Spell who reflect magic skills
#define SPELL_ENRAGE                      80467
#define SPELL_FROST_FEVER                 55095 
#define SPELL_GROUND_SLAM                 95338
#define SPELL_PARALYZE                    92426
#define SPELL_SHATTER                     92662
#define SPELL_SLOW                        31589

class boss_ozruk : public CreatureScript
{
public:
    boss_ozruk() : CreatureScript("boss_ozruk") {}
	
	CreatureAI* GetAI(Creature* pCreature) const
	{
	    return new boss_ozrukAI (pCreature);
	}
	
	struct boss_ozrukAI : public ScriptedAI
	{
        boss_ozrukAI(Creature *c) : ScriptedAI(c) {}
		
		uint32 ElementiumBulwarkTimer;
		uint32 EnrageTimer;
		uint32 FrostFeverTimer;
		uint32 GroundSlamTimer;
		uint32 ParalyzeTimer;
		uint32 ShatterTimer;
		
		void Reset()
		{
		   ElementiumBulwarkTimer = 30000;
		   FrostFeverTimer = urand(6000, 9000);
		   GroundSlamTimer = 30000;
		   ParalyzeTimer = urand(35000, 38000);
		   ShatterTimer = urand(16000, 20000);
		}
		
		 void EnterCombat(Unit * /*victim*/)
        {
            me->MonsterYell(SAY_AGGRO, LANG_UNIVERSAL, NULL);
		}
		
		 void JustDied(Unit * /*victim*/)
        {
            me->MonsterYell(SAY_DEATH, LANG_UNIVERSAL, NULL);
		}
		
		 void UpdateAI(uint32 diff)
		 {
		    if (!UpdateVictim())
                return;
		
			if (!HealthAbovePct(25))
	  		{
                me->MonsterYell(SAY_ENRAGE, LANG_UNIVERSAL, NULL);
			    DoCast(me, SPELL_ENRAGE);
            }
			
			if (FrostFeverTimer <= diff)
			{
			 if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0))
				 DoCast(pTarget, RAND(SPELL_FROST_FEVER, SPELL_SLOW));
				 FrostFeverTimer = urand(6000, 9000);
				 }else
				   FrostFeverTimer -= diff;
				   
			if (ElementiumBulwarkTimer <= diff)
			{
			    DoCast(me, SPELL_ELEMENTIUM_BULWARK);
				me->MonsterYell(SAY_ELEMENTIUM, LANG_UNIVERSAL, NULL);
				ElementiumBulwarkTimer = 30000;
				}else
				   ElementiumBulwarkTimer -= diff;
				   
			if (ParalyzeTimer <= diff)
			{
			  DoCast(SPELL_PARALYZE);
			  ParalyzeTimer = urand(35000, 38000);
			  }else
			      ParalyzeTimer -= diff;
				  
			if (ShatterTimer <= diff)
			{
			  DoCast(SPELL_SHATTER);
			  ShatterTimer = urand(16000, 20000);
			  }else
			      ShatterTimer -= diff;

		    if (GroundSlamTimer <= diff)
			{
			  if(me->getVictim())
                           DoCastVictim(SPELL_GROUND_SLAM);
			  GroundSlamTimer = 30000;
			  }else
			      GroundSlamTimer -= diff;

			DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_ozruk()
{
    new boss_ozruk();
}