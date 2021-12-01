/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef AccountService_h__
#define AccountService_h__

#include "Common.h"
#include "Service.h"
#include "account_service.pb.h"

namespace Battlenet
{
    class Session;

    namespace Services
    {
        class Account : public Service<account::v1::AccountService>
        {
            typedef Service<account::v1::AccountService> AccountService;

        public:
            Account(Session* session);

            uint32 HandleGetAccountState(account::v1::GetAccountStateRequest const* request, account::v1::GetAccountStateResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
            uint32 HandleGetGameAccountState(account::v1::GetGameAccountStateRequest const* request, account::v1::GetGameAccountStateResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
        };
    }
}

#endif // AccountService_h__
