/*
* Copyright (C) 2012-2013 HTCore <http://cata.vfire-core.com/>
* Copyright (C) 2012-2013 WoW Source <http://wow.amgi-it.ro/>
* by Shee Shen
*/

#ifndef DEF_THE_STONECORE_H
#define DEF_THE_STONECORE_H

enum Data
{
    DATA_CORBORUS_EVENT,
    DATA_SLABHIDE_EVENT,
    DATA_OZRUK_EVENT,
    DATA_HIGH_PRIESTESS_AZIL_EVENT,
    DATA_TEAM_IN_INSTANCE,
};

enum Data64
{
    DATA_CORBORUS,
    DATA_SLABHIDE,
    DATA_OZRUK,
    DATA_HIGH_PRIESTESS_AZIL,
};

enum CreatureIds
{
    // Dungeon Bosses

    BOSS_CORBORUS                  = 43438,
    BOSS_SLABHIDE                  = 43214,
    BOSS_OZRUK                     = 42188,
    BOSS_HIGH_PRIESTESS_AZIL       = 42333,

    // Trash mobs

    NPC_CRYSTALSPAWN_GIANT         = 42810,
    NPC_IMP                        = 43014,
    NPC_MILLHOUSE_MANASTORM        = 43391,
    NPC_ROCK_BORER                 = 43917,
    NPC_ROCK_BORER2                = 42845,
    NPC_STONECORE_BERSERKER        = 43430,
    NPC_STONECORE_BRUISER          = 42692,
    NPC_STONECORE_EARTHSHAPER      = 43537,
    NPC_STONECORE_FLAYER           = 42808,
    NPC_MAGMALORD                  = 42789,
    NPC_RIFT_CONJURER              = 42691,
    NPC_STONECORE_SENTRY           = 42695,
    NPC_STONECORE_WARBRINGER       = 42696,

    // Various NPCs

    NPC_EARTHWARDEN_YRSA           = 50048,
    NPC_STONECORE_TELEPORTER1      = 51396,
    NPC_STONECORE_TELEPORTER2      = 51397,
};

enum GameObjectIds
{
    GO_BROKEN_PILLAR               = 207407,
    GO_TWILIGHT_DOCUMENTS          = 207415,
};

#endif