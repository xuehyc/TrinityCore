/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "SslContext.h"
#include "Log.h"
#include "Config.h"

bool Battlenet::SslContext::Initialize()
{
    boost::system::error_code err;

#define LOAD_CHECK(fn) do { fn; \
    if (err) \
    { \
        LOG_ERROR("server.ssl", #fn " failed: %s", err.message().c_str()); \
        return false; \
    } } while (0)

    std::string certificateChainFile = sConfigMgr->GetStringDefault("CertificatesFile", "./bnetserver.cert.pem");
    std::string privateKeyFile = sConfigMgr->GetStringDefault("PrivateKeyFile", "./bnetserver.key.pem");

    LOAD_CHECK(instance().set_options(boost::asio::ssl::context::no_sslv3, err));
    LOAD_CHECK(instance().use_certificate_chain_file(certificateChainFile, err));
    LOAD_CHECK(instance().use_private_key_file(privateKeyFile, boost::asio::ssl::context::pem, err));

#undef LOAD_CHECK

    return true;
}

boost::asio::ssl::context& Battlenet::SslContext::instance()
{
    static boost::asio::ssl::context context(boost::asio::ssl::context::sslv23);
    return context;
}
