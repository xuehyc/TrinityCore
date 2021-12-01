/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/// \addtogroup world
/// @{
/// \file

#ifndef __WEATHERMGR_H
#define __WEATHERMGR_H

#include "Define.h"

class Weather;
class Player;
struct WeatherData;

namespace WeatherMgr
{
    GAME_API void LoadWeatherData();
    GAME_API WeatherData const* GetWeatherData(uint32 zone_id);
}

#endif
