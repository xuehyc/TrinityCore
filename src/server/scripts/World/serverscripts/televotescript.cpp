//
//
//	
//


class televotescript : public CreatureScript
{
public:
    televotescript() : CreatureScript("televotescript") { }

	bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action)
	{
		// Main menu
		if (sender == GOSSIP_SENDER_MAIN)
			SendDefaultMenu_televotescript(player, _Creature, action);

		return true;
	}

	bool OnGossipHello(Player *player, Creature *_Creature)
	{
		//Go straight to the main menu
		player->ADD_GOSSIP_ITEM( 5, "Main"                    , GOSSIP_SENDER_MAIN, 6000);
		player->PlayerTalkClass->SendGossipMenu(6000,_Creature->GetGUID());
		return true;
	}
	void creategossiplist(Player *player, Creature *_Creature, std::string parent)
	{
	player->PlayerTalkClass->ClearMenus();
		QueryResult result = WorldDatabase.PQuery("SELECT id,name,folder, faction FROM telelist WHERE parent='%s'", parent.c_str());
			if(result) //check if we got a result
			{
					Field *fields = result->Fetch();  
				do{
					if(player->GetTeam() == fields[3].GetUInt32() || fields[3].GetUInt32() == 0)
					{
						if(fields[2].GetUInt32() == 1)
						{
							std::stringstream folder;
							folder << fields[1].GetString() << " >>";
							player->ADD_GOSSIP_ITEM( 5, folder.str().c_str() , GOSSIP_SENDER_MAIN, fields[0].GetInt32());
						}else{
							std::stringstream teleport;
							teleport << fields[1].GetString();
							player->ADD_GOSSIP_ITEM( 3, teleport.str().c_str() , GOSSIP_SENDER_MAIN, fields[0].GetInt32());					
						}
					}
				}while(result->NextRow());
			}else{ // if we don't then we will display a message
				_Creature->MonsterWhisper("Nothing to display", player->GetGUID());
			}
			
		QueryResult BackResult = WorldDatabase.PQuery("SELECT id FROM telelist WHERE name IN (SELECT parent FROM telelist WHERE name='%s')", parent.c_str());
		if(BackResult)
		{
			Field *BackFields = BackResult->Fetch();
			player->ADD_GOSSIP_ITEM( 5, "<- Back", GOSSIP_SENDER_MAIN, BackFields[0].GetUInt32());
		}
	player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());
	}


	
	void SendDefaultMenu_televotescript(Player *player, Creature *_Creature, uint32 action )
	{
		uint32 type = 0;
		std::stringstream level_error;

			QueryResult result = WorldDatabase.PQuery("SELECT id,name,parent,folder,x,y,z,mapid,levelreq,flag,groupid FROM telelist WHERE id = '%u'",action);
			if(result){
				Field* pFields = result->Fetch();
				
				int32 db_id 			= pFields[0].GetInt32(); // don't need
				int32 db_folder 		= pFields[3].GetInt32();		
				std::string db_name 	= pFields[1].GetString();
				int32 db_flag 		= pFields[9].GetInt32();	

				if(db_folder)// we check if its a folder first
				{
					creategossiplist(player,_Creature, db_name.c_str());
				}else if(db_flag){
					int32 db_groupid 			= pFields[10].GetInt32();
					QueryResult randomresult = WorldDatabase.PQuery("SELECT x,y,z,mapid FROM telelist WHERE groupid = '%u' AND (faction = 0 || faction = '%u' ) ORDER BY rand() LIMIT 1",db_groupid,player->GetTeam());
					Field* randomtele = randomresult->Fetch();
					int32 db_x 				= randomtele[0].GetInt32(); 		
					int32 db_y 				= randomtele[1].GetInt32(); 		
					int32 db_z 				= randomtele[2].GetInt32();
					int32 db_mapid 			= randomtele[3].GetInt32();
					player->TeleportTo(db_mapid, db_x, db_y, db_z, 4.919000f);		
				
				}else{
					int32 db_x 				= pFields[4].GetInt32(); 		
					int32 db_y 				= pFields[5].GetInt32(); 		
					int32 db_z 				= pFields[6].GetInt32();
					int32 db_mapid 			= pFields[7].GetInt32();
					int32 db_levelreq			= pFields[8].GetInt32();
					if(player->getLevel() < db_levelreq)
					{
				_Creature->MonsterWhisper(level_error.str().c_str(), player->GetGUID());
					}else{
						//TELEPORT PLAYER
						player->TeleportTo(db_mapid, db_x, db_y, db_z, 4.919000f);			
					}
					player->CLOSE_GOSSIP_MENU();
				}
				
			}
	}
    struct televotescriptAI : public ScriptedAI
    {
        televotescriptAI(Creature *c) : ScriptedAI(c) {}
    };
	
    CreatureAI* GetAI(Creature* pCreature)
    {
        return new televotescriptAI (pCreature);
    }
};


void AddSC_televotescript()
{
    new televotescript();
}