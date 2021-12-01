/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef __CHATTEXT_BUILDER_H
#define __CHATTEXT_BUILDER_H

#include "Common.h"
#include "SharedDefines.h"
#include <string>

class WorldObject;

namespace WorldPackets
{
    class Packet;
}

namespace Server
{
    class BroadcastTextBuilder
    {
        public:
            BroadcastTextBuilder(WorldObject const* obj, ChatMsg msgType, uint32 textId, uint8 gender, WorldObject const* target = nullptr, uint32 achievementId = 0)
                : _source(obj), _msgType(msgType), _textId(textId), _gender(gender), _target(target), _achievementId(achievementId) { }

            WorldPackets::Packet* operator()(LocaleConstant locale) const;

        private:
            WorldObject const* _source;
            ChatMsg _msgType;
            uint32 _textId;
            uint8 _gender;
            WorldObject const* _target;
            uint32 _achievementId;
    };

    class CustomChatTextBuilder
    {
        public:
            CustomChatTextBuilder(WorldObject const* obj, ChatMsg msgType, std::string const& text, Language language = LANG_UNIVERSAL, WorldObject const* target = nullptr)
                : _source(obj), _msgType(msgType), _text(text), _language(language), _target(target) { }

            WorldPackets::Packet* operator()(LocaleConstant locale) const;

        private:
            WorldObject const* _source;
            ChatMsg _msgType;
            std::string _text;
            Language _language;
            WorldObject const* _target;
    };

    class ServerStringChatBuilder
    {
        public:
            ServerStringChatBuilder(WorldObject const* obj, ChatMsg msgType, uint32 textId, WorldObject const* target = nullptr, va_list* args = nullptr)
                : _source(obj), _msgType(msgType), _textId(textId), _target(target), _args(args) { }

            WorldPackets::Packet* operator()(LocaleConstant locale) const;

        private:
            WorldObject const* _source;
            ChatMsg _msgType;
            uint32 _textId;
            WorldObject const* _target;
            va_list* _args;
    };
}
// namespace Server

#endif // __CHATTEXT_BUILDER_H
