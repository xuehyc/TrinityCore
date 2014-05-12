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

enum TirisfalGlades
{
	NPC_SCARLET_CORPSE						= 49340,
	QUEST_RECRUITMENT						= 26800,
	
	NPC_LILIAN_VOSS_1						= 38895, 
	NPC_MARSHAL_REDPATH_1					= 49230,
	NPC_VALDRED_MORAY						= 49231,
	NPC_CARETAKER_CAICE						= 2307,
	QUEST_THE_WAKENING						= 24960,

	NPC_LILIAN_VOSS_2 						= 38910, 
	QUEST_THE_TRUTH_OF_THE_GRAVE			= 24961,

	NPC_ARADNE								= 50372,
	NPC_RISEN_DEAD							= 50374,

	NPC_MARSHAL_REDPATH_2					= 49424,
	NPC_ROTBRAIN_BERSERKER					= 49422,
	NPC_ROTBRAIN_MAGUS						= 49423,
	NPC_DEATHGUARD_PROTEKTOR				= 49428,
	QUEST_ASSAULT_ON_THE_ROTBRAIN_ENCAMPMENT = 24971,

};

/*######
## npc_scarlet_corpse
######*/

class npc_scarlet_corpse : public CreatureScript
{
public:
    npc_scarlet_corpse() : CreatureScript("npc_scarlet_corpse") { }
	
	bool OnGossipHello(Player* player, Creature* creature) override
    {
		if (!player) return true;
        player->PlayerTalkClass->SendCloseGossip();		

		if (!creature) return true;

		if (player->GetQuestStatus(QUEST_RECRUITMENT) == QUEST_STATUS_INCOMPLETE)
        {
			if (player->IsWithinDistInMap(creature, 10.0f))
			{				
				player->KilledMonsterCredit(creature->GetEntry(), NULL);
				creature->DespawnOrUnsummon();
			}
		}        
        return true;
    }
};


/*######
## npc_lilian_voss
######*/

class npc_lilian_voss : public CreatureScript
{
public:
    npc_lilian_voss() : CreatureScript("npc_lilian_voss") {count=0;}
	
	uint32 count;

	bool OnGossipHello(Player* player, Creature* creature) override
    {		
		switch (creature->GetEntry())
		{
			case NPC_LILIAN_VOSS_1:
			{
				if (player->GetQuestStatus(QUEST_THE_WAKENING) == QUEST_STATUS_INCOMPLETE)
				{
					return false;
				}
				break;
			}
			case NPC_LILIAN_VOSS_2:
			{
				if (player->GetQuestStatus(QUEST_THE_TRUTH_OF_THE_GRAVE) == QUEST_STATUS_INCOMPLETE)
				{
					return false;
				}
				break;
			}
		}	
        return true;
    }

	bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {      
		if (!player) return true;        
		if (!creature) return true;

		switch (creature->GetEntry())
		{
			case NPC_LILIAN_VOSS_1:
			{
				if (player->GetQuestStatus(QUEST_THE_WAKENING) == QUEST_STATUS_INCOMPLETE)
				{
					count++;
					if ( count < 2) return false;
					player->CLOSE_GOSSIP_MENU();
					CAST_AI(npc_lilian_vossAI, creature->AI())->player = player;
					CAST_AI(npc_lilian_vossAI, creature->AI())->phase = 1;
				}
				break;
			}
			case NPC_LILIAN_VOSS_2:
			{
				if (player->GetQuestStatus(QUEST_THE_TRUTH_OF_THE_GRAVE) == QUEST_STATUS_INCOMPLETE)
				{
					player->CLOSE_GOSSIP_MENU();
					CAST_AI(npc_lilian_vossAI, creature->AI())->player = player;
					CAST_AI(npc_lilian_vossAI, creature->AI())->phase = 11;
				}
				break;
			}
		}	       
        return true;
	}

	struct npc_lilian_vossAI : public ScriptedAI
    {
		npc_lilian_vossAI(Creature* creature) : ScriptedAI(creature) {}

		uint8  phase;
		uint32 timer;
		Player* player;		

        void Reset() override
        {
			// phase   1-3 for NPC_LILIAN_VOSS_1
			// phase 11-13 for NPC_LILIAN_VOSS_2
            phase=0; 
			timer=0;			
        }
	   
		void UpdateAI(uint32 Diff) override
		{
			if (!UpdateVictim())
			{
				if (timer <= Diff)
				{
			        switch (phase)
				    {
						// phase   1-3 for NPC_LILIAN_VOSS_1
						case 1:
						{
							me->SetFacingTo (me->GetAngle(player));						
							Talk(0);
							timer = 3000; phase = 2;
					        break;
						}
						case 2:
						{
							if (player)	
								player->KilledMonsterCredit(NPC_LILIAN_VOSS_1, NULL);
							me->SetSpeed(MOVE_WALK,1.3f,true);						
							Creature* creature = me->FindNearestCreature (NPC_CARETAKER_CAICE,300.0f);						
							if (creature) 
								me->GetMotionMaster()->MovePoint(1, creature->GetPositionX(),creature->GetPositionY(),creature->GetPositionZ());
							timer = 8000; phase = 3;
		                    break;
						}
						case 3:
						{							
							me->DespawnOrUnsummon();
							timer = 0; phase = 0;
			                break;
						}
						// phase 11-13 for NPC_LILIAN_VOSS_2
						case 11:
						{
							me->SetFacingTo (me->GetAngle(player));
							me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
							Talk(0);
							timer = 5000; phase = 12;
						    break;
						}
						case 12:
						{
							if (player)	player->KilledMonsterCredit(NPC_LILIAN_VOSS_2, NULL);
							me->SetSpeed(MOVE_WALK, 1.4f, true);
							me->GetMotionMaster()->MovePath(NPC_LILIAN_VOSS_2,true);						
							timer = 12000; phase = 13;
							break;
						}
						case 13:
						{																								
							me->DespawnOrUnsummon();
							timer = 0; phase = 0;
							break;
						}
					}
			    }
				else
					    timer -= Diff;
				} else
					DoMeleeAttackIfReady();	
		}
	};

	CreatureAI* GetAI(Creature* creature) const override
    {
		return new npc_lilian_vossAI(creature);
    }
};


/*######
## npc_marshal_redpath
######*/

class npc_marshal_redpath : public CreatureScript
{
public:
    npc_marshal_redpath() : CreatureScript("npc_marshal_redpath") { count=0; }
	
	uint32 count;

	bool OnGossipHello(Player* player, Creature* creature) override
    {
		if (creature->GetEntry() == NPC_MARSHAL_REDPATH_1 && player->GetQuestStatus(QUEST_THE_WAKENING) == QUEST_STATUS_INCOMPLETE) 
		{			
			return false;
		} 			
        return true;		
    }

	bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {      
		if (!player) return true;        
		if (!creature) return true;			

		if (creature->GetEntry() == NPC_MARSHAL_REDPATH_1 && action == 1 &&
				player->GetQuestStatus(QUEST_THE_WAKENING) == QUEST_STATUS_INCOMPLETE)
        {	
			count++;
			if ( count < 2) return false;
			CAST_AI(npc_marshal_redpathAI, creature->AI())->player = player;
			CAST_AI(npc_marshal_redpathAI, creature->AI())->phase = 1;			
		} 
		player->CLOSE_GOSSIP_MENU();
        return true;
	}

	struct npc_marshal_redpathAI : public ScriptedAI
    {
		npc_marshal_redpathAI(Creature* creature) : ScriptedAI(creature) {}

		uint8  phase;
		uint32 timer;
		Player* player;

        void Reset() override
        {			
            phase=0; 
			timer=0;
        }
	   
		void EnterCombat(Unit* who) override
		{
            if (who->GetEntry() == NPC_MARSHAL_REDPATH_2)  
			{
				Talk(0);
			}
        }

		void UpdateAI(uint32 Diff) override
		{
			if (!UpdateVictim())
			{
				if (timer <= Diff)
				{
		            switch (phase)
			        {
						case 1:
						{
							me->SetFacingTo (me->GetAngle(player));
							Talk(0);
							timer = 3000; phase = 2;
		                    break;
						}					
						case 2:
						{
							if (player)	
								player->KilledMonsterCredit(NPC_MARSHAL_REDPATH_1, NULL);
							me->SetSpeed(MOVE_WALK,1.3f,true);
							Creature* creature = me->FindNearestCreature (NPC_CARETAKER_CAICE,300.0f);						
							if (creature) 
								me->GetMotionMaster()->MovePoint(1, creature->GetPositionX(),creature->GetPositionY(),creature->GetPositionZ());
							timer = 8000; phase = 3;
				            break;
						}
						case 3:
						{																		
							me->DespawnOrUnsummon();
							timer = 0; phase = 0;
						    break;
						}
					}
			    }
				else
					    timer -= Diff;
			} else
				DoMeleeAttackIfReady();		
		} 							
	};

	CreatureAI* GetAI(Creature* creature) const override
    {
		return new npc_marshal_redpathAI(creature);
    }
};


/*######
## npc_valdred_moray
######*/

class npc_valdred_moray : public CreatureScript
{
public:
    npc_valdred_moray() : CreatureScript("npc_valdred_moray") { count=0; }
	
	uint32 count;

	bool OnGossipHello(Player* player, Creature* creature) override
    {
		if (creature->GetEntry() == NPC_VALDRED_MORAY && player->GetQuestStatus(QUEST_THE_WAKENING) == QUEST_STATUS_INCOMPLETE) 
		{			
			return false;
		} 			
        return true;		
    }

	bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {      
		if (!player) return true;        
		if (!creature) return true;			

		if (creature->GetEntry() == NPC_VALDRED_MORAY && action == 1 &&
				player->GetQuestStatus(QUEST_THE_WAKENING) == QUEST_STATUS_INCOMPLETE)
        {	
			count++;
			if ( count < 2) return false;
			CAST_AI(npc_valdred_morayAI, creature->AI())->player = player;
			CAST_AI(npc_valdred_morayAI, creature->AI())->phase = 1;			
		} 
		player->CLOSE_GOSSIP_MENU();
        return true;
	}

	struct npc_valdred_morayAI : public ScriptedAI
    {
		npc_valdred_morayAI(Creature* creature) : ScriptedAI(creature) {}

		uint8  phase;
		uint32 timer;
		Player* player;

        void Reset() override
        {			
            phase=0; 
			timer=0;
        }
	   
		void UpdateAI(uint32 Diff) override
		{
			if (!UpdateVictim())
			{
				if (timer <= Diff)
				{
			        switch (phase)
				    {
						case 1:
						{
							me->SetFacingTo (me->GetAngle(player));
							Talk(0);
							timer = 3000; phase = 2;
				            break;
						}					
						case 2:
						{
							if (player)	
								player->KilledMonsterCredit(NPC_VALDRED_MORAY, NULL);
							me->SetSpeed(MOVE_WALK,1.3f,true);						
							Creature* creature = me->FindNearestCreature (NPC_CARETAKER_CAICE,300.0f);						
							if (creature) 
								me->GetMotionMaster()->MovePoint(1, creature->GetPositionX(),creature->GetPositionY(),creature->GetPositionZ());
							timer = 8000; phase = 3;
							break;
						}
						case 3:
						{											
							me->DespawnOrUnsummon();
							timer = 0; phase = 0;
	                        break;
						}
					}
				}
	            else
		                timer -= Diff;
			} else
				DoMeleeAttackIfReady();	
		}
	};

	CreatureAI* GetAI(Creature* creature) const override
    {
		return new npc_valdred_morayAI(creature);
    }
};


/*######
## npc_aradne
######*/

class npc_aradne : public CreatureScript
{
public:
    npc_aradne() : CreatureScript("npc_aradne") { }

    struct npc_aradneAI : public ScriptedAI
    {
        npc_aradneAI(Creature *c) : ScriptedAI(c) {timer=20000;}

		uint32 timer;

        void Reset()  override
        {
            timer=urand(20000,45000);           			
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (timer <= diff)
					{
						me->SummonCreature (NPC_RISEN_DEAD,me->GetPositionX(),me->GetPositionY(),me->GetPositionZ() - 4.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN,40000);
						timer = urand(45000,60000);
						Talk(0);
					}
					else timer -= diff;
				
			} else			
				DoMeleeAttackIfReady();
			
        }
    };

	   CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_aradneAI (pCreature);
    }
};


/*######
## npc_risen_dead
######*/

class npc_risen_dead : public CreatureScript
{
public:
    npc_risen_dead() : CreatureScript("npc_risen_dead") { }

    struct npc_risen_deadAI : public ScriptedAI
    {
        npc_risen_deadAI(Creature *c) : ScriptedAI(c) {}

		uint32 timer;
		uint32 phase;
		uint32 WishToBeDead;

        void Reset()  override
        {
            timer=100;
			phase=0;
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (timer <= diff)
					{
						
						switch (phase)
						{
							case 0:
							{
								WishToBeDead = urand(0,100);
								if (WishToBeDead<80)
								{
									Talk(0); // i wish to be dead
									me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_CRY);
									phase=1;									
									timer=5000;
								} 
								else 								
								{
									Talk(1); // thank you
									me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_APPLAUD);
									phase=10;
									timer=5000;
								}							
								break;
							}
							case 1:
							{								
								me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_ROAR);
								phase=2;									
								timer=8000;
								break;
							}
							case 2:
							{
								me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_CRY);
								phase=3;									
								timer=4000;
								break;
							}
							case 3:
							{
								me->DespawnOrUnsummon ();
								phase=0;									
								timer=0;
								break;
							}
							case 10:
							{
								Creature* creature = me->FindNearestCreature (NPC_CARETAKER_CAICE,300.0f);						
								if (creature) 
									me->GetMotionMaster()->MovePoint(1, creature->GetPositionX(),creature->GetPositionY(),creature->GetPositionZ());
								phase=3;									
								timer=5000;
								break;
							}
						}

					}
					else timer -= diff;
				
			} else			
				DoMeleeAttackIfReady();
			
        }
    };

	   CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_risen_deadAI (pCreature);
    }
};


/*######
## npc_rotbrain_berserker
######*/

class npc_rotbrain_berserker : public CreatureScript
{
public:
    npc_rotbrain_berserker() : CreatureScript("npc_rotbrain_berserker") { }

    struct npc_rotbrain_berserkerAI : public ScriptedAI
    {
        npc_rotbrain_berserkerAI(Creature *c) : ScriptedAI(c) {}
		
		uint32 timer;

		void Reset()  override
        {
           timer=0;
        }

		void EnterCombat(Unit* who) override
		{            			
			Talk(0);			
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (timer <= diff)
				{
					if (Creature* infantry = me->FindNearestCreature (NPC_DEATHGUARD_PROTEKTOR,3.0f))
					{
						me->SetFacingTo (me->GetAngle(infantry));
						me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
						timer=urand(1800,2200);
					}
				} else 
					timer -= diff;												
			} else			
				DoMeleeAttackIfReady();			
        }
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_rotbrain_berserkerAI (pCreature);
    }
};


/*######
## npc_rotbrain_magus
######*/

class npc_rotbrain_magus : public CreatureScript
{
public:
    npc_rotbrain_magus() : CreatureScript("npc_rotbrain_magus") { }

    struct npc_rotbrain_magusAI : public ScriptedAI
    {
        npc_rotbrain_magusAI(Creature *c) : ScriptedAI(c) {}
		uint32 timer;

		void Reset()  override
        {
           timer=0;
        }

		void EnterCombat(Unit* who) override
		{          
			Talk(0);
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (timer <= diff)
				{
					if (Creature* infantry = me->FindNearestCreature (NPC_DEATHGUARD_PROTEKTOR,3.0f))
					{
						me->SetFacingTo (me->GetAngle(infantry));
						me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
						timer=urand(1800,2200);
					}
				} else 
					timer -= diff;												
			} else			
				DoMeleeAttackIfReady();			
        }
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_rotbrain_magusAI (pCreature);
    }
};


/*######
## npc_deathguard_protector
######*/

class npc_deathguard_protector : public CreatureScript
{
public:
    npc_deathguard_protector() : CreatureScript("npc_deathguard_protector") { }

    struct npc_deathguard_protectorAI : public ScriptedAI
    {
        npc_deathguard_protectorAI(Creature *c) : ScriptedAI(c) {}
		
		uint32 timer;

		void Reset()  override
        {
           timer=0;
        }

        void UpdateAI(uint32 diff) override
        {						
            if (!UpdateVictim())
			{
				if (timer <= diff)
				{
					if (Creature* rotbrain = me->FindNearestCreature (NPC_ROTBRAIN_BERSERKER,3.0f))
					{
						me->SetFacingTo (me->GetAngle(rotbrain));
						me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
						timer=urand(1800,2200);
					} 
					else if (Creature* rotbrain = me->FindNearestCreature (NPC_ROTBRAIN_MAGUS,3.0f))
					{
						me->SetFacingTo (me->GetAngle(rotbrain));
						me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
						timer=urand(1800,2200);					
					}
				} else 
					timer -= diff;												
			} else			
				DoMeleeAttackIfReady();			
        }
    };

	CreatureAI* GetAI(Creature* pCreature) const  override
    {
        return new npc_deathguard_protectorAI (pCreature);
    }
};




/*######################################
## more ToDo
########################################*/




void AddSC_tirisfal_glades()
{
	new npc_scarlet_corpse();
	new npc_lilian_voss();
	new npc_marshal_redpath();
	new npc_valdred_moray();
	new npc_aradne();
	new npc_risen_dead();
	new npc_rotbrain_berserker();
	new npc_rotbrain_magus();
	new npc_deathguard_protector();

}
