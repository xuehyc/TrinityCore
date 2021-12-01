/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "TransmogrificationPackets.h"

ByteBuffer& operator>>(ByteBuffer& data, WorldPackets::Transmogrification::TransmogrifyItem& transmogItem)
{
    data >> transmogItem.ItemModifiedAppearanceID;
    data >> transmogItem.Slot;
    data >> transmogItem.SpellItemEnchantmentID;

    return data;
}

void WorldPackets::Transmogrification::TransmogrifyItems::Read()
{
    Items.resize(_worldPacket.read<uint32>());
    _worldPacket >> Npc;
    for (TransmogrifyItem& item : Items)
        _worldPacket >> item;

    CurrentSpecOnly = _worldPacket.ReadBit();
}

WorldPacket const* WorldPackets::Transmogrification::TransmogCollectionUpdate::Write()
{
    _worldPacket.WriteBit(IsFullUpdate);
    _worldPacket.WriteBit(IsSetFavorite);
    _worldPacket << uint32(FavoriteAppearances.size());
    for (uint32 itemModifiedAppearanceId : FavoriteAppearances)
        _worldPacket << uint32(itemModifiedAppearanceId);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Transmogrification::OpenTransmogrifier::Write()
{
    _worldPacket << Guid;

    return &_worldPacket;
}
