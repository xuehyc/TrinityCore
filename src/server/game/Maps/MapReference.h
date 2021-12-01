/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _MAPREFERENCE_H
#define _MAPREFERENCE_H

#include "Reference.h"

class Map;
class Player;

class MapReference : public Reference<Map, Player>
{
    protected:
        void targetObjectBuildLink() override;
        void targetObjectDestroyLink() override;
        void sourceObjectDestroyLink() override;
    public:
        MapReference() : Reference<Map, Player>() { }
        ~MapReference() { unlink(); }
        MapReference* next() { return (MapReference*)Reference<Map, Player>::next(); }
        MapReference const* next() const { return (MapReference const*)Reference<Map, Player>::next(); }
        MapReference* nockeck_prev() { return (MapReference*)Reference<Map, Player>::nocheck_prev(); }
        MapReference const* nocheck_prev() const { return (MapReference const*)Reference<Map, Player>::nocheck_prev(); }
};
#endif
