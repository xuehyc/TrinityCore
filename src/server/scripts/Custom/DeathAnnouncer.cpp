/*Based on Boss Announcer by SymbolixDEV
Refactored by SPP DEV MDIC
for Gwenpool 434 Branch.
*/
#include "Config.h"
#include "Player.h"
#include "Creature.h"
#include "AccountMgr.h"
#include "ScriptedAI/ScriptedCreature.h"
#include "ScriptMgr.h"
#include "Define.h"
#include "Pet.h"
#include "Item.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "WorldSession.h"
#include "Chat.h"
#include "Log.h"
#include "Creature.h"
#include "GameObject.h"



class Death_Announcer : public PlayerScript
{
public:
    Death_Announcer() : PlayerScript("Death_Announcer") {}

    void OnPlayerKilledByCreature(Creature* killer, Player* killed)
    {
        if (sConfigMgr->GetBoolDefault("KilledByCreature.Announcer", true))
        {
            if (killer->isElite())
            {
                std::string plr = killed->GetName();
                std::string creature_n = killer->GetName();
                std::string tag_colour = "7bbef7";
                std::string plr_colour = "7bbef7";
                std::string creature_colour = "ff0000";
                std::ostringstream stream;
                stream << "|CFF" << tag_colour <<
                    "|r|cff" << plr_colour << " " << plr <<
                    "|r killed by the elite |CFF" << creature_colour << "" << creature_n << "|r " "creature" << "!";
                sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
            }
        }

        if (killer->isWorldBoss())
        {
            std::string plr = killed->GetName();
            std::string creature_n = killer->GetName();
            std::string tag_colour = "7bbef7";
            std::string plr_colour = "7bbef7";
            std::string creature_colour = "ff0000";
            std::ostringstream stream;
            stream << "|CFF" << tag_colour <<
                "|r|cff" << plr_colour << " " << plr <<
                "|r killed by the legendary |CFF" << creature_colour << "" << creature_n << "|r " "world boss" << "!";
            sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
        }

        if (killer->IsDungeonBoss())
        {
            std::string plr = killed->GetName();
            std::string creature_n = killer->GetName();
            std::string tag_colour = "7bbef7";
            std::string plr_colour = "7bbef7";
            std::string creature_colour = "ff0000";
            std::ostringstream stream;
            stream << "|CFF" << tag_colour <<
                "|r|cff" << plr_colour << " " << plr <<
                "|r killed by the mighty |CFF" << creature_colour << "" << creature_n << "|r " "dungeon boss" << "!";
            sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
        }
    }

    void OnPVPKill(Player* killer, Player* killed)
    {
        if (sConfigMgr->GetBoolDefault("PvPKill.Announcer", true))
        {
            if (killer->IsPlayer())
            {
                std::string plr = killed->GetName();
                std::string creature_n = killer->GetName();
                std::string tag_colour = "7bbef7";
                std::string plr_colour = "7bbef7";
                std::string creature_colour = "ff0000";
                std::ostringstream stream;
                stream << "|CFF" << tag_colour <<
                    "|r|cff" << plr_colour << " " << plr <<
                    "|r killed by |CFF" << creature_colour << "" << creature_n << "|r " "player" << "!";
                sWorld->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
            }
        }
    }
};

void AddSC_Death_Announcer()
{
    new Death_Announcer;
}
