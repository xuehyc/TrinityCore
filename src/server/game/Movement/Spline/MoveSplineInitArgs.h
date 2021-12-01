/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVERSERVER_MOVESPLINEINIT_ARGS_H
#define SERVERSERVER_MOVESPLINEINIT_ARGS_H

#include "MoveSplineFlag.h"
#include "ObjectGuid.h"
#include "Optional.h"

class Unit;

namespace Movement
{
    typedef std::vector<Vector3> PointsArray;

    struct FacingInfo
    {
        struct
        {
            float x, y, z;
        } f;
        ObjectGuid target;
        float angle;

        MonsterMoveType type;

        FacingInfo() : angle(0.0f), type(MONSTER_MOVE_NORMAL) { f.x = f.y = f.z = 0.0f; }
    };

    struct SpellEffectExtraData
    {
        ObjectGuid Target;
        uint32 SpellVisualId = 0;
        uint32 ProgressCurveId = 0;
        uint32 ParabolicCurveId = 0;
    };

    struct MoveSplineInitArgs
    {
        explicit MoveSplineInitArgs(size_t path_capacity = 16);
        ~MoveSplineInitArgs();

        PointsArray path;
        FacingInfo facing;
        MoveSplineFlag flags;
        int32 path_Idx_offset;
        float velocity;
        float parabolic_amplitude;
        float time_perc;
        uint32 splineId;
        float initialOrientation;
        Optional<SpellEffectExtraData> spellEffectExtra;
        bool walk;
        bool HasVelocity;
        bool TransformForTransport;

        /** Returns true to show that the arguments were configured correctly and MoveSpline initialization will succeed. */
        bool Validate(Unit* unit) const;

    private:
        bool _checkPathLengths() const;
    };
}

#endif // SERVERSERVER_MOVESPLINEINIT_ARGS_H
