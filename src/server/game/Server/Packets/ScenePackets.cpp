/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScenePackets.h"

WorldPacket const* WorldPackets::Scenes::PlayScene::Write()
{
    _worldPacket << int32(SceneID);
    _worldPacket << int32(PlaybackFlags);
    _worldPacket << int32(SceneInstanceID);
    _worldPacket << int32(SceneScriptPackageID);
    _worldPacket << TransportGUID;
    _worldPacket << Location.PositionXYZOStream();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Scenes::CancelScene::Write()
{
    _worldPacket << int32(SceneInstanceID);

    return &_worldPacket;
}

void WorldPackets::Scenes::SceneTriggerEvent::Read()
{
    uint32 len = _worldPacket.ReadBits(6);
    _worldPacket >> SceneInstanceID;
    Event = _worldPacket.ReadString(len);
}

void WorldPackets::Scenes::ScenePlaybackComplete::Read()
{
    _worldPacket >> SceneInstanceID;
}

void WorldPackets::Scenes::ScenePlaybackCanceled::Read()
{
    _worldPacket >> SceneInstanceID;
}
