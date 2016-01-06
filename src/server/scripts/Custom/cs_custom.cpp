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
            { "reclamar", rbac::RBAC_PERM_COMMAND_SERVER_MOTD, true, &HandleReclamarCommand, "" }
        };
        return commandTable;
    }

    static bool HandleReclamarCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        // Check if the player has the needed item
        if (!player->HasItemCount(ITEM_STANDARD_OF_CONQUEST))
        {
            handler->SendSysMessage(LANG_RECLAMAR_MISSED_ITEM);
            return true;
        }
        
        // Check if player is in a guild
        if (!player->GetGuild())
        {
            handler->SendSysMessage(LANG_RECLAMAR_MISSED_GUILD);
            return true;
        }

        // Check if he is in a Null Sec conquerable zone
        if (!player->GetGuildZoneId())
        {
            handler->SendSysMessage(LANG_RECLAMAR_NO_NULLSEC);
            return true;
        }

        // Check if the player is in the correct area to start claiming
        uint32 guildZoneId = sNullSecMgr->GetNullSecGuildZone(player->GetZoneId(), player->GetAreaId());
        const AreaTableEntry* atEntry = GetAreaEntryByAreaID(sNullSecMgr->GetVitalAreaByGuildZoneId(guildZoneId));

        if (player->GetAreaId() != atEntry->ID)
        {
            handler->PSendSysMessage(LANG_RECLAMAR_WRONG_AREA, atEntry->area_name[handler->GetSessionDbcLocale()]);
            return true;
        }

        // Check if the zone is not conquered by other guild
        if (sNullSecMgr->GetNullSecZoneOwner(guildZoneId) != NULL)
        {
            handler->PSendSysMessage(LANG_RECLAMAR_HAS_OWNER, atEntry->area_name[handler->GetSessionDbcLocale()]);
            return true;
        }

        // Check if zone is not under attack
        if (sNullSecMgr->IsGuildZoneUnderAttack(guildZoneId))
        {
            handler->PSendSysMessage(LANG_RECLAMAR_UNDER_ATTACK);
            return true;
        }

        // Set the Null Sec Guild Zone under attack
        sNullSecMgr->SetGuildZoneUnderAttack(guildZoneId, true, player->GetGuild());

        // Spawn the NPC
        Map* map = player->GetMap();
        Position pos = sNullSecMgr->GetStandardPositionByGuildZoneId(guildZoneId);
        Creature* creature = new Creature();
        if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, player->GetPhaseMaskForSpawn(), NPC_STANDARD_OF_CONQUEST, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation()))
        {
            delete creature;
            sNullSecMgr->SetGuildZoneUnderAttack(guildZoneId, false);
            return false;
        }

        creature->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), player->GetPhaseMaskForSpawn());

		ObjectGuid::LowType db_guid = creature->GetSpawnId();

        // To call _LoadGoods(); _LoadQuests(); CreateTrainerSpells()
        // current "creature" variable is deleted and created fresh new, otherwise old values might trigger asserts or cause undefined behavior
        creature->CleanupsBeforeDelete();
        delete creature;
        creature = new Creature();
        if (!creature->LoadCreatureFromDB(db_guid, map))
        {
            delete creature;
            sNullSecMgr->SetGuildZoneUnderAttack(guildZoneId, false);
            return false;
        }

        sObjectMgr->AddCreatureToGrid(db_guid, sObjectMgr->GetCreatureData(db_guid));

        // Delete the item from the player's inventory
        player->DestroyItemCount(ITEM_STANDARD_OF_CONQUEST, 1, true);
        handler->PSendSysMessage(LANG_RECLAMAR_ATTACK_STARTED, sNullSecMgr->GetGuildZoneName(guildZoneId).c_str());
        return true;
    }
};

void AddSC_custom_commandscript()
{
    new custom_commandscript();
}
