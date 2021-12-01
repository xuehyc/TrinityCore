/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CONNECTION_PATCHER_PATTERNS_MAC_HPP
#define CONNECTION_PATCHER_PATTERNS_MAC_HPP

#include <vector>

namespace Connection_Patcher
{
    namespace Patterns
    {
        struct Mac
        {
            static std::vector<unsigned char> LauncherLoginParametersLocation() { return { 'n','e','t','.','b','a','t','t','l','e',0 }; }
        };
    }
}

#endif
