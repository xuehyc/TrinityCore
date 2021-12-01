/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ServiceBase_h__
#define ServiceBase_h__

#include "MessageBuffer.h"
#include "Define.h"
#include <functional>
#include <string>

namespace google
{
    namespace protobuf
    {
        class Message;
    }
}

class PROTO_API ServiceBase
{
public:
    virtual ~ServiceBase() { }

    virtual void CallServerMethod(uint32 token, uint32 methodId, MessageBuffer buffer) = 0;

protected:
    virtual void SendRequest(uint32 serviceHash, uint32 methodId, google::protobuf::Message const* request, std::function<void(MessageBuffer)> callback) = 0;
    virtual void SendRequest(uint32 serviceHash, uint32 methodId, google::protobuf::Message const* request) = 0;
    virtual void SendResponse(uint32 serviceHash, uint32 methodId, uint32 token, uint32 status) = 0;
    virtual void SendResponse(uint32 serviceHash, uint32 methodId, uint32 token, google::protobuf::Message const* response) = 0;
    virtual std::string GetCallerInfo() const = 0;
};

#endif // ServiceBase_h__
