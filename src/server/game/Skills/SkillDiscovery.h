/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_SKILLDISCOVERY_H
#define SERVER_SKILLDISCOVERY_H

#include "Common.h"

class Player;

GAME_API void LoadSkillDiscoveryTable();
GAME_API uint32 GetSkillDiscoverySpell(uint32 skillId, uint32 spellId, Player* player);
GAME_API bool HasDiscoveredAllSpells(uint32 spellId, Player* player);
GAME_API uint32 GetExplicitDiscoverySpell(uint32 spellId, Player* player);

#endif
