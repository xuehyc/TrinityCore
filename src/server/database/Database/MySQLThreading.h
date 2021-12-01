/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _MYSQLTHREADING_H
#define _MYSQLTHREADING_H

#include "Define.h"

namespace MySQL
{
    DATABASE_API void Library_Init();
    DATABASE_API void Library_End();
    DATABASE_API char const* GetLibraryVersion();
};

#endif
