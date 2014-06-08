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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "GameObjectAI.h"
#include "Spell.h"
#include "Player.h"
#include "WorldSession.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"

enum UnGoroCrater
{
	QUEST_THE_NORTHERN_PYLON					= 24722,
	GO_THE_NORTHERN_CRYSTAL_PYLON				= 164955,
	SPELL_ANY_PYLON_QUEST_COMPLETED				= 72150,
	SPELL_ANY_PYLON_QUEST_COMPLETED_FORECAST	= 72152,

	QUEST_HOW_TO_MAKE_MEAT_FRESH_AGAIN			= 24697,
	ITEM_SCRAPS_OF_ROTTING_MEAT					= 50430,
	NPC_UNGORO_PIT_BUNNY						= 38354,
	NPC_DINOSAUR_TAUNT_CREDIT					= 38355,
	NPC_DIEMETRADON								= 9163,

	QUEST_AN_IMPORTANT_LESSION					= 24703,
	QUEST_THE_EVIL_DRAGONS_OF_UNGORO_CRATER		= 24704,

	QUEST_DAMSELS_WHERE_MADE_TO_BE_SAVED		= 24705,
	NPC_DAMSEL_BY_THE_SHORE						= 38238,
	NPC_DAMSEL_IN_THE_CLIFFS					= 38239,
	NPC_DAMSEL_BY_THE_NORTH						= 38240,

	QUEST_THE_SPIRITS_OF_GOLAKKA_HOT_SPRINGS	= 24706,
	NPC_MAXIMILLIAN_OF_NORDSHIRE				= 38237,
	NPC_MAXIMILLIAN_OF_NORDSHIRE_2				= 38255,
	NPC_STEAMING_FURY							= 38254,
	NPC_MAXIMILLIAN_PRAYER_CREDIT				= 38253,
	NPC_PIMENTO_MAXIMILLIANS_STEED				= 38373,

	QUEST_THE_BALLAD_OF_MAXIMILLIAN				= 24707,
	NPC_DEVILSAUR_QUEEN							= 38346,

};

/*####
# go_northern_crystal_pylon
####*/

class go_northern_crystal_pylon : public GameObjectScript
{
    public:
        go_northern_crystal_pylon() : GameObjectScript("go_northern_crystal_pylon") { }
	
		struct go_northern_crystal_pylonAI : public GameObjectAI
        {
            go_northern_crystal_pylonAI(GameObject* go) : GameObjectAI(go) {}
           			
			uint32 _timer;

			void Reset() 
			{ 
				_timer=1000;
			}

			void UpdateAI(uint32 diff) 
			{ 

				if (_timer<=diff)
				{						
					if (Player* player = go->FindNearestPlayer(6.0f,true))
					{						
						if (player->GetQuestStatus(QUEST_THE_NORTHERN_PYLON) == QUEST_STATUS_INCOMPLETE)
						{							
							player->KillCreditGO (GO_THE_NORTHERN_CRYSTAL_PYLON);							
						}
					}
					_timer=1000;
				}
				else
					_timer-=diff;					
			}

					
		
        };

        GameObjectAI* GetAI(GameObject* go) const override
        {
            return new go_northern_crystal_pylonAI(go);
        }       
};

/*####
# npc_ungoro_pit_bunny
####*/

class npc_ungoro_pit_bunny : public CreatureScript
{
    public:
        npc_ungoro_pit_bunny() : CreatureScript("npc_ungoro_pit_bunny") { }

		struct npc_ungoro_pit_bunnyAI : public ScriptedAI
        {
            npc_ungoro_pit_bunnyAI(Creature* creature) : ScriptedAI(creature) {}
	  
			uint32 _timer;

			void Reset()  override
			{
				_timer=1000; 
			}

			void UpdateAI(uint32 diff) override
			{										
				if (_timer<=diff)
				{	
					if (Player* player = me->FindNearestPlayer(6.0f,true)) 
					{						
						if (player->GetQuestStatus(QUEST_HOW_TO_MAKE_MEAT_FRESH_AGAIN) == QUEST_STATUS_INCOMPLETE)
						{	
							if  (Creature* dino = me->FindNearestCreature(NPC_DIEMETRADON,8.0f, false))
							{
								player->KilledMonsterCredit(NPC_DINOSAUR_TAUNT_CREDIT);	
								dino->DespawnOrUnsummon(0);								
							}							
						}
					}					
					_timer=1000;
				}
				else
					_timer-=diff;									
			} 

        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_ungoro_pit_bunnyAI(creature);
        }
};

/*####
# npc_maximillian_of_northshire_2
####*/

class npc_maximillian_of_northshire_2 : public CreatureScript
{
public:
	npc_maximillian_of_northshire_2() : CreatureScript("npc_maximillian_of_northshire_2") { }


	struct npc_maximillian_of_northshire_2AI : public FollowerAI 
    {
        npc_maximillian_of_northshire_2AI(Creature* creature) : FollowerAI(creature) 
		{ 
			_player=0; _targetOfPlayer=0; _phase=0; _talkPhase=0;_timer=0; 
			_DamselShoreSaved=false; _DamselCliffSaved=false; _DamselNorthSaved=false;
			_Prayer1Received=false; _Prayer2Received=false;
			_Ghost1=NULL;
		}       

		uint32	_phase;
		uint32	_talkPhase;
		uint32	_timer;
		Player*	_player;
		Unit*	_targetOfPlayer;
		bool	_DamselShoreSaved;
		bool	_DamselCliffSaved;
		bool	_DamselNorthSaved;
		bool	_Prayer1Received;
		bool	_Prayer2Received;
		Unit*	_Ghost1;
		


		void StartAnim(Player* player)
		{			
			 StartFollow(player, 0, NULL);
			_phase=1; _timer=1000; _player=player; 		
		}
				             
        void MoveInLineOfSight(Unit* who) override
        {
            FollowerAI::MoveInLineOfSight(who);
        }

		void UpdateFollowerAI(uint32 diff) override
        {
			HelpPlayerOnFightWithDragons(diff);
			TalkWithDamselShore(diff);
			TalkWithDamselCliffs(diff);
			TalkWithDamselNorth(diff);
			TalkWithSpirits(diff);
			HelpPlayerOnFightWithDragonQueen(diff);

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }  

		void HelpPlayerOnFightWithDragons(uint32 diff)
		{
			if (!_player) return;			
			if (!_player->IsInCombat()) return; 				
			if (me->IsInCombat()) return;

			// core bug.. core allways rise a reset if AttackStart is calling, so this script is not executed

			if (Unit* playerTarget  = _player->GetSelectedUnit())
			{		
				// now he help allways.. bether is to select only dragons.. ToDo: if core is fixed  
				me->SetReactState(REACT_AGGRESSIVE);
				AttackStart(playerTarget); 				
			}									
		}

		void TalkWithDamselShore(uint32 diff)
		{
			if (_DamselShoreSaved) 
				return;

			if (Creature* damsel = me->FindNearestCreature(NPC_DAMSEL_BY_THE_SHORE,5.0f,true))
			{
				if (_player->GetQuestStatus(QUEST_DAMSELS_WHERE_MADE_TO_BE_SAVED) == QUEST_STATUS_INCOMPLETE)
				{					
					if (_timer<=diff)
					{						
						switch (_phase)
						{
							case 1:
							{ 
								Talk(26);
								_timer=5000; _phase=11;
								break;
							}
							case 11:
							{ 							
								Talk(29);
								_timer=5000; _phase=12;
								break;
							}
							case 12:
							{ 							
								damsel->AI()->Talk(0);
								_timer=5000; _phase=13;
								break;
							}
							case 13:
							{ 							
								Talk(40);
								_timer=5000; _phase=14;
								break;
							}
							case 14:
							{ 							
								Talk(31);
								_timer=3000; _phase=15;
								break;
							}
							case 15:
							{ 							
								_player->KilledMonsterCredit(NPC_DAMSEL_BY_THE_SHORE);
								_DamselShoreSaved=true;
								_timer=0; _phase=1;
								break;
							}							
						}				
					}
					else
						_timer-=diff;
				}
			}
		}

		void TalkWithDamselCliffs(uint32 diff)
		{
		if (_DamselCliffSaved) 
				return;

			if (Creature* damsel = me->FindNearestCreature(NPC_DAMSEL_IN_THE_CLIFFS,5.0f,true))
			{
				if (_player->GetQuestStatus(QUEST_DAMSELS_WHERE_MADE_TO_BE_SAVED) == QUEST_STATUS_INCOMPLETE)
				{					
					if (_timer<=diff)
					{						
						switch (_phase)
						{
							case 1:
							{ 
								Talk(27);
								_timer=5000; _phase=21;
								break;
							}
							case 21:
							{ 							
								Talk(28);
								_timer=5000; _phase=22;
								break;
							}
							case 22:
							{ 							
								Talk(14);
								_timer=5000; _phase=23;
								break;
							}
							case 23:
							{ 							
								Talk(8);
								_timer=5000; _phase=24;
								break;
							}
							case 24:
							{ 							
								Talk(1);
								_timer=5000; _phase=25;
								break;
							}
							case 25:
							{ 							
								Talk(9);
								_timer=5000; _phase=26;
								break;
							}
							case 26:
							{ 							
								Talk(32);
								_timer=3000; _phase=27;
								break;
							}
							case 27:
							{ 							
								_player->KilledMonsterCredit(NPC_DAMSEL_IN_THE_CLIFFS);
								_DamselCliffSaved=true;
								_timer=0; _phase=1;
								break;
							}							
						}				
					}
					else
						_timer-=diff;
				}
			}
		}

		void TalkWithDamselNorth(uint32 diff)
		{
			if (_DamselNorthSaved) 
				return;

			if (Creature* damsel = me->FindNearestCreature(NPC_DAMSEL_BY_THE_NORTH,5.0f,true))
			{
				if (_player->GetQuestStatus(QUEST_DAMSELS_WHERE_MADE_TO_BE_SAVED) == QUEST_STATUS_INCOMPLETE)
				{				
					if (_timer<=diff)
					{						
						switch (_phase)
						{
							case 1:
							{ 
								Talk(21);
								_timer=5000; _phase=2;
								break;
							}
							case 2:
							{ 							
								Talk(36);
								_timer=5000; _phase=3;
								break;
							}
							case 3:
							{ 							
								Talk(6); // here is combat with a phoenix ??
								_timer=5000; _phase=4;
								break;
							}
							case 4:
							{ 							
								Talk(10);
								_timer=5000; _phase=5;
								break;
							}
							case 5:
							{ 							
								Talk(30);
								_timer=5000; _phase=6;
								break;
							}
							case 6:
							{ 							
								Talk(18);
								_timer=5000; _phase=7;
								break;
							}
							case 7:
							{ 							
								damsel->AI()->Talk(0);								
								_timer=3000; _phase=8;
								break;
							}
							case 8:
							{ 															
								_player->KilledMonsterCredit(NPC_DAMSEL_BY_THE_NORTH);
								_DamselNorthSaved=true;
								_timer=0; _phase=1;
								break;
							}
						}				
					}
					else
						_timer-=diff;
				}
			}		
		}

		void TalkWithSpirits(uint32 diff)
		{
			if (_Prayer1Received && _Prayer2Received) return;
			if (!_player) return;			
			if (!_player->IsInCombat()) return; 				
			if (me->IsInCombat()) return;

			if (Unit* playerTarget  = _player->GetSelectedUnit())
			{
				if (playerTarget->GetEntry() == NPC_STEAMING_FURY)
				{
					if (_player->GetQuestStatus(QUEST_THE_SPIRITS_OF_GOLAKKA_HOT_SPRINGS) == QUEST_STATUS_INCOMPLETE)
					{	
						if (_timer<=diff)
						{	
							if (_Prayer1Received==false)
							{
								switch (_phase)
								{
									case 1:
									{ 
										Talk(35);
										_timer=5000; _phase=32;
										break;
									}
									case 32:
									{ 							
										Talk(23);
										_timer=5000; _phase=33;
										break;
									}
									case 33:
									{ 							
										Talk(16); 
										_timer=5000; _phase=34;
										break;
									}
									case 34:
									{ 							
										Talk(12);
										_timer=5000; _phase=35;
										break;
									}
									case 35:
									{ 							
										Talk(15);
										_player->KilledMonsterCredit(NPC_MAXIMILLIAN_PRAYER_CREDIT);
										_Prayer1Received=true;
										_Ghost1=playerTarget;
										_timer=0; _phase=1;
										break;
									}
								}
							}
							else if (_Prayer2Received==false && playerTarget!=_Ghost1)
							{
								switch (_phase)
								{
									case 1:
									{ 
										Talk(35);
										_timer=5000; _phase=42;
										break;
									}
									case 42:
									{ 							
										Talk(25);
										_timer=5000; _phase=43;
										break;
									}
									case 43:
									{ 							
										Talk(19); 
										_timer=5000; _phase=44;
										break;
									}
									case 44:
									{ 							
										Talk(13);
										_timer=5000; _phase=45;
										break;
									}
									case 45:
									{ 							
										Talk(15);
										_player->KilledMonsterCredit(NPC_MAXIMILLIAN_PRAYER_CREDIT);
										_Prayer2Received=true;
										_timer=0; _phase=1;
										break;
									}
								}
							}
						}
						else
							_timer-=diff;						
					}
				}			
			}		
		}

		void HelpPlayerOnFightWithDragonQueen(uint32 diff)
		{
			if (!_player) return;			
			if (!_player->IsInCombat()) return;
			if (me->IsInCombat()) return;

			// core bug.. core allways rise a reset if AttackStart is calling, so this script is not executed

			if (Unit* playerTarget  = _player->GetSelectedUnit())
			{
				if (playerTarget->GetEntry() == NPC_DEVILSAUR_QUEEN)
				{
					if (_player->GetQuestStatus(QUEST_THE_BALLAD_OF_MAXIMILLIAN) == QUEST_STATUS_INCOMPLETE)
					{
						me->SetReactState(REACT_AGGRESSIVE);
						AttackStart(playerTarget); 
					}
				}
			}			
		}
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_maximillian_of_northshire_2AI(creature);
    }


};

/*####
# npc_maximillian_of_northshire
####*/

class npc_maximillian_of_northshire : public CreatureScript
{
public:
	npc_maximillian_of_northshire() : CreatureScript("npc_maximillian_of_northshire") { _ask=0; }
	
	uint32 _ask;

	bool OnGossipHello(Player* player, Creature* creature) override 
	{
		Creature* max = creature->FindNearestCreature(NPC_MAXIMILLIAN_OF_NORDSHIRE_2, 10.0f, true);
		if (!max)		
		{
			if (player->GetQuestStatus(QUEST_AN_IMPORTANT_LESSION) == QUEST_STATUS_REWARDED)
			{
				bool b=false; 
				if (player->GetQuestStatus(QUEST_THE_EVIL_DRAGONS_OF_UNGORO_CRATER) == QUEST_STATUS_INCOMPLETE) b=true;
				if (player->GetQuestStatus(QUEST_DAMSELS_WHERE_MADE_TO_BE_SAVED) == QUEST_STATUS_INCOMPLETE) b=true;
				if (player->GetQuestStatus(QUEST_THE_SPIRITS_OF_GOLAKKA_HOT_SPRINGS) == QUEST_STATUS_INCOMPLETE) b=true;
				if (player->GetQuestStatus(QUEST_THE_BALLAD_OF_MAXIMILLIAN) == QUEST_STATUS_INCOMPLETE) b=true;								
				if(b) SummonMaximillian(player,creature);
			}
		}
		
		if (player->GetQuestStatus(QUEST_AN_IMPORTANT_LESSION) == QUEST_STATUS_COMPLETE)
		{
			switch(_ask)
			{
				case 0:
				{					
					player->ADD_GOSSIP_ITEM_DB(10978,0,GOSSIP_SENDER_MAIN,1000);   
					player->SEND_GOSSIP_MENU(15278,creature->GetGUID());
					_ask=1;
					return true;
				}					
			}
		}

		return false;
	}
	
	bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
		player->PlayerTalkClass->ClearMenus();
		switch(action)
		{
			case 0:
			{
				if (player->GetQuestStatus(QUEST_AN_IMPORTANT_LESSION) == QUEST_STATUS_COMPLETE)
				{
					player->ADD_GOSSIP_ITEM_DB(10989,0,GOSSIP_SENDER_MAIN,1001);    
					player->SEND_GOSSIP_MENU(15266,creature->GetGUID());
					break;
				}
			}
			case 1000:
			{
				player->ADD_GOSSIP_ITEM_DB(10989,0,GOSSIP_SENDER_MAIN,1001);    
				player->SEND_GOSSIP_MENU(15266,creature->GetGUID());
				break;
			}
			case 1001:
			{
				player->ADD_GOSSIP_ITEM_DB(10979,0,GOSSIP_SENDER_MAIN,1002);   
				player->SEND_GOSSIP_MENU(15267,creature->GetGUID());
				break;
			}
			case 1002:
			{
				player->ADD_GOSSIP_ITEM_DB(10980,0,GOSSIP_SENDER_MAIN,1003);    
				player->ADD_GOSSIP_ITEM_DB(10980,1,GOSSIP_SENDER_MAIN,1013);    
				player->SEND_GOSSIP_MENU(15268,creature->GetGUID());
				break;
			}
			case 1003:
			{
				player->ADD_GOSSIP_ITEM_DB(10981,0,GOSSIP_SENDER_MAIN,1004);   
				player->SEND_GOSSIP_MENU(15269,creature->GetGUID());
				break;
			}
			case 1004:
			{
				player->ADD_GOSSIP_ITEM_DB(10982,0,GOSSIP_SENDER_MAIN,1005);   
				player->SEND_GOSSIP_MENU(15270,creature->GetGUID());
				break;
			}
			case 1005:
			{				
				player->CLOSE_GOSSIP_MENU();
				_ask=2;
				break;
			}
			case 1013: 
			{
				player->CLOSE_GOSSIP_MENU();
				_ask=2;
				break;
			}

		}
		return true;
	}

	bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override 
	{
		if (quest->GetQuestId() == QUEST_AN_IMPORTANT_LESSION) 
			return true;		

		Position pos;
		creature->GetNearPosition(2.5f, 1.0f);
		Creature* max = creature->FindNearestCreature(NPC_MAXIMILLIAN_OF_NORDSHIRE_2, 5.0f, true);
		if (!max)
			SummonMaximillian(player,creature);						
				
		return true;
	}

	bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt) 
	{ 
		if (quest->GetQuestId()==QUEST_AN_IMPORTANT_LESSION)
			_ask=0;
		return true; 
	}

	void SummonMaximillian(Player* player, Creature* creature)
	{
		Position pos;
		creature->GetNearPosition(2.5f,1.0f);		
		Creature* max = creature->SummonCreature(NPC_MAXIMILLIAN_OF_NORDSHIRE_2, pos);
		max->Mount(31072,0,NPC_PIMENTO_MAXIMILLIANS_STEED);
		CAST_AI(npc_maximillian_of_northshire_2::npc_maximillian_of_northshire_2AI,max->AI())->StartAnim(player);
	}

};

/*####
# npc_steaming_fury
####*/

class npc_steaming_fury : public CreatureScript
{
public:
	npc_steaming_fury() : CreatureScript("npc_steaming_fury") { }
	
	struct npc_steaming_furyAI : public ScriptedAI
    {
		npc_steaming_furyAI(Creature* creature) : ScriptedAI(creature) {}
	  
		uint32 _timer;
		uint32 _phase;
		Player* _player;

		void Reset()  override
		{
			_timer=0; _phase=0;
		}
		
		void JustDied(Unit* killer) override 
		{ 
			Player* player = killer->ToPlayer();
			
			if (!player || player->GetTypeId()!= TYPEID_PLAYER) 
				return;

			if (Creature* maximillian = me->FindNearestCreature(NPC_MAXIMILLIAN_OF_NORDSHIRE_2, 10.0f,true))
			{							
				maximillian->AI()->Talk(34);				
			}					
		} 
	};

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_steaming_furyAI(creature);
    }
};

void AddSC_ungoro_crater()
{
	new go_northern_crystal_pylon();
	new npc_ungoro_pit_bunny();	
	new npc_maximillian_of_northshire();
	new npc_maximillian_of_northshire_2();	
	new npc_steaming_fury();
}
