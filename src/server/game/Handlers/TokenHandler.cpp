/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "TokenPackets.h"
#include "WorldSession.h"

void WorldSession::HandleUpdateListedAuctionableTokens(WorldPackets::Token::UpdateListedAuctionableTokens& updateListedAuctionableTokens)
{
    WorldPackets::Token::UpdateListedAuctionableTokensResponse response;

    /// @todo: 6.x fix implementation
    response.UnkInt = updateListedAuctionableTokens.UnkInt;
    response.Result = TOKEN_RESULT_SUCCESS;

    SendPacket(response.Write());
}

void WorldSession::HandleRequestWowTokenMarketPrice(WorldPackets::Token::RequestWowTokenMarketPrice& requestWowTokenMarketPrice)
{
    WorldPackets::Token::WowTokenMarketPriceResponse response;

    /// @todo: 6.x fix implementation
    response.CurrentMarketPrice = 300000000;
    response.UnkInt = requestWowTokenMarketPrice.UnkInt;
    response.Result = TOKEN_RESULT_SUCCESS;
    //packet.ReadUInt32("UnkInt32");

    SendPacket(response.Write());
}
