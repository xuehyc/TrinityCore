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

#include "MailExternal.h"
#include "CharacterCache.h"
#include "DatabaseEnv.h"
#include "ObjectMgr.h"
#include "Mail.h"
#include "Item.h"
#include "Log.h"
#include "TaskScheduler.h"

namespace
{
    struct ExMail
    {
        uint32 ID;
        ObjectGuid::LowType PlayerGuid;
        std::string Subject;
        std::string Body;
        uint32 Money;
        uint32 CreatureEntry;
        std::vector<std::pair<uint32, uint32>> Items;
        std::vector<std::vector<std::pair<uint32, uint32>>> _overCountItems;

        bool AddItems(uint32 itemID, uint32 itemCount)
        {
            ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemID);
            if (!itemTemplate)
            {
                LOG_ERROR("mail.external", "> External Mail: Item (%u) is not exist! ExternalMailID (%u)", itemID, ID);
                return false;
            }

            if (itemCount < 1 || (itemTemplate->MaxCount > 0 && itemCount > static_cast<uint32>(itemTemplate->MaxCount)))
            {
                LOG_ERROR("mail.external", "> External Mail: Invalid count (%u) for item (%u). ExternalMailID (%u)", itemCount, itemID, ID);
                return false;
            }

            while (itemCount > itemTemplate->GetMaxStackSize())
            {
                if (Items.size() <= MAX_MAIL_ITEMS)
                {
                    Items.emplace_back(itemID, itemTemplate->GetMaxStackSize());
                    itemCount -= itemTemplate->GetMaxStackSize();
                }
                else
                {
                    _overCountItems.emplace_back(Items);
                    Items.clear();
                }
            }

            Items.emplace_back(itemID, itemCount);
            _overCountItems.emplace_back(Items);

            return true;
        }
    };

    std::unordered_map<uint32, ExMail> _mailStore;
    TaskScheduler scheduler;
}

MailExternal* MailExternal::instance()
{
    static MailExternal instance;
    return &instance;
}

void MailExternal::Initialize()
{
    scheduler.Schedule(5s, [this](TaskContext context)
    {
        GetMailsFromDB();
        SendMails();

        context.Repeat();
    });

    LOG_INFO("server.loading", ">> Done");
    LOG_INFO("server.loading", "");
}

void MailExternal::Update(uint32 diff)
{
    scheduler.Update(diff);
}

void MailExternal::SendMails()
{
    // Check mails
    if (_mailStore.empty())
        return;

    LOG_TRACE("mail.external", "> External Mail: SendMails");

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_EXTERNAL_MAIL);

    for (auto const& [ID, exMail] : _mailStore)
    {
        for (auto const& items : exMail._overCountItems)
        {
            std::list<Item*> _itemlist;

            for (auto const& itr : items)
            {
                if (Item* mailItem = Item::CreateItem(itr.first, itr.second))
                {
                    _itemlist.emplace_back(mailItem);
                    mailItem->SaveToDB(trans);
                }
            }

            sMailMgr->SendMailWithItemsByGUID(0, exMail.PlayerGuid, MAIL_CREATURE, exMail.Subject, exMail.Body, exMail.Money, _itemlist);
        }

        stmt->setUInt32(0, ID);
        trans->Append(stmt);
    }

    CharacterDatabase.CommitTransaction(trans);

    LOG_DEBUG("mail.external", "> External Mail: Sended (%u) mails", static_cast<uint32>(_mailStore.size()));
    LOG_DEBUG("mail.external", "");

    // Clear for next time
    _mailStore.clear();
}

void MailExternal::GetMailsFromDB()
{
    LOG_TRACE("mail.external", "> External Mail: Sending mails in queue...");

    PreparedQueryResult result = CharacterDatabase.Query(CharacterDatabase.GetPreparedStatement(CHAR_SEL_EXTERNAL_MAIL));
    if (!result)
    {
        LOG_TRACE("mail.external", "> External Mail: No mails in queue...");
        return;
    }

    do
    {
        Field* fields = result->Fetch();
        std::string playerName = fields[1].GetString();
        uint32 itemID = fields[5].GetUInt32();
        uint32 itemCount = fields[6].GetUInt32();

        if (!normalizePlayerName(playerName))
        {
            LOG_ERROR("mail.external", "> External Mail: Invalid player name (%s)", playerName.c_str());
            continue;
        }

        ObjectGuid playerGuid = sCharacterCache->GetCharacterGuidByName(playerName);
        if (!playerGuid.IsPlayer())
            continue;

        ::ExMail _data;
        _data.ID = fields[0].GetUInt32();
        _data.PlayerGuid = playerGuid.GetCounter();
        _data.Subject = fields[2].GetString();
        _data.Body = fields[3].GetString();
        _data.Money = fields[4].GetUInt32();
        _data.CreatureEntry = fields[7].GetUInt32();

        if (!sObjectMgr->GetItemTemplate(itemID))
        {
            LOG_ERROR("mail.external", "> External Mail: Item %u is not exist. Skip", itemID);
            continue;
        }

        if (!sObjectMgr->GetCreatureTemplate(_data.CreatureEntry))
        {
            LOG_ERROR("mail.external", "> External Mail: Creature template %u is not exist. Skip", _data.CreatureEntry);
            continue;
        }

        if (!_data.AddItems(itemID, itemCount))
            continue;

        _mailStore.emplace(_data.ID, _data);
    } while (result->NextRow());
}

void MailExternal::AddMail(std::string_view charName, std::string_view thanksSubject, std::string_view thanksText, uint32 money, uint32 itemID, uint32 itemCount, uint32 creatureEntry)
{
    // INSERT INTO `mail_external` (`PlayerName`, `Subject`, `Message`, `Money`, `ItemID`, `ItemCount`, `CreatureEntry`) VALUES (?, ?, ?, ?, ?, ?, ?)
    auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_EXTERNAL_MAIL);
    stmt->setStringView(0, charName);
    stmt->setStringView(1, thanksSubject);
    stmt->setStringView(2, thanksText);
    stmt->setUInt32(3, money);
    stmt->setUInt32(4, itemID);
    stmt->setUInt32(5, itemCount);
    stmt->setUInt32(6, creatureEntry);

    CharacterDatabase.Query(stmt);
}
