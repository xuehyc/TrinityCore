/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "GameObjectAI.h"
#include "CreatureAI.h"
#include "GameObject.h"

//GameObjectAI::GameObjectAI(GameObject* g) : go(g) { }
int GameObjectAI::Permissible(const GameObject* go)
{
    if (go->GetAIName() == "GameObjectAI")
        return PERMIT_BASE_SPECIAL;
    return PERMIT_BASE_NO;
}

NullGameObjectAI::NullGameObjectAI(GameObject* g) : GameObjectAI(g) { }

int NullGameObjectAI::Permissible(GameObject const* /*go*/)
{
    return PERMIT_BASE_IDLE;
}
