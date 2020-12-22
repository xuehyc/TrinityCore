/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AuctionHouseMgr.h"
#include "Player.h"
#include "Language.h"
#include "Log.h"

// Auction info
void Player::CalculateAuctionLotsCounter()
{
    uint32 count = 0;
    if (AuctionHouseObject * AllianceauctionHouse = sAuctionMgr->GetAuctionsMapByHouseId(AUCTIONHOUSE_ALLIANCE))
        AllianceauctionHouse->BuildListAllLots(this, count);

    if (AuctionHouseObject * AllianceauctionHouse = sAuctionMgr->GetAuctionsMapByHouseId(AUCTIONHOUSE_HORDE))
        AllianceauctionHouse->BuildListAllLots(this, count);

    if (AuctionHouseObject * AllianceauctionHouse = sAuctionMgr->GetAuctionsMapByHouseId(AUCTIONHOUSE_NEUTRAL))
        AllianceauctionHouse->BuildListAllLots(this, count);

    LOG_DEBUG("chatmessage", "Player: CalculateAuctionLotsCounter - Player (%s) has %u lots in all auctions", GetName().c_str(), count);
    m_auctionlots = count;
}
