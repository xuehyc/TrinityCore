/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WorldStatePackets.h"

WorldPackets::WorldState::InitWorldStates::InitWorldStates()
    : ServerPacket(SMSG_INIT_WORLD_STATES, 16) { }

WorldPacket const* WorldPackets::WorldState::InitWorldStates::Write()
{
    _worldPacket.reserve(16 + Worldstates.size() * 8);

    _worldPacket << uint32(MapID);
    _worldPacket << uint32(AreaID);
    _worldPacket << uint32(SubareaID);

    _worldPacket << uint32(Worldstates.size());
    for (WorldStateInfo const& wsi : Worldstates)
    {
        _worldPacket << uint32(wsi.VariableID);
        _worldPacket << int32(wsi.Value);
    }

    return &_worldPacket;
}

WorldPackets::WorldState::UpdateWorldState::UpdateWorldState()
    : ServerPacket(SMSG_UPDATE_WORLD_STATE, 9) { }

WorldPacket const* WorldPackets::WorldState::UpdateWorldState::Write()
{
    _worldPacket << uint32(VariableID);
    _worldPacket << int32(Value);
    _worldPacket.WriteBit(Hidden);
    _worldPacket.FlushBits();

    return &_worldPacket;
}
