/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef Resolver_h__
#define Resolver_h__

#include "Optional.h"
#include <boost/asio/ip/tcp.hpp>
#include <string>

namespace Server
{
    namespace Net
    {
        inline Optional<boost::asio::ip::tcp::endpoint> Resolve(boost::asio::ip::tcp::resolver& resolver, boost::asio::ip::tcp const& protocol,
            std::string const& host, std::string const& service)
        {
            boost::system::error_code ec;
#if BOOST_VERSION >= 106600
            boost::asio::ip::tcp::resolver::results_type results = resolver.resolve(protocol, host, service, ec);
            if (results.empty() || ec)
                return {};

            return results.begin()->endpoint();
#else
            boost::asio::ip::tcp::resolver::query query(std::move(protocol), std::move(host), std::move(service));
            boost::asio::ip::tcp::resolver::iterator itr = resolver.resolve(query, ec);
            boost::asio::ip::tcp::resolver::iterator end;
            if (itr == end || ec)
                return {};

            return itr->endpoint();
#endif
        }
    }
}

#endif // Resolver_h__
