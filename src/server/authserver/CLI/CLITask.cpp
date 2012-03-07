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
 *  @brief   Implementation of the CLITask class.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#include "CLITask.h"

#include <iostream>
#include <string>

#include "Command.h"
#include "CommandManager.h"

/**
 *  @brief  Allocate resources for commands and
 *          register them to the CommandHandler.
 *  @see    Impl_RegisterCommands()
 */

CLITask::CLITask()
{
    void Impl_RegisterCommands(); // forward declaration
    Impl_RegisterCommands();
}

/**
 *  @brief  Implementation of the loop.
 */

/* virtual */ int CLITask::svc()
{
    while (_running)
    {
        std::cout << "TC> "; // prompt
        std::string input = "";
        std::cin >> input;
        // try to find a command for the input
        if (Command* cmd = sCommandManager->FindCommand(input))
            cmd->Execute(); // if find a valid: execute it
    }
    return 0;
}
