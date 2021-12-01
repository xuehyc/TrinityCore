/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "PacketCrypt.h"

PacketCrypt::PacketCrypt(uint32 rc4InitSize)
    : _clientDecrypt(rc4InitSize), _serverEncrypt(rc4InitSize), _initialized(false)
{
}

void PacketCrypt::DecryptRecv(uint8* data, size_t len)
{
    if (!_initialized)
        return;

    _clientDecrypt.UpdateData(len, data);
}

void PacketCrypt::EncryptSend(uint8* data, size_t len)
{
    if (!_initialized)
        return;

    _serverEncrypt.UpdateData(len, data);
}
