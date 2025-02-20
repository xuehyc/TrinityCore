///*
// * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
// * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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
//#include "ScriptMgr.h"
//#include "ScriptedCreature.h"
//#include "greenstone_village.h"
//
//class instance_greenstone_village : public InstanceMapScript
//{
//public:
//    instance_greenstone_village() : InstanceMapScript("instance_greenstone_village", 1144) { }
//
//    InstanceScript* GetInstanceScript(InstanceMap* map) const override
//    {
//        return new instance_greenstone_village_InstanceMapScript(map);
//    }
//
//    struct instance_greenstone_village_InstanceMapScript : public InstanceScript
//    {
//        instance_greenstone_village_InstanceMapScript(Map* map) : InstanceScript(map)
//        { }
//
//        void Initialize() override
//        {
//        }
//
//        void OnPlayerEnter(Player* player) override
//        {
//        }
//
//        void SetData(uint32 type, uint32 data) override
//        {
//            switch (type)
//            {
//                case 0:
//                default:
//                    break;
//            }
//        }
//
//        ObjectGuid GetGuidData(uint32 type) const override
//        {
//            switch (type)
//            {
//                case 0:
//                default:
//                    return ObjectGuid::Empty;
//            }
//        }
//
//        uint32 GetData(uint32 type) const override
//        {
//            switch (type)
//            {
//                case 0:
//                default:
//                    return 0;
//            }
//        }
//    };
//};
//
//void AddSC_instance_greenstone_village()
//{
//    new instance_greenstone_village();
//}
