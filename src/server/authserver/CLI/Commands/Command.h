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
 *  @brief   Declaration of the Command class.
 *  @author  Anubisss <anubisss210@gmail.com>
 */

#ifndef __COMMAND_H__
#define __COMMAND_H__

#include <string>

/**
 *  @brief    That class represents a base class for commands.
 *  @details  A concrete command have to inherit this class and
 *            have to implement the Execute() method.
 *            Moreover haveto define its name by this class' constructor.
 *  @see      Command()
 *  @see      Execute()
 */

class Command
{
public:
    /**
     *  @brief  That constructor registers the specific command
     *          to the CommandManager.
     *  @see    CommandManager::RegisterCommand()
     */
    Command(std::string const name);

    /**
     *  @brief    This function should do a command's real work.
     *  @details  This virtual function should be implemented by child class,
     *            that child class is a concrete command implementation.
     *            This function called in CLI's loop.
     *  @see      CLITask::svc()
     */
    virtual void Execute() = 0;

    /**
     *  @brief   Return swith the command's name.
     *  @return  A string which represents the name of the command.
     */
    std::string GetName() const { return _name; }

private:
    /**
     *  @brief    Name of the command.
     *  @details  In fact this is an identifier which makes possible to
     *            call the command's handler.
     */
    std::string _name;
};

#endif /* __COMMAND_H__ */
