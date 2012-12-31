/*
 * Copyright (C) 2008-2010 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "OutdoorPvPWG.h"
#include "SpellAuras.h"
#include "Vehicle.h"
#include "ObjectMgr.h"
#include "World.h"
#include "Chat.h"
#include "MapManager.h"
#include "ScriptedCreature.h"
#include "ScriptPCH.h"
#include "Group.h"

OutdoorPvPWG::OutdoorPvPWG()
{
    m_TypeId = OUTDOOR_PVP_WG;
    m_LastResurrectTime = 0; // Temporal copy of BG system till 3.2
    m_SpecialEng = NULL;
    m_SpecialSpi = NULL;

    homePosition[NPC_ALLIANCE_RANDOLPH].Relocate(5100.069824f, 2168.889893f, 365.778992f, 1.972220f);
    homePosition[NPC_ALLIANCE_TESSA].Relocate(5088.609863f, 2167.659912f, 365.688995f, 0.680678f);
    homePosition[NPC_ALLIANCE_KAYLANA].Relocate(5081.700195f, 2173.729980f, 365.877991f, 0.855211f);
    homePosition[NPC_ALLIANCE_ZANNETH].Relocate(5078.279785f, 2183.699951f, 365.028992f, 1.466080f);
    homePosition[NPC_ALLIANCE_ABRAHMIS].Relocate(5088.490234f, 2188.179932f, 365.647003f, 5.253440f);
    homePosition[NPC_ALLIANCE_STOUTHANDLE].Relocate(5095.669922f, 2193.280029f, 365.924011f, 4.939280f);
    homePosition[NPC_ALLIANCE_LEGOSO].Relocate(5080.399902f, 2199.000000f, 359.489014f, 2.967060f);

    homePosition[NPC_HORDE_BLAZEFEATHER].Relocate(5030.44f, 3659.82f, 363.194f, 1.83336f);
    homePosition[NPC_HORDE_MURP].Relocate(5008.64f, 3659.91f, 361.07f, 4.0796f);
    homePosition[NPC_HORDE_FUJIN].Relocate(5016.57f, 3677.53f, 362.982f, 5.7525f);
    homePosition[NPC_HORDE_KILRATH].Relocate(5032.33f, 3680.7f, 363.018f, 3.43167f);
    homePosition[NPC_HORDE_STRONGHOOF].Relocate(5032.66f, 3674.28f, 363.053f, 2.9447f);
    homePosition[NPC_HORDE_MULFORT].Relocate(5032.44f, 3668.66f, 363.11f, 2.87402f);
    homePosition[NPC_HORDE_DARDOSH].Relocate(5022.43f, 3659.91f, 361.61f, 1.35426f);

    fortressPosition[NPC_HORDE_MUKAR].Relocate(5373.470215f, 2789.060059f, 409.322998f, 2.600540f);
    fortressPosition[NPC_ALLIANCE_DAMERON].Relocate(5373.470215f, 2789.060059f, 409.322998f, 2.600540f);
    fortressPosition[NPC_HORDE_ROSSLAI].Relocate(5370.414062f, 2786.045898f, 409.329071f, 2.667296f);
    fortressPosition[NPC_ALLIANCE_MAGRUDER].Relocate(5370.414062f, 2786.045898f, 409.329071f, 2.667296f);
    fortressPosition[NPC_HORDE_DARDOSH].Relocate(5366.129883f, 2850.129883f, 409.239441f, 3.151590f);
    fortressPosition[NPC_ALLIANCE_ZANNETH].Relocate(5366.129883f, 2833.399902f, 409.322998f, 3.141590f);
    fortressPosition[NPC_HORDE_MULFORT].Relocate(5378.062012f, 3024.062500f, 409.113953f, 3.140740f);
    fortressPosition[NPC_ALLIANCE_TESSA].Relocate(5378.062012f, 3024.062500f, 409.113953f, 3.140740f);
    fortressPosition[NPC_HORDE_KILRATH].Relocate(5366.129883f, 2833.399902f, 409.322998f, 3.141590f);
    fortressPosition[NPC_ALLIANCE_ABRAHMIS].Relocate(5366.129883f, 2850.129883f, 409.239441f, 3.151590f);
    fortressPosition[NPC_HORDE_FUJIN].Relocate(5298.617676f, 2790.405273f, 409.192322f, 0.730418f);
    fortressPosition[NPC_ALLIANCE_KAYLANA].Relocate(5300.063477f, 2886.717773f, 409.191833f, 5.543853f);
    fortressPosition[NPC_HORDE_BLAZEFEATHER].Relocate(5298.430176f, 2738.760010f, 409.316010f, 3.971740f);
    fortressPosition[NPC_ALLIANCE_RANDOLPH].Relocate(5299.093750f, 2751.792236f, 409.192017f, 6.028575f);
    fortressPosition[NPC_HORDE_STRONGHOOF].Relocate(5296.860352f, 2930.155029f, 409.191498f, 0.534910f);
    fortressPosition[NPC_ALLIANCE_STOUTHANDLE].Relocate(5296.860352f, 2930.155029f, 409.191498f, 0.534910f);
    fortressPosition[NPC_HORDE_MURP].Relocate(5234.970215f, 2883.399902f, 409.274994f, 4.293510f);
    fortressPosition[NPC_ALLIANCE_LEGOSO].Relocate(5234.586426f, 2795.128906f, 409.191772f, 1.972659f);
    fortressPosition[NPC_ALLIANCE_GENERAL].Relocate(5468.782715f, 2840.573730f, 418.675354f, 3.144451f);
    fortressPosition[NPC_HORDE_WARBRINGER].Relocate(5468.782715f, 2840.573730f, 418.675354f, 3.144451f);
}

void _LoadTeamPair(TeamPairMap &pairMap, const TeamPair *pair)
{
    while((*pair)[0])
    {
        pairMap[(*pair)[0]] = (*pair)[1];
        pairMap[(*pair)[1]] = (*pair)[0];
        ++pair;
    }
}

void _RespawnCreatureIfNeeded(Creature *cr, uint32 entry)
{
    if (cr)
    {
        cr->SetOriginalEntry(entry);

        if (entry != cr->GetEntry() || !cr->isAlive())
            if (cr->GetMap()) // Once we get here, make sure map pointer is valid. Otherwise crash in Creature::InitEntry
                cr->Respawn(true);

        cr->SetVisible(true);
    }
}

bool OutdoorPvPWG::SetupOutdoorPvP()
{
    if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
    {
        sWorld->setWorldState(WORLDSTATE_WINTERGRASP_CONTROLLING_FACTION, TEAM_NEUTRAL);
        return false;
    }

    // load worldstates (boy this is ugly...needs to be converted to use world thread to read worldstates)
    QueryResult result = CharacterDatabase.PQuery("SELECT `entry`, `value` from `worldstates` where `entry` in (31001, 31002 , 31003, 31004, 31005) order by `entry`");
    
    m_WSSaveTimer = sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_SAVESTATE_PERIOD);

    if (result)
    {
        do
        {
            Field *fields = result->Fetch();
            switch (fields[0].GetUInt32())
            {
                case 31001:
                    m_wartime = fields[1].GetBool();
                    break;
                case 31002:
                    m_timer = fields[1].GetUInt32();
                    break;
                case 31003:
                    m_defender = TeamId(fields[1].GetUInt32());
                    break;
                case 31004:
                    allianceWinStreak = fields[1].GetUInt32();
                    break;
                case 31005:
                    hordeWinStreak = fields[1].GetUInt32();
                    break;

            }
        } while(result->NextRow());
    }
    else
    {
        m_wartime = false;
        m_timer = sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_START_TIME) * MINUTE * IN_MILLISECONDS;
        m_defender = TeamId(rand()%2);
        allianceWinStreak = 0;
        hordeWinStreak = 0;
    }

    sWorld->setWorldState(WORLDSTATE_WINTERGRASP_CONTROLLING_FACTION, getDefenderTeam());
    m_changeDefender = false;
    m_announce_30_done = false;
    m_announce_10_done = false;
    m_announce_5_done = false;
    m_within_our_grasp_eligible = false;
    m_workshopCount[TEAM_ALLIANCE] = 0;
    m_workshopCount[TEAM_HORDE] = 0;
    tenacityStackCount = 0;
    m_gate = NULL;

    std::list<uint32> engineers;
    std::list<uint32> spiritGuides;

    // Store Eng, spirit guide guids and questgiver for later use
    result = WorldDatabase.PQuery("SELECT guid, id FROM creature WHERE creature.map=571"
         " AND creature.id IN (%u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u);",
         NPC_GNOMISH_DEMOLISHER, NPC_GOBLIN_MECHANIC,
         NPC_DWARVEN_SPIRIT_GUIDE, NPC_TAUNKA_SPIRIT_GUIDE,
         NPC_HORDE_FUJIN, NPC_ALLIANCE_KAYLANA,
         NPC_HORDE_BLAZEFEATHER, NPC_ALLIANCE_RANDOLPH,
         NPC_HORDE_MURP, NPC_ALLIANCE_LEGOSO,
         NPC_HORDE_KILRATH, NPC_ALLIANCE_ABRAHMIS,
         NPC_HORDE_STRONGHOOF, NPC_ALLIANCE_STOUTHANDLE,
         NPC_ALLIANCE_ABRAHMIS, NPC_ALLIANCE_TESSA,
         NPC_HORDE_DARDOSH, NPC_ALLIANCE_ZANNETH,
         NPC_ALLIANCE_DAMERON, NPC_HORDE_MUKAR,
         NPC_ALLIANCE_MAGRUDER, NPC_HORDE_ROSSLAI);
    if (!result)
        sLog->outError(LOG_FILTER_BATTLEGROUND, "Cannot find siege workshop master or spirit guides in creature!");
    else
    {
        do
        {
            // Position posHorde, posAlli;
            Field *fields = result->Fetch();
            switch(fields[1].GetUInt32())
            {
                case NPC_GNOMISH_DEMOLISHER:
                case NPC_GOBLIN_MECHANIC:
                    engineers.push_back(fields[0].GetUInt32());
                    break;
                case NPC_DWARVEN_SPIRIT_GUIDE:
                case NPC_TAUNKA_SPIRIT_GUIDE:
                    spiritGuides.push_back(fields[0].GetUInt32());
                    break;
                default:
                    //RelocateCreature(fields[0].GetUInt32());
                    break;
            }
        }while(result->NextRow());
    }

    // Select POI
    AreaPOIList areaPOIs;
    float minX = 9999, minY = 9999, maxX = -9999, maxY = -9999;
    for (uint32 i = 0; i < sAreaPOIStore.GetNumRows(); ++i)
    {
        const AreaPOIEntry * poiInfo = sAreaPOIStore.LookupEntry(i);
        if (poiInfo && poiInfo->zoneId == ZONE_WINTERGRASP)
        {
            areaPOIs.push_back(poiInfo);
            if (minX > poiInfo->x) minX = poiInfo->x;
            if (minY > poiInfo->y) minY = poiInfo->y;
            if (maxX < poiInfo->x) maxX = poiInfo->x;
            if (maxY < poiInfo->y) maxY = poiInfo->y;
        }
    }
    minX -= 20; minY -= 20; maxX += 20; maxY += 20;

    // Coords: 4290.330078, 1790.359985 - 5558.379883, 4048.889893
    result = WorldDatabase.PQuery("SELECT guid FROM gameobject,gameobject_template"
        " WHERE gameobject.map=571"
        " AND gameobject.position_x>%f AND gameobject.position_y>%f"
        " AND gameobject.position_x<%f AND gameobject.position_y<%f"
        " AND gameobject_template.type=33"
        " AND gameobject.id=gameobject_template.entry",
        minX, minY, maxX, maxY);
    if (!result)
        return false;

    do
    {
        Field *fields = result->Fetch();

        uint32 guid = fields[0].GetUInt32();
        GameObjectData const * goData = sObjectMgr->GetGOData(guid);
        if (!goData) // this should not happen
            continue;

        float x = goData->posX, y = goData->posY;
        float minDist = 100;
        AreaPOIList::iterator poi = areaPOIs.end();
        for (AreaPOIList::iterator itr = areaPOIs.begin(); itr != areaPOIs.end(); ++itr)
        {
            if (!(*itr)->icon[1]) // note: may for other use
                continue;

            float dist = (abs((*itr)->x - x) + abs((*itr)->y - y));
            if (minDist > dist)
            {
                minDist = dist;
                poi = itr;
            }
        }

        if (poi == areaPOIs.end())
            continue;

        // add building to the list
        TeamId teamId = x > POS_X_CENTER ? getDefenderTeam() : getAttackerTeam();
        m_buildingStates[guid] = new BuildingState((*poi)->worldState, teamId, getDefenderTeam() != TEAM_ALLIANCE);
        if ((*poi)->id == 2246)
            m_gate = m_buildingStates[guid];
        areaPOIs.erase(poi);

        // add capture point
        uint32 capturePointEntry = 0;

        switch(goData->id)
        {
            case 192028: // NW
            case 192030: // W
            case 192032: // SW
                capturePointEntry = 190475;
                break;
            case 192029: // NE
            case 192031: // E
            case 192033: // SE
                capturePointEntry = 190487;
                break;
        }

        if (capturePointEntry)
        {
            uint32 engGuid = 0;
            uint32 spiritGuid = 0;

            // Find closest Engineer to Workshop
            float minDist = 100;
            for (std::list<uint32>::iterator itr = engineers.begin(); itr != engineers.end(); ++itr)
            {
                const CreatureData *creData = sObjectMgr->GetCreatureData(*itr);
                if (!creData)
                    continue;

                float dist = (abs(creData->posX - x) + abs(creData->posY - y));
                if (minDist > dist)
                {
                    minDist = dist;
                    engGuid = *itr;
                }
            }

            if (!engGuid)
            {
                sLog->outError(LOG_FILTER_BATTLEGROUND, "Cannot find nearby siege workshop master!");
                continue;
            }
            else
                engineers.remove(engGuid);
            // Find closest Spirit Guide to Workshop
            minDist = 255;
            for (std::list<uint32>::iterator itr = spiritGuides.begin(); itr != spiritGuides.end(); ++itr)
            {
                const CreatureData *creData = sObjectMgr->GetCreatureData(*itr);
                if (!creData)
                    continue;

                float dist = (abs(creData->posX - x) + abs(creData->posY - y));
                if (minDist > dist)
                {
                    minDist = dist;
                    spiritGuid = *itr;
                }
            }

            // Inside fortress won't be capturable
            OPvPCapturePointWG *workshop = new OPvPCapturePointWG(this, m_buildingStates[guid]);
            if (goData->posX < POS_X_CENTER && !workshop->SetCapturePointData(capturePointEntry, goData->mapid, goData->posX + 40 * cos(goData->orientation + M_PI / 2), goData->posY + 40 * sin(goData->orientation + M_PI / 2), goData->posZ))
            {
                delete workshop;
                sLog->outError(LOG_FILTER_BATTLEGROUND, "Cannot add capture point!");
                continue;
            }

            const CreatureData *creatureData = sObjectMgr->GetCreatureData(engGuid);
            if (!creatureData)
                continue;

            workshop->m_engEntry = const_cast<uint32*>(&creatureData->id);
            const_cast<CreatureData*>(creatureData)->displayid = 0;
            workshop->m_engGuid = engGuid;

            // Back spirit is linked to one of the inside workshops, 1 workshop wont have spirit
            if (spiritGuid)
            {
                spiritGuides.remove(spiritGuid);

                const CreatureData *spiritData = sObjectMgr->GetCreatureData(spiritGuid);
                if (!spiritData)
                    continue;

                workshop->m_spiEntry = const_cast<uint32*>(&spiritData->id);
                const_cast<CreatureData*>(spiritData)->displayid = 0;
                workshop->m_spiGuid = spiritGuid;
            }
            else
                workshop->m_spiGuid = 0;
            workshop->m_workshopGuid = guid;
            AddCapturePoint(workshop);
            m_buildingStates[guid]->type = BUILDING_WORKSHOP;
            workshop->SetTeamByBuildingState();
        }
    } while(result->NextRow());

    engineers.clear();
    spiritGuides.clear();

    if (!m_gate)
    {
        sLog->outError(LOG_FILTER_BATTLEGROUND, "Cannot find wintergrasp fortress gate!");
        return false;
    }

    // Load Graveyard
    GraveYardContainer::const_iterator graveLow  = sObjectMgr->GraveYardStore.lower_bound(ZONE_WINTERGRASP);
    GraveYardContainer::const_iterator graveUp   = sObjectMgr->GraveYardStore.upper_bound(ZONE_WINTERGRASP);
    for (AreaPOIList::iterator itr = areaPOIs.begin(); itr != areaPOIs.end();)
    {
        if ((*itr)->icon[1] == 8)
        {
            // find or create grave yard
            const WorldSafeLocsEntry *loc = sObjectMgr->GetClosestGraveYard((*itr)->x, (*itr)->y, (*itr)->z, (*itr)->mapId, 0);
            if (!loc)
            {
                ++itr;
                continue;
            }

            GraveYardContainer::const_iterator graveItr;
            for (graveItr = graveLow; graveItr != graveUp; ++graveItr)
                if (graveItr->second.safeLocId == loc->ID)
                    break;
            if (graveItr == graveUp)
            {
                GraveYardData graveData;
                graveData.safeLocId = loc->ID;
                graveData.team = 0;
                graveItr = sObjectMgr->GraveYardStore.insert(std::make_pair(ZONE_WINTERGRASP, graveData));
            }

            for (BuildingStateMap::iterator stateItr = m_buildingStates.begin(); stateItr != m_buildingStates.end(); ++stateItr)
            {
                if (stateItr->second->worldState == (*itr)->worldState)
                {
                    stateItr->second->graveTeam = const_cast<uint32*>(&graveItr->second.team);
                    break;
                }
            }
            areaPOIs.erase(itr++);
        }
        else
            ++itr;
    }

    // Titan Relic
    sObjectMgr->AddGOData(GO_TITAN_RELIC, 571, 5440.0f, 2840.8f, 430.43f, 0.0f);

    if (m_SpecialSpi && m_SpecialEng)
    {
        if (getDefenderTeam() == TEAM_ALLIANCE)
        {
            _RespawnCreatureIfNeeded(m_SpecialSpi, NPC_DWARVEN_SPIRIT_GUIDE);
            _RespawnCreatureIfNeeded(m_SpecialEng, NPC_GNOMISH_DEMOLISHER);
        }
        else
        {
            _RespawnCreatureIfNeeded(m_SpecialSpi, NPC_TAUNKA_SPIRIT_GUIDE);
            _RespawnCreatureIfNeeded(m_SpecialEng, NPC_GOBLIN_MECHANIC);
        }
    }

    _LoadTeamPair(m_goDisplayPair, OutdoorPvPWGGODisplayPair);
    _LoadTeamPair(m_creEntryPair, OutdoorPvPWGCreEntryPair);

    sWorld->SendWintergraspState();
    m_towerDamagedCount[TEAM_ALLIANCE] = 0;
    m_towerDestroyedCount[TEAM_ALLIANCE] = 0;
    m_towerDamagedCount[TEAM_HORDE] = 0;
    m_towerDestroyedCount[TEAM_HORDE] = 0;

    RemoveOfflinePlayerWGAuras();

    RegisterZone(ZONE_WINTERGRASP);

    if (m_wartime)
    {
        uint32 m_WSTimer = m_timer;
        StartBattle();
        m_timer = m_WSTimer;
    }

    return true;
}

void OutdoorPvPWG::ProcessEvent(WorldObject* object, uint32 eventId)
{
    if (object->GetTypeId() != TYPEID_GAMEOBJECT)
        return;

    GameObject* gameObject = object->ToGameObject();

    if (gameObject->GetEntry() == GO_TITAN_RELIC)
    {
        if (gameObject->GetGOInfo()->goober.eventId == eventId && isWarTime() && m_gate && m_gate->damageState == DAMAGE_DESTROYED)
        {
            // Determine whether this round was eligible for the max 10-Minute timed attack run
            m_within_our_grasp_eligible = m_timer >= 20 * MINUTE * IN_MILLISECONDS;

            m_changeDefender = true;
            m_timer = 0;
        }
    }
    else if (gameObject->GetGoType() == GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING)
    {
        BuildingStateMap::const_iterator itr = m_buildingStates.find(gameObject->GetDBTableGUIDLow());
        if (itr == m_buildingStates.end())
            return;

        uint32 towerAreaCredit;
        std::string msgStr;
        switch(eventId)
        { // TODO - Localized msgs of GO names
            case 19672: case 19675: // Flamewatch Tower
                msgStr = "Flamewatch";
                towerAreaCredit = AREA_FLAMEWATCH_TOWER;
                break;
            case 19674: case 19677: // Shadowsight Tower
                msgStr = "Shadowsight";
                towerAreaCredit = AREA_SHADOWSIGHT_TOWER;
                break;
            case 19673: case 19676: // Winter's Edge Tower
                msgStr = "Winter's Edge";
                towerAreaCredit = AREA_WINTERSEDGE_TOWER;
                break;
            case 19776: case 19778: // E Workshop damaged
                msgStr = "Sunken Ring";
                break;
            case 19777: case 19779: // W Workshop damaged
                msgStr = "Broken Temple";
                break;
            case 19782: case 19786: // NW Workshop damaged
                msgStr = "north-western";
                break;
            case 19783: case 19787: // NE Workshop damaged
                msgStr = "north-eastern";
                break;
            case 19784: case 19788: // SW Workshop damaged
                msgStr = "Westpark";
                break;
            case 19785: case 19789: // SE Workshop damaged
                msgStr = "Eastpark";
                break;
            case 19657: case 19661: // NW Wintergrasp Keep Tower damaged
                msgStr = "north-western";
                break;
            case 19658: case 19663: // NE Wintergrasp Keep Tower damaged
                msgStr = "north-eastern";
                break;
            case 19659: case 19662: // SW Wintergrasp Keep Tower damaged
                msgStr = "south-western";
                break;
            case 19660: case 19664: // SE Wintergrasp Keep Tower damaged
                msgStr = "south-eastern";
                break;
            default:
                msgStr = "";
                break;
        }

        BuildingState *state = itr->second;
        if (eventId == gameObject->GetGOInfo()->building.damagedEvent)
        {
            state->damageState = DAMAGE_DAMAGED;
            switch(state->type)
            {
                case BUILDING_WORKSHOP:
                    msgStr = fmtstring(sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_WORKSHOP_DAMAGED), msgStr.c_str(), sObjectMgr->GetTrinityStringForDBCLocale(getDefenderTeam() == TEAM_ALLIANCE ? LANG_BG_AB_ALLY : LANG_BG_AB_HORDE));
                    sWorld->SendZoneText(ZONE_WINTERGRASP, msgStr.c_str());
                    break;
                case BUILDING_WALL:
                    sWorld->SendZoneText(ZONE_WINTERGRASP, sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_FORTRESS_UNDER_ATTACK));
                    if (getDefenderTeam() == TEAM_ALLIANCE) {
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_SOUND_KEEP_ASSAULTED_HORDE);
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_SOUND_KEEP_ASSAULTED_HORDE);
                    }
                    else {
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_SOUND_KEEP_ASSAULTED_ALLIANCE);
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_SOUND_KEEP_ASSAULTED_ALLIANCE);
                    }
                    break;
                case BUILDING_TOWER:
                    ++m_towerDamagedCount[state->GetTeam()];
                    msgStr = fmtstring(sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_TOWER_DAMAGED), msgStr.c_str());
                    sWorld->SendZoneText(ZONE_WINTERGRASP, msgStr.c_str());
                    if (getDefenderTeam() == TEAM_ALLIANCE) {
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_HORDE);
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_HORDE);
                    }
                    else {
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_ALLIANCE);
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_ALLIANCE);
                    }
                    break;
            }
        }
        else if (eventId == gameObject->GetGOInfo()->building.destroyedEvent)
        {
            state->damageState = DAMAGE_DESTROYED;

            switch(state->type)
            {
                case BUILDING_WORKSHOP:
                    ModifyWorkshopCount(state->GetTeam(), false);
                    msgStr = fmtstring(sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_WORKSHOP_DESTROYED), msgStr.c_str(), sObjectMgr->GetTrinityStringForDBCLocale(getDefenderTeam() == TEAM_ALLIANCE ? LANG_BG_AB_ALLY : LANG_BG_AB_HORDE));
                    sWorld->SendZoneText(ZONE_WINTERGRASP, msgStr.c_str());
                    break;
                case BUILDING_WALL:
                    sWorld->SendZoneText(ZONE_WINTERGRASP, sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_FORTRESS_UNDER_ATTACK));
                    if (getDefenderTeam() == TEAM_ALLIANCE) {
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_HORDE);
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_HORDE);
                    }
                    else {
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_ALLIANCE);
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_SOUND_KEEP_CAPTURED_ALLIANCE);
                    }
                    break;
                case BUILDING_TOWER:
                    --m_towerDamagedCount[state->GetTeam()];
                    ++m_towerDestroyedCount[state->GetTeam()];
                    if (state->GetTeam() == getAttackerTeam())
                    {
                        TeamCastSpell(getAttackerTeam(), -SPELL_TOWER_CONTROL);
                        TeamCastSpell(getDefenderTeam(), -SPELL_TOWER_CONTROL);
                        uint32 attStack = 3 - m_towerDestroyedCount[getAttackerTeam()];

                        if (m_towerDestroyedCount[getAttackerTeam()])
                        {
                            // Set all cannons in destroyed towers area invisible
                            if (towerAreaCredit > 0)
                            {
                                for (CreatureSet::iterator itr = m_creatures.begin(); itr != m_creatures.end(); ++itr)
                                {
                                    Creature* creature = (*itr);
                                    if (GetCreatureType(creature->GetEntry()) == CREATURE_TURRET && creature->GetAreaId() == towerAreaCredit)
                                    {
                                        creature->GetVehicleKit()->RemoveAllPassengers();
                                        creature->SetVisible(false);
                                    }
                                }
                            }

                            for (PlayerSet::iterator itr = m_players[getDefenderTeam()].begin(); itr != m_players[getDefenderTeam()].end(); ++itr)
                            {
                                if ((*itr)->getLevel() >= WG_MIN_LEVEL)
                                    (*itr)->SetAuraStack(SPELL_TOWER_CONTROL, (*itr), m_towerDestroyedCount[getAttackerTeam()]);
                                if ((*itr)->GetAreaId() == towerAreaCredit)
                                {
                                    // quest credit
                                    (*itr)->KilledMonsterCredit(NPC_SOUTHERN_TOWER_CREDIT, (*itr)->GetGUID());
                                    // leaning tower achievement credit
                                    (*itr)->GetAchievementMgr().UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 20723);
                                }
                            }
                        }

                        if (attStack)
                        {
                            for (PlayerSet::iterator itr = m_players[getAttackerTeam()].begin(); itr != m_players[getAttackerTeam()].end(); ++itr)
                                if ((*itr)->getLevel() >= WG_MIN_LEVEL)
                                    (*itr)->SetAuraStack(SPELL_TOWER_CONTROL, (*itr), attStack);
                        }
                        else
                        {
                            if (m_timer < 600000)
                                m_timer = 0;
                            else
                                m_timer = m_timer - 600000; // - 10 mins
                        }
                    }
                    msgStr = fmtstring(sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_TOWER_DESTROYED), msgStr.c_str());
                    sWorld->SendZoneText(ZONE_WINTERGRASP, msgStr.c_str());
                    if (getDefenderTeam() == TEAM_ALLIANCE) {
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_HORDE_CAPTAIN);
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_HORDE_CAPTAIN);
                    }
                    else {
                        PlayTeamSound(TEAM_HORDE, OutdoorPvP_WG_ALLIANCE_CAPTAIN);
                        PlayTeamSound(TEAM_ALLIANCE, OutdoorPvP_WG_ALLIANCE_CAPTAIN);
                    }
                    break;
            }
            BroadcastStateChange(state);
        }
    }
}

void OutdoorPvPWG::RemoveOfflinePlayerWGAuras()
{
    // if server crashed while in battle there could be players with rank or tenacity or eternal immunity
    CharacterDatabase.PExecute("DELETE FROM character_aura WHERE spell IN (%u, %u, %u, %u, %u, %u)",
        SPELL_RECRUIT, SPELL_CORPORAL, SPELL_LIEUTENANT, SPELL_TENACITY, SPELL_TOWER_CONTROL, SPELL_SPIRITUAL_IMMUNITY);
}

void OutdoorPvPWG::ModifyWorkshopCount(TeamId team, bool add)
{
    if (team == TEAM_NEUTRAL)
        return;

    if (add)
        ++m_workshopCount[team];
    else if (m_workshopCount[team])
        --m_workshopCount[team];
    else
        sLog->outError(LOG_FILTER_BATTLEGROUND, "OutdoorPvPWG::ModifyWorkshopCount: negative workshop count!");

    SendUpdateWorldState(MaxVehNumWorldState[team], m_workshopCount[team] * MAX_VEHICLE_PER_WORKSHOP);
}

uint32 OutdoorPvPWG::GetCreatureEntry(uint32 guidlow, const CreatureData *data)
{
    if (getDefenderTeam() == TEAM_ALLIANCE)
    {
        TeamPairMap::const_iterator itr = m_creEntryPair.find(data->id);
        if (itr != m_creEntryPair.end())
        {
            const_cast<CreatureData*>(data)->displayid = 0;
            return itr->second;
        }
    }
    return data->id;
}

OutdoorPvPWGCreType OutdoorPvPWG::GetCreatureType(uint32 entry) const
{
    // VEHICLES, GUARDS and TURRETS gives kill credit
    // OTHER Not in wartime
    // TURRET Only during wartime
    // SPECIAL like "OTHER" but no despawn conditions
    // Entries like Case A: Case: B have their own despawn function
    switch(entry)
    {
        case NPC_WG_CATAPULT:
        case NPC_WG_DEMOLISHER:
        case NPC_ALLIANCE_SIEGE_ENGINE:
        case NPC_HORDE_SIEGE_ENGINE:
        case NPC_HORDE_TURRET:
        case NPC_ALLIANCE_TURRET:
            return CREATURE_SIEGE_VEHICLE;
        case NPC_TOWER_CANNON:
            return CREATURE_TURRET;
        case NPC_GNOMISH_DEMOLISHER: // Alliance Engineer
        case NPC_GOBLIN_MECHANIC: // Horde Engineer
            return CREATURE_ENGINEER;
        case NPC_HORDE_CHAMPION:
        case NPC_ALLIANCE_CHAMPION:
        case NPC_HORDE_GUARD:
        case NPC_ALLIANCE_GUARD:
            return CREATURE_GUARD;
        case NPC_DWARVEN_SPIRIT_GUIDE:
        case NPC_TAUNKA_SPIRIT_GUIDE:
            return CREATURE_SPIRIT_GUIDE;
        case NPC_SPIRIT_HEALER:
            return CREATURE_SPIRIT_HEALER;
        case NPC_HORDE_FUJIN:
        case NPC_ALLIANCE_KAYLANA:
        case NPC_HORDE_BLAZEFEATHER:
        case NPC_ALLIANCE_RANDOLPH:
        case NPC_HORDE_MURP:
        case NPC_ALLIANCE_LEGOSO:
        case NPC_HORDE_KILRATH:
        case NPC_ALLIANCE_ABRAHMIS:
        case NPC_HORDE_STRONGHOOF:
        case NPC_ALLIANCE_STOUTHANDLE:
        case NPC_HORDE_MULFORT:
        case NPC_ALLIANCE_TESSA:
        case NPC_HORDE_DARDOSH:
        case NPC_ALLIANCE_ZANNETH:
            return CREATURE_QUESTGIVER;
        case NPC_HORDE_WARBRINGER:
        case NPC_ALLIANCE_GENERAL:
        case NPC_HORDE_MUKAR:
        case NPC_ALLIANCE_DAMERON:
        case NPC_ALLIANCE_MAGRUDER:
        case NPC_HORDE_ROSSLAI:
        case NPC_ALLIANCE_SAFEFLIGHT:
        case NPC_HORDE_SAFEFLIGHT:
            return CREATURE_SPECIAL;
        default:
            return CREATURE_OTHER; // Revenants, Elementals, etc
    }
}

void OutdoorPvPWG::OnCreatureCreate(Creature *creature)
{
    if (!creature)
        return;

    HandleCreatureSpawning(creature, true);

    // relocate initial spawns of questgivers and vendors directly on spawn
    if (GetCreatureType(creature->GetEntry()) == CREATURE_QUESTGIVER ||
            GetCreatureType(creature->GetEntry()) == CREATURE_SPECIAL)
            RelocateCreature(creature);
}

void OutdoorPvPWG::OnCreatureRemove(Creature *creature)
{
    if (!creature)
        return;

    HandleCreatureSpawning(creature, false);
}

void OutdoorPvPWG::HandleCreatureSpawning(Creature *creature, bool add)
{
    uint32 entry = creature->GetEntry();
    switch(GetCreatureType(entry))
    {
        case CREATURE_SIEGE_VEHICLE:
        {
            if (!creature->isSummon())
                return;

            TeamId team;
            if (add)
            {
                if (creature->getFaction() == WintergraspFaction[TEAM_ALLIANCE])
                    team = TEAM_ALLIANCE;
                else if (creature->getFaction() == WintergraspFaction[TEAM_HORDE])
                    team = TEAM_HORDE;
                else
                    return;

                if (uint32 engLowguid = GUID_LOPART(((TempSummon*)creature)->GetSummonerGUID()))
                {
                    if (OPvPCapturePointWG *workshop = GetWorkshopByEngGuid(engLowguid))
                    {
                        if (CanBuildVehicle(workshop))
                        {
                            m_vehicles[team].insert(creature);
                            //workshop->m_vehicles.insert(creature);
                        }
                        else
                        {
                            creature->setDeathState(DEAD);
                            creature->SetRespawnTime(DAY);
                            return;
                        }
                    }
                }

                if (tenacityStackCount > 0 && team == TEAM_ALLIANCE)
                    creature->SetAuraStack(SPELL_TENACITY_VEHICLE, creature, tenacityStackCount);
                else if (tenacityStackCount < 0 && team == TEAM_HORDE)
                    creature->SetAuraStack(SPELL_TENACITY_VEHICLE, creature, -tenacityStackCount);
            }
            else // the faction may be changed in uncharm
            {
                // TODO: now you have to wait until the corpse of vehicle disappear to build a new one
                if (m_vehicles[TEAM_ALLIANCE].erase(creature))
                    team = TEAM_ALLIANCE;
                else if (m_vehicles[TEAM_HORDE].erase(creature))
                    team = TEAM_HORDE;
                else
                    return;
            }
            SendUpdateWorldState(VehNumWorldState[team], m_vehicles[team].size());
            break;
        }
        case CREATURE_QUESTGIVER:
            if (add)
                m_questgivers[creature->GetDBTableGUIDLow()] = creature;
            else
                m_questgivers.erase(creature->GetDBTableGUIDLow());
            RelocateCreature(creature);
            break;
        case CREATURE_ENGINEER:
            // Find special engineer guid by position
            if (creature->GetDistance(5392.9f, 2975.2f, 415.2f) <= 20.0f)
            {
                m_SpecialEng = creature;

                if (m_SpecialEng)
                {
                    if (getDefenderTeam() == TEAM_ALLIANCE)
                        _RespawnCreatureIfNeeded(m_SpecialEng, NPC_GNOMISH_DEMOLISHER);
                    else
                        _RespawnCreatureIfNeeded(m_SpecialEng, NPC_GOBLIN_MECHANIC);
                }

                break;
            }

            for (OutdoorPvP::OPvPCapturePointMap::iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
            {
                if (OPvPCapturePointWG *workshop = dynamic_cast<OPvPCapturePointWG*>(itr->second))
                    if (workshop->m_engGuid == creature->GetDBTableGUIDLow())
                    {
                        workshop->m_engineer = add ? creature : NULL;
                        break;
                    }
            }
            break;
        case CREATURE_SPIRIT_GUIDE:
            // Find special engineer guid by position
            if (creature->GetDistance(5538.0f, 2895.8f, 517.0f) <= 20.0f)
            {
                this->
                m_SpecialSpi = creature;

                if (m_SpecialSpi)
                {
                    if (getDefenderTeam() == TEAM_ALLIANCE)
                        _RespawnCreatureIfNeeded(m_SpecialSpi, NPC_DWARVEN_SPIRIT_GUIDE);
                    else
                        _RespawnCreatureIfNeeded(m_SpecialSpi, NPC_TAUNKA_SPIRIT_GUIDE);
                }

                break;
            }

            for (OutdoorPvP::OPvPCapturePointMap::iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
            {
                if (OPvPCapturePointWG *workshop = dynamic_cast<OPvPCapturePointWG*>(itr->second))
                    if (workshop->m_spiGuid == creature->GetDBTableGUIDLow())
                    {
                        workshop->m_spiritguide = add ? creature : NULL;
                        break;
                    }
            }
            creature->CastSpell(creature, SPELL_SPIRITUAL_IMMUNITY, true);
        case CREATURE_SPIRIT_HEALER:
        case CREATURE_TURRET:
        case CREATURE_OTHER:
            if (add)
                UpdateCreatureInfo(creature);
        default:
            if (add)
                m_creatures.insert(creature);
            else
                m_creatures.erase(creature);
            RelocateCreature(creature);
            break;
    }
}

void OutdoorPvPWG::OnGameObjectCreate(GameObject *go)
{
    if (!go)
        return;

    HandleGameObjectSpawning(go, true);
}

void OutdoorPvPWG::OnGameObjectRemove(GameObject *go)
{
    if (!go)
        return;

    HandleGameObjectSpawning(go, false);
}

void OutdoorPvPWG::HandleGameObjectSpawning(GameObject *go, bool add)
{
    if (add)
        OutdoorPvP::OnGameObjectCreate(go);
    else
        OutdoorPvP::OnGameObjectRemove(go);

    if (UpdateGameObjectInfo(go))
    {
        if (add) m_gobjects.insert(go);
        else m_gobjects.erase(go);
    }
    //do we need to store building?
    else if (go->GetGoType() == GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING)
    {
        BuildingStateMap::const_iterator itr = m_buildingStates.find(go->GetDBTableGUIDLow());
        if (itr != m_buildingStates.end())
        {
            itr->second->building = add ? go : NULL;
            if (go->GetGOInfo()->displayId == 7878 || go->GetGOInfo()->displayId == 7900)
                itr->second->type = BUILDING_TOWER;
            if (!add || (itr->second->damageState == DAMAGE_INTACT && !itr->second->health))
                itr->second->health = go->GetGOValue()->Building.Health;
            else
            {
                go->GetGOValue()->Building.Health = itr->second->health;
                if (itr->second->damageState == DAMAGE_DAMAGED)
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED);
                else if (itr->second->damageState == DAMAGE_DESTROYED)
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED);
            }
        }
    }
}

void OutdoorPvPWG::UpdateAllWorldObject()
{
    // update creatures and gameobjects
    for (GameObjectSet::iterator itr = m_gobjects.begin(); itr != m_gobjects.end(); ++itr)
        UpdateGameObjectInfo(*itr);
    for (CreatureSet::iterator itr = m_creatures.begin(); itr != m_creatures.end(); ++itr)
        UpdateCreatureInfo(*itr);
    for (QuestGiverMap::iterator itr = m_questgivers.begin(); itr != m_questgivers.end(); ++itr)
        UpdateQuestGiverPosition((*itr).first, (*itr).second);

    // rebuild and update building states
    RebuildAllBuildings();

    // update capture points
    for (OPvPCapturePointMap::iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
        if (OPvPCapturePointWG *workshop = dynamic_cast<OPvPCapturePointWG*>(itr->second))
            workshop->SetTeamByBuildingState();

    if (m_SpecialSpi && m_SpecialEng)
    {
        if (getDefenderTeam() == TEAM_ALLIANCE)
        {
            _RespawnCreatureIfNeeded(m_SpecialSpi, NPC_DWARVEN_SPIRIT_GUIDE);
            _RespawnCreatureIfNeeded(m_SpecialEng, NPC_GNOMISH_DEMOLISHER);
        }
        else
        {
            _RespawnCreatureIfNeeded(m_SpecialSpi, NPC_TAUNKA_SPIRIT_GUIDE);
            _RespawnCreatureIfNeeded(m_SpecialEng, NPC_GOBLIN_MECHANIC);
        }
    }
}

void OutdoorPvPWG::RebuildAllBuildings()
{
    for (BuildingStateMap::const_iterator itr = m_buildingStates.begin(); itr != m_buildingStates.end(); ++itr)
    {
        if (itr->second->building)
        {
            UpdateGameObjectInfo(itr->second->building);
            itr->second->building->SetDestructibleState(GO_DESTRUCTIBLE_REBUILDING);
            itr->second->health = itr->second->building->GetGOValue()->Building.Health;
            itr->second->building->SetDestructibleState(GO_DESTRUCTIBLE_INTACT, NULL, true);
        }
        else
            itr->second->health = 0;

        if (itr->second->damageState == DAMAGE_DESTROYED)
        {
            if (itr->second->type == BUILDING_WORKSHOP)
                ModifyWorkshopCount(itr->second->GetTeam(), true);
        }

        itr->second->damageState = DAMAGE_INTACT;
        itr->second->SetTeam(getDefenderTeam() == TEAM_ALLIANCE ? OTHER_TEAM(itr->second->defaultTeam) : itr->second->defaultTeam);
    }
    m_towerDamagedCount[TEAM_ALLIANCE] = 0;
    m_towerDestroyedCount[TEAM_ALLIANCE] = 0;
    m_towerDamagedCount[TEAM_HORDE] = 0;
    m_towerDestroyedCount[TEAM_HORDE] = 0;
}

void OutdoorPvPWG::SendInitWorldStatesTo(Player *player) const
{
    WorldPacket data(SMSG_INIT_WORLD_STATES, (4+4+4+2+(m_buildingStates.size()*8)));
    data << uint32(571);
    data << uint32(ZONE_WINTERGRASP);
    data << uint32(0);
    data << uint16(4+2+4+m_buildingStates.size());

    data << uint32(3803) << uint32(getDefenderTeam() == TEAM_ALLIANCE ? 1 : 0);
    data << uint32(3802) << uint32(getDefenderTeam() != TEAM_ALLIANCE ? 1 : 0);
    data << uint32(3801) << uint32(isWarTime() ? 0 : 1);
    data << uint32(3710) << uint32(isWarTime() ? 1 : 0);

    for (uint32 i = 0; i < 2; ++i)
        data << ClockWorldState[i] << m_clock[i];

    data << uint32(3490) << uint32(m_vehicles[TEAM_HORDE].size());
    data << uint32(3491) << m_workshopCount[TEAM_HORDE] * MAX_VEHICLE_PER_WORKSHOP;
    data << uint32(3680) << uint32(m_vehicles[TEAM_ALLIANCE].size());
    data << uint32(3681) << m_workshopCount[TEAM_ALLIANCE] * MAX_VEHICLE_PER_WORKSHOP;

    for (BuildingStateMap::const_iterator itr = m_buildingStates.begin(); itr != m_buildingStates.end(); ++itr)
        itr->second->FillData(data);

    if (player)
        player->GetSession()->SendPacket(&data);
    else
        BroadcastPacket(data);
}

void OutdoorPvPWG::BroadcastStateChange(BuildingState *state) const
{
    if (m_sendUpdate)
        for (uint32 team = 0; team < 2; ++team)
            for (PlayerSet::const_iterator p_itr = m_players[team].begin(); p_itr != m_players[team].end(); ++p_itr)
                state->SendUpdate(*p_itr);
}

// Called at Start and Battle End
bool OutdoorPvPWG::UpdateCreatureInfo(Creature *creature)
{
    if (!creature)
        return false;
    uint32 entry = creature->GetEntry();
    switch(GetCreatureType(entry))
    {
        case CREATURE_TURRET:
            if (isWarTime())
            {
                if (!creature->isAlive())
                    creature->Respawn(true);
                // southern tower cannons
                if (creature->GetAreaId() == AREA_FLAMEWATCH_TOWER ||
                        creature->GetAreaId() == AREA_SHADOWSIGHT_TOWER ||
                        creature->GetAreaId() == AREA_WINTERSEDGE_TOWER)
                    creature->setFaction(WintergraspFaction[getAttackerTeam()]);
                else // fortress cannons
                    creature->setFaction(WintergraspFaction[getDefenderTeam()]);
                creature->SetHealth(creature->GetMaxHealth());
                creature->SetVisible(true);
            }
            else
            {
                if (creature->IsVehicle() && creature->GetVehicleKit())
                    creature->GetVehicleKit()->RemoveAllPassengers();

                if (!creature->isAlive())
                    creature->Respawn(true);

                creature->SetVisible(false);
                creature->setFaction(35);
            }
            return false;
        case CREATURE_OTHER:
            if (isWarTime())
            {
                creature->SetVisible(false);
                creature->setFaction(35);
            }
            else
            {
                creature->RestoreFaction();
                creature->SetVisible(true);
            }
            return false;
        case CREATURE_SPIRIT_GUIDE:
            if (isWarTime())
            {
                creature->SetVisible(true);
                //creature->setDeathState(ALIVE);
            }
            else
            {
                creature->SetVisible(false);
                //creature->setDeathState(DEAD);
            }
            return false;
        case CREATURE_SPIRIT_HEALER:
            creature->SetVisible(isWarTime() ? false : true);
            return false;
        case CREATURE_ENGINEER:
            return false;
        case CREATURE_SIEGE_VEHICLE:
            //creature->DisappearAndDie();
            return false;
        case CREATURE_GUARD:
        {
            TeamPairMap::const_iterator itr = m_creEntryPair.find(creature->GetCreatureData()->id);
            if (itr != m_creEntryPair.end())
            {
                entry = getDefenderTeam() == TEAM_ALLIANCE ? itr->second : itr->first;
                _RespawnCreatureIfNeeded(creature, entry);
            }
            return false;
        }
        case CREATURE_SPECIAL:
            RelocateCreature(creature);
            return false;
        default:
            return false;
    }
}

bool OutdoorPvPWG::UpdateQuestGiverPosition(uint32 guid, Creature *creature)
{
    assert(guid);

    RelocateCreature(creature);

    return true;
}

// Return false = Need to rebuild at battle End/Start
//        true  = no need to rebuild (ie: Banners or teleporters)
bool OutdoorPvPWG::UpdateGameObjectInfo(GameObject *go) const
{
    uint32 attFaction = 35;
    uint32 defFaction = 35;

    if (isWarTime())
    {
        attFaction = WintergraspFaction[getAttackerTeam()];
        defFaction = WintergraspFaction[getDefenderTeam()];

        if (attFaction == 35 || defFaction == 35)
            sLog->outInfo(LOG_FILTER_BATTLEGROUND, "OutdoorPvPWG: (AttackerFaction = %d), (DefenderFaction = %d), which is impossible during battle", attFaction, defFaction);
    }

    switch(go->GetGOInfo()->displayId)
    {
        case 8244: // Defender's Portal - Vehicle Teleporter
            go->SetUInt32Value(GAMEOBJECT_FACTION, WintergraspFaction[getDefenderTeam()]);
            return true;
        case 7967: // Titan relic
            go->SetUInt32Value(GAMEOBJECT_FACTION, WintergraspFaction[getAttackerTeam()]);
            return true;

        case 8165: // Wintergrasp Keep Door
        case 7877: // Wintergrasp Fortress Wall
        case 7878: // Wintergrasp Keep Tower
        case 7906: // Wintergrasp Fortress Gate
        case 7909: // Wintergrasp Wall
            go->SetUInt32Value(GAMEOBJECT_FACTION, defFaction);
            return false;
        case 7900: // Flamewatch Tower - Shadowsight Tower - Winter's Edge Tower
            go->SetUInt32Value(GAMEOBJECT_FACTION, attFaction);
            return false;
        case 8208: // Goblin Workshop
            OPvPCapturePointWG *workshop = GetWorkshopByGOGuid(go->GetGUID());
            if (workshop)
                go->SetUInt32Value(GAMEOBJECT_FACTION, WintergraspFaction[workshop->m_buildingState->GetTeam()]);
            return false;
    }

    // Note: this is only for test, still need db support
    TeamPairMap::const_iterator itr = m_goDisplayPair.find(go->GetGOInfo()->displayId);
    if (itr != m_goDisplayPair.end())
    {
        go->SetUInt32Value(GAMEOBJECT_DISPLAYID, getDefenderTeam() == TEAM_ALLIANCE ?
            itr->second : itr->first);
        return true;
    }
    return false;
}

void OutdoorPvPWG::HandlePlayerEnterZone(Player * player, uint32 zone)
{
    if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
        return;

    if (isWarTime())
    {
        if (player->getLevel() < WG_MIN_LEVEL)
        {
            player->CastSpell(player, SPELL_TELEPORT_DALARAN, true);
            return;
        }
        if (player->getLevel() >= WG_MIN_LEVEL)
        {
            if (!player->HasAura(SPELL_RECRUIT) && !player->HasAura(SPELL_CORPORAL)
                && !player->HasAura(SPELL_LIEUTENANT))
                player->CastSpell(player, SPELL_RECRUIT, true);
            if (player->GetTeamId() == getAttackerTeam())
            {
                if (m_towerDestroyedCount[getAttackerTeam()] < 3)
                    player->SetAuraStack(SPELL_TOWER_CONTROL, player, 3 - m_towerDestroyedCount[getAttackerTeam()]);
            }
            else
            {
                if (m_towerDestroyedCount[getAttackerTeam()])
                    player->SetAuraStack(SPELL_TOWER_CONTROL, player, m_towerDestroyedCount[getAttackerTeam()]);
            }
        }
    }

    SendInitWorldStatesTo(player);
    OutdoorPvP::HandlePlayerEnterZone(player, zone);
    UpdateTenacityStack();
}

// Reapply Auras if needed
void OutdoorPvPWG::HandlePlayerResurrects(Player * player, uint32 zone)
{
    if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
        return;

    if (isWarTime())
    {
        if (player->getLevel() >= WG_MIN_LEVEL)
        {
            // Tenacity
            if ((player->GetTeamId() == TEAM_ALLIANCE && tenacityStackCount > 0) ||
                (player->GetTeamId() == TEAM_HORDE && tenacityStackCount < 0))
            {
                if (player->HasAura(SPELL_TENACITY))
                    player->RemoveAurasDueToSpell(SPELL_TENACITY);

                int32 newStack = tenacityStackCount < 0 ? -tenacityStackCount : tenacityStackCount;
                if (newStack > 20)
                    newStack = 20;
                player->SetAuraStack(SPELL_TENACITY, player, newStack);
            }

            // Tower Control
            if (player->GetTeamId() == getAttackerTeam())
            {
                if (m_towerDestroyedCount[getAttackerTeam()] < 3)
                    player->SetAuraStack(SPELL_TOWER_CONTROL, player, 3 - m_towerDestroyedCount[getAttackerTeam()]);
            }
            else
            {
                if (m_towerDestroyedCount[getAttackerTeam()])
                    player->SetAuraStack(SPELL_TOWER_CONTROL, player, m_towerDestroyedCount[getAttackerTeam()]);
            }
        }
    }
    OutdoorPvP::HandlePlayerResurrects(player, zone);
}

void OutdoorPvPWG::HandlePlayerLeaveZone(Player * plr, uint32 zone)
{
    if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
        return;

    if (!plr->GetSession()->PlayerLogout())
    {
        if (plr->GetVehicle()) // dismiss in change zone case
            plr->GetVehicle()->Dismiss();
        plr->RemoveAurasDueToSpell(SPELL_RECRUIT);
        plr->RemoveAurasDueToSpell(SPELL_CORPORAL);
        plr->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
        plr->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
        plr->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
    }
    plr->RemoveAurasDueToSpell(SPELL_TENACITY);
    OutdoorPvP::HandlePlayerLeaveZone(plr, zone);
    UpdateTenacityStack();
}

void OutdoorPvPWG::PromotePlayer(Player* killer, bool wasPlayerKill) const
{
    /* require player kills for promotion? */
    //if (!wasPlayerKill)
    //    return;

    // player eligible for promote rebalancing?
    uint32 promoteBalance = 1; // default: 1 kill -> 1 charge

    // buff the attacking team on defender winstreak
    uint32 winStreak = getDefenderTeam() == TEAM_ALLIANCE ? allianceWinStreak : hordeWinStreak;
    if (winStreak > 0 && killer->GetTeamId() == getAttackerTeam())
        promoteBalance = winStreak > 5 ? 5 : winStreak;

    for (uint32 i = 0; i < promoteBalance; ++i)
    {
        Aura * aura;

        if (aura = killer->GetAura(SPELL_RECRUIT)) // basic rank, when you join wg
        {
            if (aura->GetStackAmount() >= 5)
            {
                killer->RemoveAura(SPELL_RECRUIT);
                killer->CastSpell(killer, SPELL_CORPORAL, true);
                ChatHandler(killer).PSendSysMessage(LANG_BG_WG_RANK1);
            }
            else
                killer->CastSpell(killer, SPELL_RECRUIT, true);
        }
        else if (aura = killer->GetAura(SPELL_CORPORAL)) // first rank, can build lower level siege engines
        {
            if (aura->GetStackAmount() >= 5)
            {
                killer->RemoveAura(SPELL_CORPORAL);
                killer->CastSpell(killer, SPELL_LIEUTENANT, true); // second rank, can build high level siege engine
                ChatHandler(killer).PSendSysMessage(LANG_BG_WG_RANK2);
            }
            else
                killer->CastSpell(killer, SPELL_CORPORAL, true);
        }
    }
}

void OutdoorPvPWG::HandleKill(Player *killer, Unit *victim)
{
    if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED) || !isWarTime())
        return;

    // Handle special case : duel of same faction players; should not promote player
    if (killer && victim)
        if (killer->GetTypeId() == TYPEID_PLAYER && victim->GetTypeId() == TYPEID_PLAYER)
            if (killer->GetTeam() == victim->ToPlayer()->GetTeam())
                return;

    bool wasPlayerKill = false;
    if (victim->GetTypeId() == TYPEID_PLAYER)
    {
        wasPlayerKill = true;
        killer->RewardPlayerAndGroupAtEvent(CRE_PVP_KILL, victim);
    }
    else
    {
        switch(GetCreatureType(victim->GetEntry()))
        {
            case CREATURE_SIEGE_VEHICLE:
                killer->RewardPlayerAndGroupAtEvent(CRE_PVP_KILL_V, victim);
                break;
            case CREATURE_GUARD:
                killer->RewardPlayerAndGroupAtEvent(CRE_PVP_KILL, victim);
                break;
            case CREATURE_TURRET:
                break;
        }
    }

    if (Group *pGroup = killer->GetGroup())
    {
        for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
            if (itr->getSource()->IsAtGroupRewardDistance(killer) && itr->getSource()->getLevel() >= WG_MIN_LEVEL)
                PromotePlayer(itr->getSource(), wasPlayerKill);
    }
    else if (killer->getLevel() >= WG_MIN_LEVEL)
        PromotePlayer(killer, wasPlayerKill);
}

// Recalculates Tenacity and applies it to Players / Vehicles
void OutdoorPvPWG::UpdateTenacityStack()
{
    if (!isWarTime())
        return;

    TeamId team = TEAM_NEUTRAL;
    uint32 allianceNum = 0;
    uint32 hordeNum = 0;
    int32 newStack = 0;

    for (PlayerSet::iterator itr = m_players[TEAM_ALLIANCE].begin(); itr != m_players[TEAM_ALLIANCE].end(); ++itr)
    {
        Player* player = (*itr);
        if (player->getLevel() >= WG_MIN_LEVEL && !player->isGameMaster() &&
                !player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) && !player->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_TAXI_FLIGHT))
            ++allianceNum;
    }

    for (PlayerSet::iterator itr = m_players[TEAM_HORDE].begin(); itr != m_players[TEAM_HORDE].end(); ++itr)
    {
        Player* player = (*itr);
        if (player->getLevel() >= WG_MIN_LEVEL && !player->isGameMaster() &&
                !player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) && !player->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_TAXI_FLIGHT))
            ++hordeNum;
    }

    if (allianceNum && hordeNum)
    {
        if (allianceNum < hordeNum)
            newStack = int32((float(hordeNum) / float(allianceNum) - 1) * 4); // ((A/H)-1)*4 - positive, should cast on alliance
        else if (allianceNum > hordeNum)
            newStack = int32((1 - float(allianceNum) / float(hordeNum)) * 4); // (1-(A/H))*4 - negative, should cast on horde
    }

    if (newStack == tenacityStackCount)
        return;

    if (tenacityStackCount > 0 && newStack <= 0) // old buff was on alliance
        team = TEAM_ALLIANCE;
    else if (tenacityStackCount < 0 && newStack >= 0) // old buff was on horde
        team = TEAM_HORDE;

    tenacityStackCount = newStack;

    // Remove old buff
    if (team != TEAM_NEUTRAL)
    {
        for (PlayerSet::const_iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            if ((*itr)->getLevel() >= WG_MIN_LEVEL && !(*itr)->isGameMaster())
                (*itr)->RemoveAurasDueToSpell(SPELL_TENACITY);

        for (CreatureSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            (*itr)->RemoveAurasDueToSpell(SPELL_TENACITY_VEHICLE);
    }

    // Apply new buff
    if (newStack)
    {
        team = newStack > 0 ? TEAM_ALLIANCE : TEAM_HORDE;
        if (newStack < 0)
            newStack = -newStack;
        if (newStack > 20)
            newStack = 20;

        for (PlayerSet::const_iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            if ((*itr)->getLevel() >= WG_MIN_LEVEL && !(*itr)->isGameMaster())
                (*itr)->SetAuraStack(SPELL_TENACITY, (*itr), newStack);

        for (CreatureSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            (*itr)->SetAuraStack(SPELL_TENACITY_VEHICLE, (*itr), newStack);
    }
}

void OutdoorPvPWG::UpdateClockDigit(uint32 &timer, uint32 digit, uint32 mod)
{
    uint32 value = timer % mod;
    if (m_clock[digit] != value)
    {
        m_clock[digit] = value;
        SendUpdateWorldState(ClockWorldState[digit], (timer + uint32(time(NULL))));
        sWorld->SetWintergrapsTimer(timer + uint32(time(NULL)), digit);
    }
}

void OutdoorPvPWG::UpdateClock()
{
    uint32 timer = m_timer / 1000;
    if (!isWarTime())
        UpdateClockDigit(timer, 1, 10);
    else
        UpdateClockDigit(timer, 0, 10);

     // Announce in all world, comment it if you don't like/need it
     // Announce 30 minutes left
     if ((m_timer < 1800000) && (m_announce_30_done == false) && (m_wartime == false))
     {
         m_announce_30_done = true;
         sWorld->SendMessageToAllPlayersInChannel("pvp", "|TInterface\\Icons\\spell_arcane_teleporttheramore.blp:14|t Die Schlacht um Tausendwinter beginnt in 30 Minuten.");
         // sWorld->SendWorldText(LANG_BG_WG_WORLD_ANNOUNCE_30);
     }

     // Announce 10 minutes left
     if ((m_timer < 600000) && (m_announce_10_done == false) && (m_wartime == false))
     {
         m_announce_10_done = true;
         sWorld->SendMessageToAllPlayersInChannel("pvp", "|TInterface\\Icons\\spell_arcane_teleporttheramore.blp:14|t Die Schlacht um Tausendwinter beginnt in 10 Minuten.");
         // sWorld->SendWorldText(LANG_BG_WG_WORLD_ANNOUNCE_10);
     }

     if ((m_timer < 300000) && (m_announce_5_done == false) && (m_wartime == false))
     {
         m_announce_5_done = true;
         sWorld->SendMessageToAllPlayersInChannel("pvp", "|TInterface\\Icons\\spell_arcane_teleporttheramore.blp:14|t Die Schlacht um Tausendwinter beginnt in 5 Minuten. Der Teleport von Dalaran aus ist nun verfügbar.");
     }
}

bool OutdoorPvPWG::Update(uint32 diff)
{
    if (!sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_ENABLED))
        return false;

    if (m_timer > diff)
    {
        m_timer -= diff;

        if (isWarTime())
        {
            OutdoorPvP::Update(diff); // update capture points

            /*********************************************************/
            /***        BATTLEGROUND RESSURECTION SYSTEM           ***/
            /*********************************************************/

            //this should be handled by spell system
            m_LastResurrectTime += diff;
            if (m_LastResurrectTime >= RESURRECTION_INTERVAL)
            {
                if (GetReviveQueueSize())
                {
                    for (std::map<uint64, std::vector<uint64> >::iterator itr = m_ReviveQueue.begin(); itr != m_ReviveQueue.end(); ++itr)
                    {
                        Creature *sh = NULL;
                        for (std::vector<uint64>::const_iterator itr2 = (itr->second).begin(); itr2 != (itr->second).end(); ++itr2)
                        {
                            Player *plr = ObjectAccessor::FindPlayer(*itr2);
                            if (!plr)
                                continue;

                            if (!sh && plr->IsInWorld())
                            {
                                sh = plr->GetMap()->GetCreature(itr->first);
                                // only for visual effect
                                if (sh)
                                    // Spirit Heal, effect 117
                                    sh->CastSpell(sh, SPELL_SPIRIT_HEAL, true);
                            }

                            // Resurrection visual
                            plr->CastSpell(plr, SPELL_RESURRECTION_VISUAL, true);
                            m_ResurrectQueue.push_back(*itr2);
                        }
                        (itr->second).clear();
                    }

                    m_ReviveQueue.clear();
                    m_LastResurrectTime = 0;
                }
                else
                    // queue is clear and time passed, just update last resurrection time
                    m_LastResurrectTime = 0;
            }
            else if (m_LastResurrectTime > 500)    // Resurrect players only half a second later, to see spirit heal effect on NPC
            {
                for (std::vector<uint64>::const_iterator itr = m_ResurrectQueue.begin(); itr != m_ResurrectQueue.end(); ++itr)
                {
                    Player *plr = ObjectAccessor::FindPlayer(*itr);
                    if (!plr)
                        continue;
                    plr->ResurrectPlayer(1.0f);
                    plr->CastSpell(plr, 6962, true);
                    plr->CastSpell(plr, SPELL_SPIRIT_HEAL_MANA, true);
                    sObjectAccessor->ConvertCorpseForPlayer(*itr);
                }
                m_ResurrectQueue.clear();
            }
        }
        UpdateClock();
    }
    else
    {
        m_sendUpdate = false;
        int32 entry = LANG_BG_WG_DEFENDED;

        if (m_changeDefender)
        {
            m_changeDefender = false;
            m_defender = getAttackerTeam();
            entry = LANG_BG_WG_CAPTURED;
        }

        if (isWarTime())
        {
            if (m_timer != 1) // 1 = forceStopBattle
                sWorld->SendZoneText(ZONE_WINTERGRASP, fmtstring(sObjectMgr->GetTrinityStringForDBCLocale(entry), sObjectMgr->GetTrinityStringForDBCLocale(getDefenderTeam() == TEAM_ALLIANCE ? LANG_BG_AB_ALLY : LANG_BG_AB_HORDE)));
            EndBattle();
        }
        else
        {
            if (m_timer != 1) // 1 = forceStartBattle
                sWorld->SendZoneText(ZONE_WINTERGRASP, sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_BATTLE_STARTS));
            StartBattle();
        }

        UpdateAllWorldObject();
        UpdateClock();

        SendInitWorldStatesTo();
        m_sendUpdate = true;
    }

    if (m_WSSaveTimer < diff)
    {
        sWorld->setWorldState(31001, m_wartime);
        sWorld->setWorldState(31002, m_timer);
        sWorld->setWorldState(31003, m_defender);
        sWorld->setWorldState(31004, allianceWinStreak);
        sWorld->setWorldState(31004, hordeWinStreak);
        m_WSSaveTimer = sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_SAVESTATE_PERIOD);
    } else m_WSSaveTimer -= diff;


    return false;
}

void OutdoorPvPWG::forceStartBattle()
{ // Uptime will do all the work
    m_wartime = false;

    if (m_timer != 1)
    {
        m_timer = 1;
        sWorld->SendZoneText(ZONE_WINTERGRASP, sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_BATTLE_FORCE_START));
    }
        sWorld->SendWintergraspState();
}

void OutdoorPvPWG::forceStopBattle()
{ // Uptime will do all the work.

    if (!isWarTime())
        m_wartime = true;

    if (m_timer != 1)
    {
        m_timer = 1;
        sWorld->SendZoneText(ZONE_WINTERGRASP, sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_BATTLE_FORCE_STOP));
    }
    sWorld->SendWintergraspState();
}

void OutdoorPvPWG::forceChangeTeam()
{
    m_changeDefender = true;
    m_timer = 1;
    sWorld->SendZoneText(ZONE_WINTERGRASP, fmtstring(sObjectMgr->GetTrinityStringForDBCLocale(LANG_BG_WG_SWITCH_FACTION), sObjectMgr->GetTrinityStringForDBCLocale(getAttackerTeam() == TEAM_ALLIANCE ? LANG_BG_AB_ALLY : LANG_BG_AB_HORDE)));
    if (isWarTime())
        forceStartBattle();
    else
        forceStopBattle();
}

void OutdoorPvPWG::StartBattle()
{
    // Can be forced by gm's while during active battle, so reset first
    int defenderCount = 0;
    int attackerCount = 0;
    m_wartime = true;
    m_announce_30_done = false;
    m_announce_10_done = false;
    m_announce_5_done = false;
    m_timer = sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_BATTLE_TIME) * MINUTE * IN_MILLISECONDS;
    m_within_our_grasp_eligible = false; // will be determined on goober click

    for (PlayerSet::iterator itr = m_players[getDefenderTeam()].begin(); itr != m_players[getDefenderTeam()].end(); ++itr)
    {
        Player* player = (*itr);
        if (player->getLevel() < WG_MIN_LEVEL)
            player->CastSpell(player, SPELL_TELEPORT_DALARAN, true);
        else

        {
            defenderCount++;
            player->RemoveAurasByType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED);
            player->RemoveAurasByType(SPELL_AURA_FLY);
            player->PlayDirectSound(OutdoorPvP_WG_SOUND_START_BATTLE);
        }
    }

    for (PlayerSet::iterator itr = m_players[getAttackerTeam()].begin(); itr != m_players[getAttackerTeam()].end(); ++itr)
    {
        Player* player = (*itr);

        // below min level is teleported out of dalaran
        if (player->getLevel() < WG_MIN_LEVEL)
            player->CastSpell(player, SPELL_TELEPORT_DALARAN, true);
        else
        {
            float x, y, z;
            player->GetPosition(x, y, z);
            // remove attacking team from orb room
            if (5500 > x && x > 5392 && y < 2880 && y > 2800 && z < 480)
                player->TeleportTo(571, 5050.899414f, 2847.429688f, 393.129669f, 0.021703f);
            else
            {
                attackerCount++;
                player->RemoveAurasByType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED);
                player->RemoveAurasByType(SPELL_AURA_FLY);
                player->PlayDirectSound(OutdoorPvP_WG_SOUND_START_BATTLE);
            }
        }
    }

    TeamCastSpell(getDefenderTeam(), SPELL_TELEPORT_FORTRESS);

    // Remove Essence of Wintergrasp from all players
    sWorld->setWorldState(WORLDSTATE_WINTERGRASP_CONTROLLING_FACTION, TEAM_NEUTRAL);
    sWorld->UpdateAreaDependentAuras();

    // destroyed all vehicles
    for (uint32 team = 0; team < 2; ++team)
    {
        while(!m_vehicles[team].empty())
        {
            Creature *veh = *m_vehicles[team].begin();
            m_vehicles[team].erase(m_vehicles[team].begin());
            veh->setDeathState(JUST_DIED);
        }
    }

    // Remove All Wintergrasp auras. Add Recruit rank and Tower Control
    for (PlayerSet::iterator itr = m_players[getAttackerTeam()].begin(); itr != m_players[getAttackerTeam()].end(); ++itr)
    {
        Player* player = (*itr);
        player->RemoveAurasDueToSpell(SPELL_RECRUIT);
        player->RemoveAurasDueToSpell(SPELL_CORPORAL);
        player->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
        player->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
        player->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
        if (player->getLevel() >= WG_MIN_LEVEL)
        {
            player->SetAuraStack(SPELL_TOWER_CONTROL, player, 3);
            player->CastSpell(player, SPELL_RECRUIT, true);
        }
    }

    // Remove All Wintergrasp auras. Add Recruit rank
    for (PlayerSet::iterator itr = m_players[getDefenderTeam()].begin(); itr != m_players[getDefenderTeam()].end(); ++itr)
    {
        Player* player = (*itr);
        player->RemoveAurasDueToSpell(SPELL_RECRUIT);
        player->RemoveAurasDueToSpell(SPELL_CORPORAL);
        player->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
        player->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
        player->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
        if (player->getLevel() >= WG_MIN_LEVEL)
            player->CastSpell(player, SPELL_RECRUIT, true);
    }

    // Tenacity Balancing
    UpdateTenacityStack();

    // Update timer in players battlegrounds tab
    sWorld->SendWintergraspState();
}

void OutdoorPvPWG::EndBattle()
{
    // Cast Essence of Wintergrasp to all players (CheckCast will determine who to cast)
    sWorld->setWorldState(WORLDSTATE_WINTERGRASP_CONTROLLING_FACTION, getDefenderTeam());
    sWorld->UpdateAreaDependentAuras();

    // End Battle Sound and Balance Handling
    if (getDefenderTeam() == TEAM_ALLIANCE)
    {
        allianceWinStreak++;
        hordeWinStreak = 0;
        PlayTeamSound(getDefenderTeam(), OutdoorPvP_WG_SOUND_ALLIANCE_WINS);
    }
    else
    {
        allianceWinStreak = 0;
        hordeWinStreak++;
        PlayTeamSound(getDefenderTeam(), OutdoorPvP_WG_SOUND_HORDE_WINS);
    }

    // Lost Battle Sound
    PlayTeamSound(getAttackerTeam(), OutdoorPvP_WG_SOUND_NEAR_VICTORY);

    for (uint32 team = 0; team < 2; ++team)
    {
        // destroyed all vehicles
        while(!m_vehicles[team].empty())
        {
            Creature *vehicle = *m_vehicles[team].begin();
            m_vehicles[team].erase(m_vehicles[team].begin());
            vehicle->setDeathState(JUST_DIED);
        }

        if (m_players[team].empty())
            continue;

        for (PlayerSet::iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
        {
            Player* player = (*itr);
            // When WG ends the zone is cleaned including corpses, revive all players if dead
            if (player->isDead())
            {
                player->ResurrectPlayer(1.0f);
                sObjectAccessor->ConvertCorpseForPlayer(player->GetGUID());
                //ObjectAccessor::Instance().ConvertCorpseForPlayer((*itr)->GetGUID());
            }
            player->RemoveAurasDueToSpell(SPELL_TENACITY);
            player->CombatStop(true);
            player->getHostileRefManager().deleteReferences();
        }

        // Premature end was forced, no rewards
        if (m_timer == 1)
        {
            for (PlayerSet::iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            {
                Player* player = (*itr);
                player->RemoveAurasDueToSpell(SPELL_RECRUIT);
                player->RemoveAurasDueToSpell(SPELL_CORPORAL);
                player->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
                player->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
                player->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
            }
            continue;
        }

        // calculate rewards
        uint32 intactNum = 0;
        uint32 damagedNum = 0;
        for (OutdoorPvP::OPvPCapturePointMap::const_iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
            if (OPvPCapturePointWG *workshop = dynamic_cast<OPvPCapturePointWG*>(itr->second))
                if (workshop->m_buildingState->GetTeam() == team)
                    if (workshop->m_buildingState->damageState == DAMAGE_DAMAGED)
                        ++damagedNum;
                    else if (workshop->m_buildingState->damageState == DAMAGE_INTACT)
                        ++intactNum;

        uint32 spellRewardId = team == getDefenderTeam() ? SPELL_VICTORY_REWARD : SPELL_DEFEAT_REWARD;
        uint32 baseHonor = 0;
        uint32 marks = 0;
        uint32 playersWithRankNum = 0;
        uint32 honor = 0;

        if (sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_CUSTOM_HONOR))
        {
            // Calculate Level 75+ with Corporal or Lieutenant rank
            for (PlayerSet::iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
                if ((*itr)->getLevel() >= WG_MIN_LEVEL && ((*itr)->HasAura(SPELL_LIEUTENANT) || (*itr)->HasAura(SPELL_CORPORAL)))
                    ++playersWithRankNum;

            baseHonor = team == getDefenderTeam() ? sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_WIN_BATTLE) : sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_LOSE_BATTLE);
            baseHonor += (sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_DAMAGED_TOWER) * m_towerDamagedCount[OTHER_TEAM(team)]);
            baseHonor += (sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_DESTROYED_TOWER) * m_towerDestroyedCount[OTHER_TEAM(team)]);
            baseHonor += (sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_INTACT_BUILDING) * intactNum);
            baseHonor += (sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_DAMAGED_BUILDING) * damagedNum);
            if (playersWithRankNum)
                baseHonor /= playersWithRankNum;
        }

        for (PlayerSet::iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
        {
            Player* player = (*itr);

            // No rewards for level < WG_MIN_LEVEL
            if (player->getLevel() < WG_MIN_LEVEL)
                continue;

            // Give out rewards
            if (sWorld->getBoolConfig(CONFIG_OUTDOORPVP_WINTERGRASP_CUSTOM_HONOR))
            {
                if (team == getDefenderTeam())
                {
                    if (player->HasAura(SPELL_LIEUTENANT))
                    {
                        marks = 3;
                        honor = baseHonor;
                    }
                    else if (player->HasAura(SPELL_CORPORAL))
                    {
                        marks = 2;
                        honor = baseHonor;
                    }
                    else
                    {
                        marks = 1;
                        honor = 0;
                    }
                }
                else
                {
                    if (player->HasAura(SPELL_LIEUTENANT))
                    {
                        marks = 1;
                        honor = baseHonor;
                    }
                    else if (player->HasAura(SPELL_CORPORAL))
                    {
                        marks = 1;
                        honor = baseHonor;
                    }
                    else
                    {
                        marks = 0;
                        honor = 0;
                    }
                }
                player->RewardHonor(NULL, 1, honor);
                RewardMarkOfHonor(*itr, marks);

                // update achievements for all spells triggered by wintergrasp victory / loss spell
                player->GetAchievementMgr().UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, spellRewardId);
            }
            else
            {
                // TODO: Spells are broken!
                if (player->HasAura(SPELL_LIEUTENANT) || player->HasAura(SPELL_CORPORAL))
                {
                    // TODO - Honor from SpellReward should be shared by team players
                    // TODO - Marks should be given depending on Rank but 3 are given
                    // each time so Won't give any to recruits
                    player->CastSpell(player, spellRewardId, true);
                    for (uint32 i = 0; i < intactNum; ++i)
                        player->CastSpell(player, SPELL_INTACT_BUILDING, true);
                    for (uint32 i = 0; i < damagedNum; ++i)
                        player->CastSpell(player, SPELL_DAMAGED_BUILDING, true);
                    for (uint32 i = 0; i < m_towerDamagedCount[OTHER_TEAM(team)]; ++i)
                        player->CastSpell(player, SPELL_DAMAGED_TOWER, true);
                    for (uint32 i = 0; i < m_towerDestroyedCount[OTHER_TEAM(team)]; ++i)
                        player->CastSpell(player, SPELL_DESTROYED_TOWER, true);
                }
            }

            if (team == getDefenderTeam())
            {
                if (player->HasAura(SPELL_LIEUTENANT) || player->HasAura(SPELL_CORPORAL))
                {
                    player->AreaExploredOrEventHappens(A_VICTORY_IN_WG);
                    player->AreaExploredOrEventHappens(H_VICTORY_IN_WG);
                }
            }

            // remove obsolete auras
            player->RemoveAurasDueToSpell(SPELL_RECRUIT);
            player->RemoveAurasDueToSpell(SPELL_CORPORAL);
            player->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
            player->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
            player->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
        }
    }

    m_wartime = false;
    m_timer = sWorld->getIntConfig(CONFIG_OUTDOORPVP_WINTERGRASP_INTERVAL) * MINUTE * IN_MILLISECONDS;

    RemoveOfflinePlayerWGAuras();

    // Update timer in players battlegrounds tab
    sWorld->SendWintergraspState();
}

bool OutdoorPvPWG::CanBuildVehicle(OPvPCapturePointWG* workshop) const
{
    TeamId team = workshop->m_buildingState->GetTeam();
    if (team == TEAM_NEUTRAL)
        return false;

    return isWarTime()
        && workshop->m_buildingState->damageState != DAMAGE_DESTROYED
        && m_vehicles[team].size() < m_workshopCount[team] * MAX_VEHICLE_PER_WORKSHOP;
}

uint32 OutdoorPvPWG::GetData(uint32 id)
{
    // can shop build more workshops?
    if (OPvPCapturePointWG *workshop = GetWorkshopByEngGuid(id))
        return CanBuildVehicle(workshop) ? 1 : 0;

    return 0;
}

void OutdoorPvPWG::RewardMarkOfHonor(Player* player, uint32 count)
{
    // 'Inactive' this aura prevents the player from gaining honor points and battleground tokens
    if (player->HasAura(SPELL_AURA_PLAYER_INACTIVE))
        return;
    if (count == 0)
        return;

    ItemPosCountVec dest;
    uint32 no_space_count = 0;
    InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, WG_MARK_OF_HONOR, count, &no_space_count);

    if (msg == EQUIP_ERR_ITEM_NOT_FOUND)
    {
        sLog->outError(LOG_FILTER_BATTLEGROUND, "Wintergrasp reward item (Entry %u) not exist in `item_template`.", WG_MARK_OF_HONOR);
        return;
    }

    if (msg != EQUIP_ERR_OK) // convert to possible store amount
        count -= no_space_count;

    if (count != 0 && !dest.empty()) // can add some
        if (Item* item = player->StoreNewItem(dest, WG_MARK_OF_HONOR, true, 0))
            player->SendNewItem(item, count, true, false);
}

void OutdoorPvPWG::LoadQuestGiverMap(uint32 guid, Position posHorde, Position posAlli)
{
    m_qgPosMap[std::pair<uint32, bool>(guid, true)] = posHorde,
    m_qgPosMap[std::pair<uint32, bool>(guid, false)] = posAlli,
    m_questgivers[guid] = NULL;

    //RelocateCreature(guid);
}

OPvPCapturePointWG *OutdoorPvPWG::GetWorkshop(uint32 lowguid) const
{
    if (OPvPCapturePoint *cp = GetCapturePoint(lowguid))
        return dynamic_cast<OPvPCapturePointWG*>(cp);
    return NULL;
}

OPvPCapturePointWG *OutdoorPvPWG::GetWorkshopByEngGuid(uint32 lowguid) const
{
    for (OutdoorPvP::OPvPCapturePointMap::const_iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
        if (OPvPCapturePointWG *workshop = dynamic_cast<OPvPCapturePointWG*>(itr->second))
            if (workshop->m_engGuid == lowguid)
                return workshop;
    return NULL;
}

OPvPCapturePointWG *OutdoorPvPWG::GetWorkshopByGOGuid(uint64 lowguid) const
{
    for (OutdoorPvP::OPvPCapturePointMap::const_iterator itr = m_capturePoints.begin(); itr != m_capturePoints.end(); ++itr)
        if (OPvPCapturePointWG *workshop = dynamic_cast<OPvPCapturePointWG*>(itr->second))
            if (workshop->m_workshopGuid == lowguid)
                return workshop;
    return NULL;
}

/*########################################################
 * Copy of Battleground system to make Spirit Guides Work
 *#######################################################*/
void OutdoorPvPWG::SendAreaSpiritHealerQueryOpcode(Player *pl, const uint64& guid)
{
    WorldPacket data(SMSG_AREA_SPIRIT_HEALER_TIME, 12);
    uint32 time_ = 30000 - GetLastResurrectTime();      // resurrect every 30 seconds
    if (time_ == uint32(-1))
        time_ = 0;
    data << guid << time_;
    pl->GetSession()->SendPacket(&data);
}

void OutdoorPvPWG::AddPlayerToResurrectQueue(uint64 npc_guid, uint64 player_guid)
{
    m_ReviveQueue[npc_guid].push_back(player_guid);

    Player *plr = ObjectAccessor::FindPlayer(player_guid);
    if (!plr)
        return;

    plr->CastSpell(plr, SPELL_WAITING_FOR_RESURRECT, true);
}

void OutdoorPvPWG::RemovePlayerFromResurrectQueue(uint64 player_guid)
{
    for (std::map<uint64, std::vector<uint64> >::iterator itr = m_ReviveQueue.begin(); itr != m_ReviveQueue.end(); ++itr)
    {
        for (std::vector<uint64>::iterator itr2 =(itr->second).begin(); itr2 != (itr->second).end(); ++itr2)
        {
            if (*itr2 == player_guid)
            {
                (itr->second).erase(itr2);

                Player *plr = ObjectAccessor::FindPlayer(player_guid);
                if (!plr)
                    return;

                plr->RemoveAurasDueToSpell(SPELL_WAITING_FOR_RESURRECT);

                return;
            }
        }
    }
}

void OutdoorPvPWG::RelocateDeadPlayers(Creature* creature)
{
    if (!creature || GetCreatureType(creature->GetEntry()) != CREATURE_SPIRIT_GUIDE)
        return;

    // Those who are waiting to resurrect at this node are taken to the closest own node's graveyard
    std::vector<uint64> ghost_list = m_ReviveQueue[creature->GetGUID()];
    if (!ghost_list.empty())
    {
        WorldSafeLocsEntry const *ClosestGrave = NULL;
        for (std::vector<uint64>::const_iterator itr = ghost_list.begin(); itr != ghost_list.end(); ++itr)
        {
            Player* plr = ObjectAccessor::FindPlayer(*itr);
            if (!plr)
                continue;

            if (!ClosestGrave)
                ClosestGrave = sObjectMgr->GetClosestGraveYard(plr->GetPositionX(), plr->GetPositionY(), plr->GetPositionZ(), plr->GetMapId(), plr->GetTeam());

            if (ClosestGrave)
                plr->TeleportTo(plr->GetMapId(), ClosestGrave->x, ClosestGrave->y, ClosestGrave->z, plr->GetOrientation());
        }
    }
}

/*********************
 * OPvPCapturePointWG
 *********************/

OPvPCapturePointWG::OPvPCapturePointWG(OutdoorPvPWG *opvp, BuildingState *state):
        OPvPCapturePoint(opvp), m_buildingState(state), m_wintergrasp(opvp), m_engineer(NULL), m_engGuid(0), m_spiritguide(NULL), m_spiGuid(0) {}

void OPvPCapturePointWG::SetTeamByBuildingState()
{
    if (m_buildingState->GetTeam() == TEAM_ALLIANCE)
    {
        m_value = m_maxValue;
        m_State = OBJECTIVESTATE_ALLIANCE;
    }
    else if (m_buildingState->GetTeam() == TEAM_HORDE)
    {
        m_value = -m_maxValue;
        m_State = OBJECTIVESTATE_HORDE;
    }
    else
    {
        m_value = 0;
        m_State = OBJECTIVESTATE_NEUTRAL;
    }

    if (m_team != m_buildingState->GetTeam())
    {
        TeamId oldTeam = m_team;
        m_team = m_buildingState->GetTeam();
        ChangeTeam(oldTeam);
    }

    if (!m_capturePoint)
        return;

    // send this too, sometimes the slider disappears, dunno why :(
    // send these updates to only the ones in this objective
    // send this too, sometimes it resets :S
    for (uint32 team = 0; team < 2; ++team)
    {
        // send to all players present in the area
        for (PlayerSet::iterator itr = m_activePlayers[team].begin(); itr != m_activePlayers[team].end(); ++itr)
        {
            if ((*itr))
            {
                if ((*itr)->GetSession())
                {
                    (*itr)->SendUpdateWorldState(m_capturePoint->GetGOInfo()->capturePoint.worldState1,1);
                    (*itr)->SendUpdateWorldState(m_capturePoint->GetGOInfo()->capturePoint.worldstate2,(uint32)ceil((m_value + m_maxValue) / (2 * m_maxValue) * 100.0f));
                    (*itr)->SendUpdateWorldState(m_capturePoint->GetGOInfo()->capturePoint.worldstate3,m_neutralValuePct);
                }
            }
        }
    }
}

void OPvPCapturePointWG::ChangeTeam(TeamId oldTeam)
{
    uint32 entry = 0;
    uint32 guide_entry = 0;

    if (oldTeam != TEAM_NEUTRAL)
        m_wintergrasp->ModifyWorkshopCount(oldTeam, false);

    if (m_team != TEAM_NEUTRAL)
    {
        entry = m_team == TEAM_ALLIANCE ? NPC_GNOMISH_DEMOLISHER : NPC_GOBLIN_MECHANIC;
        guide_entry = m_team == TEAM_ALLIANCE ? NPC_DWARVEN_SPIRIT_GUIDE : NPC_TAUNKA_SPIRIT_GUIDE;
        m_wintergrasp->ModifyWorkshopCount(m_team, true);
    }

    if (m_capturePoint)
        GameObject::SetGoArtKit(CapturePointArtKit[m_team], m_capturePoint, m_capturePointGUID);

    m_buildingState->SetTeam(m_team);
    // TODO: this may be sent twice
    m_wintergrasp->BroadcastStateChange(m_buildingState);

    if (m_buildingState->building)
        m_buildingState->building->SetUInt32Value(GAMEOBJECT_FACTION, WintergraspFaction[m_team]);

    if (entry)
    {
        if (m_engGuid)
        {
            *m_engEntry = entry;
            _RespawnCreatureIfNeeded(m_engineer, entry);
        }
        if (m_spiGuid)
        {
            *m_spiEntry = guide_entry;
            _RespawnCreatureIfNeeded(m_spiritguide, guide_entry);
            m_wintergrasp->RelocateDeadPlayers(m_spiritguide);
        }
    }
    else if (m_engineer)
        m_engineer->SetVisible(false);

    // sLog->outDebug("Wintergrasp workshop now belongs to %u.", (uint32)m_buildingState->GetTeam());
}

/***************************
 * Relocate System
 ***************************/

void OutdoorPvPWG::RelocateTeleport(Creature* creature, Position pos)
{
    creature->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), false);
    creature->SetHomePosition(pos);
}
void OutdoorPvPWG::RelocateSummonDespawn(Creature* creature, bool condition)
{
    if (condition)
    {
        creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
        creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
        creature->SetVisible(true);
    }
    else
    {
        creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
        creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
        creature->SetVisible(false);
    }
}

void OutdoorPvPWG::RelocateCreature(Creature* creature)
{
    // handle by entry
    switch (creature->GetEntry())
    {
        // fortress and faction base (relocate)
        case NPC_ALLIANCE_RANDOLPH:
        case NPC_ALLIANCE_LEGOSO:
        case NPC_ALLIANCE_ABRAHMIS:
        case NPC_ALLIANCE_STOUTHANDLE:
        case NPC_ALLIANCE_TESSA:
        case NPC_ALLIANCE_ZANNETH:
        case NPC_ALLIANCE_KAYLANA:
            RelocateTeleport(creature, getDefenderTeam() == TEAM_ALLIANCE ? fortressPosition[creature->GetEntry()] : homePosition[creature->GetEntry()]);
            break;
        case NPC_HORDE_BLAZEFEATHER:
        case NPC_HORDE_MURP:
        case NPC_HORDE_KILRATH:
        case NPC_HORDE_STRONGHOOF:
        case NPC_HORDE_MULFORT:
        case NPC_HORDE_DARDOSH:
        case NPC_HORDE_FUJIN:
            RelocateTeleport(creature, getDefenderTeam() == TEAM_HORDE ? fortressPosition[creature->GetEntry()] : homePosition[creature->GetEntry()]);
            break;
        // only fortress (summon & despawn)
        case NPC_ALLIANCE_DAMERON:
        case NPC_ALLIANCE_MAGRUDER:
        case NPC_ALLIANCE_GENERAL:
            RelocateSummonDespawn(creature, getDefenderTeam() == TEAM_ALLIANCE);
            break;
        case NPC_HORDE_MUKAR:
        case NPC_HORDE_ROSSLAI:
        case NPC_HORDE_WARBRINGER:
            RelocateSummonDespawn(creature, getDefenderTeam() == TEAM_HORDE);
            break;
        default:
            break;
    }
}

/****************
 * Sound Handler
 ****************/

void OutdoorPvPWG::PlayTeamSound(TeamId team, uint32 sound)
{
    for (PlayerSet::iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
        (*itr)->PlayDirectSound(sound);
}

class OutdoorPvP_wintergrasp : public OutdoorPvPScript
{
    public:

        OutdoorPvP_wintergrasp()
            : OutdoorPvPScript("outdoorpvp_wg")
        {
        }

        OutdoorPvP* GetOutdoorPvP() const
        {
            return new OutdoorPvPWG();
        }
};

void AddSC_outdoorpvp_wg()
{
    new OutdoorPvP_wintergrasp();
}
