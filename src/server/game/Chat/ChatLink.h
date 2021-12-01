/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVERCORE_CHATLINK_H
#define SERVERCORE_CHATLINK_H

#include "SharedDefines.h"
#include "Common.h"
#include <list>
#include <sstream>
#include <vector>
#include <cstring>

struct ItemLocale;
struct ItemTemplate;
struct ItemRandomSuffixEntry;
struct ItemRandomPropertiesEntry;
class SpellInfo;
struct AchievementEntry;
struct GlyphPropertiesEntry;
class Quest;

///////////////////////////////////////////////////////////////////////////////////////////////////
// ChatLink - abstract base class for various links
class GAME_API ChatLink
{
public:
    ChatLink() : _color(0), _startPos(0), _endPos(0) { }
    virtual ~ChatLink() { }
    void SetColor(uint32 color) { _color = color; }
    // This will allow to extract the whole link string from the message, if necessary.
    void SetBounds(std::istringstream::pos_type startPos, std::istringstream::pos_type endPos) { _startPos = startPos; _endPos = endPos; }

    virtual bool Initialize(std::istringstream& iss) = 0;
    virtual bool ValidateName(char* buffer, const char* context) = 0;

protected:
    uint32 _color;
    std::string _name;
    std::istringstream::pos_type _startPos;
    std::istringstream::pos_type _endPos;
};

// ItemChatLink - link to item
class GAME_API ItemChatLink : public ChatLink
{
public:
    ItemChatLink() : ChatLink(), _item(nullptr), _enchantId(0), _randomPropertyId(0), _randomPropertySeed(0), _reporterLevel(0), _reporterSpec(0), _context(0),
        _suffix(nullptr), _property(nullptr)
    {
        memset(_gemItemId, 0, sizeof(_gemItemId));
    }
    virtual bool Initialize(std::istringstream& iss) override;
    virtual bool ValidateName(char* buffer, const char* context) override;

protected:
    std::string FormatName(uint8 index, LocalizedString* suffixStrings) const;
    bool HasValue(std::istringstream& iss) const;

    ItemTemplate const* _item;
    int32 _enchantId;
    int32 _gemItemId[3];
    int32 _randomPropertyId;
    int32 _randomPropertySeed;
    int32 _reporterLevel;
    int32 _reporterSpec;
    int32 _context;
    std::vector<int32> _bonusListIDs;
    std::vector<std::pair<uint32, int32>> _modifiers;
    std::vector<int32> _gemBonusListIDs[3];
    ItemRandomSuffixEntry const* _suffix;
    ItemRandomPropertiesEntry const* _property;
};

// QuestChatLink - link to quest
class GAME_API QuestChatLink : public ChatLink
{
public:
    QuestChatLink() : ChatLink(), _quest(nullptr), _questLevel(0) { }
    virtual bool Initialize(std::istringstream& iss) override;
    virtual bool ValidateName(char* buffer, const char* context) override;

protected:
    Quest const* _quest;
    int32 _questLevel;
};

// SpellChatLink - link to quest
class GAME_API SpellChatLink : public ChatLink
{
public:
    SpellChatLink() : ChatLink(), _spell(nullptr) { }
    virtual bool Initialize(std::istringstream& iss) override;
    virtual bool ValidateName(char* buffer, const char* context) override;

protected:
    SpellInfo const* _spell;
};

// AchievementChatLink - link to quest
class GAME_API AchievementChatLink : public ChatLink
{
public:
    AchievementChatLink() : ChatLink(), _guid(0), _achievement(NULL)
    {
        memset(_data, 0, sizeof(_data));
    }
    virtual bool Initialize(std::istringstream& iss) override;
    virtual bool ValidateName(char* buffer, const char* context) override;

protected:
    uint32 _guid;
    AchievementEntry const* _achievement;
    uint32 _data[8];
};

// TradeChatLink - link to trade info
class GAME_API TradeChatLink : public SpellChatLink
{
public:
    TradeChatLink() : SpellChatLink(), _minSkillLevel(0), _maxSkillLevel(0), _guid(0) { }
    virtual bool Initialize(std::istringstream& iss) override;
private:
    int32 _minSkillLevel;
    int32 _maxSkillLevel;
    uint32 _guid;
    std::string _base64;
};

// TalentChatLink - link to talent
class GAME_API TalentChatLink : public SpellChatLink
{
public:
    TalentChatLink() : SpellChatLink(), _talentId(0), _rankId(0) { }
    virtual bool Initialize(std::istringstream& iss) override;

private:
    uint32 _talentId;
    int32 _rankId;
};

// EnchantmentChatLink - link to enchantment
class GAME_API EnchantmentChatLink : public SpellChatLink
{
public:
    EnchantmentChatLink() : SpellChatLink() { }
    virtual bool Initialize(std::istringstream& iss) override;
};

// GlyphChatLink - link to glyph
class GAME_API GlyphChatLink : public SpellChatLink
{
public:
    GlyphChatLink() : SpellChatLink(), _slotId(0), _glyph(NULL) { }
    virtual bool Initialize(std::istringstream& iss) override;
private:
    uint32 _slotId;
    GlyphPropertiesEntry const* _glyph;
};

class GAME_API LinkExtractor
{
public:
    explicit LinkExtractor(const char* msg);
    ~LinkExtractor();

    bool IsValidMessage();

private:
    typedef std::list<ChatLink*> Links;
    Links _links;
    std::istringstream _iss;
};


#endif // SERVERCORE_CHATLINK_H
