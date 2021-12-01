/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef AuthenticationService_h__
#define AuthenticationService_h__

#include "Common.h"
#include "Service.h"
#include "authentication_service.pb.h"

namespace Battlenet
{
    class Session;

    namespace Services
    {
        class Authentication : public Service<authentication::v1::AuthenticationService>
        {
            typedef Service<authentication::v1::AuthenticationService> AuthenticationService;

        public:
            Authentication(Session* session);

            uint32 HandleLogon(authentication::v1::LogonRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
            uint32 HandleVerifyWebCredentials(authentication::v1::VerifyWebCredentialsRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
        };
    }
}

#endif // AuthenticationService_h__
