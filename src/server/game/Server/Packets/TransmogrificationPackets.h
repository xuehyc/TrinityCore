/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef TransmogrificationPackets_h__
#define TransmogrificationPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include "PacketUtilities.h"

namespace WorldPackets
{
    namespace Transmogrification
    {
        struct TransmogrifyItem
        {
            int32 ItemModifiedAppearanceID = 0;
            uint32 Slot = 0;
            int32 SpellItemEnchantmentID = 0;
        };

        class TransmogrifyItems final : public ClientPacket
        {
        public:
            enum
            {
                MAX_TRANSMOGRIFY_ITEMS = 13
            };

            TransmogrifyItems(WorldPacket&& packet) : ClientPacket(CMSG_TRANSMOGRIFY_ITEMS, std::move(packet)) { }

            void Read() override;

            ObjectGuid Npc;
            Array<TransmogrifyItem, MAX_TRANSMOGRIFY_ITEMS> Items;
            bool CurrentSpecOnly = false;
        };

        class TransmogCollectionUpdate final : public ServerPacket
        {
        public:
            TransmogCollectionUpdate() : ServerPacket(SMSG_TRANSMOG_COLLECTION_UPDATE) { }

            WorldPacket const* Write() override;

            bool IsFullUpdate = false;
            bool IsSetFavorite = false;
            std::vector<uint32> FavoriteAppearances;
        };

        class OpenTransmogrifier final : public ServerPacket
        {
        public:
            OpenTransmogrifier(ObjectGuid const& guid) : ServerPacket(SMSG_OPEN_TRANSMOGRIFIER, 16), Guid(guid) { }

            WorldPacket const* Write() override;

            ObjectGuid Guid;
        };
    }
}

#endif // TransmogrificationPackets_h__
