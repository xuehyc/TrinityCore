/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _WARDEN_MAC_H
#define _WARDEN_MAC_H

#include "Cryptography/ARC4.h"
#include <map>
#include "Cryptography/BigNumber.h"
#include "ByteBuffer.h"
#include "Warden.h"

class WorldSession;
class Warden;

class GAME_API WardenMac : public Warden
{
    public:
        WardenMac();
        ~WardenMac();

        void Init(WorldSession* session, BigNumber* k) override;
        ClientWardenModule* GetModuleForClient() override;
        void InitializeModule() override;
        void RequestHash() override;
        void HandleHashResult(ByteBuffer& buff) override;
        void RequestData() override;
        void HandleData(ByteBuffer& buff) override;
};

#endif
