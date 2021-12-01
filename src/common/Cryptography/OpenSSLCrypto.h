/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef OPENSSL_CRYPTO_H
#define OPENSSL_CRYPTO_H

#include "Define.h"

/**
* A group of functions which setup openssl crypto module to work properly in multithreaded enviroment
* If not setup properly - it will crash
*/
namespace OpenSSLCrypto
{
    /// Needs to be called before threads using openssl are spawned
    COMMON_API void threadsSetup();
    /// Needs to be called after threads using openssl are despawned
    COMMON_API void threadsCleanup();
}

#endif
