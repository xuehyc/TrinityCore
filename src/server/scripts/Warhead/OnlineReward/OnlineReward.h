/*
* This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
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

#ifndef _ONLINE_REWARD_H_
#define _ONLINE_REWARD_H_

#include "Common.h"
#include "ObjectGuid.h"
#include "Player.h"
#include <unordered_map>
#include <unordered_set>

struct RewardPlayedTime
{
    uint32 ItemID;
    uint32 ItemCount;
};

struct RewardTimeHistory
{
    std::unordered_set<uint32> PerOnline;
    uint32 PerTime;
};

enum TypeReward
{
    DEFAULT_REWARD = 1,
    REWARD_PER_HOUR
};

class OnlineReward
{
public:
    static OnlineReward* instance();

    void InitSystem();
    void RewardPlayers();
    void AddRewardHistory(ObjectGuid::LowType guid);
    void DeleteRewardHistory(ObjectGuid::LowType guid);

private:
    void LoadRewards();
    bool IsExistHistory(ObjectGuid::LowType guid);
    void RewardPerOnline(Player* player);
    void RewardPerTime(Player* player);
    void SaveRewardDB();

    std::unordered_set<uint32>* GetHistoryPerOnline(ObjectGuid::LowType lowGuid);
    uint32 GetHistoryPerTime(ObjectGuid::LowType guid);

    void SendRewardForPlayer(Player* player, uint32 itemID, uint32 itemCount, uint32 secondsOnine, bool isPerOnline = true);
    void SaveDataForDB(ObjectGuid::LowType, uint32 seconds, bool isPerOnline = true);

private:
    std::unordered_map<uint32 /*time*/, RewardPlayedTime> _rewards; // for per online
    std::unordered_map<ObjectGuid::LowType /*playerGuid*/, RewardTimeHistory> _rewardHistoryDB;
};

#define sOL OnlineReward::instance()

#endif /* _ONLINE_REWARD_H_ */
