/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#pragma once

#include "Packet.h"
#include "DBCEnums.h"
#include "ItemPacketsCommon.h"
#include "ObjectGuid.h"
#include "RaceMask.h"
#include "SharedDefines.h"

class Item;

namespace WorldPackets
{
    namespace Inspect
    {
        class Inspect final : public ClientPacket
        {
        public:
            Inspect(WorldPacket&& packet) : ClientPacket(CMSG_INSPECT, std::move(packet)) { }

            void Read() override;

            ObjectGuid Target;
        };

        struct InspectEnchantData
        {
            InspectEnchantData(uint32 id, uint8 index) : Id(id), Index(index) { }

            uint32 Id   = 0;
            uint8 Index = 0;
        };

        struct InspectItemData
        {
            InspectItemData(::Item const* item, uint8 index);

            ObjectGuid CreatorGUID;
            Item::ItemInstance Item;
            uint8 Index = 0;
            bool Usable = false;
            std::vector<InspectEnchantData> Enchants;
            std::vector<Item::ItemGemData> Gems;
        };

        struct InspectGuildData
        {
            ObjectGuid GuildGUID;
            int32 NumGuildMembers = 0;
            int32 AchievementPoints = 0;
        };

        class InspectResult final : public ServerPacket
        {
        public:
            InspectResult() : ServerPacket(SMSG_INSPECT_RESULT, 45) { }

            WorldPacket const* Write() override;

            ObjectGuid InspecteeGUID;
            std::vector<InspectItemData> Items;
            std::vector<uint16> Glyphs;
            std::vector<uint16> Talents;
            std::vector<uint16> PvpTalents;
            int32 ClassID = CLASS_NONE;
            int32 GenderID = GENDER_NONE;
            Optional<InspectGuildData> GuildData;
            int32 SpecializationID = 0;
        };

        class RequestHonorStats final : public ClientPacket
        {
        public:
            RequestHonorStats(WorldPacket&& packet) : ClientPacket(CMSG_REQUEST_HONOR_STATS, std::move(packet)) { }

            void Read() override;

            ObjectGuid TargetGUID;
        };

        class InspectHonorStats final : public ServerPacket
        {
        public:
            InspectHonorStats() : ServerPacket(SMSG_INSPECT_HONOR_STATS, 25) { }

            WorldPacket const* Write() override;

            ObjectGuid PlayerGUID;
            uint32 LifetimeHK     = 0;
            uint16 YesterdayHK    = 0;
            uint16 TodayHK        = 0;
            uint8 LifetimeMaxRank = 0;
        };

        class InspectPVPRequest final : public ClientPacket
        {
        public:
            InspectPVPRequest(WorldPacket&& packet) : ClientPacket(CMSG_INSPECT_PVP, std::move(packet)) { }

            void Read() override;

            ObjectGuid InspectTarget;
            uint32 InspectRealmAddress = 0;
        };

        struct PVPBracketData
        {
            int32 Rating           = 0;
            int32 Rank             = 0;
            int32 WeeklyPlayed     = 0;
            int32 WeeklyWon        = 0;
            int32 SeasonPlayed     = 0;
            int32 SeasonWon        = 0;
            int32 WeeklyBestRating = 0;
            int32 Unk710           = 0;
            uint8 Bracket          = 0;
        };

        class InspectPVPResponse final : public ServerPacket
        {
        public:
            InspectPVPResponse() : ServerPacket(SMSG_INSPECT_PVP, 17) { }

            WorldPacket const* Write() override;

            std::vector<PVPBracketData> Bracket;
            ObjectGuid ClientGUID;
        };

        class QueryInspectAchievements final : public ClientPacket
        {
        public:
            QueryInspectAchievements(WorldPacket&& packet) : ClientPacket(CMSG_QUERY_INSPECT_ACHIEVEMENTS, std::move(packet)) { }

            void Read() override;

            ObjectGuid Guid;
        };

        /// RespondInspectAchievements in AchievementPackets
    }
}
