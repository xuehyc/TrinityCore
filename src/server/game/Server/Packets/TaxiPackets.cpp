/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "TaxiPackets.h"

void WorldPackets::Taxi::TaxiNodeStatusQuery::Read()
{
    _worldPacket >> UnitGUID;
}

WorldPacket const* WorldPackets::Taxi::TaxiNodeStatus::Write()
{
    _worldPacket << Unit;
    _worldPacket.WriteBits(Status, 2);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Taxi::ShowTaxiNodes::Write()
{
    _worldPacket.WriteBit(WindowInfo.is_initialized());
    _worldPacket.FlushBits();

    _worldPacket << uint32(CanLandNodes->size());
    _worldPacket << uint32(CanUseNodes->size());

    if (WindowInfo.is_initialized())
    {
        _worldPacket << WindowInfo->UnitGUID;
        _worldPacket << uint32(WindowInfo->CurrentNode);
    }

    _worldPacket.append(CanLandNodes->data(), CanLandNodes->size());
    _worldPacket.append(CanUseNodes->data(), CanUseNodes->size());

    return &_worldPacket;
}

void WorldPackets::Taxi::EnableTaxiNode::Read()
{
    _worldPacket >> Unit;
}

void WorldPackets::Taxi::TaxiQueryAvailableNodes::Read()
{
    _worldPacket >> Unit;
}

void WorldPackets::Taxi::ActivateTaxi::Read()
{
    _worldPacket >> Vendor;
    _worldPacket >> Node;
    _worldPacket >> GroundMountID;
    _worldPacket >> FlyingMountID;
}

WorldPacket const* WorldPackets::Taxi::ActivateTaxiReply::Write()
{
    _worldPacket.WriteBits(Reply, 4);
    _worldPacket.FlushBits();

    return &_worldPacket;
}
