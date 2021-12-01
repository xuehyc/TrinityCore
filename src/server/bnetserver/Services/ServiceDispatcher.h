/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ServiceDispatcher_h__
#define ServiceDispatcher_h__

#include "MessageBuffer.h"
#include "Log.h"
#include "Common.h"
#include "AccountService.h"
#include "AuthenticationService.h"
#include "challenge_service.pb.h"
#include "channel_service.pb.h"
#include "ConnectionService.h"
#include "friends_service.pb.h"
#include "GameUtilitiesService.h"
#include "presence_service.pb.h"
#include "report_service.pb.h"
#include "resource_service.pb.h"
#include "user_manager_service.pb.h"

namespace Battlenet
{
    class Session;

    class ServiceDispatcher
    {
    public:
        void Dispatch(Session* session, uint32 serviceHash, uint32 token, uint32 methodId, MessageBuffer buffer);

        static ServiceDispatcher& Instance();

    private:
        ServiceDispatcher();

        template<class Service>
        void AddService()
        {
            _dispatchers[Service::OriginalHash::value] = &ServiceDispatcher::Dispatch<Service>;
        }

        template<class Service>
        static void Dispatch(Session* session, uint32 token, uint32 methodId, MessageBuffer buffer)
        {
            Service(session).CallServerMethod(token, methodId, std::move(buffer));
        }

        typedef void(*ServiceMethod)(Session*, uint32, uint32, MessageBuffer);
        std::unordered_map<uint32, ServiceMethod> _dispatchers;
    };
}

#define sServiceDispatcher ServiceDispatcher::Instance()

#endif // ServiceDispatcher_h__
