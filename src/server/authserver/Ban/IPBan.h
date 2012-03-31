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
 *  @brief   Class IPBan.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#ifndef __IP_BAN_H__
#define __IP_BAN_H__

#include <string>
#include <ctime>

#include "Database/DatabaseEnv.h"

/**
 *  @brief  This class represents an IP ban with the concrete address.
 */

class IPBan
{
public:
    IPBan() : _ip(), _banDate(0), _unbanDate(0), _permanent(false) {}

    void SetIP(std::string const IPAddress) { _ip = IPAddress; }
    void SetBanDate(time_t const banDate) { _banDate = banDate; }
    void SetUnbanDate(time_t const unbanDate)
    {
        _unbanDate = unbanDate;
        if (_banDate == _unbanDate)
            _permanent = true;
    }

    std::string const& GetIP() const { return _ip; }

    /**
     *  @brief   Tells the ban is active or not.
     */
    bool IsActive() const { return _permanent ? true : time(NULL) < _unbanDate; }

    /**
     *  @brief  Deletes the IP ban from the DataBase.
     */
    void DeleteFromDB() const
    {
        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_IP_NOT_BANNED);
        stmt->setString(0, _ip);
        LoginDatabase.Execute(stmt);
    }

private:
    /**
     *  @brief  The banned IP address.
     */
    std::string  _ip;

    /**
     *  @brief  The time when get the ban, in UNIX timestamp format.
     */
    time_t _banDate;

    /**
     *  @brief  The time when the ban should be expired (only temporary ban),
                in UNIX timestamp format.@n
                Permanent ban has the same _unbanDate and _banDate values.
     */
    time_t _unbanDate;

    /**
     *  @brief  This var tells the ban is permanent (true) or not.
     */
    bool _permanent;
};

#endif /* __IP_BAN_H__ */
