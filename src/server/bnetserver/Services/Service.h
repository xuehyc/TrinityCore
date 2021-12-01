/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef Service_h__
#define Service_h__

#include "Session.h"

namespace bgs { namespace protocol { } }
using namespace bgs::protocol;

namespace Battlenet
{
    template<class T>
    class Service : public T
    {
    public:
        Service(Session* session) : T(true), _session(session) { }

    protected:
        void SendRequest(uint32 serviceHash, uint32 methodId, google::protobuf::Message const* request, std::function<void(MessageBuffer)> callback) override { _session->SendRequest(serviceHash, methodId, request, std::move(callback)); }
        void SendRequest(uint32 serviceHash, uint32 methodId, google::protobuf::Message const* request) override { _session->SendRequest(serviceHash, methodId, request); }
        void SendResponse(uint32 /*serviceHash*/, uint32 /*methodId*/, uint32 token, uint32 status) override { _session->SendResponse(token, status); }
        void SendResponse(uint32 /*serviceHash*/, uint32 /*methodId*/, uint32 token, google::protobuf::Message const* response) override { _session->SendResponse(token, response); }
        std::string GetCallerInfo() const override { return _session->GetClientInfo(); }

        Session* _session;
    };
}

#endif // Service_h__
