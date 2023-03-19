#
# Copyright (C) 2010 - 2016 Eluna Lua Engine <http://emudevs.com/>
# This program is free software licensed under GPL version 3
# Please see the included DOCS/LICENSE.md for more information
#

if ( USE_COREPCH )
  include_directories(${CMAKE_CURRENT_BINARY_DIR})
  include_directories(${CMAKE_SOURCE_DIR})
endif ()

# Iterates through all the source files and adds them to the solution
file(GLOB sources_localdir *.cpp *.h)

# Adds all the method headers to its own source group
file(GLOB method_headers  *Methods.h)
source_group("Methods" FILES ${method_headers})

set(LuaEngine_STAT_SRCS
  ${LuaEngine_STAT_SRCS}
  ${sources_localdir}
)

include_directories(
  ${CMAKE_SOURCE_DIR}/dep/zlib
  ${CMAKE_SOURCE_DIR}/dep/lualib
  ${CMAKE_BINARY_DIR}
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
  ${OPENSSL_INCLUDE_DIR}
)

add_library(LuaEngine STATIC
  ${LuaEngine_STAT_SRCS}
  ${game_STAT_SRCS}
  ${game_STAT_PCH_SRC}
)

include_directories(
  ${CMAKE_SOURCE_DIR}/dep/g3dlite
  ${CMAKE_SOURCE_DIR}/src/tools
  ${CMAKE_SOURCE_DIR}/src/Common
  ${CMAKE_SOURCE_DIR}/src/Common/Threading
  ${CMAKE_SOURCE_DIR}/src/Common/Logging
  ${CMAKE_SOURCE_DIR}/src/Common/Utilities
  ${CMAKE_SOURCE_DIR}/src/shared
  ${CMAKE_SOURCE_DIR}/src/shared/DataStores
  ${CMAKE_SOURCE_DIR}/src/server
  ${CMAKE_SOURCE_DIR}/src/server/game
  ${CMAKE_SOURCE_DIR}/src/server/game/BattleGrounds
  ${CMAKE_SOURCE_DIR}/src/server/game/Maps
  ${CMAKE_SOURCE_DIR}/src/server/game/Handlers
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/AreaTrigger
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Conversation
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Corpse
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Creature
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/DynamicObject
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/GameObject
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Item
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Object
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Object/Updates
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Pet
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Player
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Taxi
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Totem
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Transport
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Unit
  ${CMAKE_SOURCE_DIR}/src/server/game/Entities/Vehicle
)

if( WIN32 )
  if ( MSVC )
    add_custom_command(TARGET LuaEngine
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/lua_scripts/extensions/
      COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/extensions ${CMAKE_BINARY_DIR}/bin/$(ConfigurationName)/lua_scripts/extensions/
    )
  elseif ( MINGW )
    add_custom_command(TARGET LuaEngine
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/bin/lua_scripts/extensions/
      COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/extensions ${CMAKE_BINARY_DIR}/bin/ua_scripts/extensions/
    )
  endif()
endif()

install(DIRECTORY extensions DESTINATION ${BIN_DIR}/lua_scripts/)
