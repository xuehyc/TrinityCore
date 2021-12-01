/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _UPDATEFIELDFLAGS_H
#define _UPDATEFIELDFLAGS_H

#include "UpdateFields.h"
#include "Define.h"

enum UpdatefieldFlags
{
    UF_FLAG_NONE                = 0x000,
    UF_FLAG_PUBLIC              = 0x001,
    UF_FLAG_PRIVATE             = 0x002,
    UF_FLAG_OWNER               = 0x004,
    UF_FLAG_ITEM_OWNER          = 0x008,
    UF_FLAG_SPECIAL_INFO        = 0x010,
    UF_FLAG_PARTY_MEMBER        = 0x020,
    UF_FLAG_UNIT_ALL            = 0x040,
    UF_FLAG_DYNAMIC             = 0x080,
    UF_FLAG_0x100               = 0x100,
    UF_FLAG_URGENT              = 0x200,
    UF_FLAG_URGENT_SELF_ONLY    = 0x400
};

GAME_API extern uint32 ItemUpdateFieldFlags[CONTAINER_END];
GAME_API extern uint32 ItemDynamicUpdateFieldFlags[CONTAINER_DYNAMIC_END];
GAME_API extern uint32 UnitUpdateFieldFlags[PLAYER_END];
GAME_API extern uint32 UnitDynamicUpdateFieldFlags[PLAYER_DYNAMIC_END];
GAME_API extern uint32 GameObjectUpdateFieldFlags[GAMEOBJECT_END];
GAME_API extern uint32 GameObjectDynamicUpdateFieldFlags[GAMEOBJECT_DYNAMIC_END];
GAME_API extern uint32 DynamicObjectUpdateFieldFlags[DYNAMICOBJECT_END];
GAME_API extern uint32 CorpseUpdateFieldFlags[CORPSE_END];
GAME_API extern uint32 AreaTriggerUpdateFieldFlags[AREATRIGGER_END];
GAME_API extern uint32 SceneObjectUpdateFieldFlags[SCENEOBJECT_END];
GAME_API extern uint32 ConversationUpdateFieldFlags[CONVERSATION_END];
GAME_API extern uint32 ConversationDynamicUpdateFieldFlags[CONVERSATION_DYNAMIC_END];

#endif // _UPDATEFIELDFLAGS_H
