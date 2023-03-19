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

#include "RoleplayDatabase.h"
#include "MySQLPreparedStatement.h"

void RoleplayDatabaseConnection::DoPrepareStatements()
{
    if (!m_reconnecting)
        m_stmts.resize(MAX_RoleplayDATABASE_STATEMENTS);

    // SELECTS
    PrepareStatement(Roleplay_SEL_CREATUREEXTRA, "SELECT guid, scale, id_creator_bnet, id_creator_player, id_modifier_bnet, id_modifier_player, UNIX_TIMESTAMP(created), UNIX_TIMESTAMP(modified), phaseMask, displayLock, displayId, nativeDisplayId, genderLock, gender, swim, gravity, fly FROM creature_extra", CONNECTION_SYNCH);
    PrepareStatement(Roleplay_SEL_CREATUREEXTRA_TEMPLATE, "SELECT id_entry, disabled FROM gameobject_template_extra", CONNECTION_SYNCH);
    
    // DELETIONS
    PrepareStatement(Roleplay_DEL_CREATUREEXTRA, "DELETE FROM creature_extra WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(Roleplay_DEL_CUSTOMNPC, "DELETE FROM custom_npcs WHERE `Key` = ?", CONNECTION_ASYNC);

    // UPDATES
    PrepareStatement(Roleplay_UPD_CREATUREEXTRA_TEMPLATE, "UPDATE creature_template_extra SET disabled = ? WHERE id_entry = ?", CONNECTION_ASYNC);

    // REPLACES
    PrepareStatement(Roleplay_REP_CREATUREEXTRA, "REPLACE INTO creature_extra (guid, scale, id_creator_bnet, id_creator_player, id_modifier_bnet, id_modifier_player, created, modified, phaseMask, displayLock, displayId, nativeDisplayId, genderLock, gender, swim, gravity, fly) VALUES (?, ?, ?, ?, ?, ?, from_unixtime(?), from_unixtime(?), ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(Roleplay_REP_CUSTOMNPCDATA, "REPLACE INTO custom_npcs (`Key`, Entry) VALUES (?, ?)", CONNECTION_ASYNC);
}

RoleplayDatabaseConnection::RoleplayDatabaseConnection(MySQLConnectionInfo& connInfo) : MySQLConnection(connInfo)
{
}

RoleplayDatabaseConnection::RoleplayDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo) : MySQLConnection(q, connInfo)
{
}

RoleplayDatabaseConnection::~RoleplayDatabaseConnection()
{
}
