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

enum FelwoodAreas
{
    // North
    FELWOOD_NORTH_JADEFIRE_RUN      = 2618, // Camino Fuego de Jade
    FELWOOD_NORTH_IRONTREE_WOODS    = 1767, // Bosque de Troncoferro
    FELWOOD_NORTH_IRONTREE_CAVERN   = 1768, // Caverna de Troncoferro
    FELWOOD_NORTH_TALONBRANCH_GLADE = 1998, // Claro Ramaespolon
    FELWOOD_NORTH_FELPAW_VILLAGE    = 1762, // Poblado Zarpavil
    FELWOOD_NORTH_TIMBERMAW_HOLD    = 1769, // Bastion Fauces de Madera
    // Center
    FELWOOD_CENTER_JAEDENAR               = 1763, // Jaedenar
    FELWOOD_CENTER_BLOODVENOM_POST        = 1997, // Puesto del Veneno
    FELWOOD_CENTER_BLOODVENOM_RIVER       = 1764, // Rio del Veneno
    FELWOOD_CENTER_BLOODVENOM_FALLS       = 1765, // Cascadas del Veneno
    FELWOOD_CENTER_SHATTER_SCAR_VALE      = 1766, // Canada Gran Cicatriz
    FELWOOD_CENTER_SHRINE_OF_THE_DECEIVER = 1771, // Santuario del Impostor
    FELWOOD_CENTER_SHADOW_HOLD            = 1770, // Guarida Sombria
    // South
    FELWOOD_SOUTH_MORLOS_ARAN         = 2478, // Morlos'Aran
    FELWOOD_SOUTH_DEADWOOD_VILLAGE    = 1761, // Aldea Muertobosque
    FELWOOD_SOUTH_EMERALD_SANCTUARY   = 2479, // Santuario Esmeralda
    FELWOOD_SOUTH_JADEFIRE_GLEN       = 2480, // Canada Fuego de Jade
    FELWOOD_SOUTH_RUINS_OF_CONSTELLAS = 2481  // Ruinas de Constellas
};

uint32 FelwoodNorthAreas[6] =
{
    2618, // Camino Fuego de Jade
    1767, // Bosque de Troncoferro
    1768, // Caverna de Troncoferro
    1998, // Claro Ramaespolon
    1762, // Poblado Zarpavil
    1769  // Bastion Fauces de Madera
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
                player->pvpInfo.IsInHighSecZone = false;
                break;
            case NULLSEC_ZONE_FELWOOD:
                // Inform the player of that he is now in a Null-Sec zone.
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                newArea = player->GetAreaId();
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
                player->pvpInfo.IsInHighSecZone = false;
                break;
            case NULLSEC_ZONE_DESOLACE:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);
                player->pvpInfo.IsInHighSecZone = false;
                break;
            case NULLSEC_ZONE_DUSTWALLOW_MARSH:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);
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
