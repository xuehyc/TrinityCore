/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef __SERVER_CHANNELMGR_H
#define __SERVER_CHANNELMGR_H

#include "Define.h"
#include "Hash.h"
#include <string>
#include <unordered_map>

class Channel;
class Player;
struct AreaTableEntry;

class GAME_API ChannelMgr
{
    typedef std::unordered_map<std::wstring, Channel*> CustomChannelContainer; // custom channels only differ in name
    typedef std::unordered_map<std::pair<uint32 /*channelId*/, uint32 /*zoneId*/>, Channel*> BuiltinChannelContainer; // identify builtin (DBC) channels by zoneId instead, since name changes by client locale

    protected:
        explicit ChannelMgr(uint32 team) : _team(team) { }
        ~ChannelMgr();

    public:
        static ChannelMgr* ForTeam(uint32 team);
        static Channel* GetChannelForPlayerByNamePart(std::string const& namePart, Player* playerSearcher);

        Channel* GetJoinChannel(uint32 channelId, std::string const& name, AreaTableEntry const* zoneEntry = nullptr);
        Channel* GetChannel(uint32 channelId, std::string const& name, Player* player, bool notify = true, AreaTableEntry const* zoneEntry = nullptr) const;
        void LeftChannel(std::string const& name);
        void LeftChannel(uint32 channelId, AreaTableEntry const* zoneEntry);

    private:
        CustomChannelContainer _customChannels;
        BuiltinChannelContainer _channels;
        uint32 const _team;

        static void SendNotOnChannelNotify(Player const* player, std::string const& name);
};

#endif
