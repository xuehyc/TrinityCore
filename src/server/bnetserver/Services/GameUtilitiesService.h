/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef GameUtilitiesServiceService_h__
#define GameUtilitiesServiceService_h__

#include "Common.h"
#include "Service.h"
#include "game_utilities_service.pb.h"

namespace Battlenet
{
    class Session;

    namespace Services
    {
        class GameUtilities : public Service<game_utilities::v1::GameUtilitiesService>
        {
            typedef Service<game_utilities::v1::GameUtilitiesService> GameUtilitiesService;

        public:
            GameUtilities(Session* session);

            uint32 HandleProcessClientRequest(game_utilities::v1::ClientRequest const* request, game_utilities::v1::ClientResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
            uint32 HandleGetAllValuesForAttribute(game_utilities::v1::GetAllValuesForAttributeRequest const* request, game_utilities::v1::GetAllValuesForAttributeResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
        };
    }
}

#endif // GameUtilitiesServiceService_h__
