/*
Single Player Project
*/

#include "Config.h"
#include "Chat.h"
#include "Log.h"

namespace {

    class spp_module_announcer : public PlayerScript 
	{

    public:
        spp_module_announcer() : PlayerScript("spp_module_announcer")
        {
        }

        // Announce Modules
        void OnLogin(Player *player, bool /*firstLogin*/) override
        {
            if (sConfigMgr->GetBoolDefault("Module.Announcer.Enable", true))
            {
                if (sConfigMgr->GetBoolDefault("Solocraft.Announce", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00SoloCraft |rmodule is active.");
                }

                if (sConfigMgr->GetBoolDefault("WorldChat.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00WorldChat |rmodule is active. Use |cffFF0000.world |rcommand.");
                }
				
                if (sConfigMgr->GetBoolDefault("RandomEnchants.OnLoot", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00RandomEnchants on loot |rmodule is active.");
                }		
				
			    if (sConfigMgr->GetBoolDefault("Custom.XP.Rate.NPC", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00Custom.XP.Rate.NPC |rmodule is active.");
                }
                
				if (sConfigMgr->GetBoolDefault("Login.Announcer.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00LoginAnnouncer |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Boss.Announcer.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00BossKillAnnouncer |rmodule is active.");
                }
			    
				if (sConfigMgr->GetBoolDefault("DoubleXP.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00DoubleXPWeekend |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Duel.Reset.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00DuelReset |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("FireWorksOnLevelUp", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00FireWorksOnMaxLevel |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Login.BoA", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00Login.BoA |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Reset.on.login", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00ResetOnLogin |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Dungeon.Checkpoints.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00DungeonCheckpoints |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Skip.Worgen.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00SkipWorgen |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Skip.Goblin.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00SkipGoblin |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Skip.Pandaren.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00SkipPandaren |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Disallow.Multiple.Client", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00DisallowMultipleClient |rmodule is active.");
                }
								
				if (sConfigMgr->GetBoolDefault("Hardcore.Mode.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00HardcoreMode |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("MFK.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00MoneyForKill |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("Congrats.On.Level.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00CongratsOnLevel |rmodule is active.");
                }
				
				if (sConfigMgr->GetBoolDefault("CompleteQuest.Command", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("|cff4CFF00CompleteQuest.Command |rmodule is active. Use |cffFF0000.completequest [LINK] |rcommand.");
                }
            }
            ChatHandler(player->GetSession()).SendSysMessage("This server is based on |cffFF0000Single Player Project - AshamaneCore |rrepack.");
            ChatHandler(player->GetSession()).SendSysMessage("Website:|cffADD8E6 https://www.patreon.com/conan513 |r");
        }
    };
}

void AddSC_spp_module_announcer() {
    new spp_module_announcer();
}
