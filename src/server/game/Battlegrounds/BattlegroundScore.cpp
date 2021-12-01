/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "BattlegroundScore.h"
#include "Errors.h"
#include "SharedDefines.h"

BattlegroundScore::BattlegroundScore(ObjectGuid playerGuid, uint32 team) : PlayerGuid(playerGuid), TeamId(team == ALLIANCE ? BG_TEAM_ALLIANCE : BG_TEAM_HORDE),
    KillingBlows(0), Deaths(0), HonorableKills(0), BonusHonor(0), DamageDone(0), HealingDone(0)
{
}

BattlegroundScore::~BattlegroundScore()
{
}

void BattlegroundScore::UpdateScore(uint32 type, uint32 value)
{
    switch (type)
    {
        case SCORE_KILLING_BLOWS:   // Killing blows
            KillingBlows += value;
            break;
        case SCORE_DEATHS:          // Deaths
            Deaths += value;
            break;
        case SCORE_HONORABLE_KILLS: // Honorable kills
            HonorableKills += value;
            break;
        case SCORE_BONUS_HONOR:     // Honor bonus
            BonusHonor += value;
            break;
        case SCORE_DAMAGE_DONE:     // Damage Done
            DamageDone += value;
            break;
        case SCORE_HEALING_DONE:    // Healing Done
            HealingDone += value;
            break;
        default:
            ASSERT(false, "Not implemented Battleground score type %u!", type);
            break;
    }
}

void BattlegroundScore::BuildPvPLogPlayerDataPacket(WorldPackets::Battleground::PVPLogData::PlayerData& playerData) const
{
    playerData.PlayerGUID = PlayerGuid;
    playerData.Kills = KillingBlows;
    playerData.Faction = TeamId;
    if (HonorableKills || Deaths || BonusHonor)
    {
        playerData.Honor = boost::in_place();
        playerData.Honor->HonorKills = HonorableKills;
        playerData.Honor->Deaths = Deaths;
        playerData.Honor->ContributionPoints = BonusHonor;
    }

    playerData.DamageDone = DamageDone;
    playerData.HealingDone = HealingDone;
}
