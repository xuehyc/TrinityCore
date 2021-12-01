/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef BattlenetAccountMgr_h__
#define BattlenetAccountMgr_h__

#include "Define.h"
#include <string>

enum class AccountOpResult : uint8;

#define MAX_BNET_EMAIL_STR 320

namespace Battlenet
{
    namespace AccountMgr
    {
        GAME_API AccountOpResult CreateBattlenetAccount(std::string email, std::string password, bool withGameAccount, std::string* gameAccountName);
        GAME_API AccountOpResult ChangePassword(uint32 accountId, std::string newPassword);
        GAME_API bool CheckPassword(uint32 accountId, std::string password);
        GAME_API AccountOpResult LinkWithGameAccount(std::string const& email, std::string const& gameAccountName);
        GAME_API AccountOpResult UnlinkGameAccount(std::string const& gameAccountName);

        GAME_API uint32 GetId(std::string const& username);
        GAME_API bool GetName(uint32 accountId, std::string& name);
        GAME_API uint32 GetIdByGameAccount(uint32 gameAccountId);
        GAME_API uint8 GetMaxIndex(uint32 accountId);

        GAME_API std::string CalculateShaPassHash(std::string const& name, std::string const& password);
    }
}

#endif // BattlenetAccountMgr_h__
