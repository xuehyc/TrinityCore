/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef HotfixPackets_h__
#define HotfixPackets_h__

#include "Packet.h"
#include "Common.h"
#include "DB2Stores.h"
#include "ObjectGuid.h"
#include "Optional.h"

namespace WorldPackets
{
    namespace Hotfix
    {
        class DBQueryBulk final : public ClientPacket
        {
        public:
            struct DBQueryRecord
            {
                ObjectGuid GUID;
                uint32 RecordID = 0;
            };

            DBQueryBulk(WorldPacket&& packet) : ClientPacket(CMSG_DB_QUERY_BULK, std::move(packet)) { }

            void Read() override;

            uint32 TableHash = 0;
            std::vector<DBQueryRecord> Queries;
        };

        class DBReply final : public ServerPacket
        {
        public:
            DBReply() : ServerPacket(SMSG_DB_REPLY, 12) { }

            WorldPacket const* Write() override;

            uint32 TableHash = 0;
            uint32 Timestamp = 0;
            uint32 RecordID = 0;
            bool Allow = false;
            ByteBuffer Data;
        };

        class AvailableHotfixes final : public ServerPacket
        {
        public:
            AvailableHotfixes(int32 hotfixCacheVersion, std::map<uint64, int32> const& hotfixes)
                : ServerPacket(SMSG_AVAILABLE_HOTFIXES), HotfixCacheVersion(hotfixCacheVersion), Hotfixes(hotfixes) { }

            WorldPacket const* Write() override;

            int32 HotfixCacheVersion;
            std::map<uint64, int32> const& Hotfixes;
        };

        class HotfixRequest final : public ClientPacket
        {
        public:
            HotfixRequest(WorldPacket&& packet) : ClientPacket(CMSG_HOTFIX_REQUEST, std::move(packet)) { }

            void Read() override;

            std::vector<uint64> Hotfixes;
        };

        class HotfixResponse final : public ServerPacket
        {
        public:
            struct HotfixData
            {
                uint64 ID = 0;
                int32 RecordID = 0;
                Optional<ByteBuffer> Data;
            };

            HotfixResponse() : ServerPacket(SMSG_HOTFIX_RESPONSE) { }

            WorldPacket const* Write() override;

            std::vector<HotfixData> Hotfixes;
        };
    }
}

#endif // HotfixPackets_h__
