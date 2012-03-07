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
 *  @brief   Header file for CommandManager.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#ifndef __COMMAND_MANAGER_H__
#define __COMMAND_MANAGER_H__

#include <string>
#include <map>

#include <ace/Singleton.h>
#include <ace/Null_Mutex.h>

#include "Command.h"

/**
 *  @brief    A singleton which should manage/handle the commands.
 *  @details  Its main task is register commands and
 *            find (a pointer to access them) commands.
 */

class CommandManager
{
public:
    /**
     *  @brief    Free up resources.
     *  @details  Deallocate resources which allocated by
     *            the registered commands.
     *            All the allocations done in Impl_RegisterCommands()
     *  @see      Impl_RegisterCommands()
     */
    ~CommandManager();

    /**
     *  @brief   Returns (find) a Command pointer by the specific name.
     *  @retval  NULL   If there is no command with that name.
     *  @retval  ptrCommand  If there is a command with equivalent name.
     *  @param   name  The name (of the command) which looking for.
     */
    Command* FindCommand(std::string const name);

    /**
     *  @brief    Register the specific command with the specific name.
     *  @details  Push the command pointer into the CommandMap.
     *  @todo     Handle if there is another command with the same name or
     *            another command with the same pointer (same memory address).
     */
    void RegisterCommand(std::string const name, Command* cmdPtr);

private:
    /**
     *  @brief    This type is for store the registered commands.
     *  @details  Key is a string which is the command's name.
     *            Value is a pointer to the stored command.
     *  @todo     Use an unordered map.
     */
    typedef std::map<std::string const /* commandName */, Command* /* ptrToCommand */> CommandMap;

    /**
     *  @brief  Just a macro for CommandMap::const_iterator
     */
    typedef CommandMap::const_iterator CommandMap_ConstItr;

    /**
     *  @brief  This stores the registered commands.
     */
    CommandMap _commandMap;
};

/**
 *  @brief  This macro have to be used to access that class.
 */
#define sCommandManager ACE_Singleton<CommandManager, ACE_Null_Mutex>::instance()

#endif /* __COMMAND_MANAGER_H__ */
