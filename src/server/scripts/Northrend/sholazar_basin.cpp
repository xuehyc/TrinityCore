/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
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
SDName: Sholazar_Basin
SD%Complete: 100
SDComment: Quest support: 12570, 12573, 12621.
SDCategory: Sholazar_Basin
EndScriptData */

/* ContentData
npc_injured_rainspeaker_oracle
npc_vekjik
avatar_of_freya
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "SpellScript.h"

/*######
## npc_injured_rainspeaker_oracle
######*/

#define GOSSIP_ITEM1 "I am ready to travel to your village now."

enum eRainspeaker
{
    SAY_START_IRO                       = -1571000,
    SAY_QUEST_ACCEPT_IRO                = -1571001,
    SAY_END_IRO                         = -1571002,

    QUEST_FORTUNATE_MISUNDERSTANDINGS   = 12570,
    QUEST_JUST_FOLLOWING_ORDERS         = 12540,
    FACTION_ESCORTEE_A                  = 774,
    FACTION_ESCORTEE_H                  = 775,
    NPC_INJURED_RAINSPEAKER_ORACLE      = 28217
};

class npc_injured_rainspeaker_oracle : public CreatureScript
{
public:
    npc_injured_rainspeaker_oracle() : CreatureScript("npc_injured_rainspeaker_oracle") { }

    struct npc_injured_rainspeaker_oracleAI : public npc_escortAI
    {
        npc_injured_rainspeaker_oracleAI(Creature* creature) : npc_escortAI(creature) { c_guid = creature->GetGUID(); }

        uint64 c_guid;

        void Reset()
        {
            me->RestoreFaction();
            // if we will have other way to assign this to only one npc remove this part
            if (GUID_LOPART(me->GetGUID()) != 101030)
            {
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    SetRun();
                    break;
                case 10:
                case 11:
                case 12:
                case 13:
                case 14:
                case 15:
                case 16:
                case 17:
                case 18:
                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_SWIMMING);
                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);
                    me->SetSpeed(MOVE_SWIM, 0.85f, true);
                    me->AddUnitMovementFlag(MOVEMENTFLAG_SWIMMING | MOVEMENTFLAG_DISABLE_GRAVITY);
                    break;
                case 19:
                    me->SetUnitMovementFlags(MOVEMENTFLAG_FALLING);
                    break;
                case 28:
                    player->GroupEventHappens(QUEST_FORTUNATE_MISUNDERSTANDINGS, me);
                    // me->RestoreFaction();
                    DoScriptText(SAY_END_IRO, me);
                    SetRun(false);
                    break;
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            if (Player* player = GetPlayerForEscort())
            {
                if (player->GetQuestStatus(QUEST_FORTUNATE_MISUNDERSTANDINGS) != QUEST_STATUS_COMPLETE)
                    player->FailQuest(QUEST_FORTUNATE_MISUNDERSTANDINGS);
            }
        }

        // Req. for quest "Just following orders", prevents a dummy-crocodile from being killed!
        void MoveInLineOfSight(Unit* who)
        {
            if (!who)
                return;

            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (Player* player = who->ToPlayer())
                if (player->GetQuestStatus(QUEST_JUST_FOLLOWING_ORDERS) == QUEST_STATUS_INCOMPLETE)
                    player->RewardPlayerAndGroupAtEvent(NPC_INJURED_RAINSPEAKER_ORACLE, player);
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_FORTUNATE_MISUNDERSTANDINGS) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
            CAST_AI(npc_escortAI, (creature->AI()))->SetMaxPlayerDistance(35.0f);
            creature->SetUnitMovementFlags(MOVEMENTFLAG_FALLING);
            DoScriptText(SAY_START_IRO, creature);

            switch (player->GetTeam()){
            case ALLIANCE:
                creature->setFaction(FACTION_ESCORTEE_A);
                break;
            case HORDE:
                creature->setFaction(FACTION_ESCORTEE_H);
                break;
            }
        }
        return true;
    }

    bool OnQuestAccept(Player* /*player*/, Creature* creature, Quest const* /*_Quest*/)
    {
        DoScriptText(SAY_QUEST_ACCEPT_IRO, creature);
        return false;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_injured_rainspeaker_oracleAI(creature);
    }
};

/*######
## npc_vekjik
######*/

#define GOSSIP_VEKJIK_ITEM1 "Shaman Vekjik, I have spoken with the big-tongues and they desire peace. I have brought this offering on their behalf."
#define GOSSIP_VEKJIK_ITEM2 "No no... I had no intentions of betraying your people. I was only defending myself. it was all a misunderstanding."

enum eVekjik
{
    GOSSIP_TEXTID_VEKJIK1       = 13137,
    GOSSIP_TEXTID_VEKJIK2       = 13138,

    SAY_TEXTID_VEKJIK1          = -1000208,

    SPELL_FREANZYHEARTS_FURY    = 51469,

    QUEST_MAKING_PEACE          = 12573
};

class npc_vekjik : public CreatureScript
{
public:
    npc_vekjik() : CreatureScript("npc_vekjik") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_MAKING_PEACE) == QUEST_STATUS_INCOMPLETE)
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
            player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VEKJIK1, creature->GetGUID());
            return true;
        }

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_VEKJIK_ITEM2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                player->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VEKJIK2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->CLOSE_GOSSIP_MENU();
                DoScriptText(SAY_TEXTID_VEKJIK1, creature, player);
                player->AreaExploredOrEventHappens(QUEST_MAKING_PEACE);
                creature->CastSpell(player, SPELL_FREANZYHEARTS_FURY, false);
                break;
        }

        return true;
    }
};

/*######
## avatar_of_freya
######*/

#define GOSSIP_ITEM_AOF1 "I want to stop the Scourge as much as you do. How can I help?"
#define GOSSIP_ITEM_AOF2 "You can trust me. I am no friend of the Lich King."
#define GOSSIP_ITEM_AOF3 "I will not fail."

enum eFreya
{
    QUEST_FREYA_PACT         = 12621,

    SPELL_FREYA_CONVERSATION = 52045,

    GOSSIP_TEXTID_AVATAR1    = 13303,
    GOSSIP_TEXTID_AVATAR2    = 13304,
    GOSSIP_TEXTID_AVATAR3    = 13305
};

class npc_avatar_of_freya : public CreatureScript
{
public:
    npc_avatar_of_freya() : CreatureScript("npc_avatar_of_freya") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_FREYA_PACT) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
        case GOSSIP_ACTION_INFO_DEF+1:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR2, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+2:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_AOF3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
            player->PlayerTalkClass->SendGossipMenu(GOSSIP_TEXTID_AVATAR3, creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+3:
            player->CastSpell(player, SPELL_FREYA_CONVERSATION, true);
            player->CLOSE_GOSSIP_MENU();
            break;
        }
        return true;
    }
};

/*######
## npc_bushwhacker
######*/

class npc_bushwhacker : public CreatureScript
{
public:
    npc_bushwhacker() : CreatureScript("npc_bushwhacker") { }

    struct npc_bushwhackerAI : public ScriptedAI
    {
        npc_bushwhackerAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void InitializeAI()
        {
            if (me->isDead())
                return;

            if (TempSummon* summ = me->ToTempSummon())
                if (Unit* summoner = summ->GetSummoner())
                    me->GetMotionMaster()->MovePoint(0, summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ());

            Reset();
        }

        void UpdateAI(const uint32 /*uiDiff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bushwhackerAI(creature);
    }
};

/*######
## npc_engineer_helice
######*/

enum eEnums
{
    SPELL_EXPLODE_CRYSTAL       = 62487,
    SPELL_FLAMES                = 64561,

    SAY_WP_7                    = -1800047,
    SAY_WP_6                    = -1800048,
    SAY_WP_5                    = -1800049,
    SAY_WP_4                    = -1800050,
    SAY_WP_3                    = -1800051,
    SAY_WP_2                    = -1800052,
    SAY_WP_1                    = -1800053,

    QUEST_DISASTER              = 12688
};

class npc_engineer_helice : public CreatureScript
{
public:
    npc_engineer_helice() : CreatureScript("npc_engineer_helice") { }

    struct npc_engineer_heliceAI : public npc_escortAI
    {
        npc_engineer_heliceAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 m_uiChatTimer;

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();

            switch (waypointId)
            {
                case 0:
                    DoScriptText(SAY_WP_2, me);
                    break;
                case 1:
                    DoScriptText(SAY_WP_3, me);
                    me->CastSpell(5918.33f, 5372.91f, -98.770f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5918.33f, 5372.91f, -98.770f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);     //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 2:
                    DoScriptText(SAY_WP_4, me);
                    break;
                case 7:
                    DoScriptText(SAY_WP_5, me);
                    break;
                case 8:
                    me->CastSpell(5887.37f, 5379.39f, -91.289f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5887.37f, 5379.39f, -91.289f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);      //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 9:
                    DoScriptText(SAY_WP_6, me);
                    break;
                case 13:
                    if (player)
                    {
                        player->GroupEventHappens(QUEST_DISASTER, me);
                        DoScriptText(SAY_WP_7, me);
                    }
                    break;
            }
        }

        void Reset()
        {
            m_uiChatTimer = 4000;
        }

        void JustDied(Unit* /*killer*/)
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (Player* player = GetPlayerForEscort())
                    player->FailQuest(QUEST_DISASTER);
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (m_uiChatTimer <= uiDiff)
                {
                    m_uiChatTimer = 12000;
                }
                else
                    m_uiChatTimer -= uiDiff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_engineer_heliceAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_DISASTER)
        {
            if (npc_engineer_heliceAI* pEscortAI = CAST_AI(npc_engineer_helice::npc_engineer_heliceAI, creature->AI()))
            {
                creature->GetMotionMaster()->MoveJumpTo(0, 0.4f, 0.4f);
                creature->setFaction(113);

                pEscortAI->Start(false, false, player->GetGUID());
                DoScriptText(SAY_WP_1, creature);
            }
        }
        return true;
    }
};

/*#####
## npc_jungle_punch_target
#####*/

#define SAY_OFFER     "Care to try Grimbooze Thunderbrew's new jungle punch?"
#define SAY_HEMET_1   "Aye, I'll try it."
#define SAY_HEMET_2   "That's exactly what I needed!"
#define SAY_HEMET_3   "It's got my vote! That'll put hair on your chest like nothing else will."
#define SAY_HADRIUS_1 "I'm always up for something of Grimbooze's."
#define SAY_HADRIUS_2 "Well, so far, it tastes like something my wife would drink..."
#define SAY_HADRIUS_3 "Now, there's the kick I've come to expect from Grimbooze's drinks! I like it!"
#define SAY_TAMARA_1  "Sure!"
#define SAY_TAMARA_2  "Oh my..."
#define SAY_TAMARA_3  "Tastes like I'm drinking... engine degreaser!"

enum utils
{
    NPC_HEMET   = 27986,
    NPC_HADRIUS = 28047,
    NPC_TAMARA  = 28568,
    SPELL_OFFER = 51962,
    QUEST_ENTRY = 12645,
};

class npc_jungle_punch_target : public CreatureScript
{
public:
    npc_jungle_punch_target() : CreatureScript("npc_jungle_punch_target") { }

    struct npc_jungle_punch_targetAI : public ScriptedAI
    {
        npc_jungle_punch_targetAI(Creature* creature) : ScriptedAI(creature) {}

        uint16 sayTimer;
        uint8 sayStep;

        void Reset()
        {
            sayTimer = 3500;
            sayStep = 0;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!sayStep)
                return;

            if (sayTimer < uiDiff)
            {
                switch (sayStep)
                {
                    case 0:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_HEMET:   me->MonsterSay(SAY_HEMET_1, LANG_UNIVERSAL, 0);   break;
                            case NPC_HADRIUS: me->MonsterSay(SAY_HADRIUS_1, LANG_UNIVERSAL, 0); break;
                            case NPC_TAMARA:  me->MonsterSay(SAY_TAMARA_1, LANG_UNIVERSAL, 0);  break;
                        }
                        sayTimer = 3000;
                        sayStep++;
                        break;
                    }
                    case 1:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_HEMET:   me->MonsterSay(SAY_HEMET_2, LANG_UNIVERSAL, 0);   break;
                            case NPC_HADRIUS: me->MonsterSay(SAY_HADRIUS_2, LANG_UNIVERSAL, 0); break;
                            case NPC_TAMARA:  me->MonsterSay(SAY_TAMARA_2, LANG_UNIVERSAL, 0);  break;
                        }
                        sayTimer = 3000;
                        sayStep++;
                        break;
                    }
                    case 2:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_HEMET:   me->MonsterSay(SAY_HEMET_3, LANG_UNIVERSAL, 0);   break;
                            case NPC_HADRIUS: me->MonsterSay(SAY_HADRIUS_3, LANG_UNIVERSAL, 0); break;
                            case NPC_TAMARA:  me->MonsterSay(SAY_TAMARA_3, LANG_UNIVERSAL, 0);  break;
                        }
                        sayTimer = 3000;
                        sayStep = 0;
                        break;
                    }
                }
            }
            else
                sayTimer -= uiDiff;
        }

        void SpellHit(Unit* caster, const SpellInfo* proto)
        {
            if (!proto || proto->Id != SPELL_OFFER)
                return;

            if (!caster->ToPlayer())
                return;

            QuestStatusMap::const_iterator itr = caster->ToPlayer()->getQuestStatusMap().find(QUEST_ENTRY);
            if (itr->second.Status != QUEST_STATUS_INCOMPLETE)
                return;

            for (uint8 i=0; i<3; i++)
            {
                switch (i)
                {
                   case 0:
                       if (NPC_HEMET != me->GetEntry())
                           continue;
                       else
                           break;
                   case 1:
                       if (NPC_HADRIUS != me->GetEntry())
                           continue;
                       else
                           break;
                   case 2:
                       if (NPC_TAMARA != me->GetEntry())
                           continue;
                       else
                           break;
                }

                if (itr->second.CreatureOrGOCount[i] != 0)
                    continue;

                caster->ToPlayer()->KilledMonsterCredit(me->GetEntry(), 0);
                caster->ToPlayer()->Say(SAY_OFFER, LANG_UNIVERSAL);
                sayStep = 0;
                break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_jungle_punch_targetAI(creature);
    }
};

/*######
## npc_adventurous_dwarf
######*/

#define GOSSIP_OPTION_ORANGE    "Can you spare an orange?"
#define GOSSIP_OPTION_BANANAS   "Have a spare bunch of bananas?"
#define GOSSIP_OPTION_PAPAYA    "I could really use a papaya."

enum eAdventurousDwarf
{
    QUEST_12634         = 12634,

    ITEM_BANANAS        = 38653,
    ITEM_PAPAYA         = 38655,
    ITEM_ORANGE         = 38656,

    SPELL_ADD_ORANGE    = 52073,
    SPELL_ADD_BANANAS   = 52074,
    SPELL_ADD_PAPAYA    = 52076,

    GOSSIP_MENU_DWARF   = 13307,

    SAY_DWARF_OUCH      = -1571042,
    SAY_DWARF_HELP      = -1571043
};

class npc_adventurous_dwarf : public CreatureScript
{
public:
    npc_adventurous_dwarf() : CreatureScript("npc_adventurous_dwarf") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        DoScriptText(SAY_DWARF_OUCH, creature);
        return NULL;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_12634) != QUEST_STATUS_INCOMPLETE)
            return false;

        if (player->GetItemCount(ITEM_ORANGE) < 1)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_ORANGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        if (player->GetItemCount(ITEM_BANANAS) < 2)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_BANANAS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        if (player->GetItemCount(ITEM_PAPAYA) < 1)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_OPTION_PAPAYA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

        player->PlayerTalkClass->SendGossipMenu(GOSSIP_MENU_DWARF, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        uint32 spellId = 0;
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1: spellId = SPELL_ADD_ORANGE;     break;
            case GOSSIP_ACTION_INFO_DEF + 2: spellId = SPELL_ADD_BANANAS;    break;
            case GOSSIP_ACTION_INFO_DEF + 3: spellId = SPELL_ADD_PAPAYA;     break;
        }
        if (spellId)
            player->CastSpell(player, spellId, true);
        DoScriptText(SAY_DWARF_HELP, creature);
        creature->DespawnOrUnsummon();
        return true;
    }
};

/*######
## Quest The Lifewarden's Wrath
######*/

enum MiscLifewarden
{
    NPC_PRESENCE = 28563, // Freya's Presence
    NPC_SABOTEUR = 28538, // Cultist Saboteur
    NPC_SERVANT = 28320, // Servant of Freya

    WHISPER_ACTIVATE = 0,

    SPELL_FREYA_DUMMY = 51318,
    SPELL_LIFEFORCE = 51395,
    SPELL_FREYA_DUMMY_TRIGGER = 51335,
    SPELL_LASHER_EMERGE = 48195,
    SPELL_WILD_GROWTH = 52948,
};

class spell_q12620_the_lifewarden_wrath : public SpellScriptLoader
{
public:
    spell_q12620_the_lifewarden_wrath() : SpellScriptLoader("spell_q12620_the_lifewarden_wrath") { }

    class spell_q12620_the_lifewarden_wrath_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12620_the_lifewarden_wrath_SpellScript);

        void HandleSendEvent(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);

            if (Unit* caster = GetCaster())
            {
                if (Creature* presence = caster->FindNearestCreature(NPC_PRESENCE, 50.0f))
                {
                    presence->AI()->Talk(WHISPER_ACTIVATE, caster->GetGUID());
                    presence->CastSpell(presence, SPELL_FREYA_DUMMY, true); // will target plants
                    // Freya Dummy could be scripted with the following code

                    // Revive plants
                    std::list<Creature*> servants;
                    GetCaster()->GetCreatureListWithEntryInGrid(servants, NPC_SERVANT, 200.0f);
                    for (std::list<Creature*>::iterator itr = servants.begin(); itr != servants.end(); ++itr)
                    {
                        // Couldn't find a spell that does this
                        if ((*itr)->isDead())
                            (*itr)->Respawn(true);

                        (*itr)->CastSpell(*itr, SPELL_FREYA_DUMMY_TRIGGER, true);
                        (*itr)->CastSpell(*itr, SPELL_LASHER_EMERGE, false);
                        (*itr)->CastSpell(*itr, SPELL_WILD_GROWTH, false);

                        if (Unit* target = (*itr)->SelectNearestTarget(150.0f))
                            (*itr)->AI()->AttackStart(target);
                    }

                    // Kill nearby enemies
                    std::list<Creature*> saboteurs;
                    caster->GetCreatureListWithEntryInGrid(saboteurs, NPC_SABOTEUR, 200.0f);
                    for (std::list<Creature*>::iterator itr = saboteurs.begin(); itr != saboteurs.end(); ++itr)
                        if ((*itr)->isAlive())
                            // Lifeforce has a cast duration, it should be cast at all saboteurs one by one
                            presence->CastSpell((*itr), SPELL_LIFEFORCE, false);
                }
            }
        }

        void Register()
        {
            OnEffectHit += SpellEffectFn(spell_q12620_the_lifewarden_wrath_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12620_the_lifewarden_wrath_SpellScript();
    }
};

/*######
## Quest Kick, What Kick? (12589)
######*/

enum KickWhatKick
{
    NPC_LUCKY_WILHELM = 28054,
    NPC_APPLE = 28053,
    NPC_DROSTAN = 28328,
    NPC_CRUNCHY = 28346,
    NPC_THICKBIRD = 28093,

    SPELL_HIT_APPLE = 51331,
    SPELL_MISS_APPLE = 51332,
    SPELL_MISS_BIRD_APPLE = 51366,
    SPELL_APPLE_FALL = 51371,
    SPELL_BIRD_FALL = 51369,

    EVENT_MISS = 0,
    EVENT_HIT = 1,
    EVENT_MISS_BIRD = 2,

    SAY_WILHELM_MISS = 0,
    SAY_WILHELM_HIT = 1,
    SAY_DROSTAN_REPLY_MISS = 0,
};

class spell_q12589_shoot_rjr : public SpellScriptLoader
{
public:
    spell_q12589_shoot_rjr() : SpellScriptLoader("spell_q12589_shoot_rjr") { }

    class spell_q12589_shoot_rjr_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q12589_shoot_rjr_SpellScript);

        SpellCastResult CheckCast()
        {
            if (Unit* target = GetExplTargetUnit())
                if (target->GetEntry() == NPC_LUCKY_WILHELM)
                    return SPELL_CAST_OK;

            SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_TARGET_WILHELM);
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            uint32 roll = urand(1, 100);

            uint8 ev;
            if (roll <= 50)
                ev = EVENT_MISS;
            else if (roll <= 83)
                ev = EVENT_HIT;
            else
                ev = EVENT_MISS_BIRD;

            Unit* shooter = GetCaster();
            Creature* wilhelm = GetHitUnit()->ToCreature();
            Creature* apple = shooter->FindNearestCreature(NPC_APPLE, 30);
            Creature* drostan = shooter->FindNearestCreature(NPC_DROSTAN, 30);

            if (!wilhelm || !apple || !drostan)
                return;

            switch (ev)
            {
                case EVENT_MISS_BIRD:
                {
                    Creature* crunchy = shooter->FindNearestCreature(NPC_CRUNCHY, 30);
                    Creature* bird = shooter->FindNearestCreature(NPC_THICKBIRD, 30);

                    if (!bird || !crunchy)
                        ; // fall to EVENT_MISS
                    else
                    {
                        shooter->CastSpell(bird, SPELL_MISS_BIRD_APPLE);
                        bird->CastSpell(bird, SPELL_BIRD_FALL);
                        wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                        drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);

                        bird->Kill(bird);
                        crunchy->GetMotionMaster()->MovePoint(0, bird->GetPositionX(), bird->GetPositionY(),
                            bird->GetMap()->GetWaterOrGroundLevel(bird->GetPositionX(), bird->GetPositionY(), bird->GetPositionZ()));
                        // TODO: Make crunchy perform emote eat when he reaches the bird

                        break;
                    }
                }
                case EVENT_MISS:
                {
                    shooter->CastSpell(wilhelm, SPELL_MISS_APPLE);
                    wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                    drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);
                    break;
                }
                case EVENT_HIT:
                {
                    shooter->CastSpell(apple, SPELL_HIT_APPLE);
                    apple->CastSpell(apple, SPELL_APPLE_FALL);
                    wilhelm->AI()->Talk(SAY_WILHELM_HIT);
                    if (Player* player = shooter->ToPlayer())
                        player->KilledMonsterCredit(NPC_APPLE, 0);
                    apple->DespawnOrUnsummon();

                    break;
                }
            }
        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_q12589_shoot_rjr_SpellScript::CheckCast);
            OnEffectHitTarget += SpellEffectFn(spell_q12589_shoot_rjr_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_q12589_shoot_rjr_SpellScript();
    }
};

/*######
## Artruis the Heartless
######*/

enum Artruis
{
    SPELL_FROSTBOLT         = 15530,
    SPELL_ICE_LANCE         = 54261,
    SPELL_ICY_VEINS         = 54792,
    SPELL_FROST_NOVA        = 11831,
    SPELL_BINDINGS          = 52185,
    SPELL_SUMMON_PHYLACTERY = 52518,

    GO_ARTRUIS_PHYLACTERY  = 190777,

    NPC_ZEPIK   = 28668,
    NPC_JALOOT  = 28667,

    EVENT_FROSTBOLT     = 1,
    EVENT_ICE_LANCE     = 2,
    EVENT_ICY_VEINS     = 3,
    EVENT_FROST_NOVA    = 4,

    ACTION_UNBIND           = 0,
    ACTION_BIND             = 1,
    ACTION_SET_QUESTGIVER   = 2,
    ACTION_RESET            = 3,

    SAY_AGGRO       = 0,
    SAY_80PERC      = 1,
    SAY_60PERC      = 2,
    SAY_30PERC      = 3,
    EMOTE_SHIELDED  = 4,
    SAY_5PERC       = 5,
};

class npc_artruis : public CreatureScript
{
    public:
        npc_artruis() : CreatureScript("npc_artruis") {}

        struct npc_artruisAI : public ScriptedAI
        {
            npc_artruisAI(Creature* creature) : ScriptedAI(creature) {}

            EventMap events;

            void Reset()
            {
                events.Reset();

                wasImmune = false;
                isBound = false;

                talkPhase = 0;

                me->SetReactState(REACT_DEFENSIVE);

                // set event into a sane state, cannot start without zepik&jaloot, despawn phylactery
                if (Creature* zepik = me->FindNearestCreature(NPC_ZEPIK, 60.0f, false))
                    zepik->Respawn();
                else if (Creature* zepik = me->FindNearestCreature(NPC_ZEPIK, 60.0f, true))
                    zepik->GetAI()->Reset();

                if (Creature* jaloot = me->FindNearestCreature(NPC_JALOOT, 60.0f, false))
                    jaloot->Respawn();
                else if (Creature* jaloot = me->FindNearestCreature(NPC_JALOOT, 60.0f, true))
                    jaloot->GetAI()->Reset();

                //if (GameObject* phylactery = me->FindNearestGameObject(GO_ARTRUIS_PHYLACTERY, 60.0f))
                //    phylactery->Delete();
            }

            void EnterCombat(Unit* who)
            {
                events.ScheduleEvent(EVENT_FROSTBOLT, 1000);
                events.ScheduleEvent(EVENT_ICE_LANCE, 200);
                events.ScheduleEvent(EVENT_FROST_NOVA, 100);
                events.ScheduleEvent(EVENT_ICY_VEINS, 4500);
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (me->getVictim()->GetTypeId() != TYPEID_PLAYER)
                {
                    EnterEvadeMode();
                    return;
                }

                // dialog
                if (talkPhase == SAY_AGGRO)
                {
                    Talk(SAY_AGGRO);
                    talkPhase++;
                }
                else if (me->GetHealthPct() <= 80.0f && talkPhase++ == SAY_80PERC)
                    Talk(SAY_80PERC);
                else if (me->GetHealthPct() <= 60.0f && talkPhase++ == SAY_60PERC)
                    Talk(SAY_60PERC);
                else if (me->GetHealthPct() <= 5.0f && talkPhase++ == SAY_5PERC)
                    Talk(SAY_5PERC);

                // Immune-Choosing-Phase
                if (me->GetHealthPct() <= 30 && !wasImmune)
                {
                    me->InterruptNonMeleeSpells(true);
                    DoCastVictim(SPELL_BINDINGS); // has implicit targeting

                    Talk(SAY_30PERC);
                    Talk(EMOTE_SHIELDED);
                    talkPhase += 2;

                    // workaround for SpellHit not being called for implicit targeting
                    if (Creature* zepik = me->FindNearestCreature(NPC_ZEPIK, 60.0f, true))
                        zepik->GetAI()->DoAction(ACTION_BIND);

                    if (Creature* jaloot = me->FindNearestCreature(NPC_JALOOT, 60.0f, true))
                        jaloot->GetAI()->DoAction(ACTION_BIND);

                    wasImmune = true;
                    isBound = true;
                }

                events.Update(diff);

                if (isBound || me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_FROSTBOLT:
                            DoCastVictim(SPELL_FROSTBOLT);
                            events.ScheduleEvent(EVENT_FROSTBOLT, 4000);
                            break;
                        case EVENT_ICE_LANCE:
                            DoCastVictim(SPELL_ICE_LANCE);
                            events.ScheduleEvent(EVENT_ICE_LANCE, 7000);
                            break;
                        case EVENT_FROST_NOVA:
                            DoCastVictim(SPELL_FROST_NOVA);
                            events.ScheduleEvent(EVENT_FROST_NOVA, 14000);
                            break;
                        case EVENT_ICY_VEINS:
                            DoCast(me, SPELL_ICY_VEINS);
                            events.ScheduleEvent(EVENT_ICY_VEINS, 25000);
                            break;
                    }
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                // DoCastVictim(SPELL_SUMMON_PHYLACTERY);
                // stupid spell, manual spawn for new, screw you!

                // enable quests for the chosen npc
                if (Creature* zepik = me->FindNearestCreature(NPC_ZEPIK, 120.0f, true))
                    if (zepik->isAlive())
                        zepik->GetAI()->DoAction(ACTION_SET_QUESTGIVER);

                if (Creature* jaloot = me->FindNearestCreature(NPC_JALOOT, 120.0f, true))
                    if (jaloot->isAlive())
                        jaloot->GetAI()->DoAction(ACTION_SET_QUESTGIVER);
            }

            void DoAction(const int32 actionId)
            {
                if (actionId == ACTION_UNBIND)
                {
                    me->RemoveAurasDueToSpell(SPELL_BINDINGS);
                    isBound = false;
                }
            }

        private:
            bool wasImmune;
            bool isBound;
            uint8 talkPhase;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_artruisAI(creature);
        }
};

enum ZepikJaloot
{
    SPELL_TOMB_OF_HEARTLESS = 52182,
    // Zepik
    SPELL_OPEN_WOUND        = 52873,
    SPELL_SPIKE_TRAP        = 52886,
    // Jaloot
    SPELL_LIGHTNING_WHIRL   = 52943,
    SPELL_SPARK_FRENZY      = 52964,

    NPC_ARTRUIS = 28659,

    EVENT_OPEN_WOUND        = 1,
    EVENT_SPIKE_TRAP        = 2,
    EVENT_LIGHTNING_WHIRL   = 3,
    EVENT_SPARK_FRENZY      = 4,

    FACTION_FRIENDLY    = 250,
    FACTION_MONSTER   = 14,

    SAY_FREED    = 0,
};

class npc_zepik_jaloot : public CreatureScript
{
    public:
    npc_zepik_jaloot() : CreatureScript("npc_zepik_jaloot") {}

        struct npc_zepik_jalootAI : public ScriptedAI
        {
            npc_zepik_jalootAI(Creature* creature) : ScriptedAI(creature) {}

            EventMap events;

            void Reset()
            {
                events.Reset();
                me->setFaction(FACTION_FRIENDLY);

                switch (me->GetEntry())
                {
                    case NPC_ZEPIK:
                        events.ScheduleEvent(EVENT_OPEN_WOUND, 2000);
                        events.ScheduleEvent(EVENT_SPIKE_TRAP, 4000);
                        break;
                    case NPC_JALOOT:
                        events.ScheduleEvent(EVENT_LIGHTNING_WHIRL, 2000);
                        events.ScheduleEvent(EVENT_SPARK_FRENZY, 4000);
                        break;
                }

                me->RemoveAurasDueToSpell(SPELL_BINDINGS);

                me->GetMotionMaster()->MoveTargetedHome();
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (!me->HasAura(SPELL_BINDINGS))
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_OPEN_WOUND:
                            DoCastVictim(SPELL_OPEN_WOUND);
                            events.ScheduleEvent(EVENT_OPEN_WOUND, 4000);
                            break;
                        case EVENT_SPIKE_TRAP:
                            DoCastVictim(SPELL_SPIKE_TRAP);
                            events.ScheduleEvent(EVENT_SPIKE_TRAP, 4000);
                            break;
                        case EVENT_LIGHTNING_WHIRL:
                            DoCastVictim(SPELL_LIGHTNING_WHIRL);
                            events.ScheduleEvent(EVENT_LIGHTNING_WHIRL, 4000);
                            break;
                        case EVENT_SPARK_FRENZY:
                            DoCastVictim(SPELL_SPARK_FRENZY);
                            events.ScheduleEvent(EVENT_SPARK_FRENZY, 14000);
                            break;
                    }
                }
            }

            // Spell: Bindings of Submission target Zepik&Jaloot implicitly, but don't turn up in SpellHit(), makes developer sad ;-(
            void SpellHit(Unit* who, const SpellEntry* spell)
            {
                // Artruis chains Zepik&Jaloot, removes Tomb of Heartless, both attack player
                if (spell->Id == SPELL_BINDINGS)
                {
                    me->RemoveAurasDueToSpell(SPELL_TOMB_OF_HEARTLESS);
                    if (Creature* artruis = me->FindNearestCreature(NPC_ARTRUIS, 120.0f, true))
                    {
                        me->setFaction(FACTION_MONSTER);
                        me->Attack(artruis->getVictim(), true);
                        me->GetMotionMaster()->MoveChase(artruis->getVictim());
                    }
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                if (Creature* artruis = me->FindNearestCreature(NPC_ARTRUIS, 120.0f, true))
                {
                    // determine players choice
                    uint32 assistantEntry = (me->GetEntry() == NPC_ZEPIK) ? NPC_JALOOT : NPC_ZEPIK;

                    // and start assisting
                    if (Creature* assistant = me->FindNearestCreature(assistantEntry, 120.0f, true))
                    {
                        artruis->GetAI()->DoAction(ACTION_UNBIND); // do this first, because otherwise he is immune
                        assistant->RemoveAurasDueToSpell(SPELL_BINDINGS);

                        assistant->AddThreat(artruis, 25000.0f);
                        assistant->GetMotionMaster()->MoveChase(artruis);
                        assistant->setFaction(FACTION_FRIENDLY);
                        assistant->Attack(artruis, true);

                        Talk(SAY_FREED);
                    }
                }
            }

            void JustReachedHome()
            {
                me->DeleteThreatList();

                if (Creature* artruis = me->FindNearestCreature(NPC_ARTRUIS, 120.0f, false))
                    return; // this is really important, if reset is not blocked they will ice block and neither give quest nor assist

                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

                //DoCast(me, SPELL_TOMB_OF_HEARTLESS, false);
                me->AddAura(SPELL_TOMB_OF_HEARTLESS, me);
            }

            void DoAction(const int32 actionId)
            {
                if (actionId == ACTION_SET_QUESTGIVER)
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

                // replacement for SpellHit-Method
                else if (actionId == ACTION_BIND)
                {
                    if (Creature* artruis = me->FindNearestCreature(NPC_ARTRUIS, 120.0f, true))
                    {
                        me->setFaction(FACTION_MONSTER);
                        me->Attack(artruis->getVictim(), true);
                        me->GetMotionMaster()->MoveChase(artruis->getVictim());
                    }
                    me->RemoveAurasDueToSpell(SPELL_TOMB_OF_HEARTLESS);
                }

                else if (actionId == ACTION_RESET)
                    Reset();

            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_zepik_jalootAI(creature);
        }
};

void AddSC_sholazar_basin()
{
    new npc_injured_rainspeaker_oracle();
    new npc_vekjik();
    new npc_avatar_of_freya();
    new npc_bushwhacker();
    new npc_engineer_helice();
    new npc_adventurous_dwarf();
    new npc_jungle_punch_target();
    new spell_q12620_the_lifewarden_wrath();
    new spell_q12589_shoot_rjr();
    new npc_artruis();
    new npc_zepik_jaloot();
}
