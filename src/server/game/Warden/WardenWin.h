/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _WARDEN_WIN_H
#define _WARDEN_WIN_H

#include <map>
#include "Cryptography/ARC4.h"
#include "Cryptography/BigNumber.h"
#include "ByteBuffer.h"
#include "Warden.h"

#pragma pack(push, 1)

struct WardenInitModuleRequest
{
    uint8 Command1;
    uint16 Size1;
    uint32 CheckSumm1;
    uint8 Unk1;
    uint8 Unk2;
    uint8 Type;
    uint8 String_library1;
    uint32 Function1[4];

    uint8 Command2;
    uint16 Size2;
    uint32 CheckSumm2;
    uint8 Unk3;
    uint8 Unk4;
    uint8 String_library2;
    uint32 Function2;
    uint8 Function2_set;

    uint8 Command3;
    uint16 Size3;
    uint32 CheckSumm3;
    uint8 Unk5;
    uint8 Unk6;
    uint8 String_library3;
    uint32 Function3;
    uint8 Function3_set;
};

#pragma pack(pop)

class WorldSession;
class Warden;

class GAME_API WardenWin : public Warden
{
    public:
        WardenWin();
        ~WardenWin();

        void Init(WorldSession* session, BigNumber* K) override;
        ClientWardenModule* GetModuleForClient() override;
        void InitializeModule() override;
        void RequestHash() override;
        void HandleHashResult(ByteBuffer &buff) override;
        void RequestData() override;
        void HandleData(ByteBuffer &buff) override;

    private:
        uint32 _serverTicks;
        std::list<uint16> _otherChecksTodo;
        std::list<uint16> _memChecksTodo;
        std::list<uint16> _currentChecks;
};

#endif
