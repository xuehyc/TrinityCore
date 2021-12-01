/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WorldSession.h"
#include "DB2Stores.h"
#include "Item.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "ToyPackets.h"

void WorldSession::HandleAddToy(WorldPackets::Toy::AddToy& packet)
{
    if (!packet.Guid)
        return;

    Item* item = _player->GetItemByGuid(packet.Guid);
    if (!item)
    {
        _player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, nullptr, nullptr);
        return;
    }

    if (!sDB2Manager.IsToyItem(item->GetEntry()))
        return;

    InventoryResult msg = _player->CanUseItem(item);
    if (msg != EQUIP_ERR_OK)
    {
        _player->SendEquipError(msg, item, nullptr);
        return;
    }

    if (_collectionMgr->AddToy(item->GetEntry(), false))
        _player->DestroyItem(item->GetBagSlot(), item->GetSlot(), true);
}

void WorldSession::HandleUseToy(WorldPackets::Toy::UseToy& packet)
{
    uint32 itemId = packet.Cast.Misc[0];
    ItemTemplate const* item = sObjectMgr->GetItemTemplate(itemId);
    if (!item)
        return;

    if (!_collectionMgr->HasToy(itemId))
        return;

    auto effect = std::find_if(item->Effects.begin(), item->Effects.end(), [&packet](ItemEffectEntry const* effect)
    {
        return packet.Cast.SpellID == effect->SpellID;
    });

    if (effect == item->Effects.end())
        return;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(packet.Cast.SpellID);
    if (!spellInfo)
    {
        LOG_ERROR("network", "HandleUseToy: unknown spell id: %u used by Toy Item entry %u", packet.Cast.SpellID, itemId);
        return;
    }

    if (_player->isPossessing())
        return;

    SpellCastTargets targets(_player, packet.Cast);

    Spell* spell = new Spell(_player, spellInfo, TRIGGERED_NONE, ObjectGuid::Empty, false);

    WorldPackets::Spells::SpellPrepare spellPrepare;
    spellPrepare.ClientCastID = packet.Cast.CastID;
    spellPrepare.ServerCastID = spell->m_castId;
    SendPacket(spellPrepare.Write());

    spell->m_fromClient = true;
    spell->m_castItemEntry = itemId;
    spell->m_misc.Raw.Data[0] = packet.Cast.Misc[0];
    spell->m_misc.Raw.Data[1] = packet.Cast.Misc[1];
    spell->m_castFlagsEx |= CAST_FLAG_EX_USE_TOY_SPELL;
    spell->prepare(&targets);
}
