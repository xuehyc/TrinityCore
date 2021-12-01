/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef __GITREVISION_H__
#define __GITREVISION_H__

#include "Define.h"

namespace GitRevision
{
    COMMON_API char const* GetHash();
    COMMON_API char const* GetDate();
    COMMON_API char const* GetBranch();
    COMMON_API char const* GetCMakeCommand();
    COMMON_API char const* GetCMakeVersion();
    COMMON_API char const* GetHostOSVersion();
    COMMON_API char const* GetBuildDirectory();
    COMMON_API char const* GetSourceDirectory();
    COMMON_API char const* GetMySQLExecutable();
    COMMON_API char const* GetFullDatabase();
    COMMON_API char const* GetHotfixesDatabase();
    COMMON_API char const* GetFullVersion();
    COMMON_API char const* GetCompanyNameStr();
    COMMON_API char const* GetLegalCopyrightStr();
    COMMON_API char const* GetFileVersionStr();
    COMMON_API char const* GetProductVersionStr();
}

#endif
