/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_WAYPOINTDEFINES_H
#define SERVER_WAYPOINTDEFINES_H

#include "Define.h"
#include <vector>

enum WaypointMoveType
{
    WAYPOINT_MOVE_TYPE_WALK,
    WAYPOINT_MOVE_TYPE_RUN,
    WAYPOINT_MOVE_TYPE_LAND,
    WAYPOINT_MOVE_TYPE_TAKEOFF,

    WAYPOINT_MOVE_TYPE_MAX
};

struct WaypointNode
{
    WaypointNode() : id(0), x(0.f), y(0.f), z(0.f), orientation(0.f), delay(0), eventId(0), moveType(WAYPOINT_MOVE_TYPE_RUN), eventChance(0) { }
    WaypointNode(uint32 _id, float _x, float _y, float _z, float _orientation = 0.f, uint32 _delay = 0)
    {
        id = _id;
        x = _x;
        y = _y;
        z = _z;
        orientation = _orientation;
        delay = _delay;
        eventId = 0;
        moveType = WAYPOINT_MOVE_TYPE_WALK;
        eventChance = 100;
    }

    uint32 id;
    float x, y, z, orientation;
    uint32 delay;
    uint32 eventId;
    uint32 moveType;
    uint8 eventChance;
};

struct WaypointPath
{
    WaypointPath() : id(0) { }
    WaypointPath(uint32 _id, std::vector<WaypointNode>&& _nodes)
    {
        id = _id;
        nodes = _nodes;
    }

    std::vector<WaypointNode> nodes;
    uint32 id;
};

#endif
