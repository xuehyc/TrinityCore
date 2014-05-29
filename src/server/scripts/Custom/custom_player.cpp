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
                player->TeleportTo(MAPID_EASTERN_KINGDOMS, GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_REDRIDGE_MOUNTAINS].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_DUSKWOOD:
                player->TeleportTo(MAPID_EASTERN_KINGDOMS, GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionX(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionY(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetPositionZ(),
                    GraveyardsPositions[GRAVEYARD_DUSKWOOD].GetOrientation());
                ChatHandler(player->GetSession()).SendSysMessage(LANG_FRONTIER_ZONE_ENTER);
                break;
            case RESTRICTED_ZONE_WESTFALL:
                player->TeleportTo(MAPID_EASTERN_KINGDOMS, GraveyardsPositions[GRAVEYARD_WESTFALL].GetPositionX(),
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
                if (player->GetTeam() == HORDE)
                {
                    player->pvpInfo.IsInHighSecZone = true;
                    if (!areaOnly)
                        ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_GENERAL_ENTER);
                }
                // If he is a member of the opposite faction, it's like he is in a Null Sec area
                else if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_HIGHSEC_HORDE_ENTER);
                player->InGuildZone(false);
                player->SetGuildZoneId(GUILD_ZONE_NONE);
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
                player->InGuildZone(false);
                player->SetGuildZoneId(GUILD_ZONE_NONE);
                break;
            // These are the Low Sec Areas, FFA PvP is allowed here.
            case LOWSEC_ZONE_DARKSHORE:
            case LOWSEC_ZONE_ASHENVALE:
            case LOWSEC_ZONE_AZSHARA:
            case LOWSEC_ZONE_THE_BARRENS:
                player->pvpInfo.IsInHighSecZone = false;
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_LOWSEC_GENERAL_ENTER);
                player->InGuildZone(false);
                player->SetGuildZoneId(GUILD_ZONE_NONE);
                break;
            // And these are the Null Sec zones, FFA PvP is encouraged here.
            case NULLSEC_ZONE_WINTERSPRING:
            case NULLSEC_ZONE_FELWOOD:
            case NULLSEC_ZONE_STONETALON_MOUNTAINS:
            case NULLSEC_ZONE_DESOLACE:
            case NULLSEC_ZONE_DUSTWALLOW_MARSH:
                if (!areaOnly)
                    ChatHandler(player->GetSession()).SendSysMessage(LANG_NULLSEC_GENERAL_ENTER);

                // If zone = area (for example, roads) the area is not in a guild zone.
                // Other exceptions like seas are handled in OnPlayerEnterNullSecGuildZone().
                if (newZone == newArea && player->GetGuildZoneId() != GUILD_ZONE_NONE)
                    sNullSecMgr->OnPlayerLeaveNullSecGuildZone(player);
                else
                    sNullSecMgr->OnPlayerEnterNullSecGuildZone(player);
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
