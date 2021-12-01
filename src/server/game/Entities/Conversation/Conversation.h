/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVERCORE_CONVERSATION_H
#define SERVERCORE_CONVERSATION_H

#include "Object.h"
#include "ConversationDataStore.h"
#include <cstring>

class Unit;
class SpellInfo;

#pragma pack(push, 1)
struct ConversationDynamicFieldActor
{
    ConversationDynamicFieldActor() : Type(0), Padding(0)
    {
        memset(Raw.Data, 0, sizeof(Raw.Data));
    }

    bool IsEmpty() const
    {
        return ActorGuid.IsEmpty(); // this one is good enough
    }

    enum ActorType
    {
        WorldObjectActor = 0,
        CreatureActor = 1
    };

    union
    {
        ObjectGuid ActorGuid;

        ConversationActorTemplate ActorTemplate;

        struct
        {
            uint32 Data[4];
        } Raw;
    };

    uint32 Type;
    uint32 Padding;
};
#pragma pack(pop)

class GAME_API Conversation : public WorldObject, public GridObject<Conversation>
{
    public:
        Conversation();
        ~Conversation();

        void AddToWorld() override;
        void RemoveFromWorld() override;

        bool IsNeverVisibleFor(WorldObject const* seer) const override;

        void Update(uint32 diff) override;
        void Remove();
        int32 GetDuration() const { return _duration; }

        static Conversation* CreateConversation(uint32 conversationEntry, Unit* creator, Position const& pos, GuidUnorderedSet&& participants, SpellInfo const* spellInfo = nullptr);
        bool Create(ObjectGuid::LowType lowGuid, uint32 conversationEntry, Map* map, Unit* creator, Position const& pos, GuidUnorderedSet&& participants, SpellInfo const* spellInfo = nullptr);
        void AddActor(ObjectGuid const& actorGuid, uint16 actorIdx);
        void AddParticipant(ObjectGuid const& participantGuid);

        ObjectGuid const& GetCreatorGuid() const { return _creatorGuid; }

        float GetStationaryX() const override { return _stationaryPosition.GetPositionX(); }
        float GetStationaryY() const override { return _stationaryPosition.GetPositionY(); }
        float GetStationaryZ() const override { return _stationaryPosition.GetPositionZ(); }
        float GetStationaryO() const override { return _stationaryPosition.GetOrientation(); }
        void RelocateStationaryPosition(Position const& pos) { _stationaryPosition.Relocate(pos); }

        uint32 GetScriptId() const;

    private:
        Position _stationaryPosition;
        ObjectGuid _creatorGuid;
        uint32 _duration;
        GuidUnorderedSet _participants;
};

#endif // SERVERCORE_CONVERSATION_H
