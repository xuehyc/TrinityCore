/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "GitRevision.h"
#include "revision_data.h"

char const* GitRevision::GetHash()
{
    return _HASH;
}

char const* GitRevision::GetDate()
{
    return _DATE;
}

char const* GitRevision::GetBranch()
{
    return _BRANCH;
}

char const* GitRevision::GetCMakeCommand()
{
    return _CMAKE_COMMAND;
}

char const* GitRevision::GetCMakeVersion()
{
    return _CMAKE_VERSION;
}

char const* GitRevision::GetHostOSVersion()
{
    return _CMAKE_HOST_SYSTEM;
}

char const* GitRevision::GetBuildDirectory()
{
    return _BUILD_DIRECTORY;
}

char const* GitRevision::GetSourceDirectory()
{
    return _SOURCE_DIRECTORY;
}

char const* GitRevision::GetMySQLExecutable()
{
    return _MYSQL_EXECUTABLE;
}

char const* GitRevision::GetFullDatabase()
{
    return _FULL_DATABASE;
}

char const* GitRevision::GetHotfixesDatabase()
{
    return _HOTFIXES_DATABASE;
}

#if SERVER_PLATFORM == SERVER_PLATFORM_WINDOWS
#  ifdef _WIN64
#    define SERVER_PLATFORM_STR "Win64"
#  else
#    define SERVER_PLATFORM_STR "Win32"
#  endif
#elif SERVER_PLATFORM == SERVER_PLATFORM_APPLE
#  define SERVER_PLATFORM_STR "MacOSX"
#elif SERVER_PLATFORM == SERVER_PLATFORM_INTEL
#  define SERVER_PLATFORM_STR "Intel"
#else // SERVER_PLATFORM_UNIX
#  define SERVER_PLATFORM_STR "Unix"
#endif

#ifndef SERVER_API_USE_DYNAMIC_LINKING
#  define SERVER_LINKAGE_TYPE_STR "Static"
#else
#  define SERVER_LINKAGE_TYPE_STR "Dynamic"
#endif

char const* GitRevision::GetFullVersion()
{
  return VER_PRODUCTVERSION_STR " (" SERVER_PLATFORM_STR ", " _BUILD_DIRECTIVE ", " SERVER_LINKAGE_TYPE_STR ")";
}

char const* GitRevision::GetCompanyNameStr()
{
    return VER_COMPANYNAME_STR;
}

char const* GitRevision::GetLegalCopyrightStr()
{
    return VER_LEGALCOPYRIGHT_STR;
}

char const* GitRevision::GetFileVersionStr()
{
    return VER_FILEVERSION_STR;
}

char const* GitRevision::GetProductVersionStr()
{
    return VER_PRODUCTVERSION_STR;
}
