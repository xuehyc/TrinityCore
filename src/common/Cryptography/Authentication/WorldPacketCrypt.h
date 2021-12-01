/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _WORLDPACKETCRYPT_H
#define _WORLDPACKETCRYPT_H

#include "PacketCrypt.h"

class BigNumber;

class COMMON_API WorldPacketCrypt : public PacketCrypt
{
    public:
        WorldPacketCrypt();

        void Init(BigNumber* K) override;
        void Init(BigNumber* k, uint8 const* serverKey, uint8 const* clientKey);
};

#endif // _WORLDPACKETCRYPT_H
