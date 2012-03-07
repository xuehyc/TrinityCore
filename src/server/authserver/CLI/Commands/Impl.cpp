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
 *  @brief   This file should contain all the implemented commands and
 *           the function which allocate resources for them.
 *  @see     Impl_RegisterCommands()
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#include "Command.h"

#include <iostream>
#include <ctime>

#include "SystemConfig.h"
#include "Util.h"
#include "RealmdManager.h"

/**
 *  @brief  This command is just an example and also can be used for debugging.
 */

class Command_Test : public Command
{
public:
    Command_Test() : Command("test") {}

    /* virtual */ void Execute()
    {
        std::cout << "Hello World!" << std::endl;
    }
};

/**
 *  @brief    Print some info about the daemon.
 *  @details  Print some info about the daemon compilation, like:
              "TrinityCore rev. 2012-03-04 18:21:08 +0100 (f5730e82ced8+) (Unix, DEBUG)"@n
              Print the daemon's uptime, like: "Uptime: 4 Minute(s) 32 Second(s).".
 *  @todo     Print active connections.@n
 *            Print max active connections.@n
 *            Print update time diff.@n
 *            Print max update time diff.@n
 */

class Command_Info : public Command
{
public:
    Command_Info() : Command("info") {}

    /* virtual */ void Execute()
    {
        std::cout << _FULLVERSION << std::endl
                  << "Uptime: " << secsToTimeString(sRealmdManager->GetUpTime()) << std::endl;
    }
};

/**
 *  @brief  This method allocates resources for the implemented commands.
 *          Function called in CLITask's constructor.
 *  @see    CLITask::CLITask()
 */

void Impl_RegisterCommands()
{
    new Command_Test();
    new Command_Info();
}
