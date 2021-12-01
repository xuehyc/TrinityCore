/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef GOPackets_h__
#define GOPackets_h__

#include "Packet.h"
#include "DB2Stores.h"
#include "GameObject.h"
#include "WorldSession.h"

namespace WorldPackets
{
    namespace GameObject
    {
        class GameObjUse final : public ClientPacket
        {
        public:
            GameObjUse(WorldPacket&& packet) : ClientPacket(CMSG_GAME_OBJ_USE, std::move(packet)) { }

            void Read() override;

            ObjectGuid Guid;
        };

        class GameObjReportUse final : public ClientPacket
        {
        public:
            GameObjReportUse(WorldPacket&& packet) : ClientPacket(CMSG_GAME_OBJ_REPORT_USE, std::move(packet)) { }

            void Read() override;

            ObjectGuid Guid;
        };

        class GameObjectDespawn final : public ServerPacket
        {
        public:
            GameObjectDespawn() : ServerPacket(SMSG_GAME_OBJECT_DESPAWN, 16) { }

            WorldPacket const* Write() override;

            ObjectGuid ObjectGUID;
        };

        class PageText final : public ServerPacket
        {
        public:
            PageText() : ServerPacket(SMSG_PAGE_TEXT, 16) { }

            WorldPacket const* Write() override;

            ObjectGuid GameObjectGUID;
        };

        class GameObjectActivateAnimKit final : public ServerPacket
        {
        public:
            GameObjectActivateAnimKit() : ServerPacket(SMSG_GAME_OBJECT_ACTIVATE_ANIM_KIT, 16 + 4 + 1) { }

            WorldPacket const* Write() override;

            ObjectGuid ObjectGUID;
            int32 AnimKitID = 0;
            bool Maintain = false;
        };

        class DestructibleBuildingDamage final : public ServerPacket
        {
        public:
            DestructibleBuildingDamage() : ServerPacket(SMSG_DESTRUCTIBLE_BUILDING_DAMAGE, 16 + 16 + 16 + 4 + 4) { }

            WorldPacket const* Write() override;

            ObjectGuid Target;
            ObjectGuid Caster;
            ObjectGuid Owner;
            int32 Damage = 0;
            int32 SpellID = 0;
        };

        class FishNotHooked final : public ServerPacket
        {
        public:
            FishNotHooked() : ServerPacket(SMSG_FISH_NOT_HOOKED, 0) { }

            WorldPacket const* Write() override { return &_worldPacket; }
        };

        class FishEscaped final : public ServerPacket
        {
        public:
            FishEscaped() : ServerPacket(SMSG_FISH_ESCAPED, 0) { }

            WorldPacket const* Write() override { return &_worldPacket; }
        };

        class GameObjectCustomAnim final : public ServerPacket
        {
        public:
            GameObjectCustomAnim() : ServerPacket(SMSG_GAME_OBJECT_CUSTOM_ANIM, 16 + 4 + 1) { }

            WorldPacket const* Write() override;

            ObjectGuid ObjectGUID;
            uint32 CustomAnim = 0;
            bool PlayAsDespawn = false;
        };

        class GameObjectUIAction final : public ServerPacket
        {
        public:
            GameObjectUIAction() : ServerPacket(SMSG_GAME_OBJECT_UI_ACTION, 16 + 4) { }

            WorldPacket const* Write() override;

            ObjectGuid ObjectGUID;
            int32 UILink = 0;
        };
    }
}
#endif // GOPackets_h__
