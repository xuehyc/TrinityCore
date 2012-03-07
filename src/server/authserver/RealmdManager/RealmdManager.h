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
 *  @brief   Declaration of class RealmdManager.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#ifndef __REALMD_MANAGER_H__
#define __REALMD_MANAGER_H__

#include <ace/Singleton.h>
#include <ace/Null_Mutex.h>

/**
 *  @brief  Singleton which manages global realmd related things.
 */

class RealmdManager
{
public:
    /**
     *  @brief    Initialization of the class.
     *  @details  Set the start time.
     *  @see      _startTime
     */
    RealmdManager()
    {
        _startTime = time(NULL);
    }

    /**
     *  @brief    Tells how much uptime the daemon has.
     *  @details  Algorithm: nowInUnixTime - _startTime
     *  @see      _startTime
     */
    time_t GetUpTime() const { return time(NULL) - _startTime; }

    /**
     *  @brief  When the daemon started in UNIX timestamp.
     */
private:
    time_t _startTime;
};

/**
 *  @brief  Macro to access that class.
 */
#define sRealmdManager ACE_Singleton<RealmdManager, ACE_Null_Mutex>::instance()

#endif /* __REALMD_MANAGER_H__ */
