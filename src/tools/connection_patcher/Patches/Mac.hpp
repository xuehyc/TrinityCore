/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CONNECTION_PATCHER_PATCHES_MAC_HPP
#define CONNECTION_PATCHER_PATCHES_MAC_HPP

#include <vector>

namespace Connection_Patcher
{
    namespace Patches
    {
        struct Mac
        {
            static std::vector<unsigned char> LauncherLoginParametersLocation()
            {
                char const path[] = "org.trnity"; // not a typo, length must match original
                return std::vector<unsigned char>(std::begin(path), std::end(path));
            }
        };
    }
}

#endif
