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
 *  @brief   This file contains all the timers which related to bans.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#ifndef __BAN_TIMERS_H__
#define __BAN_TIMERS_H__

#include <ace/Event_Handler.h>

#include "LogTrace.h"
#include "BanManager.h"

/**
 *  @brief  This class is a timer which deletes the expired IP bans.
 */

class DeleteExpiredIPBansTimer : public ACE_Event_Handler
{
public:
    /**
     *  @brief  This function called when the timer expires.
     *  @see    BanManager::DeleteExpiredIpBans()
     */
    /* virtual */ int handle_timeout(ACE_Time_Value const& /* TV */,
                                     void const* /* ACT = NULL */)
    {
        LOG_TRACE("Timeout.");
        sBanManager->DeleteExpiredIpBans();
        return 0;
    }
};

#endif /* __BAN_TIMERS_H__ */
