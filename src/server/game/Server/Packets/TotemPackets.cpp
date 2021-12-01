/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "TotemPackets.h"

void WorldPackets::Totem::TotemDestroyed::Read()
{
    _worldPacket >> Slot;
    _worldPacket >> TotemGUID;
}

WorldPacket const* WorldPackets::Totem::TotemCreated::Write()
{
    _worldPacket << Slot;
    _worldPacket << Totem;
    _worldPacket << int32(Duration);
    _worldPacket << int32(SpellID);
    _worldPacket << float(TimeMod);
    _worldPacket.WriteBit(CannotDismiss);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Totem::TotemMoved::Write()
{
    _worldPacket << uint8(Slot);
    _worldPacket << uint8(NewSlot);
    _worldPacket << Totem;

    return &_worldPacket;
}
