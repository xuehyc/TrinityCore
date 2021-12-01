/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef __GAMETIME_H
#define __GAMETIME_H

#include "Define.h"

#include <chrono>

namespace GameTime
{
    // Server start time
    GAME_API time_t GetStartTime();

    // Current server time (unix) in seconds
    GAME_API time_t GetGameTime();

    // Milliseconds since server start
    GAME_API uint32 GetGameTimeMS();

    /// Current chrono system_clock time point
    GAME_API std::chrono::system_clock::time_point GetGameTimeSystemPoint();

    /// Current chrono steady_clock time point
    GAME_API std::chrono::steady_clock::time_point GetGameTimeSteadyPoint();

    /// Uptime (in secs)
    GAME_API uint32 GetUptime();

    GAME_API tm const* GetDateAndTime();

    void UpdateGameTimers();
}

#endif
