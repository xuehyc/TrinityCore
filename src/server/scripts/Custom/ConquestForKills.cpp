/*
* Inspired by LASYAN3's PATCH Honor for kill Module
* Developed by SPP DEV MDIC
* Gwenpool 434 Branch
 */

#include "Battleground.h"
#include "Chat.h"
#include "Config.h"
#include "Creature.h"
#include "Formulas.h"
#include "Group.h"
#include "Player.h"
#include "Pet.h"
#include "ScriptMgr.h"
#include "Unit.h"
#include "World.h"
#include "WorldPacket.h"

bool GainConquestGuardEnable = 1;
bool GainConquestGuardAnnouceModule = 1;
bool GainConquestGuardOnGuardKill = 1;
bool GainConquestGuardOnEliteKill = 1;
bool GainConquestGuardOnGuardKillAnnounce = 1;
bool GainConquestGuardOnEliteKillAnnounce = 1;
bool GainConquestRateEnable = 1;
float GainConquestRate = 1.0;

class GainConquestGuardConfig : public WorldScript
{
public:
    GainConquestGuardConfig() : WorldScript("GainConquestGuardConfig") {}

    void OnBeforeConfigLoad(bool reload)
    {
        if (!reload)
        {
            // Load Configuration Settings
            SetInitialWorldSettings();
        }
    }

    // Load Configuration Settings
    void SetInitialWorldSettings()
    {
        GainConquestGuardEnable = sConfigMgr->GetBoolDefault("GainConquestGuard.Enable", 1);
        GainConquestGuardAnnouceModule = sConfigMgr->GetBoolDefault("GainConquestGuard.Announce", 1);

        //Gain Honor Settings
        GainConquestGuardOnGuardKill = sConfigMgr->GetBoolDefault("GainConquestGuard.GainConquestOnGuardKill", 0);
        GainConquestGuardOnEliteKill = sConfigMgr->GetBoolDefault("GainConquestGuard.GainConquestOnEliteKill", 0);

        //Announce honor gained
        GainConquestGuardOnGuardKillAnnounce = sConfigMgr->GetBoolDefault("GainConquestGuard.GainConquestOnGuardKillAnnounce", 0);
        GainConquestGuardOnEliteKillAnnounce = sConfigMgr->GetBoolDefault("GainConquestGuard.GainConquestOnEliteKillAnnounce", 0);

        //Honor Rate
        GainConquestRateEnable = sConfigMgr->GetBoolDefault("GainConquestGuard.GainConquestRateEnable", 0);
        GainConquestRate = abs(sConfigMgr->GetFloatDefault("GainConquestGuard.GainConquestRate", 1.0));
    }
};

class GainConquestGuardAnnouce : public PlayerScript
{

public:

    GainConquestGuardAnnouce() : PlayerScript("GainConquestGuardAnnouce") {}

    // Announce Module
    void OnLogin(Player* player, bool /*firstLogin*/) override
    {

        // Announce Module
        if (GainConquestGuardEnable)
        {
            if (GainConquestGuardAnnouceModule)
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cFF4682B4SPP Conquest for Elite Kills |module.");
            }
        }
    }
};

class GainConquestGuard : public PlayerScript
{

public:

    GainConquestGuard() : PlayerScript("GainConquestGuard") {}

    void OnCreatureKill(Player* player, Creature* killed)  //override
    {
        RewardConquest(player, killed);
    }

    void OnCreatureKilledByPet(Player* player, Creature* killed) //override
    {
        RewardConquest(player, killed);
    }

    //Reward Honor from either a Guard (creature 32768 flag) or Elite kill.  
    void RewardConquest(Player* player, Creature* killed)
    {
        if (GainConquestGuardEnable && player->IsAlive() && !player->InArena() && !player->HasAura(SPELL_AURA_PLAYER_INACTIVE))
        {
            if (killed || !killed->HasAuraType(SPELL_AURA_NO_PVP_CREDIT))
            {
                if ((GainConquestGuardOnGuardKill && killed->ToCreature()->IsGuard()) || (GainConquestGuardOnEliteKill && killed->ToCreature()->isElite()))
                {

                    std::ostringstream ss;
                    int honor = -1; //Honor is added as an int
                    float honor_f = (float)honor; //Convert honor to float for calculations 
                    player->UpdateHonorFields();

                    int groupsize = GetNumInGroup(player); //Determine if it was a gang beatdown

                    //Determine level that is gray
                    uint8 k_level = player->getLevel();
                    uint8 k_grey = Trinity::XP::GetGrayLevel(k_level);
                    uint8 v_level = killed->getLevel();


                    // If guard or elite is grey to the player then no honor rewarded
                    if (v_level > k_grey)
                    {
                        honor_f = ceil(Trinity::Honor::hk_honor_at_level_f(k_level) * (v_level - k_grey) / (k_level - k_grey));

                        // count the number of playerkills in one day
                        player->ApplyModUInt32Value(PLAYER_FIELD_KILLS, 1, true);
                        // and those in a lifetime
                        player->ApplyModUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 1, true);
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL);
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS, killed->getClass());
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_RACE, killed->getRace());
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA, player->GetAreaId());

                        if (killed != nullptr)
                        {
                            //A Gang beatdown of an enemy rewards less honor 
                            if (groupsize > 1)
                                honor_f /= groupsize;

                            // apply honor multiplier from aura (not stacking-get highest)
                            AddPct(honor_f, player->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HONOR_GAIN_PCT));
                        }

                        //Custom Gain Honor Rate 
                        if (GainConquestRateEnable)
                        {
                            honor_f *= GainConquestRate;
                        }
                        else
                        {
                            honor_f *= sWorld->getRate(RATE_HONOR);
                        }

                        //sLog->outError("%u: gained honor with a rate: %0.2f", player->GetGUID(), sWorld->getRate(RATE_HONOR));

                        // Convert Honor Back to an int to add to player
                        honor = int32(honor_f);

                        //Not sure if this works.  
                        WorldPacket data(SMSG_PVP_CREDIT, 4 + 8 + 4);
                        data << honor;

                        // add honor points to player
                        player->ModifyCurrency(CURRENCY_TYPE_CONQUEST_POINTS, honor, true, true);

                        //announce to player if honor was gained
                        if (GainConquestGuardOnGuardKill && killed->ToCreature()->IsGuard() && GainConquestGuardOnGuardKillAnnounce)
                        {
                            ss << "You have been awarded Conquest.";
                            ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), honor);
                        }
                        else if (GainConquestGuardOnEliteKill && killed->ToCreature()->isElite() && GainConquestGuardOnEliteKillAnnounce)
                        {
                            ss << "You have been awarded Conquest.";
                            ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), honor);
                        }
                    }
                }
            }
        }
    }

    // Get the player's group size
    int GetNumInGroup(Player* player)
    {
        int numInGroup = 1;
        Group* group = player->GetGroup();
        if (group) {
            Group::MemberSlotList const& groupMembers = group->GetMemberSlots();
            numInGroup = groupMembers.size();
        }
        return numInGroup;
    }

};

void AddGainConquestGuardScripts()
{
    new GainConquestGuardConfig();
    new GainConquestGuardAnnouce();
    new GainConquestGuard();
}
