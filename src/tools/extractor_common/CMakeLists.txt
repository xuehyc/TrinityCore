# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

CollectSourceFiles(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE_SOURCES)

add_library(extractor_common STATIC ${PRIVATE_SOURCES})

target_link_libraries(extractor_common
  PRIVATE
    mobius-core-interface
  PUBLIC
    casc
    common)

target_include_directories(extractor_common
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR})
