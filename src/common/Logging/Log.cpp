/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Log.h"
#include "Config.h"
#include "Util.h"
#include "StringConvert.h"
#include "Poco/FormattingChannel.h"
#include "Poco/PatternFormatter.h"
#include "Poco/SplitterChannel.h"
#include "Poco/FileChannel.h"
#include "Poco/Logger.h"
#include "Poco/AutoPtr.h"
#include <sstream>
#include <boost/filesystem.hpp>

#if WARHEAD_PLATFORM == WARHEAD_PLATFORM_WINDOWS
#include "Poco/WindowsConsoleChannel.h"
#define CONSOLE_CHANNEL WindowsColorConsoleChannel
#else
#include "Poco/ConsoleChannel.h"
#define CONSOLE_CHANNEL ColorConsoleChannel
#endif

using namespace Poco;

Log::Log()
{
    Clear();
    InitSystemLogger();
}

Log::~Log()
{
    Clear();
}

Log* Log::instance()
{
    static Log instance;
    return &instance;
}

void Log::Clear()
{
    // Clear all loggers
    Logger::shutdown();

    ClearnAllChannels();
    _CONSOLE_CHANNEL = "";
}

void Log::Initialize()
{
    LoadFromConfig();
}

void Log::LoadFromConfig()
{
    Clear();
    InitSystemLogger();
    InitLogsDir();
    ReadChannelsFromConfig();
    ReadLoggersFromConfig();
}

void Log::InitSystemLogger()
{
    // Start console channel
    AutoPtr<PatternFormatter> _ConsolePattern(new PatternFormatter);

#define LOG_CATCH \
        catch (const std::exception& e) \
        { \
            printf("Log::InitSystemLogger - %s\n", e.what()); \
        } \

    try
    {
        _ConsolePattern->setProperty("pattern", "%t");
        _ConsolePattern->setProperty("times", "local");
    }
    LOG_CATCH

    AutoPtr<CONSOLE_CHANNEL> _ConsoleChannel(new CONSOLE_CHANNEL);

    try
    {
        _ConsoleChannel->setProperty("informationColor", "cyan");
    }
    LOG_CATCH

    // Start file channel
    AutoPtr<FileChannel> _FileChannel(new FileChannel);

    try
    {
        _FileChannel->setProperty("path", "System.log");
        _FileChannel->setProperty("times", "local");
        _FileChannel->setProperty("flush", "false");
    }
    LOG_CATCH

    AutoPtr<PatternFormatter> _FilePattern(new PatternFormatter);

    try
    {
        _FilePattern->setProperty("pattern", "%Y-%m-%d %H:%M:%S %t");
        _FilePattern->setProperty("times", "local");
    }
    LOG_CATCH

    AutoPtr<SplitterChannel> _split(new SplitterChannel);

    try
    {
        _split->addChannel(new FormattingChannel(_ConsolePattern, _ConsoleChannel));
        _split->addChannel(new FormattingChannel(_FilePattern, _FileChannel));
    }
    LOG_CATCH

    try
    {
        Logger::create(LOGGER_SYSTEM, _split, 6);
    }
    LOG_CATCH

#undef LOG_CATCH
}

void Log::InitLogsDir()
{
    m_logsDir = sConfigMgr->GetStringDefault("LogsDir", "");

    if (!m_logsDir.empty())
        if ((m_logsDir.at(m_logsDir.length() - 1) != '/') && (m_logsDir.at(m_logsDir.length() - 1) != '\\'))
            m_logsDir.push_back('/');

    boost::filesystem::path LogsPath(m_logsDir);
    if (!boost::filesystem::is_directory(LogsPath))
        m_logsDir = "";
}

void Log::ReadLoggersFromConfig()
{
    auto const& keys = sConfigMgr->GetKeysByString(PREFIX_LOGGER);
    if (!keys.size())
    {
        SYS_LOG_ERROR("Log::ReadLoggersFromConfig - Not found loggers, change config file!");
        return;
    }

    for (auto const& loggerName : keys)
        CreateLoggerFromConfig(loggerName);

    if (!Logger::has(LOGGER_ROOT))
        SYS_LOG_ERROR("Log::ReadLoggersFromConfig - Logger '%s' not found!\nPlease change or add 'Logger.%s' option in config file!\n", LOGGER_ROOT.c_str(), LOGGER_ROOT.c_str());
}

void Log::ReadChannelsFromConfig()
{
    auto const& keys = sConfigMgr->GetKeysByString(PREFIX_CHANNEL);
    if (!keys.size())
    {
        SYS_LOG_ERROR("Log::ReadChannelsFromConfig - Not found channels, change config file!");
        return;
    }

    for (auto const& channelName : keys)
        CreateChannelsFromConfig(channelName);
}

std::string Log::GetPositionOptions(std::string Options, uint8 Position, std::string const& Default /*= ""*/)
{
    auto const& tokens = Warhead::Tokenize(Options, ',', true);
    if (tokens.size() < Position + 1)
        return Default;

    return std::string(tokens[Position]);
}

std::string const Log::GetLoggerByType(std::string const& type) const
{
    if (Logger::has(type))
        return type;

    if (type == LOGGER_ROOT)
        return LOGGER_ROOT;

    std::string parentLogger = LOGGER_ROOT;
    size_t found = type.find_last_of('.');

    if (found != std::string::npos)
        parentLogger = type.substr(0, found);

    return GetLoggerByType(parentLogger);
}

bool Log::ShouldLog(std::string const& type, LogLevel level) const
{
    if (GetLoggerByType(type) == LOGGER_ROOT)
        return false;

    return Logger::get(type).getLevel() >= level;
}

std::string Log::GetDynamicFileName(std::string ChannelName, std::string Arg)
{
    if (ChannelName.empty())
        return "";

    char namebuf[WARHEAD_PATH_MAX];
    snprintf(namebuf, WARHEAD_PATH_MAX, GetPositionOptions(sConfigMgr->GetStringDefault(PREFIX_CHANNEL + ChannelName, ""), 3).c_str(), Arg.c_str());

    return namebuf;
}

FormattingChannel* Log::GetFileChannel(std::string const& ChannelName)
{
    auto const& itr = _ChannelMapFiles.find(ChannelName);
    if (itr != _ChannelMapFiles.end())
        return  _ChannelMapFiles[ChannelName];

    return nullptr;
}

FormattingChannel* Log::GetConsoleChannel()
{
    auto const& itr = _ChannelMapConsole.find(_CONSOLE_CHANNEL);
    if (itr != _ChannelMapConsole.end())
        return _ChannelMapConsole[_CONSOLE_CHANNEL];

    return nullptr;
}

void Log::AddConsoleChannel(std::string ChannelName, FormattingChannel* channel)
{
    if (_ChannelMapConsole.count(ChannelName))
        return;

    _CONSOLE_CHANNEL = ChannelName;

    _ChannelMapConsole[ChannelName] = channel;
}

void Log::AddFileChannel(std::string ChannelName, FormattingChannel* channel)
{
    auto const& itr = _ChannelMapFiles.find(ChannelName);
    if (itr != _ChannelMapFiles.end())
        return;

    _ChannelMapFiles[ChannelName] = channel;
}

void Log::ClearnAllChannels()
{
    _ChannelMapFiles.clear();
    _ChannelMapConsole.clear();
}

std::string const Log::GetChannelFromLogger(std::string LoggerName)
{
    std::string LoggerOption = sConfigMgr->GetStringDefault(PREFIX_LOGGER + LoggerName, "6,Server");

    auto const& tokens = Warhead::Tokenize(LoggerOption, ',', true);

    if (tokens.size())
        return std::string(tokens[LOGGER_OPTIONS_CHANNEL_NAME]);

    return "";
}

void Log::CreateLogger(std::string Name, LogLevel level, std::string FileChannelName)
{
    AutoPtr<SplitterChannel> _Channel(new SplitterChannel);

    // Add console channel (default)
    _Channel->addChannel(GetConsoleChannel());

    // Add file channel if exist
    if (GetFileChannel(FileChannelName))
        _Channel->addChannel(GetFileChannel(FileChannelName));

    try
    {
        Logger::create(Name, _Channel, (uint8)level);
    }
    catch (const std::exception& e)
    {
        SYS_LOG_ERROR("Log::CreateLogger - %s", e.what());
    }
}

void Log::CreateLoggerFromConfig(std::string const& ConfigLoggerName)
{
    if (ConfigLoggerName.empty())
        return;

    std::string options = sConfigMgr->GetStringDefault(ConfigLoggerName, "");
    std::string LoggerName = ConfigLoggerName.substr(PREFIX_LOGGER.length());

    if (LoggerName == LOGGER_SYSTEM || LoggerName == LOGGER_GM_DYNAMIC)
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Is is forbidden to use logger name %s\n", LoggerName.c_str());
        return;
    }

    // Check dymamic GM logger
    if (LoggerName == LOGGER_GM && !GetFileChannel(GetChannelFromLogger(LOGGER_GM)))
        return;

    if (options.empty())
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Missing config option Logger.%s\n", LoggerName.c_str());
        return;
    }

    auto const& tokens = Warhead::Tokenize(options, ',', true);
    if (!tokens.size() || tokens.size() > LOGGER_OPTIONS_CHANNEL_NAME + 1)
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Bad config options for Logger (%s)", LoggerName.c_str());
        return;
    }

    LogLevel level = LogLevel(Warhead::StringTo<uint8>(GetPositionOptions(options, LOGGER_OPTIONS_LOG_LEVEL)).value_or(LOG_LEVEL_MAX));
    if (level >= LOG_LEVEL_MAX)
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Wrong Log Level for logger %s", LoggerName.c_str());
        return;
    }

    auto FileChannel = GetPositionOptions(options, LOGGER_OPTIONS_CHANNEL_NAME);

    // Check file channel
    if (!GetFileChannel(FileChannel))
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig - Not found file channel '%s'", std::string(FileChannel).c_str());
        return;
    }

    CreateLogger(LoggerName, level, std::string(FileChannel));
}

void Log::CreateChannelsFromConfig(std::string const& LogChannelName)
{
    if (LogChannelName.empty())
        return;

    std::string options = sConfigMgr->GetStringDefault(LogChannelName, "");
    std::string ChannelName = LogChannelName.substr(PREFIX_CHANNEL.length());

    if (options.empty())
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Missing config option LogChannel.%s", ChannelName.c_str());
        return;
    }

    auto const& tokens = Warhead::Tokenize(options, ',', true);
    if (tokens.size() < CHANNEL_OPTIONS_PATTERN + 1)
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Wrong config option (< CHANNEL_OPTIONS_PATTERN) LogChannel.%s=%s\n", ChannelName.c_str(), options.c_str());
        return;
    }

    if (tokens.size() > CHANNEL_OPTIONS_OPTION_5 + 1)
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Wrong config option (> CHANNEL_OPTIONS_OPTION_5) LogChannel.%s=%s\n", ChannelName.c_str(), options.c_str());
        return;
    }

    uint8 ChannelType = atoi(GetPositionOptions(options, CHANNEL_OPTIONS_TYPE).c_str());
    if (ChannelType > CHANNEL_OPTIONS_TYPE_FILE)
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Wrong channel type for LogChannel.%s\n", ChannelName.c_str());
        return;
    }

    std::string Times = GetPositionOptions(options, CHANNEL_OPTIONS_TIMES);
    if (Times.empty())
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Empty times for LogChannel.%s", ChannelName.c_str());
        return;
    }

    std::string Pattern = GetPositionOptions(options, CHANNEL_OPTIONS_PATTERN);
    if (Pattern.empty())
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: Empty pattern for LogChannel.%s", ChannelName.c_str());
        return;
    }

    // Start configuration pattern channel
    AutoPtr<PatternFormatter> _pattern(new PatternFormatter);

    try
    {
        _pattern->setProperty("pattern", Pattern);
        _pattern->setProperty("times", Times);
    }
    catch (const std::exception& e)
    {
        SYS_LOG_ERROR("Log::CreateLoggerFromConfig: %s\n", e.what());
    }

    if (ChannelType == CHANNEL_OPTIONS_TYPE_CONSOLE)
    {
        // Configuration console channel
        AutoPtr<CONSOLE_CHANNEL> _channel(new CONSOLE_CHANNEL);

        // Init Colors
        std::string const& colorOptions = GetPositionOptions(options, CHANNEL_OPTIONS_OPTION_1);

        if (!colorOptions.empty())
        {
            auto const& tokens = Warhead::Tokenize(colorOptions, ' ', true);
            if (tokens.size() == 8)
            {
                try
                {
                    _channel->setProperty("fatalColor", std::string(tokens[0]));
                    _channel->setProperty("criticalColor", std::string(tokens[1]));
                    _channel->setProperty("errorColor", std::string(tokens[2]));
                    _channel->setProperty("warningColor", std::string(tokens[3]));
                    _channel->setProperty("noticeColor", std::string(tokens[4]));
                    _channel->setProperty("informationColor", std::string(tokens[5]));
                    _channel->setProperty("debugColor", std::string(tokens[6]));
                    _channel->setProperty("traceColor", std::string(tokens[7]));
                }
                catch (const std::exception& e)
                {
                    printf("Log::CreateLoggerFromConfig: %s\n\n", e.what());
                }
            }
            else
                _channel->setProperty("enableColors", "false");
        }
        else
            _channel->setProperty("enableColors", "false");

        if (!_CONSOLE_CHANNEL.empty())
        {
            SYS_LOG_ERROR("Log::CreateLoggerFromConfig: _CONSOLE_CHANNEL is no empty!");
            return;
        }

        AddConsoleChannel(ChannelName, new FormattingChannel(_pattern, _channel));
    }
    else if (ChannelType == CHANNEL_OPTIONS_TYPE_FILE)
    {
        if (tokens.size() < CHANNEL_OPTIONS_OPTION_1 + 1)
        {
            SYS_LOG_ERROR("Bad file name for LogChannel.%s", ChannelName.c_str());
            ABORT();
        }

        std::string FileName = GetPositionOptions(options, CHANNEL_OPTIONS_OPTION_1);

        // If dynamic file name - no need create file channel
        if (FileName.find("%s") != std::string::npos)
            return;

        std::string RotateOnOpen = GetPositionOptions(options, CHANNEL_OPTIONS_OPTION_2, "false");
        std::string Rotation = GetPositionOptions(options, CHANNEL_OPTIONS_OPTION_3, "daily");
        std::string Flush = GetPositionOptions(options, CHANNEL_OPTIONS_OPTION_4, "false");
        std::string Archive = GetPositionOptions(options, CHANNEL_OPTIONS_OPTION_5);

        // Configuration file channel
        AutoPtr<FileChannel> _channel(new FileChannel);

        try
        {
            _channel->setProperty("path", m_logsDir + FileName);
            _channel->setProperty("times", Times);

            if (!RotateOnOpen.empty())
                _channel->setProperty("rotateOnOpen", RotateOnOpen);

            if (!Rotation.empty())
                _channel->setProperty("rotation", Rotation);

            if (!Flush.empty())
                _channel->setProperty("flush", Flush);

            if (!Archive.empty())
                _channel->setProperty("archive", Archive);
        }
        catch (const std::exception& e)
        {
            SYS_LOG_ERROR("Log::CreateLoggerFromConfig: %s\n", e.what());
        }

        AddFileChannel(ChannelName, new FormattingChannel(_pattern, _channel));
    }
}

void Log::_Write(std::string const& filter, LogLevel const level, std::string const& message)
{
    if (!Logger::has(filter))
        return;

    Logger& logger = Logger::get(filter);

    try
    {
        switch (level)
        {
        case LOG_LEVEL_FATAL:
            logger.fatal(message);
            break;
        case LOG_LEVEL_CRITICAL:
            logger.critical(message);
            break;
        case LOG_LEVEL_ERROR:
            logger.error(message);
            break;
        case LOG_LEVEL_WARNING:
            logger.warning(message);
            break;
        case LOG_LEVEL_NOTICE:
            logger.notice(message);
            break;
        case LOG_LEVEL_INFO:
            logger.information(message);
            break;
        case LOG_LEVEL_DEBUG:
            logger.debug(message);
            break;
        case LOG_LEVEL_TRACE:
            logger.trace(message);
            break;
        default:
            break;
        }
    }
    catch (const std::exception& e)
    {
        SYS_LOG_ERROR("Log::_Write - %s", e.what());
    }
}

void Log::_writeCommand(std::string const message, std::string const accountid)
{
    std::string GMChannelName = GetChannelFromLogger(LOGGER_GM);

    // If dynamic file for GM commands
    if (!GetFileChannel(GMChannelName))
    {
        std::string LoggerOption = sConfigMgr->GetStringDefault(PREFIX_CHANNEL + GMChannelName, "");
        if (LoggerOption.empty())
            return;

        auto const& tokens = Warhead::Tokenize(LoggerOption, ',', true);
        if (tokens.size() < LOGGER_OPTIONS_CHANNEL_NAME + 1)
            return;

        // Get options
        std::string Times = GetPositionOptions(LoggerOption, CHANNEL_OPTIONS_TIMES);
        std::string Pattern = GetPositionOptions(LoggerOption, CHANNEL_OPTIONS_PATTERN);
        std::string RotateOnOpen = GetPositionOptions(LoggerOption, CHANNEL_OPTIONS_OPTION_2, "false");
        std::string Rotation = GetPositionOptions(LoggerOption, CHANNEL_OPTIONS_OPTION_3, "daily");
        std::string Flush = GetPositionOptions(LoggerOption, CHANNEL_OPTIONS_OPTION_4, "false");
        std::string Archive = GetPositionOptions(LoggerOption, CHANNEL_OPTIONS_OPTION_5);

        // Get filename
        std::string DynamicFileName = GetDynamicFileName(GMChannelName, accountid);

        // Configuration pattern channel
        AutoPtr<PatternFormatter> _pattern(new PatternFormatter);

        try
        {
            _pattern->setProperty("pattern", Pattern);
            _pattern->setProperty("times", Times);
        }
        catch (const std::exception& e)
        {
            SYS_LOG_ERROR("Log::_writeCommand - %s\n", e.what());
        }

        // Configuration file channel
        AutoPtr<FileChannel> _channel(new FileChannel);

        try
        {
            _channel->setProperty("path", m_logsDir + DynamicFileName);
            _channel->setProperty("times", Times);

            if (!RotateOnOpen.empty())
                _channel->setProperty("rotateOnOpen", RotateOnOpen);

            if (!Rotation.empty())
                _channel->setProperty("rotation", Rotation);

            if (!Flush.empty())
                _channel->setProperty("flush", Flush);

            if (!Archive.empty())
                _channel->setProperty("archive", Archive);
        }
        catch (const std::exception& e)
        {
            SYS_LOG_ERROR("Log::_writeCommand - %s\n", e.what());
        }

        AutoPtr<SplitterChannel> SplitShannel(new SplitterChannel);

        try
        {
            SplitShannel->addChannel(new FormattingChannel(_pattern, _channel));
            SplitShannel->addChannel(GetConsoleChannel()->getChannel());
        }
        catch (const std::exception& e)
        {
            SYS_LOG_ERROR("Log::_writeCommand - %s\n", e.what());
        }

        try
        {
            Logger::create(LOGGER_GM_DYNAMIC, SplitShannel);
            Logger::get(LOGGER_GM_DYNAMIC).information(message);
            Logger::destroy(LOGGER_GM_DYNAMIC);
        }
        catch (const std::exception& e)
        {
            SYS_LOG_ERROR("Log::_writeCommand - %s\n", e.what());
        }
    }
    else
    {
        try
        {
            Logger::get(LOGGER_GM).information(message);
        }
        catch (const std::exception& e)
        {
            SYS_LOG_ERROR("Log::_writeCommand - %s", e.what());
        }
    }
}

void Log::outMessage(std::string const& filter, LogLevel const level, std::string&& message)
{
    _Write(filter, level, message);
}

void Log::outCommand(std::string&& AccountID, std::string&& message)
{
    _writeCommand(message, AccountID);
}

void Log::outSys(LogLevel level, std::string&& message)
{
    Logger& logger = Logger::get(LOGGER_SYSTEM);

    try
    {
        switch (level)
        {
        case LOG_LEVEL_ERROR:
            logger.error("" + message);
            break;
        case LOG_LEVEL_INFO:
            logger.information("" + message);
            break;
        default:
            break;
        }
    }
    catch (const std::exception& e)
    {
        printf("Log::outSys - %s\n", e.what());
    }
}

void Log::outCharDump(std::string const& str, uint32 accountId, uint64 guid, std::string const& name)
{
    if (str.empty())
        return;

    _Write(LOGGER_PLAYER_DUMP, LOG_LEVEL_INFO, Warhead::StringFormat("== START DUMP ==\n(Account: %u. Guid: %u. Name: %s)\n%s\n== END DUMP ==\n", accountId, guid, name.c_str(), str.c_str()));
}
