/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "VoidStoragePackets.h"
#include "SharedDefines.h"

WorldPacket const* WorldPackets::VoidStorage::VoidTransferResult::Write()
{
    _worldPacket << int32(Result);
    return &_worldPacket;
}

void WorldPackets::VoidStorage::UnlockVoidStorage::Read()
{
    _worldPacket >> Npc;
}

void WorldPackets::VoidStorage::QueryVoidStorage::Read()
{
    _worldPacket >> Npc;
}

WorldPacket const* WorldPackets::VoidStorage::VoidStorageFailed::Write()
{
    _worldPacket << uint8(Reason);
    return &_worldPacket;
}

ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::VoidStorage::VoidItem const& voidItem)
{
    data << voidItem.Guid;
    data << voidItem.Creator;
    data << uint32(voidItem.Slot);
    data << voidItem.Item;
    return data;
}

WorldPacket const* WorldPackets::VoidStorage::VoidStorageContents::Write()
{
    _worldPacket.reserve(1 + Items.size() * sizeof(VoidItem));

    _worldPacket.WriteBits(Items.size(), 8);
    _worldPacket.FlushBits();

    for (VoidItem const& voidItem : Items)
        _worldPacket << voidItem;

    return &_worldPacket;
}

void WorldPackets::VoidStorage::VoidStorageTransfer::Read()
{
    _worldPacket >> Npc;
    Deposits.resize(_worldPacket.read<uint32>());
    Withdrawals.resize(_worldPacket.read<uint32>());

    for (ObjectGuid& deposit : Deposits)
        _worldPacket >> deposit;

    for (ObjectGuid& withdrawal : Withdrawals)
        _worldPacket >> withdrawal;
}

WorldPacket const* WorldPackets::VoidStorage::VoidStorageTransferChanges::Write()
{
    _worldPacket.reserve(1 + AddedItems.size() * sizeof(VoidItem) + RemovedItems.size() * 16);

    _worldPacket.WriteBits(AddedItems.size(), 4);
    _worldPacket.WriteBits(RemovedItems.size(), 4);
    _worldPacket.FlushBits();

    for (VoidItem const& addedItem : AddedItems)
        _worldPacket << addedItem;

    for (ObjectGuid const& removedItem : RemovedItems)
        _worldPacket << removedItem;

    return &_worldPacket;
}

void WorldPackets::VoidStorage::SwapVoidItem::Read()
{
    _worldPacket >> Npc;
    _worldPacket >> VoidItemGuid;
    _worldPacket >> DstSlot;
}

WorldPacket const* WorldPackets::VoidStorage::VoidItemSwapResponse::Write()
{
    _worldPacket << VoidItemA << uint32(VoidItemSlotA);
    _worldPacket << VoidItemB << uint32(VoidItemSlotB);
    return &_worldPacket;
}
