/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef WardenPackets_h__
#define WardenPackets_h__

#include "Packet.h"

namespace WorldPackets
{
    namespace Warden
    {
        class WardenData final : public ClientPacket
        {
        public:
            WardenData(WorldPacket&& packet) : ClientPacket(CMSG_WARDEN_DATA, std::move(packet)) { }

            void Read() override;

            ByteBuffer Data;
        };
    }
}

#endif // WardenPackets_h__
