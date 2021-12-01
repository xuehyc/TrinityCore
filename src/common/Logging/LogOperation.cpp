/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "LogOperation.h"
#include "Logger.h"
#include "LogMessage.h"

LogOperation::LogOperation(Logger const* _logger, std::unique_ptr<LogMessage>&& _msg) : logger(_logger), msg(std::forward<std::unique_ptr<LogMessage>>(_msg))
{
}

LogOperation::~LogOperation()
{
}

int LogOperation::call()
{
    logger->write(msg.get());
    return 0;
}
