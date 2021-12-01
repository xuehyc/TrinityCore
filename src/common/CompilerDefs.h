/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_COMPILERDEFS_H
#define SERVER_COMPILERDEFS_H

#define SERVER_PLATFORM_WINDOWS 0
#define SERVER_PLATFORM_UNIX    1
#define SERVER_PLATFORM_APPLE   2
#define SERVER_PLATFORM_INTEL   3

// must be first (win 64 also define _WIN32)
#if defined( _WIN64 )
#  define SERVER_PLATFORM SERVER_PLATFORM_WINDOWS
#elif defined( __WIN32__ ) || defined( WIN32 ) || defined( _WIN32 )
#  define SERVER_PLATFORM SERVER_PLATFORM_WINDOWS
#elif defined( __APPLE_CC__ )
#  define SERVER_PLATFORM SERVER_PLATFORM_APPLE
#elif defined( __INTEL_COMPILER )
#  define SERVER_PLATFORM SERVER_PLATFORM_INTEL
#else
#  define SERVER_PLATFORM SERVER_PLATFORM_UNIX
#endif

#define SERVER_COMPILER_MICROSOFT 0
#define SERVER_COMPILER_GNU       1
#define SERVER_COMPILER_BORLAND   2
#define SERVER_COMPILER_INTEL     3

#ifdef _MSC_VER
#  define SERVER_COMPILER SERVER_COMPILER_MICROSOFT
#elif defined( __BORLANDC__ )
#  define SERVER_COMPILER SERVER_COMPILER_BORLAND
#elif defined( __INTEL_COMPILER )
#  define SERVER_COMPILER SERVER_COMPILER_INTEL
#elif defined( __GNUC__ )
#  define SERVER_COMPILER SERVER_COMPILER_GNU
#  define GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)
#else
#  error "FATAL ERROR: Unknown compiler."
#endif

#endif
