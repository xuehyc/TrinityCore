/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVERSERVER_TYPEDEFS_H
#define SERVERSERVER_TYPEDEFS_H

#include "Common.h"

namespace G3D
{
    class Vector3;
    class Vector4;
}

namespace Movement
{
    using G3D::Vector3;
    using G3D::Vector4;

    enum MonsterMoveType
    {
        MONSTER_MOVE_NORMAL         = 0,
        MONSTER_MOVE_FACING_SPOT    = 1,
        MONSTER_MOVE_FACING_TARGET  = 2,
        MONSTER_MOVE_FACING_ANGLE   = 3
    };

    inline uint32 SecToMS(float sec)
    {
        return static_cast<uint32>(sec * 1000.f);
    }

    inline float MSToSec(uint32 ms)
    {
        return ms / 1000.f;
    }

    float computeFallTime(float path_length, bool isSafeFall);
    float computeFallElevation(float t_passed, bool isSafeFall, float start_velocity = 0.0f);

    template<class T, T limit>
    class counter
    {
    public:
        counter() { init(); }

        void Increase()
        {
            if (m_counter == limit)
                init();
            else
                ++m_counter;
        }

        T NewId() { Increase(); return m_counter; }
        T getCurrent() const { return m_counter; }

    private:
        void init() { m_counter = 0; }
        T m_counter;
    };

    typedef counter<uint32, 0xFFFFFFFF> UInt32Counter;

    float constexpr gravity = static_cast<float>(19.29110527038574);
    GAME_API extern UInt32Counter splineIdGen;
    GAME_API extern std::string MovementFlags_ToString(uint32 flags);
    GAME_API extern std::string MovementFlagsExtra_ToString(uint32 flags);
}

#endif // SERVERSERVER_TYPEDEFS_H
