/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ToyPackets_h__
#define ToyPackets_h__

#include "SpellPackets.h"
#include "CollectionMgr.h"

namespace WorldPackets
{
    namespace Toy
    {
        class AddToy final : public ClientPacket
        {
        public:
            AddToy(WorldPacket&& packet) : ClientPacket(CMSG_ADD_TOY, std::move(packet)) { }

            void Read() override;

            ObjectGuid Guid;
        };

        class UseToy final : public ClientPacket
        {
        public:
            UseToy(WorldPacket&& packet) : ClientPacket(CMSG_USE_TOY, std::move(packet)) { }

            void Read() override;

            WorldPackets::Spells::SpellCastRequest Cast;
        };

        class AccountToysUpdate final : public ServerPacket
        {
        public:
            AccountToysUpdate() : ServerPacket(SMSG_ACCOUNT_TOYS_UPDATE, 1 + 4 + 1) { }

            WorldPacket const* Write() override;

            bool IsFullUpdate = false;
            ToyBoxContainer const* Toys = nullptr;
        };
    }
}

#endif // ToyPackets_h__
