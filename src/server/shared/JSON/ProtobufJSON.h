/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ProtobufJSON_h__
#define ProtobufJSON_h__

#include "Define.h"
#include <string>

namespace google
{
    namespace protobuf
    {
        class Message;
    }
}

namespace JSON
{
    SHARED_API std::string Serialize(google::protobuf::Message const& message);
    SHARED_API bool Deserialize(std::string const& json, google::protobuf::Message* message);
}

#endif // ProtobufJSON_h__
