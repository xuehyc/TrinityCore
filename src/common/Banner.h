/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef MobiusCore_Banner_h__
#define MobiusCore_Banner_h__

#include "Define.h"

namespace Server
{
    namespace Banner
    {
        COMMON_API void Show(char const* applicationName, void(*log)(char const* text), void(*logExtraInfo)());
    }
}

#endif // MobiusCore_Banner_h__
