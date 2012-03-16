/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

/**
 *  @file
 *  @brief   Declaration of BanManager singleton.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#ifndef __BAN_MANAGER_H__
#define __BAN_MANAGER_H__

#include <map>

#include <ace/Singleton.h>
#include <ace/Null_Mutex.h>

#include "IPBan.h"

/**
 *  @brief  This singleton handles all the bans.
 *  @todo   Lot of things...
 */

class BanManager
{
public:
    /**
     *  @brief  Resources deallocation.
     */
    ~BanManager();

    /**
     *  @brief  Loads all the bans.
     */
    void LoadBans();

    /**
     *  @brief  Loads ip bans only.
     */
    void LoadIPBans();

    /**
     *  @brief  Tells that the specific IP address is banned (active) or not.
     */
    bool IsIPBanned(std::string const& ipAddress)
    {
        IPBanMap_ConstItr itr = _ipBans.find(ipAddress);
        if (itr == _ipBans.end())
            return false;
        if (itr->second->IsActive())
            return true;
        return false;
    }

private:
    /**
     *  @brief  Counts only IP bans.
     */
    size_t GetIPBansCount() const { return _ipBans.size(); }

    /**
     *  @brief  Counts all the bans.
     */
    size_t GetBansCount() const { return GetIPBansCount(); }

    /**
     *  @brief  Just adds an IP ban.
     */
    void AddIPBan(IPBan const* ipBan) { _ipBans[ipBan->GetIP()] = ipBan; }

private:
    /**
     *  @brief  This type stores the banned IPs.
     */
    typedef std::map<std::string const /* ipAddress */, IPBan const* /* ptrToIPBan */> IPBanMap;
    /**
     *  @brief  Macro for IPBanMap::const_iterator
     *  @see    IPBanMap
     */
    typedef IPBanMap::const_iterator IPBanMap_ConstItr;

    /**
     *  @brief  This stores the IP bans.
     */
    IPBanMap _ipBans;
};

/**
 *  @brief  BanManager class should be accessed via this macro.
 */
#define sBanManager ACE_Singleton<BanManager, ACE_Null_Mutex>::instance()

#endif /* __BAN_MANAGER_H__ */
