/*
* Copyright (C) 2012-2013 HTCore <http://cata.vfire-core.com/>
* Copyright (C) 2012-2013 WoW Source <http://wow.amgi-it.ro/>
* by Shee Shen
*/

#include "ScriptMgr.h"
#include "the_stonecore.h"

#define SPELL_ELEMENTIUM_BULWARK          92659  //Spell who reflect magic skills
#define SPELL_ENRAGE                      80467
#define SPELL_FROST_FEVER                 55095 
#define SPELL_GROUND_SLAM                 95338
#define SPELL_PARALYZE                    92426
#define SPELL_SHATTER                     92662
#define SPELL_SLOW                        31589

enum eNpc42188
{
    SAY_AGGRO = 0,  //      "None may pass into the World's Heart!"
    SAY_DEATH = 1,  //      "A protector has fallen. The World's Heart lies exposed!"
    SAY_ELEMENTIUM = 2, //  "Break yourselves upon my body. Feel the strength of the earth"
    SAY_ENRAGE = 3, //      "The cycle is complete."

};

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
            Talk(SAY_AGGRO);
		}
		
		 void JustDied(Unit * /*victim*/)
        {
            Talk(SAY_DEATH);
		}
		
		 void UpdateAI(uint32 diff)
		 {
		    if (!UpdateVictim())
                return;
		
			if (!HealthAbovePct(25))
	  		{
                Talk(SAY_ENRAGE);
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
				Talk(SAY_ELEMENTIUM);
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
			  if(me->GetVictim())
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