/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptedGossip.h"
#include "Creature.h"
#include "Player.h"

void ClearGossipMenuFor(Player* player) { player->PlayerTalkClass->ClearMenus(); }
// Using provided text, not from DB
void AddGossipItemFor(Player* player, uint32 icon, std::string const& text, uint32 sender, uint32 action) { player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, icon, text, sender, action, "", 0); }
// Using provided texts, not from DB
void AddGossipItemFor(Player* player, uint32 icon, std::string const& text, uint32 sender, uint32 action, std::string const& popupText, uint32 popupMoney, bool coded) { player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, icon, text, sender, action, popupText, popupMoney, coded); }
// Uses gossip item info from DB
void AddGossipItemFor(Player* player, uint32 gossipMenuID, uint32 gossipMenuItemID, uint32 sender, uint32 action) { player->PlayerTalkClass->GetGossipMenu().AddMenuItem(gossipMenuID, gossipMenuItemID, sender, action); }
void SendGossipMenuFor(Player* player, uint32 npcTextID, ObjectGuid const& guid) { player->PlayerTalkClass->SendGossipMenu(npcTextID, guid); }
void SendGossipMenuFor(Player* player, uint32 npcTextID, Creature const* creature) { if (creature) SendGossipMenuFor(player, npcTextID, creature->GetGUID()); }
void CloseGossipMenuFor(Player* player) { player->PlayerTalkClass->SendCloseGossip(); }
