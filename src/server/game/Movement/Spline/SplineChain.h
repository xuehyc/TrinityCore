/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_SPLINECHAIN_H
#define SERVER_SPLINECHAIN_H

#include "MoveSplineInitArgs.h"
#include <G3D/Vector3.h>

struct GAME_API SplineChainLink
{
    SplineChainLink(Movement::PointsArray const& points, uint32 expectedDuration, uint32 msToNext) : Points(points), ExpectedDuration(expectedDuration), TimeToNext(msToNext) { }
    template <typename iteratorType> SplineChainLink(iteratorType begin, iteratorType end, uint32 expectedDuration, uint32 msToNext) : Points(begin, end), ExpectedDuration(expectedDuration), TimeToNext(msToNext) { }
    SplineChainLink(uint32 expectedDuration, uint32 msToNext) : Points(), ExpectedDuration(expectedDuration), TimeToNext(msToNext) { }
    Movement::PointsArray Points;
    uint32 ExpectedDuration;
    uint32 TimeToNext;
};

struct GAME_API SplineChainResumeInfo
{
    SplineChainResumeInfo() : PointID(0), Chain(nullptr), IsWalkMode(false), SplineIndex(0), PointIndex(0), TimeToNext(0) { }
    SplineChainResumeInfo(uint32 id, std::vector<SplineChainLink> const* chain, bool walk, uint8 splineIndex, uint8 wpIndex, uint32 msToNext) :
        PointID(id), Chain(chain), IsWalkMode(walk), SplineIndex(splineIndex), PointIndex(wpIndex), TimeToNext(msToNext) { }
    bool Empty() const { return Chain == nullptr; }
    void Clear() { Chain = nullptr; }
    uint32 PointID;
    std::vector<SplineChainLink> const* Chain;
    bool IsWalkMode;
    uint8 SplineIndex;
    uint8 PointIndex;
    uint32 TimeToNext;
};

#endif
