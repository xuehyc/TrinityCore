/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef BUILT_IN_CONFIG_H
#define BUILT_IN_CONFIG_H

#include "Define.h"
#include <string>

/// Provides helper functions to access built-in values
/// which can be overwritten in config
namespace BuiltInConfig
{
    /// Returns the CMake command when any is specified in the config,
    /// returns the built-in path otherwise
    COMMON_API std::string GetCMakeCommand();
    /// Returns the build directory path when any is specified in the config,
    /// returns the built-in one otherwise
    COMMON_API std::string GetBuildDirectory();
    /// Returns the source directory path when any is specified in the config,
    /// returns the built-in one otherwise
    COMMON_API std::string GetSourceDirectory();
    /// Returns the path to the mysql executable (`mysql`) when any is specified
    /// in the config, returns the built-in one otherwise
    COMMON_API std::string GetMySQLExecutable();

} // namespace BuiltInConfig

#endif // BUILT_IN_CONFIG_H
