/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef TokenPackets_h__
#define TokenPackets_h__

#include "Packet.h"

namespace WorldPackets
{
    namespace Token
    {
        class UpdateListedAuctionableTokens final : public ClientPacket
        {
        public:
            UpdateListedAuctionableTokens(WorldPacket&& packet) : ClientPacket(CMSG_UPDATE_WOW_TOKEN_AUCTIONABLE_LIST, std::move(packet)) { }

            void Read() override;

            uint32 UnkInt   = 0;
        };

        class UpdateListedAuctionableTokensResponse final : public ServerPacket
        {
        public:
            UpdateListedAuctionableTokensResponse() : ServerPacket(SMSG_WOW_TOKEN_UPDATE_AUCTIONABLE_LIST_RESPONSE, 12) { }

            WorldPacket const* Write() override;

            struct AuctionableTokenAuctionable
            {
                uint64 UnkInt1      = 0;
                uint32 UnkInt2      = 0;
                uint32 Owner        = 0;
                uint64 BuyoutPrice  = 0;
                uint32 EndTime      = 0;
            };

            uint32 UnkInt           = 0; // send CMSG_UPDATE_WOW_TOKEN_AUCTIONABLE_LIST
            uint32 Result           = 0;
            std::vector<AuctionableTokenAuctionable> AuctionableTokenAuctionableList;
        };

        class RequestWowTokenMarketPrice final : public ClientPacket
        {
        public:
            RequestWowTokenMarketPrice(WorldPacket&& packet) : ClientPacket(CMSG_REQUEST_WOW_TOKEN_MARKET_PRICE, std::move(packet)) { }

            void Read() override;

            uint32 UnkInt = 0;
        };

        class WowTokenMarketPriceResponse final : public ServerPacket
        {
        public:
            WowTokenMarketPriceResponse() : ServerPacket(SMSG_WOW_TOKEN_MARKET_PRICE_RESPONSE, 20) { }

            WorldPacket const* Write() override;

            uint64 CurrentMarketPrice   = 0;
            uint32 UnkInt               = 0; // send CMSG_REQUEST_WOW_TOKEN_MARKET_PRICE
            uint32 Result               = 0;
            uint32 UnkInt2              = 0;
        };
    }
}

#endif // TokenPackets_h__
