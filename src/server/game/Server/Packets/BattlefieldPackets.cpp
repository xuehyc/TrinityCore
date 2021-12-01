/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "BattlefieldPackets.h"

WorldPacket const* WorldPackets::Battlefield::BFMgrEntryInvite::Write()
{
    _worldPacket << uint64(QueueID);
    _worldPacket << uint32(AreaID);
    _worldPacket << uint32(ExpireTime);
    return &_worldPacket;
}

void WorldPackets::Battlefield::BFMgrEntryInviteResponse::Read()
{
    _worldPacket >> QueueID;
    AcceptedInvite = _worldPacket.ReadBit();
}

WorldPacket const* WorldPackets::Battlefield::BFMgrQueueInvite::Write()
{
    _worldPacket << uint64(QueueID);
    _worldPacket << int8(BattleState);
    _worldPacket << uint32(Timeout);
    _worldPacket << int32(MinLevel);
    _worldPacket << int32(MaxLevel);
    _worldPacket << int32(MapID);
    _worldPacket << uint32(InstanceID);
    _worldPacket.WriteBit(Index != 0);
    _worldPacket.FlushBits();
    return &_worldPacket;
}

void WorldPackets::Battlefield::BFMgrQueueInviteResponse::Read()
{
    _worldPacket >> QueueID;
    AcceptedInvite = _worldPacket.ReadBit();
}

WorldPacket const* WorldPackets::Battlefield::BFMgrQueueRequestResponse::Write()
{
    _worldPacket << uint64(QueueID);
    _worldPacket << int32(AreaID);
    _worldPacket << int8(Result);
    _worldPacket << FailedPlayerGUID;
    _worldPacket << int8(BattleState);
    _worldPacket.WriteBit(LoggingIn);
    _worldPacket.FlushBits();
    return &_worldPacket;
}

void WorldPackets::Battlefield::BFMgrQueueExitRequest::Read()
{
    _worldPacket >> QueueID;
}

WorldPacket const* WorldPackets::Battlefield::BFMgrEntering::Write()
{
    _worldPacket.WriteBit(ClearedAFK);
    _worldPacket.WriteBit(Relocated);
    _worldPacket.WriteBit(OnOffense);
    _worldPacket << uint64(QueueID);
    return &_worldPacket;
}

WorldPacket const* WorldPackets::Battlefield::BFMgrEjected::Write()
{
    _worldPacket << uint64(QueueID);
    _worldPacket << int8(Reason);
    _worldPacket << int8(BattleState);
    _worldPacket.WriteBit(Relocated);
    _worldPacket.FlushBits();
    return &_worldPacket;
}
