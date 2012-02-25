/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Dragonblight
SD%Complete: 100
SDComment:
SDCategory: Dragonblight
EndScriptData */

/* ContentData
npc_alexstrasza_wr_gate
EndContentData */

#include "ScriptPCH.h"
#include "ScriptedEscortAI.h"

enum eEnums
{
    QUEST_RETURN_TO_AG_A    = 12499,
    QUEST_RETURN_TO_AG_H    = 12500,
    MOVIE_ID_GATES          = 14
};

#define GOSSIP_ITEM_WHAT_HAPPENED   "Alexstrasza, can you show me what happened here?"

class npc_alexstrasza_wr_gate : public CreatureScript
{
public:
    npc_alexstrasza_wr_gate() : CreatureScript("npc_alexstrasza_wr_gate") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestRewardStatus(QUEST_RETURN_TO_AG_A) || player->GetQuestRewardStatus(QUEST_RETURN_TO_AG_H))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_WHAT_HAPPENED, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            player->SendMovieStart(MOVIE_ID_GATES);
        }

        return true;
    }
};

enum MinebombRelated
{
    QUEST_LEAVE_NOTHING_TO_CHANCE = 12277,
    UPPER_BUNNY = 27436,
    LOWER_BUNNY = 27437
};

class npc_minebomb_of_wintergarde : public CreatureScript
{
public:
    npc_minebomb_of_wintergarde() : CreatureScript("npc_minebomb_of_wintergarde") {}

    struct npc_minebomb_of_wintergardeAI : public ScriptedAI
    {
        npc_minebomb_of_wintergardeAI(Creature* c) : ScriptedAI(c) {}

        uint32 _deathTimer;
        bool _upperBunnyGranted;
        bool _lowerBunnyGranted;

        void Reset()
        {
            // be alive for approximately 10 seconds
            _deathTimer = 10 * IN_MILLISECONDS;
            _upperBunnyGranted = false;
            _lowerBunnyGranted = false;
        }

        void UpdateAI(const uint32 diff)
        {
            Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself();

            // In error case, npc can despawn immediately
            if (!owner || owner->GetQuestStatus(QUEST_LEAVE_NOTHING_TO_CHANCE) != QUEST_STATUS_INCOMPLETE)
            {
                // If we did not give a credit before, despawn
                if (!_upperBunnyGranted && !_lowerBunnyGranted)
                {
                    me->DespawnOrUnsummon();
                    return;
                }
            }

            if(!_upperBunnyGranted)
            {
                // Search for nearby upper bunny and give credits
                if (Creature* triggerBunny = me->FindNearestCreature(UPPER_BUNNY, 10.0f, true))
                {
                    owner->KilledMonsterCredit(UPPER_BUNNY, 0);
                    _upperBunnyGranted = true;
                }
            }

            if(!_lowerBunnyGranted)
            {
                // Search for nearby lower bunny and give credits
                if (Creature* triggerBunny = me->FindNearestCreature(LOWER_BUNNY, 10.0f, true))
                {
                    owner->KilledMonsterCredit(LOWER_BUNNY, 0);
                    _lowerBunnyGranted = true;
                }
            }

            if (_deathTimer)
            {
                if (_deathTimer <= diff)
                {
                    me->DespawnOrUnsummon();
                    _deathTimer = 0;
                } else _deathTimer -= diff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_minebomb_of_wintergardeAI(creature);
    }
};

void AddSC_dragonblight()
{
    new npc_alexstrasza_wr_gate;
    new npc_minebomb_of_wintergarde;
}
