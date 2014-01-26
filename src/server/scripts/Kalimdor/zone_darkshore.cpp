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

enum DarkShore
{	
	QUEST_THE_LAST_WAVE_OF_SURVIVORS		= 13518,
	NPC_CERELLEAN_WHITECLAW					= 33093,
	NPC_VOLCOR								= 33094,
	NPC_SHALDYN								= 33095,
	NPC_GERSHALA_NIGHTWHISPER				= 32911,
	
};


/*####
# npc_cerellean_whiteclaw
####*/

class npc_cerellean_whiteclaw : public CreatureScript
{
    public:
        npc_cerellean_whiteclaw() : CreatureScript("npc_cerellean_whiteclaw") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_THE_LAST_WAVE_OF_SURVIVORS) == QUEST_STATUS_INCOMPLETE)				
			{			
				CAST_AI(npc_cerellean_whiteclawAI, creature->AI())->StartAnim(player, 1, 1000);											
			}
			return true;
		}

		struct npc_cerellean_whiteclawAI : public ScriptedAI
        {
            npc_cerellean_whiteclawAI(Creature* creature) : ScriptedAI(creature) {}
	  
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
							// ToDo let him stand up  if not in water
							_player->KilledMonsterCredit(NPC_CERELLEAN_WHITECLAW, NULL);
							_timer=1000; _phase=2;
							break;
						}
					case 2:
						{ 											
							Talk(0);
							_timer=5000; _phase=3;
							break;
						}
					case 3:
						{ 										
							me->DespawnOrUnsummon ();
							_timer=5000; _phase=0;
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
            return new npc_cerellean_whiteclawAI(creature);
        }
};

/*####
# npc_volcor
####*/

class npc_volcor : public CreatureScript
{
    public:
        npc_volcor() : CreatureScript("npc_volcor") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_THE_LAST_WAVE_OF_SURVIVORS) == QUEST_STATUS_INCOMPLETE)				
			{			
				CAST_AI(npc_volcorAI, creature->AI())->StartAnim(player, 1, 1000);											
			}
			return true;
		}

		struct npc_volcorAI : public ScriptedAI
        {
            npc_volcorAI(Creature* creature) : ScriptedAI(creature) {}
	  
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
							// ToDo  let him stand up  if not in water
							_player->KilledMonsterCredit(NPC_VOLCOR, NULL);	
							_timer=1000; _phase=2;
							break;
						}
					case 2:
						{ 		
							// Talk(0); // no text on wowhead														
							_timer=1000; _phase=3;
							break;
						}					
					case 3:
						{ 										
							me->DespawnOrUnsummon ();
							_timer=5000; _phase=0;
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
            return new npc_volcorAI(creature);
        }
};

/*####
# npc_shaldyn
####*/

class npc_shaldyn : public CreatureScript
{
    public:
        npc_shaldyn() : CreatureScript("npc_shaldyn") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_THE_LAST_WAVE_OF_SURVIVORS) == QUEST_STATUS_INCOMPLETE)				
			{			
				CAST_AI(npc_shaldynAI, creature->AI())->StartAnim(player, 1, 1000);											
			}
			return true;
		}

		struct npc_shaldynAI : public ScriptedAI
        {
            npc_shaldynAI(Creature* creature) : ScriptedAI(creature) {}
	  
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
							// ToDo  let him stand up  if not in water
							_player->KilledMonsterCredit(NPC_SHALDYN, NULL);	
							_timer=1000; _phase=2;
							break;
						}
						case 2:
						{ 		
							// Talk(0); // no text on wowhead														
							_timer=1000; _phase=3;
							break;
						}					
						case 3:
						{ 										
							me->DespawnOrUnsummon ();
							_timer=5000; _phase=0;
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
            return new npc_shaldynAI(creature);
        }
};

/*####
# npc_gershala_nightwhisper
####*/

class npc_gershala_nightwhisper : public CreatureScript
{
    public:
        npc_gershala_nightwhisper() : CreatureScript("npc_gershala_nightwhisper") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_THE_LAST_WAVE_OF_SURVIVORS) == QUEST_STATUS_INCOMPLETE)				
			{			
				CAST_AI(npc_gershala_nightwhisperAI, creature->AI())->StartAnim(player, 1, 1000);															
			}
			return true;
		}

		struct npc_gershala_nightwhisperAI : public ScriptedAI
        {
            npc_gershala_nightwhisperAI(Creature* creature) : ScriptedAI(creature) {}
	  
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
							// ToDo  let him stand up  if not in water
							_player->KilledMonsterCredit(NPC_GERSHALA_NIGHTWHISPER, NULL);	
							_timer=1000; _phase=2;
							break;
						}
						case 2:
						{ 		
							// Talk(0); // no text on wowhead														
							_timer=1000; _phase=3;
							break;
						}					
						case 3:
						{ 										
							me->DespawnOrUnsummon ();
							_timer=5000; _phase=0;
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
            return new npc_gershala_nightwhisperAI(creature);
        }
};



void AddSC_darkshore()
{
	new npc_cerellean_whiteclaw();
	new npc_volcor();
	new npc_shaldyn();
	new npc_gershala_nightwhisper();
	    
}
