/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SHA256_h__
#define SHA256_h__

#include "Define.h"
#include <string>
#include <type_traits>
#include <openssl/sha.h>

class BigNumber;

class COMMON_API SHA256Hash
{
    public:
        typedef std::integral_constant<uint32, SHA256_DIGEST_LENGTH> DigestLength;

        SHA256Hash();
        ~SHA256Hash();

        void UpdateBigNumbers(BigNumber* bn0, ...);

        void UpdateData(uint8 const* data, size_t len);
        void UpdateData(std::string const& str);

        void Initialize();
        void Finalize();

        uint8 *GetDigest() { return mDigest; }
        uint32 GetLength() const { return SHA256_DIGEST_LENGTH; }

    private:
        SHA256_CTX mC;
        uint8 mDigest[SHA256_DIGEST_LENGTH];
};

#endif // SHA256_h__
