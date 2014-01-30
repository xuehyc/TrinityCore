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

/*####
# npc_decomposing_thistle_bear
####*/

class npc_decomposing_thistle_bear : public CreatureScript
{
    public:
        npc_decomposing_thistle_bear() : CreatureScript("npc_decomposing_thistle_bear") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
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

			void IsSummonedBy(Unit* summoner) OVERRIDE
			{			
				m_player = summoner->ToPlayer();
				if (m_player) m_player->KilledMonsterCredit(NPC_DARKSCALE_SCOUT_KILL_CREDIT, NULL);	
			}

			void AttackStart(Unit* who) OVERRIDE
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

			void MoveInLineOfSight(Unit* who) OVERRIDE 
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

            void UpdateAI(uint32 diff) OVERRIDE
            {
				if (!UpdateVictim())
					return;
              
				DoMeleeAttackIfReady();
            }           
        };

        CreatureAI* GetAI(Creature* creature) const OVERRIDE
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

		bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) OVERRIDE 
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

		bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) OVERRIDE 
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

		bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) OVERRIDE 
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

    bool OnGossipHello(Player* player, GameObject* go) OVERRIDE
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

    bool OnExpire(Player* player, ItemTemplate const* pItemProto) OVERRIDE
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
		
        void Reset()  OVERRIDE
        {
              _timer=0; _phase=0; _oldOrientation=0; _forman=NULL;      			
        }

        void UpdateAI(uint32 diff) OVERRIDE
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

	CreatureAI* GetAI(Creature* pCreature) const  OVERRIDE
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
		
        void Reset()  OVERRIDE
        {
              _timer=0; _phase=0; _player=NULL; _worker=NULL;      			
        }

        void UpdateAI(uint32 diff) OVERRIDE
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

	CreatureAI* GetAI(Creature* pCreature) const  OVERRIDE
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
		
        void Reset()  OVERRIDE
        {
              _timer=0; _phase=0; _player=NULL;       			
        }

        void UpdateAI(uint32 diff) OVERRIDE
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

	CreatureAI* GetAI(Creature* pCreature) const  OVERRIDE
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

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
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

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
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

			void Register() OVERRIDE
            {                
				OnHit += SpellHitFn(spell_torch_shatterspear_supplies_SpellScript::HandleOnHit);
            }


        };

        SpellScript* GetSpellScript() const OVERRIDE
        {
            return new spell_torch_shatterspear_supplies_SpellScript();
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
}
