/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifdef _WIN32 // hack for broken mysql.h not including the correct winsock header for SOCKET definition, fixed in 5.7
#include <winsock2.h>
#endif
#include <mysql.h>
