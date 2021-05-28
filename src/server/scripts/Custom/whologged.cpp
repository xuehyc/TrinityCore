/*
Who Logged Module by Conanhun
Refactored by SPP DEV MDIC
For Gwenpool 434 Branch.
*/

#include "Configuration/Config.h"
#include "Player.h"
#include "Creature.h"
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Define.h"
#include "GossipDef.h"
#include "WorldSession.h"
#include "AppenderConsole.h"
#include "LogMessage.h"
#include "Util.h"
#include <sstream>
#include "Log.h"

class WhoLoggedAnnounce : public PlayerScript
{
public:
    WhoLoggedAnnounce() : PlayerScript("WhoLoggedAnnounce") { }


    void OnLogin(Player* p, bool)
    {
        std::string playerIP = p->GetSession()->GetRemoteAddress();
        std::string playerName = p->GetName();
        uint32 pAccountID = p->GetSession()->GetAccountId();
        uint32 pLevel = p->getLevel();
        std::string pRace;
        std::string pClass;
        std::ostringstream message;
        time_t tt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
        std::tm aTm;
        localtime_r(&tt, &aTm);

        if (!sConfigMgr->GetBoolDefault("Who-logged.console", true))
        {
            return;
        }

        switch (p->getRace())
        {
        case RACE_NONE:
            pRace = "None";
            break;
        case RACE_HUMAN:
            pRace = "Human";
            break;
        case RACE_ORC:
            pRace = "Orc";
            break;
        case RACE_DWARF:
            pRace = "Dwarf";
            break;
        case RACE_NIGHTELF:
            pRace = "Night Elf";
            break;
        case RACE_UNDEAD_PLAYER:
            pRace = "Undead";
            break;
        case RACE_TAUREN:
            pRace = "Tauren";
            break;
        case RACE_GNOME:
            pRace = "Gnome";
            break;
        case RACE_TROLL:
            pRace = "Troll";
            break;
        case RACE_GOBLIN:
            pRace = "Goblin";
            break;
        case RACE_BLOODELF:
            pRace = "Blood Elf";
            break;
        case RACE_DRAENEI:
            pRace = "Draenei";
            break;
        case RACE_WORGEN:
            pRace = "Worgen";
            break;
        }

        switch (p->getClass())
        {
        case CLASS_WARLOCK:
            pClass = "Warlock";
            break;
        case CLASS_WARRIOR:
            pClass = "Warrior";
            break;
        case CLASS_MAGE:
            pClass = "Mage";
            break;
        case CLASS_SHAMAN:
            pClass = "Shaman";
            break;
        case CLASS_DEATH_KNIGHT:
            pClass = "Death Knight";
            break;
        case CLASS_DRUID:
            pClass = "Druid";
            break;
        case CLASS_HUNTER:
            pClass = "Hunter";
            break;
        case CLASS_PALADIN:
            pClass = "Paladin";
            break;
        case CLASS_ROGUE:
            pClass = "Rogue";
            break;
        case CLASS_PRIEST:
            pClass = "Priest";
            break;
        }

        TC_LOG_INFO("chat.log.system", "%04d-%02d-%02d %02d:%02d:%02d Player '%s' has logged in : Level '%u' : Race '%s' : Class '%s' : IP '%s' : AccountID '%u'",
            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, playerName.c_str(), pLevel, pRace.c_str(), pClass.c_str(), playerIP.c_str(), pAccountID);
    }
};

void AddSC_WhoLoggedScripts()
{
    new WhoLoggedAnnounce();
}
