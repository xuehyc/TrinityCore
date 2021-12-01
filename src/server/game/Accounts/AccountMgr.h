/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _ACCMGR_H
#define _ACCMGR_H

#include "RBAC.h"

enum class AccountOpResult : uint8
{
    AOR_OK,
    AOR_NAME_TOO_LONG,
    AOR_PASS_TOO_LONG,
    AOR_EMAIL_TOO_LONG,
    AOR_NAME_ALREADY_EXIST,
    AOR_NAME_NOT_EXIST,
    AOR_DB_INTERNAL_ERROR,
    AOR_ACCOUNT_BAD_LINK
};

enum PasswordChangeSecurity
{
    PW_NONE,
    PW_EMAIL,
    PW_RBAC
};

#define MAX_PASS_STR 16
#define MAX_ACCOUNT_STR 16
#define MAX_EMAIL_STR 64

namespace rbac
{
typedef std::map<uint32, rbac::RBACPermission*> RBACPermissionsContainer;
typedef std::map<uint8, rbac::RBACPermissionContainer> RBACDefaultPermissionsContainer;
}

class GAME_API AccountMgr
{
    private:
        AccountMgr();
        ~AccountMgr();

    public:
        static AccountMgr* instance();

        AccountOpResult CreateAccount(std::string username, std::string password, std::string email = "", uint32 bnetAccountId = 0, uint8 bnetIndex = 0);
        static AccountOpResult DeleteAccount(uint32 accountId);
        static AccountOpResult ChangeUsername(uint32 accountId, std::string newUsername, std::string newPassword);
        static AccountOpResult ChangePassword(uint32 accountId, std::string newPassword);
        static AccountOpResult ChangeEmail(uint32 accountId, std::string newEmail);
        static AccountOpResult ChangeRegEmail(uint32 accountId, std::string newEmail);
        static bool CheckPassword(uint32 accountId, std::string password);
        static bool CheckEmail(uint32 accountId, std::string newEmail);

        static uint32 GetId(std::string const& username);
        static uint32 GetSecurity(uint32 accountId);
        static uint32 GetSecurity(uint32 accountId, int32 realmId);
        static bool GetName(uint32 accountId, std::string& name);
        static bool GetEmail(uint32 accountId, std::string& email);
        static uint32 GetCharactersCount(uint32 accountId);

        static std::string CalculateShaPassHash(std::string const& name, std::string const& password);
        static bool IsBannedAccount(std::string const& name);
        static bool IsPlayerAccount(uint32 gmlevel);
        static bool IsAdminAccount(uint32 gmlevel);
        static bool IsConsoleAccount(uint32 gmlevel);
        static bool HasPermission(uint32 accountId, uint32 permission, uint32 realmId);

        void UpdateAccountAccess(rbac::RBACData* rbac, uint32 accountId, uint8 securityLevel, int32 realmId);

        void LoadRBAC();
        rbac::RBACPermission const* GetRBACPermission(uint32 permission) const;

        rbac::RBACPermissionsContainer const& GetRBACPermissionList() const { return _permissions; }
        rbac::RBACPermissionContainer const& GetRBACDefaultPermissions(uint8 secLevel);

    private:
        void ClearRBAC();
        rbac::RBACPermissionsContainer _permissions;
        rbac::RBACDefaultPermissionsContainer _defaultPermissions;
};

#define sAccountMgr AccountMgr::instance()
#endif
