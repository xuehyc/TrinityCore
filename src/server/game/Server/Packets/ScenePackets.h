/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ScenePackets_h__
#define ScenePackets_h__

#include "Packet.h"
#include "Object.h"

namespace WorldPackets
{
    namespace Scenes
    {
        class GAME_API PlayScene final : public ServerPacket
        {
        public:
            PlayScene() : ServerPacket(SMSG_PLAY_SCENE, 34) { }

            WorldPacket const* Write() override;

            int32 SceneID = 0;
            int32 PlaybackFlags = 0;
            int32 SceneInstanceID = 0;
            int32 SceneScriptPackageID = 0;
            ObjectGuid TransportGUID;
            Position Location;
        };

        class GAME_API CancelScene final : public ServerPacket
        {
        public:
            CancelScene() : ServerPacket(SMSG_CANCEL_SCENE, 4) { }

            WorldPacket const* Write() override;

            int32 SceneInstanceID = 0;
        };

        class SceneTriggerEvent final : public ClientPacket
        {
        public:
            SceneTriggerEvent(WorldPacket&& packet) : ClientPacket(CMSG_SCENE_TRIGGER_EVENT, std::move(packet)) { }

            void Read() override;

            uint32 SceneInstanceID = 0;
            std::string Event;
        };

        class ScenePlaybackComplete final : public ClientPacket
        {
        public:
            ScenePlaybackComplete(WorldPacket&& packet) : ClientPacket(CMSG_SCENE_PLAYBACK_COMPLETE, std::move(packet)) { }

            void Read() override;

            uint32 SceneInstanceID = 0;
        };

        class ScenePlaybackCanceled final : public ClientPacket
        {
        public:
            ScenePlaybackCanceled(WorldPacket&& packet) : ClientPacket(CMSG_SCENE_PLAYBACK_CANCELED, std::move(packet)) { }

            void Read() override;

            uint32 SceneInstanceID = 0;
        };
    }
}

#endif // ScenePackets_h__
