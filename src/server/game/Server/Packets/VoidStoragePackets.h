/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef VoidStoragePackets_h__
#define VoidStoragePackets_h__

#include "Packet.h"
#include "ItemPacketsCommon.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"

namespace WorldPackets
{
    namespace VoidStorage
    {
        class VoidTransferResult final : public ServerPacket
        {
        public:
            VoidTransferResult(int32 result) : ServerPacket(SMSG_VOID_TRANSFER_RESULT, 4), Result(result) { }

            WorldPacket const* Write() override;

            int32 Result;
        };

        class UnlockVoidStorage final : public ClientPacket
        {
        public:
            UnlockVoidStorage(WorldPacket&& packet) : ClientPacket(CMSG_UNLOCK_VOID_STORAGE, std::move(packet)) { }

            void Read() override;

            ObjectGuid Npc;
        };

        class QueryVoidStorage final : public ClientPacket
        {
        public:
            QueryVoidStorage(WorldPacket&& packet) : ClientPacket(CMSG_QUERY_VOID_STORAGE, std::move(packet)) { }

            void Read() override;

            ObjectGuid Npc;
        };

        class VoidStorageFailed final : public ServerPacket
        {
        public:
            VoidStorageFailed() : ServerPacket(SMSG_VOID_STORAGE_FAILED, 1) { }

            WorldPacket const* Write() override;

            uint8 Reason = 0;
        };

        struct VoidItem
        {
            ObjectGuid Guid;
            ObjectGuid Creator;
            uint32 Slot = 0;
            WorldPackets::Item::ItemInstance Item;
        };

        class VoidStorageContents final : public ServerPacket
        {
        public:
            VoidStorageContents() : ServerPacket(SMSG_VOID_STORAGE_CONTENTS, 0) { }

            WorldPacket const* Write() override;

            std::vector<VoidItem> Items;
        };

        class VoidStorageTransfer final : public ClientPacket
        {
        public:
            VoidStorageTransfer(WorldPacket&& packet) : ClientPacket(CMSG_VOID_STORAGE_TRANSFER, std::move(packet)) { }

            void Read() override;

            Array<ObjectGuid, VOID_STORAGE_MAX_WITHDRAW> Withdrawals;
            Array<ObjectGuid, VOID_STORAGE_MAX_DEPOSIT> Deposits;
            ObjectGuid Npc;
        };

        class VoidStorageTransferChanges final : public ServerPacket
        {
        public:
            VoidStorageTransferChanges() : ServerPacket(SMSG_VOID_STORAGE_TRANSFER_CHANGES, 0) { }

            WorldPacket const* Write() override;

            std::vector<ObjectGuid> RemovedItems;
            std::vector<VoidItem> AddedItems;
        };

        class SwapVoidItem final : public ClientPacket
        {
        public:
            SwapVoidItem(WorldPacket&& packet) : ClientPacket(CMSG_SWAP_VOID_ITEM, std::move(packet)) { }

            void Read() override;

            ObjectGuid Npc;
            ObjectGuid VoidItemGuid;
            uint32 DstSlot = 0;
        };

        class VoidItemSwapResponse final : public ServerPacket
        {
        public:
            VoidItemSwapResponse() : ServerPacket(SMSG_VOID_ITEM_SWAP_RESPONSE, 16 + 16 + 4 + 4) { }

            WorldPacket const* Write() override;

            ObjectGuid VoidItemA;
            ObjectGuid VoidItemB;
            uint32 VoidItemSlotA = 0;
            uint32 VoidItemSlotB = 0;
        };
    }
}

#endif // VoidStoragePackets_h__
