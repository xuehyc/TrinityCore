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

#include "Transmogrification.h"
#include "GameConfig.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

class Transmogrification_NPC : public CreatureScript
{
public:
    Transmogrification_NPC() : CreatureScript("Transmogrification_NPC") { }

    class TransmogAI : public ScriptedAI
    {
    public:
        TransmogAI(Creature* creature) : ScriptedAI(creature) { }

        bool OnGossipHello(Player* player) override
        {
            sTransmog->OnGossipHello(player, me);
            return true;
        }

        bool OnGossipSelect(Player* player, uint32 /*menu_id*/, uint32 gossipListId) override
        {
            sTransmog->OnGossipSelect(player, me, player->PlayerTalkClass->GetGossipOptionAction(gossipListId), player->PlayerTalkClass->GetGossipOptionSender(gossipListId));
            return true;
        }

        bool OnGossipSelectCode(Player* player, uint32 /*menu_id*/, uint32 gossipListId, const char* code) override
        {
            sTransmog->OnGossipSelectCode(player, me, player->PlayerTalkClass->GetGossipOptionAction(gossipListId), player->PlayerTalkClass->GetGossipOptionSender(gossipListId), code);
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new TransmogAI(creature);
    }
};

class Transmogrification_Misc : public MiscScript
{
public:
    Transmogrification_Misc() : MiscScript("Transmogrification_Misc") { }

    void OnItemDelFromDB(CharacterDatabaseTransaction /*trans*/, ObjectGuid::LowType itemGuid) override
    {
        sTransmog->DeleteFakeFromDB(itemGuid);
    }

    void OnMirrorImageDisplayItem(const Item* item, uint32& display) override
    {
        sTransmog->MirrorImageDisplayItem(item, display);
    }
};

class Transmogrification_Player : public PlayerScript
{
public:
    Transmogrification_Player() : PlayerScript("Transmogrification_Player") { }

    void OnPlayerAfterSetVisibleItemSlot(Player* player, uint8 slot, Item* item) override
    {
        sTransmog->SetVisibleItemSlot(player, slot, item);
    }

    void OnLogin(Player* player, bool /*firstLogin*/) override
    {
        sTransmog->LoadPlayerSets(player);
    }

    void OnDelete(ObjectGuid guid, uint32 /*accountId*/) override
    {
        sTransmog->OnPlayerDelete(guid);
    }
};

class Transmogrification_World : public WorldScript
{
public:
    Transmogrification_World() : WorldScript("Transmogrification_World") { }

    void OnConfigLoad(bool reload) override
    {
        // Add bool
        sGameConfig->AddOption<bool>("Transmogrification.EnableSetInfo");
        sGameConfig->AddOption<bool>("Transmogrification.EnableSets", true);
        sGameConfig->AddOption<bool>("Transmogrification.EnableTransmogInfo", true);
        sGameConfig->AddOption<bool>("Transmogrification.RequireToken");
        sGameConfig->AddOption<bool>("Transmogrification.AllowPoor");
        sGameConfig->AddOption<bool>("Transmogrification.AllowCommon");
        sGameConfig->AddOption<bool>("Transmogrification.AllowUncommon", true);
        sGameConfig->AddOption<bool>("Transmogrification.AllowRare", true);
        sGameConfig->AddOption<bool>("Transmogrification.AllowEpic", true);
        sGameConfig->AddOption<bool>("Transmogrification.AllowLegendary");
        sGameConfig->AddOption<bool>("Transmogrification.AllowArtifact");
        sGameConfig->AddOption<bool>("Transmogrification.AllowHeirloom", true);
        sGameConfig->AddOption<bool>("Transmogrification.AllowMixedArmorTypes");
        sGameConfig->AddOption<bool>("Transmogrification.AllowMixedWeaponTypes");
        sGameConfig->AddOption<bool>("Transmogrification.AllowFishingPoles");
        sGameConfig->AddOption<bool>("Transmogrification.IgnoreReqRace");
        sGameConfig->AddOption<bool>("Transmogrification.IgnoreReqClass");
        sGameConfig->AddOption<bool>("Transmogrification.IgnoreReqSkill");
        sGameConfig->AddOption<bool>("Transmogrification.IgnoreReqSpell");
        sGameConfig->AddOption<bool>("Transmogrification.IgnoreReqLevel");
        sGameConfig->AddOption<bool>("Transmogrification.IgnoreReqEvent");
        sGameConfig->AddOption<bool>("Transmogrification.IgnoreReqStats");

        // Add int
        sGameConfig->AddOption<int32>("Transmogrification.SetNpcText", 601084);
        sGameConfig->AddOption<int32>("Transmogrification.MaxSets", 10);
        sGameConfig->AddOption<int32>("Transmogrification.SetCopperCost");
        sGameConfig->AddOption<int32>("Transmogrification.TransmogNpcText", 601083);
        sGameConfig->AddOption<int32>("Transmogrification.CopperCost");
        sGameConfig->AddOption<int32>("Transmogrification.TokenEntry", 49426);
        sGameConfig->AddOption<int32>("Transmogrification.TokenAmount", 1);

        // Add float
        sGameConfig->AddOption<float>("Transmogrification.SetCostModifier", 3.0f);
        sGameConfig->AddOption<float>("Transmogrification.ScaledCostModifier");

        // Add string
        sGameConfig->AddOption<std::string>("Transmogrification.Allowed");
        sGameConfig->AddOption<std::string>("Transmogrification.NotAllowed");

        sTransmog->LoadConfig(reload);
    }

    void OnLoadCustomScripts() override
    {
        sTransmog->Init();
    }
};

void AddSC_Transmogrification()
{
    new Transmogrification_Misc();
    new Transmogrification_NPC();
    new Transmogrification_Player();
    new Transmogrification_World();
}
