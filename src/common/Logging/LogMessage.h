/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef LogMessage_h__
#define LogMessage_h__

#include "Define.h"
#include "LogCommon.h"
#include <string>
#include <ctime>

struct COMMON_API LogMessage
{
    LogMessage(LogLevel _level, std::string const& _type, std::string&& _text);
    LogMessage(LogLevel _level, std::string const& _type, std::string&& _text, std::string&& _param1);

    LogMessage(LogMessage const& /*other*/) = delete;
    LogMessage& operator=(LogMessage const& /*other*/) = delete;

    static std::string getTimeStr(time_t time);
    std::string getTimeStr();

    LogLevel const level;
    std::string const type;
    std::string const text;
    std::string prefix;
    std::string param1;
    time_t mtime;

    ///@ Returns size of the log message content in bytes
    uint32 Size() const
    {
        return static_cast<uint32>(prefix.size() + text.size());
    }
};

#endif // LogMessage_h__
