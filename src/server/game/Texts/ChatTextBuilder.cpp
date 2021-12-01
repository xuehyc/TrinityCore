/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ChatTextBuilder.h"
#include "ChatPackets.h"
#include "DB2Stores.h"
#include "ObjectMgr.h"
#include <cstdarg>

WorldPackets::Packet* Server::BroadcastTextBuilder::operator()(LocaleConstant locale) const
{
    BroadcastTextEntry const* bct = sBroadcastTextStore.LookupEntry(_textId);
    WorldPackets::Chat::Chat* chat = new WorldPackets::Chat::Chat();
    chat->Initialize(_msgType, bct ? Language(bct->LanguageID) : LANG_UNIVERSAL, _source, _target, bct ? DB2Manager::GetBroadcastTextValue(bct, locale, _gender) : "", _achievementId, "", locale);
    return chat;
}

WorldPackets::Packet* Server::CustomChatTextBuilder::operator()(LocaleConstant locale) const
{
    WorldPackets::Chat::Chat* chat = new WorldPackets::Chat::Chat();
    chat->Initialize(_msgType, _language, _source, _target, _text, 0, "", locale);
    return chat;
}

WorldPackets::Packet* Server::ServerStringChatBuilder::operator()(LocaleConstant locale) const
{
    WorldPackets::Chat::Chat* packet = new WorldPackets::Chat::Chat();

    char const* text = sObjectMgr->GetServerString(_textId, locale);

    if (_args)
    {
        // we need copy va_list before use or original va_list will corrupted
        va_list ap;
        va_copy(ap, *_args);

        static size_t const BufferSize = 2048;
        char strBuffer[BufferSize];
        vsnprintf(strBuffer, BufferSize, text, ap);
        va_end(ap);

        packet->Initialize(_msgType, LANG_UNIVERSAL, _source, _target, strBuffer, 0, "", locale);
    }
    else
        packet->Initialize(_msgType, LANG_UNIVERSAL, _source, _target, text, 0, "", locale);

    return packet;
}
