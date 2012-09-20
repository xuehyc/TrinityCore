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
SDName: Teldrassil
SD%Complete: 100
SDComment: Quest support: 938
SDCategory: Teldrassil
EndScriptData */

/* ContentData
npc_mist
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedFollowerAI.h"

/*####
# npc_mist
####*/

enum Mist
{
    SAY_AT_HOME             = -1000323,
    EMOTE_AT_HOME           = -1000324,
    QUEST_MIST              = 938,
    NPC_ARYNIA              = 3519,
    FACTION_DARNASSUS       = 79
};

class npc_mist : public CreatureScript
{
public:
    npc_mist() : CreatureScript("npc_mist") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_MIST)
            if (npc_mistAI* pMistAI = CAST_AI(npc_mist::npc_mistAI, creature->AI()))
                pMistAI->StartFollow(player, FACTION_DARNASSUS, quest);

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_mistAI(creature);
    }

    struct npc_mistAI : public FollowerAI
    {
        npc_mistAI(Creature* creature) : FollowerAI(creature) { }

        void Reset() { }

        void MoveInLineOfSight(Unit* who)
        {
            FollowerAI::MoveInLineOfSight(who);

            if (!me->getVictim() && !HasFollowState(STATE_FOLLOW_COMPLETE) && who->GetEntry() == NPC_ARYNIA)
            {
                if (me->IsWithinDistInMap(who, 10.0f))
                {
                    DoScriptText(SAY_AT_HOME, who);
                    DoComplete();
                }
            }
        }

        void DoComplete()
        {
            DoScriptText(EMOTE_AT_HOME, me);

            Player* player = GetLeaderForFollower();
            if (player && player->GetQuestStatus(QUEST_MIST) == QUEST_STATUS_INCOMPLETE)
                player->GroupEventHappens(QUEST_MIST, me);

            //The follow is over (and for later development, run off to the woods before really end)
            SetFollowComplete();
        }

        //call not needed here, no known abilities
        /*void UpdateFollowerAI(const uint32 Diff)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }*/
    };

};

/*#####
# npc_tyrande_whisperwind
######*/

enum TyrandeWhisperwind
{
    SPELL_CLEAVE_TYRANDE    = 20691,
    SPELL_MOONFIRE          = 20690,
    SPELL_SEARING_ARROW     = 20688,
    SPELL_STARFALL          = 20687,

    QUEST_DEFENDING_ALLIANCE = 60000,

    NOTIFY_COOLDOWN    = 600000,

    SCALING_5          = 73762,
    SCALING_10         = 73824,
    SCALING_15         = 73825,
    SCALING_20         = 73826,
    SCALING_25         = 73827,
    SCALING_30         = 73828,
};

class npc_tyrande_whisperwind_darnassus : public CreatureScript
{
public:
    npc_tyrande_whisperwind_darnassus() : CreatureScript("npc_tyrande_whisperwind_darnassus") { }

    struct npc_tyrande_whisperwind_darnassusAI : public ScriptedAI
    {
        npc_tyrande_whisperwind_darnassusAI(Creature* creature) : ScriptedAI(creature) { }

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

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true);

            events.Reset();
            events.ScheduleEvent(SPELL_CLEAVE_TYRANDE, 5000);
            events.ScheduleEvent(SPELL_SEARING_ARROW, 8000);
            events.ScheduleEvent(SPELL_MOONFIRE, 12000);
            events.ScheduleEvent(SPELL_STARFALL, 15000);
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
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\achievement_leader_tyrande_whisperwind.blp:24|t Tyrande Wisperwind: Rettet Teldrassil!", 0, 0);
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
            if (!UpdateVictim())
                return;

            // World Notify Cooldown
            if (notifyCooldown >= diff)
                notifyCooldown -= diff;
            else
                notifyCooldown = 0;

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
                    case SPELL_CLEAVE_TYRANDE:
                        DoCastVictim(SPELL_CLEAVE_TYRANDE);
                        events.ScheduleEvent(SPELL_CLEAVE_TYRANDE, urand(5000, 7000));
                        break;
                    case SPELL_SEARING_ARROW:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                            DoCast(target, SPELL_SEARING_ARROW);
                        events.ScheduleEvent(SPELL_SEARING_ARROW, 8000);
                        break;
                    case SPELL_MOONFIRE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                            DoCast(target, SPELL_MOONFIRE);
                        events.ScheduleEvent(SPELL_MOONFIRE, urand(11000, 15000));
                        break;
                    case SPELL_STARFALL:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true))
                            DoCast(target, SPELL_STARFALL);
                        events.ScheduleEvent(SPELL_STARFALL, urand(15000, 19000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_tyrande_whisperwind_darnassusAI(creature);
    }

};

/*#####
# npc_fandral_staghelm
######*/

enum FandralStaghelm
{
    SPELL_ENTANGLING_ROOTS  = 20699,
    SPELL_REJUVENATION      = 20701,
    SPELL_SUMMON_TREANTS    = 20702,
    SPELL_WRATH             = 20698,
    SPELL_HURRICANE         = 63272,

    NPC_TREANT              = 31802, // this might be needed for summon handling in JustSummoned at a later point
};

class npc_fandral_staghelm : public CreatureScript
{
public:
    npc_fandral_staghelm() : CreatureScript("npc_fandral_staghelm") { }

    struct npc_fandral_staghelmAI : public ScriptedAI
    {
        npc_fandral_staghelmAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }

        EventMap events;
        SummonList Summons;

        bool defenderCredit;
        uint32 appliedScaling;
        uint32 rescaleTimer;
        uint32 notifyCooldown;
        uint64 hurricaneTarget;

        void Reset()
        {
            defenderCredit = false;
            appliedScaling = 0;
            rescaleTimer = 5000;
            notifyCooldown = 0;
            hurricaneTarget = 0;

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true);

            events.Reset();
            events.ScheduleEvent(SPELL_ENTANGLING_ROOTS, 7000);
            events.ScheduleEvent(SPELL_REJUVENATION, urand(15000, 20000));
            events.ScheduleEvent(SPELL_SUMMON_TREANTS, 15000);
            events.ScheduleEvent(SPELL_WRATH, 5000);

            Summons.DespawnAll();
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
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\class_druid.blp:24|t Erzdruide Fandral Hirschhaupt: Sie stürmen die Enklave des Cenarius!", 0, 0);
                notifyCooldown = NOTIFY_COOLDOWN;
            }
            me->CallForHelp(40.0f);
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
                    case SPELL_ENTANGLING_ROOTS:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true))
                        {
                            hurricaneTarget = target->GetGUID();
                            DoCast(target, SPELL_ENTANGLING_ROOTS);
                        }
                        if (urand(1,3) == 3) // 33% chance for hurricane aoe on rooted target
                            events.ScheduleEvent(SPELL_HURRICANE, urand(1500, 3000));
                        events.ScheduleEvent(SPELL_ENTANGLING_ROOTS, urand(7000, 11000));
                        break;
                    case SPELL_REJUVENATION:
                        DoCast(me, SPELL_REJUVENATION);
                        events.ScheduleEvent(SPELL_REJUVENATION, urand(15000, 20000));
                        break;
                    case SPELL_SUMMON_TREANTS:
                        if (Summons.size() < 4)
                            DoCast(me, SPELL_SUMMON_TREANTS);
                        events.ScheduleEvent(SPELL_SUMMON_TREANTS, urand(25000, 30000));
                        break;
                    case SPELL_WRATH:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f, true))
                            DoCast(target, SPELL_WRATH);
                        events.ScheduleEvent(SPELL_WRATH, urand(5000, 8000));
                        break;
                    case SPELL_HURRICANE:
                        if (Unit* player = ObjectAccessor::GetUnit(*me, hurricaneTarget))
                            DoCast(player, SPELL_HURRICANE);
                        hurricaneTarget = 0;
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon)
        {
            Summons.Summon(summon);

            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 12.0f, true))
            {
                summon->GetMotionMaster()->MoveChase(target);
                summon->SetSpeed(MOVE_RUN, 1.2f);
                summon->Attack(target, true);
            }
        }

        void SummonedCreatureDespawn(Creature* summon)
        {
            Summons.Despawn(summon);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_fandral_staghelmAI(creature);
    }
};

void AddSC_teldrassil()
{
    new npc_mist();
    new npc_tyrande_whisperwind_darnassus();
    new npc_fandral_staghelm();
}
