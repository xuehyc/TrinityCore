/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SocialPackets_h__
#define SocialPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"

struct FriendInfo;
enum FriendsResult : uint8;

namespace WorldPackets
{
    namespace Social
    {
        class SendContactList final : public ClientPacket
        {
        public:
            SendContactList(WorldPacket&& packet) : ClientPacket(CMSG_SEND_CONTACT_LIST, std::move(packet)) { }

            void Read() override;

            uint32 Flags = 0; ///< @see enum SocialFlag
        };

        struct ContactInfo
        {
            ContactInfo(ObjectGuid const& guid, FriendInfo const& friendInfo);

            ObjectGuid Guid;
            ObjectGuid WowAccountGuid;
            uint32 VirtualRealmAddr = 0;
            uint32 NativeRealmAddr  = 0;
            uint32 TypeFlags        = 0; ///< @see enum SocialFlag
            std::string Notes;
            uint8 Status            = 0; ///< @see enum FriendStatus
            uint32 AreaID           = 0;
            uint32 Level            = 0;
            uint32 ClassID          = CLASS_NONE;
        };

        class ContactList final : public ServerPacket
        {
        public:
            ContactList() : ServerPacket(SMSG_CONTACT_LIST, 8) { }

            WorldPacket const* Write() override;

            std::vector<ContactInfo> Contacts;
            uint32 Flags = 0; ///< @see enum SocialFlag
        };

        class FriendStatus final : public ServerPacket
        {
        public:
            FriendStatus() : ServerPacket(SMSG_FRIEND_STATUS, 38) { }

            void Initialize(ObjectGuid const& guid, FriendsResult result, FriendInfo const& friendInfo);

            WorldPacket const* Write() override;

            uint32 VirtualRealmAddress = 0;
            std::string Notes;
            uint32 ClassID             = CLASS_NONE;
            uint8 Status               = 0; ///< @see enum FriendStatus
            ObjectGuid Guid;
            ObjectGuid WowAccountGuid;
            uint32 Level               = 0;
            uint32 AreaID              = 0;
            uint8 FriendResult         = 0; ///< @see enum FriendsResult
        };

        struct QualifiedGUID
        {
            ObjectGuid Guid;
            uint32 VirtualRealmAddress = 0;
        };

        class AddFriend final : public ClientPacket
        {
        public:
            AddFriend(WorldPacket&& packet) : ClientPacket(CMSG_ADD_FRIEND, std::move(packet)) { }

            void Read() override;

            std::string Notes;
            std::string Name;
        };

        class DelFriend final : public ClientPacket
        {
        public:
            DelFriend(WorldPacket&& packet) : ClientPacket(CMSG_DEL_FRIEND, std::move(packet)) { }

            void Read() override;

            QualifiedGUID Player;
        };

        class SetContactNotes final : public ClientPacket
        {
        public:
            SetContactNotes(WorldPacket&& packet) : ClientPacket(CMSG_SET_CONTACT_NOTES, std::move(packet)) { }

            void Read() override;

            QualifiedGUID Player;
            std::string Notes;
        };

        class AddIgnore final : public ClientPacket
        {
        public:
            AddIgnore(WorldPacket&& packet) : ClientPacket(CMSG_ADD_IGNORE, std::move(packet)) { }

            void Read() override;

            std::string Name;
        };

        class DelIgnore final : public ClientPacket
        {
        public:
            DelIgnore(WorldPacket&& packet) : ClientPacket(CMSG_DEL_IGNORE, std::move(packet)) { }

            void Read() override;

            QualifiedGUID Player;
        };
    }
}

#endif // SocialPackets_h__
