class rewardscript : public CreatureScript
{
public:
    rewardscript() : CreatureScript("rewardscript") { }

	bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action)
	{
		// Main menu
			//Sender
			// 1 = Normal
			// 2 Choose Group Itemset
			// 3 Confirm
		DonationMenu(player, _Creature, action, sender);

		return true;
	}

bool OnGossipHello(Player *player, Creature *_Creature)
{
    //Go straight to the main menu
    player->ADD_GOSSIP_ITEM( 5, "Main"                    , 0, 6000);
    player->PlayerTalkClass->SendGossipMenu(6000,_Creature->GetGUID());
    return true;
}

	void t_error(uint32 message, Creature *_Creature, Player *player,uint32 id)
	{
	//1 item
	//2 itemset
	// 3 profession
		int32 playerid = player->GetGUID();
		int32 accountid = player->GetSession()->GetAccountId();	
			std::stringstream msg;
			switch(message)
			{
				case 1:
					msg<< "Item Failed";
				break;
				case 2:
					msg<< "Itemset Failed";
				break;
				case 3:
					msg<< "Profession Failed";
				break;
			}
		WorldDatabase.PExecute("INSERT INTO `store`.store_log (`message`,`account`,`character`,`date`,`type`,`item`) VALUES ('%s','%u','%u',NOW(),4,'%u')", msg.str().c_str(),accountid,playerid,id);
	
	}
	
	/******* NORMAL ITEM *******/
	void GiveItem(Creature* _Creature, Player* player, uint32 templateid)
	{
	_Creature->MonsterWhisper("Giving Items", player->GetGUID());
			QueryResult result = WorldDatabase.PQuery("SELECT itemID,count FROM `store`.store_item WHERE store_templateID = '%u'", templateid);
			if(result)
			{
				do
				{   
					Field *fields = result->Fetch();
					uint32 itemId = fields[0].GetUInt32();
					uint32 howmanytimes = fields[1].GetUInt32();
					player->AddItem(itemId, howmanytimes);
					_Creature->MonsterWhisper("Sent!", player->GetGUID());
				}
				while(result->NextRow());
			}else t_error(1,_Creature,player,templateid);
			
	}

	/******* ITEMSET *******/
	void GiveItemSet(Creature *_Creature, Player *player, uint32 templateid,uint32 type)
	{ // type 1 = chosen itemset
	  //      0 = Normal
	  QueryResult result;
			if(type)
				result = WorldDatabase.PQuery("SELECT itemID FROM `store`.store_itemset WHERE store_itemsetID = (SELECT itemset FROM `store`.store_cart_give WHERE store_cart_giveID = '%u')", templateid);
			else
				result = WorldDatabase.PQuery("SELECT itemID FROM `store`.store_itemset as s INNER JOIN `store`.store_itemset_link as l ON l.store_itemsetID=s.store_itemsetID WHERE store_templateID = '%u'", templateid);
			if(result)
			{
				do
				{   
					Field *fields = result->Fetch();
					uint32 itemId = fields[0].GetUInt32();
					player->AddItem(itemId, 1);
				}
				while(result->NextRow());
			}else t_error(2,_Creature,player,templateid);
			//delete result;

				
	}

	/******* OTHER *******/
	void GiveProfessionSkillOrLevel(Player *player, Creature *_Creature, int32 templateid)
	{
		//info
		QueryResult other_result = WorldDatabase.PQuery("SELECT data,extradata,min,max,flags,spellid FROM `store`.store_data as d INNER JOIN `store`.store_link as l ON d.store_dataID=l.store_dataID WHERE store_templateID = '%u';", templateid);
			if(other_result)
			{
				do{
				Field* other_fields = other_result->Fetch();
				//define
				int32 db_data = other_fields[0].GetInt32();
				int32 db_extradata = other_fields[1].GetInt32();
				int32 db_min = other_fields[2].GetInt32();
				int32 db_max = other_fields[3].GetInt32();
				int32 db_flags = other_fields[4].GetInt32();
				int32 db_spellid = other_fields[5].GetInt32();
				int32 skill_counter = 0;
				uint32 SetPlayerLevel = 0;
				
					switch(db_flags)
					{
						case 1:
							//level = 1
							SetPlayerLevel = db_data - player->getLevel();
							player->GiveLevel(player->getLevel() + SetPlayerLevel);
						break;
						case 2:
							if(!player->HasSpell(db_spellid) || !player->HasSkill(db_data))
							{
								player->learnSpell(db_spellid,false);
							}
							//skill = 2
							player->UpdateSkill(db_data, db_max);
						break;									
					}						
				}while(other_result->NextRow());	
			}else t_error(3,_Creature,player,templateid);
	}


	/******* RECORD DONATION *******/
	void record_donation(Creature* _Creature, Player* player, int32 id)
	{
		int32 playerid = player->GetGUID();
		int32 accountid = player->GetSession()->GetAccountId();
		// set reward to complete
		WorldDatabase.PExecute("UPDATE `store`.store_cart_give SET player = '%u', date = NOW(), status = 3 WHERE store_cart_giveID = '%u'", playerid, id);
		WorldDatabase.PExecute("INSERT INTO `store`.store_log (`message`,`account`,`character`,`date`,`type`,`item`) VALUES ('Successful','%u','%u',NOW(),3,'%u')", accountid,playerid,id);
		player->CLOSE_GOSSIP_MENU();
	}

	//******** EVERYTHING LOOKS GOOD********* //
	//*****SO WE GIVE THE DONATION REWARD ****//
	void giving_proccess(Creature *_Creature,Player *player, uint32 templateid, uint32 cartid)
	{
		QueryResult pResult = WorldDatabase.PQuery("SELECT type,givemoney FROM `store`.store_template WHERE store_templateID = '%u'", templateid);
		if(pResult)
		{
			Field* field = pResult->Fetch();
			uint32 flagbinary = field[0].GetInt32();
			if(flagbinary >= 16) // other = 8
			{
				GiveItemSet(_Creature, player, cartid,1);
				flagbinary -= 16;
			}		
			if(flagbinary >= 8) // other = 8
			{
				GiveProfessionSkillOrLevel(player, _Creature, templateid);
				flagbinary -= 8;
			}
			
			if(flagbinary >= 4)					//money
			{	
				_Creature->MonsterWhisper("Money", player->GetGUID());
				player->ModifyMoney(field[1].GetInt32());
				flagbinary -= 4;
			}
			
			if(flagbinary >= 2 || flagbinary >= 1 )					//itemset = 1 and items
			{	
				GiveItemSet(_Creature, player, templateid,0);
				//GiveItem(_Creature, player, templateid);  
				//flagbinary -= 2;
			}	

				//Normal Items is last because its the lowest number
			if(flagbinary >= 1)
			{ 
				GiveItem(_Creature, player, templateid);  
			}
		}
	}
	void itemsetgroup(Creature *_Creature,Player *player, uint32 templateid, uint32 cartid)
	{
		player->PlayerTalkClass->ClearMenus();
		QueryResult pResult = WorldDatabase.PQuery("SELECT name,store_itemsetID,class,faction FROM `store`.store_itemset_name WHERE `group` IN (SELECT store_itemset_groupID  FROM `store`.store_itemset_group_link WHERE store_templateID = '%u')", templateid);
		uint32 game_class;
		uint32 game_faction;
			// Make sure the result is valid
		if(pResult){
			do{
			// this should be done through the query
				Field* pFields = pResult->Fetch();
				if(pFields[3].GetInt32() == 1)
					game_class = 469; //alliance
				else if(pFields[3].GetInt32() == 2) 
					game_class = 67; //horde

				
				if(pFields[2].GetInt32() == player->getClass() && game_class == player->GetTeam() or pFields[3].GetInt32() == 0 && pFields[2].GetInt32() == player->getClass() or pFields[2].GetInt32() == 0  && pFields[3].GetInt32() == 0)
				{
					std::stringstream itemname;
					itemname << pFields[0].GetString();
					player->ADD_GOSSIP_ITEM(1, itemname.str().c_str() ,pFields[1].GetInt32(),cartid);
				}
			}while(pResult->NextRow());
		}else{
				_Creature->MonsterWhisper("Error", player->GetGUID());	
		}
		player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());
		return;
	}
	
	/******* MENU *******/
	void createmenu(uint32 accountid, Creature *_Creature, Player *player)
	{
		player->PlayerTalkClass->ClearMenus();
		player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Choose the reward you want:" , 0, 6000);
		QueryResult pResult = WorldDatabase.PQuery("SELECT title,store_cart_giveID,race,st.class,faction,givemoney,st.type,disable FROM `store`.store_cart_give as scg INNER JOIN `store`.store_cart as sc ON sc.store_cartID=scg.store_cartID INNER JOIN `store`.store_template as st ON st.store_templateID=sc.store_templateID WHERE scg.accountid = '%u' AND player  = 0", accountid);
	uint32 game_class;
	uint32 game_faction;
			// Make sure the result is valid
		if(pResult){
			do{
				Field* pFields = pResult->Fetch();
				if(pFields[4].GetInt32() == 1)
					game_class = 469;
				else if(pFields[4].GetInt32() == 2) 
					game_class = 67;

				
				if(pFields[3].GetInt32() == player->getClass() or pFields[3].GetInt32() == 0 && pFields[4].GetInt32() == 0 or game_class == player->GetTeam())
				{
				std::stringstream menuItempoints;
					menuItempoints << pFields[0].GetString() << "(" << pFields[1].GetInt32() << " ID)";
					player->ADD_GOSSIP_ITEM(1, menuItempoints.str().c_str() , 0, pFields[1].GetInt32());
				}
			}while(pResult->NextRow());
		}else{
				_Creature->MonsterWhisper("You haven't purchased anything", player->GetGUID());	
		}
		player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());
		return;
	}	
	int check(int32 db_template,Creature* _Creature, Player* player, int32 cartid)
	{
	int32 SlotsFree = 0;
			//template information
		QueryResult pResult = WorldDatabase.PQuery("SELECT race,class,faction,type,disable FROM `store`.store_template WHERE store_templateID = '%u';", db_template);
		if(pResult)
		{
			Field* pFields = pResult->Fetch();
			
			int32 temp_race			= pFields[0].GetInt32();
			int32 temp_class			= pFields[1].GetInt32();
			int32 temp_faction			= pFields[2].GetInt32();
			int32 flagbinary			= pFields[3].GetInt32();
			int32 temp_disable			= pFields[4].GetInt32();
			//checker
				if(temp_disable)
				{
					//message
					_Creature->MonsterWhisper("This item has been disabled for some reason.", player->GetGUID());
					return 0;
				}
			if(flagbinary >=16)
			{ // complete query
				QueryResult itemset_result = WorldDatabase.PQuery("SELECT count(*) FROM `store`.store_itemset WHERE store_itemsetID = (SELECT itemset FROM `store`.store_cart_give WHERE store_cart_giveID = '%u');", cartid);
				if(itemset_result)
				{
					Field* itemset_field = itemset_result->Fetch();
					SlotsFree = SlotsFree + itemset_field[0].GetInt32();
				}
				flagbinary -= 16;		
			}
			if(flagbinary >= 8) //other
			{
			uint32 skill_counter = 0;
			//info
			QueryResult other_result = WorldDatabase.PQuery("SELECT data,extradata,min,max,flags,spellid FROM `store`.store_data as d INNER JOIN `store`.store_link as l ON d.store_dataID=l.store_dataID WHERE store_templateID = '%u';", db_template);
				if(other_result){
					do{
					Field* other_fields = other_result->Fetch();
					//define
					int32 db_data = other_fields[0].GetInt32();
					int32 db_extradata = other_fields[1].GetInt32();
					int32 db_min = other_fields[2].GetInt32();
					int32 db_max = other_fields[3].GetInt32();
					int32 db_flags = other_fields[4].GetInt32();
					int32 db_spellid = other_fields[5].GetInt32();

					
						switch(db_flags)
						{
							case 1:
								//level = 1
								if(player->getLevel() > db_data || player->getLevel() > db_max) 
								{	
									_Creature->MonsterWhisper("Your Level is too high.", player->GetGUID());
									return 0;
								}
								if(player->getLevel() < db_min)
								{
									_Creature->MonsterWhisper("Your Level is too low.", player->GetGUID());
									return 0;		
								}
							break;
							case 2:
								//skill = 2
								if(player->HasSkill(db_data))
								{
									if (player->GetSkillValue(db_data) >= db_max)
									{
										_Creature->MonsterWhisper("Your skill level is already at its max.", player->GetGUID());
										return 0;
									}
									skill_counter--; //hack!!!!
								}
								else if(db_extradata)
									skill_counter++;
							break;									
							///////////////MORE TO COME
						}
								
								
					}while(other_result->NextRow());
					skill_counter -= player->GetFreePrimaryProfessionPoints();
					if(skill_counter < 2)
					{
						_Creature->MonsterWhisper("You have too many Professions", player->GetGUID());
						return 0;
					}
				}
				flagbinary -= 8;
			}
			if(flagbinary >= 4) //money
			{
			// no check is required
				flagbinary -= 4;
			}
			
			
			if(flagbinary >= 2)	 			//itemset
			{ 						//count number of slots
			_Creature->MonsterWhisper("Checking itemsets", player->GetGUID());
				QueryResult itemset_result = WorldDatabase.PQuery("SELECT count(*) FROM `store`.store_itemset WHERE store_itemsetID IN (SELECT store_itemsetID FROM `store`.store_itemset_link WHERE store_templateID = '%u');", db_template);
				if(itemset_result)
				{
					Field* itemset_field = itemset_result->Fetch();
					SlotsFree = SlotsFree + itemset_field[0].GetInt32();
				}
				flagbinary -= 2;
			}
			
			if(flagbinary >= 1)				//normale item
			{					//count number of slots
			_Creature->MonsterWhisper("Checking items", player->GetGUID());
			 QueryResult item_result = WorldDatabase.PQuery("SELECT count(*) FROM `store`.store_item WHERE store_templateID = '%u';", db_template);
				if(item_result)
				{
					Field* item_field = item_result->Fetch();
					SlotsFree = SlotsFree + item_field[0].GetInt32();
				}
				flagbinary -= 1;
			}
			
			//then add the bag slots with a flag
			if(SlotsFree)
			{
			_Creature->MonsterWhisper("Checking slots", player->GetGUID());
			std::stringstream slotmsg;
			std::stringstream slotmsg2;
			slotmsg<< "test" << SlotsFree << "slots";
			_Creature->MonsterWhisper(slotmsg.str().c_str(), player->GetGUID());
				int32 count = 1;
				uint32 noSpaceForCount = 0;
				ItemPosCountVec dest;
				uint8 msg = player->CanStoreNewItem( NULL_BAG, NULL_SLOT, dest, 23162, SlotsFree, &noSpaceForCount );

				if( msg != EQUIP_ERR_OK ) // convert to possible store amount
				{
					count -= noSpaceForCount;
					slotmsg2<< "Count=" << count << ",NoSpace=" << noSpaceForCount;
					_Creature->MonsterWhisper(slotmsg2.str().c_str(), player->GetGUID());
					 if(count <= 0 ) // can't add any
					{
						_Creature->MonsterWhisper("Make sure you have enough room in your bags", player->GetGUID());
						return 0;
					}
				
				}
			}
			
		}
		//since we made it this far we set it to 1
		return 1;
	}
	/****************************** MAIN ********************/
	/*********************************************************/
	void DonationMenu(Player *player, Creature *_Creature, uint32 action, uint32 sender)
	{
		int32 playerid = player->GetGUID();
		int32 accountid = player->GetSession()->GetAccountId();
		if(action == 6000)
		{
			createmenu(accountid,_Creature,player);
		
		}else{
			QueryResult pResult = WorldDatabase.PQuery("SELECT sc.store_cartID,player,date,store_templateID,scg.status,(SELECT type FROM `store`.store_template as temp WHERE temp.store_templateID=sc.store_templateID) FROM `store`.store_cart_give as scg INNER JOIN `store`.store_cart as sc ON scg.store_cartID=sc.store_cartID WHERE scg.accountid='%u' AND scg.store_cart_giveID = '%u';", accountid, action);
			// cart give
				// Status
				//	0 = Not chosen
				//  1 Chosen
				//  2 = confirm
				//  3 = Completed
			if(pResult)
			{
				//do{
				Field* pFields = pResult->Fetch();
				
				//ints
				int32 db_id 			= pFields[0].GetInt32();
				int32 db_player 			= pFields[1].GetInt32();
				int32 db_date 			= pFields[2].GetInt32();
				int32 db_template 			= pFields[3].GetInt32(); 
				int32 db_status 			= pFields[4].GetInt32(); 
				int32 db_type			= pFields[5].GetInt32(); 

				
				//strings
				std::string itemname;
				itemname = pFields[1].GetString();
				
				if(db_player || db_date || db_status == 3)
				{
					//message
					_Creature->MonsterWhisper("This reward is already been recieved!", player->GetGUID());
					player->CLOSE_GOSSIP_MENU();
					return;
				}
				if(db_status == 1) // if we are here with this value means they didn't confirm it
				{
					WorldDatabase.PExecute("UPDATE `store`.store_cart_give SET status = 0,itemset = 0 WHERE store_cart_giveID = '%u'", action); // reset
					db_status = 0;
				}
				//normal reward go striaght to confirm status
				if(db_type < 16)
				{	
					db_status = 2;
				}
				
				// Let the user select itemset they want
				if(db_type >= 16 && db_status == 0 && !sender)
					itemsetgroup(_Creature, player,db_template,action);
				else 				
				{
					//if group itemset update cart
					if(db_type >= 16 && sender && db_status < 2)
					{
						int32 playerid = player->GetGUID();
						WorldDatabase.PExecute("UPDATE `store`.store_cart_give SET status = 2, itemset = '%u' WHERE store_cart_giveID = '%u'", sender,action); 
						db_status = 2;
						sender = 0;
					}
					//confirm choice
					if(db_status == 2 && sender == 0)
					{
						//menu
						player->PlayerTalkClass->ClearMenus();
						player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Are you sure?" , 0, 6000);
						player->ADD_GOSSIP_ITEM(1, "Yes" , 1, action);
						player->ADD_GOSSIP_ITEM(1, "No" , 0, 6000);
						player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE,_Creature->GetGUID());
					}else{
						if(check(db_template,_Creature, player,action))
						{
							giving_proccess(_Creature, player,db_template,action);
							record_donation(_Creature, player, action);
						}else{
							_Creature->MonsterWhisper("Failed!", player->GetGUID());
							player->CLOSE_GOSSIP_MENU();
						}
					}
				}
			}else{
			
				_Creature->MonsterWhisper("Nothing here", player->GetGUID());
				player->CLOSE_GOSSIP_MENU();
			}
		
		}
		
	}
    struct rewardscriptAI : public ScriptedAI
    {
        rewardscriptAI(Creature *c) : ScriptedAI(c) {}
    };
    CreatureAI* GetAI(Creature* pCreature)
    {
        return new rewardscriptAI (pCreature);
    }
};

void AddSC_rewardscript()
{
    new rewardscript();
}