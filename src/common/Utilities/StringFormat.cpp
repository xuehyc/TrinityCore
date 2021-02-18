/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "StringFormat.h"
#include <Poco/String.h>

std::string Warhead::String::Trim(std::string& str)
{
    return Poco::trim(str);
}

// Taken from https://stackoverflow.com/a/1798170
std::string Warhead::String::Trim(std::string const& str, std::string_view whitespace /*= " \t"*/)
{
    const auto strBegin = str.find_first_not_of(whitespace);
    if (strBegin == std::string::npos)
        return ""; // no content

    auto const strEnd = str.find_last_not_of(whitespace);
    auto const strRange = strEnd - strBegin + 1;

    return str.substr(strBegin, strRange);
}

std::string Warhead::String::TrimLeft(std::string& str)
{
    return Poco::trimLeft(str);
}

std::string Warhead::String::TrimLeftInPlace(std::string& str)
{
    return Poco::trimLeftInPlace(str);
}

std::string Warhead::String::TrimRight(std::string& str)
{
    return Poco::trimRight(str);
}

std::string Warhead::String::TrimRightInPlace(std::string& str)
{
    return Poco::trimRightInPlace(str);
}

std::string Warhead::String::Reduce(std::string const& str, std::string_view fill /*= " "*/, std::string_view whitespace /*= " \t"*/)
{
    // trim first
    auto result = Trim(str, whitespace);

    // replace sub ranges
    auto beginSpace = result.find_first_of(whitespace);
    while (beginSpace != std::string::npos)
    {
        const auto endSpace = result.find_first_not_of(whitespace, beginSpace);
        const auto range = endSpace - beginSpace;

        result.replace(beginSpace, range, fill);

        const auto newStart = beginSpace + fill.length();
        beginSpace = result.find_first_of(whitespace, newStart);
    }

    return result;
}

std::string Warhead::String::Replace(std::string& str, std::string const& from, std::string const& to)
{
    return Poco::replace(str, from, to);
}

std::string Warhead::String::ReplaceInPlace(std::string& str, std::string const& from, std::string const& to)
{
    return Poco::replaceInPlace(str, from, to);
}
