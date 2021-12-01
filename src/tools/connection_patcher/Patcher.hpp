/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CONNECTION_PATCHER_PATCHER_HPP
#define CONNECTION_PATCHER_PATCHER_HPP

#include "Helper.hpp"

#include <fstream>
#include <iostream>
#include <iterator>

namespace Connection_Patcher
{
    class Patcher
    {
    public:
        Patcher(boost::filesystem::path file);

        void Patch(std::vector<unsigned char> const& bytes, std::vector<unsigned char> const& pattern);
        void Finish(boost::filesystem::path out);
        Constants::BinaryTypes GetType() const { return binaryType; }
        std::vector<unsigned char> const& GetBinary() const { return binary; }

    private:
        void ReadFile();
        void WriteFile(boost::filesystem::path const& path);

        boost::filesystem::path filePath;
        std::vector<unsigned char> binary;
        Constants::BinaryTypes binaryType;


    };
}

#endif
