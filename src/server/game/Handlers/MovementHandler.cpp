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

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Log.h"
#include "Corpse.h"
#include "Player.h"
#include "SpellAuras.h"
#include "MapManager.h"
#include "Transport.h"
#include "Battleground.h"
#include "WaypointMovementGenerator.h"
#include "InstanceSaveMgr.h"
#include "ObjectMgr.h"

#include "World.h"
#include "TriniChat/IRCClient.h"
#include "Chat.h"

bool WorldSession::Anti__ReportCheat(const char* reason,float speed,const char* op,float value1,uint32 value2,MovementInfo* movementInfo)
{
    if (!reason)
    {
        sLog->outError(LOG_FILTER_PLAYER, "Anti__ReportCheat: Missing Reason parameter!");
        return false;
    }

    Player* player = GetPlayer();
    uint32 accountId = GetPlayer()->GetSession()->GetAccountId();
    uint32 mapId = GetPlayer()->GetMapId();

    if (!player)
    {
        sLog->outError(LOG_FILTER_PLAYER, "Anti__ReportCheat: Invalid Player Instance");
        return false;
    }

    // Ignore several maps
    // 369 - Tiefenbahn - Deeprun Tram
    // 607 - Strand der Uralten - Strand of the Ancients
    // 616 - Auge der Ewigkeit - Eye of Eternity - Malygos
    if (mapId == 369 || mapId == 607 || mapId == 616)
        return false;

    QueryResult result = CharacterDatabase.PQuery("SELECT speed,Val1 FROM cheaters WHERE player='%s' AND reason LIKE '%s' AND Map='%u' AND last_date >= NOW()-300",player->GetName(),reason,mapId);
    if (result)
    {
        Field* Fields = result->Fetch();

        std::stringstream Query;
        Query << "UPDATE cheaters SET count=count+1,last_date=NOW()";
        Query.precision(5);
        if(speed>0.0f && speed > Fields[0].GetFloat())
        {
            Query << ",speed='";
            Query << std::fixed << speed;
            Query << "'";
        }

        if(value1>0.0f && value1 > Fields[1].GetFloat())
        {
            Query << ",Val1='";
            Query << std::fixed << value1;
            Query << "'";
        }

        Query << " WHERE player='" << player << "' AND reason='" << reason << "' AND Map='" << mapId << "' AND last_date >= NOW()-300 ORDER BY entry DESC LIMIT 1";

        CharacterDatabase.Execute(Query.str().c_str());
    }
    else
    {
        if(!op)
            op="";

        std::stringstream Pos;
        Pos << "OldPos: " << GetPlayer()->GetPositionX() << " " << GetPlayer()->GetPositionY() << " "
            << GetPlayer()->GetPositionZ();

        uint32 Falltime = 0;

        if(movementInfo)
        {
            Falltime = movementInfo->fallTime;
            Pos << "\nNew: " << movementInfo->pos.m_positionX << " " << movementInfo->pos.m_positionY << " " << movementInfo->pos.m_positionZ << "\n"
                << "Flags: " << movementInfo->flags << "\n"
                << "t_guid: " << movementInfo->t_guid << " falltime: " << movementInfo->fallTime;
        }

        CharacterDatabase.PExecute("INSERT INTO cheaters (player,acctid,reason,speed,count,first_date,last_date,`Op`,Val1,Val2,Map,Pos,Level) "
                                   "VALUES ('%s','%u','%s','%f','1',NOW(),NOW(),'%s','%f','%u','%u','%s','%u')",
                                   player->GetName(),accountId,reason,speed,op,value1,value2,mapId,
                                   Pos.str().c_str(),GetPlayer()->getLevel());

        time_t t = time(NULL);
        tm* aTm = localtime(&t);

        char buff[1024];
        sprintf(buff, "PRIVMSG ChanServ TOPIC #wowteam :\x02\x034[AntiCheat]\x03\x02 (%d) \x02%s\x02 (GUID: %d, Account: %d) \x034-\x03 \x02%s\x02 \x034-\x03 \x02Position:\x02 %f %f %f %d",
                player->getLevel(), player->GetName(), player->GetGUIDLow(), accountId, reason, movementInfo->pos.m_positionX, movementInfo->pos.m_positionY, movementInfo->pos.m_positionZ, mapId);
        std::string msg = buff;
        sIRC.SendIRC(msg);
    }

    if(sWorld->GetMvAnticheatKill() && GetPlayer()->isAlive())
    {
        GetPlayer()->DealDamage(GetPlayer(), GetPlayer()->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
    }

    if(sWorld->GetMvAnticheatKick())
    {
        GetPlayer()->GetSession()->KickPlayer();
    }

    if(sWorld->GetMvAnticheatBan() & 1)
    {
        sWorld->BanAccount(BAN_CHARACTER, player->GetName(), sWorld->GetMvAnticheatBanTime(), "Cheat", "Anticheat");
    }

    if(sWorld->GetMvAnticheatBan() & 2)
    {
        QueryResult result = LoginDatabase.PQuery("SELECT last_ip FROM account WHERE id=%u", accountId);
        if(result)
        {
            Field *fields = result->Fetch();
            std::string LastIP = fields[0].GetCString();
            if(!LastIP.empty())
            {
                sWorld->BanAccount(BAN_IP,LastIP,sWorld->GetMvAnticheatBanTime(),"Cheat","Anticheat");
            }
        }
    }
    return true;
}

bool WorldSession::Anti__CheatOccurred(uint32 CurTime,const char* Reason,float Speed,const char* Op, float Val1,uint32 Val2,MovementInfo* MvInfo)
{
    if(!Reason)
    {
        sLog->outError(LOG_FILTER_PLAYER, "Anti__CheatOccurred: Missing Reason parameter!");
        return false;
    }

    GetPlayer()->m_anti_lastalarmtime = CurTime;
    GetPlayer()->m_anti_alarmcount = GetPlayer()->m_anti_alarmcount + 1;

    if (GetPlayer()->m_anti_alarmcount > sWorld->GetMvAnticheatAlarmCount())
    {
        Anti__ReportCheat(Reason,Speed,Op,Val1,Val2,MvInfo);
        return true;
    }

    return false;
}

void WorldSession::HandleMoveWorldportAckOpcode(WorldPacket & /*recv_data*/)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: got MSG_MOVE_WORLDPORT_ACK.");
    HandleMoveWorldportAckOpcode();
}

void WorldSession::HandleMoveWorldportAckOpcode()
{
    // ignore unexpected far teleports
    if (!GetPlayer()->IsBeingTeleportedFar())
        return;

    GetPlayer()->SetSemaphoreTeleportFar(false);

    // get the teleport destination
    WorldLocation const loc = GetPlayer()->GetTeleportDest();

    // possible errors in the coordinate validity check
    if (!MapManager::IsValidMapCoord(loc))
    {
        LogoutPlayer(false);
        return;
    }

    // get the destination map entry, not the current one, this will fix homebind and reset greeting
    MapEntry const* mEntry = sMapStore.LookupEntry(loc.GetMapId());
    InstanceTemplate const* mInstance = sObjectMgr->GetInstanceTemplate(loc.GetMapId());

    // reset instance validity, except if going to an instance inside an instance
    if (GetPlayer()->m_InstanceValid == false && !mInstance)
        GetPlayer()->m_InstanceValid = true;

    Map* oldMap = GetPlayer()->GetMap();
    if (GetPlayer()->IsInWorld())
    {
        sLog->outError(LOG_FILTER_NETWORKIO, "Player (Name %s) is still in world when teleported from map %u to new map %u", GetPlayer()->GetName(), oldMap->GetId(), loc.GetMapId());
        oldMap->RemovePlayerFromMap(GetPlayer(), false);
    }

    // relocate the player to the teleport destination
    Map* newMap = sMapMgr->CreateMap(loc.GetMapId(), GetPlayer());
    // the CanEnter checks are done in TeleporTo but conditions may change
    // while the player is in transit, for example the map may get full
    if (!newMap || !newMap->CanEnter(GetPlayer()))
    {
        sLog->outError(LOG_FILTER_NETWORKIO, "Map %d could not be created for player %d, porting player to homebind", loc.GetMapId(), GetPlayer()->GetGUIDLow());
        GetPlayer()->TeleportTo(GetPlayer()->m_homebindMapId, GetPlayer()->m_homebindX, GetPlayer()->m_homebindY, GetPlayer()->m_homebindZ, GetPlayer()->GetOrientation());
        return;
    }
    else
        GetPlayer()->Relocate(&loc);

    GetPlayer()->ResetMap();
    GetPlayer()->SetMap(newMap);

    GetPlayer()->m_anti_TeleTime = uint32(time(NULL));

    GetPlayer()->SendInitialPacketsBeforeAddToMap();
    if (!GetPlayer()->GetMap()->AddPlayerToMap(GetPlayer()))
    {
        sLog->outError(LOG_FILTER_NETWORKIO, "WORLD: failed to teleport player %s (%d) to map %d because of unknown reason!", GetPlayer()->GetName(), GetPlayer()->GetGUIDLow(), loc.GetMapId());
        GetPlayer()->ResetMap();
        GetPlayer()->SetMap(oldMap);
        GetPlayer()->TeleportTo(GetPlayer()->m_homebindMapId, GetPlayer()->m_homebindX, GetPlayer()->m_homebindY, GetPlayer()->m_homebindZ, GetPlayer()->GetOrientation());
        return;
    }

    // battleground state prepare (in case join to BG), at relogin/tele player not invited
    // only add to bg group and object, if the player was invited (else he entered through command)
    if (_player->InBattleground())
    {
        // cleanup setting if outdated
        if (!mEntry->IsBattlegroundOrArena())
        {
            // We're not in BG
            _player->SetBattlegroundId(0, BATTLEGROUND_TYPE_NONE);
            // reset destination bg team
            _player->SetBGTeam(0);
        }
        // join to bg case
        else if (Battleground* bg = _player->GetBattleground())
        {
            if (_player->IsInvitedForBattlegroundInstance(_player->GetBattlegroundId()))
                bg->AddPlayer(_player);
        }
    }

    GetPlayer()->SendInitialPacketsAfterAddToMap();

    // flight fast teleport case
    if (GetPlayer()->GetMotionMaster()->GetCurrentMovementGeneratorType() == FLIGHT_MOTION_TYPE)
    {
        if (!_player->InBattleground())
        {
            // short preparations to continue flight
            FlightPathMovementGenerator* flight = (FlightPathMovementGenerator*)(GetPlayer()->GetMotionMaster()->top());
            flight->Initialize(*GetPlayer());
            return;
        }

        // battleground state prepare, stop flight
        GetPlayer()->GetMotionMaster()->MovementExpired();
        GetPlayer()->CleanupAfterTaxiFlight();
    }

    // resurrect character at enter into instance where his corpse exist after add to map
    Corpse* corpse = GetPlayer()->GetCorpse();
    if (corpse && corpse->GetType() != CORPSE_BONES && corpse->GetMapId() == GetPlayer()->GetMapId())
    {
        if (mEntry->IsDungeon())
        {
            GetPlayer()->ResurrectPlayer(0.5f, false);
            GetPlayer()->SpawnCorpseBones();
        }
    }

    bool allowMount = !mEntry->IsDungeon() || mEntry->IsBattlegroundOrArena();
    if (mInstance)
    {
        Difficulty diff = GetPlayer()->GetDifficulty(mEntry->IsRaid());
        if (MapDifficulty const* mapDiff = GetMapDifficultyData(mEntry->MapID, diff))
        {
            if (mapDiff->resetTime)
            {
                if (time_t timeReset = sInstanceSaveMgr->GetResetTimeFor(mEntry->MapID, diff))
                {
                    uint32 timeleft = uint32(timeReset - time(NULL));
                    GetPlayer()->SendInstanceResetWarning(mEntry->MapID, diff, timeleft);
                }
            }
        }
        allowMount = mInstance->AllowMount;
    }

    // mount allow check
    if (!allowMount)
        _player->RemoveAurasByType(SPELL_AURA_MOUNTED);

    // update zone immediately, otherwise leave channel will cause crash in mtmap
    uint32 newzone, newarea;
    GetPlayer()->GetZoneAndAreaId(newzone, newarea);
    GetPlayer()->UpdateZone(newzone, newarea);

    // honorless target
    if (GetPlayer()->pvpInfo.inHostileArea)
        GetPlayer()->CastSpell(GetPlayer(), 2479, true);

    // in friendly area
    else if (GetPlayer()->IsPvP() && !GetPlayer()->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP))
        GetPlayer()->UpdatePvP(false, false);

    // resummon pet
    GetPlayer()->ResummonPetTemporaryUnSummonedIfAny();

    GetPlayer()->Anti__SetLastTeleTime(uint32(::time(NULL)));
    GetPlayer()->m_anti_BeginFallZ = INVALID_HEIGHT;

    //lets process all delayed operations on successful teleport
    GetPlayer()->ProcessDelayedOperations();
}

void WorldSession::HandleMoveTeleportAck(WorldPacket& recv_data)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "MSG_MOVE_TELEPORT_ACK");
    uint64 guid;

    recv_data.readPackGUID(guid);

    uint32 flags, time;
    recv_data >> flags >> time;
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Guid " UI64FMTD, guid);
    sLog->outDebug(LOG_FILTER_NETWORKIO, "Flags %u, time %u", flags, time/IN_MILLISECONDS);

    Player* plMover = _player->m_mover->ToPlayer();

    if (!plMover || !plMover->IsBeingTeleportedNear())
        return;

    if (guid != plMover->GetGUID())
        return;

    plMover->SetSemaphoreTeleportNear(false);

    uint32 old_zone = plMover->GetZoneId();

    WorldLocation const& dest = plMover->GetTeleportDest();

    plMover->UpdatePosition(dest, true);

    uint32 newzone, newarea;
    plMover->GetZoneAndAreaId(newzone, newarea);
    plMover->UpdateZone(newzone, newarea);

    // new zone
    if (old_zone != newzone)
    {
        // honorless target
        if (plMover->pvpInfo.inHostileArea)
            plMover->CastSpell(plMover, 2479, true);

        // in friendly area
        else if (plMover->IsPvP() && !plMover->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP))
            plMover->UpdatePvP(false, false);
    }

    // resummon pet
    GetPlayer()->ResummonPetTemporaryUnSummonedIfAny();

    if(plMover)
    {
        plMover->Anti__SetLastTeleTime(uint32(::time(NULL)));
        plMover->m_anti_BeginFallZ=INVALID_HEIGHT;
    }

    //lets process all delayed operations on successful teleport
    GetPlayer()->ProcessDelayedOperations();
}

void WorldSession::HandleMovementOpcodes(WorldPacket & recvData)
{
    uint16 opcode = recvData.GetOpcode();

    Unit* mover = _player->m_mover;

    ASSERT(mover != NULL);                      // there must always be a mover

    Player* plrMover = mover->ToPlayer();

    // ignore, waiting processing in WorldSession::HandleMoveWorldportAckOpcode and WorldSession::HandleMoveTeleportAck
    if (plrMover && plrMover->IsBeingTeleported())
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    /* extract packet */
    uint64 guid;

    recvData.readPackGUID(guid);

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recvData, &movementInfo);

    recvData.rfinish();                         // prevent warnings spam

    // prevent tampered movement data
    if (guid != mover->GetGUID())
        return;

    if (!movementInfo.pos.IsPositionValid())
    {
        recvData.rfinish();                     // prevent warnings spam
        return;
    }

    /* handle special cases */
    if (movementInfo.flags & MOVEMENTFLAG_ONTRANSPORT)
    {
        // transports size limited
        // (also received at zeppelin leave by some reason with t_* as absolute in continent coordinates, can be safely skipped)
        if (movementInfo.t_pos.GetPositionX() > 50 || movementInfo.t_pos.GetPositionY() > 50 || movementInfo.t_pos.GetPositionZ() > 50)
        {
            recvData.rfinish();                 // prevent warnings spam
            return;
        }

        if (!Trinity::IsValidMapCoord(movementInfo.pos.GetPositionX() + movementInfo.t_pos.GetPositionX(), movementInfo.pos.GetPositionY() + movementInfo.t_pos.GetPositionY(),
            movementInfo.pos.GetPositionZ() + movementInfo.t_pos.GetPositionZ(), movementInfo.pos.GetOrientation() + movementInfo.t_pos.GetOrientation()))
        {
            recvData.rfinish();                 // prevent warnings spam
            return;
        }

        // if we boarded a transport, add us to it
        if (plrMover)
        {
            if (!plrMover->GetTransport())
            {
                float trans_rad = movementInfo.t_pos.m_positionX * movementInfo.t_pos.m_positionX + movementInfo.t_pos.m_positionY * movementInfo.t_pos.m_positionY + movementInfo.t_pos.m_positionZ * movementInfo.t_pos.m_positionZ;
                if (trans_rad > 3600.0f) // transport radius = 60 yards //cheater with on_transport_flag
                {
                    return;
                }

                // elevators also cause the client to send MOVEMENTFLAG_ONTRANSPORT - just dismount if the guid can be found in the transport list
                for (MapManager::TransportSet::const_iterator iter = sMapMgr->m_Transports.begin(); iter != sMapMgr->m_Transports.end(); ++iter)
                {
                    if ((*iter)->GetGUID() == movementInfo.t_guid)
                    {
                        plrMover->m_transport = *iter;
                        (*iter)->AddPassenger(plrMover);
                        break;
                    }
                }
            }
            else if (plrMover->GetTransport()->GetGUID() != movementInfo.t_guid)
            {
                bool foundNewTransport = false;
                plrMover->m_transport->RemovePassenger(plrMover);
                for (MapManager::TransportSet::const_iterator iter = sMapMgr->m_Transports.begin(); iter != sMapMgr->m_Transports.end(); ++iter)
                {
                    if ((*iter)->GetGUID() == movementInfo.t_guid)
                    {
                        foundNewTransport = true;
                        plrMover->m_transport = *iter;
                        (*iter)->AddPassenger(plrMover);
                        break;
                    }
                }

                if (!foundNewTransport)
                {
                    plrMover->m_transport = NULL;
                    movementInfo.t_pos.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
                    movementInfo.t_time = 0;
                    movementInfo.t_seat = -1;
                }
            }
        }

        if (!mover->GetTransport() && !mover->GetVehicle())
        {
            GameObject* go = mover->GetMap()->GetGameObject(movementInfo.t_guid);
            if (!go || go->GetGoType() != GAMEOBJECT_TYPE_TRANSPORT)
                movementInfo.flags &= ~MOVEMENTFLAG_ONTRANSPORT;
        }
    }
    else if (plrMover && plrMover->GetTransport())                // if we were on a transport, leave
    {
        plrMover->m_transport->RemovePassenger(plrMover);
        plrMover->m_transport = NULL;
        movementInfo.t_pos.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
        movementInfo.t_time = 0;
        movementInfo.t_seat = -1;
    }

    // fall damage generation (ignore in flight case that can be triggered also at lags in moment teleportation to another map).
    if (opcode == MSG_MOVE_FALL_LAND && plrMover && !plrMover->isInFlight())
        plrMover->HandleFall(movementInfo);

    if (plrMover && ((movementInfo.flags & MOVEMENTFLAG_SWIMMING) != 0) != plrMover->IsInWater())
    {
        // now client not include swimming flag in case jumping under water
        plrMover->SetInWater(!plrMover->IsInWater() || plrMover->GetBaseMap()->IsUnderWater(movementInfo.pos.GetPositionX(), movementInfo.pos.GetPositionY(), movementInfo.pos.GetPositionZ()));

        if(plrMover->GetBaseMap()->IsUnderWater(movementInfo.pos.m_positionX, movementInfo.pos.m_positionY, movementInfo.pos.m_positionZ - 7.0f))
        {
            plrMover->m_anti_BeginFallZ = INVALID_HEIGHT;
        }
    }

    // ---- anti-cheat features -->>>
    uint32 Anti_TeleTimeDiff= plrMover ? uint32(time(NULL)) - plrMover->Anti__GetLastTeleTime() : uint32(time(NULL));
    static const uint32 Anti_TeleTimeIgnoreDiff=sWorld->GetMvAnticheatIgnoreAfterTeleport();
    if (plrMover && (plrMover->m_transport == 0) && sWorld->GetMvAnticheatEnable() &&
        GetPlayer()->GetSession()->GetSecurity() <= sWorld->GetMvAnticheatGmLevel() &&
        GetPlayer()->GetMotionMaster()->GetCurrentMovementGeneratorType()!=FLIGHT_MOTION_TYPE &&
        Anti_TeleTimeDiff>Anti_TeleTimeIgnoreDiff)
    {
        const uint32 CurTime=getMSTime();
        if(getMSTimeDiff(GetPlayer()->m_anti_lastalarmtime,CurTime) > sWorld->GetMvAnticheatAlarmPeriod())
        {
            GetPlayer()->m_anti_alarmcount = 0;
        }
        /* I really don't care about movement-type yet (todo)
        UnitMoveType move_type;

        if (movementInfo.flags & MOVEMENTFLAG_FLYING) move_type = MOVE_FLY;
        else if (movementInfo.flags & MOVEMENTFLAG_SWIMMING) move_type = MOVE_SWIM;
        else if (movementInfo.flags & MOVEMENTFLAG_WALK_MODE) move_type = MOVE_WALK;
        else move_type = MOVE_RUN;*/

        float delta_x = GetPlayer()->GetPositionX() - movementInfo.pos.m_positionX;
        float delta_y = GetPlayer()->GetPositionY() - movementInfo.pos.m_positionY;
        float delta_z = GetPlayer()->GetPositionZ() - movementInfo.pos.m_positionZ;
        float delta = sqrt(delta_x * delta_x + delta_y * delta_y); // Len of movement-vector via Pythagoras (a^2+b^2=Len^2)
        float tg_z = 0.0f; //tangens
        float delta_t = (float)getMSTimeDiff(GetPlayer()->m_anti_lastmovetime,CurTime);

        GetPlayer()->m_anti_lastmovetime = CurTime;
        GetPlayer()->m_anti_MovedLen += delta;

       if(delta_t > 15000.0f)
        {   delta_t = 15000.0f;   }

        // Tangens of walking angel
        /*if (!(movementInfo.flags & (MOVEMENTFLAG_FLYING | MOVEMENTFLAG_SWIMMING)))
        {
            //Mount hack detection currently disabled
-            tg_z = ((delta !=0.0f) && (delta_z > 0.0f)) ? (atan((delta_z*delta_z) / delta) * 180.0f / M_PI) : 0.0f;
        }*/

        //antiOFF fall-damage, MOVEMENTFLAG_FALL_DAMAGE seted by client if player try movement when falling and unset in this case the MOVEMENTFLAG_FALLING flag.

        if((GetPlayer()->m_anti_BeginFallZ == INVALID_HEIGHT) &&
           (movementInfo.flags & (MOVEMENTFLAG_FALLING)) != 0)
        {
            GetPlayer()->m_anti_BeginFallZ=(float)(movementInfo.pos.m_positionZ);
        }

        if(GetPlayer()->m_anti_NextLenCheck <= CurTime)
        {
            // Check every 500ms is a lot more advisable then 1000ms, because normal movment packet arrives every 500ms
            uint32 OldNextLenCheck=GetPlayer()->m_anti_NextLenCheck;
            float delta_xyt=GetPlayer()->m_anti_MovedLen/(float)(getMSTimeDiff(OldNextLenCheck-500,CurTime));
            GetPlayer()->m_anti_NextLenCheck = CurTime+500;
            GetPlayer()->m_anti_MovedLen = 0.0f;
            static const float MaxDeltaXYT = sWorld->GetMvAnticheatMaxXYT();

            if(delta_xyt > MaxDeltaXYT && delta<=100.0f)
            {
                Anti__CheatOccurred(CurTime,"Speed hack",delta_xyt,LookupOpcodeName(opcode),
                                    (float)(GetPlayer()->GetMotionMaster()->GetCurrentMovementGeneratorType()),
                                    getMSTimeDiff(OldNextLenCheck-500,CurTime),&movementInfo);
            }
        }

        if(delta > 100.0f && GetPlayer()->GetZoneId() != 2257)
        {
            Anti__ReportCheat("Tele hack",delta,LookupOpcodeName(opcode));
        }

        // Check for waterwalking
        if(((movementInfo.flags & MOVEMENTFLAG_WATERWALKING) != 0) &&
           ((movementInfo.flags ^ MOVEMENTFLAG_WATERWALKING) != 0) && // Client sometimes set waterwalk where it shouldn't do that...
           ((movementInfo.flags & MOVEMENTFLAG_FALLING) == 0) &&
           GetPlayer()->GetBaseMap()->IsUnderWater(movementInfo.pos.m_positionX, movementInfo.pos.m_positionY, movementInfo.pos.m_positionZ-6.0f) &&
           !(GetPlayer()->HasAuraType(SPELL_AURA_WATER_WALK) || GetPlayer()->HasAuraType(SPELL_AURA_GHOST)))
        {
            Anti__CheatOccurred(CurTime,"Water walking",0.0f,NULL,0.0f,(uint32)(movementInfo.flags));
        }

        // Check for walking upwards a mountain while not beeing able to do that
        /*if ((tg_z > 85.0f))
        {
            Anti__CheatOccurred(CurTime,"Mount hack",tg_z,NULL,delta,delta_z);
        }
        */

        static const float DIFF_OVERGROUND = 10.0f;
        float Anti__GroundZ = GetPlayer()->GetMap()->GetHeight(GetPlayer()->GetPositionX(),GetPlayer()->GetPositionY(),MAX_HEIGHT);
        float Anti__FloorZ  = GetPlayer()->GetMap()->GetHeight(GetPlayer()->GetPositionX(),GetPlayer()->GetPositionY(),GetPlayer()->GetPositionZ());
        float Anti__MapZ = ((Anti__FloorZ <= (INVALID_HEIGHT+5.0f)) ? Anti__GroundZ : Anti__FloorZ) + DIFF_OVERGROUND;

        if(!GetPlayer()->Anti__CanFly() &&
           !GetPlayer()->GetBaseMap()->IsUnderWater(movementInfo.pos.m_positionX, movementInfo.pos.m_positionY, movementInfo.pos.m_positionZ-7.0f) &&
           Anti__MapZ < GetPlayer()->GetPositionZ() && Anti__MapZ > (INVALID_HEIGHT+DIFF_OVERGROUND + 5.0f))
        {
            static const float DIFF_AIRJUMP=25.0f; // 25 is realy high, but to many false positives...

            // Air-Jump-Detection definitively needs a better way to be detected...
            if((movementInfo.flags & (MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_FLYING)) != 0) // Fly Hack
            {
                Anti__CheatOccurred(CurTime,"Fly hack",
                                    ((float)(GetPlayer()->HasAuraType(SPELL_AURA_FLY))) +
                                    ((float)(GetPlayer()->HasAuraType(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED)*2)),
                                    NULL,GetPlayer()->GetPositionZ()-Anti__MapZ);
            }

    /* Need a better way to do that - currently a lot of fake alarms
            else if((Anti__MapZ+DIFF_AIRJUMP < GetPlayer()->GetPositionZ() &&
                     (movementInfo.flags & (MOVEMENTFLAG_FALLING | MOVEMENTFLAG_UNK4))==0) ||
                    (Anti__MapZ < GetPlayer()->GetPositionZ() &&
                     opcode==MSG_MOVE_JUMP))
            {
                Anti__CheatOccurred(CurTime,"Possible Air Jump Hack",
                                    0.0f,LookupOpcodeName(opcode),0.0f,movementInfo.flags,&movementInfo);
            }*/
        }

        /*
        if(Anti__FloorZ < -199900.0f && Anti__GroundZ >= -199900.0f &&
           GetPlayer()->GetPositionZ()+5.0f < Anti__GroundZ)
        {
            Anti__CheatOccurred(CurTime,"Teleport2Plane hack",
                                GetPlayer()->GetPositionZ(),NULL,Anti__GroundZ);
        }*/
    }
    // <<---- anti-cheat features

    /* process position-change */
    WorldPacket data(opcode, recvData.size());
    movementInfo.time = getMSTime();
    movementInfo.guid = mover->GetGUID();
    WriteMovementInfo(&data, &movementInfo);
    mover->SendMessageToSet(&data, _player);

    mover->m_movementInfo = movementInfo;

    // this is almost never true (not sure why it is sometimes, but it is), normally use mover->IsVehicle()
    if (mover->GetVehicle())
    {
        mover->SetOrientation(movementInfo.pos.GetOrientation());
        return;
    }

    mover->UpdatePosition(movementInfo.pos);

    if (plrMover)                                            // nothing is charmed, or player charmed
    {
        plrMover->UpdateFallInformationIfNeed(movementInfo, opcode);

        if (movementInfo.pos.GetPositionZ() < -500.0f)
        {
            if (!(plrMover->GetBattleground() && plrMover->GetBattleground()->HandlePlayerUnderMap(_player)))
            {
                // NOTE: this is actually called many times while falling
                // even after the player has been teleported away
                // TODO: discard movement packets after the player is rooted
                if (plrMover->isAlive())
                {
                    plrMover->EnvironmentalDamage(DAMAGE_FALL_TO_VOID, GetPlayer()->GetMaxHealth());
                    // player can be alive if GM/etc
                    // change the death state to CORPSE to prevent the death timer from
                    // starting in the next player update
                    if (!plrMover->isAlive())
                        plrMover->KillPlayer();
                }
            }
        }
    }
}

void WorldSession::HandleForceSpeedChangeAck(WorldPacket &recv_data)
{
    uint32 opcode = recv_data.GetOpcode();
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd %s (%u, 0x%X) opcode", LookupOpcodeName(opcode), opcode, opcode);

    /* extract packet */
    uint64 guid;
    uint32 unk1;
    float  newspeed;

    recv_data.readPackGUID(guid);

    // now can skip not our packet
    if (_player->GetGUID() != guid)
    {
        recv_data.rfinish();                   // prevent warnings spam
        return;
    }

    // continue parse packet

    recv_data >> unk1;                                      // counter or moveEvent

    MovementInfo movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recv_data, &movementInfo);

    recv_data >> newspeed;
    /*----------------*/

    // client ACK send one packet for mounted/run case and need skip all except last from its
    // in other cases anti-cheat check can be fail in false case
    UnitMoveType move_type;
    UnitMoveType force_move_type;

    static char const* move_type_name[MAX_MOVE_TYPE] = {  "Walk", "Run", "RunBack", "Swim", "SwimBack", "TurnRate", "Flight", "FlightBack", "PitchRate" };

    switch (opcode)
    {
        case CMSG_FORCE_WALK_SPEED_CHANGE_ACK:          move_type = MOVE_WALK;          force_move_type = MOVE_WALK;        break;
        case CMSG_FORCE_RUN_SPEED_CHANGE_ACK:           move_type = MOVE_RUN;           force_move_type = MOVE_RUN;         break;
        case CMSG_FORCE_RUN_BACK_SPEED_CHANGE_ACK:      move_type = MOVE_RUN_BACK;      force_move_type = MOVE_RUN_BACK;    break;
        case CMSG_FORCE_SWIM_SPEED_CHANGE_ACK:          move_type = MOVE_SWIM;          force_move_type = MOVE_SWIM;        break;
        case CMSG_FORCE_SWIM_BACK_SPEED_CHANGE_ACK:     move_type = MOVE_SWIM_BACK;     force_move_type = MOVE_SWIM_BACK;   break;
        case CMSG_FORCE_TURN_RATE_CHANGE_ACK:           move_type = MOVE_TURN_RATE;     force_move_type = MOVE_TURN_RATE;   break;
        case CMSG_FORCE_FLIGHT_SPEED_CHANGE_ACK:        move_type = MOVE_FLIGHT;        force_move_type = MOVE_FLIGHT;      break;
        case CMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE_ACK:   move_type = MOVE_FLIGHT_BACK;   force_move_type = MOVE_FLIGHT_BACK; break;
        case CMSG_FORCE_PITCH_RATE_CHANGE_ACK:          move_type = MOVE_PITCH_RATE;    force_move_type = MOVE_PITCH_RATE;  break;
        default:
            sLog->outError(LOG_FILTER_NETWORKIO, "WorldSession::HandleForceSpeedChangeAck: Unknown move type opcode: %u", opcode);
            return;
    }

    // skip all forced speed changes except last and unexpected
    // in run/mounted case used one ACK and it must be skipped.m_forced_speed_changes[MOVE_RUN} store both.
    if (_player->m_forced_speed_changes[force_move_type] > 0)
    {
        --_player->m_forced_speed_changes[force_move_type];
        if (_player->m_forced_speed_changes[force_move_type] > 0)
            return;
    }

    if (!_player->GetTransport() && fabs(_player->GetSpeed(move_type) - newspeed) > 0.01f)
    {
        if (_player->GetSpeed(move_type) > newspeed)         // must be greater - just correct
        {
            sLog->outError(LOG_FILTER_NETWORKIO, "%sSpeedChange player %s is NOT correct (must be %f instead %f), force set to correct value",
                move_type_name[move_type], _player->GetName(), _player->GetSpeed(move_type), newspeed);
            _player->SetSpeed(move_type, _player->GetSpeedRate(move_type), true);
        }
        else                                                // must be lesser - cheating
        {
            sLog->outDebug(LOG_FILTER_GENERAL, "Player %s from account id %u kicked for incorrect speed (must be %f instead %f)",
                _player->GetName(), _player->GetSession()->GetAccountId(), _player->GetSpeed(move_type), newspeed);
            _player->GetSession()->KickPlayer();
        }
    }
}

void WorldSession::HandleSetActiveMoverOpcode(WorldPacket &recv_data)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_SET_ACTIVE_MOVER");

    uint64 guid;
    recv_data >> guid;

    if (GetPlayer()->IsInWorld())
    {
        if (_player->m_mover->GetGUID() != guid)
            sLog->outError(LOG_FILTER_NETWORKIO, "HandleSetActiveMoverOpcode: incorrect mover guid: mover is " UI64FMTD " (%s - Entry: %u) and should be " UI64FMTD, guid, GetLogNameForGuid(guid), GUID_ENPART(guid), _player->m_mover->GetGUID());
    }
}

void WorldSession::HandleMoveNotActiveMover(WorldPacket &recv_data)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Recvd CMSG_MOVE_NOT_ACTIVE_MOVER");

    uint64 old_mover_guid;
    recv_data.readPackGUID(old_mover_guid);

    MovementInfo mi;
    ReadMovementInfo(recv_data, &mi);

    mi.guid = old_mover_guid;

    _player->m_movementInfo = mi;
}

void WorldSession::HandleMountSpecialAnimOpcode(WorldPacket& /*recv_data*/)
{
    WorldPacket data(SMSG_MOUNTSPECIAL_ANIM, 8);
    data << uint64(GetPlayer()->GetGUID());

    GetPlayer()->SendMessageToSet(&data, false);
}

void WorldSession::HandleMoveKnockBackAck(WorldPacket & recv_data)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_MOVE_KNOCK_BACK_ACK");

    uint64 guid;
    recv_data.readPackGUID(guid);

    if (_player->m_mover->GetGUID() != guid)
        return;

    recv_data.read_skip<uint32>();                          // unk

    MovementInfo movementInfo;
    ReadMovementInfo(recv_data, &movementInfo);

    _player->m_movementInfo = movementInfo;

    WorldPacket data(MSG_MOVE_KNOCK_BACK, 66);
    data.appendPackGUID(guid);
    _player->BuildMovementPacket(&data);

    // knockback specific info
    data << movementInfo.j_sinAngle;
    data << movementInfo.j_cosAngle;
    data << movementInfo.j_xyspeed;
    data << movementInfo.j_zspeed;

    _player->SendMessageToSet(&data, false);
}

void WorldSession::HandleMoveHoverAck(WorldPacket& recv_data)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_MOVE_HOVER_ACK");

    uint64 guid;                                            // guid - unused
    recv_data.readPackGUID(guid);

    recv_data.read_skip<uint32>();                          // unk

    MovementInfo movementInfo;
    ReadMovementInfo(recv_data, &movementInfo);

    recv_data.read_skip<uint32>();                          // unk2
}

void WorldSession::HandleMoveWaterWalkAck(WorldPacket& recv_data)
{
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_MOVE_WATER_WALK_ACK");

    uint64 guid;                                            // guid - unused
    recv_data.readPackGUID(guid);

    recv_data.read_skip<uint32>();                          // unk

    MovementInfo movementInfo;
    ReadMovementInfo(recv_data, &movementInfo);

    recv_data.read_skip<uint32>();                          // unk2
}

void WorldSession::HandleSummonResponseOpcode(WorldPacket& recv_data)
{
    if (!_player->isAlive() || _player->isInCombat())
        return;

    uint64 summoner_guid;
    bool agree;
    recv_data >> summoner_guid;
    recv_data >> agree;

    _player->SummonIfPossible(agree);
}
