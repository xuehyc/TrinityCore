/*
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

// This is where scripts' loading functions should be declared:
// 这是脚本加载定义的地方:

//AshamaneCore
void AddSC_solocraft_AshamaneCore();
void AddSC_FireWorksOnLevelUp();
void AddSC_XGirlWhispersOnLevelUp();        //小女孩的低语(升级发送一句清心咒,也可能是恶搞)
void AddSC_Player_Boa();                    //给玩家送初始物品,提交名:Starting items script (LoginBoA)
void AddSC_gon_playerscripts();             //新玩家自动加工会,提交名:Starting guilds script
void AddSC_login_script();                  //登录恢复满血,,提交名:Reset hp mp cooldown on login
void AddSC_announce_login();                //登录提醒, 提示阵营:联盟或部落
void AddSC_Boss_Announcer();                //boss击杀公告  //初始版本为有爱论坛,后续发现实则来自AshamaneCore
void AddSC_Duel_Reset();                    //给决斗后的玩家,自动恢复血量
void AddSC_PhasedDueling();                 //阶段性决斗(3局两胜?)
void AddSC_RandomEnchantsScript();          //随机增强脚本,原提交名为:Random Enchants on loot and craft
void AddSC_Dynamic_Resurrections();         //副本中在最后击杀的BOSS处复活
void AddSC_custom_CongratsOnLevel();        //升级奖励金钱.原提交名为:[Money for level] add the basic script
//禁用的
//void AddSC_XpWeekend_AshamaneCore();      //周五周六周天双倍经验,重复,禁用,文件名为:DoubleXP.cpp
void AddSC_NPC_Teleport();                  //NPC传送
//上方脚本来自AshamaneCore

//conan513/SingleCore_TC(github)
void AddSC_BGRewardScripts();               //战场奖励脚本(竞技场不生效)
void AddSC_PvPScripts();                    //PVP防止刷荣誉等
void AddSC_CongratsOnLevelScripts();        //玩家升级公告    
//上方脚本来自conan513/SingleCore_TC(github)

void AddSC_XpWeekend();                     //周末(周五、周六、周天)双倍经验
void AddSC_solocraft();                     //单人随机地下城查找器脚本-单人模块
void AddSC_SpellCraft();                    //单人随机地下城查找器脚本-技能模块
void AddSC_LeechCraft();                    //单人随机地下城查找器脚本-吸血模块
void AddSC_CombatRatingCraft();             //单人随机地下城查找器脚本-战斗倍率
void AddSC_Hastecraft();                    //单人随机地下城查找器脚本-急速模块
void AddLfgSoloScripts();                   //单人随机地下城查找器脚本-单人随机地下城查找器
void AddSC_custom_npcs();                   //自定义NPC-好像是暴风城的龙王加冕事件
void AddSC_custom_player_script();          //一个自定义的NPC,有许多功能
void AddSC_GuardianAngel();                 //守护神
//上方脚本来自TrinityCoreBased



void AddSC_GOMove_commandscript();          //Rochet2-gomove_master
void AddSC_onlogin_announcer();             //玩家欢迎信息
void AddSC_PvP_System();                    //pvp系统-击杀公告

//void AddSC_debug_lfg();                   //单人进地下城尝试, OpenLCore,已经自己通过配置实现,停用
//void AddSC_double_xp();                   //周六、周天双倍经验, OpenLCore,和现有XpWeekend重复,故而停用
//void AddSC_start_equipment();             //OpenLCore,出生送装备
//void AddSC_quest_conversation();          //任务对话?       //这货启用,会使服务端启动不了,千万别启用,谨记!
//void AddSC_gossiptp();                    //闲聊


//注释看上面就行,下面是一样的,以后不再重复注释


// The name of this function should match:  // 本功能的名称应该符合:
// void Add${NameOfDirectory}Scripts()      // void Add${NameOfDirectory}Scripts()
                                            // 这样的样式
void AddCustomScripts()
{
    AddSC_GOMove_commandscript();
    AddSC_XpWeekend();              //周末双倍经验
    AddSC_solocraft_AshamaneCore(); //单人随机地下城查找器脚本,来自Ashamane核心
    AddSC_SpellCraft();             //单人随机地下城查找器脚本
    AddSC_LeechCraft();             //单人随机地下城查找器脚本
    AddSC_CombatRatingCraft();      //单人随机地下城查找器脚本
    AddSC_Hastecraft();             //单人随机地下城查找器脚本
    AddLfgSoloScripts();            //单人随机地下城查找器脚本
    AddSC_custom_player_script();   //单人随机地下城查找器脚本
    AddSC_custom_npcs();            //自定义NPC-好像是暴风城的龙王加冕事件
    AddSC_custom_player_script();   //一个自定义的NPC,有许多功能
    AddSC_GuardianAngel();          //守护神
    AddSC_onlogin_announcer();      //玩家欢迎信息
    AddSC_Boss_Announcer();         //boss击杀公告
    AddSC_PvP_System();             //pvp击杀公告

    //AddSC_PvP_System();            //pvp击杀公告
   //AddSC_debug_lfg();              //单人进地下城尝试, OpenLCore,已经自己通过配置实现,停用
   //AddSC_double_xp();              //周六、周天双倍经验, OpenLCore,和现有XpWeekend重复,故而停用
   //AddSC_start_equipment();        //OpenLCore,出生送装备
   //AddSC_quest_conversation();     //任务对话?       //这货启用,会使服务端启动不了,千万别启用,谨记!
    //   AddSC_gossiptp();           //闲聊
	AddSC_solocraft();
	AddSC_FireWorksOnLevelUp();
    AddSC_XGirlWhispersOnLevelUp();
    AddSC_Player_Boa();             //给玩家送初始物品
    AddSC_gon_playerscripts();
    AddSC_login_script();
    AddSC_announce_login();
    //AddSC_XpWeekend_AshamaneCore();
    AddSC_PhasedDueling();
    AddSC_RandomEnchantsScript();
    AddSC_Dynamic_Resurrections();
    AddSC_custom_CongratsOnLevel();

    AddSC_BGRewardScripts();
    AddSC_PvPScripts();
    AddSC_CongratsOnLevelScripts();

    AddSC_NPC_Teleport();
}
