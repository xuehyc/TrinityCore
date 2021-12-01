/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef LOGGER_H
#define LOGGER_H

#include "Define.h"
#include "LogCommon.h"
#include <unordered_map>
#include <string>

class Appender;
struct LogMessage;

class COMMON_API Logger
{
    public:
        Logger(std::string const& name, LogLevel level);

        void addAppender(uint8 type, Appender* appender);
        void delAppender(uint8 type);

        std::string const& getName() const;
        LogLevel getLogLevel() const;
        void setLogLevel(LogLevel level);
        void write(LogMessage* message) const;

    private:
        std::string name;
        LogLevel level;
        std::unordered_map<uint8, Appender*> appenders;
};

#endif
