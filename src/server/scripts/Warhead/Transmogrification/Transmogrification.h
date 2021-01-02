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

#ifndef _TRANSMOGRIFICATION_H_
#define _TRANSMOGRIFICATION_H_

#include "Common.h"
#include "ObjectGuid.h"
#include <map>
#include <set>
#include <unordered_map>
#include <vector>

#define MAX_OPTIONS 25 // do not alter

class Item;
class Player;
class Creature;
class WorldSession;
struct ItemTemplate;

class Transmogrification
{
    Transmogrification() = default;
    ~Transmogrification() = default;
    Transmogrification(const Transmogrification&);
    Transmogrification& operator=(const Transmogrification&);

public:
    static Transmogrification* instance();

    void Init();
    void LoadConfig(bool reload);

    void DeleteFakeFromDB(ObjectGuid::LowType itemGuid);
    void MirrorImageDisplayItem(const Item* item, uint32& display);
    void SetVisibleItemSlot(Player* player, uint8 slot, Item* item);
    void LoadPlayerSets(Player* player);
    void UnloadPlayerSets(Player* player);
    void ClearPlayerAtLogout(Player* player);
    void LoadPlayerAtLogin(Player* player);

    void OnPlayerDelete(ObjectGuid guid);

    // Gossip
    void OnGossipHello(Player* player, Creature* creature);
    void OnGossipSelect(Player* player, Creature* creature, uint32 const& action, uint32 const& sender);
    void OnGossipSelectCode(Player* player, Creature* creature, uint32 const& action, uint32 const& sender, const char* code);

private:
    // Use IsAllowed() and IsNotAllowed()
    // these are thread unsafe, but assumed to be static data so it should be safe
    std::set<uint32> Allowed;
    std::set<uint32> NotAllowed;

    bool CanTransmogSlot(uint8 slot) const;
    void PresetTransmog(Player* player, Item* itemTransmogrified, uint32 fakeEntry, uint8 slot);
    uint32 GetSpecialPrice(ItemTemplate const* proto) const;

    bool IsAllowed(uint32 entry) const;
    bool IsNotAllowed(uint32 entry) const;
    bool IsAllowedQuality(uint32 quality) const;
    bool IsRangedWeapon(uint32 Class, uint32 SubClass) const;

    std::string GetItemIcon(uint32 entry, uint32 width, uint32 height, int x, int y) const;
    std::string GetSlotIcon(uint8 slot, uint32 width, uint32 height, int x, int y) const;
    std::string const GetSlotName(Player* player, uint8 slot) const;
    std::string GetItemLink(Item* item, WorldSession* session) const;
    std::string GetItemLink(uint32 entry, WorldSession* session) const;
    void UpdateItem(Player* player, Item* item) const;
    void DeleteFakeEntry(Player* player, uint8 slot, Item* itemTransmogrified);
    void SetFakeEntry(Player* player, uint32 newEntry, uint8 slot, Item* itemTransmogrified);
    uint32 GetFakeEntry(ObjectGuid itemGUID) const;

    void Transmogrify(Player* player, ObjectGuid itemGUID, uint8 slot, bool no_cost = false);
    void SendNotification(Player* player, uint8 stringID);
    bool CanTransmogrifyItemWithItem(Player* player, ItemTemplate const* destination, ItemTemplate const* source) const;
    bool SuitableForTransmogrification(Player* player, ItemTemplate const* proto) const;
    //std::vector<ObjectGuid> GetItemList(const Player* player) const;

    std::string const GetGossipIcon(uint8 slot, Player* player);
    std::string const GetGossipItemName(Player* player, uint8 gossipItem);

    bool CanSavePresets(Player* player);
    void SavePreset(Player* player, std::string const& name);

    // Private gossips
    void GossipShowTransmogItems(Player* player, Creature* creature, uint8 slot);
    void GossipRemoveAllTransmogrifications(Player* player);
    void GossipRemoveSingleTransmogrifications(Player* player, uint32 const& action);
    void GossipShowPresetsMenu(Player* player, Creature* creature);
    void GossipUsePreset(Player* player, uint32 const& action);
    void GossipViewPreset(Player* player, Creature* creature, uint32 const& action, uint32 const& sender);
    void GossipDeletePreset(Player* player, uint32 const& action);
    void GossipSavePreset(Player* player, Creature* creature, uint32 const& action, uint32 const& sender);
    void GossipTransmogrify(Player* player, uint32 const& action, uint32 const& sender);

    using TransmogrificationDataContainer = std::unordered_map<ObjectGuid::LowType, ObjectGuid::LowType>;
    using TransmogrificationMapContainer = std::unordered_map<ObjectGuid::LowType, TransmogrificationDataContainer>;
    using SlotsContainer = std::map<uint8, uint32>;
    using PresetsContainer = std::map<uint8, SlotsContainer>;
    using PresetsDataMapContainer = std::unordered_map<ObjectGuid, PresetsContainer>;
    using PresetsIdMapContainer = std::map<uint8, std::string>;
    using PresetsNameMapContainer = std::unordered_map<ObjectGuid, PresetsIdMapContainer>;

    PresetsNameMapContainer _presetByName; // _presetByName[pGUID][presetID] = presetName
    PresetsDataMapContainer _presetById; // _presetById[pGUID][presetID][slot] = entry
    TransmogrificationMapContainer _mapStore;
    TransmogrificationDataContainer _dataMapStore;
};

#define sTransmog Transmogrification::instance()

#endif // _TRANSMOGRIFICATION_H_
