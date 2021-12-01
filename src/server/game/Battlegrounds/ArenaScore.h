/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_ARENA_SCORE_H
#define SERVER_ARENA_SCORE_H

#include "BattlegroundScore.h"

struct GAME_API ArenaScore : public BattlegroundScore
{
    friend class Arena;

    protected:
        ArenaScore(ObjectGuid playerGuid, uint32 team);

        void BuildPvPLogPlayerDataPacket(WorldPackets::Battleground::PVPLogData::PlayerData& playerData) const override;

        // For Logging purpose
        std::string ToString() const override;

        uint32 PreMatchRating = 0;
        uint32 PreMatchMMR = 0;
        uint32 PostMatchRating = 0;
        uint32 PostMatchMMR = 0;
};

struct GAME_API ArenaTeamScore
{
    friend class Arena;
    friend class Battleground;

    protected:
        ArenaTeamScore();
        virtual ~ArenaTeamScore();

        void Assign(uint32 preMatchRating, uint32 postMatchRating, uint32 preMatchMMR, uint32 postMatchMMR);

        uint32 PreMatchRating = 0;
        uint32 PostMatchRating = 0;
        uint32 PreMatchMMR = 0;
        uint32 PostMatchMMR = 0;
};

#endif // SERVER_ARENA_SCORE_H
