/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "CharacterTemplateDataStore.h"
#include "DatabaseEnv.h"
#include "DB2Stores.h"
#include "Log.h"
#include "Timer.h"

namespace
{
    CharacterTemplateContainer _characterTemplateStore;
}

void CharacterTemplateDataStore::LoadCharacterTemplates()
{
    uint32 oldMSTime = getMSTime();
    _characterTemplateStore.clear();

    std::unordered_map<uint32, std::vector<CharacterTemplateClass>> characterTemplateClasses;

    if (QueryResult classesResult = WorldDatabase.Query("SELECT TemplateId, FactionGroup, Class FROM character_template_class"))
    {
        do
        {
            Field* fields = classesResult->Fetch();

            uint32 templateId = fields[0].GetUInt32();
            uint8 factionGroup = fields[1].GetUInt8();
            uint8 classID = fields[2].GetUInt8();

            if (!((factionGroup & (FACTION_MASK_PLAYER | FACTION_MASK_ALLIANCE)) == (FACTION_MASK_PLAYER | FACTION_MASK_ALLIANCE)) &&
                !((factionGroup & (FACTION_MASK_PLAYER | FACTION_MASK_HORDE)) == (FACTION_MASK_PLAYER | FACTION_MASK_HORDE)))
            {
                LOG_ERROR("sql.sql", "Faction group %u defined for character template %u in `character_template_class` is invalid. Skipped.", factionGroup, templateId);
                continue;
            }

            ChrClassesEntry const* classEntry = sChrClassesStore.LookupEntry(classID);
            if (!classEntry)
            {
                LOG_ERROR("sql.sql", "Class %u defined for character template %u in `character_template_class` does not exists, skipped.", classID, templateId);
                continue;
            }

            characterTemplateClasses[templateId].emplace_back(factionGroup, classID);
        }
        while (classesResult->NextRow());
    }
    else
    {
        LOG_INFO("server.loading", ">> Loaded 0 character template classes. DB table `character_template_class` is empty.");
    }

    QueryResult templates = WorldDatabase.Query("SELECT Id, Name, Description, Level FROM character_template");
    if (!templates)
    {
        LOG_INFO("server.loading", ">> Loaded 0 character templates. DB table `character_template` is empty.");
        return;
    }

    do
    {
        Field* fields = templates->Fetch();

        CharacterTemplate templ;
        templ.TemplateSetId = fields[0].GetUInt32();
        templ.Name = fields[1].GetString();
        templ.Description = fields[2].GetString();
        templ.Level = fields[3].GetUInt8();
        templ.Classes = std::move(characterTemplateClasses[templ.TemplateSetId]);

        if (templ.Classes.empty())
        {
            LOG_ERROR("sql.sql", "Character template %u does not have any classes defined in `character_template_class`. Skipped.", templ.TemplateSetId);
            continue;
        }

        _characterTemplateStore[templ.TemplateSetId] = templ;
    }
    while (templates->NextRow());

    LOG_INFO("server.loading", ">> Loaded " SZFMTD " character templates in %u ms.", _characterTemplateStore.size(), GetMSTimeDiffToNow(oldMSTime));
}

CharacterTemplateContainer const& CharacterTemplateDataStore::GetCharacterTemplates() const
{
    return _characterTemplateStore;
}

CharacterTemplate const* CharacterTemplateDataStore::GetCharacterTemplate(uint32 templateId) const
{
    auto itr = _characterTemplateStore.find(templateId);
    if (itr != _characterTemplateStore.end())
        return &itr->second;

    return nullptr;
}

CharacterTemplateDataStore* CharacterTemplateDataStore::Instance()
{
    static CharacterTemplateDataStore instance;
    return &instance;
}
