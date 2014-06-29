/*
 * Copyright (C) 2011-2014 ArkCORE <http://www.arkania.net/>
 * Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __BattlegroundBFG_H
#define __BattlegroundBFG_H

#include "Player.h"
#include "Battleground.h"
#include "BattlegroundScore.h"

class BattlegroundBFGScore final : public BattlegroundScore
{
    protected:
        BattlegroundBFGScore(uint64 playerGuid, uint32 team) : BattlegroundScore(playerGuid, team), BasesAssaulted(0), BasesDefended(0) { }

        void UpdateScore(uint32 type, uint32 value) override
        {
            switch (type)
            {
                case SCORE_BASES_ASSAULTED:
                    BasesAssaulted += value;
                    break;
                case SCORE_BASES_DEFENDED:
                    BasesDefended += value;
                    break;
                default:
                    BattlegroundScore::UpdateScore(type, value);
                    break;
            }
        }

        uint32 BasesAssaulted;
        uint32 BasesDefended;
};

class BattlegroundBFG : public Battleground
{
    friend class BattlegroundMgr;

    public:
        BattlegroundBFG();
        ~BattlegroundBFG();

        void Update(uint32 diff);

        /* inherited from BattlegroundClass */
        void AddPlayer(Player* player);
        virtual void StartingEventCloseDoors();
        virtual void StartingEventOpenDoors();
        void RemovePlayer(Player* player, uint64 guid, uint32 team);
        void HandleAreaTrigger(Player* Source, uint32 Trigger);
        virtual bool SetupBattleground();
        virtual void Reset();
        void EndBattleground(uint32 winner);
        virtual WorldSafeLocsEntry const* GetClosestGraveYard(Player* player);

        /* Score-keeping */
        virtual void UpdatePlayerScore(Player *Source, uint32 type, uint32 value, bool doAddHonor = true);

        virtual void FillInitialWorldStates(WorldPacket& data);

        /* Nodes occupying */
        virtual void EventPlayerClickedOnFlag(Player* source, GameObject* target_obj);

        /* achievement requirements. */
        bool IsAllNodesConrolledByTeam(uint32 team) const;
        bool IsTeamScores500Disadvantage(uint32 team) const { return m_TeamScores500Disadvantage[GetTeamIndexByTeamId(team)]; }

    private:

        /* GameObject spawning/removing */
        void _CreateBanner(uint8 node, uint8 type, uint8 teamIndex, bool delay);
        void _DelBanner(uint8 node, uint8 type, uint8 teamIndex);
        void _SendNodeUpdate(uint8 node);

        /* Creature spawning/removing */
        // TODO: need to get the peons spawns scripted
        void _NodeOccupied(uint8 node, Team team);
        void _NodeDeOccupied(uint8 node);

        int32 _GetNodeNameId(uint8 node);

        /* Nodes info:
         *  0: neutral
         *  1: ally contested
         *  2: horde contested
         *  3: ally occupied
         *  4: horde occupied
         */
        uint8               m_Nodes[GILNEAS_BG_DYNAMIC_NODES_COUNT];
        uint8               m_prevNodes[GILNEAS_BG_DYNAMIC_NODES_COUNT];
        GILNEAS_BG_BannerTimer   m_BannerTimers[GILNEAS_BG_DYNAMIC_NODES_COUNT];
        uint32              m_NodeTimers[GILNEAS_BG_DYNAMIC_NODES_COUNT];

        uint32              m_lastTick[BG_TEAMS_COUNT];
        uint32              m_HonorScoreTicks[BG_TEAMS_COUNT];
        uint32              m_ReputationScoreTicks[BG_TEAMS_COUNT];

        bool                m_IsInformedNearVictory;
        uint32              m_HonorTicks;
        uint32              m_ReputationTicks;
        bool                m_TeamScores500Disadvantage[BG_TEAMS_COUNT];
};

#endif
