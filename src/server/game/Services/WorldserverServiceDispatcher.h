/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef WorldserverServiceDispatcher_h__
#define WorldserverServiceDispatcher_h__

#include "WorldSession.h"
#include "MessageBuffer.h"
#include "Log.h"
#include "Common.h"
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

namespace Battlenet
{
    class WorldserverServiceDispatcher
    {
    public:
        void Dispatch(WorldSession* session, uint32 serviceHash, uint32 token, uint32 methodId, MessageBuffer buffer);

        static WorldserverServiceDispatcher& Instance();

    private:
        WorldserverServiceDispatcher();

        template<class Service>
        void AddService()
        {
            _dispatchers[Service::NameHash::value] = &WorldserverServiceDispatcher::Dispatch<Service>;
        }

        template<class Service>
        static void Dispatch(WorldSession* session, uint32 token, uint32 methodId, MessageBuffer buffer)
        {
            Service(session).CallServerMethod(token, methodId, std::move(buffer));
        }

        typedef void(*ServiceMethod)(WorldSession*, uint32, uint32, MessageBuffer);
        std::unordered_map<uint32, ServiceMethod> _dispatchers;
    };
}

#define sServiceDispatcher Battlenet::WorldserverServiceDispatcher::Instance()

#endif // WorldserverServiceDispatcher_h__
