/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "MySQLThreading.h"
#include "MySQLWorkaround.h"

void MySQL::Library_Init()
{
    mysql_library_init(-1, NULL, NULL);
}

void MySQL::Library_End()
{
    mysql_library_end();
}

char const* MySQL::GetLibraryVersion()
{
    return MYSQL_SERVER_VERSION;
}
