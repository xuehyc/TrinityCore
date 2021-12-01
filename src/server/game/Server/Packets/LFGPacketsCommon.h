/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef LFGPacketsCommon_h__
#define LFGPacketsCommon_h__

#include "Packet.h"
#include "ObjectGuid.h"

namespace WorldPackets
{
    namespace LFG
    {
        enum class RideType : uint32
        {
            None = 0,
            Battlegrounds = 1,
            Lfg = 2
        };

        struct RideTicket
        {
            ObjectGuid RequesterGuid;
            uint32 Id = 0;
            RideType Type = RideType::None;
            int32 Time = 0;
        };
    }
}

ByteBuffer& operator>>(ByteBuffer& data, WorldPackets::LFG::RideTicket& ticket);
ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::LFG::RideTicket const& ticket);

#endif // LFGPacketsCommon_h__
