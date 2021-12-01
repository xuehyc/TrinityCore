# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

set(PRIVATE_SOURCES VMapAssembler.cpp)

if (WIN32)
  list(APPEND PRIVATE_SOURCES ${sources_windows})
endif()

add_executable(vmap4assembler ${PRIVATE_SOURCES})

target_link_libraries(vmap4assembler
  PRIVATE
    mobius-core-interface
  PUBLIC
    common
    casc
    zlib)

set_target_properties(vmap4assembler
    PROPERTIES
      FOLDER
        "tools")

if( UNIX )
  install(TARGETS vmap4assembler DESTINATION bin)
elseif( WIN32 )
  install(TARGETS vmap4assembler DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()
