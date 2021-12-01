/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _ITEM_ENCHANTMENT_MGR_H
#define _ITEM_ENCHANTMENT_MGR_H

#include "Common.h"

enum class ItemRandomEnchantmentType : uint8
{
    Property    = 0,
    Suffix      = 1,
    BonusList   = 2
};

struct ItemRandomEnchantmentId
{
    ItemRandomEnchantmentId() = default;
    ItemRandomEnchantmentId(ItemRandomEnchantmentType type, uint32 id) : Type(type), Id(id) { }

    ItemRandomEnchantmentType Type = ItemRandomEnchantmentType::Property;
    uint32 Id = 0;
};

GAME_API void LoadRandomEnchantmentsTable();
GAME_API ItemRandomEnchantmentId GenerateItemRandomPropertyId(uint32 item_id);
GAME_API uint32 GenerateEnchSuffixFactor(uint32 item_id);
GAME_API uint32 GetRandomPropertyPoints(uint32 itemLevel, uint32 quality, uint32 inventoryType, uint32 subclass);

#endif
