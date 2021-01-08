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

#ifndef _BAN_MANAGER_H_
#define _BAN_MANAGER_H_

#include "Common.h"
#include "Optional.h"
#include <tuple>

/// Ban function return codes
enum BanReturn
{
    BAN_SUCCESS,
    BAN_SYNTAX_ERROR,
    BAN_NOTFOUND,
    BAN_EXISTS
};

/// Ban function modes
enum BanMode
{
    BAN_ACCOUNT,
    BAN_CHARACTER,
    BAN_IP
};

class WH_GAME_API BanManager
{
public:
    static BanManager* instance();

    BanReturn BanAccount(std::string const& accountName, std::string_view duration, std::string const& reason, std::string const& author);
    BanReturn BanAccountByPlayerName(std::string const& characterName, std::string_view duration, std::string const& reason, std::string const& author);
    BanReturn BanIP(std::string const& IP, std::string_view duration, std::string const& reason, std::string const& author);
    BanReturn BanCharacter(std::string const& characterName, std::string_view duration, std::string const& reason, std::string const& author);

    bool RemoveBanAccount(std::string const& accountName);
    bool RemoveBanAccountByPlayerName(std::string const& characterName);
    bool RemoveBanIP(std::string const& IP);
    bool RemoveBanCharacter(std::string const& characterName);

    Optional<std::tuple<uint32, uint32, std::string, std::string>> GetBanInfoIP(std::string_view characterName);
    Optional<std::tuple<uint32, uint32, std::string, std::string>> GetBanInfoAccount(std::string_view characterName);
    Optional<std::tuple<uint32, uint32, std::string, std::string>> GetBanInfoCharacter(std::string_view characterName);
};

#define sBan BanManager::instance()

#endif // _BAN_MANAGER_H_
