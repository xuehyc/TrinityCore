/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WorldSession.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ReferAFriendPackets.h"
#include "World.h"

void WorldSession::HandleGrantLevel(WorldPackets::RaF::GrantLevel& grantLevel)
{
    Player* target = ObjectAccessor::GetPlayer(*_player, grantLevel.Target);

    // check cheating
    uint8 levels = _player->GetGrantableLevels();
    uint8 error = 0;
    if (!target)
        error = ERR_REFER_A_FRIEND_NO_TARGET;
    else if (levels == 0)
        error = ERR_REFER_A_FRIEND_INSUFFICIENT_GRANTABLE_LEVELS;
    else if (GetRecruiterId() != target->GetSession()->GetAccountId())
        error = ERR_REFER_A_FRIEND_NOT_REFERRED_BY;
    else if (target->GetTeamId() != _player->GetTeamId())
        error = ERR_REFER_A_FRIEND_DIFFERENT_FACTION;
    else if (target->getLevel() >= _player->getLevel())
        error = ERR_REFER_A_FRIEND_TARGET_TOO_HIGH;
    else if (target->getLevel() >= sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL))
        error = ERR_REFER_A_FRIEND_GRANT_LEVEL_MAX_I;
    else if (target->GetGroup() != _player->GetGroup())
        error = ERR_REFER_A_FRIEND_NOT_IN_GROUP;
    else if (target->getLevel() >= GetMaxLevelForExpansion(target->GetSession()->GetExpansion()))
        error = ERR_REFER_A_FRIEND_INSUF_EXPAN_LVL;

    if (error)
    {
        WorldPackets::RaF::ReferAFriendFailure failure;
        failure.Reason = error;
        if (error == ERR_REFER_A_FRIEND_NOT_IN_GROUP)
            failure.Str = target->GetName();

        SendPacket(failure.Write());
        return;
    }

    WorldPackets::RaF::ProposeLevelGrant proposeLevelGrant;
    proposeLevelGrant.Sender = _player->GetGUID();
    target->SendDirectMessage(proposeLevelGrant.Write());
}

void WorldSession::HandleAcceptGrantLevel(WorldPackets::RaF::AcceptLevelGrant& acceptLevelGrant)
{
    Player* other = ObjectAccessor::GetPlayer(*_player, acceptLevelGrant.Granter);
    if (!(other && other->GetSession()))
        return;

    if (GetAccountId() != other->GetSession()->GetRecruiterId())
        return;

    if (other->GetGrantableLevels())
        other->SetGrantableLevels(other->GetGrantableLevels() - 1);
    else
        return;

    _player->GiveLevel(_player->getLevel() + 1);
}
