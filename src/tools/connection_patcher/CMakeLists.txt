# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

CollectSourceFiles(${CMAKE_CURRENT_SOURCE_DIR} PRIVATE_SOURCES)

if (WIN32)
  list(APPEND PRIVATE_SOURCES ${sources_windows})
endif()

GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(connection_patcher ${PRIVATE_SOURCES})

target_link_libraries(connection_patcher
  PRIVATE
    mobius-core-interface
  PUBLIC
    common
)

if (UNIX)
  install(TARGETS connection_patcher DESTINATION bin)
elseif (WIN32)
  install(TARGETS connection_patcher DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif ()
