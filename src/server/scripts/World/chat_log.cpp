/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "Channel.h"
#include "Group.h"
#include "Guild.h"
#include "Log.h"
#include "Player.h"

class ChatLogScript : public PlayerScript
{
    public:
        ChatLogScript() : PlayerScript("ChatLogScript") { }

        void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg) override
        {
            time_t tt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

            std::tm aTm;
            localtime_r(&tt, &aTm);

            switch (type)
            {
                case CHAT_MSG_SAY:
                    TC_LOG_INFO("chat.log.say", "%04d-%02d-%02d %02d:%02d:%02d Player %s says (language %u): %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), lang, msg.c_str());
                    break;

                case CHAT_MSG_EMOTE:
                    TC_LOG_INFO("chat.log.emote", "%04d-%02d-%02d %02d:%02d:%02d Player %s emotes: %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), msg.c_str());
                    break;

                case CHAT_MSG_YELL:
                    TC_LOG_INFO("chat.log.yell", "%04d-%02d-%02d %02d:%02d:%02d Player %s yells (language %u): %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), lang, msg.c_str());
                    break;
            }
        }

        void OnChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* receiver) override
        {
            time_t tt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

            std::tm aTm;
            localtime_r(&tt, &aTm);

            if (lang != LANG_ADDON)
                TC_LOG_INFO("chat.log.whisper", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells %s: %s",
                    aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), receiver ? receiver->GetName().c_str() : "<unknown>", msg.c_str());
            else
                TC_LOG_INFO("chat.log.addon.whisper", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells %s: %s",
                    aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), receiver ? receiver->GetName().c_str() : "<unknown>", msg.c_str());
        }

        void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
        {
            time_t tt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

            std::tm aTm;
            localtime_r(&tt, &aTm);
            //! NOTE:
            //! LANG_ADDON can only be sent by client in "PARTY", "RAID", "GUILD", "BATTLEGROUND", "WHISPER"
            switch (type)
            {
                case CHAT_MSG_PARTY:
                    if (lang != LANG_ADDON)
                        TC_LOG_INFO("chat.log.party", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells group with leader %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                    else
                        TC_LOG_INFO("chat.log.addon.party", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells group with leader %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                    break;

                case CHAT_MSG_PARTY_LEADER:
                    TC_LOG_INFO("chat.log.party", "%04d-%02d-%02d %02d:%02d:%02d Leader %s tells group: %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), msg.c_str());
                    break;

                case CHAT_MSG_RAID:
                    if (lang != LANG_ADDON)
                        TC_LOG_INFO("chat.log.raid", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells raid with leader %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                    else
                        TC_LOG_INFO("chat.log.addon.raid", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells raid with leader %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                    break;

                case CHAT_MSG_RAID_LEADER:
                    TC_LOG_INFO("chat.log.raid", "%04d-%02d-%02d %02d:%02d:%02d Leader player %s tells raid: %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), msg.c_str());
                    break;

                case CHAT_MSG_RAID_WARNING:
                    TC_LOG_INFO("chat.log.raid", "%04d-%02d-%02d %02d:%02d:%02d Leader player %s warns raid with: %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), msg.c_str());
                    break;

                case CHAT_MSG_BATTLEGROUND:
                    if (lang != LANG_ADDON)
                        TC_LOG_INFO("chat.log.bg", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells battleground with leader %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                    else
                        TC_LOG_INFO("chat.log.addon.bg", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells battleground with leader %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), group ? group->GetLeaderName() : "<unknown>", msg.c_str());
                    break;

                case CHAT_MSG_BATTLEGROUND_LEADER:
                    TC_LOG_INFO("chat.log.bg", "%04d-%02d-%02d %02d:%02d:%02d Leader player %s tells battleground: %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), msg.c_str());
                    break;
            }
        }

        void OnChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
        {
            time_t tt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

            std::tm aTm;
            localtime_r(&tt, &aTm);

            switch (type)
            {
                case CHAT_MSG_GUILD:
                    if (lang != LANG_ADDON)
                        TC_LOG_INFO("chat.log.guild", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells guild %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
                    else
                        TC_LOG_INFO("chat.log.addon.guild", "%04d-%02d-%02d %02d:%02d:%02d Player %s sends to guild %s: %s",
                            aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
                    break;

                case CHAT_MSG_OFFICER:
                    TC_LOG_INFO("chat.log.guild.officer", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells guild %s officers: %s",
                        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), guild ? guild->GetName().c_str() : "<unknown>", msg.c_str());
                    break;
            }
        }

        void OnChat(Player* player, uint32 /*type*/, uint32 /*lang*/, std::string& msg, Channel* channel) override
        {
            time_t tt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

            std::tm aTm;
            localtime_r(&tt, &aTm);

            bool isSystem = channel &&
                            (channel->HasFlag(CHANNEL_FLAG_TRADE) ||
                             channel->HasFlag(CHANNEL_FLAG_GENERAL) ||
                             channel->HasFlag(CHANNEL_FLAG_CITY) ||
                             channel->HasFlag(CHANNEL_FLAG_LFG));

            if (isSystem)
                TC_LOG_INFO("chat.log.system", "%04d-%02d-%02d %02d:%02d:%02d Player %s tells channel %s: %s",
                    aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), channel->GetName().c_str(), msg.c_str());
            else
            {
                std::string channelName = channel ? channel->GetName() : "<unknown>";
                TC_LOG_INFO("chat.log.channel." + channelName, "%04d-%02d-%02d %02d:%02d:%02d Player %s tells channel %s: %s",
                    aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec, player->GetName().c_str(), channelName.c_str(), msg.c_str());
            }
        }
};

void AddSC_chat_log()
{
    new ChatLogScript();
}
