/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "DuelPackets.h"

void WorldPackets::Duel::CanDuel::Read()
{
    _worldPacket >> TargetGUID;
}

WorldPacket const* WorldPackets::Duel::CanDuelResult::Write()
{
    _worldPacket << TargetGUID;
    _worldPacket.WriteBit(Result);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Duel::DuelComplete::Write()
{
    _worldPacket.WriteBit(Started);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Duel::DuelCountdown::Write()
{
    _worldPacket << Countdown;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Duel::DuelRequested::Write()
{
    _worldPacket << ArbiterGUID;
    _worldPacket << RequestedByGUID;
    _worldPacket << RequestedByWowAccount;

    return &_worldPacket;
}

void WorldPackets::Duel::DuelResponse::Read()
{
    _worldPacket >> ArbiterGUID;
    Accepted = _worldPacket.ReadBit();
}

WorldPacket const* WorldPackets::Duel::DuelWinner::Write()
{
    _worldPacket.WriteBits(BeatenName.size(), 6);
    _worldPacket.WriteBits(WinnerName.size(), 6);
    _worldPacket.WriteBit(Fled);
    _worldPacket << BeatenVirtualRealmAddress;
    _worldPacket << WinnerVirtualRealmAddress;
    _worldPacket.WriteString(BeatenName);
    _worldPacket.WriteString(WinnerName);

    return &_worldPacket;
}
