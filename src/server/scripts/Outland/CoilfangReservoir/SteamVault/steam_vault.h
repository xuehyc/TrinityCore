/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_STEAM_VAULT_H
#define DEF_STEAM_VAULT_H

#include "CreatureAIImpl.h"

#define SteamVaultScriptName "instance_steam_vault"
#define DataHeader "SV"

uint32 const EncounterCount = 3;

enum SVDataTypes
{
    DATA_HYDROMANCER_THESPIA        = 0,
    DATA_MEKGINEER_STEAMRIGGER      = 1,
    DATA_WARLORD_KALITHRESH         = 2,
    DATA_DISTILLER                  = 3,

    // Additional Data
    DATA_ACCESS_PANEL_HYDRO         = 4,
    DATA_ACCESS_PANEL_MEK           = 5
};

enum SVCreatureIds
{
    NPC_HYDROMANCER_THESPIA         = 17797,
    NPC_MEKGINEER_STEAMRIGGER       = 17796,
    NPC_WARLORD_KALITHRESH          = 17798
};

enum SVGameObjectIds
{
    GO_MAIN_CHAMBERS_DOOR           = 183049,
    GO_ACCESS_PANEL_HYDRO           = 184125,
    GO_ACCESS_PANEL_MEK             = 184126
};

template<typename AI>
inline AI* GetSteamVaultAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, SteamVaultScriptName);
}

#endif
