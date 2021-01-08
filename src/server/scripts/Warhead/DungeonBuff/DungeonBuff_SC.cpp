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

#include "Log.h"
#include "Chat.h"
#include "GameConfig.h"
#include "Group.h"
#include "Map.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "StringConvert.h"
#include "Util.h"

class DungeonBuff
{
public:
    static DungeonBuff* instance()
    {
        static DungeonBuff instance;
        return &instance;
    }

    // Config load
    void LoadConfig()
    {
        sGameConfig->AddOption<bool>("DB.Enable");
        sGameConfig->AddOption<bool>("DB.Default.Enable");
        sGameConfig->AddOption<bool>("DB.Heroic.Enable");
        sGameConfig->AddOption<std::string>("DB.Buffs.Default");
        sGameConfig->AddOption<std::string>("DB.Buffs.Heroic");

        _IsEnableDefault = CONF_GET_BOOL("DB.Default.Enable");
        _IsEnableHeroic = CONF_GET_BOOL("DB.Heroic.Enable");

        _buffsContainerDefault.clear();
        _buffsContainerHeroic.clear();

        std::string buffsDefault = CONF_GET_STR("DB.Buffs.Default");
        std::string buffsHeroic = CONF_GET_STR("DB.Buffs.Heroic");

        auto const& tokensDefault = Warhead::Tokenize(buffsDefault, ',', true);
        auto const& tokensHeroic = Warhead::Tokenize(buffsHeroic, ',', true);

        for (uint8 i = 0; i < tokensDefault.size(); i++)
            _buffsContainerDefault[i + 1] = Warhead::StringTo<uint32>(tokensDefault[i]).value_or(0);

        for (uint8 i = 0; i < tokensHeroic.size(); i++)
            _buffsContainerHeroic[i + 1] = Warhead::StringTo<uint32>(tokensHeroic[i]).value_or(0);
    }

    // Manage system
    void ApplyBuffs(Player* player)
    {
        ClearBuffs(player);

        uint8 Diff = player->GetMap()->GetDifficulty();

        if ((!Diff && !_IsEnableDefault) || (Diff && !_IsEnableHeroic))
            return;

        uint32 SpellID = GetSpellForDungeon(Diff, GetPlayerCountInGroup(player));
        if (!SpellID)
            return;

        player->CastSpell(player, SpellID, true);
    }

    void ClearBuffs(Player* player)
    {
        if (!IsPlayerBuffed(player))
            return;

        _playerBuffedStore.erase(player->GetGUID());
    }

private:
    std::unordered_map<uint64, uint32> _playerBuffedStore;
    std::unordered_map<uint8, uint32> _buffsContainerDefault;
    std::unordered_map<uint8, uint32> _buffsContainerHeroic;

    bool IsPlayerBuffed(Player* player)
    {
        auto const& itr = _playerBuffedStore.find(player->GetGUID());
        if (itr != _playerBuffedStore.end())
            return true;

        return false;
    }

    uint32 GetPlayerCountInGroup(Player* player)
    {
        uint32 count = 1;

        if (Group* group = player->GetGroup())
            count = static_cast<uint32>(group->GetMemberSlots().size());

        return count;
    }

    uint32 GetSpellForDungeon(uint32 diff, uint32 playerCount)
    {
        if (diff)
        {
            for (auto const& itr : _buffsContainerHeroic)
                if (itr.first == playerCount)
                    return itr.second;
        }
        else
        {
            for (auto const& itr : _buffsContainerDefault)
                if (itr.first == playerCount)
                    return itr.second;
        }

        return 0;
    }

    // From config
    bool _IsEnableDefault;
    bool _IsEnableHeroic;
};

#define sDB DungeonBuff::instance()

class DungeonBuff_Player : public PlayerScript
{
public:
    DungeonBuff_Player() : PlayerScript("DungeonBuff_Player") { }

    void OnMapChanged(Player* player) override
    {
        if (!CONF_GET_BOOL("DB.Enable"))
            return;

        if (!player)
            return;

        sDB->ClearBuffs(player);

        Map* map = player->GetMap();

        if (map->IsRaid() || map->Is25ManRaid())
            return;

        if (map->IsDungeon())
            sDB->ApplyBuffs(player);
    }
};

class DungeonBuff_World : public WorldScript
{
public:
    DungeonBuff_World() : WorldScript("DungeonBuff_World") { }

    void OnConfigLoad(bool /*reload*/) override
    {
        sDB->LoadConfig();
    }
};

// Group all custom scripts
void AddSC_DungeonBuff()
{
    new DungeonBuff_World();
    new DungeonBuff_Player();
}
