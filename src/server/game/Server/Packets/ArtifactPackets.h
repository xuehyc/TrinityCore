/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ArtifactPackets_h__
#define ArtifactPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include "PacketUtilities.h"

namespace WorldPackets
{
    namespace Artifact
    {
        class ArtifactAddPower final : public ClientPacket
        {
        public:
            struct ArtifactPowerChoice
            {
                int32 ArtifactPowerID = 0;
                uint8 Rank = 0;
            };

            ArtifactAddPower(WorldPacket&& packet) : ClientPacket(CMSG_ARTIFACT_ADD_POWER, std::move(packet)) { }

            void Read() override;

            ObjectGuid ArtifactGUID;
            ObjectGuid ForgeGUID;
            Array<ArtifactPowerChoice, 1 /*lua allows only 1 power per call*/> PowerChoices;
        };

        class ArtifactSetAppearance final : public ClientPacket
        {
        public:
            ArtifactSetAppearance(WorldPacket&& packet) : ClientPacket(CMSG_ARTIFACT_SET_APPEARANCE, std::move(packet)) { }

            void Read() override;

            ObjectGuid ArtifactGUID;
            ObjectGuid ForgeGUID;
            int32 ArtifactAppearanceID = 0;
        };

        class ConfirmArtifactRespec final : public ClientPacket
        {
        public:
            ConfirmArtifactRespec(WorldPacket&& packet) : ClientPacket(CMSG_CONFIRM_ARTIFACT_RESPEC, std::move(packet)) { }

            void Read() override;

            ObjectGuid ArtifactGUID;
            ObjectGuid NpcGUID;
        };

        class ArtifactForgeOpened final : public ServerPacket
        {
        public:
            ArtifactForgeOpened() : ServerPacket(SMSG_ARTIFACT_FORGE_OPENED, 16 + 16) { }

            WorldPacket const* Write() override;

            ObjectGuid ArtifactGUID;
            ObjectGuid ForgeGUID;
        };

        class ArtifactRespecConfirm final : public ServerPacket
        {
        public:
            ArtifactRespecConfirm() : ServerPacket(SMSG_ARTIFACT_RESPEC_CONFIRM, 16 + 16) { }

            WorldPacket const* Write() override;

            ObjectGuid ArtifactGUID;
            ObjectGuid NpcGUID;
        };

        class ArtifactXpGain final : public ServerPacket
        {
        public:
            ArtifactXpGain() : ServerPacket(SMSG_ARTIFACT_XP_GAIN, 16 + 4) { }

            WorldPacket const* Write() override;

            ObjectGuid ArtifactGUID;
            uint64 Amount = 0;
        };

        class ArtifactKnowledge final : public ServerPacket
        {
        public:
            ArtifactKnowledge() : ServerPacket(SMSG_ARTIFACT_KNOWLEDGE, 1 + 4) { }

            WorldPacket const* Write() override;

            int32 ArtifactCategoryID = 0;
            int8 KnowledgeLevel = 0;
        };
    }
}

#endif // ArtifactPackets_h__
