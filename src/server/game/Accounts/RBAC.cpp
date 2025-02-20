﻿//小女孩注释 2022年3月17日07:40:43 权限管理 rbac全称:Role Based Access Control 基于角色的访问控制 (来源:AC-Web群 【小兵(群等级)】恶来 。(6956329)  上午 08:09:00解答)
/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
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

#include "RBAC.h"
#include "AccountMgr.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include <sstream>

namespace rbac
{

std::string GetDebugPermissionString(RBACPermissionContainer const& perms)
{
    std::string str = "";
    if (!perms.empty())
    {
        std::ostringstream o;
        RBACPermissionContainer::const_iterator itr = perms.begin();
        o << (*itr);
        for (++itr; itr != perms.end(); ++itr)
            o << ", " << uint32(*itr);
        str = o.str();
    }

    return str;
}

RBACCommandResult RBACData::GrantPermission(uint32 permissionId, int32 realmId /* = 0*/)
{
    // Check if permission Id exists
    //检查权限ID是否存在
    RBACPermission const* perm = sAccountMgr->GetRBACPermission(permissionId);
    if (!perm)
    {
        TC_LOG_TRACE("rbac", "RBACData::GrantPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Permission does not exists",
                       GetId(), GetName(), permissionId, realmId);
        return RBAC_ID_DOES_NOT_EXISTS;
    }

    // Check if already added in denied list
    // 检查是否已在禁止列表
    if (HasDeniedPermission(permissionId))
    {
        TC_LOG_TRACE("rbac", "RBACData::GrantPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Permission in deny list",
                       GetId(), GetName(), permissionId, realmId);
        return RBAC_IN_DENIED_LIST;
    }

    // Already added?
    // 已添加?
    if (HasGrantedPermission(permissionId))
    {
        TC_LOG_TRACE("rbac", "RBACData::GrantPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Permission already granted",
                       GetId(), GetName(), permissionId, realmId);
        return RBAC_CANT_ADD_ALREADY_ADDED;
    }

    AddGrantedPermission(permissionId);

    // Do not save to db when loading data from DB (realmId = 0)
    // 当从数据库中加载时,不要保存到数据库(realmId = 0).
    if (realmId)
    {
        TC_LOG_TRACE("rbac", "RBACData::GrantPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Ok and DB updated",
                       GetId(), GetName(), permissionId, realmId);
        SavePermission(permissionId, true, realmId);
        CalculateNewPermissions();
    }
    else
        TC_LOG_TRACE("rbac", "RBACData::GrantPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Ok",
                       GetId(), GetName(), permissionId, realmId);

    return RBAC_OK;
}

// RBAC命令结果
RBACCommandResult RBACData::DenyPermission(uint32 permissionId, int32 realmId /* = 0*/)
{
    // Check if permission Id exists
    // 检查权限ID是否存在
    RBACPermission const* perm = sAccountMgr->GetRBACPermission(permissionId);
    if (!perm)
    {
        TC_LOG_TRACE("rbac", "RBACData::DenyPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Permission does not exists",
                       GetId(), GetName(), permissionId, realmId);
        return RBAC_ID_DOES_NOT_EXISTS;
    }

    // Check if already added in granted list
    // 检查是否已添加到准许列表
    if (HasGrantedPermission(permissionId))
    {
        TC_LOG_TRACE("rbac", "RBACData::DenyPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Permission in grant list",
                       GetId(), GetName(), permissionId, realmId);
        return RBAC_IN_GRANTED_LIST;
    }

    // Already added?
    // 已添加?
    if (HasDeniedPermission(permissionId))
    {
        TC_LOG_TRACE("rbac", "RBACData::DenyPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Permission already denied",
                       GetId(), GetName(), permissionId, realmId);
        return RBAC_CANT_ADD_ALREADY_ADDED;
    }

    AddDeniedPermission(permissionId);

    // Do not save to db when loading data from DB (realmId = 0)
    // 当从数据库中加载时,不要保存到数据库(realmId = 0).
    if (realmId)
    {
        TC_LOG_TRACE("rbac", "RBACData::DenyPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Ok and DB updated",
                       GetId(), GetName(), permissionId, realmId);
        SavePermission(permissionId, false, realmId);
        CalculateNewPermissions();
    }
    else
        TC_LOG_TRACE("rbac", "RBACData::DenyPermission [Id: {} Name: {}] (Permission {}, RealmId {}). Ok",
                       GetId(), GetName(), permissionId, realmId);

    return RBAC_OK;
}

void RBACData::SavePermission(uint32 permission, bool granted, int32 realmId)
{
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_RBAC_ACCOUNT_PERMISSION);
    //获取已准备的语句(登录_插入_RBAC_账号_权限)
    stmt->setUInt32(0, GetId());
    stmt->setUInt32(1, permission);
    stmt->setBool(2, granted);
    stmt->setInt32(3, realmId);
    LoginDatabase.Execute(stmt);
}

RBACCommandResult RBACData::RevokePermission(uint32 permissionId, int32 realmId /* = 0*/)
{
    // Check if it's present in any list
    // 检查是否已在任何列表中
    if (!HasGrantedPermission(permissionId) && !HasDeniedPermission(permissionId))
    {
        TC_LOG_TRACE("rbac", "RBACData::RevokePermission [Id: {} Name: {}] (Permission {}, RealmId {}). Not granted or revoked",
                       GetId(), GetName(), permissionId, realmId);
        return RBAC_CANT_REVOKE_NOT_IN_LIST;
    }

    RemoveGrantedPermission(permissionId);
    RemoveDeniedPermission(permissionId);

    // Do not save to db when loading data from DB (realmId = 0)
    // 当从数据库中加载时,不要保存到数据库(realmId = 0).
    if (realmId)
    {
        TC_LOG_TRACE("rbac", "RBACData::RevokePermission [Id: {} Name: {}] (Permission {}, RealmId {}). Ok and DB updated",
                       GetId(), GetName(), permissionId, realmId);
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_RBAC_ACCOUNT_PERMISSION);
        stmt->setUInt32(0, GetId());
        stmt->setUInt32(1, permissionId);
        stmt->setInt32(2, realmId);
        LoginDatabase.Execute(stmt);

        CalculateNewPermissions();
    }
    else
        TC_LOG_TRACE("rbac", "RBACData::RevokePermission [Id: {} Name: {}] (Permission {}, RealmId {}). Ok",
                       GetId(), GetName(), permissionId, realmId);

    return RBAC_OK;
}

void RBACData::LoadFromDB()
{
    ClearData();

    TC_LOG_DEBUG("rbac", "RBACData::LoadFromDB [Id: {} Name: {}]: Loading permissions", GetId(), GetName());
    // Load account permissions (granted and denied) that affect current realm
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_RBAC_ACCOUNT_PERMISSIONS);
    stmt->setUInt32(0, GetId());
    stmt->setInt32(1, GetRealmId());

    LoadFromDBCallback(LoginDatabase.Query(stmt));
}

QueryCallback RBACData::LoadFromDBAsync()
{
    ClearData();

    TC_LOG_DEBUG("rbac", "RBACData::LoadFromDB [Id: {} Name: {}]: Loading permissions", GetId(), GetName());
    // Load account permissions (granted and denied) that affect current realm
    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_RBAC_ACCOUNT_PERMISSIONS);
    stmt->setUInt32(0, GetId());
    stmt->setInt32(1, GetRealmId());

    return LoginDatabase.AsyncQuery(stmt);
}

void RBACData::LoadFromDBCallback(PreparedQueryResult result)
{
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            if (fields[1].GetBool())
                GrantPermission(fields[0].GetUInt32());
            else
                DenyPermission(fields[0].GetUInt32());
        } while (result->NextRow());
    }

    // Add default permissions
    // 增加默认权限
    RBACPermissionContainer const& permissions = sAccountMgr->GetRBACDefaultPermissions(_secLevel);
    for (uint32 permission : permissions)
        GrantPermission(permission);

    // Force calculation of permissions
    // 强制计算权限
    CalculateNewPermissions();
}

void RBACData::CalculateNewPermissions()
{
    TC_LOG_TRACE("rbac", "RBACData::CalculateNewPermissions [Id: {} Name: {}]", GetId(), GetName());

    // Get the list of granted permissions
    // 获取准许权限列表
    _globalPerms = GetGrantedPermissions();
    ExpandPermissions(_globalPerms);
    RBACPermissionContainer revoked = GetDeniedPermissions();
    ExpandPermissions(revoked);
    RemovePermissions(_globalPerms, revoked);
}

void RBACData::AddPermissions(RBACPermissionContainer const& permsFrom, RBACPermissionContainer& permsTo)
{
    for (uint32 permission : permsFrom)
        permsTo.insert(permission);
}

void RBACData::RemovePermissions(RBACPermissionContainer& permsFrom, RBACPermissionContainer const& permsToRemove)
{
    for (uint32 permission: permsToRemove)
        permsFrom.erase(permission);
}

void RBACData::ExpandPermissions(RBACPermissionContainer& permissions)
{
    RBACPermissionContainer toCheck = permissions;
    permissions.clear();

    while (!toCheck.empty())
    {
        // remove the permission from original list
        uint32 permissionId = *toCheck.begin();
        toCheck.erase(toCheck.begin());

        RBACPermission const* permission = sAccountMgr->GetRBACPermission(permissionId);
        if (!permission)
            continue;

        // insert into the final list (expanded list)
        permissions.insert(permissionId);

        // add all linked permissions (that are not already expanded) to the list of permissions to be checked
        RBACPermissionContainer const& linkedPerms = permission->GetLinkedPermissions();
        for (uint32 linkedPerm : linkedPerms)
            if (permissions.find(linkedPerm) == permissions.end())
                toCheck.insert(linkedPerm);
    }

    TC_LOG_DEBUG("rbac", "RBACData::ExpandPermissions: Expanded: {}", GetDebugPermissionString(permissions));
    //日志输出:扩展权限
}

void RBACData::ClearData()
{
    _grantedPerms.clear();
    _deniedPerms.clear();
    _globalPerms.clear();
}

}
