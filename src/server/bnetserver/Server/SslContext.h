/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SslContext_h__
#define SslContext_h__

#include <boost/asio/ssl/context.hpp>

namespace Battlenet
{
    class SslContext
    {
    public:
        static bool Initialize();

        static boost::asio::ssl::context& instance();
    };
}

#endif // SslContext_h__
