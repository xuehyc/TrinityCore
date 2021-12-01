/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CharacterTemplateDataStore_h__
#define CharacterTemplateDataStore_h__

#include "Define.h"

#include <unordered_map>
#include <vector>
#include <string>

struct CharacterTemplateClass
{
    CharacterTemplateClass(uint8 factionGroup, uint8 classID)
        : FactionGroup(factionGroup), ClassID(classID) { }

    uint8 FactionGroup;
    uint8 ClassID;
};

struct CharacterTemplate
{
    uint32 TemplateSetId;
    std::vector<CharacterTemplateClass> Classes;
    std::string Name;
    std::string Description;
    uint8 Level;
};

typedef std::unordered_map<uint32, CharacterTemplate> CharacterTemplateContainer;

class GAME_API CharacterTemplateDataStore
{
public:
    void LoadCharacterTemplates();

    CharacterTemplateContainer const& GetCharacterTemplates() const;
    CharacterTemplate const* GetCharacterTemplate(uint32 templateId) const;

    static CharacterTemplateDataStore* Instance();
};

#define sCharacterTemplateDataStore CharacterTemplateDataStore::Instance()

#endif // CharacterTemplateDataStore_h__
