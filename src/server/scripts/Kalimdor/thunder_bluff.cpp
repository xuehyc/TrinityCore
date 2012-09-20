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
SDName: Thunder_Bluff
SD%Complete: 100
SDComment: Quest support: 925
SDCategory: Thunder Bluff
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

/*#####
# npc_cairne_bloodhoof
######*/

enum CairneBloodhoof
{
    SPELL_BERSERKER_CHARGE  = 16636,
    SPELL_CLEAVE            = 16044,
    SPELL_MORTAL_STRIKE     = 16856,
    SPELL_THUNDERCLAP       = 23931,
    SPELL_UPPERCUT          = 22916,

    QUEST_DEFENDING_HORDE       = 60001,

    NOTIFY_COOLDOWN             = 600000,

    SCALING_5                   = 73816,
    SCALING_10                  = 73818,
    SCALING_15                  = 73819,
    SCALING_20                  = 73820,
    SCALING_25                  = 73821,
    SCALING_30                  = 73822,
};

#define GOSSIP_HCB "I know this is rather silly but a young ward who is a bit shy would like your hoofprint."
//TODO: verify abilities/timers
class npc_cairne_bloodhoof : public CreatureScript
{
public:
    npc_cairne_bloodhoof() : CreatureScript("npc_cairne_bloodhoof") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_SENDER_INFO)
        {
            player->CastSpell(player, 23123, false);
            player->SEND_GOSSIP_MENU(7014, creature->GetGUID());
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(925) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HCB, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

        player->SEND_GOSSIP_MENU(7013, creature->GetGUID());

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_cairne_bloodhoofAI (creature);
    }

    struct npc_cairne_bloodhoofAI : public ScriptedAI
    {
        npc_cairne_bloodhoofAI(Creature* creature) : ScriptedAI(creature) {}

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

            me->m_CombatDistance = 100.0f;

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true);

            events.ScheduleEvent(SPELL_BERSERKER_CHARGE, 30000);
            events.ScheduleEvent(SPELL_CLEAVE, 5000);
            events.ScheduleEvent(SPELL_MORTAL_STRIKE, 10000);
            events.ScheduleEvent(SPELL_THUNDERCLAP, 15000);
            events.ScheduleEvent(SPELL_UPPERCUT, 10000);

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
                    if (player->GetTeamId() != TEAM_HORDE)
                        continue; // only same faction

                    if (!player->IsPvP())
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (not flagged for PvP)", player->GetName());
                        continue; // Do not reward players who are not flagged for pvp ("no pain, no gain")
                    }

                    if (player->GetQuestStatus(QUEST_DEFENDING_HORDE) == QUEST_STATUS_INCOMPLETE)
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[x] %s (rewarded)", player->GetName());
                        player->CompleteQuest(QUEST_DEFENDING_HORDE);
                    } else
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (did not have quest %d at evade)", player->GetName(), QUEST_DEFENDING_HORDE);
                }
            } else
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected but did not qualify for Defender Credit (Anti-Farm Rule)", me->GetName(), me->GetEntry());

            if (appliedScaling)
                if (me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);

            Talk(1);
            ScriptedAI::EnterEvadeMode();
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (notifyCooldown == 0)
            {
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\achievement_leader_cairne-bloodhoof.blp:24|t Cairne Bluthuf: Für die Ehre!", 0, 0);
                notifyCooldown = NOTIFY_COOLDOWN;
            }
            Talk(0);
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
                    case SPELL_BERSERKER_CHARGE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(target, SPELL_BERSERKER_CHARGE);
                        events.ScheduleEvent(SPELL_BERSERKER_CHARGE, 25000);
                        break;
                    case SPELL_UPPERCUT:
                        DoCastVictim(SPELL_UPPERCUT);
                        events.ScheduleEvent(SPELL_UPPERCUT, 20000);
                        break;
                    case SPELL_THUNDERCLAP:
                        DoCastVictim(SPELL_THUNDERCLAP);
                        events.ScheduleEvent(SPELL_THUNDERCLAP, 15000);
                        break;
                    case SPELL_MORTAL_STRIKE:
                        DoCastVictim(SPELL_MORTAL_STRIKE);
                        events.ScheduleEvent(SPELL_MORTAL_STRIKE, 15000);
                        break;
                    case SPELL_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(SPELL_CLEAVE, 7000);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_thunder_bluff()
{
    new npc_cairne_bloodhoof();
}
