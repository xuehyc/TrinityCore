/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CollectionPackets_h__
#define CollectionPackets_h__

#include "Packet.h"

namespace WorldPackets
{
    namespace Collections
    {
        enum CollectionType : int32
        {
            NONE            = -1,
            TOYBOX          = 1,
            APPEARANCE      = 3,
            TRANSMOG_SET    = 4
        };

        class CollectionItemSetFavorite final : public ClientPacket
        {
        public:
            CollectionItemSetFavorite(WorldPacket&& packet) : ClientPacket(CMSG_COLLECTION_ITEM_SET_FAVORITE, std::move(packet)) { }

            void Read() override;

            CollectionType Type = NONE;
            uint32 ID = 0;
            bool IsFavorite = false;
        };
    }
}

#endif // CollectionPackets_h__
