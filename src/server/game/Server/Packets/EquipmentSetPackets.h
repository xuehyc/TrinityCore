/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#pragma once

#include "Packet.h"
#include "EquipementSet.h"
#include "ItemPacketsCommon.h"

namespace WorldPackets
{
    namespace EquipmentSet
    {
        class EquipmentSetID final : public ServerPacket
        {
        public:
            EquipmentSetID() : ServerPacket(SMSG_EQUIPMENT_SET_ID, 8 + 4) { }

            WorldPacket const* Write() override;

            uint64 GUID  = 0; ///< Set Identifier
            int32 Type = 0;
            uint32 SetID = 0; ///< Index
        };

        class LoadEquipmentSet final : public ServerPacket
        {
        public:
            LoadEquipmentSet() : ServerPacket(SMSG_LOAD_EQUIPMENT_SET, 4) { }

            WorldPacket const* Write() override;

            std::vector<EquipmentSetInfo::EquipmentSetData const*> SetData;
        };

        class SaveEquipmentSet final : public ClientPacket
        {
        public:
            SaveEquipmentSet(WorldPacket&& packet) : ClientPacket(CMSG_SAVE_EQUIPMENT_SET, std::move(packet)) { }

            void Read() override;

            EquipmentSetInfo::EquipmentSetData Set;
        };

        class DeleteEquipmentSet final : public ClientPacket
        {
        public:
            DeleteEquipmentSet(WorldPacket&& packet) : ClientPacket(CMSG_DELETE_EQUIPMENT_SET, std::move(packet)) { }

            void Read() override;

            uint64 ID = 0;
        };

        class UseEquipmentSet final : public ClientPacket
        {
        public:
            UseEquipmentSet(WorldPacket&& packet) : ClientPacket(CMSG_USE_EQUIPMENT_SET, std::move(packet)) { }

            void Read() override;

            struct EquipmentSetItem
            {
                ObjectGuid Item;
                uint8 ContainerSlot     = 0;
                uint8 Slot              = 0;
            };

            WorldPackets::Item::InvUpdate Inv;
            EquipmentSetItem Items[EQUIPEMENT_SET_SLOTS];
            uint64 GUID = 0; ///< Set Identifier
        };

        class UseEquipmentSetResult final : public ServerPacket
        {
        public:
            UseEquipmentSetResult() : ServerPacket(SMSG_USE_EQUIPMENT_SET_RESULT, 1) { }

            WorldPacket const* Write() override;

            uint64 GUID = 0; ///< Set Identifier
            uint8 Reason = 0;
        };
    }
}
