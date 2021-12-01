/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "Patcher.hpp"

namespace Connection_Patcher
{
    Patcher::Patcher(boost::filesystem::path file)
        : filePath(file)
    {
        ReadFile();
        binaryType = Helper::GetBinaryType(binary);
    }

    void Patcher::ReadFile()
    {
        std::ifstream ifs(filePath.string(), std::ifstream::binary);
        if (!ifs)
            throw std::runtime_error("could not open " + filePath.string());

        binary.clear();
        ifs >> std::noskipws;
        ifs.seekg(0, std::ios_base::end);
        binary.reserve(ifs.tellg());
        ifs.seekg(0, std::ios_base::beg);

        std::copy(std::istream_iterator<unsigned char>(ifs), std::istream_iterator<unsigned char>(), std::back_inserter(binary));
    }

    void Patcher::WriteFile(boost::filesystem::path const& path)
    {
        std::ofstream ofs(path.string(), std::ofstream::binary);
        if (!ofs)
            throw std::runtime_error("could not open " + path.string());

        ofs << std::noskipws;

        std::copy(binary.begin(), binary.end(), std::ostream_iterator<unsigned char>(ofs));
    }

    void Patcher::Patch(std::vector<unsigned char> const& bytes, std::vector<unsigned char> const& pattern)
    {
        if (binary.size() < pattern.size())
            throw std::logic_error("pattern larger than binary");

        if (pattern.empty())
            return;

        for (size_t const offset : Helper::SearchOffset(binary, pattern))
        {
            std::cout << "Found offset " << offset << std::endl;

            if (offset != 0 && binary.size() >= bytes.size())
                for (size_t i = 0; i < bytes.size(); i++)
                    binary[offset + i] = bytes[i];
        }
    }

    void Patcher::Finish(boost::filesystem::path out)
    {
        if (boost::filesystem::exists(out))
            boost::filesystem::remove(out);

        WriteFile(out);
    }
}
