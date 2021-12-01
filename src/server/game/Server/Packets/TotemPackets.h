/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef TotemPackets_h__
#define TotemPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"

namespace WorldPackets
{
    namespace Totem
    {
        class TotemDestroyed final : public ClientPacket
        {
        public:
            TotemDestroyed(WorldPacket&& packet) : ClientPacket(CMSG_TOTEM_DESTROYED, std::move(packet)) { }

            void Read() override;

            ObjectGuid TotemGUID;
            uint8 Slot = 0;
        };

        class TotemCreated final : public ServerPacket
        {
        public:
            TotemCreated() : ServerPacket(SMSG_TOTEM_CREATED, 25) { }

            WorldPacket const* Write() override;

            ObjectGuid Totem;
            int32 SpellID = 0;
            int32 Duration = 0;
            int8 Slot = 0;
            float TimeMod = 1.0f;
            bool CannotDismiss = false;
        };

        class TotemMoved final : public ServerPacket
        {
        public:
            TotemMoved() : ServerPacket(SMSG_TOTEM_MOVED, 18) { }

            WorldPacket const* Write() override;

            ObjectGuid Totem;
            uint8 Slot = 0;
            uint8 NewSlot = 0;
        };
    }
}

#endif // TotemPackets_h__
