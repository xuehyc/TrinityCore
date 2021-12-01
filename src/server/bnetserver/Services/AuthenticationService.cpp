/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "AuthenticationService.h"
#include "Session.h"

Battlenet::Services::Authentication::Authentication(Session* session) : AuthenticationService(session)
{
}

uint32 Battlenet::Services::Authentication::HandleLogon(authentication::v1::LogonRequest const* request, NoData* /*response*/, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation)
{
    return _session->HandleLogon(request, continuation);
}

uint32 Battlenet::Services::Authentication::HandleVerifyWebCredentials(authentication::v1::VerifyWebCredentialsRequest const* request, NoData* /*response*/, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation)
{
    return _session->HandleVerifyWebCredentials(request, continuation);
}
