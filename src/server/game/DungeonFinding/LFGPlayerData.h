/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _LFGPLAYERDATA_H
#define _LFGPLAYERDATA_H

#include "LFG.h"
#include "LFGPacketsCommon.h"

namespace lfg
{

/**
    Stores all lfg data needed about the player.
*/
class GAME_API LfgPlayerData
{
    public:
        LfgPlayerData();
        ~LfgPlayerData();

        // General
        void SetTicket(WorldPackets::LFG::RideTicket const& ticket);
        void SetState(LfgState state);
        void RestoreState();
        void SetTeam(uint8 team);
        void SetGroup(ObjectGuid group);

        // Queue
        void SetRoles(uint8 roles);
        void SetSelectedDungeons(const LfgDungeonSet& dungeons);

        // General
        WorldPackets::LFG::RideTicket const& GetTicket() const;
        LfgState GetState() const;
        LfgState GetOldState() const;
        uint8 GetTeam() const;
        ObjectGuid GetGroup() const;

        // Queue
        uint8 GetRoles() const;
        LfgDungeonSet const& GetSelectedDungeons() const;

    private:
        // General
        WorldPackets::LFG::RideTicket m_Ticket;            ///< Join ticket
        LfgState m_State;                                  ///< State if group in LFG
        LfgState m_OldState;                               ///< Old State - Used to restore state after failed Rolecheck/Proposal
        // Player
        uint8 m_Team;                                      ///< Player team - determines the queue to join
        ObjectGuid m_Group;                                ///< Original group of player when joined LFG

        // Queue
        uint8 m_Roles;                                     ///< Roles the player selected when joined LFG
        LfgDungeonSet m_SelectedDungeons;                  ///< Selected Dungeons when joined LFG
};

} // namespace lfg

#endif
