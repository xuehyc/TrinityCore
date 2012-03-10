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
 *  @brief   Declaration of a class which responsible for process
 *           input (commands) from the command line.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#ifndef __CLI_TASK_H__
#define __CLI_TASK_H__

#include <ace/Task.h>

#include "LogTrace.h"

/**
 *  @brief    Command line interface thread.
 *  @details  Inherit from class ACE_Task_Base which makes the task
 *            to running on a new thread.
 */

class CLITask : public ACE_Task_Base
{
public:
    /**
     *  @brief  This constructor prepares "things" for the CLI.
     */
    CLITask();

    /**
     *  @brief  Create a new thread and enter into its loop.
     *  @see    svc()
     */
    void Start()
    {
        LOG_TRACE("Starting CLI thread...");
        _running = true;
        activate();
    }
    /**
     *  @brief  Stop the loop.
     *  @see    svc()
     */
    void Stop()
    {
        LOG_TRACE("Stopping CLI thread...");
        _running = false;
    }

    /**
     *  @brief  The new running thread's "loop".
     */
    /* virtual */ int svc();

private:
    /**
     *  @brief    This boolean can tell the realm daemon is running or not.
     *  @details  Bool is true when yes and false if not.
     *            If not our loop should stop.
     *            Used in svc().
     *  @see      svc()
     */
    bool _running;
};

#endif /* __CLI_TASK_H__ */
