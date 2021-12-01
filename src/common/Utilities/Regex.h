/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef MobiusCore_Regex_h__
#define MobiusCore_Regex_h__

#ifndef HAS_BROKEN_WSTRING_REGEX
#include <regex>
#define REGEX_NAMESPACE std
#else
#include <boost/regex.hpp>
#define REGEX_NAMESPACE boost
#endif

// regex compatibility layer, required for clang building with libstdc++-4.9
namespace Server
{
    using regex = REGEX_NAMESPACE :: regex;
    using wregex = REGEX_NAMESPACE :: wregex;

    using :: REGEX_NAMESPACE :: regex_match;
    using :: REGEX_NAMESPACE :: regex_search;
}

#endif // MobiusCore_Regex_h__
