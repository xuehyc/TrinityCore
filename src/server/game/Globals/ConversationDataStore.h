/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ConversationDataStore_h__
#define ConversationDataStore_h__

#include "Define.h"
#include "ObjectGuid.h"

#include <vector>

enum ConversationLineFlags
{
    CONVERSATION_LINE_FLAG_NOTIFY_STARTED = 0x1 // Client will send CMSG_CONVERSATION_LINE_STARTED when it runs this line
};

#pragma pack(push, 1)
struct ConversationActorTemplate
{
    uint32 Id;
    uint32 CreatureId;
    uint32 CreatureModelId;
};

struct ConversationLineTemplate
{
    uint32 Id;          // Link to ConversationLine.db2
    uint32 StartTime;   // Time in ms after conversation creation the line is displayed
    uint32 UiCameraID;  // Link to UiCamera.db2
    uint8 ActorIdx;     // Index from conversation_actors
    uint8 Flags;
    uint16 Padding;
};
#pragma pack(pop)

struct ConversationTemplate
{
    uint32 Id;
    uint32 FirstLineId;     // Link to ConversationLine.db2
    uint32 LastLineEndTime; // Time in ms after conversation creation the last line fades out

    std::vector<ConversationActorTemplate const*> Actors;
    std::vector<ObjectGuid::LowType> ActorGuids;
    std::vector<ConversationLineTemplate const*> Lines;

    uint32 ScriptId;
};

class GAME_API ConversationDataStore
{
public:
    void LoadConversationTemplates();

    ConversationTemplate const* GetConversationTemplate(uint32 conversationId) const;

    static ConversationDataStore* Instance();
};

#define sConversationDataStore ConversationDataStore::Instance()

#endif // ConversationDataStore_h__
