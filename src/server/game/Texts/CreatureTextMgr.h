/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_CREATURE_TEXT_MGR_H
#define SERVER_CREATURE_TEXT_MGR_H

#include "Common.h"
#include "SharedDefines.h"
#include <map>
#include <unordered_map>
#include <vector>

class Creature;
class Player;
class Unit;
class WorldObject;
class WorldPacket;

enum CreatureTextRange
{
    TEXT_RANGE_NORMAL   = 0,
    TEXT_RANGE_AREA     = 1,
    TEXT_RANGE_ZONE     = 2,
    TEXT_RANGE_MAP      = 3,
    TEXT_RANGE_WORLD    = 4
};

struct CreatureTextEntry
{
    uint32 creatureId;
    uint8 groupId;
    uint8 id;
    std::string text;
    ChatMsg type;
    Language lang;
    float probability;
    Emote emote;
    uint32 duration;
    uint32 sound;
    uint32 BroadcastTextId;
    CreatureTextRange TextRange;
};

struct CreatureTextLocale
{
    std::vector<std::string> Text;
};

struct CreatureTextId
{
    CreatureTextId(uint32 e, uint32 g, uint32 i) : entry(e), textGroup(g), textId(i) { }

    bool operator<(CreatureTextId const& right) const
    {
        return std::tie(entry, textGroup, textId) < std::tie(right.entry, right.textGroup, right.textId);
    }

    uint32 entry;
    uint32 textGroup;
    uint32 textId;
};

typedef std::vector<CreatureTextEntry> CreatureTextGroup;                   // texts in a group
typedef std::unordered_map<uint8, CreatureTextGroup> CreatureTextHolder;    // groups for a creature by groupid
typedef std::unordered_map<uint32, CreatureTextHolder> CreatureTextMap;     // all creatures by entry

typedef std::map<CreatureTextId, CreatureTextLocale> LocaleCreatureTextMap;

class GAME_API CreatureTextMgr
{
    private:
        CreatureTextMgr() { }
        ~CreatureTextMgr() { }

    public:
        static CreatureTextMgr* instance();

        void LoadCreatureTexts();
        void LoadCreatureTextLocales();
        CreatureTextMap const& GetTextMap() const { return mTextMap; }

        static void SendSound(Creature* source, uint32 sound, ChatMsg msgType, WorldObject const* whisperTarget = nullptr, CreatureTextRange range = TEXT_RANGE_NORMAL, Team team = TEAM_OTHER, bool gmOnly = false);
        static void SendEmote(Unit* source, uint32 emote);

        //if sent, returns the 'duration' of the text else 0 if error
        uint32 SendChat(Creature* source, uint8 textGroup, WorldObject const* whisperTarget = nullptr, ChatMsg msgType = CHAT_MSG_ADDON, Language language = LANG_ADDON, CreatureTextRange range = TEXT_RANGE_NORMAL, uint32 sound = 0, Team team = TEAM_OTHER, bool gmOnly = false, Player* srcPlr = nullptr);
        bool TextExist(uint32 sourceEntry, uint8 textGroup) const;
        std::string GetLocalizedChatString(uint32 entry, uint8 gender, uint8 textGroup, uint32 id, LocaleConstant locale) const;

        template<class Builder>
        static void SendChatPacket(WorldObject* source, Builder const& builder, ChatMsg msgType, WorldObject const* whisperTarget = nullptr, CreatureTextRange range = TEXT_RANGE_NORMAL, Team team = TEAM_OTHER, bool gmOnly = false);

    private:
        static void SendNonChatPacket(WorldObject* source, WorldPacket const* data, ChatMsg msgType, WorldObject const* whisperTarget, CreatureTextRange range, Team team, bool gmOnly);
        static float GetRangeForChatType(ChatMsg msgType);

        CreatureTextMap mTextMap;
        LocaleCreatureTextMap mLocaleTextMap;
};

#define sCreatureTextMgr CreatureTextMgr::instance()

#endif
