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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
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

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            player->CLOSE_GOSSIP_MENU();
            player->SendMovieStart(MOVIE_ID_GATES);
        }

        return true;
    }
};

/*######
## Quest Strengthen the Ancients (12096|12092)
######*/

enum StrengthenAncientsMisc
{
    SAY_WALKER_FRIENDLY = 0,
    SAY_WALKER_ENEMY = 1,
    SAY_LOTHALOR = 0,

    SPELL_CREATE_ITEM_BARK = 47550,
    SPELL_CONFUSED = 47044,

    NPC_LOTHALOR = 26321,

    FACTION_WALKER_ENEMY = 14,
};

class spell_q12096_q12092_dummy : public SpellScriptLoader // Strengthen the Ancients: On Interact Dummy to Woodlands Walker
{
public:
    spell_q12096_q12092_dummy() : SpellScriptLoader("spell_q12096_q12092_dummy") { }

    class spell_q12096_q12092_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12096_q12092_dummy_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            uint32 roll = rand() % 2;

            Creature* tree = GetHitCreature();
            Player* player = GetCaster()->ToPlayer();

            if (!tree || !player)
                return;

            tree->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);

            if (roll == 1) // friendly version
            {
                tree->CastSpell(player, SPELL_CREATE_ITEM_BARK);
                tree->AI()->Talk(SAY_WALKER_FRIENDLY, player->GetGUID());
                tree->DespawnOrUnsummon(1000);
            }
            else if (roll == 0) // enemy version
            {
                tree->AI()->Talk(SAY_WALKER_ENEMY, player->GetGUID());
                tree->setFaction(FACTION_WALKER_ENEMY);
                tree->Attack(player, true);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_dummy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12096_q12092_dummy_SpellScript();
    }
};

class spell_q12096_q12092_bark : public SpellScriptLoader // Bark of the Walkers
{
public:
    spell_q12096_q12092_bark() : SpellScriptLoader("spell_q12096_q12092_bark") { }

    class spell_q12096_q12092_bark_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12096_q12092_bark_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Creature* lothalor = GetHitCreature();
            if (!lothalor || lothalor->GetEntry() != NPC_LOTHALOR)
                return;

            lothalor->AI()->Talk(SAY_LOTHALOR);
            lothalor->RemoveAura(SPELL_CONFUSED);
            lothalor->DespawnOrUnsummon(4000);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_q12096_q12092_bark_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12096_q12092_bark_SpellScript();
    }
};

enum HighAbbot
{
    ACTION_PREPARE_MOVING = 0,

    QUEST_A_FALL_FROM_GRACE = 12274,
    NPC_HIGH_ABBOT_KILL_BUNNY = 27444,

    SAY_HIGH_ABBOT_FOLLOW_ME = -1700070,
    SAY_HIGH_ABBOT_DISGUISE_FAILED = -1700071,
    SAY_HIGH_ABBOT_THE_MASTER = -1700072,
    SAY_HIGH_ABBOT_NOT_DIE_BY_YOUR_HAND = -1700073,
    SAY_HIGH_ABBOT_MY_CHOOSING = -1700074,
    SAY_HIGH_ABBOT_SCREAMING_JUMP = -1700075,

    EVENT_SPEECH_DISGUISE = 1,
    EVENT_SPEECH_MASTER = 2,
    EVENT_SPEECH_NOT_YOU = 3,
    EVENT_SPEECH_CHOOSING = 4,
    EVENT_JUMP_OFF_CLIFF_PT1 = 5,
    EVENT_JUMP_OFF_CLIFF_PT2 = 6,
    EVENT_DIE = 7,

    FACTION_FRIENDLY_TO_ALL = 35,
    FACTION_SCARLET_CRUSADE = 67,

    SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE   = 48763,
    SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE = 48761
};

Position dummyTarget = {2735.9446f, -533.7491f, 105.7517f};
Position jumpTarget = {2728.7979f, -553.4839f, 17.2747f};    // Note that orientation is not required here, since he dies :o

class npc_high_abbot_lundgren : public CreatureScript
{
public:
    npc_high_abbot_lundgren() : CreatureScript("npc_high_abbot_lundgren") {}

    bool OnGossipHello(Player* player, Creature* creature)
    {
        QuestStatus status = player->GetQuestStatus(QUEST_A_FALL_FROM_GRACE);
        if (status == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM( 0, "High Abbot, can I have a talk with you?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
            {
                player->CLOSE_GOSSIP_MENU();

                if(creature->AI())
                {
                    creature->AI()->DoAction(ACTION_PREPARE_MOVING);
                    creature->AI()->SetGUID(player->GetGUID());     // Note: This starts the escort.
                }
                break;
            }
        }
        return true;
    }

    struct npc_high_abbot_lundgrenAI : public npc_escortAI
    {
        npc_high_abbot_lundgrenAI(Creature* creature) : npc_escortAI(creature) {}

        void Reset()
        {
            me->setFaction(FACTION_SCARLET_CRUSADE);
        }

        void EnterCombat(Unit* who)
        {
            if (IsEscorted())
            {
                // Note: Since we cannot enter combat while being friendly to all in a regular way, we prefer evasion over irregular behavior.
                EnterEvadeMode();
            }
            else
            {
                // If we're not friendly (i.e. not being escorted), get this handled by the base class.
                npc_escortAI::EnterCombat(who);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage)
        {
            if(IsEscorted())
                damage = 0;
        }

        void SetGUID(uint64 activator, int32 /* = 0 */)
        {
            Start(false, false, activator);
        }

        void DoAction(const int32 actionid)
        {
            switch (actionid)
            {
                case ACTION_PREPARE_MOVING:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    DoScriptText(SAY_HIGH_ABBOT_FOLLOW_ME, me);
                    me->setFaction(FACTION_FRIENDLY_TO_ALL);
                    break;
            }
        }

        void UpdateEscortAI(const uint32 diff)
        {
            if (IsEscorted())
            {
                events.Update(diff);
                while (uint32 event = events.ExecuteEvent())
                {
                    switch (event)
                    {
                        case EVENT_SPEECH_DISGUISE:
                            DoScriptText(SAY_HIGH_ABBOT_DISGUISE_FAILED, me);
                            events.ScheduleEvent(EVENT_SPEECH_MASTER, 5000);
                            break;
                        case EVENT_SPEECH_MASTER:
                            DoScriptText(SAY_HIGH_ABBOT_THE_MASTER, me);
                            events.ScheduleEvent(EVENT_SPEECH_NOT_YOU, 5000);
                            break;
                        case EVENT_SPEECH_NOT_YOU:
                            DoScriptText(SAY_HIGH_ABBOT_NOT_DIE_BY_YOUR_HAND, me);
                            events.ScheduleEvent(EVENT_SPEECH_CHOOSING, 5000);
                            break;
                        case EVENT_SPEECH_CHOOSING:
                            DoScriptText(SAY_HIGH_ABBOT_MY_CHOOSING, me);
                            events.ScheduleEvent(EVENT_JUMP_OFF_CLIFF_PT1, 5000);
                            break;
                        case EVENT_JUMP_OFF_CLIFF_PT1:
                            if (Player* player = GetPlayerForEscort())
                            {
                                player->KilledMonsterCredit(NPC_HIGH_ABBOT_KILL_BUNNY, 0);
                            }
                            me->GetMotionMaster()->MoveJump(dummyTarget.GetPositionX(), dummyTarget.GetPositionY(), dummyTarget.GetPositionZ(), 10.0f, 10.0f);
                            events.ScheduleEvent(EVENT_JUMP_OFF_CLIFF_PT2, 200);
                            break;
                        case EVENT_JUMP_OFF_CLIFF_PT2:
                            DoScriptText(SAY_HIGH_ABBOT_SCREAMING_JUMP, me);
                            me->GetMotionMaster()->MoveJump(jumpTarget.GetPositionX(), jumpTarget.GetPositionY(), jumpTarget.GetPositionZ(), 30.0f, 30.0f);
                            events.ScheduleEvent(EVENT_DIE, 10000);
                            break;
                        case EVENT_DIE:
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                            me->DespawnOrUnsummon();
                            break;
                    }
                }
            }
            else
            {
                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 0:
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                    if (Player* player = GetPlayerForEscort())
                    {
                        // If player is out of range or has lost his aura, evade!
                        if (!player->IsInRange(me, 0.0f, GetMaxPlayerDistance()) || (!player->HasAura(SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE) && !player->HasAura(SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE)))
                        {
                            EnterEvadeMode();
                        }
                    }
                    else
                        EnterEvadeMode();   // Should not happen regularly, but...
                    break;
                case 9: // 0-8 are irrelevant, 10 is a dummy.
                    SetEscortPaused(true);
                    if(Player* player = GetPlayerForEscort())
                        me->SetFacingToObject(player);
                    else
                        EnterEvadeMode();   // Should not happen regularly, but...
                    events.ScheduleEvent(EVENT_SPEECH_DISGUISE, 1000);
                    break;
            }
        }

        EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_high_abbot_lundgrenAI(creature);
    }
};

enum
{
    NPC_LEVIROTH = 26452
};

class npc_leviroth : public CreatureScript
{
public:
    npc_leviroth() : CreatureScript("npc_leviroth") {}

    struct npc_levirothAI : public ScriptedAI
    {
        npc_levirothAI(Creature* creature) : ScriptedAI(creature) {}

        void DamageTaken(Unit* attacker, uint32& damage)
        {
            // If there is no known attacker or the damage is too low to kill us, ignore it.
            if (!attacker || damage < me->GetHealth())
                return;

            // Note: This NPC gets hit by himself due to a spell (regularly, during Q11626), thus, we enforce that the killing player gets the credit.
            if (Player* player = attacker->ToPlayer())
            {
                player->KilledMonsterCredit(NPC_LEVIROTH, 0);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_levirothAI(creature);
    }
};

void AddSC_dragonblight()
{
    new npc_alexstrasza_wr_gate;
    new spell_q12096_q12092_dummy;
    new spell_q12096_q12092_bark;
    new npc_high_abbot_lundgren;
    new npc_leviroth;
}
