/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SessionKeyGeneration_h__
#define SessionKeyGeneration_h__

#include "Define.h"
#include <cstring>

template<class Hash>
class SessionKeyGenerator
{
public:
    SessionKeyGenerator(uint8* buff, uint32 size)
    {
        uint32 halfSize = size / 2;

        sh.Initialize();
        sh.UpdateData(buff, halfSize);
        sh.Finalize();

        memcpy(o1, sh.GetDigest(), Hash::DigestLength::value);

        sh.Initialize();
        sh.UpdateData(buff + halfSize, size - halfSize);
        sh.Finalize();

        memcpy(o2, sh.GetDigest(), Hash::DigestLength::value);

        memset(o0, 0x00, Hash::DigestLength::value);

        FillUp();
    }

    void Generate(uint8* buf, uint32 sz)
    {
        for (uint32 i = 0; i < sz; ++i)
        {
            if (taken == Hash::DigestLength::value)
                FillUp();

            buf[i] = o0[taken];
            taken++;
        }
    }

private:
    void FillUp()
    {
        sh.Initialize();
        sh.UpdateData(o1, Hash::DigestLength::value);
        sh.UpdateData(o0, Hash::DigestLength::value);
        sh.UpdateData(o2, Hash::DigestLength::value);
        sh.Finalize();

        memcpy(o0, sh.GetDigest(), Hash::DigestLength::value);

        taken = 0;
    }

    Hash sh;
    uint32 taken;
    uint8 o0[Hash::DigestLength::value];
    uint8 o1[Hash::DigestLength::value];
    uint8 o2[Hash::DigestLength::value];
};

#endif // SessionKeyGeneration_h__
