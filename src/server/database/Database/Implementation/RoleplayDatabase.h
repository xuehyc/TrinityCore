/*
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
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

#ifndef _RoleplayDATABASE_H
#define _RoleplayDATABASE_H

#include "MySQLConnection.h"

enum RoleplayDatabaseStatements
{
    /*  Naming standard for defines:
        {DB}_{SEL/INS/UPD/DEL/REP}_{Summary of data changed}
        When updating more than one field, consider looking at the calling function
        name for a suiting suffix.
    */
    // SELECTS
    Roleplay_SEL_CREATUREEXTRA,
    Roleplay_SEL_CREATUREEXTRA_TEMPLATE,

    // DELETIONS
    Roleplay_DEL_CREATUREEXTRA,
    Roleplay_DEL_CUSTOMNPC,

    // UPDATES
    Roleplay_UPD_CREATUREEXTRA_TEMPLATE,

    // REPLACES
    Roleplay_REP_CREATUREEXTRA,
    Roleplay_REP_CUSTOMNPCDATA,

    MAX_RoleplayDATABASE_STATEMENTS
};

class TC_DATABASE_API RoleplayDatabaseConnection : public MySQLConnection
{
public:
    typedef RoleplayDatabaseStatements Statements;

    //- Constructors for sync and async connections
    RoleplayDatabaseConnection(MySQLConnectionInfo& connInfo);
    RoleplayDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo);
    ~RoleplayDatabaseConnection();

    //- Loads database type specific prepared statements
    void DoPrepareStatements() override;
};

#endif
