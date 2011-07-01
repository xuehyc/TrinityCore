#include "ScriptPCH.h"

class Reset_OnDuelEnd : public PlayerScript
{
    public:
        Reset_OnDuelEnd() : PlayerScript("Reset_OnDuelEnd") {}

    void OnDuelEnd(Player *winner, Player *loser, DuelCompleteType type)
    {
        // reset cooldowns in zone 0, 41 and 616
                if (winner->GetZoneId() == 0 || winner->GetZoneId() == 41 || winner->GetZoneId() == 616)
                {
                        winner->RemoveArenaSpellCooldowns();
                        loser->RemoveArenaSpellCooldowns();
                        winner->SetHealth(winner->GetMaxHealth());
                        winner->SetPower(POWER_MANA, winner->GetMaxPower(POWER_MANA));
                        loser->SetHealth(loser->GetMaxHealth());
                        loser->SetPower(POWER_MANA, loser->GetMaxPower(POWER_MANA));
                }
    }
};

void AddSC_Reset()
{
    new Reset_OnDuelEnd;
}