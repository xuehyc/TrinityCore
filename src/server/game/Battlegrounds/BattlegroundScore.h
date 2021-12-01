/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_BATTLEGROUND_SCORE_H
#define SERVER_BATTLEGROUND_SCORE_H

#include "BattlegroundPackets.h"
#include "ObjectGuid.h"
#include <string>

enum ScoreType
{
    // ALL
    SCORE_KILLING_BLOWS         = 1,
    SCORE_DEATHS                = 2,
    SCORE_HONORABLE_KILLS       = 3,
    SCORE_BONUS_HONOR           = 4,
    SCORE_DAMAGE_DONE           = 5,
    SCORE_HEALING_DONE          = 6,

    // WS, EY and TP
    SCORE_FLAG_CAPTURES         = 7,
    SCORE_FLAG_RETURNS          = 8,

    // AB and IC
    SCORE_BASES_ASSAULTED       = 9,
    SCORE_BASES_DEFENDED        = 10,

    // AV
    SCORE_GRAVEYARDS_ASSAULTED  = 11,
    SCORE_GRAVEYARDS_DEFENDED   = 12,
    SCORE_TOWERS_ASSAULTED      = 13,
    SCORE_TOWERS_DEFENDED       = 14,
    SCORE_MINES_CAPTURED        = 15,

    // SOTA
    SCORE_DESTROYED_DEMOLISHER  = 16,
    SCORE_DESTROYED_WALL        = 17
};

struct BattlegroundScore
{
    friend class Arena;
    friend class Battleground;

    protected:
        BattlegroundScore(ObjectGuid playerGuid, uint32 team);
        virtual ~BattlegroundScore();

        virtual void UpdateScore(uint32 type, uint32 value);

        virtual void BuildPvPLogPlayerDataPacket(WorldPackets::Battleground::PVPLogData::PlayerData& playerData) const;

        // For Logging purpose
        virtual std::string ToString() const { return ""; }

        uint32 GetKillingBlows() const    { return KillingBlows; }
        uint32 GetDeaths() const          { return Deaths; }
        uint32 GetHonorableKills() const  { return HonorableKills; }
        uint32 GetBonusHonor() const      { return BonusHonor; }
        uint32 GetDamageDone() const      { return DamageDone; }
        uint32 GetHealingDone() const     { return HealingDone; }

        virtual uint32 GetAttr1() const { return 0; }
        virtual uint32 GetAttr2() const { return 0; }
        virtual uint32 GetAttr3() const { return 0; }
        virtual uint32 GetAttr4() const { return 0; }
        virtual uint32 GetAttr5() const { return 0; }

        ObjectGuid PlayerGuid;
        uint8 TeamId; // BattlegroundTeamId

        // Default score, present in every type
        uint32 KillingBlows;
        uint32 Deaths;
        uint32 HonorableKills;
        uint32 BonusHonor;
        uint32 DamageDone;
        uint32 HealingDone;
};

#endif // SERVER_BATTLEGROUND_SCORE_H
