/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CONNECTION_PATCHER_PATTERNS_WINDOWS_HPP
#define CONNECTION_PATCHER_PATTERNS_WINDOWS_HPP

#include <vector>

namespace Connection_Patcher
{
    namespace Patterns
    {
        struct Windows
        {
            static std::vector<unsigned char> LauncherLoginParametersLocation()
            {
                char const path[] = R"(Software\Blizzard Entertainment\Battle.net\Launch Options\)";
                return std::vector<unsigned char>(std::begin(path), std::end(path));
            }
        };
    }
}

#endif
