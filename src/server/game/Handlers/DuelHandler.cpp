/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "Common.h"
#include "DuelPackets.h"
#include "WorldSession.h"
#include "Log.h"
#include "Player.h"
#include "ObjectAccessor.h"

#define SPELL_DUEL  7266
#define SPELL_MOUNTED_DUEL  62875

void WorldSession::HandleCanDuel(WorldPackets::Duel::CanDuel& packet)
{
    Player* player = ObjectAccessor::FindPlayer(packet.TargetGUID);

    if (!player)
        return;

    WorldPackets::Duel::CanDuelResult response;
    response.TargetGUID = packet.TargetGUID;
    response.Result = !player->duel;
    SendPacket(response.Write());

    if (response.Result)
    {
        if (_player->IsMounted())
            _player->CastSpell(player, SPELL_MOUNTED_DUEL);
        else
            _player->CastSpell(player, SPELL_DUEL);
    }
}

void WorldSession::HandleDuelResponseOpcode(WorldPackets::Duel::DuelResponse& duelResponse)
{
    if (duelResponse.Accepted)
        HandleDuelAccepted();
    else
        HandleDuelCancelled();
}

void WorldSession::HandleDuelAccepted()
{
    if (!GetPlayer()->duel)                                  // ignore accept from duel-sender
        return;

    Player* player = GetPlayer();
    Player* plTarget = player->duel->opponent;

    if (player == player->duel->initiator || !plTarget || player == plTarget || player->duel->startTime != 0 || plTarget->duel->startTime != 0)
        return;

    LOG_DEBUG("network", "Player 1 is: %s (%s)", player->GetGUID().ToString().c_str(), player->GetName().c_str());
    LOG_DEBUG("network", "Player 2 is: %s (%s)", plTarget->GetGUID().ToString().c_str(), plTarget->GetName().c_str());

    time_t now = time(NULL);
    player->duel->startTimer = now;
    plTarget->duel->startTimer = now;

    WorldPackets::Duel::DuelCountdown packet(3000); // milliseconds
    WorldPacket const* worldPacket = packet.Write();
    player->GetSession()->SendPacket(worldPacket);
    plTarget->GetSession()->SendPacket(worldPacket);
    player->EnablePvpRules();
    plTarget->EnablePvpRules();
}

void WorldSession::HandleDuelCancelled()
{
    // no duel requested
    if (!GetPlayer()->duel)
        return;

    // player surrendered in a duel using /forfeit
    if (GetPlayer()->duel->startTime != 0)
    {
        GetPlayer()->CombatStopWithPets(true);
        if (GetPlayer()->duel->opponent)
            GetPlayer()->duel->opponent->CombatStopWithPets(true);

        GetPlayer()->CastSpell(GetPlayer(), 7267, true);    // beg
        GetPlayer()->DuelComplete(DUEL_WON);
        return;
    }

    GetPlayer()->DuelComplete(DUEL_INTERRUPTED);
}
