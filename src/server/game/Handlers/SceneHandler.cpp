/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "Common.h"
#include "Log.h"
#include "ScenePackets.h"
#include "WorldSession.h"
#include "Player.h"

void WorldSession::HandleSceneTriggerEvent(WorldPackets::Scenes::SceneTriggerEvent& sceneTriggerEvent)
{
    LOG_DEBUG("scenes", "HandleSceneTriggerEvent: SceneInstanceID: %u Event: %s", sceneTriggerEvent.SceneInstanceID, sceneTriggerEvent.Event.c_str());

    GetPlayer()->GetSceneMgr().OnSceneTrigger(sceneTriggerEvent.SceneInstanceID, sceneTriggerEvent.Event);
}

void WorldSession::HandleScenePlaybackComplete(WorldPackets::Scenes::ScenePlaybackComplete& scenePlaybackComplete)
{
    LOG_DEBUG("scenes", "HandleScenePlaybackComplete: SceneInstanceID: %u", scenePlaybackComplete.SceneInstanceID);

    GetPlayer()->GetSceneMgr().OnSceneComplete(scenePlaybackComplete.SceneInstanceID);
}

void WorldSession::HandleScenePlaybackCanceled(WorldPackets::Scenes::ScenePlaybackCanceled& scenePlaybackCanceled)
{
    LOG_DEBUG("scenes", "HandleScenePlaybackCanceled: SceneInstanceID: %u", scenePlaybackCanceled.SceneInstanceID);

    GetPlayer()->GetSceneMgr().OnSceneCancel(scenePlaybackCanceled.SceneInstanceID);
}
