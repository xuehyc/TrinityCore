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
	NPC_HEARTRAZOR							= 47486,

	QUEST_THE_TWILIGHT_SKYMASTER			= 28098,
	NPC_HEARTRAZOR_2B						= 47508,
	NPC_HEARTRAZOR_1B						= 47503,
	SPELL_SUMMON_HEARTRAZOR_1B				= 88591, // Kill 47504, Summon 47503
	SPELL_SUMMON_HEARTRAZOR_2B				= 88592, // Summon 47508
	SPELL_SUMMON_AERIE_GUNNER_WIND_RIDER	= 88624, // Summon NPC_CAPTURED_WIND_RIDER
	NPC_CAPTURED_WIND_RIDER					= 47527,
	SPELL_COWER_ANIM_SET					= 88598, // Dummy 127
	SPELL_RICHTOFENS_DISARM					= 88602, // Disarm
	SPELL_SUMMON_RICHTOFENS_WIND_RIDER		= 88601,
	NPC_RICHTOFENS_WIND_RIDER				= 47509,
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
					if (!me->FindNearestCreature (NPC_TWILIGHT_SUBDUER,50.0, true))
					{
						player->KilledMonsterCredit(NPC_HEARTRAZOR, NULL);						 
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

/*####
# npc_paoka_swiftmountain
####*/

class npc_paoka_swiftmountain : public CreatureScript
{
    public:
        npc_paoka_swiftmountain() : CreatureScript("npc_paoka_swiftmountain") { }

		bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) 
		{ 			
			creature->CastSpell(player,SPELL_SUMMON_HEARTRAZOR_2B);
			return true; 
		}


		struct npc_paoka_swiftmountainAI : public ScriptedAI
        {
            npc_paoka_swiftmountainAI(Creature* creature) : ScriptedAI(creature) {}	  		

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
            return new npc_paoka_swiftmountainAI(creature);
        }
};

/*####
# npc_heartrazor_2b
####*/

class npc_heartrazor_2b : public CreatureScript
{
    public:
        npc_heartrazor_2b() : CreatureScript("npc_heartrazor_2b") { }

		bool OnGossipHello(Player* player, Creature* creature) OVERRIDE
		{
			if (!player) return true;

			player->PlayerTalkClass->SendCloseGossip();	
					
			if (player->GetQuestStatus(QUEST_THE_TWILIGHT_SKYMASTER) == QUEST_STATUS_INCOMPLETE)				
			{			
				// ToDo: the monsterkill should first be givig after riding the mount
				player->KilledMonsterCredit(NPC_HEARTRAZOR_1B, NULL);										
			}
			return true;
		}		
};

/*####
# npc_twilight_skymaster_richtofen
####*/

class npc_twilight_skymaster_richtofen : public CreatureScript
{
    public:
        npc_twilight_skymaster_richtofen() : CreatureScript("npc_twilight_skymaster_richtofen") { }		

		struct npc_twilight_skymaster_richtofenAI : public ScriptedAI
        {
            npc_twilight_skymaster_richtofenAI(Creature* creature) : ScriptedAI(creature) {}	  		

			Player* _player;
			uint32	_timer;
			
			void Reset() OVERRIDE 
			{ 
				_player=NULL; _timer=2000;
			}

			void DamageTaken(Unit* pDone_by, uint32& uiDamage) OVERRIDE  
			{ 
				if (Player* player = pDone_by->ToPlayer())
				{
					_player=player;					
				}				
			}

			void EnterCombat(Unit* who) OVERRIDE 
			{
				me->CastSpell (me,SPELL_SUMMON_RICHTOFENS_WIND_RIDER);
				Talk(0);
			}

			void UpdateAI(uint32 diff) OVERRIDE
			{	
				if (me->IsInCombat())
				{
					if (_timer <= diff)				
					{
						DoWork();
						_timer=10000;
					}
					else 
						_timer -= diff;				
				}

				if (!UpdateVictim())						
					return;							
				else								
					DoMeleeAttackIfReady();
			} 

			void DoWork()
			{
				if (me->GetHealthPct()<30)
				{
					DoCast(80003);
					return;
				}				
				if (me->GetDistance (_player)>=25)
				{
					DoCast(6660);
					return;
				}
				Talk(0);				
			}

        };
		
        CreatureAI* GetAI(Creature* creature) const OVERRIDE
        {
            return new npc_twilight_skymaster_richtofenAI(creature);
        }
};

/*####
# npc_richtofens_wind_rider
####*/

class npc_richtofens_wind_rider : public CreatureScript
{
    public:
        npc_richtofens_wind_rider() : CreatureScript("npc_richtofens_wind_rider") { }		

		struct npc_richtofens_wind_riderAI : public ScriptedAI
        {
            npc_richtofens_wind_riderAI(Creature* creature) : ScriptedAI(creature) {}	  		

			uint32	_timer;
			uint32	_phase;			

			void Reset() OVERRIDE 
			{ 
				_timer=2000; _phase=0;
			}

			void UpdateAI(uint32 diff) OVERRIDE
			{															
				if (_timer <= diff)				
					DoWork();				
				else 
					_timer -= diff;						
			
			} 

			void DoWork()
			{
				switch (_phase)
				{
				case 0:
					{
						Position pos = {-5282.0f,-1324.0f,120.0f,0};						
						me->GetMotionMaster()->MoveTakeoff(0,pos);
						_timer=15000; _phase=1;
						break;
					}
				case 1:
					{
						me->DespawnOrUnsummon();
						_timer=0; _phase=0;					
						break;
					}
				
				}
			
			}

        };
		
        CreatureAI* GetAI(Creature* creature) const OVERRIDE
        {
            return new npc_richtofens_wind_riderAI(creature);
        }
};



void AddSC_thousand_needles()
{
	new npc_dead_employee();
	new npc_highperch_prideling();
	new npc_twilight_subduer();
	new npc_paoka_swiftmountain();
	new npc_heartrazor_2b();
	new npc_twilight_skymaster_richtofen();
	new npc_richtofens_wind_rider();

}
