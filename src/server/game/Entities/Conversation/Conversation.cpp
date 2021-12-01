/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "Conversation.h"
#include "Creature.h"
#include "IteratorPair.h"
#include "Log.h"
#include "Map.h"
#include "PhasingHandler.h"
#include "ScriptMgr.h"
#include "Unit.h"
#include "UpdateData.h"

Conversation::Conversation() : WorldObject(false), _duration(0)
{
    m_objectType |= TYPEMASK_CONVERSATION;
    m_objectTypeId = TYPEID_CONVERSATION;

    m_updateFlag = UPDATEFLAG_STATIONARY_POSITION;

    m_valuesCount = CONVERSATION_END;
    _dynamicValuesCount = CONVERSATION_DYNAMIC_END;
}

Conversation::~Conversation()
{
}

void Conversation::AddToWorld()
{
    ///- Register the Conversation for guid lookup and for caster
    if (!IsInWorld())
    {
        GetMap()->GetObjectsStore().Insert<Conversation>(GetGUID(), this);
        WorldObject::AddToWorld();
    }
}

void Conversation::RemoveFromWorld()
{
    ///- Remove the Conversation from the accessor and from all lists of objects in world
    if (IsInWorld())
    {
        WorldObject::RemoveFromWorld();
        GetMap()->GetObjectsStore().Remove<Conversation>(GetGUID());
    }
}

bool Conversation::IsNeverVisibleFor(WorldObject const* seer) const
{
    if (_participants.find(seer->GetGUID()) == _participants.end())
        return true;

    return WorldObject::IsNeverVisibleFor(seer);
}

void Conversation::Update(uint32 diff)
{
    if (GetDuration() > int32(diff))
        _duration -= diff;
    else
        Remove(); // expired

    WorldObject::Update(diff);
}

void Conversation::Remove()
{
    if (IsInWorld())
    {
        AddObjectToRemoveList(); // calls RemoveFromWorld
    }
}

Conversation* Conversation::CreateConversation(uint32 conversationEntry, Unit* creator, Position const& pos, GuidUnorderedSet&& participants, SpellInfo const* spellInfo /*= nullptr*/)
{
    ConversationTemplate const* conversationTemplate = sConversationDataStore->GetConversationTemplate(conversationEntry);
    if (!conversationTemplate)
        return nullptr;

    ObjectGuid::LowType lowGuid = creator->GetMap()->GenerateLowGuid<HighGuid::Conversation>();

    Conversation* conversation = new Conversation();
    if (!conversation->Create(lowGuid, conversationEntry, creator->GetMap(), creator, pos, std::move(participants), spellInfo))
    {
        delete conversation;
        return nullptr;
    }

    return conversation;
}

bool Conversation::Create(ObjectGuid::LowType lowGuid, uint32 conversationEntry, Map* map, Unit* creator, Position const& pos, GuidUnorderedSet&& participants, SpellInfo const* /*spellInfo = nullptr*/)
{
    ConversationTemplate const* conversationTemplate = sConversationDataStore->GetConversationTemplate(conversationEntry);
    ASSERT(conversationTemplate);

    _creatorGuid = creator->GetGUID();
    _participants = std::move(participants);

    SetMap(map);
    Relocate(pos);

    Object::_Create(ObjectGuid::Create<HighGuid::Conversation>(GetMapId(), conversationEntry, lowGuid));
    PhasingHandler::InheritPhaseShift(this, creator);

    SetEntry(conversationEntry);
    SetObjectScale(1.0f);

    SetUInt32Value(CONVERSATION_LAST_LINE_END_TIME, conversationTemplate->LastLineEndTime);
    _duration = conversationTemplate->LastLineEndTime;

    for (uint16 actorIndex = 0; actorIndex < conversationTemplate->Actors.size(); ++actorIndex)
    {
        if (ConversationActorTemplate const* actor = conversationTemplate->Actors[actorIndex])
        {
            ConversationDynamicFieldActor actorField;
            actorField.ActorTemplate = *actor;
            actorField.Type = ConversationDynamicFieldActor::ActorType::CreatureActor;
            SetDynamicStructuredValue(CONVERSATION_DYNAMIC_FIELD_ACTORS, actorIndex, &actorField);
        }
    }

    for (uint16 actorIndex = 0; actorIndex < conversationTemplate->ActorGuids.size(); ++actorIndex)
    {
        ObjectGuid::LowType const& actorGuid = conversationTemplate->ActorGuids[actorIndex];
        if (!actorGuid)
            continue;

        for (auto const& pair : Server::Containers::MapEqualRange(map->GetCreatureBySpawnIdStore(), actorGuid))
        {
            // we just need the last one, overriding is legit
            AddActor(pair.second->GetGUID(), actorIndex);
        }
    }

    std::set<uint16> actorIndices;
    for (ConversationLineTemplate const* line : conversationTemplate->Lines)
    {
        actorIndices.insert(line->ActorIdx);
        AddDynamicStructuredValue(CONVERSATION_DYNAMIC_FIELD_LINES, line);
    }

    sScriptMgr->OnConversationCreate(this, creator);

    // All actors need to be set
    for (uint16 actorIndex : actorIndices)
    {
        ConversationDynamicFieldActor const* actor = GetDynamicStructuredValue<ConversationDynamicFieldActor>(CONVERSATION_DYNAMIC_FIELD_ACTORS, actorIndex);
        if (!actor || actor->IsEmpty())
        {
            LOG_ERROR("entities.conversation", "Failed to create conversation (Id: %u) due to missing actor (Idx: %u).", conversationEntry, actorIndex);
            return false;
        }
    }

    if (!GetMap()->AddToMap(this))
        return false;

    return true;
}

void Conversation::AddActor(ObjectGuid const& actorGuid, uint16 actorIdx)
{
    ConversationDynamicFieldActor actorField;
    actorField.ActorGuid = actorGuid;
    actorField.Type = ConversationDynamicFieldActor::ActorType::WorldObjectActor;
    SetDynamicStructuredValue(CONVERSATION_DYNAMIC_FIELD_ACTORS, actorIdx, &actorField);
}

void Conversation::AddParticipant(ObjectGuid const& participantGuid)
{
    _participants.insert(participantGuid);
}

uint32 Conversation::GetScriptId() const
{
    return sConversationDataStore->GetConversationTemplate(GetEntry())->ScriptId;
}
