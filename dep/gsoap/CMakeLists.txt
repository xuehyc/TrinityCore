# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

file(GLOB sources *.cpp *.h)

add_library(gsoap STATIC ${sources})

set_target_properties(gsoap PROPERTIES LINKER_LANGUAGE CXX)

target_include_directories(gsoap
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR})

target_compile_definitions(gsoap
  PUBLIC
    -DWITH_OPENSSL)

target_link_libraries(gsoap
  PRIVATE
    mobius-dependency-interface
  PUBLIC
    openssl)

set_target_properties(gsoap
    PROPERTIES
      FOLDER
        "dep")

if (MSVC)
  # Little fix for MSVC / Windows platforms
  target_compile_definitions(gsoap
    PRIVATE
      -D_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES=0)
endif()
