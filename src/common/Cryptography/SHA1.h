/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _AUTH_SHA1_H
#define _AUTH_SHA1_H

#include "Define.h"
#include <string>
#include <type_traits>
#include <openssl/sha.h>

class BigNumber;

class COMMON_API SHA1Hash
{
    public:
        typedef std::integral_constant<uint32, SHA_DIGEST_LENGTH> DigestLength;

        SHA1Hash();
        ~SHA1Hash();

        void UpdateBigNumbers(BigNumber* bn0, ...);

        void UpdateData(const uint8 *dta, int len);
        void UpdateData(const std::string &str);

        void Initialize();
        void Finalize();

        uint8 *GetDigest(void) { return mDigest; }
        int GetLength(void) const { return SHA_DIGEST_LENGTH; }

    private:
        SHA_CTX mC;
        uint8 mDigest[SHA_DIGEST_LENGTH];
};

/// Returns the SHA1 hash of the given content as hex string.
COMMON_API std::string CalculateSHA1Hash(std::string const& content);

#endif
