/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef GuildFinderPackets_h__
#define GuildFinderPackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include "Optional.h"

namespace WorldPackets
{
    namespace GuildFinder
    {
        class LFGuildAddRecruit final : public ClientPacket
        {
        public:
            LFGuildAddRecruit(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_ADD_RECRUIT, std::move(packet)) { }

            void Read() override;

            ObjectGuid GuildGUID;
            int32 Availability = 0;
            int32 ClassRoles = 0;
            int32 PlayStyle = 0;
            std::string Comment;
        };

        class LFGuildApplicationsListChanged final : public ServerPacket
        {
        public:
            LFGuildApplicationsListChanged() : ServerPacket(SMSG_LF_GUILD_APPLICATIONS_LIST_CHANGED, 0) { }

            WorldPacket const* Write() override { return &_worldPacket; }
        };

        class LFGuildApplicantListChanged final : public ServerPacket
        {
        public:
            LFGuildApplicantListChanged() : ServerPacket(SMSG_LF_GUILD_APPLICANT_LIST_CHANGED, 0) { }

            WorldPacket const* Write() override { return &_worldPacket; }
        };

        class LFGuildBrowse final : public ClientPacket
        {
        public:
            LFGuildBrowse(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_BROWSE, std::move(packet)) { }

            void Read() override;

            int32 CharacterLevel = 0;
            int32 Availability = 0;
            int32 ClassRoles = 0;
            int32 PlayStyle = 0;
        };

        struct LFGuildBrowseData
        {
            std::string GuildName;
            ObjectGuid GuildGUID;
            uint32 GuildVirtualRealm = 0;
            int32 GuildMembers = 0;
            int32 GuildAchievementPoints = 0;
            int32 PlayStyle = 0;
            int32 Availability = 0;
            int32 ClassRoles = 0;
            int32 LevelRange = 0;
            int32 EmblemStyle = 0;
            int32 EmblemColor = 0;
            int32 BorderStyle = 0;
            int32 BorderColor = 0;
            int32 Background = 0;
            std::string Comment;
            int8 Cached = 0;
            int8 MembershipRequested = 0;
        };

        class LFGuildBrowseResult final : public ServerPacket
        {
        public:
            LFGuildBrowseResult() : ServerPacket(SMSG_LF_GUILD_BROWSE) { }

            WorldPacket const* Write() override;

            std::vector<LFGuildBrowseData> Post;
        };

        class LFGuildDeclineRecruit final : public ClientPacket
        {
        public:
            LFGuildDeclineRecruit(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_DECLINE_RECRUIT, std::move(packet)) { }

            void Read() override;

            ObjectGuid RecruitGUID;
        };

        class LFGuildGetApplications final : public ClientPacket
        {
        public:
            LFGuildGetApplications(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_GET_APPLICATIONS, std::move(packet)) { }

            void Read() override { }
        };

        struct LFGuildApplicationData
        {
            ObjectGuid GuildGUID;
            uint32 GuildVirtualRealm = 0;
            std::string GuildName;
            int32 ClassRoles = 0;
            int32 PlayStyle = 0;
            int32 Availability = 0;
            uint32 SecondsSinceCreated = 0;
            uint32 SecondsUntilExpiration = 0;
            std::string Comment;
        };

        class LFGuildApplications final : public ServerPacket
        {
        public:
            LFGuildApplications() : ServerPacket(SMSG_LF_GUILD_APPLICATIONS) { }

            WorldPacket const* Write() override;

            std::vector<LFGuildApplicationData> Application;
            int32 NumRemaining = 0;
        };

        class LFGuildGetGuildPost final : public ClientPacket
        {
        public:
            LFGuildGetGuildPost(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_GET_GUILD_POST, std::move(packet)) { }

            void Read() override { }
        };

        struct GuildPostData
        {
            bool Active = false;
            int32 PlayStyle = 0;
            int32 Availability = 0;
            int32 ClassRoles = 0;
            int32 LevelRange = 0;
            time_t SecondsRemaining = time_t(0);
            std::string Comment;
        };

        class LFGuildPost final : public ServerPacket
        {
        public:
            LFGuildPost() : ServerPacket(SMSG_LF_GUILD_POST, 1 + 1 + 4 + 4 + 4 + 4 + 4 + 255) { }

            WorldPacket const* Write() override;

            Optional<GuildPostData> Post;
        };

        class LFGuildGetRecruits final : public ClientPacket
        {
        public:
            LFGuildGetRecruits(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_GET_RECRUITS, std::move(packet)) { }

            void Read() override;

            uint32 LastUpdate = 0;
        };

        struct LFGuildRecruitData
        {
            ObjectGuid RecruitGUID;
            std::string Name;
            uint32 RecruitVirtualRealm = 0;
            std::string Comment;
            int32 CharacterClass = 0;
            int32 CharacterGender = 0;
            int32 CharacterLevel = 0;
            int32 ClassRoles = 0;
            int32 PlayStyle = 0;
            int32 Availability = 0;
            uint32 SecondsSinceCreated = 0;
            uint32 SecondsUntilExpiration = 0;
        };

        class LFGuildRecruits final : public ServerPacket
        {
        public:
            LFGuildRecruits() : ServerPacket(SMSG_LF_GUILD_RECRUITS) { }

            WorldPacket const* Write() override;

            std::vector<LFGuildRecruitData> Recruits;
            time_t UpdateTime = time_t(0);
        };

        class LFGuildRemoveRecruit final : public ClientPacket
        {
        public:
            LFGuildRemoveRecruit(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_REMOVE_RECRUIT, std::move(packet)) { }

            void Read() override;

            ObjectGuid GuildGUID;
        };

        class LFGuildSetGuildPost final : public ClientPacket
        {
        public:
            LFGuildSetGuildPost(WorldPacket&& packet) : ClientPacket(CMSG_LF_GUILD_SET_GUILD_POST, std::move(packet)) { }

            void Read() override;

            int32 Availability = 0;
            int32 PlayStyle = 0;
            int32 ClassRoles = 0;
            int32 LevelRange = 0;
            bool Active = false;
            std::string Comment;
        };
    }
}

#endif // GuildFinderPackets_h__
