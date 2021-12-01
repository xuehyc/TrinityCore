/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _MAPREFMANAGER
#define _MAPREFMANAGER

#include "RefManager.h"

class MapReference;

class MapRefManager : public RefManager<Map, Player>
{
    public:
        typedef LinkedListHead::Iterator<MapReference> iterator;
        typedef LinkedListHead::Iterator<MapReference const> const_iterator;

        MapReference* getFirst()             { return (MapReference*)RefManager<Map, Player>::getFirst(); }
        MapReference const* getFirst() const { return (MapReference const*)RefManager<Map, Player>::getFirst(); }

        iterator begin() { return iterator(getFirst()); }
        iterator end()   { return iterator(nullptr); }

        const_iterator begin() const { return const_iterator(getFirst()); }
        const_iterator end() const   { return const_iterator(nullptr); }
};
#endif
