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
SDName: Dustwallow_Marsh
SD%Complete: 95
SDComment: Quest support: 11180, 558, 11126, 11142, 11174, Vendor Nat Pagle
SDCategory: Dustwallow Marsh
EndScriptData */

/* ContentData
mobs_risen_husk_spirit
npc_lady_jaina_proudmoore
npc_nat_pagle
npc_private_hendel
npc_cassa_crimsonwing - handled by npc_taxi
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"

/*######
## mobs_risen_husk_spirit
######*/

enum HauntingWitchHill
{
    // Quest
    QUEST_WHATS_HAUNTING_WITCH_HILL     = 11180,

    // General spells
    SPELL_SUMMON_RESTLESS_APPARITION    = 42511,
    SPELL_WITCH_HILL_INFORMATION_CREDIT = 42512,

    // Risen Husk specific
    SPELL_CONSUME_FLESH                 = 37933,
    NPC_RISEN_HUSK                      = 23555,

    // Risen Spirit specific
    SPELL_INTANGIBLE_PRESENCE           = 43127,
    NPC_RISEN_SPIRIT                    = 23554,

    // Events
    EVENT_CONSUME_FLESH                 = 0,
    EVENT_INTANGIBLE_PRESENCE           = 1,
};

class mobs_risen_husk_spirit : public CreatureScript
{
    public:
        mobs_risen_husk_spirit() : CreatureScript("mobs_risen_husk_spirit") { }

        struct mobs_risen_husk_spiritAI : public ScriptedAI
        {
            mobs_risen_husk_spiritAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset()
            {
                events.Reset();
                if (me->GetEntry() == NPC_RISEN_HUSK)
                    events.ScheduleEvent(EVENT_CONSUME_FLESH, 5000);
                else if (me->GetEntry() == NPC_RISEN_SPIRIT)
                    events.ScheduleEvent(EVENT_INTANGIBLE_PRESENCE, 5000);
            }

            void JustDied(Unit* killer)
            {
                if (killer->GetTypeId() == TYPEID_PLAYER)
                {
                    if (killer->ToPlayer()->GetQuestStatus(QUEST_WHATS_HAUNTING_WITCH_HILL) == QUEST_STATUS_INCOMPLETE)
                    {
                        DoCast(me, SPELL_SUMMON_RESTLESS_APPARITION, true);
                        DoCast(killer, SPELL_WITCH_HILL_INFORMATION_CREDIT, true);
                    }
                }
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_CONSUME_FLESH:
                            DoCastVictim(SPELL_CONSUME_FLESH);
                            events.ScheduleEvent(EVENT_CONSUME_FLESH, 15000);
                            break;
                        case EVENT_INTANGIBLE_PRESENCE:
                            DoCastVictim(SPELL_INTANGIBLE_PRESENCE);
                            events.ScheduleEvent(EVENT_INTANGIBLE_PRESENCE, 15000);
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mobs_risen_husk_spiritAI (creature);
        }
};

/*######
## npc_theramor_guard
######*/

enum TheramoreGuard
{
    SAY_QUEST1                                   = -1000641,
    SAY_QUEST2                                   = -1000642,
    SAY_QUEST3                                   = -1000643,
    SAY_QUEST4                                   = -1000644,
    SAY_QUEST5                                   = -1000645,
    SAY_QUEST6                                   = -1000646,
    SAY_QUEST7                                   = -1000647,
    SAY_QUEST8                                   = -1000648,
    SAY_QUEST9                                   = -1000649,

    QUEST_DISCREDITING_THE_DESERTERS             = 11133,

    NPC_THERAMORE_GUARD                          = 4979,

    SPELL_DOCTORED_LEAFLET                       = 42725,
    SPELL_PROPAGANDIZED                          = 42246,
};

#define GOSSIP_ITEM_THERAMORE_GUARD "You look like an intelligent person. Why don't you read one of these leaflets and give it some thought?"

class npc_theramore_guard : public CreatureScript
{
public:
    npc_theramore_guard() : CreatureScript("npc_theramore_guard") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_DISCREDITING_THE_DESERTERS) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_THERAMORE_GUARD, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();

        if (action == GOSSIP_SENDER_INFO)
        {
            player->CLOSE_GOSSIP_MENU();
            player->KilledMonsterCredit(NPC_THERAMORE_GUARD, 0);
            DoScriptText(SAY_QUEST1, creature);
            creature->CastSpell(creature, SPELL_DOCTORED_LEAFLET, false);
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            CAST_AI(npc_theramore_guard::npc_theramore_guardAI, creature->AI())->YellTimer = 4000;
            CAST_AI(npc_theramore_guard::npc_theramore_guardAI, creature->AI())->bYellTimer = true;
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_theramore_guardAI(creature);
    }

    struct npc_theramore_guardAI : public ScriptedAI
    {
        npc_theramore_guardAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 YellTimer;
        uint32 Step;
        bool bYellTimer;

        void Reset()
        {
            bYellTimer = false;
            Step = 0;
        }

        void UpdateAI(const uint32 Diff)
        {
            if (!me->HasAura(SPELL_PROPAGANDIZED))
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            if (bYellTimer && YellTimer <= Diff)
            {
                switch (Step)
                {
                    case 0:
                        DoScriptText(RAND(SAY_QUEST2, SAY_QUEST3, SAY_QUEST4, SAY_QUEST5, SAY_QUEST6), me);
                        YellTimer = 3000;
                        ++Step;
                        break;
                    case 1:
                        DoScriptText(RAND(SAY_QUEST7, SAY_QUEST8, SAY_QUEST9), me);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                        Step = 0;
                        bYellTimer = false;
                        break;
                }
            }
            else
                YellTimer -= Diff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_lady_jaina_proudmoore
######*/

enum LadyJaina
{
    QUEST_JAINAS_AUTOGRAPH = 558,
    SPELL_JAINAS_AUTOGRAPH = 23122,

    SPELL_BLIZZARD              = 20680,
    SPELL_FIRE_BLAST            = 20679,
    SPELL_FIREBALL              = 20692,
    SPELL_SUMMON_WATER_ELEMENT  = 20681,
    SPELL_TELEPORT              = 20682,

    QUEST_DEFENDING_ALLIANCE = 60000,

    NOTIFY_COOLDOWN    = 600000,

    SCALING_5          = 73762,
    SCALING_10         = 73824,
    SCALING_15         = 73825,
    SCALING_20         = 73826,
    SCALING_25         = 73827,
    SCALING_30         = 73828,
};

#define GOSSIP_ITEM_JAINA "I know this is rather silly but i have a young ward who is a bit shy and would like your autograph."

class npc_lady_jaina_proudmoore : public CreatureScript
{
public:
    npc_lady_jaina_proudmoore() : CreatureScript("npc_lady_jaina_proudmoore") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_SENDER_INFO)
        {
            player->SEND_GOSSIP_MENU(7012, creature->GetGUID());
            player->CastSpell(player, SPELL_JAINAS_AUTOGRAPH, false);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_JAINAS_AUTOGRAPH) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_JAINA, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    struct npc_lady_jaina_proudmooreAI : public ScriptedAI
    {
        npc_lady_jaina_proudmooreAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }

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

            events.Reset();
            events.ScheduleEvent(SPELL_BLIZZARD, 15000);
            events.ScheduleEvent(SPELL_FIRE_BLAST, 5000);
            events.ScheduleEvent(SPELL_FIREBALL, 7000);
            events.ScheduleEvent(SPELL_SUMMON_WATER_ELEMENT, 20000);
            events.ScheduleEvent(SPELL_TELEPORT, 17000);

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
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\spell_arcane_teleporttheramore.blp:24|t Lady Jaina Prachtmeer: Theramore wird nicht fallen!", 0, 0);
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
                    case SPELL_BLIZZARD:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true))
                            DoCast(target, SPELL_BLIZZARD);
                        events.ScheduleEvent(SPELL_BLIZZARD, urand(15000, 18000));
                        break;
                    case SPELL_FIRE_BLAST:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 20.0f, true))
                            DoCast(target, SPELL_FIRE_BLAST);
                        events.ScheduleEvent(SPELL_FIRE_BLAST, urand(5000, 8000));
                        break;
                    case SPELL_FIREBALL:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                            DoCast(target, SPELL_FIREBALL);
                        events.ScheduleEvent(SPELL_FIREBALL, urand(7000, 10000));
                        break;
                    case SPELL_SUMMON_WATER_ELEMENT:
                        DoCast(me, SPELL_SUMMON_WATER_ELEMENT);
                        events.ScheduleEvent(SPELL_SUMMON_WATER_ELEMENT, urand(20000, 30000));
                        break;
                    case SPELL_TELEPORT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        {
                            DoModifyThreatPercent(target, 100); // Delete Target from Threat List
                            DoCast(target, SPELL_TELEPORT);
                        }
                        events.ScheduleEvent(SPELL_TELEPORT, urand(37000, 52000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon)
        {
            Summons.Summon(summon);
        }

        void SummonedCreateDespawn(Creature* summon)
        {
            Summons.Despawn(summon);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lady_jaina_proudmooreAI(creature);
    }

};

/*######
## npc_nat_pagle
######*/

enum NatPagle
{
    QUEST_NATS_MEASURING_TAPE = 8227
};

class npc_nat_pagle : public CreatureScript
{
public:
    npc_nat_pagle() : CreatureScript("npc_nat_pagle") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->isVendor() && player->GetQuestRewardStatus(QUEST_NATS_MEASURING_TAPE))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
            player->SEND_GOSSIP_MENU(7640, creature->GetGUID());
        }
        else
            player->SEND_GOSSIP_MENU(7638, creature->GetGUID());

        return true;
    }

};

/*######
## npc_private_hendel
######*/

enum Hendel
{
    // looks like all this text ids are wrong.
    SAY_PROGRESS_1_TER          = -1000411, // signed for 3568
    SAY_PROGRESS_2_HEN          = -1000412, // signed for 3568
    SAY_PROGRESS_3_TER          = -1000413,
    SAY_PROGRESS_4_TER          = -1000414,
    EMOTE_SURRENDER             = -1000415,

    QUEST_MISSING_DIPLO_PT16    = 1324,
    FACTION_HOSTILE             = 168,                      //guessed, may be different

    NPC_SENTRY                  = 5184,                     //helps hendel
    NPC_JAINA                   = 4968,                     //appears once hendel gives up
    NPC_TERVOSH                 = 4967
};

//TODO: develop this further, end event not created
class npc_private_hendel : public CreatureScript
{
public:
    npc_private_hendel() : CreatureScript("npc_private_hendel") { }

    bool OnQuestAccept(Player* /*player*/, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_MISSING_DIPLO_PT16)
            creature->setFaction(FACTION_HOSTILE);

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_private_hendelAI(creature);
    }

    struct npc_private_hendelAI : public ScriptedAI
    {
        npc_private_hendelAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset()
        {
            me->RestoreFaction();
        }

        void AttackedBy(Unit* pAttacker)
        {
            if (me->getVictim())
                return;

            if (me->IsFriendlyTo(pAttacker))
                return;

            AttackStart(pAttacker);
        }

        void DamageTaken(Unit* pDoneBy, uint32 &Damage)
        {
            if (Damage > me->GetHealth() || me->HealthBelowPctDamaged(20, Damage))
            {
                Damage = 0;

                if (Player* player = pDoneBy->GetCharmerOrOwnerPlayerOrPlayerItself())
                    player->GroupEventHappens(QUEST_MISSING_DIPLO_PT16, me);

                DoScriptText(EMOTE_SURRENDER, me);
                EnterEvadeMode();
            }
        }
    };

};

/*######
## npc_zelfrax
######*/

Position const MovePosition = {-2967.030f, -3872.1799f, 35.620f, 0.0f};

enum Zelfrax
{
    SAY_ZELFRAX     = -1000472,
    SAY_ZELFRAX_2   = -1000473
};

class npc_zelfrax : public CreatureScript
{
public:
    npc_zelfrax() : CreatureScript("npc_zelfrax") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_zelfraxAI(creature);
    }

    struct npc_zelfraxAI : public ScriptedAI
    {
        npc_zelfraxAI(Creature* creature) : ScriptedAI(creature)
        {
            MoveToDock();
        }

        void AttackStart(Unit* who)
        {
            if (!who)
                return;

            if (me->Attack(who, true))
            {
                me->SetInCombatWith(who);
                who->SetInCombatWith(me);

                if (IsCombatMovementAllowed())
                    me->GetMotionMaster()->MoveChase(who);
            }
        }

        void MovementInform(uint32 Type, uint32 /*Id*/)
        {
            if (Type != POINT_MOTION_TYPE)
                return;

            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            SetCombatMovement(true);

            if (me->isInCombat())
                if (Unit* unit = me->getVictim())
                    me->GetMotionMaster()->MoveChase(unit);
        }

        void MoveToDock()
        {
            SetCombatMovement(false);
            me->GetMotionMaster()->MovePoint(0, MovePosition);
            DoScriptText(SAY_ZELFRAX, me);
            DoScriptText(SAY_ZELFRAX_2, me);
        }

        void UpdateAI(uint32 const /*Diff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

};

/*######
## npc_stinky
######*/

enum Stinky
{
    QUEST_STINKYS_ESCAPE_H                       = 1270,
    QUEST_STINKYS_ESCAPE_A                       = 1222,
    SAY_QUEST_ACCEPTED                           = -1000507,
    SAY_STAY_1                                   = -1000508,
    SAY_STAY_2                                   = -1000509,
    SAY_STAY_3                                   = -1000510,
    SAY_STAY_4                                   = -1000511,
    SAY_STAY_5                                   = -1000512,
    SAY_STAY_6                                   = -1000513,
    SAY_QUEST_COMPLETE                           = -1000514,
    SAY_ATTACKED_1                               = -1000515,
    EMOTE_DISAPPEAR                              = -1000516
};

class npc_stinky : public CreatureScript
{
public:
   npc_stinky() : CreatureScript("npc_stinky") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_stinkyAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
         if (quest->GetQuestId() == QUEST_STINKYS_ESCAPE_H || quest->GetQuestId() == QUEST_STINKYS_ESCAPE_A)
         {
             if (npc_stinkyAI* pEscortAI = CAST_AI(npc_stinky::npc_stinkyAI, creature->AI()))
             {
                 creature->setFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);
                 creature->SetStandState(UNIT_STAND_STATE_STAND);
                 DoScriptText(SAY_QUEST_ACCEPTED, creature);
                 pEscortAI->Start(false, false, player->GetGUID());
             }
         }
         return true;
    }

    struct npc_stinkyAI : public npc_escortAI
    {
       npc_stinkyAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 7:
                    DoScriptText(SAY_STAY_1, me, player);
                    break;
                case 11:
                    DoScriptText(SAY_STAY_2, me, player);
                    break;
                case 25:
                    DoScriptText(SAY_STAY_3, me, player);
                    break;
                case 26:
                    DoScriptText(SAY_STAY_4, me, player);
                    break;
                case 27:
                    DoScriptText(SAY_STAY_5, me, player);
                    break;
                case 28:
                    DoScriptText(SAY_STAY_6, me, player);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    break;
                case 29:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    break;
                case 37:
                    DoScriptText(SAY_QUEST_COMPLETE, me, player);
                    me->SetSpeed(MOVE_RUN, 1.2f, true);
                    me->SetWalk(false);
                    if (player->GetQuestStatus(QUEST_STINKYS_ESCAPE_H))
                        player->GroupEventHappens(QUEST_STINKYS_ESCAPE_H, me);
                    if (player->GetQuestStatus(QUEST_STINKYS_ESCAPE_A))
                        player->GroupEventHappens(QUEST_STINKYS_ESCAPE_A, me);
                    break;
                case 39:
                    DoScriptText(EMOTE_DISAPPEAR, me);
                    break;
            }
        }

        void EnterCombat(Unit* who)
        {
            DoScriptText(SAY_ATTACKED_1, me, who);
        }

        void Reset() {}

        void JustDied(Unit* /*killer*/)
        {
            Player* player = GetPlayerForEscort();
            if (player && HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (player->GetQuestStatus(QUEST_STINKYS_ESCAPE_H))
                    player->FailQuest(QUEST_STINKYS_ESCAPE_H);

                if (player->GetQuestStatus(QUEST_STINKYS_ESCAPE_A))
                    player->FailQuest(QUEST_STINKYS_ESCAPE_A);
            }
        }

       void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

enum SpellScripts
{
    SPELL_OOZE_ZAP              = 42489,
    SPELL_OOZE_ZAP_CHANNEL_END  = 42485,
    SPELL_OOZE_CHANNEL_CREDIT   = 42486,
    SPELL_ENERGIZED             = 42492,
};

class spell_ooze_zap : public SpellScriptLoader
{
    public:
        spell_ooze_zap() : SpellScriptLoader("spell_ooze_zap") { }

        class spell_ooze_zap_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ooze_zap_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_OOZE_ZAP))
                    return false;
                return true;
            }

            SpellCastResult CheckRequirement()
            {
                if (!GetCaster()->HasAura(GetSpellInfo()->Effects[EFFECT_1].CalcValue()))
                    return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW; // This is actually correct

                if (!GetExplTargetUnit())
                    return SPELL_FAILED_BAD_TARGETS;

                return SPELL_CAST_OK;
            }

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (GetHitUnit())
                    GetCaster()->CastSpell(GetHitUnit(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_ooze_zap_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
                OnCheckCast += SpellCheckCastFn(spell_ooze_zap_SpellScript::CheckRequirement);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ooze_zap_SpellScript();
        }
};

class spell_ooze_zap_channel_end : public SpellScriptLoader
{
    public:
        spell_ooze_zap_channel_end() : SpellScriptLoader("spell_ooze_zap_channel_end") { }

        class spell_ooze_zap_channel_end_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ooze_zap_channel_end_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_OOZE_ZAP_CHANNEL_END))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Player* player = GetCaster()->ToPlayer())
                    player->CastSpell(player, SPELL_OOZE_CHANNEL_CREDIT, true);
                GetHitUnit()->Kill(GetHitUnit());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_ooze_zap_channel_end_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ooze_zap_channel_end_SpellScript();
        }
};

class spell_energize_aoe : public SpellScriptLoader
{
    public:
        spell_energize_aoe() : SpellScriptLoader("spell_energize_aoe") { }

        class spell_energize_aoe_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_energize_aoe_SpellScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ENERGIZED))
                    return false;
                return true;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end();)
                {
                    if ((*itr)->GetTypeId() == TYPEID_PLAYER && (*itr)->ToPlayer()->GetQuestStatus(GetSpellInfo()->Effects[EFFECT_1].CalcValue()) == QUEST_STATUS_INCOMPLETE)
                        ++itr;
                    else
                        targets.erase(itr++);
                }
                targets.push_back(GetCaster());
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_energize_aoe_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_energize_aoe_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_energize_aoe_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENTRY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_energize_aoe_SpellScript();
        }
};

/*######
## go_blackhoof_cage
######*/

enum PrisonersOfTheGrimTotems
{
    NPC_THERAMORE_PRISONER                          = 23720,
    SAY_FREE                                        = 0,
};

class go_blackhoof_cage : public GameObjectScript
{
public:
    go_blackhoof_cage() : GameObjectScript("go_blackhoof_cage") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (Creature* prisoner = go->FindNearestCreature(NPC_THERAMORE_PRISONER, 1.0f))
        {
            go->UseDoorOrButton();
            if (player)
                player->KilledMonsterCredit(NPC_THERAMORE_PRISONER, 0);

            prisoner->AI()->Talk(SAY_FREE); // We also emote cry here (handled in creature_text.emote)
            prisoner->DespawnOrUnsummon(6000);
        }
        return true;
    }
};

void AddSC_dustwallow_marsh()
{
    new mobs_risen_husk_spirit();
    new npc_lady_jaina_proudmoore();
    new npc_nat_pagle();
    new npc_private_hendel();
    new npc_zelfrax();
    new npc_stinky();
    new npc_theramore_guard();
    new spell_ooze_zap();
    new spell_ooze_zap_channel_end();
    new spell_energize_aoe();
    new go_blackhoof_cage();
}
