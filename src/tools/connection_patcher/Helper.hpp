/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CONNECTION_PATCHER_HELPER_HPP
#define CONNECTION_PATCHER_HELPER_HPP

#include "Constants/BinaryTypes.hpp"

#include <boost/filesystem.hpp>
#include <vector>
#include <set>

namespace Connection_Patcher
{
    namespace Helper
    {
        void CopyDir(boost::filesystem::path const & source, boost::filesystem::path const & destination);
        Constants::BinaryTypes GetBinaryType(std::vector<unsigned char> const& data);
        std::set<size_t> SearchOffset(std::vector<unsigned char> const& binary, std::vector<unsigned char> const& pattern);
        uint32_t GetBuildNumber(std::vector<unsigned char> const& binary);
    }
}

#endif
