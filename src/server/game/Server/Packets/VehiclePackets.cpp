/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "VehiclePackets.h"

WorldPacket const* WorldPackets::Vehicle::MoveSetVehicleRecID::Write()
{
    _worldPacket << MoverGUID;
    _worldPacket << uint32(SequenceIndex);
    _worldPacket << int32(VehicleRecID);

    return &_worldPacket;
}

void WorldPackets::Vehicle::MoveSetVehicleRecIdAck::Read()
{
    _worldPacket >> Data;
    _worldPacket >> VehicleRecID;
}

WorldPacket const* WorldPackets::Vehicle::SetVehicleRecID::Write()
{
    _worldPacket << VehicleGUID;
    _worldPacket << int32(VehicleRecID);

    return &_worldPacket;
}

void WorldPackets::Vehicle::MoveDismissVehicle::Read()
{
    _worldPacket >> Status;
}

void WorldPackets::Vehicle::MoveChangeVehicleSeats::Read()
{
    _worldPacket >> Status;
    _worldPacket >> DstVehicle;
    _worldPacket >> DstSeatIndex;
}

void WorldPackets::Vehicle::RequestVehicleSwitchSeat::Read()
{
    _worldPacket >> Vehicle;
    _worldPacket >> SeatIndex;
}

void WorldPackets::Vehicle::RideVehicleInteract::Read()
{
    _worldPacket >> Vehicle;
}

void WorldPackets::Vehicle::EjectPassenger::Read()
{
    _worldPacket >> Passenger;
}
