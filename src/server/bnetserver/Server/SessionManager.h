/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SessionManager_h__
#define SessionManager_h__

#include "SocketMgr.h"
#include "Session.h"

namespace Battlenet
{
    class SessionManager : public SocketMgr<Session>
    {
        typedef SocketMgr<Session> BaseSocketMgr;

    public:
        static SessionManager& Instance();

        bool StartNetwork(Server::Asio::IoContext& ioContext, std::string const& bindIp, uint16 port, int threadCount = 1) override;

    protected:
        NetworkThread<Session>* CreateThreads() const override;

    private:
        static void OnSocketAccept(tcp::socket&& sock, uint32 threadIndex);
    };
}

#define sSessionMgr Battlenet::SessionManager::Instance()

#endif // SessionManager_h__
