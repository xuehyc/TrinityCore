#include "BuffCommand.h"
#include "ScriptMgr.h"
#include "Config.h"
#include "World.h"
#include "WorldSession.h"
#include "Player.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Log.h"


void Kargatum_Buff::LoadDB()
{
	uint32 oldMSTime = getMSTime();
	_buffStore.clear();

	QueryResult result = WorldDatabase.PQuery("SELECT spellid FROM `player_buff`");
	if (!result)
	{
        TC_LOG_INFO("server.loading", ">> Loaded 0 buff. DB table `player_buff` is empty!");
		return;
	}

	do
	{
		uint32 id = result->Fetch()->GetInt32();
		_buffStore.push_back(id);

	} while (result->NextRow());

    TC_LOG_INFO("server.loading", ">> Loaded %u buff in %u ms", uint32(_buffStore.size()), GetMSTimeDiffToNow(oldMSTime));
}

class KargatumCS_BuffCOmmand : public CommandScript
{
public:
	KargatumCS_BuffCOmmand() : CommandScript("KargatumCS_BuffCOmmand") {}

	std::vector<ChatCommand> GetCommands() const override
	{
		static std::vector<ChatCommand> commandTable = // .commands
		{
			{ "buff",				SEC_PLAYER,			false, &HandleBuffCommand,	"" }
		};

		return commandTable;
	}

	static bool HandleBuffCommand(ChatHandler *handler, const char *args)
	{
		Player* player = handler->GetSession()->GetPlayer();
		std::string ArgStr = (char*)args;

		if (ArgStr == "reload" && AccountMgr::IsAdminAccount(player->GetSession()->GetSecurity()))
		{
            TC_LOG_INFO("server.loading", "Re-Loading Player Buff data...");
			//sKargatumBuff;
			handler->SendGlobalGMSysMessage("|cff6C8CD5#|cFFFF0000 Table|r `player_buff` |cFFFF0000re.|r");
			return true;
		}
		else
		{
			if (player->duel || player->GetMap()->IsBattleArena() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead(), player->IsInCombat() || player->IsInFlight())
			{
				handler->SendSysMessage("You can not do it now");
				handler->SetSentErrorMessage(true);
				return false;
			}

			player->RemoveAurasByType(SPELL_AURA_MOUNTED);

			/*Kargatum_Buff::Kargatum_Buff_Container& sn = sKargatumBuff->GetBuffData();
			for (auto i : sn)
				player->CastSpell(player, i, true);*/

			return true;
		}
	}
};

class Kargatum_BuffLoad : public WorldScript
{
public:
	Kargatum_BuffLoad() : WorldScript("Kargatum_BuffLoad") {}

	void OnStartup() override
	{
        TC_LOG_INFO("server.loading", "Loading player buff command ...");
		//sKargatumBuff->LoadDB();
	}
};

void AddSC_BuffCommandScripts()
{
	new KargatumCS_BuffCOmmand();
	new Kargatum_BuffLoad();
}
