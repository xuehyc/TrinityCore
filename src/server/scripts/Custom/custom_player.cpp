/*
* Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2014 Steel Gamers Community <http://www.steelgamers.es>
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

#include "ScriptMgr.h"
#include "Channel.h"
#include "Guild.h"
#include "Group.h"
#include "Language.h"
#include "NullSecMgr.h"

#define MAPID_EASTERN_KINGDOMS 0
#define MAPID_KALIMDOR 1

enum RestrictedZones
{
    RESTRICTED_ZONE_FERALAS            = 357,
    RESTRICTED_ZONE_THOUSAND_NEEDLES   = 400,
    RESTRICTED_ZONE_REDRIDGE_MOUNTAINS = 44,
    RESTRICTED_ZONE_DUSKWOOD           = 10,
    RESTRICTED_ZONE_WESTFALL           = 40
};

enum HighSecZones
{
    HIGHSEC_ZONE_STORMWIND     = 1519,
    HIGHSEC_ZONE_ORGRIMMAR     = 1637,
    HIGHSEC_ZONE_DARNASSUS     = 1657,
    HIGHSEC_ZONE_THUNDERBLUFF  = 1638,
    HIGHSEC_ZONE_ELWYNN_FOREST = 12,
    HIGHSEC_ZONE_DUROTAR       = 14,
    HIGHSEC_ZONE_TELDRASSIL    = 141,
    HIGHSEC_ZONE_MULGORE       = 215
};

enum LowSecZones
{
    LOWSEC_ZONE_DARKSHORE   = 148,
    LOWSEC_ZONE_ASHENVALE   = 331,
    LOWSEC_ZONE_AZSHARA     = 16,
    LOWSEC_ZONE_THE_BARRENS = 17,
};

enum NullSecZones
{
    NULLSEC_ZONE_DESOLACE             = 405,
    NULLSEC_ZONE_WINTERSPRING         = 618,
    NULLSEC_ZONE_DUSTWALLOW_MARSH     = 15,
    NULLSEC_ZONE_STONETALON_MOUNTAINS = 406,
    NULLSEC_ZONE_FELWOOD              = 361
};

enum RestrictedGraveyards
{
    GRAVEYARD_FERALAS            = 0,
    GRAVEYARD_THOUSAND_NEEDLES   = 1,
    GRAVEYARD_REDRIDGE_MOUNTAINS = 2,
    GRAVEYARD_DUSKWOOD           = 3,
    GRAVEYARD_WESTFALL           = 4
};

Position const GraveyardsPositions[5] =
{
        { -1967.22f, 1723.91f, 61.67f, 5.7387f },
        { -2515.37f, -1964.68f, 91.79f, 4.48131f },
        { -9339.96f, 172.11f, 61.57f, 3.56999f },
        { -9339.96f, 172.11f, 61.57f, 3.56999f },
        { -9339.96f, 172.11f, 61.57f, 3.56999f }
};

enum WinterspringAreas
{
    // North (7/17)
    WINTERSPRING_NORTH_FROSTSABER_ROCK       = 2241,
    WINTERSPRING_NORTH_THE_HIDDEN_GROVE      = 2242,
    WINTERSPRING_NORTH_STARFALL_VILLAGE      = 2253,
    WINTERSPRING_NORTH_MOON_HORROR_DEN       = 3139,
    WINTERSPRING_NORTH_LAKE_KELTHERIL        = 2251,
    WINTERSPRING_NORTH_FROSTFIRE_HOT_SPRINGS = 2246,
    WINTERSPRING_NORTH_TIMBERMAW_POST        = 2243,
    // South (10/17)
    WINTERSPRING_SOUTH_EVERLOOK               = 2255,
    WINTERSPRING_SOUTH_DARKWHISPER_GORGE      = 2256,
    WINTERSPRING_SOUTH_BANTHALLOW_BARROW_DEN  = 2254,
    WINTERSPRING_SOUTH_THE_RUINS_OF_KELTHERIL = 2252,
    WINTERSPRING_SOUTH_OWL_WING_THICKET       = 2250,
    WINTERSPRING_SOUTH_FROSTWHISPER_GORGE     = 2249,
    WINTERSPRING_SOUTH_DUN_MANDARR            = 2248,
    WINTERSPRING_SOUTH_ICE_THISTLE_HILLS      = 2247,
    WINTERSPRING_SOUTH_MAZTHORIL              = 2245,
    WINTERSPRING_SOUTH_WINTERFALL_VILLAGE     = 2244
};

enum FelwoodAreas
{
    // North (6/18)
    FELWOOD_NORTH_JADEFIRE_RUN      = 2618, // Camino Fuego de Jade
    FELWOOD_NORTH_IRONTREE_WOODS    = 1767, // Bosque de Troncoferro
    FELWOOD_NORTH_IRONTREE_CAVERN   = 1768, // Caverna de Troncoferro
    FELWOOD_NORTH_TALONBRANCH_GLADE = 1998, // Claro Ramaespolon
    FELWOOD_NORTH_FELPAW_VILLAGE    = 1762, // Poblado Zarpavil
    FELWOOD_NORTH_TIMBERMAW_HOLD    = 1769, // Bastion Fauces de Madera
    // Center (7/18)
    FELWOOD_CENTER_JAEDENAR               = 1763, // Jaedenar
    FELWOOD_CENTER_BLOODVENOM_POST        = 1997, // Puesto del Veneno
    FELWOOD_CENTER_BLOODVENOM_RIVER       = 1764, // Rio del Veneno
    FELWOOD_CENTER_BLOODVENOM_FALLS       = 1765, // Cascadas del Veneno
    FELWOOD_CENTER_SHATTER_SCAR_VALE      = 1766, // Canada Gran Cicatriz
    FELWOOD_CENTER_SHRINE_OF_THE_DECEIVER = 1771, // Santuario del Impostor
    FELWOOD_CENTER_SHADOW_HOLD            = 1770, // Guarida Sombria
    // South (5/18)
    FELWOOD_SOUTH_MORLOS_ARAN         = 2478, // Morlos'Aran
    FELWOOD_SOUTH_DEADWOOD_VILLAGE    = 1761, // Aldea Muertobosque
    FELWOOD_SOUTH_EMERALD_SANCTUARY   = 2479, // Santuario Esmeralda
    FELWOOD_SOUTH_JADEFIRE_GLEN       = 2480, // Canada Fuego de Jade
    FELWOOD_SOUTH_RUINS_OF_CONSTELLAS = 2481  // Ruinas de Constellas
};

enum StoneTalonMountainsAreas
{
    // East (14/19)
    STONETALON_EAST_GREATWOOD_VALE      = 469,
    STONETALON_EAST_SUN_ROCK_RETREAT    = 460,
    STONETALON_EAST_CRAGPOOL_LAKE       = 463,
    STONETALON_EAST_WINDSHEAR_CRAG      = 461,
    STONETALON_EAST_SISHIR_CANYON       = 2541,
    STONETALON_EAST_MALAKAJIN           = 2539,
    STONETALON_EAST_CAMP_APARAJE        = 2538,
    STONETALON_EAST_GRIMTOTEM_POST      = 2537,
    STONETALON_EAST_WINDSHEAR_MINE      = 2160,
    STONETALON_EAST_WEBWINDER_PATH      = 1076,
    STONETALON_EAST_TALONDEEP_PATH      = 1277,
    STONETALON_EAST_BLACKWOLF_RIVER     = 636,
    STONETALON_EAST_BOULDERSLIDE_RAVINE = 2540,
    STONETALON_EAST_BOULDERSLIDE_CAVERN = 3157,
    // West (5/19)
    STONETALON_WEST_MIRKFALLON_LAKE           = 464,
    STONETALON_WEST_THE_CHARRED_VALE          = 465,
    STONETALON_WEST_VALLEY_OF_THE_BLOODFURIES = 466,
    STONETALON_WEST_STONETALON_PEAK           = 467,
    STONETALON_WEST_THE_TALON_DEN             = 468
};

enum DesolaceAreas
{
    // North (8/22)
    DESOLACE_NORTH_NIJELS_POINT         = 608,
    DESOLACE_NORTH_THUNDER_AXE_FORTRESS = 599,
    DESOLACE_NORTH_SARGERON             = 603,
    DESOLACE_NORTH_TETHRIS_ARAN         = 2404,
    DESOLACE_NORTH_SHADOWBREAK_RAVINE   = 2198,
    DESOLACE_NORTH_MAGRAM_VILLAGE       = 604,
    DESOLACE_NORTH_KORMEKS_HUT          = 2407,
    DESOLACE_NORTH_KOLKAR_VILLAGE       = 609,
    // South (13/22)
    DESOLACE_SOUTH_KODO_GRAVEYARD       = 596,
    DESOLACE_SOUTH_GHOST_WALKER_POST    = 597,
    DESOLACE_SOUTH_SARTHERIS_STRAND     = 598,
    DESOLACE_SOUTH_BOLGANS_HOLE         = 600,
    DESOLACE_SOUTH_MANNOROC_COVEN       = 602,
    DESOLACE_SOUTH_GELKIS_VILLAGE       = 606,
    DESOLACE_SOUTH_VALLEY_OF_SPEARS     = 607,
    DESOLACE_SOUTH_BROKEN_SPEAR_VILLAGE = 2217,
    DESOLACE_SOUTH_SHADOWPREY_VILLAGE   = 2408,
    DESOLACE_SOUTH_RANAZJAR_ISLE        = 2406,
    DESOLACE_SOUTH_ETHEL_RETHOR         = 2405,
    DESOLACE_SOUTH_SCRABBLESCREWS_CAMP  = 2617,
    DESOLACE_SOUTH_VALLEY_OF_BONES      = 2657
};

enum DustwallowMarsh
{
    // North (15/32)
    DUSTWALLOW_MARSH_NORTH_BRACKENWALL_VILLAGE = 496,
    DUSTWALLOW_MARSH_NORTH_SWAMPLIGHT_MANOR    = 497,
    DUSTWALLOW_MARSH_NORTH_DARKMIST_CAVERN     = 499,
    DUSTWALLOW_MARSH_NORTH_MOGGLE_POINT        = 500,
    DUSTWALLOW_MARSH_NORTH_WITCH_HILL          = 502,
    DUSTWALLOW_MARSH_NORTH_SENTRY_POINT        = 503,
    DUSTWALLOW_MARSH_NORTH_NORTH_POINT_TOWER   = 504,
    DUSTWALLOW_MARSH_NORTH_WEST_POINT_TOWER    = 505,
    DUSTWALLOW_MARSH_NORTH_BLUEFEN             = 507,
    DUSTWALLOW_MARSH_NORTH_BLACKHOOF_VILLAGE   = 512,
    DUSTWALLOW_MARSH_NORTH_THERAMORE_ISLE      = 513,
    DUSTWALLOW_MARSH_NORTH_FOOTHOLD_CITADEL    = 514,
    DUSTWALLOW_MARSH_NORTH_IRONCLAD_PRISON     = 515,
    DUSTWALLOW_MARSH_NORTH_DREADMURK_SHORE     = 518,
    DUSTWALLOW_MARSH_NORTH_ALCAZ_ISLAND        = 2079,
    // South (15/32)
    DUSTWALLOW_MARSH_SOUTH_SHADY_REST_INN   = 403,
    DUSTWALLOW_MARSH_SOUTH_BLOODFEN_BURROW  = 498,
    DUSTWALLOW_MARSH_SOUTH_BEEZILS_WRECK    = 501,
    DUSTWALLOW_MARSH_SOUTH_LOST_POINT       = 506,
    DUSTWALLOW_MARSH_SOUTH_STONEMAUL_RUINS  = 508,
    DUSTWALLOW_MARSH_SOUTH_THE_DEN_OF_FLAME = 509,
    DUSTWALLOW_MARSH_SOUTH_THE_DRAGONMURK   = 510,
    DUSTWALLOW_MARSH_SOUTH_WYRMBOG          = 511,
    DUSTWALLOW_MARSH_SOUTH_TIDEFURY_COVE    = 517,
    DUSTWALLOW_MARSH_SOUTH_EMBERSTRIFES_DEN = 2158,
    DUSTWALLOW_MARSH_SOUTH_THE_QUAGMIRE     = 2302,
    DUSTWALLOW_MARSH_SOUTH_MUDSPROCKET      = 4010,
    DUSTWALLOW_MARSH_SOUTH_NATS_LANDING     = 4047,
    DUSTWALLOW_MARSH_SOUTH_TABETHAS_FARM    = 4049,
    DUSWALLOW_MARSH_SOUTH_DIREHORN_POST     = 4046
};

class CustomPlayerScript : public PlayerScript
{
public:
    CustomPlayerScript() : PlayerScript("CustomPlayerScript") { }

    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea, bool areaOnly) override
    {
        // This zones are the new frontiers, so don't let the players cross them.
        switch (newZone)
        {
            // The following zones are the new frontiers, so don't let the players enter them.
            // TODO: More costal regions should be checked. May be change check type for Eastern Kingdoms. Block transports.
            case RESTRICTED_ZONE_FERALAS:
                player->TeleportTo(MAPID_KALIMDOR, GraveyardsPositions[GRAVEYARD_FERALAS].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_FERALAS].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_FERALAS].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_FERALAS].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_THOUSAND_NEEDLES:
                player->TeleportTo(MAPID_KALIMDOR, GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_THOUSAND_NEEDLES].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_REDRIDGE_MOUNTAINS:
                player->TeleportTo(MAPID_KALIMDOR, GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_DUSKWOOD:
                player->TeleportTo(MAPID_KALIMDOR, GraveyardsPositions[GRAVEYARD_FERALAS].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_WESTFALL:
                player->TeleportTo(MAPID_KALIMDOR, GraveyardsPositions[GRAVEYARD_WESTFALL].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_WESTFALL].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_WESTFALL].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_WESTFALL].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            // The following zones are High Sec areas. We must force the player exit FFA PvP state, if his faction is the owner of the zone.
            case HIGHSEC_ZONE_MULGORE:
            case HIGHSEC_ZONE_DUROTAR:
            case HIGHSEC_ZONE_ORGRIMMAR:
            case HIGHSEC_ZONE_THUNDERBLUFF:
                // If he is a member of the opposite faction, it's like he is in a Null Sec area
                if (player->GetTeam() == HORDE)
                {
                    player->pvpInfo.IsInHighSecZone = true;
                    if (!areaOnly)
                        ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_GENERAL_ENTER);
                }
                else if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_HORDE_ENTER);
                break;
            case HIGHSEC_ZONE_TELDRASSIL:
            case HIGHSEC_ZONE_ELWYNN_FOREST:
            case HIGHSEC_ZONE_STORMWIND:
            case HIGHSEC_ZONE_DARNASSUS:
                if (player->GetTeam() == ALLIANCE)
                {
                    player->pvpInfo.IsInHighSecZone = true;
                    if (!areaOnly)
                        ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_GENERAL_ENTER);
                }
                else if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_ALLIANCE_ENTER);
                break;
            // These are the Low Sec Areas, FFA PvP is allowed here.
            case LOWSEC_ZONE_DARKSHORE:
            case LOWSEC_ZONE_ASHENVALE:
            case LOWSEC_ZONE_AZSHARA:
            case LOWSEC_ZONE_THE_BARRENS:
                player->pvpInfo.IsInHighSecZone = false;
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_LOWSEC_GENERAL_ENTER);
                break;
            // And these are the Null Sec zones, FFA PvP is encouraged here.
            case NULLSEC_ZONE_WINTERSPRING:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                switch (newArea)
                {
                    // North (7/17)
                    case WINTERSPRING_NORTH_FROSTSABER_ROCK:
                    case WINTERSPRING_NORTH_THE_HIDDEN_GROVE:
                    case WINTERSPRING_NORTH_STARFALL_VILLAGE:
                    case WINTERSPRING_NORTH_MOON_HORROR_DEN:
                    case WINTERSPRING_NORTH_LAKE_KELTHERIL:
                    case WINTERSPRING_NORTH_FROSTFIRE_HOT_SPRINGS:
                    case WINTERSPRING_NORTH_TIMBERMAW_POST:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_WINTERSPRING_NORTH);
                        break;
                    // South (10/17)
                    case WINTERSPRING_SOUTH_EVERLOOK:
                    case WINTERSPRING_SOUTH_DARKWHISPER_GORGE:
                    case WINTERSPRING_SOUTH_BANTHALLOW_BARROW_DEN:
                    case WINTERSPRING_SOUTH_THE_RUINS_OF_KELTHERIL:
                    case WINTERSPRING_SOUTH_OWL_WING_THICKET:
                    case WINTERSPRING_SOUTH_FROSTWHISPER_GORGE:
                    case WINTERSPRING_SOUTH_DUN_MANDARR:
                    case WINTERSPRING_SOUTH_ICE_THISTLE_HILLS:
                    case WINTERSPRING_SOUTH_MAZTHORIL:
                    case WINTERSPRING_SOUTH_WINTERFALL_VILLAGE:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_WINTERSPRING_SOUTH);
                        break;
                    default:
                        if (player->GetGuildZoneId() != GUILD_ZONE_NONE)
                            sNullSecMgr->OnPlayerLeaveNullSecZone(player);
                        break;
                }
                player->pvpInfo.IsInHighSecZone = false;
                break;
            case NULLSEC_ZONE_FELWOOD:
                // Inform the player of that he is now in a Null-Sec zone.
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                switch (newArea)
                {
                    // Felwood North
                    case FELWOOD_NORTH_JADEFIRE_RUN:
                    case FELWOOD_NORTH_IRONTREE_WOODS:
                    case FELWOOD_NORTH_IRONTREE_CAVERN:
                    case FELWOOD_NORTH_TALONBRANCH_GLADE:
                    case FELWOOD_NORTH_FELPAW_VILLAGE:
                    case FELWOOD_NORTH_TIMBERMAW_HOLD:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_FELWOOD_NORTH);
                        break;
                    // Felwood Center
                    case FELWOOD_CENTER_JAEDENAR:
                    case FELWOOD_CENTER_BLOODVENOM_POST:
                    case FELWOOD_CENTER_BLOODVENOM_RIVER:
                    case FELWOOD_CENTER_BLOODVENOM_FALLS:
                    case FELWOOD_CENTER_SHATTER_SCAR_VALE:
                    case FELWOOD_CENTER_SHRINE_OF_THE_DECEIVER:
                    case FELWOOD_CENTER_SHADOW_HOLD:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_FELWOOD_CENTER);
                        break;
                    // Felwood South
                    case FELWOOD_SOUTH_MORLOS_ARAN:
                    case FELWOOD_SOUTH_DEADWOOD_VILLAGE:
                    case FELWOOD_SOUTH_EMERALD_SANCTUARY:
                    case FELWOOD_SOUTH_JADEFIRE_GLEN:
                    case FELWOOD_SOUTH_RUINS_OF_CONSTELLAS:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_FELWOOD_SOUTH);
                        break;
                    default:
                        if (player->GetGuildZoneId() != GUILD_ZONE_NONE)
                            sNullSecMgr->OnPlayerLeaveNullSecZone(player);
                        break;
                }
                player->pvpInfo.IsInHighSecZone = false;
                break;
            case NULLSEC_ZONE_STONETALON_MOUNTAINS:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                switch (newArea)
                {
                     // East (14/19)
                    case STONETALON_EAST_GREATWOOD_VALE:
                    case STONETALON_EAST_SUN_ROCK_RETREAT:
                    case STONETALON_EAST_CRAGPOOL_LAKE:
                    case STONETALON_EAST_WINDSHEAR_CRAG:
                    case STONETALON_EAST_SISHIR_CANYON:
                    case STONETALON_EAST_MALAKAJIN:
                    case STONETALON_EAST_CAMP_APARAJE:
                    case STONETALON_EAST_GRIMTOTEM_POST:
                    case STONETALON_EAST_WINDSHEAR_MINE:
                    case STONETALON_EAST_WEBWINDER_PATH:
                    case STONETALON_EAST_TALONDEEP_PATH:
                    case STONETALON_EAST_BLACKWOLF_RIVER:
                    case STONETALON_EAST_BOULDERSLIDE_RAVINE:
                    case STONETALON_EAST_BOULDERSLIDE_CAVERN:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_STONETALON_MOUNTAINS_EAST);
                        break;
                    // West (5/19)
                    case STONETALON_WEST_MIRKFALLON_LAKE:
                    case STONETALON_WEST_THE_CHARRED_VALE:
                    case STONETALON_WEST_VALLEY_OF_THE_BLOODFURIES:
                    case STONETALON_WEST_STONETALON_PEAK:
                    case STONETALON_WEST_THE_TALON_DEN:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_STONETALON_MOUNTAINS_WEST);
                        break;
                    default:
                        if (player->GetGuildZoneId() != GUILD_ZONE_NONE)
                            sNullSecMgr->OnPlayerLeaveNullSecZone(player);
                        break;
                }
                player->pvpInfo.IsInHighSecZone = false;
                break;
            case NULLSEC_ZONE_DESOLACE:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                switch (newArea)
                {
                    // North (8/22)
                    case DESOLACE_NORTH_NIJELS_POINT:
                    case DESOLACE_NORTH_THUNDER_AXE_FORTRESS:
                    case DESOLACE_NORTH_SARGERON:
                    case DESOLACE_NORTH_TETHRIS_ARAN:
                    case DESOLACE_NORTH_SHADOWBREAK_RAVINE:
                    case DESOLACE_NORTH_MAGRAM_VILLAGE:
                    case DESOLACE_NORTH_KORMEKS_HUT:
                    case DESOLACE_NORTH_KOLKAR_VILLAGE:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_DESOLACE_NORTH);
                        break;
                    // South (13/22)
                    case DESOLACE_SOUTH_KODO_GRAVEYARD:
                    case DESOLACE_SOUTH_GHOST_WALKER_POST:
                    case DESOLACE_SOUTH_SARTHERIS_STRAND:
                    case DESOLACE_SOUTH_BOLGANS_HOLE:
                    case DESOLACE_SOUTH_MANNOROC_COVEN:
                    case DESOLACE_SOUTH_GELKIS_VILLAGE:
                    case DESOLACE_SOUTH_VALLEY_OF_SPEARS:
                    case DESOLACE_SOUTH_BROKEN_SPEAR_VILLAGE:
                    case DESOLACE_SOUTH_SHADOWPREY_VILLAGE:
                    case DESOLACE_SOUTH_RANAZJAR_ISLE:
                    case DESOLACE_SOUTH_ETHEL_RETHOR:
                    case DESOLACE_SOUTH_SCRABBLESCREWS_CAMP:
                    case DESOLACE_SOUTH_VALLEY_OF_BONES:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_DESOLACE_SOUTH);
                        break;
                    default:
                        if (player->GetGuildZoneId() != GUILD_ZONE_NONE)
                            sNullSecMgr->OnPlayerLeaveNullSecZone(player);
                        break;
                }
                player->pvpInfo.IsInHighSecZone = false;
                break;
            case NULLSEC_ZONE_DUSTWALLOW_MARSH:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                switch (newArea)
                {
                    // North (15/32)
                    case DUSTWALLOW_MARSH_NORTH_BRACKENWALL_VILLAGE:
                    case DUSTWALLOW_MARSH_NORTH_SWAMPLIGHT_MANOR:
                    case DUSTWALLOW_MARSH_NORTH_DARKMIST_CAVERN:
                    case DUSTWALLOW_MARSH_NORTH_MOGGLE_POINT:
                    case DUSTWALLOW_MARSH_NORTH_WITCH_HILL:
                    case DUSTWALLOW_MARSH_NORTH_SENTRY_POINT:
                    case DUSTWALLOW_MARSH_NORTH_NORTH_POINT_TOWER:
                    case DUSTWALLOW_MARSH_NORTH_WEST_POINT_TOWER:
                    case DUSTWALLOW_MARSH_NORTH_BLUEFEN:
                    case DUSTWALLOW_MARSH_NORTH_BLACKHOOF_VILLAGE:
                    case DUSTWALLOW_MARSH_NORTH_THERAMORE_ISLE:
                    case DUSTWALLOW_MARSH_NORTH_FOOTHOLD_CITADEL:
                    case DUSTWALLOW_MARSH_NORTH_IRONCLAD_PRISON:
                    case DUSTWALLOW_MARSH_NORTH_DREADMURK_SHORE:
                    case DUSTWALLOW_MARSH_NORTH_ALCAZ_ISLAND:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_DUSTWALLOW_MARSH_NORTH);
                        break;
                    // South (15/32)
                    case DUSTWALLOW_MARSH_SOUTH_SHADY_REST_INN:
                    case DUSTWALLOW_MARSH_SOUTH_BLOODFEN_BURROW:
                    case DUSTWALLOW_MARSH_SOUTH_BEEZILS_WRECK:
                    case DUSTWALLOW_MARSH_SOUTH_LOST_POINT:
                    case DUSTWALLOW_MARSH_SOUTH_STONEMAUL_RUINS:
                    case DUSTWALLOW_MARSH_SOUTH_THE_DEN_OF_FLAME:
                    case DUSTWALLOW_MARSH_SOUTH_THE_DRAGONMURK:
                    case DUSTWALLOW_MARSH_SOUTH_WYRMBOG:
                    case DUSTWALLOW_MARSH_SOUTH_TIDEFURY_COVE:
                    case DUSTWALLOW_MARSH_SOUTH_EMBERSTRIFES_DEN:
                    case DUSTWALLOW_MARSH_SOUTH_THE_QUAGMIRE:
                    case DUSTWALLOW_MARSH_SOUTH_MUDSPROCKET:
                    case DUSTWALLOW_MARSH_SOUTH_NATS_LANDING:
                    case DUSTWALLOW_MARSH_SOUTH_TABETHAS_FARM:
                    case DUSWALLOW_MARSH_SOUTH_DIREHORN_POST:
                        sNullSecMgr->OnPlayerEnterNullSecZone(player, GUILD_ZONE_DUSTWALLOW_MARSH_SOUTH);
                        break;
                    default:
                        if (player->GetGuildZoneId() != GUILD_ZONE_NONE)
                            sNullSecMgr->OnPlayerLeaveNullSecZone(player);
                        break;
                }
                player->pvpInfo.IsInHighSecZone = false;
                break;
            default:
                break;
        }
    }
};

void AddSC_custom_player()
{
    new CustomPlayerScript();
}
