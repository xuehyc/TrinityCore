/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _MMAP_FACTORY_H
#define _MMAP_FACTORY_H

#include "Define.h"
#include "MMapManager.h"
#include "DetourAlloc.h"
#include "DetourNavMesh.h"
#include "DetourNavMeshQuery.h"
#include <unordered_map>

namespace MMAP
{
    enum MMAP_LOAD_RESULT
    {
        MMAP_LOAD_RESULT_ERROR,
        MMAP_LOAD_RESULT_OK,
        MMAP_LOAD_RESULT_IGNORED
    };

    // static class
    // holds all mmap global data
    // access point to MMapManager singleton
    class COMMON_API MMapFactory
    {
        public:
            static MMapManager* createOrGetMMapManager();
            static void clear();
    };
}

#endif
