/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/*
 * Interaction between core and LFGScripts
 */

#include "Common.h"
#include "SharedDefines.h"
#include "ScriptMgr.h"

class Player;
class Group;

namespace lfg
{

class GAME_API LFGPlayerScript : public PlayerScript
{
    public:
        LFGPlayerScript();

        // Player Hooks
        void OnLogout(Player* player) override;
        void OnLogin(Player* player, bool loginFirst) override;
        void OnMapChanged(Player* player) override;
};

class GAME_API LFGGroupScript : public GroupScript
{
    public:
        LFGGroupScript();

        // Group Hooks
        void OnAddMember(Group* group, ObjectGuid guid) override;
        void OnRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, char const* reason) override;
        void OnDisband(Group* group) override;
        void OnChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid) override;
        void OnInviteMember(Group* group, ObjectGuid guid) override;
};

/*keep private*/ void AddSC_LFGScripts();

} // namespace lfg
