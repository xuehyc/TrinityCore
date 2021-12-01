/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef AreaTriggerPackets_h__
#define AreaTriggerPackets_h__

#include "Packet.h"
#include "AreaTriggerTemplate.h"
#include "ObjectGuid.h"
#include "Optional.h"

namespace WorldPackets
{
    namespace AreaTrigger
    {
        struct AreaTriggerSplineInfo
        {
            uint32 TimeToTarget = 0;
            uint32 ElapsedTimeForMovement = 0;
            std::vector<TaggedPosition<Position::XYZ>> Points;
        };

        class AreaTrigger final : public ClientPacket
        {
        public:
            AreaTrigger(WorldPacket&& packet) : ClientPacket(CMSG_AREA_TRIGGER, std::move(packet)) { }

            void Read() override;

            int32 AreaTriggerID = 0;
            bool Entered = false;
            bool FromClient = false;
        };

        class AreaTriggerDenied final : public ServerPacket
        {
        public:
            AreaTriggerDenied() : ServerPacket(SMSG_AREA_TRIGGER_DENIED, 5) { }

            int32 AreaTriggerID = 0;
            bool Entered = false;

            WorldPacket const* Write() override;
        };

        class AreaTriggerNoCorpse final : public ServerPacket
        {
        public:
            AreaTriggerNoCorpse() : ServerPacket(SMSG_AREA_TRIGGER_NO_CORPSE, 0) { }

            WorldPacket const* Write() override { return &_worldPacket; }
        };

        class AreaTriggerRePath final : public ServerPacket
        {
        public:
            AreaTriggerRePath() : ServerPacket(SMSG_AREA_TRIGGER_RE_PATH, 50) { }

            WorldPacket const* Write() override;

            AreaTriggerSplineInfo AreaTriggerSpline;
            ObjectGuid TriggerGUID;
        };

        class AreaTriggerReShape final : public ServerPacket
        {
        public:
            AreaTriggerReShape() : ServerPacket(SMSG_AREA_TRIGGER_RE_SHAPE, 17) { }

            WorldPacket const* Write() override;

            Optional<AreaTriggerSplineInfo> AreaTriggerSpline;
            Optional<AreaTriggerCircularMovementInfo> AreaTriggerCircularMovement;
            ObjectGuid TriggerGUID;
        };
    }
}

ByteBuffer& operator<<(ByteBuffer& data, AreaTriggerCircularMovementInfo const& areaTriggerCircularMovement);

#endif // AreaTriggerPackets_h__
