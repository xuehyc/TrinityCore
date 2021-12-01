/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "GameObjectPackets.h"

void WorldPackets::GameObject::GameObjUse::Read()
{
    _worldPacket >> Guid;
}

void WorldPackets::GameObject::GameObjReportUse::Read()
{
    _worldPacket >> Guid;
}

WorldPacket const* WorldPackets::GameObject::GameObjectDespawn::Write()
{
    _worldPacket << ObjectGUID;
    return &_worldPacket;
}

WorldPacket const* WorldPackets::GameObject::PageText::Write()
{
    _worldPacket << GameObjectGUID;
    return &_worldPacket;
}

WorldPacket const* WorldPackets::GameObject::GameObjectActivateAnimKit::Write()
{
    _worldPacket << ObjectGUID;
    _worldPacket << uint32(AnimKitID);
    _worldPacket.WriteBit(Maintain);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const * WorldPackets::GameObject::DestructibleBuildingDamage::Write()
{
    _worldPacket << Target;
    _worldPacket << Owner;
    _worldPacket << Caster;
    _worldPacket << int32(Damage);
    _worldPacket << int32(SpellID);

    return &_worldPacket;
}

WorldPacket const* WorldPackets::GameObject::GameObjectCustomAnim::Write()
{
    _worldPacket << ObjectGUID;
    _worldPacket << uint32(CustomAnim);
    _worldPacket.WriteBit(PlayAsDespawn);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::GameObject::GameObjectUIAction::Write()
{
    _worldPacket << ObjectGUID;
    _worldPacket << int32(UILink);

    return &_worldPacket;
}
