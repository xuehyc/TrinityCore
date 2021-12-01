/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "TokenPackets.h"

void WorldPackets::Token::UpdateListedAuctionableTokens::Read()
{
    _worldPacket >> UnkInt;
}

WorldPacket const* WorldPackets::Token::UpdateListedAuctionableTokensResponse::Write()
{
    _worldPacket << UnkInt;
    _worldPacket << Result;
    _worldPacket << uint32(AuctionableTokenAuctionableList.size());
    for (AuctionableTokenAuctionable const& auctionableTokenAuctionable : AuctionableTokenAuctionableList)
    {
        _worldPacket << auctionableTokenAuctionable.UnkInt1;
        _worldPacket << auctionableTokenAuctionable.UnkInt2;
        _worldPacket << auctionableTokenAuctionable.Owner;
        _worldPacket << auctionableTokenAuctionable.BuyoutPrice;
        _worldPacket << auctionableTokenAuctionable.EndTime;
    }

    return &_worldPacket;
}

void WorldPackets::Token::RequestWowTokenMarketPrice::Read()
{
    _worldPacket >> UnkInt;
}

WorldPacket const* WorldPackets::Token::WowTokenMarketPriceResponse::Write()
{
    _worldPacket << CurrentMarketPrice;
    _worldPacket << UnkInt;
    _worldPacket << Result;
    _worldPacket << UnkInt2;

    return &_worldPacket;
}
