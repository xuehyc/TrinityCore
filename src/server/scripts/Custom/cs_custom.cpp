/*
* Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2014 Steel Gamers Community <http://steelgamers.es/>
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

/* ScriptData
Name: custom_commandscript
%Complete: 100
Comment: Custom Steel Gamers Commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "Language.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "NullSecMgr.h"
#include "ObjectMgr.h"

class custom_commandscript : public CommandScript
{
public:
    custom_commandscript() : CommandScript("custom_commandscript") { }

	std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> commandTable =
        {
            { "claim", rbac::RBAC_PERM_COMMAND_SERVER_MOTD, true, &HandleClaimCommand, "" }
        };
        return commandTable;
    }

    static bool HandleClaimCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        // Check if the player has the needed item
        if (!player->HasItemCount(ITEM_STANDARD_OF_CONQUEST))
        {
            handler->SendSysMessage(LANG_CLAIM_MISSED_ITEM);
            return true;
        }
        
        // Check if player is in a guild
        if (!player->GetGuild())
        {
            handler->SendSysMessage(LANG_CLAIM_MISSED_GUILD);
            return true;
        }

        // Check if he is in a Null Sec conquerable zone
        if (!player->GetGuildZoneId())
        {
            handler->SendSysMessage(LANG_CLAIM_NO_NULLSEC);
            return true;
        }

        // Check if the player is in the correct area to start claiming
        uint32 guildZoneId = sNullSecMgr->GetNullSecGuildZoneId(player->GetZoneId());

        if (!sNullSecMgr->IsNullSecVitalArea(guildZoneId, player->GetAreaId()))
        {
            handler->PSendSysMessage(LANG_CLAIM_WRONG_AREA/*, atEntry->area_name[handler->GetSessionDbcLocale()]*/);
            return true;
        }

        AreaTableEntry const* atEntry = sAreaTableStore.LookupEntry(player->GetAreaId());
        uint8 vitalAreaStatus = sNullSecMgr->GetNullSecVitalAreaStatus(guildZoneId, atEntry->ID);
        // Check if the zone is not conquered by other guild
        if (vitalAreaStatus == VITAL_AREA_STATUS_CONQUERED)
        {
            handler->PSendSysMessage(LANG_CLAIM_HAS_OWNER);
            return true;
        }

        // Check if area is not under attack
        if (vitalAreaStatus == VITAL_AREA_STATUS_UNDER_ATTACK)
        {
            handler->PSendSysMessage(LANG_CLAIM_UNDER_ATTACK);
            return true;
        }

        

        // Spawn the NPC
        Map* map = player->GetMap();
        Position pos = sNullSecMgr->GetStandardPositionByVitalArea(guildZoneId, atEntry->ID);

        if (pos == NULL)
            return false;

        Creature* creature = new Creature();

        if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, player->GetPhaseMaskForSpawn(), NPC_STANDARD_OF_CONQUEST, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation()))
        {
            delete creature;
            return false;
        }

        creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());

		ObjectGuid::LowType db_guid = creature->GetSpawnId();

        // To call _LoadGoods(); _LoadQuests(); CreateTrainerSpells()
        // current "creature" variable is deleted and created fresh new, otherwise old values might trigger asserts or cause undefined behavior
        creature->CleanupsBeforeDelete();
        delete creature;

        // Set the Null Sec Vital Area under attack _before_ adding the NPC to the world
        sNullSecMgr->SetNullSecVitalAreaStatus(guildZoneId, atEntry->ID, VITAL_AREA_STATUS_UNDER_ATTACK);
        sNullSecMgr->SetNullSecVitalAreaAttacker(guildZoneId, atEntry->ID, player->GetGuild());

        creature = new Creature();
        if (!creature->LoadCreatureFromDB(db_guid, map))
        {
            delete creature;
            // Reset territory status
            sNullSecMgr->SetNullSecVitalAreaStatus(guildZoneId, atEntry->ID, VITAL_AREA_STATUS_UNCONQUERED);
            sNullSecMgr->SetNullSecVitalAreaAttacker(guildZoneId, atEntry->ID, NULL);
            return false;
        }

        sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));

        // Delete the item from the player's inventory
        player->DestroyItemCount(ITEM_STANDARD_OF_CONQUEST, 1, true);
        handler->PSendSysMessage(LANG_CLAIM_ATTACK_STARTED, sNullSecMgr->GetNullSecName(guildZoneId).c_str());

        return true;
    }
};

void AddSC_custom_commandscript()
{
    new custom_commandscript();
}
