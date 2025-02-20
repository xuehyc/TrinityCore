﻿/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
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

#ifndef WDT_H
#define WDT_H
#include "loadlib.h"

//**************************************************************************************
// WDT file class and structures    WDT文件类别和结构
//**************************************************************************************
#define WDT_MAP_SIZE 64

#pragma pack(push, 1)

class wdt_MPHD
{
    union
    {
        uint32 fcc;
        char   fcc_txt[4];
    };
public:
    uint32 size;

    uint32 flags;
    uint32 lgtFileDataID;
    uint32 occFileDataID;
    uint32 fogsFileDataID;
    uint32 mpvFileDataID;
    uint32 texFileDataID;
    uint32 wdlFileDataID;
    uint32 pd4FileDataID;
};

class wdt_MAIN
{
    union
    {
        uint32 fcc;
        char   fcc_txt[4];
    };
public:
    uint32 size;

    struct adtData
    {
        uint32 flag;
        uint32 data1;
    } adt_list[64][64];
};

class wdt_MAID
{
    union
    {
        uint32 fcc;
        char   fcc_txt[4];
    };
public:
    uint32 size;

    struct
    {
        uint32 rootADT;         // FileDataID of mapname_xx_yy.adt              //类似 地图名称_xx_yy.adt 文件数据编号
        uint32 obj0ADT;         // FileDataID of mapname_xx_yy_obj0.adt
        uint32 obj1ADT;         // FileDataID of mapname_xx_yy_obj1.adt
        uint32 tex0ADT;         // FileDataID of mapname_xx_yy_tex0.adt
        uint32 lodADT;          // FileDataID of mapname_xx_yy_lod.adt
        uint32 mapTexture;      // FileDataID of mapname_xx_yy.blp
        uint32 mapTextureN;     // FileDataID of mapname_xx_yy_n.blp
        uint32 minimapTexture;  // FileDataID of mapxx_yy.blp
    } adt_files[64][64];
};

#pragma pack(pop)

#endif
