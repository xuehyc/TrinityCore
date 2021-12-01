/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WardenPackets.h"

void WorldPackets::Warden::WardenData::Read()
{
    uint32 size = _worldPacket.read<uint32>();

    if (size)
    {
        Data.resize(size);
        _worldPacket.read(Data.contents(), size);
    }
}
