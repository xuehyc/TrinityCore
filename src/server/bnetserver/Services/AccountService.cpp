/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "AccountService.h"
#include "Session.h"

Battlenet::Services::Account::Account(Session* session) : AccountService(session)
{
}

uint32 Battlenet::Services::Account::HandleGetAccountState(account::v1::GetAccountStateRequest const* request, account::v1::GetAccountStateResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& /*continuation*/)
{
    return _session->HandleGetAccountState(request, response);
}

uint32 Battlenet::Services::Account::HandleGetGameAccountState(account::v1::GetGameAccountStateRequest const* request, account::v1::GetGameAccountStateResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& /*continuation*/)
{
    return _session->HandleGetGameAccountState(request, response);
}
