#include "ScriptPCH.h"

/* Battlemaster */

class npc_quelbattle : public CreatureScript
{
public:
    npc_quelbattle() : CreatureScript("npc_quelbattle") { }

    bool OnGossipHello(Player *player, Creature *_creature)
    {
        if (player->isInCombat())
        {
            player->CLOSE_GOSSIP_MENU();
            _creature->MonsterWhisper("You are in combat!", player->GetGUID());
            return true;
        }
        else
        {
            player->ADD_GOSSIP_ITEM( 9, "Join the battle for Quel'thalas Keep!"                   , GOSSIP_SENDER_MAIN, 1);
        }

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());         
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction)
    {
        if (sender == GOSSIP_SENDER_MAIN)
        {
            player->PlayerTalkClass->ClearMenus();
            switch(uiAction)
            {
            case 1: //Join to Quel'thalas Keep battle!
                if ( player->GetTeam() == ALLIANCE)
		    {
	           		if (sWorld->GetPlayersAllianceInZone(2037) < 20)
		    		{
                       		player->TeleportTo(0, 3415.042969f, -2114.816895f, 131.407578f, 0.907265f);
					player->AddItem(999951, 1);
					ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_WELCOME);
					sLog->outString("QuelThalas Keep: New Player has joined the battle!");

     					char MSG[200];
              			sprintf(MSG, "Player '|cff0000f1 %s |r' has joined the battle!", player->GetName());
              			sWorld->SendZoneText(2037, MSG);
                  	}
	           		else 
		    		{
                       		ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_FULL);
                  	}
	           		return true;
		    }
		    else if ( player->GetTeam() == HORDE)
		    {
	           		if (sWorld->GetPlayersHordeInZone(2037) < 20)
		    		{
                       		player->TeleportTo(0, 3514.493896f, -1979.416016f, 131.407623f, 4.097552f);
					player->AddItem(999951, 1);
					ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_WELCOME);
					sLog->outString("QuelThalas Keep: New Player has joined the battle!");

     					char MSG[200];
              			sprintf(MSG, "Player '|cffde0909 %s |r' has joined the battle!", player->GetName());
              			sWorld->SendZoneText(2037, MSG);
                  	}
	           		else 
		    		{
                       		ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_FULL);
                  	}
	           		return true;
		    }
		    return true;
            break;

            }
        } 
        return true;
    } 
};

/* Battlemaster */

class npc_quelvehicle : public CreatureScript
{
public:
    npc_quelvehicle() : CreatureScript("npc_quelvehicle") { }

    bool OnGossipHello(Player *player, Creature *_creature)
    {
        if (player->isInCombat())
        {
            player->CLOSE_GOSSIP_MENU();
            _creature->MonsterWhisper("You are in combat!", player->GetGUID());
            return true;
        }
        else
        {
	          player->ADD_GOSSIP_ITEM( 7, "Build Vehicles"                   , GOSSIP_SENDER_MAIN, 1);

	 }

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());         
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction)
    {
        if (sender == GOSSIP_SENDER_MAIN)
        {
            player->PlayerTalkClass->ClearMenus();
            switch(uiAction)
            {
            case 1: //Build Vehicles
            	if (player->HasItemCount( 999950, 15, false ))
	     	{
				player->ADD_GOSSIP_ITEM( 7, "Build Walking Tank [15KP]"                   , GOSSIP_SENDER_MAIN, 2);
		}
            	if (player->HasItemCount( 999950, 25, false ))
	     	{
				player->ADD_GOSSIP_ITEM( 7, "Build Keep Shredder [25KP]"                   , GOSSIP_SENDER_MAIN, 3);
		}

			player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
	     break;

            case 2: //Build Walking Tank  [15KP]
			if (player->GetTeam() == ALLIANCE)
			{
				_creature->SummonCreature(999958, 0, 0, 0, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 70000);
				player->DestroyItemCount(999950, 15, true, false);
				player->CLOSE_GOSSIP_MENU();
			}
			else if (player->GetTeam() == HORDE)
			{
				_creature->SummonCreature(999955, 0, 0, 0, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 70000);
				player->DestroyItemCount(999950, 15, true, false);
				player->CLOSE_GOSSIP_MENU();
			}
			return true;
	      break;

            case 3: //Build Keep Shredder [25KP]
			if (player->GetTeam() == ALLIANCE)
			{
				_creature->SummonCreature(999957, 0, 0, 0, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 70000);
				player->DestroyItemCount(999950, 25, true, false);
				player->CLOSE_GOSSIP_MENU();
			}
			else if (player->GetTeam() == HORDE)
			{
				_creature->SummonCreature(999954, 0, 0, 0, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 70000);
				player->DestroyItemCount(999950, 25, true, false);
				player->CLOSE_GOSSIP_MENU();
			}
			return true;
		break;

            case 5: //You can not build any vehicle!
				player->CLOSE_GOSSIP_MENU();
		break;

            }
        } 
        return true;
    } 
};

/* Rewards Vendor */

class npc_quelreward : public CreatureScript
{
public:
    npc_quelreward() : CreatureScript("npc_quelreward") { }

    bool OnGossipHello(Player *player, Creature *_creature)
    {
        if (player->isInCombat())
        {
            player->CLOSE_GOSSIP_MENU();
            _creature->MonsterWhisper("You are in combat!", player->GetGUID());
            return true;
        }
        else
        {
            player->ADD_GOSSIP_ITEM( 6, "Buy Honor Points"                   , GOSSIP_SENDER_MAIN, 1);
            player->ADD_GOSSIP_ITEM( 6, "Buy Arena Points"                   , GOSSIP_SENDER_MAIN, 2);
            player->ADD_GOSSIP_ITEM( 6, "Buy Emblem of Frost"                , GOSSIP_SENDER_MAIN, 3);
            player->ADD_GOSSIP_ITEM( 6, "Buy Emblem of Triumph"              , GOSSIP_SENDER_MAIN, 4);
            player->ADD_GOSSIP_ITEM( 0, "Price List"              	       , GOSSIP_SENDER_MAIN, 5);
        }

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());         
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction)
    {
        if (sender == GOSSIP_SENDER_MAIN)
        {
            player->PlayerTalkClass->ClearMenus();
            switch(uiAction)
            {
            case 1: //Buy Honor Points
			if (player->HasItemCount( 999950, 5, false ))
			{
				player->ModifyHonorPoints(+250);
				player->DestroyItemCount(999950, 5, true, false);
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_HONOR_POINTS);
				player->CLOSE_GOSSIP_MENU();
			}
			else 
			{
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_NO_REQUIRED_POINTS);
				player->CLOSE_GOSSIP_MENU();
			}
			return true;
            break;

            case 2: //Buy Arena Points
			if (player->HasItemCount( 999950, 5, false ))
			{
				player->ModifyArenaPoints(+5);
				player->DestroyItemCount(999950, 5, true, false);
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_ARENA_POINTS);
				player->CLOSE_GOSSIP_MENU();
			}
			else 
			{
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_NO_REQUIRED_POINTS);
				player->CLOSE_GOSSIP_MENU();
			}
			return true;
            break;

            case 3: //Buy Emblem of Frost
			if (player->HasItemCount( 999950, 5, false ))
			{
				player->DestroyItemCount(999950, 5, true, false);
				player->AddItem(49426, 1);
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_EMBLEM_FROST);
				player->CLOSE_GOSSIP_MENU();
			}
			else 
			{
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_NO_REQUIRED_POINTS);
				player->CLOSE_GOSSIP_MENU();
			}
			return true;
            break;

            case 4: //Buy Emblem of Triumph
			if (player->HasItemCount( 999950, 5, false ))
			{
				player->DestroyItemCount(999950, 5, true, false);
				player->AddItem(47241, 1);
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_EMBLEM_TRIUMPH);
				player->CLOSE_GOSSIP_MENU();
			}
			else 
			{
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_NO_REQUIRED_POINTS);
				player->CLOSE_GOSSIP_MENU();
			}
			return true;
            break;

            case 5: //Price List
				ChatHandler(player).SendSysMessage(LANG_QUELTHALAS_PRICE_LIST);
				player->CLOSE_GOSSIP_MENU();
            break;

            }
        } 
        return true;
    } 
};

void AddSC_npc_quelthalas()
{
    new npc_quelbattle();
    new npc_quelvehicle();
    new npc_quelreward();
}