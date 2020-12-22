/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
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

#include "WorldSession.h"
#include "AccountMgr.h"
#include "AuctionHouseMgr.h"
#include "CharacterCache.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DBCStructure.h"
#include "GameTime.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "Mail.h"
#include "Mail.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "UpdateMask.h"
#include "Util.h"
#include "GameConfig.h"
#include "WorldPacket.h"

//void called when player click on auctioneer npc
void WorldSession::HandleAuctionHelloOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;                                            //NPC guid
    recvData >> guid;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionHelloOpcode - Unit (%s) not found or you can't interact with him.", guid.ToString().c_str());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    SendAuctionHello(guid, unit);
}

//this void causes that auction window is opened
void WorldSession::SendAuctionHello(ObjectGuid guid, Creature* unit)
{
    if (GetPlayer()->GetLevel() < CONF_GET_INT("LevelReq.Auction"))
    {
        SendNotification(GetWarheadString(LANG_AUCTION_REQ), CONF_GET_INT("LevelReq.Auction"));
        return;
    }

    AuctionHouseEntry const* ahEntry = AuctionHouseMgr::GetAuctionHouseEntry(unit->GetFaction());
    if (!ahEntry)
        return;

    WorldPacket data(MSG_AUCTION_HELLO, 12);
    data << uint64(guid);
    data << uint32(ahEntry->ID);
    data << uint8(1);                                       // 3.3.3: 1 - AH enabled, 0 - AH disabled
    SendPacket(&data);
}

//call this method when player bids, creates, or deletes auction
void WorldSession::SendAuctionCommandResult(uint32 auctionItemId, AuctionAction command, AuctionError errorCode, InventoryResult bagResult)
{
    WorldPacket data(SMSG_AUCTION_COMMAND_RESULT, 16);
    data << int32(auctionItemId);
    data << int32(command);
    data << int32(errorCode);
    if (errorCode == ERR_AUCTION_INVENTORY)
        data << int32(bagResult);
    SendPacket(&data);
}

//this function sends notification, if bidder is online
void WorldSession::SendAuctionBidderNotification(uint32 location, uint32 auctionId, ObjectGuid bidder, uint32 bidSum, uint32 diff, uint32 itemEntry)
{
    WorldPacket data(SMSG_AUCTION_BIDDER_NOTIFICATION, (8*4));
    data << uint32(location);
    data << uint32(auctionId);
    data << uint64(bidder);
    data << uint32(bidSum);
    data << uint32(diff);
    data << uint32(itemEntry);
    data << uint32(0);
    SendPacket(&data);
}

//this void causes on client to display: "Your auction sold"
void WorldSession::SendAuctionOwnerNotification(AuctionEntry* auction)
{
    WorldPacket data(SMSG_AUCTION_OWNER_NOTIFICATION, (8*4));
    data << uint32(auction->Id);
    data << uint32(auction->bid);
    data << uint32(0);                                      //unk
    data << uint64(0);                                      //unk (bidder guid?)
    data << uint32(auction->itemEntry);
    data << uint32(0);                                      //unk
    data << float(0);                                       //unk (time?)
    SendPacket(&data);
}

//this void creates new auction and adds auction to some auctionhouse
void WorldSession::HandleAuctionSellItem(WorldPacket& recvData)
{
    if (GetPlayer() && (sMailMgr->GetMailBoxSize(GetPlayer()->GetGUID().GetCounter()) + GetPlayer()->GetAuctionLotsCount()) > CONF_GET_UINT("Antispam.Mail.Controller"))
    {
        GetPlayer()->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_CAP_REACHED);
        recvData.rfinish();
        return;
    }

    ObjectGuid auctioneer;
    uint32 itemsCount, etime, bid, buyout;
    recvData >> auctioneer;
    recvData >> itemsCount;

    ObjectGuid itemGUIDs[MAX_AUCTION_ITEMS]; // 160 slot = 4x 36 slot bag + backpack 16 slot
    uint32 count[MAX_AUCTION_ITEMS];
    memset(count, 0, sizeof(count));

    if (itemsCount > MAX_AUCTION_ITEMS)
    {
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        recvData.rfinish();
        return;
    }

    for (uint32 i = 0; i < itemsCount; ++i)
    {
        recvData >> itemGUIDs[i];
        recvData >> count[i];

        if (!itemGUIDs[i] || !count[i] || count[i] > 1000)
        {
            recvData.rfinish();
            return;
        }
    }

    recvData >> bid;
    recvData >> buyout;
    recvData >> etime;

    if (!bid || !etime)
        return;

    if (bid > MAX_MONEY_AMOUNT || buyout > MAX_MONEY_AMOUNT)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Player %s %s attempted to sell item with higher price than max gold amount.", _player->GetName().c_str(), _player->GetGUID().ToString().c_str());
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Unit (%s) not found or you can't interact with him.", auctioneer.ToString().c_str());
        return;
    }

    AuctionHouseEntry const* auctionHouseEntry = AuctionHouseMgr::GetAuctionHouseEntry(creature->GetFaction());
    if (!auctionHouseEntry)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionSellItem - Unit (%s) has wrong faction.", auctioneer.ToString().c_str());
        return;
    }

    etime *= MINUTE;

    switch (etime)
    {
        case 1*MIN_AUCTION_TIME:
        case 2*MIN_AUCTION_TIME:
        case 4*MIN_AUCTION_TIME:
            break;
        default:
            return;
    }

    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    Item* items[MAX_AUCTION_ITEMS];

    uint32 finalCount = 0;
    uint32 itemEntry = 0;

    for (uint32 i = 0; i < itemsCount; ++i)
    {
        Item* item = _player->GetItemByGuid(itemGUIDs[i]);

        if (!item)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_ITEM_NOT_FOUND);
            return;
        }

        if (itemEntry == 0)
            itemEntry = item->GetTemplate()->ItemId;

        if (sAuctionMgr->GetAItem(item->GetGUID().GetCounter()) || !item->CanBeTraded() || item->IsNotEmptyBag() ||
            item->GetTemplate()->HasFlag(ITEM_FLAG_CONJURED) || item->GetUInt32Value(ITEM_FIELD_DURATION) ||
            item->GetCount() < count[i] || itemEntry != item->GetTemplate()->ItemId)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            return;
        }

        items[i] = item;
        finalCount += count[i];
    }

    if (!finalCount)
    {
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
        return;
    }

    // check if there are 2 identical guids, in this case user is most likely cheating
    for (uint32 i = 0; i < itemsCount - 1; ++i)
    {
        for (uint32 j = i + 1; j < itemsCount; ++j)
        {
            if (itemGUIDs[i] == itemGUIDs[j])
            {
                SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
                return;
            }
        }
    }

    for (uint32 i = 0; i < itemsCount; ++i)
    {
        Item* item = items[i];

        if (item->GetMaxStackCount() < finalCount)
        {
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            return;
        }
    }

    Item* item = items[0];

    uint32 auctionTime = uint32(etime * CONF_GET_FLOAT("Rate.Auction.Time"));
    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    uint32 deposit = sAuctionMgr->GetAuctionDeposit(auctionHouseEntry, etime, item, finalCount);
    if (!_player->HasEnoughMoney(deposit))
    {
        SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_NOT_ENOUGHT_MONEY);
        return;
    }

    AuctionEntry* AH = new AuctionEntry();

    if (CONF_GET_BOOL("AllowTwoSide.Interaction.Auction"))
        AH->houseId = AUCTIONHOUSE_NEUTRAL;
    else
    {
        CreatureData const* auctioneerData = sObjectMgr->GetCreatureData(creature->GetSpawnId());
        if (!auctioneerData)
        {
            LOG_ERROR("misc", "Data for auctioneer not found (%s)", auctioneer.ToString().c_str());
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            delete AH;
            return;
        }

        CreatureTemplate const* auctioneerInfo = sObjectMgr->GetCreatureTemplate(auctioneerData->id);
        if (!auctioneerInfo)
        {
            LOG_ERROR("misc", "Non existing auctioneer (%s)", auctioneer.ToString().c_str());
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            delete AH;
            return;
        }

        AuctionHouseEntry const* AHEntry = sAuctionMgr->GetAuctionHouseEntry(auctioneerInfo->faction);
        AH->houseId = AHEntry->ID;
    }

    // Required stack size of auction matches to current item stack size, just move item to auctionhouse
    if (itemsCount == 1 && item->GetCount() == count[0])
    {
        if (HasPermission(rbac::RBAC_PERM_LOG_GM_TRADE))
        {
            LOG_GM(GetAccountId(), "GM %s (Account: %u) create auction: %s (Entry: %u Count: %u)",
                GetPlayerName().c_str(), GetAccountId(), item->GetTemplate()->Name1.c_str(), item->GetEntry(), item->GetCount());
        }

        AH->Id = sObjectMgr->GenerateAuctionID();
        AH->itemGUIDLow = item->GetGUID().GetCounter();
        AH->itemEntry = item->GetEntry();
        AH->itemCount = item->GetCount();
        AH->owner = _player->GetGUID().GetCounter();
        AH->startbid = bid;
        AH->bidder = 0;
        AH->bid = 0;
        AH->buyout = buyout;
        AH->expire_time = GameTime::GetGameTime() + auctionTime;
        AH->deposit = deposit;
        AH->etime = etime;
        AH->auctionHouseEntry = auctionHouseEntry;
        AH->Flags = AUCTION_ENTRY_FLAG_NONE;

        LOG_INFO("network", "CMSG_AUCTION_SELL_ITEM: Player %s %s is selling item %s entry %u %s with count %u with initial bid %u with buyout %u and with time %u (in sec) in auctionhouse %u",
            _player->GetName().c_str(), _player->GetGUID().ToString().c_str(), item->GetTemplate()->Name1.c_str(), item->GetEntry(), item->GetGUID().ToString().c_str(), item->GetCount(), bid, buyout, auctionTime, AH->GetHouseId());

        // Add to pending auctions, or fail with insufficient funds error
        if (!sAuctionMgr->PendingAuctionAdd(_player, AH))
        {
            SendAuctionCommandResult(AH->Id, AUCTION_SELL_ITEM, ERR_AUCTION_NOT_ENOUGHT_MONEY);
            return;
        }

        sAuctionMgr->AddAItem(item);
        auctionHouse->AddAuction(AH);
        _player->MoveItemFromInventory(item->GetBagSlot(), item->GetSlot(), true);

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        item->DeleteFromInventoryDB(trans);
        item->SaveToDB(trans);

        AH->SaveToDB(trans);
        _player->SaveInventoryAndGoldToDB(trans);
        CharacterDatabase.CommitTransaction(trans);

        SendAuctionCommandResult(AH->Id, AUCTION_SELL_ITEM, ERR_AUCTION_OK);

        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
        GetPlayer()->AddLotsCount();
    }
    else // Required stack size of auction does not match to current item stack size, clone item and set correct stack size
    {
        Item* newItem = item->CloneItem(finalCount, _player);
        if (!newItem)
        {
            LOG_ERROR("network", "CMSG_AUCTION_SELL_ITEM: Could not create clone of item %u", item->GetEntry());
            SendAuctionCommandResult(0, AUCTION_SELL_ITEM, ERR_AUCTION_DATABASE_ERROR);
            delete AH;
            return;
        }

        if (HasPermission(rbac::RBAC_PERM_LOG_GM_TRADE))
        {
            LOG_GM(GetAccountId(), "GM %s (Account: %u) create auction: %s (Entry: %u Count: %u)",
                GetPlayerName().c_str(), GetAccountId(), newItem->GetTemplate()->Name1.c_str(), newItem->GetEntry(), newItem->GetCount());
        }

        AH->Id = sObjectMgr->GenerateAuctionID();
        AH->itemGUIDLow = newItem->GetGUID().GetCounter();
        AH->itemEntry = newItem->GetEntry();
        AH->itemCount = newItem->GetCount();
        AH->owner = _player->GetGUID().GetCounter();
        AH->startbid = bid;
        AH->bidder = 0;
        AH->bid = 0;
        AH->buyout = buyout;
        AH->expire_time = GameTime::GetGameTime() + auctionTime;
        AH->deposit = deposit;
        AH->etime = etime;
        AH->auctionHouseEntry = auctionHouseEntry;
        AH->Flags = AUCTION_ENTRY_FLAG_NONE;

        LOG_INFO("network", "CMSG_AUCTION_SELL_ITEM: Player %s %s is selling item %s entry %u %s with count %u with initial bid %u with buyout %u and with time %u (in sec) in auctionhouse %u",
            _player->GetName().c_str(), _player->GetGUID().ToString().c_str(), newItem->GetTemplate()->Name1.c_str(), newItem->GetEntry(), newItem->GetGUID().ToString().c_str(), newItem->GetCount(), bid, buyout, auctionTime, AH->GetHouseId());

        // Add to pending auctions, or fail with insufficient funds error
        if (!sAuctionMgr->PendingAuctionAdd(_player, AH))
        {
            SendAuctionCommandResult(AH->Id, AUCTION_SELL_ITEM, ERR_AUCTION_NOT_ENOUGHT_MONEY);
            return;
        }

        sAuctionMgr->AddAItem(newItem);
        auctionHouse->AddAuction(AH);
        for (uint32 j = 0; j < itemsCount; ++j)
        {
            Item* item2 = items[j];

            // Item stack count equals required count, ready to delete item - cloned item will be used for auction
            if (item2->GetCount() == count[j])
            {
                _player->MoveItemFromInventory(item2->GetBagSlot(), item2->GetSlot(), true);

                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                item2->DeleteFromInventoryDB(trans);
                item2->DeleteFromDB(trans);
                CharacterDatabase.CommitTransaction(trans);
                delete item2;
            }
            else // Item stack count is bigger than required count, update item stack count and save to database - cloned item will be used for auction
            {
                item2->SetCount(item2->GetCount() - count[j]);
                item2->SetState(ITEM_CHANGED, _player);
                _player->ItemRemovedQuestCheck(item2->GetEntry(), count[j]);
                item2->SendUpdateToPlayer(_player);

                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                item2->SaveToDB(trans);
                CharacterDatabase.CommitTransaction(trans);
            }
        }

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        newItem->SaveToDB(trans);
        AH->SaveToDB(trans);
        _player->SaveInventoryAndGoldToDB(trans);
        CharacterDatabase.CommitTransaction(trans);

        SendAuctionCommandResult(AH->Id, AUCTION_SELL_ITEM, ERR_AUCTION_OK);

        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CREATE_AUCTION, 1);
        GetPlayer()->AddLotsCount();
    }
}

//this function is called when client bids or buys out auction
void WorldSession::HandleAuctionPlaceBid(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_PLACE_BID");

    if (GetPlayer() && (sMailMgr->GetMailBoxSize(GetPlayer()->GetGUID().GetCounter()) + GetPlayer()->GetAuctionLotsCount()) > CONF_GET_UINT("Antispam.Mail.Controller"))
    {
        GetPlayer()->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_CAP_REACHED);
        recvData.rfinish();
        return;
    }

    ObjectGuid auctioneer;
    uint32 auctionId;
    uint32 price;
    recvData >> auctioneer;
    recvData >> auctionId >> price;

    if (!auctionId || !price)
        return;                                             //check for cheaters

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionPlaceBid - %s not found or you can't interact with him.", auctioneer.ToString().c_str());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    AuctionEntry* auction = auctionHouse->GetAuction(auctionId);
    Player* player = GetPlayer();

    if (!auction || auction->owner == player->GetGUID().GetCounter())
    {
        //you cannot bid your own auction:
        SendAuctionCommandResult(0, AUCTION_PLACE_BID, ERR_AUCTION_BID_OWN);
        return;
    }

    // impossible have online own another character (use this for speedup check in case online owner)
    ObjectGuid ownerGuid(HighGuid::Player, auction->owner);
    Player* auction_owner = ObjectAccessor::FindPlayer(ownerGuid);
    if (!auction_owner && sCharacterCache->GetCharacterAccountIdByGuid(ownerGuid) == player->GetSession()->GetAccountId())
    {
        //you cannot bid your another character auction:
        SendAuctionCommandResult(0, AUCTION_PLACE_BID, ERR_AUCTION_BID_OWN);
        return;
    }

    // cheating
    if (price <= auction->bid || price < auction->startbid)
        return;

    // price too low for next bid if not buyout
    if ((price < auction->buyout || auction->buyout == 0) &&
        price < auction->bid + auction->GetAuctionOutBid())
    {
        //auction has already higher bid, client tests it!
        return;
    }

    if (!player->HasEnoughMoney(price))
    {
        //you don't have enought money!, client tests!
        //SendAuctionCommandResult(auction->auctionId, AUCTION_PLACE_BID, ???);
        return;
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    if (price < auction->buyout || auction->buyout == 0)
    {
        if (auction->bidder > 0)
        {
            if (auction->bidder == player->GetGUID().GetCounter())
                player->ModifyMoney(-int32(price - auction->bid));
            else
            {
                // mail to last bidder and return money
                sAuctionMgr->SendAuctionOutbiddedMail(auction, price, GetPlayer());
                player->ModifyMoney(-int32(price));
            }
        }
        else
            player->ModifyMoney(-int32(price));

        auction->bidder = player->GetGUID().GetCounter();
        auction->bid = price;
        if (HasPermission(rbac::RBAC_PERM_LOG_GM_TRADE))
            auction->Flags = AuctionEntryFlag(auction->Flags | AUCTION_ENTRY_FLAG_GM_LOG_BUYER);
        else
            auction->Flags = AuctionEntryFlag(auction->Flags & ~AUCTION_ENTRY_FLAG_GM_LOG_BUYER);

        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, price);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_AUCTION_BID);
        stmt->setUInt32(0, auction->bidder);
        stmt->setUInt32(1, auction->bid);
        stmt->setUInt32(2, auction->Id);
        stmt->setUInt8(3, auction->Flags);
        trans->Append(stmt);

        if (auction->bidders.find(player->GetGUID()) == auction->bidders.end())
        {
            // save new bidder in list, and save record to db
            auction->bidders.insert(player->GetGUID());
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_AUCTION_BIDDERS);
            stmt->setUInt32(0, auction->Id);
            stmt->setUInt32(1, auction->bidder);
            trans->Append(stmt);

            GetPlayer()->AddLotsCount();
        }

        SendAuctionCommandResult(auction->Id, AUCTION_PLACE_BID, ERR_AUCTION_OK);
    }
    else
    {
        //buyout:
        if (player->GetGUID().GetCounter() == auction->bidder)
            player->ModifyMoney(-int32(auction->buyout - auction->bid));
        else
        {
            player->ModifyMoney(-int32(auction->buyout));
            if (auction->bidder)                          //buyout for bidded auction ..
                sAuctionMgr->SendAuctionOutbiddedMail(auction, auction->buyout, GetPlayer());
        }
        auction->bidder = player->GetGUID().GetCounter();
        auction->bid = auction->buyout;
        if (HasPermission(rbac::RBAC_PERM_LOG_GM_TRADE))
            auction->Flags = AuctionEntryFlag(auction->Flags | AUCTION_ENTRY_FLAG_GM_LOG_BUYER);
        else
            auction->Flags = AuctionEntryFlag(auction->Flags & ~AUCTION_ENTRY_FLAG_GM_LOG_BUYER);

        GetPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_AUCTION_BID, auction->buyout);

        //- Mails must be under transaction control too to prevent data loss
        sAuctionMgr->SendAuctionSalePendingMail(auction);
        sAuctionMgr->SendAuctionSuccessfulMail(auction);
        sAuctionMgr->SendAuctionWonMail(auction, trans);

        SendAuctionCommandResult(auction->Id, AUCTION_PLACE_BID, ERR_AUCTION_OK);

        auction->DeleteFromDB(trans);

        sAuctionMgr->RemoveAItem(auction->itemGUIDLow);
        auctionHouse->RemoveAuction(auction);
    }
    player->SaveInventoryAndGoldToDB(trans);
    CharacterDatabase.CommitTransaction(trans);
}

//this void is called when auction_owner cancels his auction
void WorldSession::HandleAuctionRemoveItem(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_REMOVE_ITEM");

    if (GetPlayer() && (sMailMgr->GetMailBoxSize(GetPlayer()->GetGUID().GetCounter()) + GetPlayer()->GetAuctionLotsCount()) > CONF_GET_UINT("Antispam.Mail.Controller"))
    {
        GetPlayer()->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_CAP_REACHED);
        recvData.rfinish();
        return;
    }

    ObjectGuid auctioneer;
    uint32 auctionId;
    recvData >> auctioneer;
    recvData >> auctionId;
    //LOG_DEBUG("Cancel AUCTION AuctionID: %u", auctionId);

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(auctioneer, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionRemoveItem - %s not found or you can't interact with him.", auctioneer.ToString().c_str());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    AuctionEntry* auction = auctionHouse->GetAuction(auctionId);
    Player* player = GetPlayer();

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    if (auction && auction->owner == player->GetGUID().GetCounter())
    {
        Item* pItem = sAuctionMgr->GetAItem(auction->itemGUIDLow);
        if (pItem)
        {
            if (auction->bidder > 0)                        // If we have a bidder, we have to send him the money he paid
            {
                uint32 auctionCut = auction->GetAuctionCut();
                if (!player->HasEnoughMoney(auctionCut))          //player doesn't have enough money, maybe message needed
                    return;
                //some auctionBidderNotification would be needed, but don't know that parts..
                sAuctionMgr->SendAuctionCancelledToBidderMail(auction);
                player->ModifyMoney(-int32(auctionCut));
            }

            std::list<Item*> itemlist;
            itemlist.push_back(pItem);
            // item will deleted or added to received mail list
            sMailMgr->SendMailByAuctionHouseWithItems(auction, player->GetGUID().GetCounter(), auction->BuildAuctionMailSubject(AUCTION_CANCELED), AuctionEntry::BuildAuctionMailBody(0, 0, auction->buyout, auction->deposit, 0), 0, itemlist, MAIL_CHECK_MASK_COPIED);
            itemlist.clear();
        }
        else
        {
            LOG_ERROR("network", "Auction id: %u has non-existed item (item guid : %u)!!!", auction->Id, auction->itemGUIDLow);
            SendAuctionCommandResult(0, AUCTION_CANCEL, ERR_AUCTION_DATABASE_ERROR);
            return;
        }
    }
    else
    {
        SendAuctionCommandResult(0, AUCTION_CANCEL, ERR_AUCTION_DATABASE_ERROR);
        //this code isn't possible ... maybe there should be assert
        LOG_ERROR("entities.player.cheat", "CHEATER : %s tried to cancel auction (id: %u) of another player, or auction is NULL", player->GetGUID().ToString().c_str(), auctionId);
        return;
    }

    //inform player, that auction is removed
    SendAuctionCommandResult(auction->Id, AUCTION_CANCEL, ERR_AUCTION_OK);
    player->RemoveLotsCount();
    // Now remove the auction

    player->SaveInventoryAndGoldToDB(trans);
    auction->DeleteFromDB(trans);
    CharacterDatabase.CommitTransaction(trans);

    sAuctionMgr->RemoveAItem(auction->itemGUIDLow);
    auctionHouse->RemoveAuction(auction);
}

//called when player lists his bids
void WorldSession::HandleAuctionListBidderItems(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_BIDDER_ITEMS");

    ObjectGuid guid;                                        //NPC guid
    uint32 listfrom;                                        //page of auctions
    uint32 outbiddedCount;                                  //count of outbidded auctions

    recvData >> guid;
    recvData >> listfrom;                                  // not used in fact (this list not have page control in client)
    recvData >> outbiddedCount;
    if (recvData.size() != (16 + outbiddedCount * 4))
    {
        LOG_ERROR("network", "Client sent bad opcode!!! with count: %u and size : %lu (must be: %u)", outbiddedCount, (unsigned long)recvData.size(), (16 + outbiddedCount * 4));
        outbiddedCount = 0;
    }

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionListBidderItems - %s not found or you can't interact with him.", guid.ToString().c_str());
        recvData.rfinish();
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    WorldPacket data(SMSG_AUCTION_BIDDER_LIST_RESULT, (4+4+4));
    Player* player = GetPlayer();
    data << (uint32) 0;                                     //add 0 as count
    uint32 count = 0;
    uint32 totalcount = 0;
    while (outbiddedCount > 0)                             //add all data, which client requires
    {
        --outbiddedCount;
        uint32 outbiddedAuctionId;
        recvData >> outbiddedAuctionId;
        AuctionEntry* auction = auctionHouse->GetAuction(outbiddedAuctionId);
        if (auction && auction->BuildAuctionInfo(data))
        {
            ++totalcount;
            ++count;
        }
    }

    auctionHouse->BuildListBidderItems(data, player, count, totalcount);
    data.put<uint32>(0, count);                           // add count to placeholder
    data << totalcount;
    data << (uint32)300;                                    //unk 2.3.0
    SendPacket(&data);
}

//this void sends player info about his auctions
void WorldSession::HandleAuctionListOwnerItems(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_OWNER_ITEMS");

    uint32 listfrom;
    ObjectGuid guid;

    recvData >> guid;
    recvData >> listfrom;                                  // not used in fact (this list not have page control in client)

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionListOwnerItems - %s not found or you can't interact with him.", guid.ToString().c_str());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    WorldPacket data(SMSG_AUCTION_OWNER_LIST_RESULT, (4+4+4));
    data << (uint32) 0;                                     // amount place holder

    uint32 count = 0;
    uint32 totalcount = 0;

    auctionHouse->BuildListOwnerItems(data, _player, count, totalcount);
    data.put<uint32>(0, count);
    data << (uint32) totalcount;
    data << (uint32) 0;
    SendPacket(&data);
}

//this void is called when player clicks on search button
void WorldSession::HandleAuctionListItems(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_ITEMS");

    std::string searchedname;
    uint8 levelmin, levelmax, usable, getAll;
    uint32 listfrom, auctionSlotID, auctionMainCategory, auctionSubCategory, quality;
    ObjectGuid guid;

    recvData >> guid;
    recvData >> listfrom;                                  // start, used for page control listing by 50 elements
    recvData >> searchedname;

    recvData >> levelmin >> levelmax;
    recvData >> auctionSlotID >> auctionMainCategory >> auctionSubCategory;
    recvData >> quality >> usable;

    recvData >> getAll;

    // this block looks like it uses some lame byte packing or similar...
    uint8 unkCnt;
    recvData >> unkCnt;
    for (uint8 i = 0; i < unkCnt; i++)
    {
        recvData.read_skip<uint8>();
        recvData.read_skip<uint8>();
    }

    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_AUCTIONEER);
    if (!creature)
    {
        LOG_DEBUG("network", "WORLD: HandleAuctionListItems - %s not found or you can't interact with him.", guid.ToString().c_str());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    AuctionHouseObject* auctionHouse = sAuctionMgr->GetAuctionsMap(creature->GetFaction());

    LOG_DEBUG("auctionHouse", "Auctionhouse search (%s) list from: %u, searchedname: %s, levelmin: %u, levelmax: %u, auctionSlotID: %u, auctionMainCategory: %u, auctionSubCategory: %u, quality: %u, usable: %u",
        guid.ToString().c_str(), listfrom, searchedname.c_str(), levelmin, levelmax, auctionSlotID, auctionMainCategory, auctionSubCategory, quality, usable);

    WorldPacket data(SMSG_AUCTION_LIST_RESULT, (4+4+4));
    uint32 count = 0;
    uint32 totalcount = 0;
    data << (uint32) 0;

    // converting string that we try to find to lower case
    std::wstring wsearchedname;
    if (!Utf8toWStr(searchedname, wsearchedname))
        return;

    wstrToLower(wsearchedname);

    auctionHouse->BuildListAuctionItems(data, _player,
        wsearchedname, listfrom, levelmin, levelmax, usable,
        auctionSlotID, auctionMainCategory, auctionSubCategory, quality,
        count, totalcount, (getAll != 0 && CONF_GET_INT("Auction.GetAllScanDelay") != 0));

    data.put<uint32>(0, count);
    data << (uint32) totalcount;
    data << (uint32) CONF_GET_INT("Auction.SearchDelay");
    SendPacket(&data);
}

void WorldSession::HandleAuctionListPendingSales(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_AUCTION_LIST_PENDING_SALES");

    recvData.read_skip<uint64>();

    uint32 count = 0;

    WorldPacket data(SMSG_AUCTION_LIST_PENDING_SALES, 4);
    data << uint32(count);                                  // count
    /*for (uint32 i = 0; i < count; ++i)
    {
        data << "";                                         // string
        data << "";                                         // string
        data << uint32(0);
        data << uint32(0);
        data << float(0);
    }*/
    SendPacket(&data);
}
