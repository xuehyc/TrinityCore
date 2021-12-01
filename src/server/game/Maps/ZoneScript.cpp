/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ZoneScript.h"
#include "Creature.h"

uint32 ZoneScript::GetCreatureEntry(ObjectGuid::LowType /*guidLow*/, CreatureData const* data)
{
    return data->id;
}
