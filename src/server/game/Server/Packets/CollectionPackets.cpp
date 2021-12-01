/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "CollectionPackets.h"

void WorldPackets::Collections::CollectionItemSetFavorite::Read()
{
    Type = _worldPacket.read<CollectionType>();
    ID = _worldPacket.read<uint32>();
    IsFavorite = _worldPacket.ReadBit();
}
