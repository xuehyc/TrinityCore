/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_PACKETLOG_H
#define SERVER_PACKETLOG_H

#include "Common.h"
#include <mutex>

enum Direction
{
    CLIENT_TO_SERVER,
    SERVER_TO_CLIENT
};

class WorldPacket;
enum ConnectionType : int8;

namespace boost
{
    namespace asio
    {
        namespace ip
        {
            class address;
        }
    }
}

class GAME_API PacketLog
{
    private:
        PacketLog();
        ~PacketLog();
        std::mutex _logPacketLock;
        std::once_flag _initializeFlag;

    public:
        static PacketLog* instance();

        void Initialize();
        bool CanLogPacket() const { return (_file != NULL); }
        void LogPacket(WorldPacket const& packet, Direction direction, boost::asio::ip::address const& addr, uint16 port, ConnectionType connectionType);

    private:
        FILE* _file;
};

#define sPacketLog PacketLog::instance()
#endif
