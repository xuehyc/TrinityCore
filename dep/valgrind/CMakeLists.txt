# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

add_library(valgrind INTERFACE)

target_include_directories(valgrind
  INTERFACE
    "${VALGRIND_INCLUDE_DIR}")
