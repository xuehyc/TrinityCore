/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ArenaScore.h"
#include <sstream>

ArenaScore::ArenaScore(ObjectGuid playerGuid, uint32 team) : BattlegroundScore(playerGuid, team)
{
}

void ArenaScore::BuildPvPLogPlayerDataPacket(WorldPackets::Battleground::PVPLogData::PlayerData& playerData) const
{
    BattlegroundScore::BuildPvPLogPlayerDataPacket(playerData);

    if (PreMatchRating)
        playerData.PreMatchRating = PreMatchRating;

    if (PostMatchRating != PreMatchRating)
        playerData.RatingChange = int32(PostMatchRating) - PreMatchRating;

    if (PreMatchMMR)
        playerData.PreMatchMMR = PreMatchMMR;

    if (PostMatchMMR != PreMatchMMR)
        playerData.MmrChange = int32(PostMatchMMR) - PreMatchMMR;
}

// For Logging purpose
std::string ArenaScore::ToString() const
{
    std::ostringstream stream;
    stream << "Damage done: " << DamageDone << ", Healing done: " << HealingDone << ", Killing blows: " << KillingBlows
        << ", PreMatchRating: " << PreMatchRating << ", PreMatchMMR: " << PreMatchMMR
        << ", PostMatchRating: " << PostMatchRating << ", PostMatchMMR: " << PostMatchMMR;
    return stream.str();
}

ArenaTeamScore::ArenaTeamScore()
{
}

ArenaTeamScore::~ArenaTeamScore()
{
}

void ArenaTeamScore::Assign(uint32 preMatchRating, uint32 postMatchRating, uint32 preMatchMMR, uint32 postMatchMMR)
{
    PreMatchRating = preMatchRating;
    PostMatchRating = postMatchRating;
    PreMatchMMR = preMatchMMR;
    PostMatchMMR = postMatchMMR;
}
