/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ConversationDataStore.h"
#include "Containers.h"
#include "DatabaseEnv.h"
#include "DB2Stores.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Timer.h"

namespace
{
    std::unordered_map<uint32, ConversationTemplate>       _conversationTemplateStore;
    std::unordered_map<uint32, ConversationActorTemplate>  _conversationActorTemplateStore;
    std::unordered_map<uint32, ConversationLineTemplate>   _conversationLineTemplateStore;
}

void ConversationDataStore::LoadConversationTemplates()
{
    _conversationActorTemplateStore.clear();
    _conversationLineTemplateStore.clear();
    _conversationTemplateStore.clear();

    std::unordered_map<uint32, std::vector<ConversationActorTemplate const*>> actorsByConversation;
    std::unordered_map<uint32, std::vector<ObjectGuid::LowType>> actorGuidsByConversation;

    if (QueryResult actorTemplates = WorldDatabase.Query("SELECT Id, CreatureId, CreatureModelId FROM conversation_actor_template"))
    {
        uint32 oldMSTime = getMSTime();

        do
        {
            Field* fields = actorTemplates->Fetch();

            uint32 id = fields[0].GetUInt32();
            ConversationActorTemplate& conversationActor = _conversationActorTemplateStore[id];
            conversationActor.Id = id;
            conversationActor.CreatureId = fields[1].GetUInt32();
            conversationActor.CreatureModelId = fields[2].GetUInt32();
        }
        while (actorTemplates->NextRow());

        LOG_INFO("server.loading", ">> Loaded " SZFMTD " Conversation actor templates in %u ms", _conversationActorTemplateStore.size(), GetMSTimeDiffToNow(oldMSTime));
    }
    else
    {
        LOG_INFO("server.loading", ">> Loaded 0 Conversation actor templates. DB table `conversation_actor_template` is empty.");
    }

    if (QueryResult lineTemplates = WorldDatabase.Query("SELECT Id, StartTime, UiCameraID, ActorIdx, Flags FROM conversation_line_template"))
    {
        uint32 oldMSTime = getMSTime();

        do
        {
            Field* fields = lineTemplates->Fetch();

            uint32 id = fields[0].GetUInt32();

            if (!sConversationLineStore.LookupEntry(id))
            {
                LOG_ERROR("sql.sql", "Table `conversation_line_template` has template for non existing ConversationLine (ID: %u), skipped", id);
                continue;
            }

            ConversationLineTemplate& conversationLine = _conversationLineTemplateStore[id];
            conversationLine.Id         = id;
            conversationLine.StartTime  = fields[1].GetUInt32();
            conversationLine.UiCameraID = fields[2].GetUInt32();
            conversationLine.ActorIdx   = fields[3].GetUInt8();
            conversationLine.Flags      = fields[4].GetUInt8();
        }
        while (lineTemplates->NextRow());

        LOG_INFO("server.loading", ">> Loaded " SZFMTD " Conversation line templates in %u ms", _conversationLineTemplateStore.size(), GetMSTimeDiffToNow(oldMSTime));
    }
    else
    {
        LOG_INFO("server.loading", ">> Loaded 0 Conversation line templates. DB table `conversation_line_template` is empty.");
    }

    if (QueryResult actors = WorldDatabase.Query("SELECT ConversationId, ConversationActorId, ConversationActorGuid, Idx FROM conversation_actors"))
    {
        uint32 oldMSTime = getMSTime();
        uint32 count = 0;

        do
        {
            Field* fields = actors->Fetch();

            uint32 conversationId         = fields[0].GetUInt32();
            uint32 actorId                = fields[1].GetUInt32();
            ObjectGuid::LowType actorGuid = fields[2].GetUInt64();
            uint16 idx                    = fields[3].GetUInt16();

            if (actorId != 0 && actorGuid != 0)
            {
                LOG_ERROR("sql.sql", "Table `conversation_actors` references both actor (ID: %u) and actorGuid (GUID: " UI64FMTD ") for Conversation %u, skipped.", actorId, actorGuid, conversationId);
                continue;
            }

            if (actorId != 0)
            {
                if (ConversationActorTemplate const* conversationActorTemplate = Server::Containers::MapGetValuePtr(_conversationActorTemplateStore, actorId))
                {
                    std::vector<ConversationActorTemplate const*>& actors = actorsByConversation[conversationId];
                    if (actors.size() <= idx)
                        actors.resize(idx + 1);
                    actors[idx] = conversationActorTemplate;
                    ++count;
                }
                else
                    LOG_ERROR("sql.sql", "Table `conversation_actors` references an invalid actor (ID: %u) for Conversation %u, skipped", actorId, conversationId);
            }
            else if (actorGuid != 0)
            {
                if (sObjectMgr->GetCreatureData(actorGuid))
                {
                    std::vector<ObjectGuid::LowType>& guids = actorGuidsByConversation[conversationId];
                    if (guids.size() <= idx)
                        guids.resize(idx + 1);
                    guids[idx] = actorGuid;
                    ++count;
                }
                else
                    LOG_ERROR("sql.sql", "Table `conversation_actors` references an invalid creature guid (GUID: " UI64FMTD ") for Conversation %u, skipped", actorGuid, conversationId);
            }
        }
        while (actors->NextRow());

        LOG_INFO("server.loading", ">> Loaded %u Conversation actors in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    }
    else
    {
        LOG_INFO("server.loading", ">> Loaded 0 Conversation actors. DB table `conversation_actors` is empty.");
    }

    if (QueryResult templates = WorldDatabase.Query("SELECT Id, FirstLineId, LastLineEndTime, ScriptName FROM conversation_template"))
    {
        uint32 oldMSTime = getMSTime();

        do
        {
            Field* fields = templates->Fetch();

            ConversationTemplate conversationTemplate;
            conversationTemplate.Id                 = fields[0].GetUInt32();
            conversationTemplate.FirstLineId        = fields[1].GetUInt32();
            conversationTemplate.LastLineEndTime    = fields[2].GetUInt32();
            conversationTemplate.ScriptId           = sObjectMgr->GetScriptId(fields[3].GetString());

            conversationTemplate.Actors = std::move(actorsByConversation[conversationTemplate.Id]);
            conversationTemplate.ActorGuids = std::move(actorGuidsByConversation[conversationTemplate.Id]);

            ConversationLineEntry const* currentConversationLine = sConversationLineStore.LookupEntry(conversationTemplate.FirstLineId);
            if (!currentConversationLine)
                LOG_ERROR("sql.sql", "Table `conversation_template` references an invalid line (ID: %u) for Conversation %u, skipped", conversationTemplate.FirstLineId, conversationTemplate.Id);

            while (currentConversationLine != nullptr)
            {
                if (ConversationLineTemplate const* conversationLineTemplate = Server::Containers::MapGetValuePtr(_conversationLineTemplateStore, currentConversationLine->ID))
                    conversationTemplate.Lines.push_back(conversationLineTemplate);
                else
                    LOG_ERROR("sql.sql", "Table `conversation_line_template` has missing template for line (ID: %u) in Conversation %u, skipped", currentConversationLine->ID, conversationTemplate.Id);

                if (!currentConversationLine->NextConversationLineID)
                    break;

                currentConversationLine = sConversationLineStore.AssertEntry(currentConversationLine->NextConversationLineID);
            }

            _conversationTemplateStore[conversationTemplate.Id] = conversationTemplate;
        }
        while (templates->NextRow());

        LOG_INFO("server.loading", ">> Loaded " SZFMTD " Conversation templates in %u ms", _conversationTemplateStore.size(), GetMSTimeDiffToNow(oldMSTime));
    }
    else
    {
        LOG_INFO("server.loading", ">> Loaded 0 Conversation templates. DB table `conversation_template` is empty.");
    }
}

ConversationTemplate const* ConversationDataStore::GetConversationTemplate(uint32 conversationId) const
{
    return Server::Containers::MapGetValuePtr(_conversationTemplateStore, conversationId);
}

ConversationDataStore* ConversationDataStore::Instance()
{
    static ConversationDataStore instance;
    return &instance;
}
