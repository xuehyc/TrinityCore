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

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "GridNotifiers.h"

enum DarkShore
{	
	QUEST_THE_LAST_WAVE_OF_SURVIVORS		= 13518,
	NPC_CERELLEAN_WHITECLAW					= 33093,
	NPC_VOLCOR								= 33094,
	NPC_SHALDYN								= 33095,
	NPC_GERSHALA_NIGHTWHISPER				= 32911,
	
	QUEST_NO_ACCOUNTING_FOR_TASTE			= 13527,
	NPC_DECOMPOSING_THISTLE_BEAR			= 32975,
	ITEM_FOUL_BEAR_CARCASS_SAMPLE			= 44911,
	SPELL_FORCE_FOUL_BEAR_CARCASS_SAMPLE	= 62113,

	QUEST_POWER_OVER_THE_TIDES				= 13523,
	NPC_TRANQUIL_TIDAL_SPIRIT				= 32937,
	NPC_ENRAGED_TIDAL_SPIRIT				= 32890,
	SPELL_SHADOW_BOLT						= 9613,

	QUEST_TWICE_REMOVED						= 13565,
	NPC_WITHERED_ENT						= 34009,
	NPC_LADY_JANIRA							= 33207,
	NPC_DARKSCALE_SCOUT						= 33206,
	NPC_DARKSCALE_SCOUT_KILL_CREDIT			= 34010,
	SPELL_WITHERED_TOUCH					= 11442,

	QUEST_THE_RITUAL_BOND					= 13569,
	QUEST_SPIRIT_OF_THE_STAG				= 13567,
	QUEST_SPIRIT_OF_THE_MOONSTALKER			= 13568,
	QUEST_SPIRIT_OF_THE_THISTLE_BEAR		= 13597,
	NPC_GREAT_STAG_SPIRIT					= 33133,
	NPC_GREAT_THISTLE_BEAR_SPIRIT			= 33132,
	NPC_GREAT_MOONSTALKER_SPIRIT			= 33131,
	SPELL_BLESSING_OF_THE_STAG				= 64341,
	SPELL_BLESSING_OF_THE_MOONSTALKER		= 64340,
	SPELL_BLESSING_OF_THE_THISTLE_BEAR		= 64329,
	SPELL_RITUAL_BOND_QUEST_COMPLETE		= 62803,
	GO_GROVEKEEPERS_INCENSE					= 194771,
	SPELL_GROVEKEEPERS_TRANCE				= 64198,

	QUEST_AGAINST_THE_WIND					= 13542,
	NPC_FRENZIED_CYCLONE_BRACERS_KILL_CREDIT = 32986,
	ITEM_FRENZIED_CYCLONE_BRACERS			= 44868,
	GO_MOONWELL								= 174795,

	QUEST_LEAVE_NO_TRACKS					= 13892,
	NPC_TWILIGHT_WORKER						= 34405,
	NPC_FOREMAN_BALSOTH						= 34406,
	NPC_DARKSHORE_INTELLIGENCE_CREDIT_1		= 34410,

	QUEST_STEPPING_UP_SURVEILLANCE			= 13948,
	NPC_THALYA_THE_VOIDCALLER				= 34427,
	NPC_DARKSHORE_INTELLIGENCE_CREDIT_2		= 34411,

	QUEST_THE_SEEDS_OF_LIFE					= 13882,
	NPC_ONU									= 3616,
	NPC_DARKSHORE_WISP						= 34306,
	SPELL_CREATE_SEED_OF_EARTH				= 65154,
	SPELL_CAPTURING							= 65125,
	ITEM_SEED_OF_EARTH						= 46354,
	ITEM_SEED_OF_THE_SKY					= 46355,

	QUEST_WAR_SUPPLIES						= 13509,
	NPC_SHATTERSPEAR_SUPPLIES_CREDIT_BUNNY	= 33056,
	ITEM_SENTINEL_TORCH						= 44999,
	GO_SHATTERSPEAR_SUPPLIES_1				= 194103,
	GO_SHATTERSPEAR_SUPPLIES_2				= 194104,
	SPELL_TORCH_SHATTERSPEAR_SUPPLIES		= 62624,

	QUEST_ENDING_THE_THREAD					= 13515,
	NPC_JORKIL_THE_SOULRIPPER				= 32862,
	NPC_HUNTRESS_SANDRA_MOONFALL			= 33178,
	SPELL_AEGIS_OF_THE_SHATTERSPEER			= 64549,

	QUEST_A_NEW_HOME						= 13910,
	GO_NEW_HOME_BUILDING_SITE				= 195043,
	GO_BUILDING_SIDE						= 195045,
	GO_BULDING_CENTER						= 195044,
	GO_BUILDING_CENTER_HUT					= 195055,
	NPC_GREYMIST_HOVEL_BUILD_QUEST_MARKER	= 34349,
	NPC_HUNTRESS_SANDRYA_MOONFALL			= 33178,

	QUEST_CLEANSING_THE_AFFLICTED			= 13545,
	NPC_CORRUPTED_BLACKWOOD					= 33044,
	SPELL_BLESSED_HERB_BUNDLE				= 62092, 

	QUEST_THE_DARKSCALE_WARLOAD				= 13899,
	SPELL_PERMANENT_FEIGN_DEATH				= 29266,
	NPC_WARLOAD_WRATHSPINE					= 34423,

	QUEST_THE_OFFERING_TO_AZSHARA			= 13900,
	NPC_QUEEN_AZSHARA						= 34416,
	NPC_MALFURION_STORMRAGE					= 34422,
	NPC_AZSHARA_EVENT_CREDIT				= 51314,
	NPC_DARKSCALE_PRIESTESS					= 34415,

};

/*####
# npc_cerellean_whiteclaw
####*/

class npc_cerellean_whiteclaw : public CreatureScript
{
    public:
        npc_cerellean_whiteclaw() : CreatureScript("npc_cerellean_whiteclaw") { }

		bool OnGossipHello(Player* player, Creature* creature) override
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
			
			void UpdateAI(uint32 diff) override
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
		
        CreatureAI* GetAI(Creature* creature) const override
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

		bool OnGossipHello(Player* player, Creature* creature) override
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
			
			void UpdateAI(uint32 diff) override
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
		
        CreatureAI* GetAI(Creature* creature) const override
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

		bool OnGossipHello(Player* player, Creature* creature) override
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
			
			void UpdateAI(uint32 diff) override
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
		
        CreatureAI* GetAI(Creature* creature) const override
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

		bool OnGossipHello(Player* player, Creature* creature) override
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
			
			void UpdateAI(uint32 diff) override
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
		
        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_gershala_nightwhisperAI(creature);
        }
};

/*####
# npc_decomposing_thistle_bear
####*/

class npc_decomposing_thistle_bear : public CreatureScript
{
    public:
        npc_decomposing_thistle_bear() : CreatureScript("npc_decomposing_thistle_bear") { }

		bool OnGossipHello(Player* player, Creature* creature) override
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_NO_ACCOUNTING_FOR_TASTE) == QUEST_STATUS_INCOMPLETE)				
			{			
				player->CastSpell (creature, SPELL_FORCE_FOUL_BEAR_CARCASS_SAMPLE);
				creature->DespawnOrUnsummon(500);
			}
			return true;
		}
};

/*####
# npc_withered_ent
#
# ToDo: Core BUG: the core sends on every movement a reset(), so the npc can not walk or attack
# ToDo: Core BUG: by click on item 45911, cast a spell 64306. This spell summon a withered_ent. Now this does always, but shold only if a dead scout is near.   
#
####*/

class npc_withered_ent : public CreatureScript
{
    public: npc_withered_ent() : CreatureScript("npc_withered_ent") {}
		
        struct npc_withered_entAI : public ScriptedAI
        {
            npc_withered_entAI(Creature* creature) : ScriptedAI(creature) { }			
        
			Player* m_player;

			void IsSummonedBy(Unit* summoner) override
			{			
				m_player = summoner->ToPlayer();
				if (m_player) m_player->KilledMonsterCredit(NPC_DARKSCALE_SCOUT_KILL_CREDIT, NULL);	
			}

			void AttackStart(Unit* who) override
			{
				if (!who)
					return;				

				if (me->Attack(who, true) && who->IsAlive())
				{										
					me->AddThreat(who, 0.0f);
					me->SetInCombatWith(who);
					who->SetInCombatWith(me);
					DoStartMovement(who);
				}               				
			}		

			void MoveInLineOfSight(Unit* who) override 
			{ 				
				if (!me->IsInCombat())				
				{
                    if (who->GetEntry() != NPC_DARKSCALE_SCOUT)
                        return;
					if (!me->IsWithinLOSInMap(who))
						return;					   					 										
					if (who->GetDistance (who) > 20.0f && !who->IsAlive())
						return;
					
					SetCombatMovement(true);
					AttackStart(who);										
				} 				
			}            

            void UpdateAI(uint32 diff) override
            {
				if (!UpdateVictim())
					return;
              
				DoMeleeAttackIfReady();
            }           
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_withered_entAI(creature);
        }
};

/*####
# npc_great_thistle_bear_spirit
####*/

class npc_great_thistle_bear_spirit : public CreatureScript
{
    public:
        npc_great_thistle_bear_spirit() : CreatureScript("npc_great_thistle_bear_spirit") { }

		bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override 
		{					
			if (quest->GetQuestId() == QUEST_SPIRIT_OF_THE_THISTLE_BEAR)
			{						
				creature->AI()->DoCast(player, SPELL_BLESSING_OF_THE_THISTLE_BEAR);				
			}
			return true;
		}

		bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt) 
		{ 			
			if (quest->GetQuestId() == QUEST_SPIRIT_OF_THE_THISTLE_BEAR)
			{					
				creature->AI()->DoCast(player, SPELL_RITUAL_BOND_QUEST_COMPLETE);
				player->RemoveAuraFromStack(SPELL_GROVEKEEPERS_TRANCE);
				player->SetPhaseMask(1, true);				
			}

			return true; 
		}
};

/*####
# npc_great_moonstalker_spirit
####*/

class npc_great_moonstalker_spirit : public CreatureScript
{
    public:
        npc_great_moonstalker_spirit() : CreatureScript("npc_great_moonstalker_spirit") { }

		bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override 
		{			
			if (quest->GetQuestId() == QUEST_SPIRIT_OF_THE_MOONSTALKER)
			{						
				creature->AI()->DoCast(player, SPELL_BLESSING_OF_THE_MOONSTALKER);
				creature->AI()->DoCast(player, SPELL_RITUAL_BOND_QUEST_COMPLETE);
			}
			return true;
		}

		bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt) 
		{ 			
			if (quest->GetQuestId() == QUEST_SPIRIT_OF_THE_MOONSTALKER)
			{					
				creature->AI()->DoCast(player, SPELL_RITUAL_BOND_QUEST_COMPLETE);
				player->RemoveAuraFromStack(SPELL_GROVEKEEPERS_TRANCE);
				player->SetPhaseMask(1, true);				
			}

			return true; 
		}
};

/*####
# npc_great_stag_spirit
####*/

class npc_great_stag_spirit : public CreatureScript
{
    public:
        npc_great_stag_spirit() : CreatureScript("npc_great_stag_spirit") { }

		bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override 
		{			
			if (quest->GetQuestId() == QUEST_SPIRIT_OF_THE_STAG)
			{												
				creature->AI()->DoCast(player, SPELL_BLESSING_OF_THE_STAG);
				creature->AI()->DoCast(player, SPELL_RITUAL_BOND_QUEST_COMPLETE);
			}
			return true;
		}

		bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt) 
		{ 			
			if (quest->GetQuestId() == QUEST_SPIRIT_OF_THE_STAG)
			{					
				creature->AI()->DoCast(player, SPELL_RITUAL_BOND_QUEST_COMPLETE);
				player->RemoveAuraFromStack(SPELL_GROVEKEEPERS_TRANCE);
				player->SetPhaseMask(1, true);				
			}

			return true; 
		}
};

/*####
# go_grovekeepers_incense
####*/

class go_grovekeepers_incense : public GameObjectScript
{
public:
    go_grovekeepers_incense() : GameObjectScript("go_grovekeepers_incense") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
		if (player->GetQuestStatus(QUEST_THE_RITUAL_BOND) == QUEST_STATUS_INCOMPLETE)				
		{
			go->CastSpell(player, SPELL_GROVEKEEPERS_TRANCE);			
		}
        return true;
    }
};

/*#####
# item_frenzied_cyclone_bracers
# ToDo: the core fires no script-events for items
#####*/

class item_frenzied_cyclone_bracers : public ItemScript
{
public:
    item_frenzied_cyclone_bracers() : ItemScript("item_frenzied_cyclone_bracers") { }

    bool OnExpire(Player* player, ItemTemplate const* pItemProto) override
    {
		printf("Trigger item_frenzied_cyclone_bracers::OnExpire \n");
		if (player->GetQuestStatus(QUEST_AGAINST_THE_WIND) == QUEST_STATUS_INCOMPLETE)				
		{
			if (GameObject* moon = player->FindNearestGameObject (GO_MOONWELL,3.0f))
			{
				player->KilledMonsterCredit(NPC_FRENZIED_CYCLONE_BRACERS_KILL_CREDIT, NULL);
			}
		} 

        return true;
    }
};
	
/*######
## npc_twilight_worker
######*/

class npc_twilight_worker : public CreatureScript
{
public:
    npc_twilight_worker() : CreatureScript("npc_twilight_worker") { }

    struct npc_twilight_workerAI : public ScriptedAI
    {
        npc_twilight_workerAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32	  _phase;				
		Creature* _forman;
		float	  _oldOrientation;
		
        void Reset()  override
        {
              _timer=0; _phase=0; _oldOrientation=0; _forman=NULL;      			
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (_timer<=diff)				
					DoWork();
				else
					_timer-=diff;				
			} else 
				DoMeleeAttackIfReady();			
        }

		void DoWork()
		{
			switch (_phase)
			{
				case 1:
				{ 
					if (_forman)
						_oldOrientation=me->GetOrientation();
						me->SetFacingTo (me->GetAngle(_forman));
					Talk(2); _timer=60000; _phase=2;
					break;
				}
				case 2:
				{ 
					me->SetOrientation(_oldOrientation);
					_timer=0; _phase=0;
					break;
				}				
			}
		}

		void StartAnim(Creature* forman)
		{
			_forman=forman;
			_phase=1;
		}

		void StopAnim()
		{
			me->SetOrientation(_oldOrientation);
			// ToDo set working aura back 
			_timer=0; _phase=0;					
		}
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_twilight_workerAI (pCreature);
    }
};

/*######
## npc_foreman_balsoth
######*/

class npc_foreman_balsoth : public CreatureScript
{
public:
    npc_foreman_balsoth() : CreatureScript("npc_foreman_balsoth") { }

    struct npc_foreman_balsothAI : public ScriptedAI
    {
        npc_foreman_balsothAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32    _phase;
		Player*   _player;
		Creature* _worker;
		
        void Reset()  override
        {
              _timer=0; _phase=0; _player=NULL; _worker=NULL;      			
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (_timer<=diff)				
					DoWork();
				else
					_timer-=diff;					
				
			} else 
				DoMeleeAttackIfReady();			
        }

		void DoWork()
		{		
			switch (_phase)
			{
				case 0:
				{ 
					_player=me->FindNearestPlayer(10.0f); 
					if (!_player) return;			

					if (_player->GetQuestStatus(QUEST_LEAVE_NO_TRACKS) != QUEST_STATUS_INCOMPLETE) return;
			
					_worker=me->FindNearestCreature(NPC_TWILIGHT_WORKER,10.0f,true); 
					if (!_worker) return;

					me->GetMotionMaster()->MoveIdle(); 
					me->SetFacingTo (me->GetAngle(_worker));
					CAST_AI(npc_twilight_worker::npc_twilight_workerAI, _worker->AI())->StartAnim(me); 			
					_timer=6000; _phase=1; // wait until worker has finish talk
					break;
				}
				case 1:
				{ 
					Talk(0);
					_timer=6000; _phase=2;
					break;
				}
				case 2:
				{ 
					Talk(1);
					_timer=3000; _phase=3;
					break;
				}
				case 3:
				{ 
					_player->KilledMonsterCredit(NPC_DARKSHORE_INTELLIGENCE_CREDIT_1, NULL);	
					_timer=3000; _phase=4;
					break;
				}
				case 4:
				{ 
					CAST_AI(npc_twilight_worker::npc_twilight_workerAI, _worker->AI())->StopAnim();
					_timer=0; _phase=0;
					break;
				}
			}
		}
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_foreman_balsothAI (pCreature);
    }
};

/*######
## npc_thalya_the_voidcaller
######*/

class npc_thalya_the_voidcaller : public CreatureScript
{
public:
    npc_thalya_the_voidcaller() : CreatureScript("npc_thalya_the_voidcaller") { }

    struct npc_thalya_the_voidcallerAI : public ScriptedAI
    {
        npc_thalya_the_voidcallerAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32    _phase;
		Player*   _player;		
		
        void Reset()  override
        {
              _timer=0; _phase=0; _player=NULL;       			
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (_timer<=diff)				
					DoWork();
				else
					_timer-=diff;					
				
			} else 
				DoMeleeAttackIfReady();			
        }

		void DoWork()
		{					
			switch (_phase)
			{
				case 0:
				{ 	
					_player=me->FindNearestPlayer(10.0f); // this is 2D
					if (!_player) return;			

					if (_player->GetQuestStatus(QUEST_STEPPING_UP_SURVEILLANCE) != QUEST_STATUS_INCOMPLETE) return;

					if (me->GetDistance(_player) > 10.0f) return;

					Talk(0);
					_timer=6000; _phase=1; 
					break;
				}
				case 1:
				{ 
					_player->KilledMonsterCredit(NPC_DARKSHORE_INTELLIGENCE_CREDIT_2, NULL);
					_timer=3000; _phase=2;
					break;
				}
				case 2:
				{ 					
					_timer=0; _phase=0;
					break;
				}			
			}
		}
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_thalya_the_voidcallerAI (pCreature);
    }
};

/*####
# npc_onu
####*/

class npc_onu : public CreatureScript
{
    public:
        npc_onu() : CreatureScript("npc_onu") { }

		bool OnGossipHello(Player* player, Creature* creature) override
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	

			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_THE_SEEDS_OF_LIFE) == QUEST_STATUS_INCOMPLETE)				
			{	
				if (player->GetItemCount (ITEM_SEED_OF_EARTH)==0)
				{
					creature->CastSpell(player,SPELL_CREATE_SEED_OF_EARTH,false);
					player->AddItem(ITEM_SEED_OF_EARTH,1);
				}
			}
			return true;
		}
};

/*####
# npc_darkshore_wisp
####*/

class npc_darkshore_wisp : public CreatureScript
{
    public:
        npc_darkshore_wisp() : CreatureScript("npc_darkshore_wisp") { }

		bool OnGossipHello(Player* player, Creature* creature) override
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();			
			if (!creature) return true;
					
			if (player->GetQuestStatus(QUEST_THE_SEEDS_OF_LIFE) == QUEST_STATUS_INCOMPLETE)				
			{							
				if (player->GetItemCount (ITEM_SEED_OF_THE_SKY)==0)
				{
					creature->CastSpell(player,SPELL_CAPTURING,false);
					player->AddItem(ITEM_SEED_OF_THE_SKY,1);
				}
			}
			return true;
		}
};

/*####
# spell_torch_shatterspear_supplies
####*/

class spell_torch_shatterspear_supplies : public SpellScriptLoader
{
    public:
        spell_torch_shatterspear_supplies() : SpellScriptLoader("spell_torch_shatterspear_supplies") { }

        class spell_torch_shatterspear_supplies_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_torch_shatterspear_supplies_SpellScript);
			
            void HandleOnHit()
            {
				Player* player = GetCaster()->ToPlayer();
				if (!player) return;

				// ToDo: wrong in core: caster docast on self
				// GameObject* go = GetExplTargetGObj();
				GameObject* go=NULL;
				go = player->FindNearestGameObject(GO_SHATTERSPEAR_SUPPLIES_1, 5.0f); //  workaround 
				if (!go) go = player->FindNearestGameObject(GO_SHATTERSPEAR_SUPPLIES_2, 5.0f); //  workaround 
				if (!go) return;

				if (go->GetEntry() != GO_SHATTERSPEAR_SUPPLIES_1 && go->GetEntry() != GO_SHATTERSPEAR_SUPPLIES_2) return;

				if (player->GetQuestStatus(QUEST_WAR_SUPPLIES) == QUEST_STATUS_INCOMPLETE)				
				{								
					player->KilledMonsterCredit(NPC_SHATTERSPEAR_SUPPLIES_CREDIT_BUNNY, NULL);	
					go->Delete();
					//go->DestroyForNearbyPlayers();					
				}
            }

			void Register() override
            {                
				OnHit += SpellHitFn(spell_torch_shatterspear_supplies_SpellScript::HandleOnHit);
            }


        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_torch_shatterspear_supplies_SpellScript();
        }
};

/*####
# npc_huntress_sandrya_moonfall
####*/

class npc_huntress_sandrya_moonfall : public CreatureScript
{
    public:
        npc_huntress_sandrya_moonfall() : CreatureScript("npc_huntress_sandrya_moonfall") { }				

		bool OnGossipHello(Player* player, Creature* creature) override
		{
			if (!player || !creature) return true;			

			if (player->GetQuestStatus(QUEST_ENDING_THE_THREAD) == QUEST_STATUS_COMPLETE) return false;
			if (player->GetQuestStatus(QUEST_ENDING_THE_THREAD) == QUEST_STATUS_REWARDED) return false;	

			Creature* jorkil=creature->FindNearestCreature (NPC_JORKIL_THE_SOULRIPPER,100.0f,true);
			
			if (jorkil)
			{							
				if (jorkil->HasAura(SPELL_AEGIS_OF_THE_SHATTERSPEER))					
				{
					player->PrepareGossipMenu(creature,50786,true);	
					player->SendPreparedGossip(creature);
					return true;
				}

				return false;
			} 
			else
			{
				player->PrepareGossipMenu(creature,50787,true);
				player->SendPreparedGossip(creature);				
			}
			
			return true;
		}

		bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override 
		{		
			Creature* jorkil=creature->FindNearestCreature (NPC_JORKIL_THE_SOULRIPPER,100.0f,true);
			if (jorkil)
			{	
				CAST_AI(npc_huntress_sandrya_moonfallAI, creature->AI())->StartAnim(player,jorkil);	
				player->PlayerTalkClass->SendCloseGossip();
			}
			return true;
		}
		
		struct npc_huntress_sandrya_moonfallAI : public ScriptedAI
        {
            npc_huntress_sandrya_moonfallAI(Creature* creature) : ScriptedAI(creature) {}
	  			
			uint32    _timer;
			Player*   _player;
			Creature* _jorkil;					
			uint32    _talkTimer;
			uint32    _phase;
			
			void Reset() override 
			{ 
				_timer=0; _talkTimer=0;  _phase=0; _player=NULL; _jorkil=NULL;
			}

			void StartAnim(Player* player, Creature* jorkil) 
			{
				_player=player; _jorkil=jorkil; _phase=1;
			}    
			
			void EnterCombat(Unit* who) override 
			{ 
				if (who->GetEntry() == uint32(NPC_JORKIL_THE_SOULRIPPER))
					Talk(2);
			}

	        void MoveInLineOfSight(Unit* who) override 
			{ 				
				Player* player=who->ToPlayer();
				if (!player) return;
			
				if (player->GetQuestStatus(QUEST_ENDING_THE_THREAD) != QUEST_STATUS_INCOMPLETE)	return;

				if (me->GetDistance2d(player)<10.0f && _talkTimer==0 && _phase==0 && !me->IsInCombat())
				{
					Talk(1); _talkTimer=45000; 
				}					
			}
			
			void UpdateAI(uint32 diff) override
			{	
				if (_talkTimer<=diff)				
						_talkTimer=0;
					else
						_talkTimer-=diff;	

				if (!UpdateVictim())						
					if (_timer<=diff)				
					{
						DoWork();
					}
					else
						_timer-=diff;										

					DoMeleeAttackIfReady();
			} 

			void DoWork()
			{
				switch (_phase)
				{
					case 1:
					{
						_jorkil->RemoveAuraFromStack(SPELL_AEGIS_OF_THE_SHATTERSPEER);
						Talk(0);						
						_timer=120000; _phase=2;
						break;
					}
					case 2:
					{
						_timer=0; _phase=0;
						break;
					}					
				}
			}
		};
		
        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_huntress_sandrya_moonfallAI(creature);
        }
};

/*####
# spell_constructing
####*/

class spell_constructing : public SpellScriptLoader
{
    public:
        spell_constructing() : SpellScriptLoader("spell_constructing") { }

        class spell_constructing_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_constructing_SpellScript);
			
            void HandleOnHit()
            {
				Player* player = GetCaster()->ToPlayer();
				if (!player) return;
				
				if (player->GetQuestStatus(QUEST_A_NEW_HOME) == QUEST_STATUS_INCOMPLETE)				
				{
					GameObject* go = player->FindNearestGameObject (GO_NEW_HOME_BUILDING_SITE,3.0f);
					if (go)
					{
						player->SummonGameObject(GO_BULDING_CENTER,4690.67f,695.279f,1.15692f,3.927f,0,0,-0.923879f,0.382686f,200);
						player->SummonGameObject(GO_BUILDING_SIDE,4692.65f,693.8f,1.13805f,1.11701f,0,0,0.529919f,0.848048f,200);
						player->SummonGameObject(GO_BUILDING_SIDE,4688.91f,696.616f,1.19471f,3.87463f,0,0,-0.93358f,0.358368f,200);	
						player->SummonGameObject(GO_BUILDING_CENTER_HUT,4682.55f,690.984f,2.00314f,2.68202f,0,0,0.973715f,0.227768f,200);	
						player->KilledMonsterCredit(NPC_GREYMIST_HOVEL_BUILD_QUEST_MARKER, NULL);	
					}
				}				
            }

			void Register() override
            {                
				OnHit += SpellHitFn(spell_constructing_SpellScript::HandleOnHit);
            }


        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_constructing_SpellScript();
        }
};

/*######
## npc_corrupted_blackwood
######*/

class npc_corrupted_blackwood : public CreatureScript
{
public:
    npc_corrupted_blackwood() : CreatureScript("npc_corrupted_blackwood") { }

    struct npc_corrupted_blackwoodAI : public ScriptedAI
    {
        npc_corrupted_blackwoodAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32    _phase;				
		
        void Reset()  override
        {
              _timer=0; _phase=0;       			
        }

		void DamageTaken(Unit* pDone_by, uint32& uiDamage) override  
		{ 
			if (me->GetHealthPct() < 15)
			{
				Talk(0);
				me->GetMotionMaster()->MoveFleeing (pDone_by);
			}		
		}

		void SpellHit(Unit* Hitter, SpellInfo const* spell) override  
		{ 
			if (spell->Id==SPELL_BLESSED_HERB_BUNDLE && Hitter->GetTypeId()==TYPEID_PLAYER)
				_phase=1;
		}

        void UpdateAI(uint32 diff) override
        {				
			if (_timer<=diff)				
				DoWork();
			else
				_timer-=diff;		

            if (!UpdateVictim())
				return;
			else 
				DoMeleeAttackIfReady();			
        }

		void DoWork()
		{					
			switch (_phase)
			{				
				case 1:
				{ 							
					me->CombatStop (true);						
					me->setFaction(35);					
					Talk(1);
					_timer=120000; _phase=2;
					break;
				}
				case 2:
				{ 	
					me->setFaction(82);										
					me->SetReactState(REACT_AGGRESSIVE);					
					_timer=0; _phase=0;
					break;
				}			
			}
		}
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_corrupted_blackwoodAI (pCreature);
    }
};

/*######
## npc_corrupted_blackwood
######*/

class npc_warlord_wrathspine : public CreatureScript
{
public:
    npc_warlord_wrathspine() : CreatureScript("npc_warlord_wrathspine") { }

    struct npc_warlord_wrathspineAI : public ScriptedAI
    {
        npc_warlord_wrathspineAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32    _phase;
		Player*	  _player;
		
        void Reset()  override
        {
              _timer=0; _phase=0;       			
        }

		void DamageTaken(Unit* pDone_by, uint32& uiDamage) override  
		{ 
			float onepct = (float)me->GetMaxHealth()/100;
			float dmgpct = (float)uiDamage/onepct;
			
			if ((me->GetHealthPct()-dmgpct) < 20)
			{									
				if (_player = pDone_by->ToPlayer())
				{
					if (_player->GetQuestStatus(QUEST_THE_DARKSCALE_WARLOAD) == QUEST_STATUS_INCOMPLETE)
					{
						_phase=1;
						uiDamage=0;
					}
				}				
			}		
		}

        void UpdateAI(uint32 diff) override
        {				
			if (_timer<=diff)				
				DoWork();
			else
				_timer-=diff;		

            if (!UpdateVictim())
				return;
			else 
				DoMeleeAttackIfReady();			
        }

		void DoWork()
		{					
			switch (_phase)
			{				
				case 1:
				{ 						
					me->CombatStop (true);						
					me->setFaction(35);		
					Talk(0);
					me->SetHealth(me->GetMaxHealth()/100);
					DoCast(SPELL_PERMANENT_FEIGN_DEATH);
					if (_player) _player->KilledMonsterCredit(NPC_WARLOAD_WRATHSPINE, NULL);
					_timer=120000; _phase=2;
					break;
				}
				case 2:
				{ 	
					me->setFaction(72);	
					me->RemoveAllAuras();
					me->RemoveAuraFromStack(SPELL_PERMANENT_FEIGN_DEATH);
					me->DespawnOrUnsummon();				
					_timer=0; _phase=0;
					break;
				}			
			}
		}
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_warlord_wrathspineAI (pCreature);
    }
};

/*######
## npc_queen_azshara
######*/

class npc_queen_azshara : public CreatureScript
{
public:
    npc_queen_azshara() : CreatureScript("npc_queen_azshara") { }

    struct npc_queen_azsharaAI : public ScriptedAI
    {
        npc_queen_azsharaAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32    _phase;
		Player*	  _player;
		
        void StartAnim(Player* player) 
        {
              _timer=0; _phase=0; _player=player;      			
        }
		
        void UpdateAI(uint32 diff) override
        {	
			if (_timer<=diff)				
				DoWork();
			else
				_timer-=diff;		

            if (!UpdateVictim())
				return;
			else 
				DoMeleeAttackIfReady();			
        }	

		void DoWork()
		{
			if (!_player) return;

			switch (_phase)
			{
			case 0:
				{
					_timer=2000; _phase=1; // first delay
					break;
				}
			case 1:
				{
					Talk(1);
					_timer=16000; _phase=2; // pause for me and answer
					break;
				}
			case 2:
				{
					Talk(2);
					_timer=8000; _phase=3; 
					break;
				}
			case 3:
				{
					Talk(3);
					_timer=18000; _phase=4; // wait for me and answer
					break;
				}			
			case 4:
				{
					_player->KilledMonsterCredit(NPC_AZSHARA_EVENT_CREDIT, NULL);	
					me->DespawnOrUnsummon();
					break;
				}
			}
		
		}

    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_queen_azsharaAI (pCreature);
    }
};

/*######
## npc_malfurion_stormrage
######*/

class npc_malfurion_stormrage : public CreatureScript
{
public:
    npc_malfurion_stormrage() : CreatureScript("npc_malfurion_stormrage") { }

    struct npc_malfurion_stormrageAI : public ScriptedAI
    {
        npc_malfurion_stormrageAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32    _phase;
		Player*	  _player;
		
        void StartAnim(Player* player) 
        {
              _timer=0; _phase=0; _player=player;      			
        }
		
        void UpdateAI(uint32 diff) override
        {	
			if (_timer<=diff)				
				DoWork();
			else
				_timer-=diff;		

            if (!UpdateVictim())
				return;
			else 
				DoMeleeAttackIfReady();			
        }	

		void DoWork()
		{
			if (!_player) return;

			switch (_phase)
			{
			case 0:
				{
					_timer=10000; _phase=1; // first delay and waiting on talk queen
					break;
				}
			case 1:
				{
					Talk(1);
					_timer=24000; _phase=2; // wait for me and 2 talk from queen
					break;
				}
			case 2:
				{
					me->SetFacingTo (me->GetAngle(_player));
					Talk(2);
					_timer=8000; _phase=3; 
					break;
				}
			case 3:
				{
					Talk(3);
					// chanche to take new quest???
					_timer=180000; _phase=4; // talk help and wait for quest taker
					break;
				}
			case 4:
				{		
					me->DespawnOrUnsummon();
					_timer=0; _phase=0; 
					break;
				}		
			}		
		}
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_malfurion_stormrageAI (pCreature);
    }
};

/*######
## npc_darkscale_priestess
######*/

class npc_darkscale_priestess : public CreatureScript
{
public:
    npc_darkscale_priestess() : CreatureScript("npc_darkscale_priestess") { }

    struct npc_darkscale_priestessAI : public ScriptedAI
    {
        npc_darkscale_priestessAI(Creature *c) : ScriptedAI(c) {}

        uint32    _timer;  
		uint32    _phase;
		Player*   _player;
		Creature* _queen;
		Creature* _malfurion;
		
        void Reset()  override
        {
              _timer=0; _phase=0; _player=NULL; _queen=NULL; _malfurion=NULL;     			
        }
		
		void JustDied(Unit* killer) override 
		{ 	
			_player=killer->ToPlayer();
			if (!_player) 
			{
				printf("Killed by Pet \n");
				_player=me->FindNearestPlayer (10.0f);
				if (!_player) return;
			}

			Creature* priestess = me->FindNearestCreature (NPC_DARKSCALE_PRIESTESS,50.0f);
			if (!priestess) // and only if she is the last, spawns the queen..
			{
				if (_player->GetQuestStatus(QUEST_THE_OFFERING_TO_AZSHARA) == QUEST_STATUS_INCOMPLETE)
				{
					me->SummonCreature (NPC_QUEEN_AZSHARA, 4607.107f, 884.2894f, 37.89753f, 2.423f);
					me->SummonCreature (NPC_MALFURION_STORMRAGE, 4595.326172f, 905.159851f, 42.118744f, 5.327f);
					
					if (_queen = me->FindNearestCreature (NPC_QUEEN_AZSHARA, 100.0f))											
						CAST_AI(npc_queen_azshara::npc_queen_azsharaAI, _queen->AI())->StartAnim(_player);	
					
					if (_malfurion= me->FindNearestCreature (NPC_MALFURION_STORMRAGE, 100.0))											
						CAST_AI(npc_malfurion_stormrage::npc_malfurion_stormrageAI, _malfurion->AI())->StartAnim(_player);	
				}
			}
					
		} 

        void UpdateAI(uint32 diff) override
        {							
            if (!UpdateVictim())
				return;
			else 
				DoMeleeAttackIfReady();			
        }	
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_darkscale_priestessAI (pCreature);
    }
};


void AddSC_darkshore()
{
	new npc_cerellean_whiteclaw();
	new npc_volcor();
	new npc_shaldyn();
	new npc_gershala_nightwhisper();
	new npc_decomposing_thistle_bear();	
	new npc_withered_ent();	
	new npc_great_thistle_bear_spirit();
	new npc_great_moonstalker_spirit();
	new npc_great_stag_spirit();
	new go_grovekeepers_incense();
	new item_frenzied_cyclone_bracers();
	new npc_twilight_worker();
	new npc_foreman_balsoth();
	new npc_thalya_the_voidcaller();
	new npc_onu();
	new npc_darkshore_wisp();
	new spell_torch_shatterspear_supplies();
	new npc_huntress_sandrya_moonfall();
	new spell_constructing();
	new npc_corrupted_blackwood();
	new npc_warlord_wrathspine();
	new npc_darkscale_priestess();
	new npc_queen_azshara();
	new npc_malfurion_stormrage();
}
