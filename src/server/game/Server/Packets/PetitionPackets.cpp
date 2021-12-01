/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "PetitionPackets.h"

void WorldPackets::Petition::QueryPetition::Read()
{
    _worldPacket >> PetitionID;
    _worldPacket >> ItemGUID;
}

ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::Petition::PetitionInfo const& petitionInfo)
{
    data << petitionInfo.PetitionID;
    data << petitionInfo.Petitioner;

    data << petitionInfo.MinSignatures;
    data << petitionInfo.MaxSignatures;
    data << petitionInfo.DeadLine;
    data << petitionInfo.IssueDate;
    data << petitionInfo.AllowedGuildID;
    data << petitionInfo.AllowedClasses;
    data << petitionInfo.AllowedRaces;
    data << petitionInfo.AllowedGender;
    data << petitionInfo.AllowedMinLevel;
    data << petitionInfo.AllowedMaxLevel;
    data << petitionInfo.NumChoices;
    data << petitionInfo.StaticType;
    data << petitionInfo.Muid;

    data.WriteBits(petitionInfo.Title.length(), 7);
    data.WriteBits(petitionInfo.BodyText.length(), 12);

    for (uint8 i = 0; i < 10; i++)
        data.WriteBits(petitionInfo.Choicetext[i].length(), 6);

    data.FlushBits();

    for (uint8 i = 0; i < 10; i++)
        data.WriteString(petitionInfo.Choicetext[i]);

    data.WriteString(petitionInfo.Title);
    data.WriteString(petitionInfo.BodyText);

    return data;
}

WorldPacket const* WorldPackets::Petition::QueryPetitionResponse::Write()
{
    _worldPacket << PetitionID;
    _worldPacket.WriteBit(Allow);
    _worldPacket.FlushBits();

    if (Allow)
        _worldPacket << Info;

    return &_worldPacket;
}

void WorldPackets::Petition::PetitionShowList::Read()
{
    _worldPacket >> PetitionUnit;
}

WorldPacket const* WorldPackets::Petition::ServerPetitionShowList::Write()
{
    _worldPacket << Unit;
    _worldPacket << Price;

    return &_worldPacket;
}

void WorldPackets::Petition::PetitionBuy::Read()
{
    uint32 titleLen = _worldPacket.ReadBits(7);

    _worldPacket >> Unit;
    Title = _worldPacket.ReadString(titleLen);
}

void WorldPackets::Petition::PetitionShowSignatures::Read()
{
    _worldPacket >> Item;
}

WorldPacket const* WorldPackets::Petition::ServerPetitionShowSignatures::Write()
{
    _worldPacket << Item;
    _worldPacket << Owner;
    _worldPacket << OwnerAccountID;
    _worldPacket << PetitionID;

    _worldPacket << uint32(Signatures.size());
    for (PetitionSignature signature : Signatures)
    {
        _worldPacket << signature.Signer;
        _worldPacket << signature.Choice;
    }

    return &_worldPacket;
}

void WorldPackets::Petition::SignPetition::Read()
{
    _worldPacket >> PetitionGUID;
    _worldPacket >> Choice;
}

WorldPacket const* WorldPackets::Petition::PetitionSignResults::Write()
{
    _worldPacket << Item;
    _worldPacket << Player;

    _worldPacket.WriteBits(Error, 4);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::Petition::PetitionAlreadySigned::Write()
{
    _worldPacket << SignerGUID;

    return &_worldPacket;
}

void WorldPackets::Petition::DeclinePetition::Read()
{
    _worldPacket >> PetitionGUID;
}

void WorldPackets::Petition::TurnInPetition::Read()
{
    _worldPacket >> Item;
}

WorldPacket const* WorldPackets::Petition::TurnInPetitionResult::Write()
{
    _worldPacket.WriteBits(Result, 4);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

void WorldPackets::Petition::OfferPetition::Read()
{
    _worldPacket >> ItemGUID;
    _worldPacket >> TargetPlayer;
}

WorldPacket const* WorldPackets::Petition::OfferPetitionError::Write()
{
    _worldPacket << PlayerGUID;

    return &_worldPacket;
}

void WorldPackets::Petition::PetitionRenameGuild::Read()
{
    _worldPacket >> PetitionGuid;

    _worldPacket.ResetBitPos();
    uint32 nameLen = _worldPacket.ReadBits(7);

    NewGuildName = _worldPacket.ReadString(nameLen);
}

WorldPacket const* WorldPackets::Petition::PetitionRenameGuildResponse::Write()
{
    _worldPacket << PetitionGuid;

    _worldPacket.WriteBits(NewGuildName.length(), 7);
    _worldPacket.FlushBits();

    _worldPacket.WriteString(NewGuildName);

    return &_worldPacket;
}
