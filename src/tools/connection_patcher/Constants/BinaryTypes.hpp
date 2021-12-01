/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CONNECTION_PATCHER_CONSTANTS_BINARYTYPES_HPP
#define CONNECTION_PATCHER_CONSTANTS_BINARYTYPES_HPP

#include <cstdint>

namespace Connection_Patcher
{
    namespace Constants
    {
        enum class BinaryTypes : uint32_t
        {
            Pe32   = 0x0000014C,
            Pe64   = 0x00008664,
            Mach64 = 0xFEEDFACF
        };
    }
}

#endif
