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

#ifndef _MAIL_H_
#define _MAIL_H_

#include "Common.h"
#include "Mail.h"
#include "Item.h"
#include "ObjectGuid.h"
#include "Timer.h"

constexpr uint32 MAIL_BODY_ITEM_TEMPLATE = 8383; // - plain letter, A Dusty Unsent Letter: 889
constexpr uint32 MAX_MAIL_ITEMS = 12;

struct AuctionEntry;
struct CalendarEvent;

class Item;
class Object;
class Player;

enum MailMessageType
{
    MAIL_NORMAL         = 0,
    MAIL_AUCTION        = 2,
    MAIL_CREATURE       = 3,                                // client send CMSG_CREATURE_QUERY on this mailmessagetype
    MAIL_GAMEOBJECT     = 4,                                // client send CMSG_GAMEOBJECT_QUERY on this mailmessagetype
    MAIL_CALENDAR       = 5
};

enum MailCheckMask
{
    MAIL_CHECK_MASK_NONE        = 0x00,
    MAIL_CHECK_MASK_READ        = 0x01,
    MAIL_CHECK_MASK_RETURNED    = 0x02,                     /// This mail was returned. Do not allow returning mail back again.
    MAIL_CHECK_MASK_COPIED      = 0x04,                     /// This mail was copied. Do not allow making a copy of items in mail.
    MAIL_CHECK_MASK_COD_PAYMENT = 0x08,
    MAIL_CHECK_MASK_HAS_BODY    = 0x10                      /// This mail has body text.
};

// gathered from Stationery.dbc
enum MailStationery
{
    MAIL_STATIONERY_TEST    = 1,
    MAIL_STATIONERY_DEFAULT = 41,
    MAIL_STATIONERY_GM      = 61,
    MAIL_STATIONERY_AUCTION = 62,
    MAIL_STATIONERY_VAL     = 64,                           // Valentine
    MAIL_STATIONERY_CHR     = 65,                           // Christmas
    MAIL_STATIONERY_ORP     = 67                            // Orphan
};

enum MailShowFlags
{
    MAIL_SHOW_UNK0    = 0x0001,
    MAIL_SHOW_DELETE  = 0x0002,                             // forced show delete button instead return button
    MAIL_SHOW_AUCTION = 0x0004,                             // from old comment
    MAIL_SHOW_UNK2    = 0x0008,                             // unknown, COD will be shown even without that flag
    MAIL_SHOW_RETURN  = 0x0010
};

enum MailState : uint8
{
    MAIL_STATE_UNCHANGED = 1,
    MAIL_STATE_CHANGED   = 2,
    //MAIL_STATE_DELETED   = 3  // not nessesary more
};

struct WH_GAME_API Mail
{
    uint8 messageType;
    uint8 stationery;
    uint16 mailTemplateId;
    ObjectGuid::LowType sender;
    ObjectGuid::LowType receiver;
    std::string subject;
    std::string body;
    bool items_exist;
    time_t expireTime;
    time_t deliverTime;
    uint32 money;
    uint32 COD;
    uint8 checked;
    uint8 state;
};

struct WH_GAME_API MailItem
{
    uint32 messageID;
    ObjectGuid::LowType item_guid;
    ObjectGuid::LowType receiver_guid;
};

class WH_GAME_API MailMgr
{
    private:
        MailMgr();
        ~MailMgr();

    public:
        static MailMgr* instance();

        void Initialize();

        void Update(uint32 diff);

        void SendMailBy(Object* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, MailCheckMask checkMask = MAIL_CHECK_MASK_NONE,
                        uint32 deliver_delay = 0, uint32 COD = 0);
        void SendMailByGUID(ObjectGuid::LowType sender, ObjectGuid::LowType receiver, uint8 messageType, std::string const& subject, std::string const& body, uint32 money,
                            MailCheckMask checkMask = MAIL_CHECK_MASK_NONE, uint32 deliver_delay = 0, uint32 COD = 0);

        void SendMailWithItemsBy(Object* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, std::list<Item*> const& itemlist,
                                 MailCheckMask checkMask = MAIL_CHECK_MASK_NONE, uint32 deliver_delay = 0, uint32 COD = 0);
        void SendMailWithItemsByGUID(ObjectGuid::LowType sender, ObjectGuid::LowType receiver, uint8 messageType, std::string const& subject, std::string const& body, uint32 money,
                                     std::list<Item*> const& itemlist, MailCheckMask checkMask = MAIL_CHECK_MASK_NONE, uint32 deliver_delay = 0, uint32 COD = 0);

        void SendMailByAuctionHouse(AuctionEntry* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, MailCheckMask checkMask = MAIL_CHECK_MASK_NONE,
                                    uint32 deliver_delay = 0, uint32 COD = 0);
        void SendMailByAuctionHouseWithItems(AuctionEntry* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, std::list<Item*> const& itemlist,
                                             MailCheckMask checkMask = MAIL_CHECK_MASK_NONE, uint32 deliver_delay = 0, uint32 COD = 0);

        void SendMailByCalendarEvent(CalendarEvent* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, MailCheckMask checkMask = MAIL_CHECK_MASK_NONE,
                                     uint32 deliver_delay = 0, uint32 COD = 0);
        void SendMailByCalendarEventWithItems(CalendarEvent* sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, std::list<Item*> const& itemlist,
                                              MailCheckMask checkMask = MAIL_CHECK_MASK_NONE, uint32 deliver_delay = 0, uint32 COD = 0);

        void SendMailWithTemplateBy(Object* sender, ObjectGuid::LowType receiver, uint16 mailTemplateId, MailCheckMask checkMask = MAIL_CHECK_MASK_HAS_BODY, uint32 deliver_delay = 0);
        void SendMailWithTemplateByGUID(ObjectGuid::LowType sender, ObjectGuid::LowType receiver, uint8 messageType, uint16 mailTemplateId, MailCheckMask checkMask = MAIL_CHECK_MASK_HAS_BODY,
                                        uint32 deliver_delay = 0);

        void RemoveAllMailsFor(ObjectGuid::LowType playerId);

        uint32 GetUnreadMessagesAndNextDelivertime(ObjectGuid::LowType playerId, time_t& delivertime);
        uint32 GetMailBoxSize(ObjectGuid::LowType playerId);

        bool HandleMailMarkAsRead(uint32 mailID);
        bool HandleMailDelete(uint32 mailID);
        uint8 HandleMailReturnToSender(uint32 mailID);
        uint8 HandleMailTakeItem(Player* player, uint32 mailID, ObjectGuid::LowType item_guid, uint32& count, uint8& msg_result);
        void HandleMailTakeMoney(Player* player, uint32 mailID);
        void HandleGetMailList(Player* player, WorldPacket& data);
        void HandleMailCreateTextItem(Player* player, uint32 mailID);
        bool HandleQueryNextMailTime(Player* player, WorldPacket& data);

        time_t GetMailMgrExpiryTimer() { return _ExpTimer.GetExpiry().count(); }

    private:
        // Mail section
        uint32 AddNewMail(
            uint8 messageType, uint8 stationery, uint16 mailTemplateId, ObjectGuid::LowType sender, ObjectGuid::LowType receiver,
            std::string const& subject, std::string const& body, bool items, uint32 money, time_t expireTime, time_t deliverTime,
            uint32 COD, uint8 checked = MAIL_CHECK_MASK_NONE, uint8 state = MAIL_STATE_UNCHANGED
        );

        // Mail Item section
        void AddNewMailItem(uint32 mailID, Item* itemPointer, ObjectGuid::LowType itemGuidLow, ObjectGuid::LowType receiver, CharacterDatabaseTransaction& trans);

        Item* GetMItem(uint32 id);
        void AddMItem(Item* it);
        bool RemoveMItem(uint32 id);

        void RemoveMail(uint32 mailID, CharacterDatabaseTransaction& trans);
        void RemoveMailItem(ObjectGuid::LowType itemGuidLow, CharacterDatabaseTransaction& trans);
        void RemoveMailItemsByMailId(uint32 mailID, CharacterDatabaseTransaction& trans);

        // helper
        bool PrepareMessageAttributeBy(Object* sender, ObjectGuid::LowType receiver, uint8& messageType, uint8& stationery, ObjectGuid::LowType& m_senderId, uint32 deliver_delay, uint32 COD,
                                       time_t& expireTime, time_t& deliverTime);
        bool PrepareMessageAttributeByGUID(ObjectGuid::LowType sender, uint8 messageType, uint8& stationery, uint32 deliver_delay, uint32 COD, time_t& expireTime, time_t& deliverTime);
        bool PrepareMessageAttributeForAuctionAndCalendar(uint32 deliver_delay, uint32 COD, time_t& expireTime, time_t& deliverTime);

        void PrepareItems(uint32 mailId, uint16 mailTemplateId, Player* receiver);
        uint32 SendReturnMailByGUID(uint32 old_mailID, ObjectGuid::LowType sender, ObjectGuid::LowType receiver, std::string const& subject, std::string const& body, uint32 money, bool itemexist,
                                    uint32 deliver_delay = 0);

        void CearDependInstanceItem(ObjectGuid::LowType playerId, uint32 mailID, CharacterDatabaseTransaction& trans);
        void ClearDependInstanceItemsBeforeDeletePlayer(ObjectGuid::LowType playerId);

        void _LoadMails();
        void _LoadMailItems();
        void _LoadMailedItemPointers();

        void _UpdateExpiryTime();
        time_t GetNextExpireMailUpd();
        void _DeleteExpiryMails(bool startServer = false);

        void _RemoveMoneyFromMail(uint32 mailId, CharacterDatabaseTransaction& trans) const;

        void SendMail(uint8 messageType, uint8 stationery, ObjectGuid::LowType sender, ObjectGuid::LowType receiver,
                      std::string const& subject, std::string const& body, uint32 money, time_t expireTime, time_t deliverTime, uint32 COD, uint8 checkMask = MAIL_CHECK_MASK_NONE);

        void SendMailItems(uint8 messageType, uint8 stationery, ObjectGuid::LowType sender, ObjectGuid::LowType receiver,
                           std::string const& subject, std::string const& body, uint32 money, std::list<Item*> const& itemlist, time_t expireTime, time_t deliverTime, uint32 COD, uint8 checkMask = MAIL_CHECK_MASK_NONE);

        void SendMailTemplate(uint8 messageType, uint8 stationery, uint16 mailTemplateId, ObjectGuid::LowType senderID,
                              ObjectGuid::LowType receiver, uint32 money, time_t expireTime, time_t deliverTime, MailCheckMask checkMask);

        std::unordered_map<uint32 /*mailId*/, Mail> _mails;
        std::unordered_map<uint32 /*mailItemId*/, MailItem> _mailItems;
        std::unordered_map<uint32, Item*> _MItems; // template defined in objectmgr.cpp

        // update interval
        uint32 m_updateTimer;
        TimeTracker _ExpTimer;
};

#define sMailMgr MailMgr::instance()

#endif // _MAIL_H_
