/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ReferAFriendPackets.h"

void WorldPackets::RaF::AcceptLevelGrant::Read()
{
    _worldPacket >> Granter;
}

void WorldPackets::RaF::GrantLevel::Read()
{
    _worldPacket >> Target;
}

WorldPacket const* WorldPackets::RaF::ProposeLevelGrant::Write()
{
    _worldPacket << Sender;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::RaF::ReferAFriendFailure::Write()
{
    _worldPacket << int32(Reason);
    // Client uses this string only if Reason == ERR_REFER_A_FRIEND_NOT_IN_GROUP || Reason == ERR_REFER_A_FRIEND_SUMMON_OFFLINE_S
    // but always reads it from packet
    _worldPacket.WriteBits(Str.length(), 6);
    _worldPacket.FlushBits();
    _worldPacket.WriteString(Str);

    return &_worldPacket;
}
