/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "GameUtilitiesService.h"
#include "Session.h"

Battlenet::Services::GameUtilities::GameUtilities(Session* session) : GameUtilitiesService(session)
{
}

uint32 Battlenet::Services::GameUtilities::HandleProcessClientRequest(game_utilities::v1::ClientRequest const* request, game_utilities::v1::ClientResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& /*continuation*/)
{
    return _session->HandleProcessClientRequest(request, response);
}

uint32 Battlenet::Services::GameUtilities::HandleGetAllValuesForAttribute(game_utilities::v1::GetAllValuesForAttributeRequest const* request, game_utilities::v1::GetAllValuesForAttributeResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& /*continuation*/)
{
    return _session->HandleGetAllValuesForAttribute(request, response);
}
