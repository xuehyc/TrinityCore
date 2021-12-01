# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

add_subdirectory(threads)

if(SERVERS OR TOOLS)
  add_subdirectory(boost)
  add_subdirectory(process)
  add_subdirectory(zlib)
  add_subdirectory(g3dlite)
  add_subdirectory(recastnavigation)
  add_subdirectory(fmt)
  add_subdirectory(SFMT)
  add_subdirectory(utf8cpp)
  add_subdirectory(valgrind)
  add_subdirectory(openssl)
  add_subdirectory(jemalloc)
endif()

if(SERVERS)
  add_subdirectory(mysql)
  add_subdirectory(readline)
  add_subdirectory(gsoap)
  add_subdirectory(rapidjson)
  add_subdirectory(efsw)
  add_subdirectory(protobuf)
endif()

if(TOOLS)
  add_subdirectory(bzip2)
  add_subdirectory(CascLib)
endif()
