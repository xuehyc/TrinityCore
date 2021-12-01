/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_DEFINE_H
#define SERVER_DEFINE_H

#include "CompilerDefs.h"

#if SERVER_COMPILER == SERVER_COMPILER_GNU
#  if !defined(__STDC_FORMAT_MACROS)
#    define __STDC_FORMAT_MACROS
#  endif
#  if !defined(__STDC_CONSTANT_MACROS)
#    define __STDC_CONSTANT_MACROS
#  endif
#  if !defined(_GLIBCXX_USE_NANOSLEEP)
#    define _GLIBCXX_USE_NANOSLEEP
#  endif
#  if defined(HELGRIND)
#    include <valgrind/helgrind.h>
#    undef _GLIBCXX_SYNCHRONIZATION_HAPPENS_BEFORE
#    undef _GLIBCXX_SYNCHRONIZATION_HAPPENS_AFTER
#    define _GLIBCXX_SYNCHRONIZATION_HAPPENS_BEFORE(A) ANNOTATE_HAPPENS_BEFORE(A)
#    define _GLIBCXX_SYNCHRONIZATION_HAPPENS_AFTER(A)  ANNOTATE_HAPPENS_AFTER(A)
#  endif
#  if defined(VALGRIND)
#    include <valgrind/memcheck.h>
#  endif
#endif

#include <cstddef>
#include <cinttypes>
#include <climits>

#define SERVER_LITTLEENDIAN 0
#define SERVER_BIGENDIAN    1

#if !defined(SERVER_ENDIAN)
#  if defined (BOOST_BIG_ENDIAN)
#    define SERVER_ENDIAN SERVER_BIGENDIAN
#  else
#    define SERVER_ENDIAN SERVER_LITTLEENDIAN
#  endif
#endif

#if SERVER_PLATFORM == SERVER_PLATFORM_WINDOWS
#  define SERVER_PATH_MAX 260
#  define _USE_MATH_DEFINES
#  ifndef DECLSPEC_NORETURN
#    define DECLSPEC_NORETURN __declspec(noreturn)
#  endif //DECLSPEC_NORETURN
#  ifndef DECLSPEC_DEPRECATED
#    define DECLSPEC_DEPRECATED __declspec(deprecated)
#  endif //DECLSPEC_DEPRECATED
#else // SERVER_PLATFORM != SERVER_PLATFORM_WINDOWS
#  define SERVER_PATH_MAX PATH_MAX
#  define DECLSPEC_NORETURN
#  define DECLSPEC_DEPRECATED
#endif // SERVER_PLATFORM

#if !defined(COREDEBUG)
#  define SERVER_INLINE inline
#else //COREDEBUG
#  if !defined(SERVER_DEBUG)
#    define SERVER_DEBUG
#  endif //SERVER_DEBUG
#  define SERVER_INLINE
#endif //!COREDEBUG

#if SERVER_COMPILER == SERVER_COMPILER_GNU
#  define ATTR_NORETURN __attribute__((__noreturn__))
#  define ATTR_PRINTF(F, V) __attribute__ ((__format__ (__printf__, F, V)))
#  define ATTR_DEPRECATED __attribute__((__deprecated__))
#else //SERVER_COMPILER != SERVER_COMPILER_GNU
#  define ATTR_NORETURN
#  define ATTR_PRINTF(F, V)
#  define ATTR_DEPRECATED
#endif //SERVER_COMPILER == SERVER_COMPILER_GNU

#ifdef SERVER_API_USE_DYNAMIC_LINKING
#  if SERVER_COMPILER == SERVER_COMPILER_MICROSOFT
#    define API_EXPORT __declspec(dllexport)
#    define API_IMPORT __declspec(dllimport)
#  elif SERVER_COMPILER == SERVER_COMPILER_GNU
#    define API_EXPORT __attribute__((visibility("default")))
#    define API_IMPORT
#  else
#    error compiler not supported!
#  endif
#else
#  define API_EXPORT
#  define API_IMPORT
#endif

#ifdef SERVER_API_EXPORT_COMMON
#  define COMMON_API API_EXPORT
#else
#  define COMMON_API API_IMPORT
#endif

#ifdef SERVER_API_EXPORT_PROTO
#  define PROTO_API API_EXPORT
#else
#  define PROTO_API API_IMPORT
#endif

#ifdef SERVER_API_EXPORT_DATABASE
#  define DATABASE_API API_EXPORT
#else
#  define DATABASE_API API_IMPORT
#endif

#ifdef SERVER_API_EXPORT_SHARED
#  define SHARED_API API_EXPORT
#else
#  define SHARED_API API_IMPORT
#endif

#ifdef SERVER_API_EXPORT_GAME
#  define GAME_API API_EXPORT
#else
#  define GAME_API API_IMPORT
#endif

#define UI64FMTD "%" PRIu64
#define UI64LIT(N) UINT64_C(N)

#define SI64FMTD "%" PRId64
#define SI64LIT(N) INT64_C(N)

#define SZFMTD "%" PRIuPTR

typedef int64_t int64;
typedef int32_t int32;
typedef int16_t int16;
typedef int8_t int8;
typedef uint64_t uint64;
typedef uint32_t uint32;
typedef uint16_t uint16;
typedef uint8_t uint8;

enum DBCFormer
{
    FT_STRING = 's',                                        // LocalizedString*
    FT_STRING_NOT_LOCALIZED = 'S',                          // char*
    FT_FLOAT = 'f',                                         // float
    FT_INT = 'i',                                           // uint32
    FT_BYTE = 'b',                                          // uint8
    FT_SHORT = 'h',                                         // uint16
    FT_LONG = 'l'                                           // uint64
};

#endif //SERVER_DEFINE_H
