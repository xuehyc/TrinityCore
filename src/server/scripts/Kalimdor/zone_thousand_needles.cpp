/*
 *
 * Copyright (C) 2011-2014 ArkCORE <http://www.arkania.net/>
 *
 * Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
 *
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

enum ThousandNeedles
{
	QUEST_WE_ALL_SCREAM_FOR_ICE_CREAM		= 28051,
	NPC_DEAD_EMPLOYEE						= 47446,
	SPELL_HOOK_DEAD_EMPLOYEE				= 88478,
	SPELL_TOW_HOOK							= 88479,

	QUEST_FREE_THE_PRIDELINGS				= 28086,
	NPC_HIGHPERCH_PRIDELING_IN_CAGE			= 47481,
	NPC_HIGHPERCH_PRIDELING_FREE			= 47483,
	SPELL_SUMMON_HIGHPERCH_PRIDELING_FREE	= 88532,
	SPELL_FREE_THE_PRIDELINGS_LOOT_FX		= 88554,
	SPELL_PRIDELING_DIVING_HELM_VISUAL		= 88567,

	QUEST_RELEASE_HEARTRAZOR				= 28088,
	NPC_TWILIGHT_SUBDUER					= 47487,
	NPC_Heartrazor							= 47486,

};


/*####
# npc_dead_employee
####*/

class npc_dead_employee : public CreatureScript
{
    public:
        npc_dead_employee() : CreatureScript("npc_dead_employee") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_WE_ALL_SCREAM_FOR_ICE_CREAM) == QUEST_STATUS_INCOMPLETE)				
			{			
				CAST_AI(npc_dead_employeeAI, creature->AI())->StartAnim(player, 1, 1000);											
			}
			return true;
		}

		struct npc_dead_employeeAI : public ScriptedAI
        {
            npc_dead_employeeAI(Creature* creature) : ScriptedAI(creature) {}
	  
			uint32 _phase;
			uint32 _timer;
			Player* _player;								

			void StartAnim(Player* player, uint32 phase, uint32 timer)
			{
				_phase=phase;
				_timer=timer;
				_player=player;
			}
			
			void UpdateAI(uint32 diff) OVERRIDE
			{						
				if (!UpdateVictim())						
					DoTimerWork_OOC(diff);								
				else								
					DoMeleeAttackIfReady();
			} 

			void DoTimerWork_OOC(uint32 diff)
			{				
				if (_timer<=diff)
				{		
					switch (_phase)
					{
					case 1:
						{ 							
							DoCast(me, SPELL_HOOK_DEAD_EMPLOYEE); // you can hear this works ToDo: but no animation
							_timer=3000; _phase=2;
							break;
						}
					case 2:
						{ 			
							_player->KilledMonsterCredit(NPC_DEAD_EMPLOYEE, NULL);	
							DoCast(me, SPELL_TOW_HOOK); // ToDo: no working animation
							_timer=3000; _phase=3;
							break;
						}
					case 3:
						{ 															
							me->DespawnOrUnsummon ();
							_timer=0; _phase=0;
							break;
						}
					}				
				}
				else
					_timer-=diff;				
			}
        };
		
        CreatureAI* GetAI(Creature* creature) const OVERRIDE
        {
            return new npc_dead_employeeAI(creature);
        }
};

/*####
# npc_highperch_prideling
####*/

class npc_highperch_prideling : public CreatureScript
{
    public:
        npc_highperch_prideling() : CreatureScript("npc_highperch_prideling") { }
	
		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_FREE_THE_PRIDELINGS) == QUEST_STATUS_INCOMPLETE)				
			{	
				player->CastSpell(creature,SPELL_SUMMON_HIGHPERCH_PRIDELING_FREE);
				creature->DespawnOrUnsummon();
				player->KilledMonsterCredit(NPC_HIGHPERCH_PRIDELING_IN_CAGE, NULL);	
			}
			return true;
		}
};

/*####
# npc_twilight_subduer
# ToDo: Heartrazor is bond from npc_twilight_subduer, the aura is unknown.. so visual is not to see you free Heartrazor by killing the last npc_twilight_subduer..
####*/

class npc_twilight_subduer : public CreatureScript
{
    public:
        npc_twilight_subduer() : CreatureScript("npc_twilight_subduer") { }

		struct npc_twilight_subduerAI : public ScriptedAI
        {
            npc_twilight_subduerAI(Creature* creature) : ScriptedAI(creature) {}
	  
			void JustDied(Unit* killer) OVERRIDE 
			{ 
				if (Player* player = killer->ToPlayer())
				{
					if (!me->FindNearestCreature (me->GetEntry(),50.0, true))
					{
						player->KilledMonsterCredit(NPC_Heartrazor, NULL);						 
					}				
				}						
			} 

			void UpdateAI(uint32 diff) OVERRIDE
			{						
				if (!UpdateVictim())						
					return;							
				else								
					DoMeleeAttackIfReady();
			} 			
        };
		
        CreatureAI* GetAI(Creature* creature) const OVERRIDE
        {
            return new npc_twilight_subduerAI(creature);
        }
};



void AddSC_thousand_needles()
{
	new npc_dead_employee();
	new npc_highperch_prideling();
	new npc_twilight_subduer();

}
