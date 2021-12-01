/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WorldSession.h"
#include "CombatPackets.h"
#include "Common.h"
#include "CreatureAI.h"
#include "DB2Structure.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "Vehicle.h"

void WorldSession::HandleAttackSwingOpcode(WorldPackets::Combat::AttackSwing& packet)
{
    Unit* enemy = ObjectAccessor::GetUnit(*_player, packet.Victim);

    if (!enemy)
    {
        // stop attack state at client
        SendAttackStop(nullptr);
        return;
    }

    if (!_player->IsValidAttackTarget(enemy))
    {
        // stop attack state at client
        SendAttackStop(enemy);
        return;
    }

    //! Client explicitly checks the following before sending CMSG_ATTACKSWING packet,
    //! so we'll place the same check here. Note that it might be possible to reuse this snippet
    //! in other places as well.
    if (Vehicle* vehicle = _player->GetVehicle())
    {
        VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(_player);
        ASSERT(seat);
        if (!(seat->Flags & VEHICLE_SEAT_FLAG_CAN_ATTACK))
        {
            SendAttackStop(enemy);
            return;
        }
    }

    _player->Attack(enemy, true);
}

void WorldSession::HandleAttackStopOpcode(WorldPackets::Combat::AttackStop& /*recvData*/)
{
    GetPlayer()->AttackStop();
}

void WorldSession::HandleSetSheathedOpcode(WorldPackets::Combat::SetSheathed& packet)
{
    if (packet.CurrentSheathState >= MAX_SHEATH_STATE)
    {
        LOG_ERROR("network", "Unknown sheath state %u ??", packet.CurrentSheathState);
        return;
    }

    GetPlayer()->SetSheath(SheathState(packet.CurrentSheathState));
}

void WorldSession::SendAttackStop(Unit const* enemy)
{
    SendPacket(WorldPackets::Combat::SAttackStop(GetPlayer(), enemy).Write());
}
