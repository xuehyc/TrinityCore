/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ReputationPackets.h"

WorldPacket const* WorldPackets::Reputation::InitializeFactions::Write()
{
    for (uint16 i = 0; i < FactionCount; ++i)
    {
        _worldPacket << uint8(FactionFlags[i]);
        _worldPacket << int32(FactionStandings[i]);
    }

    for (uint16 i = 0; i < FactionCount; ++i)
        _worldPacket.WriteBit(FactionHasBonus[i]);

    _worldPacket.FlushBits();

    return &_worldPacket;
}

ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::Reputation::ForcedReaction const& forcedReaction)
{
    data << int32(forcedReaction.Faction);
    data << int32(forcedReaction.Reaction);
    return data;
}

WorldPacket const* WorldPackets::Reputation::SetForcedReactions::Write()
{
    _worldPacket << uint32(Reactions.size());
    for (ForcedReaction const& reaction : Reactions)
        _worldPacket << reaction;

    _worldPacket.FlushBits();

    return &_worldPacket;
}

ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::Reputation::FactionStandingData const& factionStanding)
{
    data << int32(factionStanding.Index);
    data << int32(factionStanding.Standing);
    return data;
}

WorldPacket const* WorldPackets::Reputation::SetFactionStanding::Write()
{
    _worldPacket << float(ReferAFriendBonus);
    _worldPacket << float(BonusFromAchievementSystem);
    _worldPacket << uint32(Faction.size());
    for (FactionStandingData const& factionStanding : Faction)
        _worldPacket << factionStanding;

    _worldPacket.WriteBit(ShowVisual);
    _worldPacket.FlushBits();

    return &_worldPacket;
}
