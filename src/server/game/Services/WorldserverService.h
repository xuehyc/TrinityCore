/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef WorldserverService_h__
#define WorldserverService_h__

#include "WorldSession.h"
#include "account_service.pb.h"
#include "authentication_service.pb.h"
#include "challenge_service.pb.h"
#include "channel_service.pb.h"
#include "connection_service.pb.h"
#include "friends_service.pb.h"
#include "game_utilities_service.pb.h"
#include "presence_service.pb.h"
#include "report_service.pb.h"
#include "resource_service.pb.h"
#include "user_manager_service.pb.h"

namespace bgs { namespace protocol { } }
using namespace bgs::protocol;

namespace Battlenet
{
    template<class T>
    class WorldserverService : public T
    {
    public:
        WorldserverService(WorldSession* session) : T(false), _session(session) { }

    protected:
        void SendRequest(uint32 serviceHash, uint32 methodId, google::protobuf::Message const* request, std::function<void(MessageBuffer)> callback) override { _session->SendBattlenetRequest(serviceHash, methodId, request, std::move(callback)); }
        void SendRequest(uint32 serviceHash, uint32 methodId, google::protobuf::Message const* request) override { _session->SendBattlenetRequest(serviceHash, methodId, request); }
        void SendResponse(uint32 serviceHash, uint32 methodId, uint32 token, uint32 status) override { _session->SendBattlenetResponse(serviceHash, methodId, token, status); }
        void SendResponse(uint32 serviceHash, uint32 methodId, uint32 token, google::protobuf::Message const* response) override { _session->SendBattlenetResponse(serviceHash, methodId, token, response); }
        std::string GetCallerInfo() const override { return _session->GetPlayerInfo(); }

        WorldSession* _session;
    };

    class GameUtilitiesService : public WorldserverService<game_utilities::v1::GameUtilitiesService>
    {
        typedef WorldserverService<game_utilities::v1::GameUtilitiesService> BaseService;

    public:
        GameUtilitiesService(WorldSession* session);

        uint32 HandleProcessClientRequest(game_utilities::v1::ClientRequest const* request, game_utilities::v1::ClientResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
        uint32 HandleGetAllValuesForAttribute(game_utilities::v1::GetAllValuesForAttributeRequest const* request, game_utilities::v1::GetAllValuesForAttributeResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;

    private:
        uint32 HandleRealmListRequest(std::unordered_map<std::string, Variant const*> params, game_utilities::v1::ClientResponse* response);
        uint32 HandleRealmJoinRequest(std::unordered_map<std::string, Variant const*> params, game_utilities::v1::ClientResponse* response);
    };
}

#endif // WorldserverService_h__
