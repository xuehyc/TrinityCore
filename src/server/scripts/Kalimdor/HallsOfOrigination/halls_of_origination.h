/*
* Copyright (C) 2012-2013 HTCore <http://cata.vfire-core.com/>
* Copyright (C) 2012-2013 WoW Source <http://wow.amgi-it.ro/>
* by Shee Shen
*/

#ifndef DEF_HALLS_OF_ORIGINATION_H
#define DEF_HALLS_OF_ORIGINATION_H

enum Data
{
    DATA_TEMPLE_GUARDIAN_ANHUUR_EVENT,
    DATA_EARTHRAGER_PTAH_EVENT,
    DATA_ANRAPHET_EVENT,
    DATA_ISISET_EVENT,
    DATA_AMMUNAE_EVENT,
    DATA_SETESH_EVENT,
    DATA_RAJH_EVENT,
    DATA_TEAM_IN_INSTANCE,
};

enum Data64
{
    DATA_TEMPLE_GUARDIAN_ANHUUR,
    DATA_EARTHRAGER_PTAH,
    DATA_ANRAPHET,
    DATA_ISISET,
    DATA_AMMUNAE,
    DATA_SETESH,
    DATA_RAJH,
};

enum GameObjectIds
{
    GO_ORIGINATION_ELEVATOR,
    GO_LARGE_STONE_OBELISK      = 207410,
};

enum CreatureIds
{
    // Dungeon Bosses

    BOSS_TEMPLE_GUARDIAN_ANHUUR = 39425,
    BOSS_EARTHRAGER_PTAH        = 39428,
    BOSS_ANRAPHET               = 39788,
    BOSS_ISISET                 = 39587,
    BOSS_AMMUNAE                = 39731,
    BOSS_SETESH                 = 39732,
    BOSS_RAJH                   = 39378,

    // Trash Mobs

    NPC_BLISTERING_SCARAB       = 40310,
    NPC_BLOODPETAL_BLOSSOM      = 40620,
    NPC_DUSTBONE_TORMENTOR      = 40311,
    NPC_DUSTBONE_HORROR         = 40787,
    NPC_EARTH_WARDEN            = 39801,
    NPC_FLAME_WARDEN            = 39800,
    NPC_FLUX_ANIMATOR           = 40033,
    NPC_LIFEWARDEN_NYMPH        = 40715,
    NPC_LIVING_VINE             = 40668,
    NPC_SPATIAL_ANOMALY         = 40170,
    NPC_TEMPLE_SWIFTSTALKER     = 48139,
    NPC_TEMPLE_SHADOWLANCER     = 48141,
    NPC_TEMPLE_RUNECASTER       = 48140,
    NPC_TEMPLE_FIRESHAPER       = 48143,
    NPC_VENOMOUS_SKITTERER      = 39440,
    NPC_WATER_WARDEN            = 39802,
    NPC_AIR_WARDEN              = 39803,

    // Various NPCs

    NPC_BRANN_BRONZEBEARD       = 49941,
    NPC_SEARING_FLAME           = 40283,
    NPC_LIGHT                   = 40183
};

#endif