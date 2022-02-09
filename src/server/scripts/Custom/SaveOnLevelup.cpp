/*
Single Player Project
Module by Conanhun
Refactored for gwenpool 434 by SPP DEV MDic
*/

#include "Chat.h"
#include "Config.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "ObjectAccessor.h"

class spp_save_on_levelup : public PlayerScript
{
public:
    spp_save_on_levelup() : PlayerScript("spp_save_on_levelup") { };

    void OnLevelChanged(Player* player, uint8 /*oldLevel*/)
    {
        if (sConfigMgr->GetBoolDefault("Save.On.LevelUp", true))
        {
            if (sConfigMgr->GetBoolDefault("Save.On.LevelUp.Announcer", true))
            {
                ChatHandler(player->GetSession()).SendSysMessage("|cFF008000Characters saved on the server.|");
            }

            ObjectAccessor::SaveAllPlayers();
        }
    }
};

void AddSC_save_on_levelup()
{
    new spp_save_on_levelup();
}
