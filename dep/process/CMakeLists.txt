# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

add_library(process INTERFACE)

target_include_directories(process
  INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(process
  INTERFACE
    boost)
