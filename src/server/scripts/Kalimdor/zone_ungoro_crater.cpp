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

        GameObjectAI* GetAI(GameObject* go) const OVERRIDE
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

			void Reset()  OVERRIDE
			{
				_timer=1000; 
			}

			void UpdateAI(uint32 diff) OVERRIDE
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

        CreatureAI* GetAI(Creature* creature) const OVERRIDE
        {
            return new npc_ungoro_pit_bunnyAI(creature);
        }
};


void AddSC_ungoro_crater()
{
	new go_northern_crystal_pylon();
	new npc_ungoro_pit_bunny();
}
