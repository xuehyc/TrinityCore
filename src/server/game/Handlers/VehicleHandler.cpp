/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WorldSession.h"
#include "DB2Structure.h"
#include "Log.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "Vehicle.h"
#include "VehiclePackets.h"

void WorldSession::HandleMoveDismissVehicle(WorldPackets::Vehicle::MoveDismissVehicle& moveDismissVehicle)
{
    ObjectGuid vehicleGUID = _player->GetCharmGUID();
    if (vehicleGUID.IsEmpty())
        return;

    _player->ValidateMovementInfo(&moveDismissVehicle.Status);
    _player->m_movementInfo = moveDismissVehicle.Status;

    _player->ExitVehicle();
}

void WorldSession::HandleRequestVehiclePrevSeat(WorldPackets::Vehicle::RequestVehiclePrevSeat& /*requestVehiclePrevSeat*/)
{
    Unit* vehicle_base = GetPlayer()->GetVehicleBase();
    if (!vehicle_base)
        return;

    VehicleSeatEntry const* seat = GetPlayer()->GetVehicle()->GetSeatForPassenger(GetPlayer());
    if (!seat->CanSwitchFromSeat())
    {
        LOG_ERROR("network", "HandleRequestVehiclePrevSeat: %s tried to switch seats but current seatflags %u don't permit that.",
            GetPlayer()->GetGUID().ToString().c_str(), seat->Flags);
        return;
    }

    GetPlayer()->ChangeSeat(-1, false);
}

void WorldSession::HandleRequestVehicleNextSeat(WorldPackets::Vehicle::RequestVehicleNextSeat& /*requestVehicleNextSeat*/)
{
    Unit* vehicle_base = GetPlayer()->GetVehicleBase();
    if (!vehicle_base)
        return;

    VehicleSeatEntry const* seat = GetPlayer()->GetVehicle()->GetSeatForPassenger(GetPlayer());
    if (!seat->CanSwitchFromSeat())
    {
        LOG_ERROR("network", "HandleRequestVehicleNextSeat: %s tried to switch seats but current seatflags %u don't permit that.",
            GetPlayer()->GetGUID().ToString().c_str(), seat->Flags);
        return;
    }

    GetPlayer()->ChangeSeat(-1, true);
}

void WorldSession::HandleMoveChangeVehicleSeats(WorldPackets::Vehicle::MoveChangeVehicleSeats& moveChangeVehicleSeats)
{
    Unit* vehicle_base = GetPlayer()->GetVehicleBase();
    if (!vehicle_base)
        return;

    VehicleSeatEntry const* seat = GetPlayer()->GetVehicle()->GetSeatForPassenger(GetPlayer());
    if (!seat->CanSwitchFromSeat())
    {
        LOG_ERROR("network", "HandleMoveChangeVehicleSeats: %s tried to switch seats but current seatflags %u don't permit that.",
            GetPlayer()->GetGUID().ToString().c_str(), seat->Flags);
        return;
    }

    GetPlayer()->ValidateMovementInfo(&moveChangeVehicleSeats.Status);

    if (vehicle_base->GetGUID() != moveChangeVehicleSeats.Status.guid)
        return;

    vehicle_base->m_movementInfo = moveChangeVehicleSeats.Status;

    if (moveChangeVehicleSeats.DstVehicle.IsEmpty())
        GetPlayer()->ChangeSeat(-1, moveChangeVehicleSeats.DstSeatIndex != 255);
    else if (Unit* vehUnit = ObjectAccessor::GetUnit(*GetPlayer(), moveChangeVehicleSeats.DstVehicle))
        if (Vehicle* vehicle = vehUnit->GetVehicleKit())
            if (vehicle->HasEmptySeat(moveChangeVehicleSeats.DstSeatIndex))
                vehUnit->HandleSpellClick(GetPlayer(), int8(moveChangeVehicleSeats.DstSeatIndex));
}

void WorldSession::HandleRequestVehicleSwitchSeat(WorldPackets::Vehicle::RequestVehicleSwitchSeat& requestVehicleSwitchSeat)
{
    Unit* vehicle_base = GetPlayer()->GetVehicleBase();
    if (!vehicle_base)
        return;

    VehicleSeatEntry const* seat = GetPlayer()->GetVehicle()->GetSeatForPassenger(GetPlayer());
    if (!seat->CanSwitchFromSeat())
    {
        LOG_ERROR("network", "HandleRequestVehicleSwitchSeat: %s tried to switch seats but current seatflags %u don't permit that.",
            GetPlayer()->GetGUID().ToString().c_str(), seat->Flags);
        return;
    }

    if (vehicle_base->GetGUID() == requestVehicleSwitchSeat.Vehicle)
        GetPlayer()->ChangeSeat(int8(requestVehicleSwitchSeat.SeatIndex));
    else if (Unit* vehUnit = ObjectAccessor::GetUnit(*GetPlayer(), requestVehicleSwitchSeat.Vehicle))
        if (Vehicle* vehicle = vehUnit->GetVehicleKit())
            if (vehicle->HasEmptySeat(int8(requestVehicleSwitchSeat.SeatIndex)))
                vehUnit->HandleSpellClick(GetPlayer(), int8(requestVehicleSwitchSeat.SeatIndex));
}

void WorldSession::HandleRideVehicleInteract(WorldPackets::Vehicle::RideVehicleInteract& rideVehicleInteract)
{
    if (Player* player = ObjectAccessor::GetPlayer(*_player, rideVehicleInteract.Vehicle))
    {
        if (!player->GetVehicleKit())
            return;
        if (!player->IsInRaidWith(_player))
            return;
        if (!player->IsWithinDistInMap(_player, INTERACTION_DISTANCE))
            return;
        // Dont' allow players to enter player vehicle on arena
        if (!_player->FindMap() || _player->FindMap()->IsBattleArena())
            return;

        _player->EnterVehicle(player);
    }
}

void WorldSession::HandleEjectPassenger(WorldPackets::Vehicle::EjectPassenger& ejectPassenger)
{
    Vehicle* vehicle = _player->GetVehicleKit();
    if (!vehicle)
    {
        LOG_ERROR("network", "HandleEjectPassenger: %s is not in a vehicle!", GetPlayer()->GetGUID().ToString().c_str());
        return;
    }

    if (ejectPassenger.Passenger.IsUnit())
    {
        Unit* unit = ObjectAccessor::GetUnit(*_player, ejectPassenger.Passenger);
        if (!unit) // creatures can be ejected too from player mounts
        {
            LOG_ERROR("network", "%s tried to eject %s from vehicle, but the latter was not found in world!", GetPlayer()->GetGUID().ToString().c_str(), ejectPassenger.Passenger.ToString().c_str());
            return;
        }

        if (!unit->IsOnVehicle(vehicle->GetBase()))
        {
            LOG_ERROR("network", "%s tried to eject %s, but they are not in the same vehicle", GetPlayer()->GetGUID().ToString().c_str(), ejectPassenger.Passenger.ToString().c_str());
            return;
        }

        VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(unit);
        ASSERT(seat);
        if (seat->IsEjectable())
            unit->ExitVehicle();
        else
            LOG_ERROR("network", "%s attempted to eject %s from non-ejectable seat.", GetPlayer()->GetGUID().ToString().c_str(), ejectPassenger.Passenger.ToString().c_str());
    }
    else
        LOG_ERROR("network", "HandleEjectPassenger: %s tried to eject invalid %s ", GetPlayer()->GetGUID().ToString().c_str(), ejectPassenger.Passenger.ToString().c_str());
}

void WorldSession::HandleRequestVehicleExit(WorldPackets::Vehicle::RequestVehicleExit& /*requestVehicleExit*/)
{
    if (Vehicle* vehicle = GetPlayer()->GetVehicle())
    {
        auto itr = vehicle->GetSeatIteratorForPassenger(GetPlayer());
        if (itr != vehicle->Seats.end())
        {
            if (itr->second.SeatInfo->CanEnterOrExit())
                GetPlayer()->ExitVehicle();
            else
                LOG_ERROR("network", "%s tried to exit vehicle, but seatflags %u (ID: %u) don't permit that.",
                    GetPlayer()->GetGUID().ToString().c_str(), vehicle->GetVehicleInfo()->SeatID[itr->first], itr->second.SeatInfo->Flags);
        }
    }
}

void WorldSession::HandleMoveSetVehicleRecAck(WorldPackets::Vehicle::MoveSetVehicleRecIdAck& setVehicleRecIdAck)
{
    GetPlayer()->ValidateMovementInfo(&setVehicleRecIdAck.Data.Status);
}
