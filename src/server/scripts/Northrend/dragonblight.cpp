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

    bool OnGossipHello(Player* player, Creature* me)
    {
        QuestStatus status = player->GetQuestStatus(QUEST_A_FALL_FROM_GRACE);
        if (status == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM( 0, "High Abbot, can I have a talk with you?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (uiAction)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->CLOSE_GOSSIP_MENU();
            if(creature->AI())
            {                
                creature->AI()->DoAction(ACTION_PREPARE_MOVING);
                creature->AI()->SetGUID(player->GetGUID());     // Note: This starts the escort.
            }
            break;
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

        void EnterCombat(Unit* attacker)
        {            
            if (IsEscorted())
            {
                // Note: Since we cannot enter combat while being friendly to all in a regular way, we prefer evasion over irregular behavior.
                EnterEvadeMode();
            }
            else
            {
                // If we're not friendly (i.e. not being escorted), get this handled by the base class.
                npc_escortAI::EnterCombat(attacker);
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
                        if (Player* p = GetPlayerForEscort())
                        {
                            p->KilledMonsterCredit(NPC_HIGH_ABBOT_KILL_BUNNY, 0);
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
                        me->ForcedDespawn(0);
                        break;
                    }
                }
            }
            else
            {
                if (!UpdateVictim())
                {
                    return;
                }
                DoMeleeAttackIfReady();
            }
        }

        void WaypointReached(uint32 i)
        {
            switch (i)
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
                    if (Player* p = GetPlayerForEscort())
                    {
                        // If player is out of range or has lost his aura, evade!
                        if ( !p->IsInRange(me, 0.0f, GetMaxPlayerDistance()) || (!p->HasAura(SPELL_SCARLET_RAVEN_PRIEST_IMAGE_MALE) && !p->HasAura(SPELL_SCARLET_RAVEN_PRIEST_IMAGE_FEMALE)) ) 
                        {
                            EnterEvadeMode();
                        }
                    }
                    else
                        EnterEvadeMode();   // Should not happen regularly, but...
                    break;
                case 9: // 0-8 are irrelevant, 10 is a dummy. 
                    SetEscortPaused(true);
                    if(Player* p = GetPlayerForEscort())
                        me->SetFacingToObject(p);
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
        npc_levirothAI(Creature* c) : ScriptedAI(c) {}

        void DamageTaken(Unit* attacker, uint32& damage)
        {
            // If there is no known attacker or the damage is too low to kill us, ignore it.
            if (!attacker || damage < me->GetHealth())
                return;

            // Note: This NPC gets hit by himself due to a spell (regularly, during Q11626), thus, we enforce that the killing player gets the credit.           
            if (Player* p = attacker->ToPlayer())
            {
                p->KilledMonsterCredit(NPC_LEVIROTH, 0);
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
    new npc_minebomb_of_wintergarde;
    new npc_high_abbot_lundgren;
    new npc_leviroth;
}
