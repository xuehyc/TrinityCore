/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "World.h"

// This is where scripts' loading functions should be declared:
// world
void AddSC_areatrigger_scripts();
void AddSC_conversation_scripts();
void AddSC_emerald_dragons();
void AddSC_generic_creature();
void AddSC_go_scripts();
void AddSC_guards();
void AddSC_item_scripts();
void AddSC_npc_professions();
void AddSC_npc_innkeeper();
void AddSC_npcs_special();
void AddSC_achievement_scripts();
void AddSC_action_ip_logger();
void AddSC_scene_scripts();
// player
void AddSC_chat_log();
void AddSC_duel_reset();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddWorldScripts()
{
    AddSC_areatrigger_scripts();
    AddSC_conversation_scripts();
    AddSC_emerald_dragons();
    AddSC_generic_creature();
    AddSC_go_scripts();
    AddSC_guards();
    AddSC_item_scripts();
    AddSC_npc_professions();
    AddSC_npc_innkeeper();
    AddSC_npcs_special();
    AddSC_achievement_scripts();
    AddSC_chat_log(); // location: scripts\World\chat_log.cpp
    AddSC_scene_scripts();

    // FIXME: This should be moved in a script validation hook.
    // To avoid duplicate code, we check once /*ONLY*/ if logging is permitted or not.
    if (sWorld->getBoolConfig(CONFIG_IP_BASED_ACTION_LOGGING))
        AddSC_action_ip_logger(); // location: scripts\World\action_ip_logger.cpp
    AddSC_duel_reset();
}
