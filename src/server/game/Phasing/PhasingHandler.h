/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef PhasingHandler_h__
#define PhasingHandler_h__

#include "Define.h"
#include <string>

class ChatHandler;
class Map;
class ObjectGuid;
class PhaseShift;
class Player;
class WorldObject;
namespace WorldPackets
{
    namespace Party
    {
        struct PartyMemberPhaseStates;
    }
}

class GAME_API PhasingHandler
{
public:
    static void AddPhase(WorldObject* object, uint32 phaseId, bool updateVisibility);
    static void RemovePhase(WorldObject* object, uint32 phaseId, bool updateVisibility);
    static void AddPhaseGroup(WorldObject* object, uint32 phaseGroupId, bool updateVisibility);
    static void RemovePhaseGroup(WorldObject* object, uint32 phaseGroupId, bool updateVisibility);

    static void AddVisibleMapId(WorldObject* object, uint32 visibleMapId);
    static void RemoveVisibleMapId(WorldObject* object, uint32 visibleMapId);

    static void ResetPhaseShift(WorldObject* object);
    static void InheritPhaseShift(WorldObject* target, WorldObject const* source);

    static void OnMapChange(WorldObject* object);
    static void OnAreaChange(WorldObject* object);
    static void OnConditionChange(WorldObject* object);

    static void SendToPlayer(Player const* player, PhaseShift const& phaseShift);
    static void SendToPlayer(Player const* player);
    static void FillPartyMemberPhase(WorldPackets::Party::PartyMemberPhaseStates* partyMemberPhases, PhaseShift const& phaseShift);

    static PhaseShift const& GetEmptyPhaseShift();
    static void InitDbPhaseShift(PhaseShift& phaseShift, uint8 phaseUseFlags, uint16 phaseId, uint32 phaseGroupId);
    static void InitDbVisibleMapId(PhaseShift& phaseShift, int32 visibleMapId);
    static bool InDbPhaseShift(WorldObject const* object, uint8 phaseUseFlags, uint16 phaseId, uint32 phaseGroupId);

    static uint32 GetTerrainMapId(PhaseShift const& phaseShift, Map const* map, float x, float y);

    static void SetAlwaysVisible(WorldObject* object, bool apply, bool updateVisibility);
    static void SetInversed(WorldObject* object, bool apply, bool updateVisibility);

    static void PrintToChat(ChatHandler* chat, PhaseShift const& phaseShift);
    static std::string FormatPhases(PhaseShift const& phaseShift);

private:
    static void AddPhase(WorldObject* object, uint32 phaseId, ObjectGuid const& personalGuid, bool updateVisibility);
    static void AddPhaseGroup(WorldObject* object, uint32 phaseGroupId, ObjectGuid const& personalGuid, bool updateVisibility);
    static void UpdateVisibilityIfNeeded(WorldObject* object, bool updateVisibility, bool changed);
};

#endif // PhasingHandler_h__
