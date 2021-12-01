/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WorldserverServiceDispatcher.h"
#include "WorldserverService.h"

Battlenet::WorldserverServiceDispatcher::WorldserverServiceDispatcher()
{
    AddService<WorldserverService<account::v1::AccountService>>();
    AddService<WorldserverService<authentication::v1::AuthenticationService>>();
    AddService<WorldserverService<challenge::v1::ChallengeService>>();
    AddService<WorldserverService<channel::v1::ChannelService>>();
    AddService<WorldserverService<connection::v1::ConnectionService>>();
    AddService<WorldserverService<friends::v1::FriendsService>>();
    AddService<GameUtilitiesService>();
    AddService<WorldserverService<presence::v1::PresenceService>>();
    AddService<WorldserverService<report::v1::ReportService>>();
    AddService<WorldserverService<resources::v1::ResourcesService>>();
    AddService<WorldserverService<user_manager::v1::UserManagerService>>();
}

void Battlenet::WorldserverServiceDispatcher::Dispatch(WorldSession* session, uint32 serviceHash, uint32 token, uint32 methodId, MessageBuffer buffer)
{
    auto itr = _dispatchers.find(serviceHash);
    if (itr != _dispatchers.end())
        itr->second(session, token, methodId, std::move(buffer));
    else
        LOG_DEBUG("session.rpc", "%s tried to call invalid service 0x%X", session->GetPlayerInfo().c_str(), serviceHash);
}

Battlenet::WorldserverServiceDispatcher& Battlenet::WorldserverServiceDispatcher::Instance()
{
    static WorldserverServiceDispatcher instance;
    return instance;
}
