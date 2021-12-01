/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef BlackMarketPackets_h__
#define BlackMarketPackets_h__

#include "Packet.h"
#include "ItemPacketsCommon.h"
#include "ObjectGuid.h"

namespace WorldPackets
{
    namespace BlackMarket
    {
        struct BlackMarketItem
        {
            int32 MarketID = 0;
            int32 SellerNPC = 0;
            Item::ItemInstance Item;
            int32 Quantity = 0;
            uint64 MinBid = 0;
            uint64 MinIncrement = 0;
            uint64 CurrentBid = 0;
            int32 SecondsRemaining = 0;
            int32 NumBids = 0;
            bool HighBid = false;
        };

        class BlackMarketOpen final : public ClientPacket
        {
        public:
            BlackMarketOpen(WorldPacket&& packet) : ClientPacket(CMSG_BLACK_MARKET_OPEN, std::move(packet)) { }

            void Read() override;

            ObjectGuid Guid;
        };

        class BlackMarketOpenResult final : public ServerPacket
        {
        public:
            BlackMarketOpenResult() : ServerPacket(SMSG_BLACK_MARKET_OPEN_RESULT, 15) { }

            WorldPacket const* Write() override;

            ObjectGuid Guid;
            bool Enable = true;
        };

        class BlackMarketRequestItems final : public ClientPacket
        {
        public:
            BlackMarketRequestItems(WorldPacket&& packet) : ClientPacket(CMSG_BLACK_MARKET_REQUEST_ITEMS, std::move(packet)) { }

            void Read() override;

            ObjectGuid Guid;
            uint32 LastUpdateID = 0;
        };

        class BlackMarketRequestItemsResult final : public ServerPacket
        {
        public:
            BlackMarketRequestItemsResult() : ServerPacket(SMSG_BLACK_MARKET_REQUEST_ITEMS_RESULT, 4) { }

            WorldPacket const* Write() override;

            int32 LastUpdateID = 0;
            std::vector<BlackMarketItem> Items;
        };

        class BlackMarketBidOnItem final : public ClientPacket
        {
        public:
            BlackMarketBidOnItem(WorldPacket&& packet) : ClientPacket(CMSG_BLACK_MARKET_BID_ON_ITEM, std::move(packet)) { }

            void Read() override;

            ObjectGuid Guid;
            int32 MarketID = 0;
            Item::ItemInstance Item;
            uint64 BidAmount = 0;
        };

        class BlackMarketBidOnItemResult final : public ServerPacket
        {
        public:
            BlackMarketBidOnItemResult() : ServerPacket(SMSG_BLACK_MARKET_BID_ON_ITEM_RESULT, 4 + 76 + 4) { }

            WorldPacket const* Write() override;

            int32 MarketID = 0;
            Item::ItemInstance Item;
            int32 Result = 0;
        };

        class BlackMarketOutbid final : public ServerPacket
        {
        public:
            BlackMarketOutbid() : ServerPacket(SMSG_BLACK_MARKET_OUTBID, 4 + 76 + 4) { }

            WorldPacket const* Write() override;

            int32 MarketID = 0;
            Item::ItemInstance Item;
            int32 RandomPropertiesID = 0;
        };

        class BlackMarketWon final : public ServerPacket
        {
        public:
            BlackMarketWon() : ServerPacket(SMSG_BLACK_MARKET_WON, 4 + 76 + 4) { }

            WorldPacket const* Write() override;

            int32 MarketID = 0;
            Item::ItemInstance Item;
            int32 RandomPropertiesID = 0;
        };
    }
}

#endif // BlackMarketPackets_h__
