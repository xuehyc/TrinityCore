/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "NGrid.h"
#include "Random.h"

GridInfo::GridInfo() : i_timer(0), vis_Update(0, irand(0, DEFAULT_VISIBILITY_NOTIFY_PERIOD)),
    i_unloadActiveLockCount(0), i_unloadExplicitLock(false)
{
}

GridInfo::GridInfo(time_t expiry, bool unload /*= true */) : i_timer(expiry), vis_Update(0, irand(0, DEFAULT_VISIBILITY_NOTIFY_PERIOD)),
    i_unloadActiveLockCount(0), i_unloadExplicitLock(!unload)
{
}
