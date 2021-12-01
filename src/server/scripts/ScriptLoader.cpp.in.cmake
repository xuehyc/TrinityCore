/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

// This file was created automatically from your script configuration!
// Use CMake to reconfigure this file, never change it on your own!

#cmakedefine SERVER_IS_DYNAMIC_SCRIPTLOADER

#include "Define.h"
#include <vector>
#include <string>

@SERVER_SCRIPTS_FORWARD_DECL@
#ifdef SERVER_IS_DYNAMIC_SCRIPTLOADER
#  include "revision_data.h"
#  define SCRIPT_API API_EXPORT
extern "C" {

/// Exposed in script modules to return the script module revision hash.
SCRIPT_API char const* GetScriptModuleRevisionHash()
{
    return _HASH;
}

/// Exposed in script module to return the name of the script module
/// contained in this shared library.
SCRIPT_API char const* GetScriptModule()
{
    return "@SERVER_CURRENT_SCRIPT_PROJECT@";
}

#else
#  include "ScriptLoader.h"
#  define SCRIPT_API
#endif

/// Exposed in script modules to register all scripts to the ScriptMgr.
SCRIPT_API void AddScripts()
{
@SERVER_SCRIPTS_INVOKE@}

/// Exposed in script modules to get the build directive of the module.
SCRIPT_API char const* GetBuildDirective()
{
    return _BUILD_DIRECTIVE;
}

#ifdef SERVER_IS_DYNAMIC_SCRIPTLOADER
} // extern "C"
#endif
