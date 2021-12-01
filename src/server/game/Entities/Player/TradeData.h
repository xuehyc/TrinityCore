/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef TradeData_h__
#define TradeData_h__

#include "ObjectGuid.h"

enum TradeSlots
{
    TRADE_SLOT_COUNT          = 7,
    TRADE_SLOT_TRADED_COUNT   = 6,
    TRADE_SLOT_NONTRADED      = 6,
    TRADE_SLOT_INVALID        = -1
};

class Item;
class Player;

class GAME_API TradeData
{
public:
    TradeData(Player* player, Player* trader) :
        _player(player), _trader(trader), _accepted(false), _acceptProccess(false),
        _money(0), _spell(0), _spellCastItem(), _clientStateIndex(1), _serverStateIndex(1) { }

    Player* GetTrader() const { return _trader; }
    TradeData* GetTraderData() const;

    Item* GetItem(TradeSlots slot) const;
    bool HasItem(ObjectGuid itemGuid) const;
    TradeSlots GetTradeSlotForItem(ObjectGuid itemGuid) const;
    void SetItem(TradeSlots slot, Item* item, bool update = false);

    uint32 GetSpell() const { return _spell; }
    void SetSpell(uint32 spell_id, Item* castItem = nullptr);

    Item*  GetSpellCastItem() const;
    bool HasSpellCastItem() const { return !_spellCastItem.IsEmpty(); }

    uint64 GetMoney() const { return _money; }
    void SetMoney(uint64 money);

    bool IsAccepted() const { return _accepted; }
    void SetAccepted(bool state, bool forTrader = false);

    bool IsInAcceptProcess() const { return _acceptProccess; }
    void SetInAcceptProcess(bool state) { _acceptProccess = state; }

    uint32 GetClientStateIndex() const { return _clientStateIndex; }
    void UpdateClientStateIndex() { ++_clientStateIndex; }

    uint32 GetServerStateIndex() const { return _serverStateIndex; }
    void UpdateServerStateIndex();

private:
    void Update(bool for_trader = true) const;

    Player*    _player;                                // Player who own of this TradeData
    Player*    _trader;                                // Player who trade with _player

    bool       _accepted;                              // _player press accept for trade list
    bool       _acceptProccess;                        // one from player/trader press accept and this processed

    uint64     _money;                                 // _player place money to trade

    uint32     _spell;                                 // _player apply spell to non-traded slot item
    ObjectGuid _spellCastItem;                         // applied spell cast by item use

    ObjectGuid _items[TRADE_SLOT_COUNT];               // traded items from _player side including non-traded slot

    uint32     _clientStateIndex;
    uint32     _serverStateIndex;
};

#endif // TradeData_h__
