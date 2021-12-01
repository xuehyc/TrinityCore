/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CONNECTION_PATCHER_PATTERNS_COMMON_HPP
#define CONNECTION_PATCHER_PATTERNS_COMMON_HPP

#include <vector>

namespace Connection_Patcher
{
    namespace Patterns
    {
        struct Common
        {
            static std::vector<unsigned char> Portal() { return { '.', 'a', 'c', 't', 'u', 'a' , 'l', '.', 'b', 'a', 't', 't', 'l', 'e', '.', 'n', 'e', 't', 0x00 }; }
            static std::vector<unsigned char> Modulus() { return { 0x91, 0xD5, 0x9B, 0xB7, 0xD4, 0xE1, 0x83, 0xA5 }; }
            static std::vector<unsigned char> BinaryVersion() { return { 0x3C, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x3E }; }
            static std::vector<unsigned char> VersionsFile() { return { '%', 's', '.', 'p', 'a', 't', 'c', 'h', '.', 'b', 'a', 't', 't', 'l', 'e', '.', 'n', 'e', 't', ':', '1', '1', '1', '9', '/', '%', 's', '/', 'v', 'e', 'r', 's', 'i', 'o', 'n', 's' }; }
            static std::vector<unsigned char> CertBundleUrl() { return { 'h', 't', 't', 'p', ':', '/', '/', 'n', 'y', 'd', 'u', 's', '-', 'q', 'a', '.', 'w', 'e', 'b', '.', 'b', 'l', 'i', 'z', 'z', 'a', 'r', 'd', '.', 'n', 'e', 't', '/', 'B', 'n', 'e', 't', '/', 'z', 'x', 'x', '/', 'c', 'l', 'i', 'e', 'n', 't', '/', 'b', 'g', 's', '-', 'k', 'e', 'y', '-', 'f', 'i', 'n', 'g', 'e', 'r', 'p', 'r', 'i', 'n', 't' }; }
            static std::vector<unsigned char> CertSignatureModulus() { return { 0x85, 0xF3, 0x7B, 0x14, 0x5A, 0x9C, 0x48, 0xF6 }; }
        };
    }
}

#endif
