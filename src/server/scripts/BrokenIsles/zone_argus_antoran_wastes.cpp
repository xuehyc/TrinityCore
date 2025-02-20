///*
// * Copyright (C) 2022 BfaCore Reforged
// *
// * This program is free software; you can redistribute it and/or modify it
// * under the terms of the GNU General Public License as published by the
// * Free Software Foundation; either version 2 of the License, or (at your
// * option) any later version.
// *
// * This program is distributed in the hope that it will be useful, but WITHOUT
// * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// * more details.
// *
// * You should have received a copy of the GNU General Public License along
// * with this program. If not, see <http://www.gnu.org/licenses/>.
// */
//
//
//#include "ScriptMgr.h"
//#include "Player.h"
//#include "SpellMgr.h"
//
//// Zone 8899
//class zone_argus_antoran_wastes : public ZoneScript
//{
//public:
//    zone_argus_antoran_wastes() : ZoneScript("zone_argus_antoran_wastes") { }
//
//    void OnPlayerEnter(Player* player) override
//    {
//        player->GetScheduler().Schedule(Milliseconds(2s), ZONE_ANTORAN_WASTES, [](TaskContext context)
//        {
//            if (Player* player = GetContextPlayer())
//                if (player->GetAreaId() == AREA_ANTORAN_WASTES_VINDICAAR)
//                    if (player->GetPositionZ() <= -125.0f)
//                        player->NearTeleportTo(-2602.05f, 8573.32f, -66.0f, 1.816547f);
//
//            context.Repeat();
//        });
//    }
//
//    void OnPlayerExit(Player* player) override
//    {
//        player->GetScheduler().CancelGroup(ZONE_ANTORAN_WASTES);
//    }
//};
//
//void AddSC_zone_argus_antoran_wastes()
//{
//    new zone_argus_antoran_wastes();
//}
