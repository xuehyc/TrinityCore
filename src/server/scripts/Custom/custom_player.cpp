/*
* Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2014 Steel Gamers Community <http://www.steelgamers.es>
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
#include "Channel.h"
#include "Guild.h"
#include "Group.h"
#include "Language.h"
#include "NullSecMgr.h"
#include "LootMgr.h"

#define MAPID_EASTERN_KINGDOMS 0
#define MAPID_KALIMDOR 1

#define PLAYER_REMAINS_ENTRY 177806
#define PLAYER_REMAINS_LOOT_ENTRY 200000

enum TeleportGraveyards
{
    GRAVEYARD_FERALAS            = 0,
    GRAVEYARD_THOUSAND_NEEDLES   = 1,
    GRAVEYARD_REDRIDGE_MOUNTAINS = 2,
    GRAVEYARD_DUSKWOOD           = 3,
    GRAVEYARD_WESTFALL           = 4
};

Position const GraveyardsPositions[5] =
{
        { -1967.22f, 1723.91f, 61.67f, 5.7387f },
        { -2515.37f, -1964.68f, 91.79f, 4.48131f },
        { -9339.96f, 172.11f, 61.57f, 3.56999f },
        { -9339.96f, 172.11f, 61.57f, 3.56999f },
        { -9339.96f, 172.11f, 61.57f, 3.56999f }
};

class CustomPlayerScript : public PlayerScript
{
public:
    CustomPlayerScript() : PlayerScript("CustomPlayerScript") { }

    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea, bool areaOnly) override
    {
        // This zones are the new frontiers, so don't let the players cross them.
        switch (newZone)
        {
            // The following zones are the new frontiers, so don't let the players enter them.
            // TODO: More costal regions should be checked. May be change check type for Eastern Kingdoms. Block transports.
            case RESTRICTED_ZONE_FERALAS:
                player->TeleportTo(MAPID_KALIMDOR, GraveyardsPositions[GRAVEYARD_FERALAS].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_FERALAS].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_FERALAS].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_FERALAS].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_THOUSAND_NEEDLES:
                player->TeleportTo(MAPID_KALIMDOR, GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_REDRIDGE_MOUNTAINS:
                player->TeleportTo(MAPID_EASTERN_KINGDOMS, GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_DUSKWOOD:
                player->TeleportTo(MAPID_EASTERN_KINGDOMS, GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_WESTFALL:
                player->TeleportTo(MAPID_EASTERN_KINGDOMS, GraveyardsPositions[GRAVEYARD_WESTFALL].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_WESTFALL].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_WESTFALL].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_WESTFALL].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            // The following zones are High Sec areas. We must force the player exit FFA PvP state, if his faction is the owner of the zone.
            case HIGHSEC_ZONE_MULGORE:
            case HIGHSEC_ZONE_DUROTAR:
            case HIGHSEC_ZONE_ORGRIMMAR:
            case HIGHSEC_ZONE_THUNDERBLUFF:
                if (player->GetTeam() == HORDE)
                {
                    player->pvpInfo.IsInHighSecZone = true;
                    if (!areaOnly)
                        ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_GENERAL_ENTER);
                }
                // If he is a member of the opposite faction, it's like he is in a Null Sec area
                else if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_HORDE_ENTER);
                player->InGuildZone(false);
                player->SetGuildZoneId(GUILD_ZONE_NONE);
                break;
            case HIGHSEC_ZONE_TELDRASSIL:
            case HIGHSEC_ZONE_ELWYNN_FOREST:
            case HIGHSEC_ZONE_STORMWIND:
            case HIGHSEC_ZONE_DARNASSUS:
                if (player->GetTeam() == ALLIANCE)
                {
                    player->pvpInfo.IsInHighSecZone = true;
                    if (!areaOnly)
                        ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_GENERAL_ENTER);
                }
                else if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_ALLIANCE_ENTER);
                player->InGuildZone(false);
                player->SetGuildZoneId(GUILD_ZONE_NONE);
                break;
            // These are the Low Sec Areas, FFA PvP is allowed here.
            case LOWSEC_ZONE_DARKSHORE:
            case LOWSEC_ZONE_ASHENVALE:
            case LOWSEC_ZONE_AZSHARA:
            case LOWSEC_ZONE_THE_BARRENS:
                player->pvpInfo.IsInHighSecZone = false;
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_LOWSEC_GENERAL_ENTER);
                player->InGuildZone(false);
                player->SetGuildZoneId(GUILD_ZONE_NONE);
                break;
            // And these are the Null Sec zones, FFA PvP is encouraged here.
            case NULLSEC_ZONE_WINTERSPRING:
            case NULLSEC_ZONE_FELWOOD:
            case NULLSEC_ZONE_STONETALON_MOUNTAINS:
            case NULLSEC_ZONE_DESOLACE:
            case NULLSEC_ZONE_DUSTWALLOW_MARSH:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                // If zone = area (for example, must roads) the area is not in a guild zone.
                // Other exceptions like seas are handled in OnPlayerEnterNullSecGuildZone().
                if (newZone == newArea && player->GetGuildZoneId() != GUILD_ZONE_NONE)
                    sNullSecMgr->OnPlayerLeaveNullSecGuildZone(player);
                else
                    sNullSecMgr->OnPlayerEnterNullSecGuildZone(player);
                player->pvpInfo.IsInHighSecZone = false;
                break;
            default:
                break;
        }
    }

    void OnPVPKill(Player* killer, Player* killed) override
    {
        SpawnPlayerLoot(killed, killer);
    }

    void SpawnPlayerLoot(Player* player, Player* lootOwner)
    {
        // player should loot his/her items only if he is in null sec.
        ZoneSecurityLevels zoneSec = player->GetZoneSecurityLevel();
        if (zoneSec == ZONE_SECURITY_LEVEL_HIGH || zoneSec == ZONE_SECURITY_LEVEL_UNK)
            return;

        // Get next free dynamic lootId
        uint32 freeLootId = LootTemplates_Gameobject.GetFreeDynamicLootId();
        if (!freeLootId) // There's too many dynamic loot entries in use
            return;

        std::vector<LootStoreItem> storeItems;

        // Fill the gameobject's loot with the player's items, and destroy them.
        // The bags itselfs are not dropped.
        for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
        {
            if (Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                uint32 count = pItem->GetCount();
                LootStoreItem lootItem(pItem->GetEntry(), 100.0f, 1, 0, count, count);
                storeItems.push_back(lootItem);
                player->DestroyItemCount(pItem, count, true);
            }
        }

        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            if (Bag* pBag = player->GetBagByPos(i))
            {
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                {
                    if (Item* pItem = player->GetItemByPos(i, j))
                    {
                        uint32 count = pItem->GetCount();
                        LootStoreItem lootItem(pItem->GetEntry(), 100.0f, 1, 0, count, count);
                        storeItems.push_back(lootItem);
                        player->DestroyItemCount(pItem, count, true);
                    }
                }
            }
        }
        // If player is in Null Sec, drop also his/her equipped items, but with a chance.
        if (zoneSec == ZONE_SECURITY_LEVEL_NULL)
        {
            for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
            {
                if (Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                {
                    uint32 count = 1;
                    LootStoreItem lootItem(pItem->GetEntry(), 20.0f, 1, 0, count, count);
                    storeItems.push_back(lootItem);
                    player->DestroyItemCount(pItem, count, true);
                }
            }
        }
        // Add items to the loot store
        LootTemplates_Gameobject.LoadDynamicLootTemplate(storeItems, freeLootId);

        // Spawn the lootable player remains
        float x = float(player->GetPositionX());
        float y = float(player->GetPositionY());
        float z = float(player->GetPositionZ());
        float o = float(player->GetOrientation());
        Map* map = player->GetMap();

        GameObject* object = new GameObject;
        uint32 guidLow = sObjectMgr->GenerateLowGuid(HIGHGUID_GAMEOBJECT);

        if (!object->Create(guidLow, PLAYER_REMAINS_ENTRY, map, player->GetPhaseMaskForSpawn(), x, y, z, o, 0.0f, 0.0f, 0.0f, 0.0f, 0, GO_STATE_READY))
        {
            delete object;
            return;
        }

        map->AddToMap(object);
        object->SetDynamicLootId(freeLootId);

        // Give the killer his money
        uint32 money = player->GetMoney();
        if (money > 0)
        {
            player->ModifyMoney(money * -1, false);
            uint32 golds = uint32(money / 10000);
            uint32 silvers = uint32((money - (golds * 10000)) / 100);
            uint32 coppers = uint32(money - (golds * 10000) - (silvers * 100));
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_PVP_MONEY_LOST, lootOwner->GetName().c_str(), golds, silvers, coppers);
            lootOwner->ModifyMoney(money);
            ChatHandler(lootOwner->GetSession()).PSendSysMessage(LANG_PVP_MONEY_WON, golds, silvers, coppers, player->GetName().c_str());
        }
    }
};

void AddSC_custom_player()
{
    new CustomPlayerScript();
}
