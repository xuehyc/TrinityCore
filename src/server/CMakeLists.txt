# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

# Enforce compileparameters for corebuilds under GCC
# This to stop a few silly crashes that could have been avoided IF people
# weren't doing some -O3 psychooptimizations etc.

if(CMAKE_COMPILER_IS_GNUCXX AND NOT MINGW)
  add_definitions(-fno-delete-null-pointer-checks)
endif()

if(WIN32)
  list(APPEND sources_windows
    ${CMAKE_SOURCE_DIR}/src/common/Platform/ServiceWin32.cpp
    ${CMAKE_SOURCE_DIR}/src/common/Platform/ServiceWin32.h
  )
endif(WIN32)

add_subdirectory(database)
add_subdirectory(proto)
add_subdirectory(shared)
add_subdirectory(bnetserver)
add_subdirectory(game)
add_subdirectory(scripts)
add_subdirectory(worldserver)
