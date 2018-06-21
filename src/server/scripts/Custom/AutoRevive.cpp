#include "ScriptMgr.h"
#include "Player.h"
#include "AccountMgr.h"
#include "Common.h"
#include "Config.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"



uint32 TimeCheck_AutoRevive = 0;

class AutoRevive_PlayerSC : public PlayerScript
{
public:
	AutoRevive_PlayerSC() : PlayerScript("AutoRevive_PlayerSC") {}

	void OnBeforeUpdate(Player* player, uint32 diff)
	{
		if (!sConfigMgr->GetBoolDefault("AutoRevive.Enable", false))
			return;

		uint32 NowHealth = player->GetHealth();
		uint32 TimeCheck = sConfigMgr->GetIntDefault("AutoRevive.TimeCheck", 1000);
		uint32 zoneid_conf = sConfigMgr->GetIntDefault("AutoRevive.ZoneID", 0);
		uint32 zoneid = player->GetZoneId();

		if (TimeCheck_AutoRevive < diff)
		{
			if (NowHealth <= 1)
			{
				if (zoneid_conf > 0)
				{
					if (zoneid_conf == zoneid)
					{
						player->ResurrectPlayer(1.0f);
						player->SaveToDB();
					}
					else
						return;
				}
				else
				{
					player->ResurrectPlayer(1.0f);
					player->SaveToDB();
				}
			}
			
			TimeCheck_AutoRevive = TimeCheck;
		}
		else
			TimeCheck_AutoRevive -= diff;
	}
};

void AddSC_AutoReviveScripts()
{
    new AutoRevive_PlayerSC();
}
