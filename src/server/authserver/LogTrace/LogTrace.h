/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

/**
 *  @file
 *  @brief
 *  @author  Anubisss, <anubisss210@gmail.com>
 */

#ifndef __LOG_TRACE_H__
#define __LOG_TRACE_H__

#include <iostream>
#include <cstring>

#include <ace/Singleton.h>
#include <ace/Null_Mutex.h>
#include <ace/OS.h>
#include <ace/Thread_Manager.h>

/**
 *  @brief  Singleton class to generate trace logs to the standard output.
 *  @see    Trace()
 */

class LogTrace
{
public:
    /**
     *  @brief    This function called by the macro which
     *            used for generate a log message.
     *  @details  Output format: [LOG_TRACE] (process_id|thread_id) filename.ext:line_number, pretty_function_name - msg
     *  @par      eg.:
     *            [LOG_TRACE] (4765|3078018768) Main.cpp:232, int main(int, char**) - Loop starting...@n
     *            [LOG_TRACE] (4765|3078018768) RealmdManager.h:48, RealmdManager::RealmdManager() - RealmdManager initialized.
     * @see       LOG_TRACE(msg)
     */
    void Trace(std::string const functionName, std::string const fileName, int const lineNumber, std::string const message)
    {
        std::cout << "[LOG_TRACE] (" << ACE_OS::getpid() << "|" << ACE_Thread_Manager::instance()->thr_self() << ")"
                  << " " << fileName << ":" << lineNumber << ","
                  << " " << functionName << " - " << message << std::endl;
    }
};

/**
 *  @brief  This macro does cut out the file name from the macro __FILE__
 *          full path string.
 *  @todo   Need another one for platform windows ('\').
 */

#define __SHORT_FILE__ \
(strrchr(__FILE__,'/') \
? strrchr(__FILE__,'/')+1 \
: __FILE__ \
)

/**
 *  @brief  This macro should used to generate a log message.
 */

#define LOG_TRACE(msg) ACE_Singleton<LogTrace, ACE_Null_Mutex>::instance()->Trace(__PRETTY_FUNCTION__, __SHORT_FILE__, __LINE__, msg)

#endif /* __LOG_TRACE_H__ */
