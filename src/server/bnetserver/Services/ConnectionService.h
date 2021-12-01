/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ConnectionService_h__
#define ConnectionService_h__

#include "Common.h"
#include "Service.h"
#include "connection_service.pb.h"

namespace Battlenet
{
    class Session;

    namespace Services
    {
        class Connection : public Service<connection::v1::ConnectionService>
        {
            typedef Service<connection::v1::ConnectionService> ConnectionService;

        public:
            Connection(Session* session);

            uint32 HandleConnect(connection::v1::ConnectRequest const* request, connection::v1::ConnectResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
            uint32 HandleKeepAlive(NoData const* request) override;
            uint32 HandleRequestDisconnect(connection::v1::DisconnectRequest const* request) override;

        };
    }
}

#endif // ConnectionService_h__
