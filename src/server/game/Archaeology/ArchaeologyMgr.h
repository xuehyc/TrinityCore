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

// #ifndef __ARKCORE_ARCHAEOLOGY_H
// #define __ARKCORE_ARCHAEOLOGY_H

// #include "DBCEnums.h"
// #include "DBCStores.h"
// #include "Player.h"

// class ArchaeologyMgr
// {
    // struct ResearchDigsitesEntry
    // {
        // uint16 id;
        // uint16 mapId;
        // uint8 minLevel;
        // uint16 minSkillLevel;
        // uint16 currencyId;
        // uint16 QuestPoitBlobId;
    // };

    // public:
        // void LoadResearchDigsites();
        // void initProject(Player* player, uint32 currencyId);
        // void changeDigsite(Player* player, uint8 memId);
        // void addDigsitesToMap(Player* player, uint32 mapId);
        // bool isActiveBranch(Player* player, uint32 currencyId);
        // void generateRandomPosition(Player* player, uint8 count);
        // int getCurrencyId(uint16 digsiteId);
        // void completeArtifact(Player* player, uint32 spellId);

    // private:
        // typedef UNORDERED_MAP<uint16, ResearchDigsitesEntry> DigsitesMap;
        // DigsitesMap mResearchDigsitesMap;
// };

// struct Digsite
// {
    // uint8     memId;       // Posicion en memoria
    // float     x;           // Coordenada X
    // float     y;           // Coordenada Y
    // uint8     digCount;    // Contador de exploraciones
// };

// typedef UNORDERED_MAP<uint8, Digsite> DigsiteMap;

// #define sArchaeologyMgr ACE_Singleton<ArchaeologyMgr, ACE_Null_Mutex>::instance()

// #endif
