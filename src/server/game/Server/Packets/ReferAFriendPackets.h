/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ReferAFriendPackets_h__
#define ReferAFriendPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"

namespace WorldPackets
{
    namespace RaF
    {
        class AcceptLevelGrant final : public ClientPacket
        {
        public:
            AcceptLevelGrant(WorldPacket&& packet) : ClientPacket(CMSG_ACCEPT_LEVEL_GRANT, std::move(packet)) { }

            void Read() override;

            ObjectGuid Granter;
        };

        class GrantLevel final : public ClientPacket
        {
        public:
            GrantLevel(WorldPacket&& packet) : ClientPacket(CMSG_GRANT_LEVEL, std::move(packet)) { }

            void Read() override;

            ObjectGuid Target;
        };

        class ProposeLevelGrant final : public ServerPacket
        {
        public:
            ProposeLevelGrant() : ServerPacket(SMSG_PROPOSE_LEVEL_GRANT, 16) { }

            WorldPacket const* Write() override;

            ObjectGuid Sender;
        };

        class ReferAFriendFailure final : public ServerPacket
        {
        public:
            ReferAFriendFailure() : ServerPacket(SMSG_REFER_A_FRIEND_FAILURE, 1 + 4) { }

            WorldPacket const* Write() override;

            std::string Str;
            int32 Reason = 0;
        };
    }
}

#endif // ReferAFriendPackets_h__
