/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "BankPackets.h"

void WorldPackets::Bank::AutoBankItem::Read()
{
    _worldPacket >> Inv
                 >> Bag
                 >> Slot;
}

void WorldPackets::Bank::AutoStoreBankItem::Read()
{
    _worldPacket >> Inv
                 >> Bag
                 >> Slot;
}

void WorldPackets::Bank::BuyBankSlot::Read()
{
    _worldPacket >> Guid;
}
