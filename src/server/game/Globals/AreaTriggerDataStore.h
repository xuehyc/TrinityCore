/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef AreaTriggerDataStore_h__
#define AreaTriggerDataStore_h__

#include "Define.h"

class AreaTriggerTemplate;
class AreaTriggerMiscTemplate;

class GAME_API AreaTriggerDataStore
{
public:
    void LoadAreaTriggerTemplates();

    AreaTriggerTemplate const* GetAreaTriggerTemplate(uint32 areaTriggerId) const;
    AreaTriggerMiscTemplate const* GetAreaTriggerMiscTemplate(uint32 spellMiscValue) const;

    static AreaTriggerDataStore* Instance();
};

#define sAreaTriggerDataStore AreaTriggerDataStore::Instance()

#endif // AreaTriggerDataStore_h__
