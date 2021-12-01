/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef BLACK_MARKET_H
#define BLACK_MARKET_H

#include "SharedDefines.h"
#include "DatabaseEnvFwd.h"
#include "ObjectGuid.h"
#include "ItemPacketsCommon.h"
#include <unordered_map>

class Player;

namespace WorldPackets
{
    namespace BlackMarket
    {
        class BlackMarketRequestItemsResult;
    }
}

enum BlackMarketError : int32      // Extracted from client
{
    ERR_BMAH_OK = 0,
    ERR_BMAH_ITEM_NOT_FOUND = 1,
    ERR_BMAH_ALREADY_BID = 2,
    ERR_BMAH_HIGHER_BID = 4,
    ERR_BMAH_DATABASE_ERROR = 6,
    ERR_BMAH_NOT_ENOUGH_MONEY = 7,
    ERR_BMAH_RESTRICTED_ACCOUNT_TRIAL = 9
};

enum BMAHMailAuctionAnswers
{
    BMAH_AUCTION_OUTBID = 0,
    BMAH_AUCTION_WON = 1,
};

const static uint64 BMAH_MAX_BID = 1000000LL * GOLD;

struct BlackMarketTemplate
{
    int32 MarketID = 0;
    int32 SellerNPC = 0;
    int32 Quantity = 0;
    uint64 MinBid = UI64LIT(0);
    time_t Duration = time_t(0);
    float Chance = 0.0f;
    WorldPackets::Item::ItemInstance Item;

    // Helpers
    bool LoadFromDB(Field* fields);
};

class BlackMarketEntry
{
public:

    void Update(time_t newTimeOfUpdate);
    void Initialize(int32 marketId, uint32 duration)
    {
        _marketId = marketId;
        _secondsRemaining = duration;
    }

    BlackMarketTemplate const* GetTemplate() const;
    int32 GetMarketId() const { return _marketId; }

    uint64 GetCurrentBid() const { return _currentBid; }
    void SetCurrentBid(uint64 bid) { _currentBid = bid; }

    int32 GetNumBids() const { return _numBids; }
    void SetNumBids(int32 numBids) { _numBids = numBids; }

    ObjectGuid::LowType GetBidder() const { return _bidder; }
    void SetBidder(ObjectGuid::LowType bidder) { _bidder = bidder; }

    uint32 GetSecondsRemaining() const; // Get seconds remaining relative to now
    time_t GetExpirationTime() const;
    bool IsCompleted() const;

    void DeleteFromDB(CharacterDatabaseTransaction& trans) const;
    void SaveToDB(CharacterDatabaseTransaction& trans) const;
    bool LoadFromDB(Field* fields);

    uint64 GetMinIncrement() const { return (_currentBid / 20) - ((_currentBid / 20) % GOLD); } //5% increase every bid (has to be round gold value)
    bool ValidateBid(uint64 bid) const;
    void PlaceBid(uint64 bid, Player* player, CharacterDatabaseTransaction& trans);

    std::string BuildAuctionMailSubject(BMAHMailAuctionAnswers response) const;
    std::string BuildAuctionMailBody();

    void MailSent() { _mailSent = true; } // Set when mail has been sent
    bool GetMailSent() const { return _mailSent; }

private:
    int32 _marketId = 0;
    uint64 _currentBid = 0;
    int32 _numBids = 0;
    ObjectGuid::LowType _bidder = 0;
    uint32 _secondsRemaining = 0;
    bool _mailSent = false;
};

class GAME_API BlackMarketMgr
{
  private:
    BlackMarketMgr();
    ~BlackMarketMgr();

  public:
    static BlackMarketMgr* Instance();

    typedef std::unordered_map<int32, BlackMarketEntry*> BlackMarketEntryMap;
    typedef std::unordered_map<int32, BlackMarketTemplate const*> BlackMarketTemplateMap;

    // Load templates first
    void LoadTemplates();
    void LoadAuctions();

    void Update(bool updateTime = false);
    void RefreshAuctions();
    time_t GetLastUpdate() const { return _lastUpdate; }

    bool IsEnabled() const;

    void BuildItemsResponse(WorldPackets::BlackMarket::BlackMarketRequestItemsResult& packet, Player* player);

    BlackMarketEntry* GetAuctionByID(int32 marketId) const;
    BlackMarketTemplate const* GetTemplateByID(int32 marketId) const;

    void AddAuction(BlackMarketEntry* auction);
    void AddTemplate(BlackMarketTemplate* templ);

    void SendAuctionWonMail(BlackMarketEntry* entry, CharacterDatabaseTransaction& trans);
    void SendAuctionOutbidMail(BlackMarketEntry* entry, CharacterDatabaseTransaction& trans); // Call before incrementing bid

  private:
      BlackMarketEntryMap _auctions;
      BlackMarketTemplateMap _templates;
      time_t _lastUpdate = time_t(0);
};

#define sBlackMarketMgr BlackMarketMgr::Instance()

#endif
