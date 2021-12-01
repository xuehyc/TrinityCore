/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "AreaTriggerPackets.h"

ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::AreaTrigger::AreaTriggerSplineInfo const& areaTriggerSpline)
{
    data << uint32(areaTriggerSpline.TimeToTarget);
    data << uint32(areaTriggerSpline.ElapsedTimeForMovement);

    data.WriteBits(areaTriggerSpline.Points.size(), 16);
    data.FlushBits();

    for (TaggedPosition<Position::XYZ> const& point : areaTriggerSpline.Points)
        data << point;

    return data;
}

ByteBuffer& operator<<(ByteBuffer& data, AreaTriggerCircularMovementInfo const& areaTriggerCircularMovement)
{
    data.WriteBit(areaTriggerCircularMovement.TargetGUID.is_initialized());
    data.WriteBit(areaTriggerCircularMovement.Center.is_initialized());
    data.WriteBit(areaTriggerCircularMovement.CounterClockwise);
    data.WriteBit(areaTriggerCircularMovement.CanLoop);

    data << uint32(areaTriggerCircularMovement.TimeToTarget);
    data << int32(areaTriggerCircularMovement.ElapsedTimeForMovement);
    data << uint32(areaTriggerCircularMovement.StartDelay);
    data << float(areaTriggerCircularMovement.Radius);
    data << float(areaTriggerCircularMovement.BlendFromRadius);
    data << float(areaTriggerCircularMovement.InitialAngle);
    data << float(areaTriggerCircularMovement.ZOffset);

    if (areaTriggerCircularMovement.TargetGUID)
        data << *areaTriggerCircularMovement.TargetGUID;

    if (areaTriggerCircularMovement.Center)
        data << *areaTriggerCircularMovement.Center;

    return data;
}

void WorldPackets::AreaTrigger::AreaTrigger::Read()
{
    _worldPacket >> AreaTriggerID;
    Entered = _worldPacket.ReadBit();
    FromClient = _worldPacket.ReadBit();
}

WorldPacket const* WorldPackets::AreaTrigger::AreaTriggerDenied::Write()
{
    _worldPacket << int32(AreaTriggerID);
    _worldPacket.WriteBit(Entered);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AreaTrigger::AreaTriggerRePath::Write()
{
    _worldPacket << TriggerGUID;
    _worldPacket << AreaTriggerSpline;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::AreaTrigger::AreaTriggerReShape::Write()
{
    _worldPacket << TriggerGUID;

    _worldPacket.WriteBit(AreaTriggerSpline.is_initialized());
    _worldPacket.WriteBit(AreaTriggerCircularMovement.is_initialized());
    _worldPacket.FlushBits();

    if (AreaTriggerSpline)
        _worldPacket << *AreaTriggerSpline;

    if (AreaTriggerCircularMovement)
        _worldPacket << *AreaTriggerCircularMovement;

    return &_worldPacket;
}
