# Copyright (C) 2008-2010 Trinity <http://www.trinitycore.org/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

find_program(_DOXYGEN
  NAMES
    doxygen
  HINTS
    ENV PATH
)

if(_DOXYGEN)
  execute_process(
    COMMAND ${_DOXYGEN} Doxygen.conf
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/src/server/authserver
  )
endif()
