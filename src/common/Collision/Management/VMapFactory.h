/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _VMAPFACTORY_H
#define _VMAPFACTORY_H

#include "IVMapManager.h"

/**
This is the access point to the VMapManager.
*/

namespace VMAP
{
    //===========================================================

    class COMMON_API VMapFactory
    {
        public:
            static IVMapManager* createOrGetVMapManager();
            static void clear();
    };

}
#endif
