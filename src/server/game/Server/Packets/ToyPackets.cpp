/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ToyPackets.h"

void WorldPackets::Toy::AddToy::Read()
{
    _worldPacket >> Guid;
}

void WorldPackets::Toy::UseToy::Read()
{
    _worldPacket >> Cast;
}

WorldPacket const* WorldPackets::Toy::AccountToysUpdate::Write()
{
    _worldPacket.WriteBit(IsFullUpdate);
    _worldPacket.FlushBits();

    // both lists have to have the same size
    _worldPacket << int32(Toys->size());
    _worldPacket << int32(Toys->size());

    for (auto const& item : *Toys)
        _worldPacket << uint32(item.first);

    for (auto const& favourite : *Toys)
        _worldPacket.WriteBit(favourite.second);

    _worldPacket.FlushBits();

    return &_worldPacket;
}
