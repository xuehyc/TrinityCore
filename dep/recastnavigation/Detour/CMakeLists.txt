# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

set(Detour_STAT_SRCS
    Source/DetourAlloc.cpp 
    Source/DetourCommon.cpp 
    Source/DetourNavMesh.cpp 
    Source/DetourNavMeshBuilder.cpp 
    Source/DetourNavMeshQuery.cpp 
    Source/DetourNode.cpp 
)

add_library(Detour STATIC ${Detour_STAT_SRCS})

target_include_directories(Detour
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/Include)

target_link_libraries(Detour
  PRIVATE
    mobius-dependency-interface
  PUBLIC
    zlib)

set_target_properties(Detour
    PROPERTIES
      FOLDER
        "dep")
