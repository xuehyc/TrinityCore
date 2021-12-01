# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

add_library(rapidjson INTERFACE)

target_include_directories(rapidjson
  INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR})

target_compile_definitions(rapidjson
  INTERFACE
    -DRAPIDJSON_HAS_STDSTRING
    -DRAPIDJSON_SSE2
    -DRAPIDJSON_48BITPOINTER_OPTIMIZATION=0
    -DRAPIDJSON_ASSERT=WPAssert)
