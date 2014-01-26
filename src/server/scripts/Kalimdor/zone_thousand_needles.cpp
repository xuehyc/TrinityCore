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



void AddSC_thousand_needles()
{
	new npc_dead_employee();
}
