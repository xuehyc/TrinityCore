/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "BankPackets.h"
#include "Item.h"
#include "DB2Stores.h"
#include "Log.h"
#include "NPCPackets.h"
#include "Opcodes.h"
#include "Player.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleAutoBankItemOpcode(WorldPackets::Bank::AutoBankItem& packet)
{
    LOG_DEBUG("network", "STORAGE: receive bag = %u, slot = %u", packet.Bag, packet.Slot);

    if (!CanUseBank())
    {
        LOG_ERROR("network", "WORLD: HandleAutoBankItemOpcode - Unit (%s) not found or you can't interact with him.", m_currentBankerGUID.ToString().c_str());
        return;
    }

    Item* item = _player->GetItemByPos(packet.Bag, packet.Slot);
    if (!item)
        return;

    ItemPosCountVec dest;
    InventoryResult msg = _player->CanBankItem(NULL_BAG, NULL_SLOT, dest, item, false);
    if (msg != EQUIP_ERR_OK)
    {
        _player->SendEquipError(msg, item, NULL);
        return;
    }

    if (dest.size() == 1 && dest[0].pos == item->GetPos())
    {
        _player->SendEquipError(EQUIP_ERR_CANT_SWAP, item, NULL);
        return;
    }

    _player->RemoveItem(packet.Bag, packet.Slot, true);
    _player->ItemRemovedQuestCheck(item->GetEntry(), item->GetCount());
    _player->BankItem(dest, item, true);
}

void WorldSession::HandleBankerActivateOpcode(WorldPackets::NPC::Hello& packet)
{
    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(packet.Unit, UNIT_NPC_FLAG_BANKER);
    if (!unit)
    {
        LOG_ERROR("network", "WORLD: HandleBankerActivateOpcode - %s not found or you can not interact with him.", packet.Unit.ToString().c_str());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // set currentBankerGUID for other bank action

    SendShowBank(packet.Unit);
}

void WorldSession::HandleAutoStoreBankItemOpcode(WorldPackets::Bank::AutoStoreBankItem& packet)
{
    LOG_DEBUG("network", "STORAGE: receive bag = %u, slot = %u", packet.Bag, packet.Slot);

    if (!CanUseBank())
    {
        LOG_ERROR("network", "WORLD: HandleAutoStoreBankItemOpcode - Unit (%s) not found or you can't interact with him.", m_currentBankerGUID.ToString().c_str());
        return;
    }

    Item* item = _player->GetItemByPos(packet.Bag, packet.Slot);
    if (!item)
        return;

    if (_player->IsBankPos(packet.Bag, packet.Slot))                    // moving from bank to inventory
    {
        ItemPosCountVec dest;
        InventoryResult msg = _player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, item, false);
        if (msg != EQUIP_ERR_OK)
        {
            _player->SendEquipError(msg, item, NULL);
            return;
        }

        _player->RemoveItem(packet.Bag, packet.Slot, true);
        if (Item const* storedItem = _player->StoreItem(dest, item, true))
            _player->ItemAddedQuestCheck(storedItem->GetEntry(), storedItem->GetCount());

    }
    else                                                                // moving from inventory to bank
    {
        ItemPosCountVec dest;
        InventoryResult msg = _player->CanBankItem(NULL_BAG, NULL_SLOT, dest, item, false);
        if (msg != EQUIP_ERR_OK)
        {
            _player->SendEquipError(msg, item, NULL);
            return;
        }

        _player->RemoveItem(packet.Bag, packet.Slot, true);
        _player->BankItem(dest, item, true);
    }
}

void WorldSession::HandleBuyBankSlotOpcode(WorldPackets::Bank::BuyBankSlot& packet)
{
    WorldPacket data(SMSG_BUY_BANK_SLOT_RESULT, 4);
    if (!CanUseBank(packet.Guid))
    {
        data << uint32(ERR_BANKSLOT_NOTBANKER);
        SendPacket(&data);
        LOG_ERROR("network", "WORLD: HandleBuyBankSlotOpcode - %s not found or you can't interact with him.", packet.Guid.ToString().c_str());
        return;
    }

    uint32 slot = _player->GetBankBagSlotCount();

    // next slot
    ++slot;

    LOG_INFO("network", "PLAYER: Buy bank bag slot, slot number = %u", slot);

    BankBagSlotPricesEntry const* slotEntry = sBankBagSlotPricesStore.LookupEntry(slot);

    if (!slotEntry)
    {
        data << uint32(ERR_BANKSLOT_FAILED_TOO_MANY);
        SendPacket(&data);
        return;
    }

    uint32 price = slotEntry->Cost;

    if (!_player->HasEnoughMoney(uint64(price)))
    {
        data << uint32(ERR_BANKSLOT_INSUFFICIENT_FUNDS);
        SendPacket(&data);
        return;
    }

    _player->SetBankBagSlotCount(slot);
    _player->ModifyMoney(-int64(price));

     data << uint32(ERR_BANKSLOT_OK);
     SendPacket(&data);

    _player->UpdateCriteria(CRITERIA_TYPE_BUY_BANK_SLOT);
}

void WorldSession::SendShowBank(ObjectGuid guid)
{
    m_currentBankerGUID = guid;
    WorldPackets::NPC::ShowBank packet;
    packet.Guid = guid;
    SendPacket(packet.Write());
}
