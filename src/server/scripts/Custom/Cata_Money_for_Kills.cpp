/*
Money for Kills Module 434 Edition
Original Module by StygianTheBest for AzerothCore
(https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
Modified by SPP DEV MDIC
For Gwenpool 434 Branch.
*/
#include "Chat.h"
#include "Config.h"
#include "Creature.h"
#include "Group.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Guild.h"
#include "World.h"

enum KillType
{
    KILLTYPE_LOOT,
    KILLTYPE_PVP,
    KILLTYPE_DUNGEONBOSS,
    KILLTYPE_WORLDBOSS,
    KILLTYPE_MOB,
    KILLTYPE_SUICIDE
};

static constexpr const char* MFKEnable = "MFK.Enable";
static constexpr const char* MFKAnnounce = "MFK.Announce";
static constexpr const char* MFKAnnounceWorldBoss = "MFK.Announce.World.WorldBoss";
static constexpr const char* MFKAnnounceDungeonBoss = "MFK.Announce.Group.DungeonBoss";
static constexpr const char* MFKAnnounceWorldSuicide = "MFK.Announce.World.Suicide";
static constexpr const char* MFKAnnounceGuildSuicide = "MFK.Announce.Guild.Suicide";
static constexpr const char* MFKAnnounceGroupSuicide = "MFK.Announce.Group.Suicide";
static constexpr const char* MFKAnnouncePvP = "MFK.Announce.World.PvP";
static constexpr const char* MFKBountyKillingBlow = "MFK.Bounty.KillingBlowOnly";
static constexpr const char* MFKBountyMoneyForNothing = "MFK.Bounty.MoneyForNothing";
static constexpr const char* MFKPVPCorpseLootPercent = "MFK.PVP.CorpseLootPercent";
static constexpr const char* MFKBountyKillMult = "MFK.Bounty.Kill.Multiplier";
static constexpr const char* MFKPVPKillMult = "MFK.PVP.Kill.Multiplier";
static constexpr const char* MFKBountyKillDBMult = "MFK.Bounty.DungeonBoss.Multiplier";
static constexpr const char* MFKBountyKillWBMult = "MFK.Bounty.WorldBoss.Multiplier";

class MoneyForKills : public PlayerScript
{
public:
    MoneyForKills() : PlayerScript("MoneyForKills") { }

    // Announce Module
    void OnLogin(Player* player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault(MFKEnable, true))
        {
            if (sConfigMgr->GetBoolDefault(MFKAnnounce, true))
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cFFB8860BSPP Cata Money For Kills |rmodule.");
            }
        }
    }

    // Player Kill Reward
    void OnPVPKill(Player* killer, Player* victim)
    {
        // If enabled...
        if (sConfigMgr->GetBoolDefault(MFKEnable, true))
        {
            const uint32 PVPMultiplier = sConfigMgr->GetIntDefault(MFKPVPKillMult, 0);
            const uint32 VictimLevel = victim->getLevel();

            // If enabled...
            if (PVPMultiplier > 0)
            {
                // No reward for killing yourself
                if (killer->GetGUID() == victim->GetGUID())
                {
                    Notify(killer, victim, nullptr, KILLTYPE_SUICIDE, 0);
                    return;
                }

                const int BountyAmount = ((VictimLevel * PVPMultiplier) / 3);

                // Pay the player the additional PVP bounty
                killer->ModifyMoney(BountyAmount);
                // Inform the player of the bounty amount
                Notify(killer, victim, nullptr, KILLTYPE_PVP, BountyAmount);
            }

            // Calculate the amount of gold to give to the victor
            const uint32 PVPCorpseLootPercent = sConfigMgr->GetIntDefault(MFKPVPCorpseLootPercent, 5);
            const int VictimLoot = (victim->GetMoney() * PVPCorpseLootPercent) / 100;

            // Rifle the victim's corpse for loot
            if (victim->GetMoney() >= 10000 && VictimLoot > 0)
            {
                // Player loots a percentage of the victim's gold
                killer->ModifyMoney(VictimLoot);
                victim->ModifyMoney(-VictimLoot);

                // Inform the player of the corpse loot
                Notify(killer, victim, nullptr, KILLTYPE_LOOT, VictimLoot);
            }

            return;
        }
    }

    // Creature Kill Reward
    void OnCreatureKill(Player* player, Creature* killed)
    {
        // If enabled...
        if (sConfigMgr->GetBoolDefault(MFKEnable, true))
        {
            // Get the creature level
            const uint32 CreatureLevel = killed->getLevel();
            uint32 BossMultiplier = 0;
            uint32 KillMultiplier = 0;
            KillType CreatureType;

            if (killed->IsDungeonBoss()) {
                BossMultiplier = sConfigMgr->GetIntDefault(MFKBountyKillDBMult, 0);
                CreatureType = KILLTYPE_DUNGEONBOSS;
            }
            else if (killed->isWorldBoss()) {
                BossMultiplier = sConfigMgr->GetIntDefault(MFKBountyKillWBMult, 0);
                CreatureType = KILLTYPE_WORLDBOSS;
            }
            else
            {
                KillMultiplier = sConfigMgr->GetIntDefault(MFKBountyKillMult, 0);
                CreatureType = KILLTYPE_MOB;
            }

            if (BossMultiplier > 0)
            {
                // Reward based on creature level
                const int BountyAmount = ((CreatureLevel * BossMultiplier) * 100);

                if (CreatureType == KILLTYPE_WORLDBOSS)
                {
                    Notify(player, nullptr, killed, KILLTYPE_WORLDBOSS, BountyAmount);
                    CreatureBounty(player, killed, KILLTYPE_MOB, BountyAmount);
                }
                else
                {
                    CreatureBounty(player, killed, CreatureType, BountyAmount);
                }

            }

            if (KillMultiplier > 0)
            {
                // Reward based on creature level
                const int BountyAmount = ((CreatureLevel * KillMultiplier) / 3);

                // Pay the bounty amount
                CreatureBounty(player, killed, CreatureType, BountyAmount);
            }
        }
    }

    // Pay Creature Bounty
    void CreatureBounty(Player* player, Creature* killed, KillType kType, int bounty)
    {
        Group* group = player->GetGroup();
        const uint32 KillingBlowOnly = sConfigMgr->GetIntDefault(MFKBountyKillingBlow, 0);

        // Determine who receives the bounty
        if (!group || KillingBlowOnly == 1)
        {
            // Pay a specific player bounty amount
            player->ModifyMoney(bounty);

            // Inform the player of the bounty amount
            Notify(player, nullptr, killed, kType, bounty);
        }
        else
        {
            const uint32 MoneyForNothing = sConfigMgr->GetIntDefault(MFKBountyMoneyForNothing, 0);
            Group::MemberSlotList const& members = group->GetMemberSlots();

            // Pay the group (OnCreatureKill only rewards the player that got the killing blow)
            for (auto itr = members.begin(); itr != members.end(); ++itr)
            {
                Player* playerInGroup = ObjectAccessor::FindPlayer((*itr).guid);

                // Pay each player in the group
                if (playerInGroup && playerInGroup->GetSession())
                {
                    // Money for nothing and the kills for free..
                    if (MoneyForNothing == 1)
                    {
                        // Pay the bounty
                        playerInGroup->ModifyMoney(bounty);

                        // Inform the player of the bounty amount
                        Notify(playerInGroup, nullptr, killed, kType, bounty);
                    }
                    else
                    {
                        // Only pay players that are in reward distance	
                        if (playerInGroup->IsAtGroupRewardDistance(killed))
                        {
                            // Pay the bounty
                            playerInGroup->ModifyMoney(bounty);

                            // Inform the player of the bounty amount
                            Notify(playerInGroup, nullptr, killed, kType, bounty);
                        }
                    }
                }
            }
        }
    }

    void Notify(Player* killer, Player* victim, Creature* killed, KillType kType, int reward)
    {
        int rewardBreakdown[3];
        rewardBreakdown[0] = reward / 10000;
        reward = reward - rewardBreakdown[0] * 10000;
        rewardBreakdown[1] = reward / 100;
        rewardBreakdown[2] = reward - (rewardBreakdown[1] * 100);

        std::string rewardMsg = "";
        std::string victimMsg = "";
        std::string rewardVal = BuildRewardString(&rewardBreakdown[0]);
        switch (kType)
        {
        case KILLTYPE_LOOT:
            rewardMsg.append("You loot").append(rewardVal).append(" from the corpse.");
            victimMsg.append(killer->GetName()).append(" rifles through your corpse and takes").append(rewardVal).append(".");
            ChatHandler(victim->GetSession()).SendSysMessage(victimMsg.c_str());
            ChatHandler(killer->GetSession()).SendSysMessage(rewardMsg.c_str());
            break;
        case KILLTYPE_PVP:
            if (sConfigMgr->GetBoolDefault(MFKAnnouncePvP, true))
            {
                rewardMsg.append("|cff676767[ |cffFFFF00World |cff676767]|r:|cff4CFF00 ").append(killer->GetName()).append(" |cffFF0000has slain ");
                rewardMsg.append(victim->GetName()).append(" earning a bounty of").append(rewardVal).append(".");
                sWorld->SendServerMessage(SERVER_MSG_STRING, rewardMsg.c_str());
            }
            break;
        case KILLTYPE_DUNGEONBOSS:
            if (sConfigMgr->GetBoolDefault(MFKAnnounceDungeonBoss, true))
            {
                rewardMsg.append("|cffFF8000Your group has defeated |cffFF0000").append(killed->GetName()).append("|cffFF8000.");
                ChatHandler(killer->GetSession()).SendSysMessage(rewardMsg.c_str());
                rewardMsg.clear();
            }
            break;
        case KILLTYPE_WORLDBOSS:
            if (sConfigMgr->GetBoolDefault(MFKAnnounceWorldBoss, true))
            {
                rewardMsg.append("|cffFF0000[ |cffFFFF00World |cffFF0000]|r:|cff4CFF00 ").append(killer->GetName());
                rewardMsg.append("'s|r group triumphed victoriously over |CFF18BE00[").append(killed->GetName()).append("]|r !");
                sWorld->SendServerMessage(SERVER_MSG_STRING, rewardMsg.c_str());
                rewardMsg.clear();
            }
            break;
        case KILLTYPE_MOB:
            break;
        case KILLTYPE_SUICIDE:
            std::string message = "|cff4CFF00 ";
            message.append(killer->GetName());
            message.append(" met an untimely demise!");

            if (sConfigMgr->GetBoolDefault(MFKAnnounceWorldSuicide, true))
                sWorld->SendServerMessage(SERVER_MSG_STRING, message.c_str());

            if (sConfigMgr->GetBoolDefault(MFKAnnounceGuildSuicide, false))
            {
                Guild* guild = killer->GetGuild();
                if (guild)
                    guild->BroadcastToGuild(killer->GetSession(), false, message, LANG_UNIVERSAL);
            }

            if (sConfigMgr->GetBoolDefault(MFKAnnounceGroupSuicide, false))
            {
                Group* group = killer->GetGroup();
                if (group)
                {
                    Group::MemberSlotList const& members = group->GetMemberSlots();

                    for (auto itr = members.begin(); itr != members.end(); ++itr)
                    {
                        Player* playerInGroup = ObjectAccessor::FindPlayer((*itr).guid);
                        if (playerInGroup)
                            ChatHandler(playerInGroup->GetSession()).SendSysMessage(message.c_str());
                    }
                }
            }

        }

        if (kType != KILLTYPE_LOOT && kType != KILLTYPE_WORLDBOSS && kType != KILLTYPE_SUICIDE)
        {
            rewardMsg.clear();
            rewardMsg.append("You receive a bounty of");
            rewardMsg.append(rewardVal);
            rewardMsg.append(" for the kill.");
            ChatHandler(killer->GetSession()).SendSysMessage(rewardMsg.c_str());
        }
    }

    std::string BuildRewardString(int* reward)
    {
        std::string currSymbol[3] = { " gold", " silver", " copper" };
        std::string rewardMsg = "";
        for (int i = 0; i < 3; i++)
        {
            if (reward[i] > 0)
            {
                rewardMsg.append(" ").append(std::to_string(reward[i]));
                rewardMsg.append(currSymbol[i]);
            }
        }

        return rewardMsg;
    }
};

void AddMoneyForKillsScripts()
{
    new MoneyForKills();
}
