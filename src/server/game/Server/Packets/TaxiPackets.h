/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef TaxiPackets_h__
#define TaxiPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include "DBCEnums.h"
#include "Optional.h"

namespace WorldPackets
{
    namespace Taxi
    {
        class TaxiNodeStatusQuery final : public ClientPacket
        {
        public:
            TaxiNodeStatusQuery(WorldPacket&& packet) : ClientPacket(CMSG_TAXI_NODE_STATUS_QUERY, std::move(packet)) { }

            void Read() override;

            ObjectGuid UnitGUID;
        };

        class TaxiNodeStatus final : public ServerPacket
        {
        public:
            TaxiNodeStatus() : ServerPacket(SMSG_TAXI_NODE_STATUS, 16 + 1) { }

            WorldPacket const* Write() override;

            uint8 Status = 0; // replace with TaxiStatus enum
            ObjectGuid Unit;
        };

        struct ShowTaxiNodesWindowInfo
        {
            ObjectGuid UnitGUID;
            int32 CurrentNode = 0;
        };

        class ShowTaxiNodes final : public ServerPacket
        {
        public:
            ShowTaxiNodes() : ServerPacket(SMSG_SHOW_TAXI_NODES) { }

            WorldPacket const* Write() override;

            Optional<ShowTaxiNodesWindowInfo> WindowInfo;
            TaxiMask const* CanLandNodes = nullptr; // Nodes known by player
            TaxiMask const* CanUseNodes = nullptr;  // Nodes available for use - this can temporarily disable a known node
        };

        class EnableTaxiNode final : public ClientPacket
        {
        public:
            EnableTaxiNode(WorldPacket&& packet) : ClientPacket(CMSG_ENABLE_TAXI_NODE, std::move(packet)) { }

            void Read() override;

            ObjectGuid Unit;
        };

        class TaxiQueryAvailableNodes final : public ClientPacket
        {
        public:
            TaxiQueryAvailableNodes(WorldPacket&& packet) : ClientPacket(CMSG_TAXI_QUERY_AVAILABLE_NODES, std::move(packet)) { }

            void Read() override;

            ObjectGuid Unit;
        };

        class ActivateTaxi final : public ClientPacket
        {
        public:
            ActivateTaxi(WorldPacket&& packet) : ClientPacket(CMSG_ACTIVATE_TAXI, std::move(packet)) { }

            void Read() override;

            ObjectGuid Vendor;
            uint32 Node = 0;
            uint32 GroundMountID = 0;
            uint32 FlyingMountID = 0;
        };

        class NewTaxiPath final : public ServerPacket
        {
        public:
            NewTaxiPath() : ServerPacket(SMSG_NEW_TAXI_PATH, 0) { }

            WorldPacket const* Write() override { return &_worldPacket; }
        };

        class ActivateTaxiReply final : public ServerPacket
        {
        public:
            ActivateTaxiReply() : ServerPacket(SMSG_ACTIVATE_TAXI_REPLY, 4) { }

            WorldPacket const* Write() override;

            uint8 Reply = 0;
        };

        class TaxiRequestEarlyLanding final : public ClientPacket
        {
        public:
            TaxiRequestEarlyLanding(WorldPacket&& packet) : ClientPacket(CMSG_TAXI_REQUEST_EARLY_LANDING, std::move(packet)) { }

            void Read() override { }
        };
    }
}

#endif // TaxiPackets_h__
