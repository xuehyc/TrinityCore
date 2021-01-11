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

#include "UnbindInstance.h"
#include "Chat.h"
#include "GameConfig.h"
#include "Log.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "StringConvert.h"

class UnbindInstance_Creature : public CreatureScript
{
public:
    UnbindInstance_Creature() : CreatureScript("UnbindInstance_Creature") { }

    class UnbindInstance_CreatureAI : public ScriptedAI
    {
    public:
        UnbindInstance_CreatureAI(Creature* creature) : ScriptedAI(creature) { }

        bool OnGossipHello(Player* player) override
        {
            if (!CONF_GET_BOOL("UnbindInsance.Enable"))
                return true;

            sUI->SendGossipHello(player, me);
            return true;
        }

        bool OnGossipSelect(Player* player, uint32 /*menu_id*/, uint32 gossipListId) override
        {
            ClearGossipMenuFor(player);

            uint32 action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            uint32 sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);

            if (sender >= GOSSIP_SENDER_DIFFICULTY)
            {
                sUI->BindInfo(player, me, sender, action);
                return true;
            }

            switch (action)
            {
                case GOSSIP_ACTION_INFO_MAIN_MENU:
                    sUI->SendGossipHello(player, me);
                    break;
                case GOSSIP_ACTION_INFO_DUNGEON_HEROIC:
                    sUI->SendBindList(player, me, 1, false);
                    break;
                case GOSSIP_ACTION_INFO_RAID_10_NORMAL:
                    sUI->SendBindList(player, me, 0);
                    break;
                case GOSSIP_ACTION_INFO_RAID_25_NORMAL:
                    sUI->SendBindList(player, me, 1);
                    break;
                case GOSSIP_ACTION_INFO_RAID_10_HEROIC:
                    sUI->SendBindList(player, me, 2);
                    break;
                case GOSSIP_ACTION_INFO_RAID_25_HEROIC:
                    sUI->SendBindList(player, me, 3);
                    break;
                default:
                    break;
            }

            return true;
        }

        bool OnGossipSelectCode(Player* player, uint32 /*menu_id*/, uint32 gossipListId, const char* code) override
        {
            sUI->Unbind(player, me, player->PlayerTalkClass->GetGossipOptionSender(gossipListId), player->PlayerTalkClass->GetGossipOptionAction(gossipListId), *Warhead::StringTo<uint32>(code));
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new UnbindInstance_CreatureAI(creature);
    }
};

class UnbindInstance_World : public WorldScript
{
public:
    UnbindInstance_World() : WorldScript("UnbindInstance_World") { }

    void OnConfigLoad(bool /*reload*/) override
    {
        sGameConfig->AddOption<bool>("UnbindInsance.Enable");
    }

    void OnLoadCustomScripts() override
    {
        sUI->Init();
    }
};

// Group all custom scripts
void AddSC_UnbindInstance()
{
    new UnbindInstance_Creature();
    new UnbindInstance_World();
}
