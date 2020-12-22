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
#include "CharacterCache.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "GameTime.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "Mail.h"
#include "Mail.h"
#include "MailPackets.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "GameConfig.h"
#include "WorldPacket.h"

bool WorldSession::CanOpenMailBox(ObjectGuid guid)
{
    if (guid == _player->GetGUID())
    {
        if (!HasPermission(rbac::RBAC_PERM_COMMAND_MAILBOX))
        {
            LOG_WARN("cheat", "%s attempted to open mailbox by using a cheat.", _player->GetName().c_str());
            return false;
        }
    }
    else if (guid.IsGameObject())
    {
        if (!_player->GetGameObjectIfCanInteractWith(guid, GAMEOBJECT_TYPE_MAILBOX))
            return false;
    }
    else if (guid.IsAnyTypeCreature())
    {
        if (!_player->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_MAILBOX))
            return false;
    }
    else
        return false;

    return true;
}

void WorldSession::HandleSendMail(WorldPackets::Mail::SendMailClient& sendMail)
{
    if (!CanOpenMailBox(sendMail.Mailbox))
        return;

    if (sendMail.Target.empty())
        return;

    Player* player = _player;

    if (_player->GetLevel() < CONF_GET_INT("LevelReq.Mail"))
    {
        SendNotification(GetWarheadString(LANG_MAIL_SENDER_REQ), CONF_GET_INT("LevelReq.Mail"));
        return;
    }

    ObjectGuid receiverGuid;
    if (normalizePlayerName(sendMail.Target))
        receiverGuid = sCharacterCache->GetCharacterGuidByName(sendMail.Target);

    if (!receiverGuid)
    {
        LOG_INFO("network", "Player %s is sending mail to %s (GUID: non-existing!) with subject %s "
            "and body %s includes " SZFMTD " items, %u copper and %u COD copper with StationeryID = %d, PackageID = %d",
            GetPlayerInfo().c_str(), sendMail.Target.c_str(), sendMail.Subject.c_str(), sendMail.Body.c_str(),
            sendMail.Attachments.size(), sendMail.SendMoney, sendMail.Cod, sendMail.StationeryID, sendMail.PackageID);
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_NOT_FOUND);
        return;
    }

    if (sendMail.SendMoney < 0)
    {
        GetPlayer()->SendMailResult(0, MAIL_SEND, MAIL_ERR_INTERNAL_ERROR);
        LOG_WARN("cheat", "Player %s attempted to send mail to %s (%s) with negative money value (SendMoney: %d)",
            GetPlayerInfo().c_str(), sendMail.Target.c_str(), receiverGuid.ToString().c_str(), sendMail.SendMoney);
        return;
    }

    if (sendMail.Cod < 0)
    {
        GetPlayer()->SendMailResult(0, MAIL_SEND, MAIL_ERR_INTERNAL_ERROR);
        LOG_WARN("cheat", "Player %s attempted to send mail to %s (%s) with negative COD value (Cod: %d)",
            GetPlayerInfo().c_str(), sendMail.Target.c_str(), receiverGuid.ToString().c_str(), sendMail.Cod);
        return;
    }

    LOG_INFO("network", "Player %s is sending mail to %s (%s) with subject %s and body %s "
        "including " SZFMTD " items, %u copper and %u COD copper with StationeryID = %d, PackageID = %d",
        GetPlayerInfo().c_str(), sendMail.Target.c_str(), receiverGuid.ToString().c_str(), sendMail.Subject.c_str(),
        sendMail.Body.c_str(), sendMail.Attachments.size(), sendMail.SendMoney, sendMail.Cod, sendMail.StationeryID, sendMail.PackageID);

    if (player->GetGUID() == receiverGuid)
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_CANNOT_SEND_TO_SELF);
        return;
    }

    int32 cost = !sendMail.Attachments.empty() ? 30 * sendMail.Attachments.size() : 30;  // price hardcoded in client

    int32 reqmoney = cost + sendMail.SendMoney;

    // Check for overflow
    if (reqmoney < sendMail.SendMoney)
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_NOT_ENOUGH_MONEY);
        return;
    }

    if (!player->HasEnoughMoney(reqmoney) && !player->IsGameMaster())
    {
        player->SendMailResult(0, MAIL_SEND, MAIL_ERR_NOT_ENOUGH_MONEY);
        return;
    }

        if (_player != player)
            return;

        // do not allow to have more than 100 mails in mailbox.. mails count is in opcode uint8!!! - so max can be 255..
        if (sMailMgr->GetMailBoxSize(receiverGuid) > 100)
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_CAP_REACHED);
            return;
        }

        // test the receiver's Faction... or all items are account bound
        bool accountBound = !sendMail.Attachments.empty();
        for (auto const& att : sendMail.Attachments)
        {
            if (Item* item = player->GetItemByGuid(att.ItemGUID))
            {
                ItemTemplate const* itemProto = item->GetTemplate();
                if (!itemProto || !itemProto->HasFlag(ITEM_FLAG_IS_BOUND_TO_ACCOUNT))
                {
                    accountBound = false;
                    break;
                }
            }
        }

        uint32 receiverTeam = 0;
        uint8 receiverLevel = 0;
        uint32 receiverAccountId = 0;
        Player* receiver = ObjectAccessor::FindConnectedPlayer(receiverGuid);
        if (receiver)
        {
            receiverTeam = receiver->GetTeam();
            receiverLevel = receiver->GetLevel();
            receiverAccountId = receiver->GetSession()->GetAccountId();
        }
        else
        {
            if (CharacterCacheEntry const* characterInfo = sCharacterCache->GetCharacterCacheByGuid(receiverGuid))
            {
                receiverTeam = Player::TeamForRace(characterInfo->Race);
                receiverLevel = characterInfo->Level;
                receiverAccountId = characterInfo->AccountId;
            }
        }

        if (!accountBound && player->GetTeam() != receiverTeam && !HasPermission(rbac::RBAC_PERM_TWO_SIDE_INTERACTION_MAIL))
        {
            player->SendMailResult(0, MAIL_SEND, MAIL_ERR_NOT_YOUR_TEAM);
            return;
        }

        if (receiverLevel < CONF_GET_INT("LevelReq.Mail"))
        {
            SendNotification(GetWarheadString(LANG_MAIL_RECEIVER_REQ), CONF_GET_INT("LevelReq.Mail"));
            return;
        }

        std::vector<Item*> items;

        for (auto const& att : sendMail.Attachments)
        {
            if (att.ItemGUID.IsEmpty())
            {
                player->SendMailResult(0, MAIL_SEND, MAIL_ERR_MAIL_ATTACHMENT_INVALID);
                return;
            }

            Item* item = player->GetItemByGuid(att.ItemGUID);

            // prevent sending bag with items (cheat: can be placed in bag after adding equipped empty bag to mail)
            if (!item)
            {
                player->SendMailResult(0, MAIL_SEND, MAIL_ERR_MAIL_ATTACHMENT_INVALID);
                return;
            }

            if (!item->CanBeTraded(true))
            {
                player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_MAIL_BOUND_ITEM);
                return;
            }

            if (item->IsBoundAccountWide() && item->IsSoulBound() && GetAccountId() != receiverAccountId)
            {
                player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_ARTEFACTS_ONLY_FOR_OWN_CHARACTERS);
                return;
            }

            if (item->GetTemplate()->HasFlag(ITEM_FLAG_CONJURED) || item->GetUInt32Value(ITEM_FIELD_DURATION))
            {
                player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_MAIL_BOUND_ITEM);
                return;
            }

            if (sendMail.Cod && item->IsWrapped())
            {
                player->SendMailResult(0, MAIL_SEND, MAIL_ERR_CANT_SEND_WRAPPED_COD);
                return;
            }

            if (item->IsNotEmptyBag())
            {
                player->SendMailResult(0, MAIL_SEND, MAIL_ERR_EQUIP_ERROR, EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS);
                return;
            }

            items.push_back(item);
        }

        player->SendMailResult(0, MAIL_SEND, MAIL_OK);

        player->ModifyMoney(-int32(reqmoney));
        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_MAIL, cost);

        bool needItemDelay = false;

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        std::list<Item*> maillist;
        if (!sendMail.Attachments.empty() || sendMail.SendMoney > 0)
        {
            bool log = HasPermission(rbac::RBAC_PERM_LOG_GM_TRADE);
            if (!sendMail.Attachments.empty())
            {
                for (Item* item : items)
                {
                    if (log)
                    {
                        LOG_GM(GetAccountId(), "GM %s (GUID: %u) (Account: %u) mail item: %s (Entry: %u Count: %u) "
                            "to: %s (%s) (Account: %u)", GetPlayerName().c_str(), GetGUIDLow(), GetAccountId(),
                            item->GetTemplate()->Name1.c_str(), item->GetEntry(), item->GetCount(),
                            sendMail.Target.c_str(), receiverGuid.ToString().c_str(), receiverAccountId);
                    }

                    item->SetNotRefundable(GetPlayer()); // makes the item no longer refundable
                    player->MoveItemFromInventory(item->GetBagSlot(), item->GetSlot(), true);

                    item->DeleteFromInventoryDB(trans);     // deletes item from character's inventory
                    item->SetOwnerGUID(receiverGuid);
                    item->SetState(ITEM_CHANGED);
                    item->SaveToDB(trans);                  // recursive and not have transaction guard into self, item not in inventory and can be save standalone

                    maillist.push_back(item);
                }

                // if item send to character at another account, then apply item delivery delay
                needItemDelay = GetAccountId() != receiverAccountId;
            }

            if (log && sendMail.SendMoney > 0)
            {
                LOG_GM(GetAccountId(), "GM %s (GUID: %u) (Account: %u) mail money: %u to: %s (%s) (Account: %u)",
                    GetPlayerName().c_str(), GetGUIDLow(), GetAccountId(), sendMail.SendMoney, sendMail.Target.c_str(), receiverGuid.ToString().c_str(), receiverAccountId);
            }
        }

        // If theres is an item, there is a one hour delivery delay if sent to another account's character.
        uint32 deliver_delay = needItemDelay ? CONF_GET_INT("MailDeliveryDelay") : 0;

        // don't ask for COD if there are no items
        if (sendMail.Attachments.empty())
            sendMail.Cod = 0;

        if (!sendMail.Attachments.empty())
            sMailMgr->SendMailWithItemsBy(player, receiverGuid.GetCounter(), sendMail.Subject, sendMail.Body, sendMail.SendMoney, maillist, sendMail.Body.empty() ? MAIL_CHECK_MASK_COPIED : MAIL_CHECK_MASK_HAS_BODY, deliver_delay, sendMail.Cod);
        else
            sMailMgr->SendMailBy(player, receiverGuid.GetCounter(), sendMail.Subject, sendMail.Body, sendMail.SendMoney, sendMail.Body.empty() ? MAIL_CHECK_MASK_COPIED : MAIL_CHECK_MASK_HAS_BODY, deliver_delay, sendMail.Cod);

        player->SaveInventoryAndGoldToDB(trans);
        CharacterDatabase.CommitTransaction(trans);
        // just i love to see destructors
        maillist.clear();
        items.clear();
}

//called when mail is read
void WorldSession::HandleMailMarkAsRead(WorldPackets::Mail::MailMarkAsRead& markAsRead)
{
    if (!CanOpenMailBox(markAsRead.Mailbox))
        return;

    if (!sMailMgr->HandleMailMarkAsRead(markAsRead.MailID))
        return;

    if (_player->unReadMails)
        --_player->unReadMails;
}

//called when client deletes mail
void WorldSession::HandleMailDelete(WorldPackets::Mail::MailDelete& mailDelete)
{
    if (!CanOpenMailBox(mailDelete.Mailbox))
        return;

    if (sMailMgr->HandleMailDelete(mailDelete.MailID))
        _player->SendMailResult(mailDelete.MailID, MAIL_DELETED, MAIL_OK);
    else
        _player->SendMailResult(mailDelete.MailID, MAIL_DELETED, MAIL_ERR_INTERNAL_ERROR);
}

void WorldSession::HandleMailReturnToSender(WorldPackets::Mail::MailReturnToSender& returnToSender)
{
    if (!CanOpenMailBox(returnToSender.Mailbox))
        return;

    switch (sMailMgr->HandleMailReturnToSender(returnToSender.MailID))
    {
        case 0:
            _player->SendMailResult(returnToSender.MailID, MAIL_RETURNED_TO_SENDER, MAIL_ERR_INTERNAL_ERROR);
            break;
        case 1:
            _player->SendMailResult(0, MAIL_SEND, MAIL_ERR_RECIPIENT_CAP_REACHED);
            break;
        case 2:
            _player->SendMailResult(returnToSender.MailID, MAIL_RETURNED_TO_SENDER, MAIL_OK);
            break;
        default:
            break;
    }
}

//called when player takes item attached in mail
void WorldSession::HandleMailTakeItem(WorldPackets::Mail::MailTakeItem& takeItem)
{
    if (!CanOpenMailBox(takeItem.Mailbox))
        return;

    uint8 msg_result = 0;
    uint32 count = 0;
    switch (sMailMgr->HandleMailTakeItem(_player, takeItem.MailID, takeItem.AttachID, count, msg_result))
    {
        case 0:
            _player->SendMailResult(takeItem.MailID, MAIL_ITEM_TAKEN, MAIL_ERR_INTERNAL_ERROR);
            break;
        case 1:
            _player->SendMailResult(takeItem.MailID, MAIL_ITEM_TAKEN, MAIL_ERR_NOT_ENOUGH_MONEY);
            break;
        case 2:
            _player->SendMailResult(takeItem.MailID, MAIL_ITEM_TAKEN, MAIL_OK, 0, takeItem.AttachID, count);
            break;
        case 3:
            _player->SendMailResult(takeItem.MailID, MAIL_ITEM_TAKEN, MAIL_ERR_EQUIP_ERROR, msg_result);
            break;
        default:
            break;
    }
}

void WorldSession::HandleMailTakeMoney(WorldPackets::Mail::MailTakeMoney& takeMoney)
{
    if (!CanOpenMailBox(takeMoney.Mailbox))
        return;

    sMailMgr->HandleMailTakeMoney(_player, takeMoney.MailID);
}

//called when player lists his received mails
void WorldSession::HandleGetMailList(WorldPackets::Mail::MailGetList& getList)
{
    if (!CanOpenMailBox(getList.Mailbox))
        return;

    WorldPacket data(SMSG_MAIL_LIST_RESULT, (200));         // guess size
    sMailMgr->HandleGetMailList(_player, data);
    SendPacket(&data);

    // recalculate m_nextMailDelivereTime and unReadMails
    _player->UpdateNextMailTimeAndUnreads();
}

//used when player copies mail body to his inventory
void WorldSession::HandleMailCreateTextItem(WorldPackets::Mail::MailCreateTextItem& createTextItem)
{
    if (!CanOpenMailBox(createTextItem.Mailbox))
        return;

    sMailMgr->HandleMailCreateTextItem(_player, createTextItem.MailID);
}

void WorldSession::HandleQueryNextMailTime(WorldPacket& /*recvData*/)
{
    WorldPacket data(MSG_QUERY_NEXT_MAIL_TIME, 8);

    if (_player->unReadMails > 0)
    {
        if (!sMailMgr->HandleQueryNextMailTime(_player, data))
        {
            data << float(-DAY);
            data << uint32(0);
        }
    }
    else
    {
        data << float(-DAY);
        data << uint32(0);
    }

    SendPacket(&data);
}
