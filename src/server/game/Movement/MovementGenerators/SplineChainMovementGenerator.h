/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_SPLINECHAINMOVEMENTGENERATOR_H
#define SERVER_SPLINECHAINMOVEMENTGENERATOR_H

#include "SplineChain.h"
#include "MovementGenerator.h"

class GAME_API SplineChainMovementGenerator : public MovementGenerator
{
    public:
        explicit SplineChainMovementGenerator(uint32 id, std::vector<SplineChainLink> const& chain, bool walk = false) : _id(id), _chain(chain), _chainSize(chain.size()), _walk(walk), finished(false), _nextIndex(0), _nextFirstWP(0), _msToNext(0) { }
        explicit SplineChainMovementGenerator(SplineChainResumeInfo const& info) : _id(info.PointID), _chain(*info.Chain), _chainSize(info.Chain->size()), _walk(info.IsWalkMode), finished(info.SplineIndex >= info.Chain->size()), _nextIndex(info.SplineIndex), _nextFirstWP(info.PointIndex), _msToNext(info.TimeToNext) { }
        void Initialize(Unit* me) override;
        void Finalize(Unit* me) override;
        void Reset(Unit* /*me*/) override { };
        bool Update(Unit* me, uint32 diff) override;
        MovementGeneratorType GetMovementGeneratorType() const override { return SPLINE_CHAIN_MOTION_TYPE; }
        // Builds info that can later be used to resume this spline chain movement at the current position
        static void GetResumeInfo(Unit const* me, SplineChainResumeInfo& info);
        // Leaving the object method public for people that know what they're doing to use
        // But really, 99% of the time you should be using the static one instead
        SplineChainResumeInfo GetResumeInfo(Unit const* me) const;

    private:
        void SendSplineFor(Unit* me, uint32 index, uint32& toNext);
        uint32 SendPathSpline(Unit* me, Movement::PointsArray const& wp) const;
        uint32 const _id;
        std::vector<SplineChainLink> const& _chain;
        uint8 const _chainSize;
        bool const _walk;
        bool finished;
        uint8 _nextIndex;
        uint8 _nextFirstWP; // only used for resuming
        uint32 _msToNext;
};

#endif
