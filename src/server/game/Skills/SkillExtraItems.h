/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_SKILL_EXTRA_ITEMS_H
#define SERVER_SKILL_EXTRA_ITEMS_H

#include "Common.h"

// predef classes used in functions
class Player;

// returns true and sets the appropriate info if the player can create a perfect item with the given spellId
GAME_API bool CanCreatePerfectItem(Player* player, uint32 spellId, float &perfectCreateChance, uint32 &perfectItemType);
// load perfection proc info from DB
GAME_API void LoadSkillPerfectItemTable();
// returns true and sets the appropriate info if the player can create extra items with the given spellId
GAME_API bool CanCreateExtraItems(Player* player, uint32 spellId, float &additionalChance, uint8 &additionalMax);
// function to load the extra item creation info from DB
GAME_API void LoadSkillExtraItemTable();

#endif
