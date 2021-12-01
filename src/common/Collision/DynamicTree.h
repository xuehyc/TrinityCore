/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _DYNTREE_H
#define _DYNTREE_H

#include "Define.h"

namespace G3D
{
    class Ray;
    class Vector3;
}

class GameObjectModel;
class PhaseShift;
struct DynTreeImpl;

class COMMON_API DynamicMapTree
{
    DynTreeImpl *impl;

public:

    DynamicMapTree();
    ~DynamicMapTree();

    bool isInLineOfSight(G3D::Vector3 const& startPos, G3D::Vector3 const& endPos, PhaseShift const& phaseShift) const;
    bool getIntersectionTime(G3D::Ray const& ray, G3D::Vector3 const& endPos, PhaseShift const& phaseShift, float& maxDist) const;
    bool getObjectHitPos(G3D::Vector3 const& startPos, G3D::Vector3 const& endPos, G3D::Vector3& resultHitPos, float modifyDist, PhaseShift const& phaseShift) const;

    float getHeight(float x, float y, float z, float maxSearchDist, PhaseShift const& phaseShift) const;
    bool getAreaInfo(float x, float y, float& z, PhaseShift const& phaseShift, uint32& flags, int32& adtId, int32& rootId, int32& groupId) const;

    void insert(const GameObjectModel&);
    void remove(const GameObjectModel&);
    bool contains(const GameObjectModel&) const;

    void balance();
    void update(uint32 diff);
};

#endif // _DYNTREE_H
