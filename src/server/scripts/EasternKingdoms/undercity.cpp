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
SDName: Undercity
SD%Complete: 95
SDComment: Quest support: 6628, 9180(post-event).
SDCategory: Undercity
EndScriptData */

/* ContentData
npc_lady_sylvanas_windrunner
npc_highborne_lamenter
npc_parqual_fintallas
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

/*######
## npc_lady_sylvanas_windrunner
######*/

enum Sylvanas
{
    QUEST_JOURNEY_TO_UNDERCITY  = 9180,
    SAY_LAMENT_END              = -1000196,
    EMOTE_LAMENT_END            = -1000197,

    SOUND_CREDIT                = 10896,
    ENTRY_HIGHBORNE_LAMENTER    = 21628,
    ENTRY_HIGHBORNE_BUNNY       = 21641,
    ENTRY_SKELETON              = 6412,

    SPELL_HIGHBORNE_AURA        = 37090,
    SPELL_SYLVANAS_CAST         = 36568,
    SPELL_RIBBON_OF_SOULS       = 34432,                   //the real one to use might be 37099

    // Combat spells
    SPELL_BLACK_ARROW           = 59712,
    SPELL_FADE                  = 20672,
    SPELL_FADE_BLINK            = 29211,
    SPELL_MULTI_SHOT            = 59713,
    SPELL_SHOOT_SYLVANAS        = 59710,
    SPELL_SUMMON_SKELETON       = 59711,

    QUEST_DEFENDING_HORDE       = 60001,

    NOTIFY_COOLDOWN             = 600000,

    SCALING_5                   = 73816,
    SCALING_10                  = 73818,
    SCALING_15                  = 73819,
    SCALING_20                  = 73820,
    SCALING_25                  = 73821,
    SCALING_30                  = 73822,
};

float HighborneLoc[4][3]=
{
    {1285.41f, 312.47f, 0.51f},
    {1286.96f, 310.40f, 1.00f},
    {1289.66f, 309.66f, 1.52f},
    {1292.51f, 310.50f, 1.99f},
};

#define HIGHBORNE_LOC_Y             -61.00f
#define HIGHBORNE_LOC_Y_NEW         -55.50f

class npc_lady_sylvanas_windrunner : public CreatureScript
{
public:
    npc_lady_sylvanas_windrunner() : CreatureScript("npc_lady_sylvanas_windrunner") { }

    bool OnQuestReward(Player* /*player*/, Creature* creature, const Quest *_Quest, uint32 /*slot*/)
    {
        if (_Quest->GetQuestId() == QUEST_JOURNEY_TO_UNDERCITY)
        {
            CAST_AI(npc_lady_sylvanas_windrunner::npc_lady_sylvanas_windrunnerAI, creature->AI())->LamentEvent = true;
            CAST_AI(npc_lady_sylvanas_windrunner::npc_lady_sylvanas_windrunnerAI, creature->AI())->DoPlaySoundToSet(creature, SOUND_CREDIT);
            creature->CastSpell(creature, SPELL_SYLVANAS_CAST, false);

            for (uint8 i = 0; i < 4; ++i)
                creature->SummonCreature(ENTRY_HIGHBORNE_LAMENTER, HighborneLoc[i][0], HighborneLoc[i][1], HIGHBORNE_LOC_Y, HighborneLoc[i][2], TEMPSUMMON_TIMED_DESPAWN, 160000);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lady_sylvanas_windrunnerAI (creature);
    }

    struct npc_lady_sylvanas_windrunnerAI : public ScriptedAI
    {
        npc_lady_sylvanas_windrunnerAI(Creature* creature) : ScriptedAI(creature), Summons(me) {}

        uint32 LamentEventTimer;
        bool LamentEvent;
        uint64 targetGUID;

        EventMap events;
        SummonList Summons;

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

            LamentEventTimer = 5000;
            LamentEvent = false;
            targetGUID = 0;

            events.Reset();
            events.ScheduleEvent(SPELL_BLACK_ARROW, 15000);
            events.ScheduleEvent(SPELL_FADE, 15000);
            events.ScheduleEvent(SPELL_MULTI_SHOT, 11000);
            events.ScheduleEvent(SPELL_SHOOT_SYLVANAS, 5000);
            events.ScheduleEvent(SPELL_SUMMON_SKELETON, 17000);

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

            ScriptedAI::EnterEvadeMode();
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (notifyCooldown == 0)
            {
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\achievement_leader_sylvanas.blp:24|t Lady Sylvanas Windläufer: Lasst niemanden am Leben!", 0, 0);
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

        void JustSummoned(Creature* summoned)
        {
            if (summoned->GetEntry() == ENTRY_HIGHBORNE_BUNNY)
            {
                if (Creature* target = Unit::GetCreature(*summoned, targetGUID))
                {
                    target->MonsterMoveWithSpeed(target->GetPositionX(), target->GetPositionY(), me->GetPositionZ()+15.0f, 0);
                    target->SetPosition(target->GetPositionX(), target->GetPositionY(), me->GetPositionZ()+15.0f, 0.0f);
                    summoned->CastSpell(target, SPELL_RIBBON_OF_SOULS, false);
                }

                summoned->SetDisableGravity(true);
                targetGUID = summoned->GetGUID();
            }

            if (summoned->GetEntry() == ENTRY_SKELETON)
            {
                Summons.Summon(summoned);
                if (Unit* randomTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                    summoned->Attack(randomTarget, true);
                else if (me->getVictim())
                    summoned->Attack(me->getVictim(), true);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (LamentEvent)
            {
                if (LamentEventTimer <= diff)
                {
                    DoSummon(ENTRY_HIGHBORNE_BUNNY, me, 10.0f, 3000, TEMPSUMMON_TIMED_DESPAWN);

                    LamentEventTimer = 2000;
                    if (!me->HasAura(SPELL_SYLVANAS_CAST))
                    {
                        DoScriptText(SAY_LAMENT_END, me);
                        DoScriptText(EMOTE_LAMENT_END, me);
                        LamentEvent = false;
                    }
                } else LamentEventTimer -= diff;
            }

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
                    case SPELL_BLACK_ARROW:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f, true))
                            DoCast(target, SPELL_BLACK_ARROW);
                        events.ScheduleEvent(SPELL_BLACK_ARROW, urand(15000, 25000));
                        break;
                    case SPELL_FADE:
                        DoCast(me, SPELL_FADE);
                        events.ScheduleEvent(SPELL_FADE, urand(25000, 35000));
                        break;
                    case SPELL_MULTI_SHOT:
                        DoCastVictim(SPELL_MULTI_SHOT);
                        events.ScheduleEvent(SPELL_MULTI_SHOT, urand(11000, 14000));
                        break;
                    case SPELL_SHOOT_SYLVANAS:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true))
                            if (me->GetDistance(target) > 5.0f)
                                DoCast(target, SPELL_SHOOT_SYLVANAS);
                        events.ScheduleEvent(SPELL_SHOOT_SYLVANAS, urand(6000, 9000));
                        break;
                    case SPELL_SUMMON_SKELETON:
                        if (Summons.size() < 7)
                            DoCast(me, SPELL_SUMMON_SKELETON);
                        events.ScheduleEvent(SPELL_SUMMON_SKELETON, urand(17000, 23000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void SummonedCreateDespawn(Creature* summon)
        {
            Summons.Despawn(summon);
        }
    };
};

/*######
## npc_highborne_lamenter
######*/

class npc_highborne_lamenter : public CreatureScript
{
public:
    npc_highborne_lamenter() : CreatureScript("npc_highborne_lamenter") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_highborne_lamenterAI (creature);
    }

    struct npc_highborne_lamenterAI : public ScriptedAI
    {
        npc_highborne_lamenterAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 EventMoveTimer;
        uint32 EventCastTimer;
        bool EventMove;
        bool EventCast;

        void Reset()
        {
            EventMoveTimer = 10000;
            EventCastTimer = 17500;
            EventMove = true;
            EventCast = true;
        }

        void EnterCombat(Unit* /*who*/) {}

        void UpdateAI(const uint32 diff)
        {
            if (EventMove)
            {
                if (EventMoveTimer <= diff)
                {
                    me->SetDisableGravity(true);
                    me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), HIGHBORNE_LOC_Y_NEW, me->GetDistance(me->GetPositionX(), me->GetPositionY(), HIGHBORNE_LOC_Y_NEW) / (5000 * 0.001f));
                    me->SetPosition(me->GetPositionX(), me->GetPositionY(), HIGHBORNE_LOC_Y_NEW, me->GetOrientation());
                    EventMove = false;
                } else EventMoveTimer -= diff;
            }
            if (EventCast)
            {
                if (EventCastTimer <= diff)
                {
                    DoCast(me, SPELL_HIGHBORNE_AURA);
                    EventCast = false;
                } else EventCastTimer -= diff;
            }
        }
    };
};

/*######
## npc_parqual_fintallas
######*/

#define SPELL_MARK_OF_SHAME 6767

#define GOSSIP_HPF1 "Gul'dan"
#define GOSSIP_HPF2 "Kel'Thuzad"
#define GOSSIP_HPF3 "Ner'zhul"

class npc_parqual_fintallas : public CreatureScript
{
public:
    npc_parqual_fintallas() : CreatureScript("npc_parqual_fintallas") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->CastSpell(player, SPELL_MARK_OF_SHAME, false);
        }
        if (action == GOSSIP_ACTION_INFO_DEF+2)
        {
            player->CLOSE_GOSSIP_MENU();
            player->AreaExploredOrEventHappens(6628);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(6628) == QUEST_STATUS_INCOMPLETE && !player->HasAura(SPELL_MARK_OF_SHAME))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HPF1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HPF2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HPF3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->SEND_GOSSIP_MENU(5822, creature->GetGUID());
        }
        else
            player->SEND_GOSSIP_MENU(5821, creature->GetGUID());

        return true;
    }
};

/*######
## AddSC
######*/

void AddSC_undercity()
{
    new npc_lady_sylvanas_windrunner();
    new npc_highborne_lamenter();
    new npc_parqual_fintallas();
}
