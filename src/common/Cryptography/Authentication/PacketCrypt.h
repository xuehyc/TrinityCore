/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _PACKETCRYPT_H
#define _PACKETCRYPT_H

#include "Cryptography/ARC4.h"

class BigNumber;

class COMMON_API PacketCrypt
{
    public:
        PacketCrypt(uint32 rc4InitSize);
        virtual ~PacketCrypt() { }

        virtual void Init(BigNumber* K) = 0;
        void DecryptRecv(uint8* data, size_t length);
        void EncryptSend(uint8* data, size_t length);

        bool IsInitialized() const { return _initialized; }

    protected:
        ARC4 _clientDecrypt;
        ARC4 _serverEncrypt;
        bool _initialized;
};

#endif // _PACKETCRYPT_H
