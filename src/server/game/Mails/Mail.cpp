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

#include "Mail.h"
#include "AccountMgr.h"
#include "AuctionHouseMgr.h"
#include "Bag.h"
#include "BattlegroundMgr.h"
#include "CalendarMgr.h"
#include "CharacterCache.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "GameConfig.h"
#include "GameLocale.h"
#include "GameTime.h"
#include "Guild.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "LootMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "RBAC.h"
#include "WorldPacket.h"
#include "WorldSession.h"

constexpr uint32 MAX_NETCLIENT_PACKET_SIZE = 32767 - 1; // Client hardcap: int16 with trailing zero space otherwise crash on memory free
constexpr uint32 MAIL_UPDATE_INTERVAL = 1000; // 1 sec

GameMail* GameMail::instance()
{
    static GameMail instance;
    return &instance;
}

GameMail::GameMail() : _ExpTimer(MONTH)
{
    m_updateTimer = 0;
}

GameMail::~GameMail()
{
    _mails.clear();
    _mailItems.clear();

    for (auto& [id, mailItem] : _MItems)
        mailItem->RemoveFromWorld();

    _MItems.clear();
}

void GameMail::Initialize()
{
    _LoadMails();
    _LoadMailItems();
    _LoadMailedItemPointers();

    // delete old
    _DeleteExpiryMails(true);

    LOG_INFO("server.loading", "");
}

void GameMail::Update(uint32 diff)
{
    m_updateTimer += diff;

    if (m_updateTimer >= MAIL_UPDATE_INTERVAL) // upd only each 1 sec
    {
        _ExpTimer.Update(m_updateTimer / 1000);

        if (_ExpTimer.Passed())
            _DeleteExpiryMails();

        m_updateTimer = 0;
    }
}

void GameMail::SendMailBy(Object* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /* = 0*/, uint32 COD /*= 0*/)
{
    if (!sender || !receiver)
        return;

    uint8 messageType;
    uint8 stationery;
    ObjectGuid::LowType senderID;
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeBy(sender, receiver, messageType, stationery, senderID, deliver_delay, COD, expireTime, deliverTime))
        return;

    SendMail(messageType, stationery, senderID, receiver, subject, body, money, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailByGUID(ObjectGuid::LowType sender, ObjectGuid::LowType receiver, uint8 messageType, std::string const& subject, std::string const& body,
    uint32 money, MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /*= 0*/, uint32 COD /*= 0*/)
{
    if (!receiver)
        return;

    uint8 stationery;
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeByGUID(sender, messageType, stationery, deliver_delay, COD, expireTime, deliverTime))
        return;

    SendMail(messageType, stationery, sender, receiver, subject, body, money, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailWithItemsBy(Object* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money,
    std::vector<Item*> const& itemlist, MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /*= 0*/, uint32 COD /*= 0*/)
{
    if (!sender || !receiver)
        return;

    uint8 messageType;
    uint8 stationery;
    ObjectGuid::LowType senderID;
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeBy(sender, receiver, messageType, stationery, senderID, deliver_delay, COD, expireTime, deliverTime))
        return;

    SendMailItems(messageType, stationery, senderID, receiver, subject, body, money, itemlist, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailWithItemsByGUID(ObjectGuid::LowType sender, ObjectGuid::LowType receiver, uint8 messageType, std::string const& subject, std::string const& body,
    uint32 money, std::vector<Item*> const& itemlist, MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /*= 0*/, uint32 COD /*= 0*/)
{
    if (!receiver)
        return;

    uint8 stationery;
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeByGUID(sender, messageType, stationery, deliver_delay, 0, expireTime, deliverTime))
        return;

    SendMailItems(messageType, stationery, sender, receiver, subject, body, money, itemlist, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailByAuctionHouse(AuctionEntry* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money,
    MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /*= 0*/, uint32 COD /*= 0*/)
{
    if (!sender || !receiver)
        return;

    uint8 messageType = MAIL_AUCTION;
    uint8 stationery = MAIL_STATIONERY_AUCTION;
    ObjectGuid::LowType senderID = sender->GetHouseId();
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeForAuctionAndCalendar(deliver_delay, COD, expireTime, deliverTime))
        return;

    SendMail(messageType, stationery, senderID, receiver, subject, body, money, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailByAuctionHouseWithItems(AuctionEntry* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money,
    std::vector<Item*> const& itemlist, MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /*= 0*/, uint32 COD /*= 0*/)
{
    if (!sender || !receiver)
        return;

    uint8 messageType = MAIL_AUCTION;
    uint8 stationery = MAIL_STATIONERY_AUCTION;
    ObjectGuid::LowType m_senderId = sender->GetHouseId();
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeForAuctionAndCalendar(deliver_delay, COD, expireTime, deliverTime))
        return;

    SendMailItems(messageType, stationery, m_senderId, receiver, subject, body, money, itemlist, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailByCalendarEvent(CalendarEvent* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money,
    MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /*= 0*/, uint32 COD /*= 0*/)
{
    if (!sender || !receiver)
        return;

    uint8 messageType = MAIL_CALENDAR;
    uint8 stationery = MAIL_STATIONERY_DEFAULT;
    ObjectGuid::LowType senderID = sender->GetEventId();
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeForAuctionAndCalendar(deliver_delay, COD, expireTime, deliverTime))
        return;

    SendMail(messageType, stationery, senderID, receiver, subject, body, money, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailByCalendarEventWithItems(CalendarEvent* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money,
    std::vector<Item*> const& itemlist, MailCheckMask checkMask /*= MAIL_CHECK_MASK_NONE*/, uint32 deliver_delay /*= 0*/, uint32 COD /*= 0*/)
{
    if (!sender || !receiver)
        return;

    uint8 messageType = MAIL_CALENDAR;
    uint8 stationery = MAIL_STATIONERY_DEFAULT;
    ObjectGuid::LowType senderID = sender->GetEventId();
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeForAuctionAndCalendar(deliver_delay, COD, expireTime, deliverTime))
        return;

    SendMailItems(messageType, stationery, senderID, receiver, subject, body, money, itemlist, expireTime, deliverTime, COD, checkMask);
}

void GameMail::SendMailWithTemplateBy(Object* sender, ObjectGuid::LowType receiver, uint16 mailTemplateId, MailCheckMask checkMask /*= MAIL_CHECK_MASK_HAS_BODY*/, uint32 deliver_delay /*= 0*/)
{
    if (!sender || !receiver || !mailTemplateId)
        return;

    uint8 messageType;
    uint8 stationery;
    uint32 money = 0;
    ObjectGuid::LowType senderID;
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeBy(sender, receiver, messageType, stationery, senderID, deliver_delay, 0, expireTime, deliverTime))
        return;

    // The mail sent after turning in the quest The Good News and The Bad News contains 100g
    if (mailTemplateId == 123)
        money = 1000000;

    SendMailTemplate(messageType, stationery, mailTemplateId, senderID, receiver, money, expireTime, deliverTime, checkMask);
}

void GameMail::SendMailWithTemplateByGUID(ObjectGuid::LowType sender, ObjectGuid::LowType receiver, uint8 messageType, uint16 mailTemplateId, MailCheckMask checkMask /*= MAIL_CHECK_MASK_HAS_BODY*/, uint32 deliver_delay /*= 0*/)
{
    if (!sender || !receiver)
        return;

    if (!mailTemplateId)
        return;

    uint8 stationery;
    uint32 money = 0;
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeByGUID(sender, messageType, stationery, deliver_delay, 0, expireTime, deliverTime))
        return;

    // The mail sent after turning in the quest The Good News and The Bad News contains 100g
    if (mailTemplateId == 123)
        money = 1000000;

    SendMailTemplate(messageType, stationery, mailTemplateId, sender, receiver, money, expireTime, deliverTime, checkMask);
}

void GameMail::PrepareItems(uint32 mailId, uint16 mailTemplateId, Player* receiver)
{
    if (!receiver)
        return;

    Loot mailLoot;

    // can be empty
    mailLoot.FillLoot(mailTemplateId, LootTemplates_Mail, receiver, true, true);

    uint32 max_slot = mailLoot.GetMaxSlotInLootFor(receiver);
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    for (uint32 i = 0; i < max_slot; ++i)
    {
        if (LootItem* lootitem = mailLoot.LootItemInSlot(i, receiver))
        {
            if (Item* item = Item::CreateItem(lootitem->itemid, lootitem->count, receiver))
            {
                item->SaveToDB(trans);                           // save for prevent lost at next mail load, if send fail then item will deleted
                AddNewMailItem(mailId, item, item->GetGUID(), receiver->GetGUID().GetCounter(), trans);
            }
        }
    }

    CharacterDatabase.CommitTransaction(trans);
}

uint32 GameMail::SendReturnMailByGUID(uint32 old_mailID, ObjectGuid::LowType sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, bool itemexist, uint32 deliver_delay)
{
    if (!old_mailID || !receiver)
        return 0;

    uint8 messageType = MAIL_NORMAL;
    uint8 stationery = MAIL_STATIONERY_DEFAULT;
    MailCheckMask checkMask = MAIL_CHECK_MASK_RETURNED;
    time_t expireTime, deliverTime;

    if (!PrepareMessageAttributeByGUID(sender, messageType, stationery, deliver_delay, 0, expireTime, deliverTime))
        return 0;

    uint32 mail_id = AddNewMail(messageType, stationery, 0, sender, receiver, subject, body, itemexist, money, expireTime, deliverTime, 0, checkMask);

    if (!mail_id)
        return 0;

    if (itemexist)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL_ITEM_OLDMAILID_BY_MAILID);
        stmt->setUInt32(0, mail_id);
        stmt->setUInt32(1, old_mailID);
        CharacterDatabase.Execute(stmt);
    }

    // For online receiver update in game mail status and data
    if (Player* _receiver = ObjectAccessor::FindPlayerByLowGUID(receiver))
        _receiver->AddNewMailDeliverTime(deliverTime);

    return mail_id;
}

void GameMail::ClearDependInstanceItem(ObjectGuid::LowType playerId, uint32 mailID, CharacterDatabaseTransaction trans)
{
    ObjectGuid receiverGuid(HighGuid::Player, playerId);

    // Data needs to be at first place for Item::LoadFromDB
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAILITEM);
    stmt->setUInt32(0, mailID);

    PreparedQueryResult resultItems = CharacterDatabase.Query(stmt);
    if (resultItems)
    {
        do
        {
            Field* itemFields = resultItems->Fetch();
            ObjectGuid::LowType item_guidlow = itemFields[11].GetUInt32();
            uint32 item_template = itemFields[12].GetUInt32();

            ItemTemplate const* itemProto = sObjectMgr->GetItemTemplate(item_template);
            if (!itemProto)
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                stmt->setUInt32(0, item_guidlow);
                trans->Append(stmt);
                continue;
            }

            Item* pItem = NewItemOrBag(itemProto);
            if (!pItem->LoadFromDB(item_guidlow, receiverGuid, itemFields, item_template))
            {
                pItem->FSetState(ITEM_REMOVED);
                pItem->SaveToDB(trans);              // it also deletes item object!
                continue;
            }
        } while (resultItems->NextRow());
    }
}

void GameMail::ClearDependInstanceItemsBeforeDeletePlayer(ObjectGuid::LowType playerId)
{
    ObjectGuid receiverGuid(HighGuid::Player, playerId);

    // Data from ITEM_INSTANCE should be cleared also
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAILITEMS_FOR_DELETE);
    stmt->setUInt32(0, playerId);

    PreparedQueryResult resultItems = CharacterDatabase.Query(stmt);
    if (!resultItems)
        return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    do
    {
        Field* itemFields = resultItems->Fetch();
        ObjectGuid::LowType item_guidlow = itemFields[11].GetUInt32();
        uint32 item_template = itemFields[12].GetUInt32();

        ItemTemplate const* itemProto = sObjectMgr->GetItemTemplate(item_template);
        if (!itemProto)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
            stmt->setUInt32(0, item_guidlow);
            trans->Append(stmt);
            continue;
        }

        Item* pItem = NewItemOrBag(itemProto);
        if (!pItem->LoadFromDB(item_guidlow, receiverGuid, itemFields, item_template))
        {
            pItem->FSetState(ITEM_REMOVED);
            pItem->SaveToDB(trans);              // it also deletes item object!
            continue;
        }
    } while (resultItems->NextRow());

    CharacterDatabase.CommitTransaction(trans);
}

bool GameMail::PrepareMessageAttributeBy(Object* sender, [[maybe_unused]] ObjectGuid::LowType receiver, uint8& messageType, uint8& stationery, ObjectGuid::LowType& m_senderId, uint32 deliver_delay, uint32 COD, time_t& expireTime, time_t& deliverTime)
{
    stationery = MAIL_STATIONERY_DEFAULT;

    bool typeIsOk = true;
    switch (sender->GetTypeId())
    {
        case TYPEID_UNIT:
            messageType = MAIL_CREATURE;
            m_senderId = sender->GetEntry();
            break;
        case TYPEID_GAMEOBJECT:
            messageType = MAIL_GAMEOBJECT;
            m_senderId = sender->GetEntry();
            break;
        case TYPEID_PLAYER:
            messageType = MAIL_NORMAL;
            m_senderId = sender->GetGUID().GetCounter();
            if (sender->ToPlayer()->IsGameMaster())
                stationery = MAIL_STATIONERY_GM;
            break;
        default:
            messageType = MAIL_NORMAL;
            m_senderId = 0; // will show mail from non-existing player
            LOG_ERROR("misc", "GameMail::SendMailTo - Mail message contains unexpected sender typeid (%u).", sender->GetTypeId());
            typeIsOk = false;
            break;
    }

    if (!typeIsOk)
        return false;

    deliverTime = GameTime::GetGameTime() + deliver_delay;

    // expire time if COD 3 days, if no COD 30 days, if auction sale pending 1 hour
    uint32 expire_delay;

    // mail from battlemaster (rewardmarks) should last only one day
    if (messageType == MAIL_CREATURE && sBattlegroundMgr->GetBattleMasterBG(m_senderId) != BATTLEGROUND_TYPE_NONE)
        expire_delay = DAY;
    // default case: expire time if COD 3 days, if no COD 30 days (or 90 days if sender is a game master)
    else
    {
        Player* _sender = sender->ToPlayer();

        if (COD)
            expire_delay = 3 * DAY;
        else
            expire_delay = _sender && _sender->IsGameMaster() ? 90 * DAY : 30 * DAY;
    }

    expireTime = deliverTime + expire_delay;

    return true;
}

bool GameMail::PrepareMessageAttributeByGUID(ObjectGuid::LowType senderEntry, uint8 messageType, uint8& stationery, uint32 deliver_delay, uint32 COD, time_t& expireTime, time_t& deliverTime)
{
    stationery = MAIL_STATIONERY_DEFAULT;

    if (!senderEntry)
        stationery = MAIL_STATIONERY_GM;

    deliverTime = GameTime::GetGameTime() + deliver_delay;

    // expire time if COD 3 days, if no COD 30 days, if auction sale pending 1 hour
    uint32 expire_delay;

    // mail from battlemaster (rewardmarks) should last only one day
    if (messageType == MAIL_CREATURE && sBattlegroundMgr->GetBattleMasterBG(senderEntry) != BATTLEGROUND_TYPE_NONE)
        expire_delay = DAY;
    // default case: expire time if COD 3 days, if no COD 30 days (or 90 days if sender is a game master)
    else
    {
        if (COD)
            expire_delay = 3 * DAY;
        else
            expire_delay = 30 * DAY;
    }

    expireTime = deliverTime + expire_delay;

    return true;
}

bool GameMail::PrepareMessageAttributeForAuctionAndCalendar(uint32 deliver_delay, uint32 COD, time_t& expireTime, time_t& deliverTime)
{
    deliverTime = GameTime::GetGameTime() + deliver_delay;

    // expire time if COD 3 days, if no COD 30 days, if auction sale pending 1 hour
    uint32 expire_delay;
    if (COD)
        expire_delay = 3 * DAY;
    else
        expire_delay = 30 * DAY;

    expireTime = deliverTime + expire_delay;

    return true;
}

uint32 GameMail::AddNewMail(uint8 messageType, uint8 stationery, uint16 mailTemplateId, ObjectGuid::LowType sender, ObjectGuid::LowType receiver,
    std::string const& subject, std::string const& body, bool item_exists, uint32 money, time_t expireTime, time_t deliverTime,
    uint32 COD, uint8 checked, uint8 state)
{
    // find max id
    uint32 newID = 0;
    for (auto const& [_mailID, mail] : _mails)
        if (_mailID > newID)
            newID = _mailID;

    // use next
    ++newID;

    Mail nm;

    nm.messageType = messageType;
    nm.stationery = stationery;
    nm.mailTemplateId = mailTemplateId;
    nm.sender = sender;
    nm.receiver = receiver;
    nm.subject = subject;
    nm.body = body;
    nm.items_exist = item_exists;
    nm.expireTime = expireTime;
    nm.deliverTime = deliverTime;
    nm.money = money;
    nm.COD = COD;
    nm.checked = checked;
    nm.state = state;

    _mails.emplace(newID, nm);

    // Add to DB
    uint8 index = 0;
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_MAIL);
    stmt->setUInt32(index, newID);
    stmt->setUInt8(++index, messageType);
    stmt->setInt8(++index, stationery);
    stmt->setUInt16(++index, mailTemplateId);
    stmt->setUInt32(++index, sender);
    stmt->setUInt32(++index, receiver);
    stmt->setString(++index, subject);
    stmt->setString(++index, body);
    stmt->setInt8(++index, item_exists ? 1 : 0);
    stmt->setUInt64(++index, uint64(expireTime));
    stmt->setUInt64(++index, uint64(deliverTime));
    stmt->setUInt32(++index, money);
    stmt->setUInt32(++index, COD);
    stmt->setUInt8(++index, checked);
    stmt->setUInt8(++index, state);
    CharacterDatabase.Execute(stmt);

    time_t currentExpTime = GetMailMgrExpiryTimer();
    time_t now = GameTime::GetGameTime();

    if (expireTime - now < currentExpTime)
        _ExpTimer.Reset(expireTime - now);

    return newID;
}

void GameMail::RemoveAllMailsFor(ObjectGuid::LowType playerId)
{
    std::vector<uint32> mID;

    for (auto const& itr : _mails)
        if (itr.second.receiver == playerId)
            mID.emplace_back(itr.first);

    if (mID.empty())
        return;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    for (auto const& mailID : mID)
        RemoveMail(mailID, trans);

    CharacterDatabase.CommitTransaction(trans);

    mID.clear();

    ClearDependInstanceItemsBeforeDeletePlayer(playerId);
}

void GameMail::RemoveMail(uint32 mailID, CharacterDatabaseTransaction trans)
{
    // before need to remove all mail items and instance items
    RemoveMailItemsByMailId(mailID, trans);

    // now clear from container
    _mails.erase(mailID);

    // now clear from DB
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
    stmt->setUInt32(0, mailID);
    trans->Append(stmt);
}

void GameMail::AddNewMailItem(uint32 mailID, Item* itemPointer, ObjectGuid::LowType itemGuidLow, ObjectGuid::LowType receiver, CharacterDatabaseTransaction trans)
{
    bool itemExist = false;
    for (auto const& [mailItemID, mailItem] : _mailItems)
        if (mailItem.item_guid == itemGuidLow)
            itemExist = true;

    if (itemExist)
    {
        LOG_ERROR("mailMgr", "New Mail (%u) :: AddNewMailItem (GUID: %u), but item with this item_guid already exist, skip", mailID, itemGuidLow);
        return;
    }

    // find max id
    uint32 newID = 0;
    for (auto const& [mailItemID, mailItem] : _mailItems)
        if (mailItemID > newID)
            newID = mailItemID;

    // use next
    ++newID;

    MailItem mii;
    mii.messageID = mailID;
    mii.item_guid = itemGuidLow;
    mii.receiver_guid = receiver;
    _mailItems.emplace(newID, mii);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_MAIL_ITEM);
    stmt->setUInt32(0, newID);
    stmt->setUInt32(1, mailID);
    stmt->setUInt32(2, itemGuidLow);
    stmt->setUInt32(3, receiver);
    trans->Append(stmt);

    AddMItem(itemPointer);
}

void GameMail::RemoveMailItem(ObjectGuid::LowType itemGuidLow, CharacterDatabaseTransaction trans)
{
    uint32 id = 0;

    for (auto const& [mailItemID, mailItem] : _mailItems)
    {
        if (mailItem.item_guid == itemGuidLow)
        {
            id = mailItemID;
            break;
        }
    }

    if (!id)
        return;

    RemoveMItem(itemGuidLow);
    _mailItems.erase(id);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
    stmt->setUInt32(0, itemGuidLow);
    trans->Append(stmt);
}

void GameMail::RemoveMailItemsByMailId(uint32 mailID, CharacterDatabaseTransaction trans)
{
    std::vector<uint32> miID;

    for (auto const& [mailItemID, mailItem] : _mailItems)
    {
        if (mailItem.messageID == mailID)
        {
            ClearDependInstanceItem(mailItem.receiver_guid, mailID, trans);
            miID.emplace_back(mailItemID);
        }
    }

    if (miID.empty())
        return;

    for (auto const& mailItemID : miID)
        _mailItems.erase(mailItemID);

    miID.clear();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEMS_BY_MAILID);
    stmt->setUInt32(0, mailID);
    trans->Append(stmt);
}

uint32 GameMail::GetUnreadMessagesAndNextDelivertime(ObjectGuid::LowType playerId, time_t& delivertime)
{
    uint32 unread = 0;
    time_t cTime = GameTime::GetGameTime();

    for (auto const& [_mailID, mail] : _mails)
    {
        if (mail.receiver == playerId)
        {
            if (mail.deliverTime > cTime && (!delivertime || delivertime > mail.deliverTime))
                delivertime = mail.deliverTime;
            else if (mail.checked == MAIL_CHECK_MASK_READ)
                ++unread;
        }
    }

    return unread;
}

uint32 GameMail::GetMailBoxSize(ObjectGuid::LowType playerId)
{
    uint32 mails = 0;

    for (auto const& [_mailID, mail] : _mails)
        if (mail.receiver == playerId)
            ++mails;

    return mails;
}

bool GameMail::HandleMailMarkAsRead(uint32 mailID)
{
    auto itr = _mails.find(mailID);
    if (itr == _mails.end())
        return false;

    auto const& mail = itr->second;

    auto mailChecked = mail.checked | MAIL_CHECK_MASK_READ;
    auto mailState = MAIL_STATE_CHANGED;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL_MARK_AS_READ);
    stmt->setUInt8(0, uint8(mailChecked));
    stmt->setUInt8(1, uint8(mailState));
    stmt->setUInt32(2, itr->first);
    CharacterDatabase.Execute(stmt);

    return true;
}

bool GameMail::HandleMailDelete(uint32 mailID)
{
    auto const& itr = _mails.find(mailID);
    if (itr == _mails.end())
        return false;

    auto const& mail = itr->second;

    // if mail with item and COD we should reward sender (he should not lost the money)
    if (mail.COD && mail.sender && mail.messageType == MAIL_NORMAL)
        SendMailByGUID(0, mail.sender, MAIL_NORMAL, "Money received", "From old mail with COD", mail.COD, MAIL_CHECK_MASK_COD_PAYMENT);

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    RemoveMail(mailID, trans);
    CharacterDatabase.CommitTransaction(trans);

    return true;
}

MailResponseResult GameMail::HandleMailReturnToSender(uint32 mailID)
{
    uint32 newSender        = 0;
    uint32 newReceiver      = 0;
    uint32 money            = 0;
    uint32 deliver_delay    = 0;
    std::string subject, body;
    bool itemsExist = false;

    // Handle old-exist mailID (check it)
    auto const& itr = _mails.find(mailID);
    if (itr != _mails.end())
    {
        if (itr->second.deliverTime > GameTime::GetGameTime())
            return MAIL_ERR_INTERNAL_ERROR;

        ObjectGuid oldSenderGuid(HighGuid::Player, itr->second.sender);
        ObjectGuid oldReceiverGuid(HighGuid::Player, itr->second.receiver);

        uint32 srAccount = sCharacterCache->GetCharacterAccountIdByGuid(oldSenderGuid);
        uint32 rcAccount = sCharacterCache->GetCharacterAccountIdByGuid(oldReceiverGuid);

        Player* oldsender = ObjectAccessor::FindConnectedPlayer(oldSenderGuid);

        if (!oldsender && !srAccount) // sender (new receiver) not exist
            return MAIL_ERR_RECIPIENT_NOT_FOUND;

        if (itr->second.sender) // new receiver
        {
            if (Player* receiver = ObjectAccessor::FindPlayerByLowGUID(itr->second.sender))
            {
                if (GetMailBoxSize(itr->second.sender) + receiver->GetAuctionLotsCount() > CONF_GET_UINT("Antispam.Mail.Controller"))
                    return MAIL_ERR_RECIPIENT_CAP_REACHED;
            }
        }

        // MAIL_OK, now just gather info from mail for new mail
        newReceiver = itr->second.sender;
        newSender = itr->second.receiver;
        subject = itr->second.subject;
        body = itr->second.body;
        money = itr->second.money;

        if (itr->second.items_exist)
            itemsExist = true;

        bool needItemDelay = srAccount != rcAccount;

        // If theres is an item, there is a one hour delivery delay.
        deliver_delay = needItemDelay ? CONF_GET_INT("MailDeliveryDelay") : 0;
    }

    // 1 step - send new mail
    uint32 new_mailID = SendReturnMailByGUID(mailID, newSender, newReceiver, subject, body, money, itemsExist, deliver_delay);

    // 2 step - update mail_items for new mailid
    if (itemsExist)
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        auto const& itr = _mailItems.find(mailID);
        if (itr != _mailItems.end())
        {
            itr->second.receiver_guid = newReceiver;

            // update mailId in memory container (in DB it already done in SendReturnMailByGUID func)
            itr->second.messageID = new_mailID;

            // owner in data will set at mail receive and item extracting
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEM_OWNER);
            stmt->setUInt32(0, itr->second.receiver_guid);
            stmt->setUInt32(1, itr->second.item_guid);
            trans->Append(stmt);
        }

        CharacterDatabase.CommitTransaction(trans);
    }

    // 3 step - delete old mail
    CharacterDatabaseTransaction trans2 = CharacterDatabase.BeginTransaction();
    RemoveMail(mailID, trans2);
    CharacterDatabase.CommitTransaction(trans2);

    return MAIL_OK;
}

MailResponseResult GameMail::HandleMailTakeItem(Player* player, uint32 mailID, ObjectGuid::LowType item_guid, uint32& count, uint32& msg_result)
{
    if (!player || !player->GetSession())
        return MAIL_ERR_RECIPIENT_NOT_FOUND;

    auto const& itr = _mails.find(mailID);
    if (itr != _mails.end())
    {
        if (itr->second.deliverTime > GameTime::GetGameTime())
            return MAIL_ERR_INTERNAL_ERROR;

        // check on item id
        bool itemExist = false;
        for (auto const& [mailItemID, mailItem] : _mailItems)
            if (mailItem.messageID == mailID && mailItem.item_guid == item_guid)
                itemExist = true;

        Item* it = GetMItem(item_guid);
        if (!it || !itemExist)
        {
            if (!it && itemExist)
                LOG_ERROR("mailMgr", "Mail (%u) has item (GUID: %u), but doesn not exist in ItemMap of pointers", mailID, item_guid);

            if (it && !itemExist)
                LOG_ERROR("mailMgr", "Mail (%u) has item (GUID: %u), but doesn not exist in MailItemMap", mailID, item_guid);

            return MAIL_ERR_MAIL_ATTACHMENT_INVALID;
        }

        if (!player->HasEnoughMoney(itr->second.COD))
            return MAIL_ERR_CANT_SEND_WRAPPED_COD;

        ItemPosCountVec dest;
        msg_result = player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, it, false);

        if (msg_result == EQUIP_ERR_OK)
        {
            CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

            // if there is COD, take COD money from player and send them to sender by mail
            if (itr->second.COD)
            {
                ObjectGuid senderGuid(HighGuid::Player, itr->second.sender);
                Player* receiver = ObjectAccessor::FindConnectedPlayer(senderGuid);

                uint32 senderAccId = 0;

                if (player->GetSession()->HasPermission(rbac::RBAC_PERM_LOG_GM_TRADE))
                {
                    std::string senderName;
                    if (receiver)
                    {
                        senderAccId = receiver->GetSession()->GetAccountId();
                        senderName = receiver->GetName();
                    }
                    else
                    {
                        // can be calculated early
                        senderAccId = sCharacterCache->GetCharacterAccountIdByGuid(senderGuid);

                        if (!sCharacterCache->GetCharacterNameByGuid(senderGuid, senderName))
                            senderName = sGameLocale->GetWarheadStringForDBCLocale(LANG_UNKNOWN);
                    }
                    sLog->outCommand(player->GetSession()->GetAccountId(), "GM %s (Account: %u) receiver mail item: %s (Entry: %u Count: %u) and send COD money: %u to player: %s (Account: %u)",
                        player->GetName().c_str(), player->GetSession()->GetAccountId(), it->GetTemplate()->Name1.c_str(), it->GetEntry(), it->GetCount(), itr->second.COD, senderName.c_str(), senderAccId);
                }
                else if (!receiver)
                    senderAccId = sCharacterCache->GetCharacterAccountIdByGuid(senderGuid);

                // check player existence
                if (receiver || senderAccId)
                    SendMailBy(player, itr->second.sender, itr->second.subject, "", itr->second.COD, MAIL_CHECK_MASK_COD_PAYMENT);

                player->ModifyMoney(-int32(itr->second.COD));

                itr->second.COD = 0;
            }

            // upd state
            itr->second.state = MAIL_STATE_CHANGED;
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL_STATE);
            stmt->setUInt8(0, MAIL_STATE_CHANGED);
            stmt->setUInt32(1, mailID);
            trans->Append(stmt);

            count = it->GetCount();         // save counts before store and possible merge with deleting
            it->SetState(ITEM_UNCHANGED);   // need to set this state, otherwise item cannot be removed later, if neccessary
            player->MoveItemToInventory(dest, it, true);
            player->SaveInventoryAndGoldToDB(trans);

            // upd owner of item
            CharacterDatabasePreparedStatement* stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEM_OWNER);
            stmt2->setUInt32(0, player->GetGUID().GetCounter());
            stmt2->setUInt32(1, item_guid);
            trans->Append(stmt2);

            RemoveMailItem(item_guid, trans);

            // check on others items in this mail, and set "has_items" = 0 if no
            bool has_items = false;
            for (auto const& [mailItemID, mailItem] : _mailItems)
                if (mailItem.messageID == mailID)
                    has_items = true;

            CharacterDatabasePreparedStatement* stmt3 = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL_ITEM_HAS_ITEM);
            stmt3->setUInt8(0, has_items ? uint8(1) : uint8(0));
            stmt3->setUInt32(1, mailID);
            trans->Append(stmt3);
            CharacterDatabase.CommitTransaction(trans);

            return MAIL_OK;
        }
        else
            return MAIL_ERR_EQUIP_ERROR;
    }

    return MAIL_ERR_INTERNAL_ERROR;
}

MailResponseResult GameMail::HandleMailTakeMoney(Player* player, uint32 mailID, uint32& msg_result)
{
    if (!player)
        return MAIL_ERR_RECIPIENT_NOT_FOUND;

    auto const& itr = _mails.find(mailID);
    if (itr != _mails.end())
    {
        if (itr->second.deliverTime > GameTime::GetGameTime())
            return MAIL_ERR_INTERNAL_ERROR;

        if (!player->ModifyMoney(itr->second.money, false))
        {
            msg_result = EQUIP_ERR_TOO_MUCH_GOLD;
            return MAIL_ERR_EQUIP_ERROR;
        }

        itr->second.money = 0;
        itr->second.state = MAIL_STATE_CHANGED;

        player->SendMailResult(mailID, MAIL_MONEY_TAKEN, MAIL_OK);

        // save money and mail to prevent cheating
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        player->SaveGoldToDB(trans);
        _RemoveMoneyFromMail(mailID, trans);
        CharacterDatabase.CommitTransaction(trans);

        return MAIL_OK;
    }

    return MAIL_ERR_INTERNAL_ERROR;
}

void GameMail::HandleGetMailList(Player* player, WorldPacket& data)
{
    uint32 mailsCount = 0;      // real send to client mails amount
    uint32 realCount = 0;       // real mails amount

    data << uint32(0);          // real mail's count
    data << uint8(0);           // mail's count

    time_t cur_time = GameTime::GetGameTime();

    for (auto const& [mailID, mail] : _mails)
    {
        if (mail.receiver == player->GetGUID().GetCounter())
        {
            // Only first 50 mails are displayed
            if (mailsCount >= 50)
            {
                realCount += 1;
                continue;
            }

            // skip not delivered (deliver delay not expired) mails
            if (cur_time < mail.deliverTime)
                continue;

            uint8 item_count = 0;

            for (auto const& [mailItemID, mailItem] : _mailItems)
                if (mailItem.messageID == mailID)
                    ++item_count;

            size_t next_mail_size = 2 + 4 + 1 + (mail.messageType == MAIL_NORMAL ? 8 : 4) + 4 * 8 + (mail.subject.size() + 1) + (mail.body.size() + 1) + 1 + item_count * (1 + 4 + 4 + MAX_INSPECTED_ENCHANTMENT_SLOT * 3 * 4 + 4 + 4 + 4 + 4 + 4 + 4 + 1);

            if (data.wpos() + next_mail_size > MAX_NETCLIENT_PACKET_SIZE)
            {
                realCount += 1;
                continue;
            }

            data << uint16(next_mail_size);                     // Message size
            data << uint32(mailID);                             // Message ID
            data << uint8(mail.messageType);                    // Message Type

            switch (mail.messageType)
            {
                case MAIL_NORMAL:                               // sender guid
                    data << ObjectGuid(HighGuid::Player, mail.sender);
                    break;
                case MAIL_CREATURE:
                case MAIL_GAMEOBJECT:
                case MAIL_AUCTION:
                case MAIL_CALENDAR:
                    data << uint32(mail.sender);                // creature/gameobject entry, auction id, calendar event id?
                    break;
            }

            data << uint32(mail.COD);                           // COD
            data << uint32(0);                                  // package (Package.dbc)
            data << uint32(mail.stationery);                    // stationery (Stationery.dbc)
            data << uint32(mail.money);                         // Gold
            data << uint32(mail.checked);                       // flags
            data << float(float(mail.expireTime - GameTime::GetGameTime()) / DAY); // Time
            data << uint32(mail.mailTemplateId);                // mail template (MailTemplate.dbc)
            data << mail.subject;                               // Subject string - once 00, when mail type = 3, max 256
            data << mail.body;                                  // message? max 8000
            data << uint8(item_count);                          // client limit is 0x10

            uint8 ItemIntex = 0;
            for (auto const& [mailItemID, mailItem] : _mailItems)
            {
                if (mailItem.messageID == mailID)
                {
                    ++ItemIntex;
                    Item* item = GetMItem(mailItem.item_guid);

                    // item index (0-6?)
                    data << uint8(ItemIntex);

                    // item guid low?
                    data << uint32(item ? item->GetGUID().GetCounter() : 0);

                    // entry
                    data << uint32(item ? item->GetEntry() : 0);

                    for (uint8 j = 0; j < MAX_INSPECTED_ENCHANTMENT_SLOT; ++j)
                    {
                        data << uint32(item ? item->GetEnchantmentId((EnchantmentSlot)j) : 0);
                        data << uint32(item ? item->GetEnchantmentDuration((EnchantmentSlot)j) : 0);
                        data << uint32(item ? item->GetEnchantmentCharges((EnchantmentSlot)j) : 0);
                    }

                    // can be negative
                    data << int32(item ? item->GetItemRandomPropertyId() : 0);

                    // unk
                    data << uint32(item ? item->GetItemSuffixFactor() : 0);

                    // stack count
                    data << uint32(item ? item->GetCount() : 0);

                    // charges
                    data << uint32(item ? item->GetSpellCharges() : 0);

                    // durability
                    data << uint32(item ? item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY) : 0);

                    // durability
                    data << uint32(item ? item->GetUInt32Value(ITEM_FIELD_DURABILITY) : 0);

                    // unknown wotlk
                    data << uint8(item && !item->IsLocked() ? 1 : 0);
                }
            }

            ++realCount;
            ++mailsCount;
        }
    }

    data.put<uint32>(0, realCount); // this will display warning about undelivered mail to player if realCount > mailsCount
    data.put<uint8>(4, mailsCount); // set real send mails to client
}

MailResponseResult GameMail::HandleMailCreateTextItem(Player* player, uint32 mailID, uint32& msg_result)
{
    if (!player || !player->GetSession())
        return MAIL_ERR_RECIPIENT_NOT_FOUND;

    auto const& itr = _mails.find(mailID);
    if (itr == _mails.end())
        return MAIL_ERR_INTERNAL_ERROR;

    if ((itr->second.body.empty() && !itr->second.mailTemplateId) || itr->second.deliverTime > GameTime::GetGameTime() || (itr->second.checked & MAIL_CHECK_MASK_COPIED))
        return MAIL_ERR_INTERNAL_ERROR;

    Item* bodyItem = new Item;                              // This is not bag and then can be used new Item.
    if (!bodyItem->Create(sObjectMgr->GetGenerator<HighGuid::Item>().Generate(), MAIL_BODY_ITEM_TEMPLATE, player))
    {
        delete bodyItem;
        return MAIL_ERR_MAIL_ATTACHMENT_INVALID;
    }

    // in mail template case we need create new item text
    if (itr->second.mailTemplateId)
    {
        MailTemplateEntry const* mailTemplateEntry = sMailTemplateStore.LookupEntry(itr->second.mailTemplateId);
        ASSERT(mailTemplateEntry);
        bodyItem->SetText(mailTemplateEntry->Body[player->GetSession()->GetSessionDbcLocale()]);
    }
    else
        bodyItem->SetText(itr->second.body);

    if (itr->second.messageType == MAIL_NORMAL)
        bodyItem->SetGuidValue(ITEM_FIELD_CREATOR, ObjectGuid(HighGuid::Player, itr->second.sender));

    bodyItem->SetFlag(ITEM_FIELD_FLAGS, ITEM_FLAG_MAIL_TEXT_MASK);

    LOG_DEBUG("network", "HandleMailCreateTextItem mailid = %u", mailID);

    ItemPosCountVec dest;
    msg_result = player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, bodyItem, false);

    if (msg_result == EQUIP_ERR_OK)
    {
        itr->second.checked = itr->second.checked | MAIL_CHECK_MASK_COPIED;
        itr->second.state = MAIL_STATE_CHANGED;
        player->StoreItem(dest, bodyItem, true);
        return MAIL_OK;
    }
    else
    {
        delete bodyItem;
        return MAIL_ERR_EQUIP_ERROR;
    }

    return MAIL_ERR_INTERNAL_ERROR;
}

bool GameMail::HandleQueryNextMailTime(Player* player, WorldPacket& data)
{
    if (!player)
        return false;

    data << float(0);   // float
    data << uint32(0);  // count

    uint32 count = 0;
    time_t now = GameTime::GetGameTime();
    std::set<uint32> sentSenders;

    for (auto const& [_mailID, mail] : _mails)
    {
        if (mail.receiver == player->GetGUID().GetCounter())
        {
            // must be not checked yet
            if (mail.checked & MAIL_CHECK_MASK_READ)
                continue;

            // and already delivered
            if (now < mail.deliverTime)
                continue;

            // only send each mail sender once
            if (sentSenders.count(mail.sender))
                continue;

            data << uint64(mail.messageType == MAIL_NORMAL ? ObjectGuid(HighGuid::Player, mail.sender) : ObjectGuid::Empty);  // player guid
            data << uint32(mail.messageType != MAIL_NORMAL ? mail.sender : 0);  // non-player entries
            data << uint32(mail.messageType);
            data << uint32(mail.stationery);
            data << float(mail.deliverTime - now);

            sentSenders.emplace(mail.sender);

            ++count;

            if (count == 2)                                  // do not display more than 2 mails
                break;
        }
    }

    sentSenders.clear();

    data.put<uint32>(4, count);

    return true;
}

Item* GameMail::GetMItem(uint32 id)
{
    auto const& itr = _MItems.find(id);
    return itr != _MItems.end() ? itr->second : nullptr;
}

void GameMail::AddMItem(Item* it)
{
    ASSERT(it);

    // ASSERT deleted, because items can be added before loading
    _MItems[it->GetGUID().GetCounter()] = it;
}

bool GameMail::RemoveMItem(uint32 id)
{
    return _MItems.erase(id) ? true : false;
}

// sql helper in func
// set zero money in Mail in db when received money
void GameMail::_RemoveMoneyFromMail(uint32 mailId, CharacterDatabaseTransaction trans) const
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL_MONEY_RECEIVED);
    stmt->setUInt32(0, 0);
    stmt->setUInt32(1, mailId);
    trans->Append(stmt);
}

// load mails
void GameMail::_LoadMails()
{
    uint32 oldMSTime = getMSTime();

    _mails.clear();

    //                                                    0       1            2               3         4       5         6       7       8         9             10         11    12     13      14
    QueryResult result = CharacterDatabase.Query("SELECT id, messageType, stationery, mailTemplateId, sender, receiver, subject, body, has_items, expire_time, deliver_time, money, cod, checked, state FROM mail");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 Mails. DB table `mail` is empty.");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        uint32 id = fields[0].GetUInt32();

        Mail nm;
        nm.messageType = fields[1].GetUInt8();
        nm.stationery = fields[2].GetUInt8();
        nm.mailTemplateId = fields[3].GetUInt16();
        nm.sender = fields[4].GetUInt32();
        nm.receiver = fields[5].GetUInt32();
        nm.subject = fields[6].GetString();
        nm.body = fields[7].GetString();
        nm.items_exist = fields[8].GetUInt8() == 1 ? true : false;
        nm.expireTime = time_t(fields[9].GetUInt64());
        nm.deliverTime = time_t(fields[10].GetUInt64());
        nm.money = fields[11].GetUInt32();
        nm.COD = fields[12].GetUInt32();
        nm.checked = fields[13].GetUInt8();
        nm.state = fields[14].GetUInt8();

        _mails.emplace(id, nm);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded %u mails in %u ms", static_cast<uint32>(_mails.size()), GetMSTimeDiffToNow(oldMSTime));
}

void GameMail::_LoadMailItems()
{
    uint32 oldMSTime = getMSTime();

    _mailItems.clear();

    //                                                    0     1        2          3
    QueryResult result = CharacterDatabase.Query("SELECT id, mail_id, item_guid, receiver FROM mail_items");
    if (!result)
    {
        LOG_INFO("server.loading", ">> Loaded 0 Mail items. DB table `mail_items` is empty.");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        MailItem mii;
        uint32 id = fields[0].GetUInt32();
        mii.messageID = fields[1].GetUInt32();
        mii.item_guid = fields[2].GetUInt32();
        mii.receiver_guid = fields[3].GetUInt32();

        _mailItems.emplace(id, mii);
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded %u mail items in %u ms", static_cast<uint32>(_mailItems.size()), GetMSTimeDiffToNow(oldMSTime));
}

// load mailed item which should receive current player
void GameMail::_LoadMailedItemPointers()
{
    _MItems.clear();

    // data needs to be at first place for Item::LoadFromDB
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_MAILITEMS);

    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
        return;

    do
    {
        Field* fields = result->Fetch();

        ObjectGuid::LowType itemGuid = fields[11].GetUInt32();
        uint32 itemTemplate = fields[12].GetUInt32();

        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemTemplate);
        if (!proto)
        {
            LOG_ERROR("mailMgr", "Mail has unknown item_template in mailed items (GUID: %u, Entry: %u), deleted.", itemGuid, itemTemplate);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
            stmt->setUInt32(0, itemGuid);
            CharacterDatabase.Execute(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
            stmt->setUInt32(0, itemGuid);
            CharacterDatabase.Execute(stmt);
            continue;
        }

        Item* item = NewItemOrBag(proto);
        if (!item->LoadFromDB(itemGuid, ObjectGuid(HighGuid::Player, fields[13].GetUInt32()), fields, itemTemplate))
        {
            LOG_ERROR("entities.player", "Player::_LoadMailedItems: Item (GUID: %u) in mail doesn't exist, deleted from mail.", itemGuid);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
            stmt->setUInt32(0, itemGuid);
            CharacterDatabase.Execute(stmt);

            item->FSetState(ITEM_REMOVED);

            CharacterDatabaseTransaction temp = CharacterDatabaseTransaction(nullptr);
            item->SaveToDB(temp);                               // it also deletes item object !
            continue;
        }

        AddMItem(item);
    } while (result->NextRow());
}

void GameMail::_DeleteExpiryMails(bool startServer)
{
    std::vector<uint32> mailIds;
    time_t now = GameTime::GetGameTime();

    for (auto const& [mailID, mail] : _mails)
    {
        if (mail.expireTime <= now)
        {
            mailIds.emplace_back(mailID);

            // if mail with item and COD we should reward sender (he should not lost the money)
            if (mail.COD && mail.sender && mail.messageType == MAIL_NORMAL)
                SendMailByGUID(0, mail.sender, MAIL_NORMAL, "Money received", "From old mail with COD", mail.COD, MAIL_CHECK_MASK_COD_PAYMENT);
        }
    }

    if (!mailIds.empty())
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        for (auto const& mailID : mailIds)
            RemoveMail(mailID, trans);

        CharacterDatabase.CommitTransaction(trans);
    }

    mailIds.clear();

    // set new exp time
    if (!startServer)
        _UpdateExpiryTime();
}

time_t GameMail::GetNextExpireMailUpd()
{
    time_t nextExpiry = GameTime::GetGameTime() + (12 * HOUR);

    for (auto const& [_mailID, mail] : _mails)
        if (mail.expireTime < nextExpiry)
            nextExpiry = mail.expireTime;

    return nextExpiry;
}

void GameMail::_UpdateExpiryTime()
{
    time_t now = GameTime::GetGameTime();
    time_t newExpiry = GetNextExpireMailUpd();

    _ExpTimer.Reset(newExpiry - now);
}

void GameMail::SendMail(uint8 messageType, uint8 stationery, ObjectGuid::LowType sender, ObjectGuid::LowType receiver,
    std::string const& subject, std::string const& body, uint32 money, time_t expireTime, time_t deliverTime, uint32 COD, uint8 checkMask /*= MAIL_CHECK_MASK_NONE*/)
{
    uint32 mail_id = AddNewMail(messageType, stationery, 0, sender, receiver, subject, body, false, money, expireTime, deliverTime, COD, checkMask);
    if (!mail_id)
        return;

    // For online receiver update in game mail status and data
    if (Player* _receiver = ObjectAccessor::FindPlayerByLowGUID(receiver))
        _receiver->AddNewMailDeliverTime(deliverTime);
}

void GameMail::SendMailItems(uint8 messageType, uint8 stationery, ObjectGuid::LowType sender, ObjectGuid::LowType receiver,
    std::string const& subject, std::string const& body, uint32 money, std::vector<Item*> const& itemlist, time_t expireTime, time_t deliverTime, uint32 COD, uint8 checkMask /*= MAIL_CHECK_MASK_NONE*/)
{
    uint32 mail_id = AddNewMail(messageType, stationery, 0, sender, receiver, subject, body, true, money, expireTime, deliverTime, COD, checkMask);
    if (!mail_id)
        return;

    if (!itemlist.empty()) // it's unreal, but possible to sent message with empty list
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        for (auto const& item : itemlist)
            AddNewMailItem(mail_id, item, item->GetGUID(), receiver, trans);

        CharacterDatabase.CommitTransaction(trans);
    }

    // For online receiver update in game mail status and data
    if (Player* _receiver = ObjectAccessor::FindPlayerByLowGUID(receiver))
        _receiver->AddNewMailDeliverTime(deliverTime);
}

void GameMail::SendMailTemplate(uint8 messageType, uint8 stationery, uint16 mailTemplateId, ObjectGuid::LowType senderID,
    ObjectGuid::LowType receiver, uint32 money, time_t expireTime, time_t deliverTime, MailCheckMask checkMask)
{
    uint32 mail_id = AddNewMail(messageType, stationery, mailTemplateId, senderID, receiver, "", "", false, money, expireTime, deliverTime, 0, checkMask);

    if (!mail_id)
        return;

    if (Player* _receiver = ObjectAccessor::FindPlayerByLowGUID(receiver))
        PrepareItems(mail_id, mailTemplateId, _receiver);
}
