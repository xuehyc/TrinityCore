/*
 * Copyright (C) 2011-2013 ArkCORE <http://www.arkania.net/>
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

// #include "ArchaeologyMgr.h"
// #include "Map.h"
// #include "DatabaseEnv.h"
// #include "DBCEnums.h"
// #include "Player.h"


// void ArchaeologyMgr::LoadResearchDigsites()
// {
    // uint32 oldMSTime = getMSTime();

    // mResearchDigsitesMap.clear();

    // PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_LOAD_RESEARCH_DIGSITES);
    // PreparedQueryResult result = WorldDatabase.Query(stmt);

    // if (!result)
    // {
        // sLog->outInfo(LOG_FILTER_SQL, ">> 0 archaeology digsites. DB table `research_digsites` is empty.");
        // return;
    // }

    // uint32 digCount = 0;

    // do
    // {
        // Field* fields = result->Fetch();
        // uint16 digid = fields[0].GetUInt16();

        // if (!sResearchDigsiteStore.LookupEntry(digid)){
            // sLog->outError(LOG_FILTER_SQL, "ArchaeologyMgr:  Digsite id %u found in table `research_digsites` but does not exist in DBC, skipped!.", digid);
            // continue;
        // }

        // ResearchDigsiteEntry const *rd = sResearchDigsiteStore.LookupEntry(digid);
        // ResearchDigsitesEntry temp;

        // temp.id               = fields[0].GetUInt16();
        // temp.mapId            = uint16(rd->mapId);
        // temp.minLevel         = fields[1].GetUInt8();
        // temp.minSkillLevel    = fields[2].GetUInt16();
        // temp.currencyId       = fields[3].GetUInt16();
        // temp.QuestPoitBlobId  = uint16(rd->QuestPoitBlobId);

        // mResearchDigsitesMap.insert(DigsitesMap::value_type(digid, temp));
        // ++digCount;

    // } while (result->NextRow());

    // sLog->outInfo(LOG_FILTER_SQL, ">> %u archaeology digsites in %u ms", digCount, GetMSTimeDiffToNow(oldMSTime));
// }

// void ArchaeologyMgr::initProject(Player* player, uint32 currencyId)
// {
    // if (!player->HasSkill(SKILL_ARCHAEOLOGY))
        // return;

    // if(isActiveBranch(player, currencyId))
        // return;

    // uint16 selectProject = 0;
    // uint32 count = 0;
    // std::vector<uint16> BranchProjects;

    // for(uint32 i=0; i < 9; ++i)
        // if(player->GetUInt16Value(PLAYER_FIELD_RESEARCHING_1 + i / 2, i % 2))
            // count = i + 1;

    // for(uint32 i=0; i < sResearchBranchStore.GetNumRows(); ++i)
    // {
        // ResearchBranchEntry const* ab = sResearchBranchStore.LookupEntry(i);
        // if (!ab || ab->currencyId != currencyId)
            // continue;

        // for(uint32 i=0; i < sResearchProjectStore.GetNumRows(); ++i)
        // {
            // ResearchProjectEntry const* rs = sResearchProjectStore.LookupEntry(i);

            // if(!rs || rs->researchBranchId != ab->Id)
                // continue;

            //Faltan mas checks para hacerlo 100% blizzlike, por ejemplo ajustar un máximo de fragmentos al minimo para los primeros projects

            // BranchProjects.push_back(rs->Id);
        // }

        // selectProject = BranchProjects[urand(0, BranchProjects.size()-1)];
        // player->SetUInt16Value(PLAYER_FIELD_RESEARCHING_1 + count / 2, count % 2, selectProject);
        // BranchProjects.clear();
    // }
// }

// void ArchaeologyMgr::changeDigsite(Player* player, uint8 memId)
// {
    // std::vector<uint16> SitesInMap;

    // for(DigsitesMap::iterator itr = mResearchDigsitesMap.begin(); itr != mResearchDigsitesMap.end(); ++itr)
    // {
        // bool isActiveDigsite = false;

        // if(player->GetMapId() != itr->second.mapId || itr->second.minLevel > player->getLevel() || itr->second.minSkillLevel > player->GetSkillValue(SKILL_ARCHAEOLOGY))
            // continue;

        // for(uint32 i=0; i < 16; ++i)
        // {
            // if(player->GetUInt16Value(PLAYER_FIELD_RESERACH_SITE_1 + i / 2, i % 2) != itr->second.id)
                // continue;

            // isActiveDigsite = true;
        // }

        // if(isActiveDigsite)
            // continue;

        // SitesInMap.push_back(itr->second.id);
    // }

    // uint16 selectDigsite = SitesInMap[urand(0, SitesInMap.size()-1)];
    // player->SetUInt16Value(PLAYER_FIELD_RESERACH_SITE_1 + memId / 2, memId % 2, selectDigsite);
    // player->setDigsitePosition(memId, 0, 0, 0);
    // SitesInMap.clear();
// }

// void ArchaeologyMgr::addDigsitesToMap(Player* player, uint32 mapId)
// {
    // if (!player->HasSkill(SKILL_ARCHAEOLOGY))
        // return;

    // std::vector<uint16> SitesInMap;
    // uint8 count;

    // switch(mapId)
    // {
        // case 0:
            // count = 0;
            // break;
        // case 1:
            // count = 4;
            // break;
        // case 530:
            // count = 8;
            // break;
        // case 571:
            // count = 12;
            // break;
        // default:
            // return;
    // }

    // for(DigsitesMap::iterator itr = mResearchDigsitesMap.begin(); itr != mResearchDigsitesMap.end(); ++itr)
    // {
        // if(itr->second.mapId != mapId || itr->second.minLevel > player->getLevel() || itr->second.minSkillLevel > player->GetSkillValue(SKILL_ARCHAEOLOGY))
            // continue;

        // SitesInMap.push_back(itr->second.id);
    // }

    // for(uint32 addedsites=0; addedsites < 4; ++addedsites)
    // {
        // bool isActiveDigsite = false;
        // uint16 selectDigsite = 0;

        // do
        // {
            // isActiveDigsite = false;
            // selectDigsite = SitesInMap[urand(0, SitesInMap.size()-1)];

            // for(uint32 i=0; i < 16; ++i)
            // {
                // if(player->GetUInt16Value(PLAYER_FIELD_RESERACH_SITE_1 + i / 2, i % 2) != selectDigsite)
                    // continue;

                // isActiveDigsite = true;
            // }
        // }
        // while (isActiveDigsite);

        // player->SetUInt16Value(PLAYER_FIELD_RESERACH_SITE_1 + count / 2, count % 2, selectDigsite);
        // ++count;
    // }

    // SitesInMap.clear();
// }

// bool ArchaeologyMgr::isActiveBranch(Player* player, uint32 currencyId)
// {
    // for(uint32 i=0; i < 9; ++i)
    // {
        // if(player->GetUInt16Value(PLAYER_FIELD_RESEARCHING_1 + i / 2, i % 2))
        // {
            // uint16 projectId = player->GetUInt16Value(PLAYER_FIELD_RESEARCHING_1 + i / 2, i % 2);
            // ResearchProjectEntry const* rs = sResearchProjectStore.LookupEntry(projectId);
            // ResearchBranchEntry const* ab = sResearchBranchStore.LookupEntry(rs->researchBranchId);

            // if(ab->currencyId == currencyId)
                // return true;
        // }
    // }
    // return false;
// }

// void ArchaeologyMgr::generateRandomPosition(Player* player, uint8 count)
// {
    // Position playerPos;
    // Position treasurePos;
    // player->GetPosition(&playerPos);

    // do
    // {
        // player->GetRandomPoint(playerPos, 300.f, treasurePos);
    // }
    // while (player->getDigsite(treasurePos.GetPositionX(), treasurePos.GetPositionY()) == -1);

    // uint8 memId = player->getDigsite(treasurePos.GetPositionX(), treasurePos.GetPositionY());
    // player->setDigsitePosition(memId, treasurePos.GetPositionX(), treasurePos.GetPositionY(), count);
// }

// int ArchaeologyMgr::getCurrencyId(uint16 digsiteId)
// {
    // DigsitesMap::iterator itr = mResearchDigsitesMap.find(digsiteId);
    // return uint16(itr->second.currencyId);
// }

// void ArchaeologyMgr::completeArtifact(Player* player, uint32 spellId)
// {
    // for(uint32 memId=0; memId < 9; ++memId)
    // {
        // if(player->GetUInt16Value(PLAYER_FIELD_RESEARCHING_1 + memId / 2, memId % 2))
        // {
            // uint16 projectId = player->GetUInt16Value(PLAYER_FIELD_RESEARCHING_1 + memId / 2, memId % 2);

            // for(uint32 i=0; i < sResearchProjectStore.GetNumRows(); ++i)
            // {
                // ResearchProjectEntry const* rs = sResearchProjectStore.LookupEntry(i);

                // if(!rs || rs->Id != projectId || rs->spellId != spellId)
                    // continue;

                // for(uint32 i=0; i < sResearchBranchStore.GetNumRows(); ++i)
                // {
                    // ResearchBranchEntry const* ab = sResearchBranchStore.LookupEntry(i);

                    // if(!ab || ab->Id != rs->researchBranchId)
                        // continue;

                    // player->ModifyCurrency(ab->currencyId, -((int32)rs->fragmentsNeeded * 100 -1)); // Hack hasta corregir el error del UI cuando te quedan 0 currencys

                    // QueryResult result = CharacterDatabase.PQuery("SELECT time, projectId, count FROM character_research_history WHERE guid = %u AND projectId = %u", player->GetGUIDLow(), projectId);

                    // if(result)
                    // {
                        // CharacterDatabase.PQuery("UPDATE character_research_history SET count=count+1 WHERE guid = %u AND projectId = %u", player->GetGUIDLow(), projectId);
                    // }
                    // else
                    // {
                        // PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_ADD_RESEARCH_HISTORY);
                        // stmt->setUInt32(0, player->GetGUIDLow());
                        // stmt->setUInt64(1, time(NULL));
                        // stmt->setUInt32(2, projectId);
                        // CharacterDatabase.Execute(stmt);
                    // }

                    // std::vector<uint16> BranchProjects;

                    // for(uint32 i=0; i < sResearchProjectStore.GetNumRows(); ++i)
                    // {
                        // ResearchProjectEntry const* rs2 = sResearchProjectStore.LookupEntry(i);

                        // if(!rs2 || rs2->researchBranchId != ab->Id || rs2->Id == projectId)
                            // continue;

                        // BranchProjects.push_back(rs2->Id);
                    // }

                    // uint16 selectProject = BranchProjects[urand(0, BranchProjects.size()-1)];
                    // player->SetUInt16Value(PLAYER_FIELD_RESEARCHING_1 + memId / 2, memId % 2, selectProject);
                    // BranchProjects.clear();

                    // return;
                // }
            // }
        // }
    // }
// }
