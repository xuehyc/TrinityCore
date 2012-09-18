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
SDName: Ironforge
SD%Complete: 100
SDComment: Quest support: 3702
SDCategory: Ironforge
EndScriptData */

/* ContentData
npc_royal_historian_archesonus
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

/*######
## npc_royal_historian_archesonus
######*/

#define GOSSIP_ITEM_ROYAL   "I am ready to listen"
#define GOSSIP_ITEM_ROYAL_1 "That is tragic. How did this happen?"
#define GOSSIP_ITEM_ROYAL_2 "Interesting, continue please."
#define GOSSIP_ITEM_ROYAL_3 "Unbelievable! How dare they??"
#define GOSSIP_ITEM_ROYAL_4 "Of course I will help!"

class npc_royal_historian_archesonus : public CreatureScript
{
public:
    npc_royal_historian_archesonus() : CreatureScript("npc_royal_historian_archesonus") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(2236, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(2237, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(2238, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                player->SEND_GOSSIP_MENU(2239, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(3702);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(3702) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ROYAL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            player->SEND_GOSSIP_MENU(2235, creature->GetGUID());
        }
        else
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

/*#####
# npc_magni_bronzebeard
######*/

enum MagniBronzebeard
{
    SPELL_AVATAR        = 19135,
    SPELL_KNOCK_AWAY    = 20686,
    SPELL_STORM_BOLT    = 20685,

    QUEST_DEFENDING_ALLIANCE = 60000,

    NOTIFY_COOLDOWN    = 600000,

    SCALING_5          = 73762,
    SCALING_10         = 73824,
    SCALING_15         = 73825,
    SCALING_20         = 73826,
    SCALING_25         = 73827,
    SCALING_30         = 73828,
};

class npc_magni_bronzebeard : public CreatureScript
{
public:
    npc_magni_bronzebeard() : CreatureScript("npc_magni_bronzebeard") { }

    struct npc_magni_bronzebeardAI : public ScriptedAI
    {
        npc_magni_bronzebeardAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        bool defenderCredit;
        uint32 appliedScaling;
        uint32 rescaleTimer;
        uint32 notifyCooldown;

        void Reset()
        {
            defenderCredit = false;
            appliedScaling = 0;
            rescaleTimer = 5000;
            notifyCooldown = 0;

            events.Reset();
            events.ScheduleEvent(SPELL_AVATAR, 15000);
            events.ScheduleEvent(SPELL_KNOCK_AWAY, 8000);
            events.ScheduleEvent(SPELL_STORM_BOLT, urand(7000, 9000));
        }

        void EnterEvadeMode()
        {
            if (defenderCredit)
            {
                std::list<Player*> playerList;
                Trinity::AnyPlayerInObjectRangeCheck checker(me, me->GetMap()->GetVisibilityRange(), false);
                Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, playerList, checker);
                me->VisitNearbyWorldObject(me->GetMap()->GetVisibilityRange(), searcher);
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected and Players in Range for Defender Credit are:", me->GetName(), me->GetEntry());
                for (std::list<Player*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                {
                    Player* player = (*itr);
                    if (player->GetTeamId() != TEAM_ALLIANCE)
                        continue; // only same faction

                    if (!player->IsPvP())
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (not flagged for PvP)", player->GetName());
                        continue; // Do not reward players who are not flagged for pvp ("no pain, no gain")
                    }

                    if (player->GetQuestStatus(QUEST_DEFENDING_ALLIANCE) == QUEST_STATUS_INCOMPLETE)
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[x] %s (rewarded)", player->GetName());
                        player->CompleteQuest(QUEST_DEFENDING_ALLIANCE);
                    } else
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (did not have quest %d at evade)", player->GetName(), QUEST_DEFENDING_ALLIANCE);
                }
            } else
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected but did not qualify for Defender Credit (Anti-Farm Rule)", me->GetName(), me->GetEntry());

            if (appliedScaling)
                if (me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);

            ScriptedAI::EnterEvadeMode();
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (notifyCooldown == 0)
            {
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\achievement_leader_king_magni_bronzebeard.blp:24|t König Magni Bronzebart: Angriff auf Eisenschmiede!", 0, 0);
                notifyCooldown = NOTIFY_COOLDOWN;
            }
            Talk(0);
            me->CallForHelp(60.0f); // only throne room
        }

        void HandleScaling()
        {
            // make the fight more attractive and less grinding when more players are around
            uint32 enemyCount = 0;
            std::list<HostileReference*>& threatList = me->getThreatManager().getThreatList();
            std::list<HostileReference*>::iterator itr;
            for (itr = threatList.begin(); itr != threatList.end(); ++itr)
            {
                Unit* unit = (*itr)->getTarget();
                if (unit && unit->ToPlayer())
                    enemyCount++;
            }

            uint32 newScaling = 0;
            if (enemyCount >= 17)
                newScaling = SCALING_30;
            else if (enemyCount >= 15)
                newScaling = SCALING_25;
            else if (enemyCount >= 13)
                newScaling = SCALING_20;
            else if (enemyCount >= 10)
                newScaling = SCALING_15;
            else if (enemyCount >= 7)
                newScaling = SCALING_10;
            else if (enemyCount >= 5)
                newScaling = SCALING_5;

            if (newScaling == appliedScaling)
                return; // if current scaling equals new scaling stop here
            else
            {
                if (appliedScaling > 0 && me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);
                if (newScaling > 0)
                    me->AddAura(newScaling, me);
                appliedScaling = newScaling;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            // World Notify Cooldown
            if (notifyCooldown >= diff)
                notifyCooldown -= diff;
            else
                notifyCooldown = 0;

            if (!UpdateVictim())
                return;

            // Defender Quest Credit
            if (!defenderCredit)
                if (me->getThreatManager().getThreatList().size() >= 5 && me->GetHealthPct() < 90.f) // Anti-Farming Conditions
                    defenderCredit = true;

            // Boss rescaling
            if (rescaleTimer <= diff)
            {
                HandleScaling();
                rescaleTimer = 10000;
            } else rescaleTimer -= diff;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case SPELL_AVATAR:
                        DoCast(me, SPELL_AVATAR);
                        events.ScheduleEvent(SPELL_AVATAR, 15000 + urand(12000, 15000));
                        break;
                    case SPELL_KNOCK_AWAY:
                        DoCastVictim(SPELL_KNOCK_AWAY);
                        DoResetThreat();
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                            AttackStart(target);
                        events.ScheduleEvent(SPELL_KNOCK_AWAY, urand(28000, 32000));
                        break;
                    case SPELL_STORM_BOLT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                            DoCast(target, SPELL_STORM_BOLT);
                        events.ScheduleEvent(SPELL_STORM_BOLT, urand(7000, 9000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_magni_bronzebeardAI (creature);
    }

};

/*#####
# npc_high_tinker_mekkatorque
######*/

enum HighTinkerMekkartorgue
{
    SPELL_BOMB              = 9143,
    SPELL_GOBLIN_DRAGON_GUN = 22739, // triggers 22741 in a frontal cone, increase eff0 basepoints!!!
    SPELL_SUPER_SHRINK_RAY  = 22742,
};

class npc_high_tinker_mekkatorque : public CreatureScript
{
public:
    npc_high_tinker_mekkatorque() : CreatureScript("npc_high_tinker_mekkatorque") { }

    struct npc_high_tinker_mekkatorqueAI : public ScriptedAI
    {
        npc_high_tinker_mekkatorqueAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        bool defenderCredit;
        uint32 appliedScaling;
        uint32 rescaleTimer;
        uint32 notifyCooldown;

        void Reset()
        {
            defenderCredit = false;
            appliedScaling = 0;
            rescaleTimer = 5000;
            notifyCooldown = 0;

            events.Reset();
            events.ScheduleEvent(SPELL_BOMB, 10000);
            events.ScheduleEvent(SPELL_GOBLIN_DRAGON_GUN, 15000);
            events.ScheduleEvent(SPELL_SUPER_SHRINK_RAY, 15000);
        }

        void EnterEvadeMode()
        {
            if (defenderCredit)
            {
                std::list<Player*> playerList;
                Trinity::AnyPlayerInObjectRangeCheck checker(me, me->GetMap()->GetVisibilityRange(), false);
                Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, playerList, checker);
                me->VisitNearbyWorldObject(me->GetMap()->GetVisibilityRange(), searcher);
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected and Players in Range for Defender Credit are:", me->GetName(), me->GetEntry());
                for (std::list<Player*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                {
                    Player* player = (*itr);
                    if (player->GetTeamId() != TEAM_ALLIANCE)
                        continue; // only same faction

                    if (!player->IsPvP())
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (not flagged for PvP)", player->GetName());
                        continue; // Do not reward players who are not flagged for pvp ("no pain, no gain")
                    }

                    if (player->GetQuestStatus(QUEST_DEFENDING_ALLIANCE) == QUEST_STATUS_INCOMPLETE)
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[x] %s (rewarded)", player->GetName());
                        player->CompleteQuest(QUEST_DEFENDING_ALLIANCE);
                    } else
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (did not have quest %d at evade)", player->GetName(), QUEST_DEFENDING_ALLIANCE);
                }
            } else
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected but did not qualify for Defender Credit (Anti-Farm Rule)", me->GetName(), me->GetEntry());

            if (appliedScaling)
                if (me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);

            ScriptedAI::EnterEvadeMode();
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (notifyCooldown == 0)
            {
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\inv_misc_tournaments_symbol_gnome.blp:24|t Hochtüftler Mekkadrill: Eindringlinge, haltet sie auf!", 0, 0);
                notifyCooldown = NOTIFY_COOLDOWN;
            }
            me->CallForHelp(100.0f);
        }

        void HandleScaling()
        {
            // make the fight more attractive and less grinding when more players are around
            uint32 enemyCount = 0;
            std::list<HostileReference*>& threatList = me->getThreatManager().getThreatList();
            std::list<HostileReference*>::iterator itr;
            for (itr = threatList.begin(); itr != threatList.end(); ++itr)
            {
                Unit* unit = (*itr)->getTarget();
                if (unit && unit->ToPlayer())
                    enemyCount++;
            }

            uint32 newScaling = 0;
            if (enemyCount >= 17)
                newScaling = SCALING_30;
            else if (enemyCount >= 15)
                newScaling = SCALING_25;
            else if (enemyCount >= 13)
                newScaling = SCALING_20;
            else if (enemyCount >= 10)
                newScaling = SCALING_15;
            else if (enemyCount >= 7)
                newScaling = SCALING_10;
            else if (enemyCount >= 5)
                newScaling = SCALING_5;

            if (newScaling == appliedScaling)
                return; // if current scaling equals new scaling stop here
            else
            {
                if (appliedScaling > 0 && me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);
                if (newScaling > 0)
                    me->AddAura(newScaling, me);
                appliedScaling = newScaling;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            // World Notify Cooldown
            if (notifyCooldown >= diff)
                notifyCooldown -= diff;
            else
                notifyCooldown = 0;

            if (!UpdateVictim())
                return;

            // Defender Quest Credit
            if (!defenderCredit)
                if (me->getThreatManager().getThreatList().size() >= 5 && me->GetHealthPct() < 90.f) // Anti-Farming Conditions
                    defenderCredit = true;

            // Boss rescaling
            if (rescaleTimer <= diff)
            {
                HandleScaling();
                rescaleTimer = 10000;
            } else rescaleTimer -= diff;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case SPELL_BOMB:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                            DoCast(target, SPELL_BOMB);
                        events.ScheduleEvent(SPELL_BOMB, urand(8000, 15000));
                        break;
                    case SPELL_GOBLIN_DRAGON_GUN:
                        DoCastVictim(SPELL_GOBLIN_DRAGON_GUN);
                        events.ScheduleEvent(SPELL_GOBLIN_DRAGON_GUN, urand(15000, 20000));
                        break;
                    case SPELL_SUPER_SHRINK_RAY:
                        DoCastVictim(SPELL_SUPER_SHRINK_RAY); // needs to target mutiple players, hits only one though...
                        events.ScheduleEvent(SPELL_SUPER_SHRINK_RAY, urand(25000, 35000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_high_tinker_mekkatorqueAI(creature);
    }

};

void AddSC_ironforge()
{
    new npc_royal_historian_archesonus();
    new npc_magni_bronzebeard();
    new npc_high_tinker_mekkatorque();
}
