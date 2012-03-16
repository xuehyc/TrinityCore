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
 *  @brief   Implementation of the CommandManager class.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#include "CommandManager.h"

#include <sstream>

#include "LogTrace.h"

CommandManager::~CommandManager()
{
    for (CommandMap_ConstItr itr = _commands.begin(); itr != _commands.end(); ++itr)
        delete itr->second;
    _commands.clear();
}

Command* CommandManager::FindCommand(std::string const name)
{
    if (_commands.find(name) == _commands.end())
        return NULL;
    return _commands[name];
}

void CommandManager::RegisterCommand(std::string const name, Command* cmdPtr)
{
    _commands[name] = cmdPtr;

    std::ostringstream oss;
    oss << "Command registered with the CommandManager: \"" << name << "\"";
    LOG_TRACE(oss.str());
}
