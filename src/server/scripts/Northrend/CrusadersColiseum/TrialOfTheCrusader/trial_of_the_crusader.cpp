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
SDName: Trial Of the crusader
SD%Complete: ??%
SDComment: event script based on /dev/rsa
SDCategory: trial_of_the_crusader
EndScriptData */

//Known Bugs:
// - Need better implementation of Gossip and correct gossip text and option
// - Misses Dalaran Teleport at the end.

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "trial_of_the_crusader.h"
#include "Group.h"

enum eYells
{
    // Highlord Tirion Fordring - 34996
    SAY_STAGE_0_01            = 0,
    SAY_STAGE_0_02            = 1,
    SAY_STAGE_0_04            = 2,
    SAY_STAGE_0_05            = 3,
    SAY_STAGE_0_06            = 4,
    SAY_STAGE_0_WIPE          = 5,
    SAY_STAGE_1_01            = 6,
    SAY_STAGE_1_07            = 7,
    SAY_STAGE_1_08            = 8,
    SAY_STAGE_1_11            = 9,
    SAY_STAGE_2_01            = 10,
    SAY_STAGE_2_03            = 11,
    SAY_STAGE_2_06            = 12,
    SAY_STAGE_3_01            = 13,
    SAY_STAGE_3_02            = 14,
    SAY_STAGE_4_01            = 15,
    SAY_STAGE_4_03            = 16,

    // Varian Wrynn
    SAY_STAGE_0_03a           = 0,
    SAY_STAGE_1_10            = 1,
    SAY_STAGE_2_02a           = 2,
    SAY_STAGE_2_04a           = 3,
    SAY_STAGE_2_05a           = 4,
    SAY_STAGE_3_03a           = 5,

    // Garrosh
    SAY_STAGE_0_03h           = 0,
    SAY_STAGE_1_09            = 1,
    SAY_STAGE_2_02h           = 2,
    SAY_STAGE_2_04h           = 3,
    SAY_STAGE_2_05h           = 4,
    SAY_STAGE_3_03h           = 5,

    // Wilfred Fizzlebang
    SAY_STAGE_1_02            = 0,
    SAY_STAGE_1_03            = 1,
    SAY_STAGE_1_04            = 2,
    SAY_STAGE_1_06            = 3,

    // Lord Jaraxxus
    SAY_STAGE_1_05            = 0,

    //  The Lich King
    SAY_STAGE_4_02            = 0,
    SAY_STAGE_4_05            = 1,
    SAY_STAGE_4_04            = 2,

    // Highlord Tirion Fordring - 36095
    SAY_STAGE_4_06            = 0,
    SAY_STAGE_4_07            = 1,
};

struct _Messages
{
    eAnnouncerMessages msgnum;
    uint32 id;
    bool state;
    uint32 encounter;
};

static _Messages _GossipMessage[]=
{
    {MSG_BEASTS, GOSSIP_ACTION_INFO_DEF+1, false, TYPE_BEASTS},
    {MSG_JARAXXUS, GOSSIP_ACTION_INFO_DEF+2, false, TYPE_JARAXXUS},
    {MSG_CRUSADERS, GOSSIP_ACTION_INFO_DEF+3, false, TYPE_CRUSADERS},
    {MSG_VALKIRIES, GOSSIP_ACTION_INFO_DEF+4, false, TYPE_VALKIRIES},
    {MSG_LICH_KING, GOSSIP_ACTION_INFO_DEF+5, false, TYPE_ANUBARAK},
    {MSG_ANUBARAK, GOSSIP_ACTION_INFO_DEF+6, true, TYPE_ANUBARAK}
};

enum
{
    NUM_MESSAGES = 6,
};

class npc_announcer_toc10 : public CreatureScript
{
    public:

        npc_announcer_toc10() : CreatureScript("npc_announcer_toc10") { }

        struct npc_announcer_toc10AI : public ScriptedAI
        {
            npc_announcer_toc10AI(Creature* creature) : ScriptedAI(creature)
            {
                instance = creature->GetInstanceScript();
            }

            InstanceScript* instance;

            void Reset()
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                if (Creature* pAlly = GetClosestCreatureWithEntry(me, NPC_THRALL, 300.0f))
                    pAlly->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                if (Creature* pAlly = GetClosestCreatureWithEntry(me, NPC_PROUDMOORE, 300.0f))
                    pAlly->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            void AttackStart(Unit* /*who*/) {}
        };

        bool OnGossipHello(Player* player, Creature* creature)
        {
            InstanceScript* instanceScript = creature->GetInstanceScript();
            if (!instanceScript)
                return true;

            char const* _message = "We are ready!";

            if (player->isInCombat() || instanceScript->IsEncounterInProgress() || instanceScript->GetData(TYPE_EVENT))
                return true;

            uint8 i = 0;
            for (; i < NUM_MESSAGES; ++i)
            {
                if ((!_GossipMessage[i].state && instanceScript->GetData(_GossipMessage[i].encounter) != DONE)
                    || (_GossipMessage[i].state && instanceScript->GetData(_GossipMessage[i].encounter) == DONE))
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, _message, GOSSIP_SENDER_MAIN, _GossipMessage[i].id);
                    break;
                }
            }

            player->SEND_GOSSIP_MENU(_GossipMessage[i].msgnum, creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            player->PlayerTalkClass->ClearMenus();
            player->CLOSE_GOSSIP_MENU();
            InstanceScript* instanceScript = creature->GetInstanceScript();
            if (!instanceScript)
                return true;

            switch (action)
            {
                case GOSSIP_ACTION_INFO_DEF+1:
                    if (instanceScript->GetData(TYPE_BEASTS) != DONE)
                    {
                        instanceScript->SetData(TYPE_EVENT, 110);
                        instanceScript->SetData(TYPE_NORTHREND_BEASTS, NOT_STARTED);
                        instanceScript->SetData(TYPE_BEASTS, NOT_STARTED);
                    }
                    break;
                case GOSSIP_ACTION_INFO_DEF+2:
                    if (Creature* jaraxxus = Unit::GetCreature(*player, instanceScript->GetData64(NPC_JARAXXUS)))
                    {
                        jaraxxus->RemoveAurasDueToSpell(SPELL_JARAXXUS_CHAINS);
                        jaraxxus->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        jaraxxus->SetReactState(REACT_AGGRESSIVE);

                        if (Unit* target = jaraxxus->SelectNearestTarget(150))
                            jaraxxus->AI()->AttackStart(target);
                    }
                    else if (instanceScript->GetData(TYPE_JARAXXUS) != DONE)
                    {
                        instanceScript->SetData(TYPE_EVENT, 1010);
                        instanceScript->SetData(TYPE_JARAXXUS, NOT_STARTED);
                    }
                    break;
                case GOSSIP_ACTION_INFO_DEF+3:

                    uint32 TeamInInstance;
                    TeamInInstance = 0;

                    if (instanceScript->GetData(TYPE_CRUSADERS) != DONE)
                    {
                        if (instanceScript->instance)
                        {
                            Map::PlayerList const &players = instanceScript->instance->GetPlayers();
                            uint8 HordeCount = 0;
                            uint8 AllianceCount = 0;
        
                            if (!players.isEmpty())
                            {
                                for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
                                {
                                    if (Player* player = i->getSource())
                                    {
                                        if (player->GetTeam() == HORDE)
                                            HordeCount++;
                                        else if (player->GetTeam() == ALLIANCE)
                                            AllianceCount++;
                                    }
                                }
        
                                if (AllianceCount > HordeCount)
                                    TeamInInstance = ALLIANCE;
                                else if (HordeCount > AllianceCount)
                                    TeamInInstance = HORDE;
                                else if (HordeCount == AllianceCount)
                                    TeamInInstance = RAND(ALLIANCE, HORDE);
                            }
                        }

                        if (TeamInInstance == ALLIANCE)
                            instanceScript->SetData(TYPE_EVENT, 3000);
                        else
                            instanceScript->SetData(TYPE_EVENT, 3001);

                        instanceScript->SetData(TYPE_CRUSADERS, NOT_STARTED);
                    }
                    break;
                case GOSSIP_ACTION_INFO_DEF+4:
                    if (instanceScript->GetData(TYPE_VALKIRIES) != DONE)
                    {
                        instanceScript->SetData(TYPE_EVENT, 4000);
                        instanceScript->SetData(TYPE_VALKIRIES, NOT_STARTED);
                    }
                    break;
                case GOSSIP_ACTION_INFO_DEF+5:
                {
                    if (instanceScript->GetData(TYPE_LICH_KING) != DONE && !player->isGameMaster())
                        return true;

                    if (GameObject* floor = GameObject::GetGameObject(*player, instanceScript->GetData64(GO_ARGENT_COLISEUM_FLOOR)))
                        floor->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);

                    creature->CastSpell(creature, 69016, false);

                    Creature* anubArak = Unit::GetCreature(*creature, instanceScript->GetData64(NPC_ANUBARAK));
                    if (!anubArak)
                        anubArak = creature->SummonCreature(NPC_ANUBARAK, AnubarakLoc[0].GetPositionX(), AnubarakLoc[0].GetPositionY(), AnubarakLoc[0].GetPositionZ(), 3, TEMPSUMMON_CORPSE_TIMED_DESPAWN, DESPAWN_TIME);

                    instanceScript->SetData(TYPE_ANUBARAK, NOT_STARTED);

                    if (creature->IsVisible() == false)
                        creature->SetVisible(false);
                    break;
                }
            }
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            return true;
        }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_announcer_toc10AI(creature);
        }
};

class boss_lich_king_toc : public CreatureScript
{
    public:

        boss_lich_king_toc() : CreatureScript("boss_lich_king_toc") { }

        struct boss_lich_king_tocAI : public ScriptedAI
        {
            boss_lich_king_tocAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = creature->GetInstanceScript();
            }

            InstanceScript* instance;
            uint32 m_uiUpdateTimer;

            void Reset()
            {
                m_uiUpdateTimer = 0;
                me->SetReactState(REACT_PASSIVE);
                if (Creature* summoned = me->SummonCreature(NPC_TRIGGER, ToCCommonLoc[2].GetPositionX(), ToCCommonLoc[2].GetPositionY(), ToCCommonLoc[2].GetPositionZ(), 5, TEMPSUMMON_TIMED_DESPAWN, 60000))
                {
                    summoned->CastSpell(summoned, 51807, false);
                    summoned->SetDisplayId(11686);
                }
                if (instance) instance->SetData(TYPE_LICH_KING, IN_PROGRESS);
                me->SetWalk(true);
            }

            void MovementInform(uint32 uiType, uint32 uiId)
            {
                if (uiType != POINT_MOTION_TYPE)
                    return;
                switch (uiId)
                {
                    case 0:
                        instance->SetData(TYPE_EVENT, 5030);
                        break;
                    case 1:
                        instance->SetData(TYPE_EVENT, 5050);
                        break;
                }
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!instance)
                    return;

                if (instance->GetData(TYPE_EVENT_NPC) != NPC_LICH_KING_1)
                    return;

                m_uiUpdateTimer = instance->GetData(TYPE_EVENT_TIMER);
                if (m_uiUpdateTimer <= uiDiff)
                {
                    switch (instance->GetData(TYPE_EVENT))
                    {
                        case 5010:
                            Talk(SAY_STAGE_4_02);
                            m_uiUpdateTimer = 3000;
                            me->GetMotionMaster()->MovePoint(0, LichKingLoc[0]);
                            instance->SetData(TYPE_EVENT, 5020);
                            break;
                        case 5030:
                            Talk(SAY_STAGE_4_04);
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                            m_uiUpdateTimer = 10000;
                            instance->SetData(TYPE_EVENT, 5040);
                            break;
                        case 5040:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                            me->GetMotionMaster()->MovePoint(1, LichKingLoc[1]);
                            m_uiUpdateTimer = 1000;
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 5050:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 5060);
                            break;
                        case 5060:
                            Talk(SAY_STAGE_4_05);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                            m_uiUpdateTimer = 2500;
                            instance->SetData(TYPE_EVENT, 5070);
                            break;
                        case 5070:
                            me->CastSpell(me, 68198, false);
                            m_uiUpdateTimer = 1500;
                            instance->SetData(TYPE_EVENT, 5080);
                            break;
                        case 5080:
                            if (GameObject* go = instance->instance->GetGameObject(instance->GetData64(GO_ARGENT_COLISEUM_FLOOR)))
                                go->SetDestructibleState(GO_DESTRUCTIBLE_DAMAGED);
                            me->CastSpell(me, 69016, false);
                            if (instance)
                            {
                                instance->SetData(TYPE_LICH_KING, DONE);
                                Creature* temp = Unit::GetCreature(*me, instance->GetData64(NPC_ANUBARAK));
                                if (!temp || !temp->isAlive())
                                    temp = me->SummonCreature(NPC_ANUBARAK, AnubarakLoc[0].GetPositionX(), AnubarakLoc[0].GetPositionY(), AnubarakLoc[0].GetPositionZ(), 3, TEMPSUMMON_CORPSE_TIMED_DESPAWN, DESPAWN_TIME);

                                instance->SetData(TYPE_EVENT, 0);
                            }
                            me->DespawnOrUnsummon();
                            m_uiUpdateTimer = 20000;
                            break;
                    }
                } else m_uiUpdateTimer -= uiDiff;
                instance->SetData(TYPE_EVENT_TIMER, m_uiUpdateTimer);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_lich_king_tocAI(creature);
        }
};

class npc_fizzlebang_toc : public CreatureScript
{
    public:

        npc_fizzlebang_toc() : CreatureScript("npc_fizzlebang_toc") { }

        struct npc_fizzlebang_tocAI : public ScriptedAI
        {
            npc_fizzlebang_tocAI(Creature* creature) : ScriptedAI(creature), Summons(me)
            {
                instance = me->GetInstanceScript();
            }

            InstanceScript* instance;
            SummonList Summons;
            uint32 m_uiUpdateTimer;
            uint64 m_uiPortalGUID;
            uint64 m_uiTriggerGUID;

            void JustDied(Unit* killer)
            {
                Talk(SAY_STAGE_1_06, killer->GetGUID());
                instance->SetData(TYPE_EVENT, 1180);
                if (Creature* temp = Unit::GetCreature(*me, instance->GetData64(NPC_JARAXXUS)))
                {
                    temp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    temp->SetReactState(REACT_AGGRESSIVE);

                    if (Unit* target = temp->SelectNearestTarget(150))
                        temp->AI()->AttackStart(target);
                }
            }

            void Reset()
            {
                me->SetWalk(true);
                m_uiPortalGUID = 0;
                me->GetMotionMaster()->MovePoint(1, ToCCommonLoc[10].GetPositionX(), ToCCommonLoc[10].GetPositionY()-60, ToCCommonLoc[10].GetPositionZ());
            }

            void MovementInform(uint32 uiType, uint32 uiId)
            {
                if (uiType != POINT_MOTION_TYPE)
                    return;

                switch (uiId)
                {
                    case 1:
                        me->SetWalk(false);
                        if (instance)
                        {
                            instance->SetData(TYPE_EVENT, 1120);
                            instance->SetData(TYPE_EVENT_TIMER, 1000);
                        }
                        break;
                }
            }

            void JustSummoned(Creature* summoned)
            {
                Summons.Summon(summoned);
            }

            void UpdateAI(const uint32 uiDiff)
            {
                if (!instance)
                    return;

                if (instance->GetData(TYPE_EVENT_NPC) != NPC_FIZZLEBANG)
                    return;

                m_uiUpdateTimer = instance->GetData(TYPE_EVENT_TIMER);
                if (m_uiUpdateTimer <= uiDiff)
                {
                    switch (instance->GetData(TYPE_EVENT))
                    {
                        case 1110:
                            instance->SetData(TYPE_EVENT, 1120);
                            m_uiUpdateTimer = 4000;
                            break;
                        case 1120:
                            Talk(SAY_STAGE_1_02);
                            instance->SetData(TYPE_EVENT, 1130);
                            m_uiUpdateTimer = 12000;
                            break;
                        case 1130:
                            me->GetMotionMaster()->MovementExpired();
                            Talk(SAY_STAGE_1_03);
                            me->HandleEmoteCommand(EMOTE_ONESHOT_SPELL_CAST_OMNI);
                            if (Unit* pTrigger =  me->SummonCreature(NPC_TRIGGER, ToCCommonLoc[1].GetPositionX(), ToCCommonLoc[1].GetPositionY(), ToCCommonLoc[1].GetPositionZ(), 4.69494f, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                m_uiTriggerGUID = pTrigger->GetGUID();
                                pTrigger->SetObjectScale(2.0f);
                                pTrigger->SetDisplayId(22862);
                                pTrigger->CastSpell(pTrigger, SPELL_WILFRED_PORTAL, false);
                            }
                            instance->SetData(TYPE_EVENT, 1132);
                            m_uiUpdateTimer = 4000;
                            break;
                        case 1132:
                            me->GetMotionMaster()->MovementExpired();
                            instance->SetData(TYPE_EVENT, 1134);
                            m_uiUpdateTimer = 4000;
                            break;
                        case 1134:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_SPELL_CAST_OMNI);
                            if (Creature* pPortal = me->SummonCreature(NPC_WILFRED_PORTAL, ToCCommonLoc[1].GetPositionX(), ToCCommonLoc[1].GetPositionY(), ToCCommonLoc[1].GetPositionZ(), 4.71239f, TEMPSUMMON_MANUAL_DESPAWN))
                            {
                                pPortal->SetReactState(REACT_PASSIVE);
                                pPortal->SetObjectScale(2.0f);
                                pPortal->CastSpell(pPortal, SPELL_WILFRED_PORTAL, false);
                                m_uiPortalGUID = pPortal->GetGUID();
                            }
                            m_uiUpdateTimer = 4000;
                            instance->SetData(TYPE_EVENT, 1135);
                            break;
                        case 1135:
                            instance->SetData(TYPE_EVENT, 1140);
                            m_uiUpdateTimer = 3000;
                            break;
                        case 1140:
                            Talk(SAY_STAGE_1_04);
                            if (Creature* temp = me->SummonCreature(NPC_JARAXXUS, ToCCommonLoc[1].GetPositionX(), ToCCommonLoc[1].GetPositionY(), ToCCommonLoc[1].GetPositionZ(), 5.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, DESPAWN_TIME))
                            {
                                temp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                temp->SetReactState(REACT_PASSIVE);
                                temp->GetMotionMaster()->MovePoint(0, ToCCommonLoc[1].GetPositionX(), ToCCommonLoc[1].GetPositionY()-10, ToCCommonLoc[1].GetPositionZ());
                            }
                            instance->SetData(TYPE_EVENT, 1142);
                            m_uiUpdateTimer = 5000;
                            break;
                        case 1142:
                            if (Creature* temp = Unit::GetCreature(*me, instance->GetData64(NPC_JARAXXUS)))
                                temp->SetTarget(me->GetGUID());
                            if (Creature* pTrigger = Unit::GetCreature(*me, m_uiTriggerGUID))
                                pTrigger->DespawnOrUnsummon();
                            if (Creature* pPortal = Unit::GetCreature(*me, m_uiPortalGUID))
                                pPortal->DespawnOrUnsummon();
                            instance->SetData(TYPE_EVENT, 1144);
                            m_uiUpdateTimer = 10000;
                            break;
                        case 1144:
                            if (Creature* temp = Unit::GetCreature(*me, instance->GetData64(NPC_JARAXXUS)))
                                temp->AI()->Talk(SAY_STAGE_1_05);
                            instance->SetData(TYPE_EVENT, 1150);
                            m_uiUpdateTimer = 5000;
                            break;
                        case 1150:
                            if (Creature* temp = Unit::GetCreature(*me, instance->GetData64(NPC_JARAXXUS)))
                            {
                                //1-shot Fizzlebang
                                temp->Kill(me);
                            }
                            instance->SetData(TYPE_EVENT, 1160);
                            m_uiUpdateTimer = 3000;
                            break;
                    }
                } else m_uiUpdateTimer -= uiDiff;
                instance->SetData(TYPE_EVENT_TIMER, m_uiUpdateTimer);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_fizzlebang_tocAI(creature);
        }
};

class npc_tirion_toc : public CreatureScript
{
    public:

        npc_tirion_toc() : CreatureScript("npc_tirion_toc") { }

        struct npc_tirion_tocAI : public ScriptedAI
        {
            npc_tirion_tocAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = me->GetInstanceScript();
            }

            InstanceScript* instance;
            uint32 m_uiUpdateTimer;

            void Reset() {}

            void AttackStart(Unit* /*who*/) {}

            void UpdateAI(const uint32 uiDiff)
            {
                if (!instance)
                    return;

                if (instance->GetData(TYPE_EVENT_NPC) != NPC_TIRION)
                    return;

                m_uiUpdateTimer = instance->GetData(TYPE_EVENT_TIMER);
                if (m_uiUpdateTimer <= uiDiff)
                {
                    switch (instance->GetData(TYPE_EVENT))
                    {
                        case 110:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_TALK);
                            Talk(SAY_STAGE_0_01);
                            m_uiUpdateTimer = 22000;
                            instance->SetData(TYPE_EVENT, 120);
                            break;
                        case 140:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_TALK);
                            Talk(SAY_STAGE_0_02);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 150);
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            break;
                        case 150:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                            if (instance->GetData(TYPE_BEASTS) != DONE)
                            {
                                if (Creature* temp = me->SummonCreature(NPC_GORMOK, ToCCommonLoc[10].GetPositionX(), ToCCommonLoc[10].GetPositionY(), ToCCommonLoc[10].GetPositionZ(), 5, TEMPSUMMON_CORPSE_DESPAWN))
                                {
                                    temp->GetMotionMaster()->MovePoint(1, ToCCommonLoc[5].GetPositionX(), ToCCommonLoc[5].GetPositionY(), ToCCommonLoc[5].GetPositionZ());
                                    temp->SetWalk(true);
                                    temp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                                    temp->SetReactState(REACT_PASSIVE);
                                }
                            }
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 155);
                            break;
                        case 155:
                            if (Creature* temp = Unit::GetCreature(*me, instance->GetData64(NPC_GORMOK)))
                            {
                                temp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                                temp->SetReactState(REACT_AGGRESSIVE);
                            }
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            instance->SetData(TYPE_BEASTS, IN_PROGRESS);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 160);
                            break;
                        case 200:
                            Talk(SAY_STAGE_0_04);
                            m_uiUpdateTimer = 8000;
                            instance->SetData(TYPE_EVENT, 205);
                            break;
                        case 205:
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 210);
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            break;
                        case 210:
                            if (instance->GetData(TYPE_BEASTS) != DONE)
                            {
                                if (Creature* temp = me->SummonCreature(NPC_DREADSCALE, ToCCommonLoc[3].GetPositionX(), ToCCommonLoc[3].GetPositionY(), ToCCommonLoc[3].GetPositionZ(), 5, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    temp->GetMotionMaster()->MovePoint(1, ToCCommonLoc[6].GetPositionX(), ToCCommonLoc[6].GetPositionY(), ToCCommonLoc[6].GetPositionZ());
                                    temp->SetWalk(true);
                                    temp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                                    temp->SetReactState(REACT_PASSIVE);
                                }
                                if (Creature* temp = me->SummonCreature(NPC_ACIDMAW, ToCCommonLoc[4].GetPositionX(), ToCCommonLoc[4].GetPositionY(), ToCCommonLoc[4].GetPositionZ(), 5, TEMPSUMMON_MANUAL_DESPAWN))
                                {
                                    temp->GetMotionMaster()->MovePoint(1, ToCCommonLoc[7].GetPositionX(), ToCCommonLoc[7].GetPositionY(), ToCCommonLoc[7].GetPositionZ());
                                    temp->SetWalk(true);
                                    temp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                                    temp->SetReactState(REACT_PASSIVE);
                                }
                            }
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 220);
                            break;
                        case 220:
                            if (Creature* temp = Unit::GetCreature((*me), instance->GetData64(NPC_DREADSCALE)))
                            {
                                temp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                                temp->SetReactState(REACT_AGGRESSIVE);
                            }
                            if (Creature* temp = Unit::GetCreature((*me), instance->GetData64(NPC_ACIDMAW)))
                            {
                                temp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE);
                                temp->SetReactState(REACT_AGGRESSIVE);
                            }
                            instance->SetData(TYPE_EVENT, 230);
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            break;
                        case 300:
                            Talk(SAY_STAGE_0_05);
                            m_uiUpdateTimer = 8000;
                            instance->SetData(TYPE_EVENT, 305);
                            break;
                        case 305:
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 310);
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            break;
                        case 310:
                            if (instance->GetData(TYPE_BEASTS) != DONE)
                            {
                                if (Creature* temp = me->SummonCreature(NPC_ICEHOWL, ToCCommonLoc[10].GetPositionX(), ToCCommonLoc[10].GetPositionY(), ToCCommonLoc[10].GetPositionZ(), 5, TEMPSUMMON_CORPSE_TIMED_DESPAWN, DESPAWN_TIME))
                                {
                                    temp->GetMotionMaster()->MovePoint(2, ToCCommonLoc[5].GetPositionX(), ToCCommonLoc[5].GetPositionY(), ToCCommonLoc[5].GetPositionZ());
                                }
                            }
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 315);
                            break;
                        case 315:
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            instance->SetData(TYPE_EVENT, 320);
                            break;
                        case 400:
                            Talk(SAY_STAGE_0_06);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 666:
                            Talk(SAY_STAGE_0_WIPE);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 1010:
                            Talk(SAY_STAGE_1_01);
                            m_uiUpdateTimer = 7000;
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            me->SummonCreature(NPC_FIZZLEBANG, ToCCommonLoc[10].GetPositionX(), ToCCommonLoc[10].GetPositionY(), ToCCommonLoc[10].GetPositionZ(), 2, TEMPSUMMON_CORPSE_TIMED_DESPAWN, DESPAWN_TIME);
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 1180:
                            Talk(SAY_STAGE_1_07);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 2000:
                            Talk(SAY_STAGE_1_08);
                            m_uiUpdateTimer = 18000;
                            instance->SetData(TYPE_EVENT, 2010);
                            break;
                        case 2030:
                            Talk(SAY_STAGE_1_11);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 3000:
                            Talk(SAY_STAGE_2_01);
                            m_uiUpdateTimer = 12000;
                            instance->SetData(TYPE_EVENT, 3050);
                            break;
                        case 3001:
                            Talk(SAY_STAGE_2_01);
                            m_uiUpdateTimer = 12000;
                            instance->SetData(TYPE_EVENT, 3051);
                            break;
                        case 3060:
                            Talk(SAY_STAGE_2_03);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 3070);
                            break;
                        case 3061:
                            Talk(SAY_STAGE_2_03);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 3071);
                            break;
                        //Summoning crusaders
                        case 3091:
                            if (Creature* pChampionController = me->SummonCreature(NPC_CHAMPIONS_CONTROLLER, ToCCommonLoc[1]))
                                pChampionController->AI()->SetData(0, HORDE);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 3092);
                            break;
                        //Summoning crusaders
                        case 3090:
                            if (Creature* pChampionController = me->SummonCreature(NPC_CHAMPIONS_CONTROLLER, ToCCommonLoc[1]))
                                pChampionController->AI()->SetData(0, ALLIANCE);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 3092);
                            break;
                        case 3092:
                            if (Creature* pChampionController = Unit::GetCreature((*me), instance->GetData64(NPC_CHAMPIONS_CONTROLLER)))
                                pChampionController->AI()->SetData(1, NOT_STARTED);
                            instance->SetData(TYPE_EVENT, 3095);
                            break;
                        //Crusaders battle end
                        case 3100:
                            Talk(SAY_STAGE_2_06);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 4000:
                            Talk(SAY_STAGE_3_01);
                            m_uiUpdateTimer = 13000;
                            instance->SetData(TYPE_EVENT, 4010);
                            break;
                        case 4010:
                            Talk(SAY_STAGE_3_02);
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 4015);
                            break;
                        case 4015:
                            if (Creature* temp = me->SummonCreature(NPC_LIGHTBANE, ToCCommonLoc[3].GetPositionX(), ToCCommonLoc[3].GetPositionY(), ToCCommonLoc[3].GetPositionZ(), 5, TEMPSUMMON_CORPSE_TIMED_DESPAWN, DESPAWN_TIME))
                            {
                                temp->GetMotionMaster()->MovePoint(0, ToCCommonLoc[6].GetPositionX(), ToCCommonLoc[6].GetPositionY(), ToCCommonLoc[6].GetPositionZ());
                                temp->SetWalk(true);
                                me->SetReactState(REACT_PASSIVE);
                            }

                            if (Creature* temp = me->SummonCreature(NPC_DARKBANE, ToCCommonLoc[4].GetPositionX(), ToCCommonLoc[4].GetPositionY(), ToCCommonLoc[4].GetPositionZ(), 5, TEMPSUMMON_CORPSE_TIMED_DESPAWN, DESPAWN_TIME))
                            {
                                temp->GetMotionMaster()->MovePoint(0, ToCCommonLoc[7].GetPositionX(), ToCCommonLoc[7].GetPositionY(), ToCCommonLoc[7].GetPositionZ());
                                temp->SetWalk(true);
                                me->SetReactState(REACT_PASSIVE);
                            }
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 4016);
                            break;
                        case 4016:
                            instance->SetData(TYPE_EVENT, 4017);
                            instance->DoUseDoorOrButton(instance->GetData64(GO_MAIN_GATE_DOOR));
                            break;
                        case 4040:
                            m_uiUpdateTimer = 60000;
                            instance->SetData(TYPE_EVENT, 5000);
                            break;
                        case 5000:
                            Talk(SAY_STAGE_4_01);
                            m_uiUpdateTimer = 10000;
                            instance->SetData(TYPE_EVENT, 5005);
                            break;
                        case 5005:
                            m_uiUpdateTimer = 8000;
                            instance->SetData(TYPE_EVENT, 5010);
                            me->SummonCreature(NPC_LICH_KING_1, ToCCommonLoc[2].GetPositionX(), ToCCommonLoc[2].GetPositionY(), ToCCommonLoc[2].GetPositionZ(), 5);
                            break;
                        case 5020:
                            Talk(SAY_STAGE_4_03);
                            m_uiUpdateTimer = 1000;
                            instance->SetData(TYPE_EVENT, 0);
                            break;
                        case 6000:
                            me->NearTeleportTo(AnubarakLoc[0].GetPositionX(), AnubarakLoc[0].GetPositionY(), AnubarakLoc[0].GetPositionZ(), 4.0f);
                            m_uiUpdateTimer = 20000;
                            instance->SetData(TYPE_EVENT, 6005);
                            break;
                        case 6005:
                            if (Creature* tirionFordring = Unit::GetCreature((*me), instance->GetData64(NPC_TIRION_FORDRING)))
                                tirionFordring->AI()->Talk(SAY_STAGE_4_06);
                            m_uiUpdateTimer = 20000;
                            instance->SetData(TYPE_EVENT, 6010);
                            break;
                        case 6010:
                            if (IsHeroic())
                            {
                                if (Creature* tirionFordring = Unit::GetCreature((*me), instance->GetData64(NPC_TIRION_FORDRING)))
                                    tirionFordring->AI()->Talk(SAY_STAGE_4_07);
                                m_uiUpdateTimer = 60000;
                                instance->SetData(TYPE_ANUBARAK, SPECIAL);
                                instance->SetData(TYPE_EVENT, 6020);
                            } else instance->SetData(TYPE_EVENT, 6030);
                            break;
                        case 6020:
                            me->DespawnOrUnsummon();
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 6030);
                            break;
                    }
                } else m_uiUpdateTimer -= uiDiff;
                instance->SetData(TYPE_EVENT_TIMER, m_uiUpdateTimer);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_tirion_tocAI(creature);
        }
};

class npc_garrosh_toc : public CreatureScript
{
    public:

        npc_garrosh_toc() : CreatureScript("npc_garrosh_toc") { }

        struct npc_garrosh_tocAI : public ScriptedAI
        {
            npc_garrosh_tocAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = me->GetInstanceScript();
            }

            InstanceScript* instance;
            uint32 m_uiUpdateTimer;

            void Reset() {}

            void AttackStart(Unit* /*who*/) {}

            void UpdateAI(const uint32 uiDiff)
            {
                if (!instance)
                    return;

                if (instance->GetData(TYPE_EVENT_NPC) != NPC_GARROSH)
                    return;

                m_uiUpdateTimer = instance->GetData(TYPE_EVENT_TIMER);
                if (m_uiUpdateTimer <= uiDiff)
                {
                    switch (instance->GetData(TYPE_EVENT))
                    {
                        case 130:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_TALK);
                            Talk(SAY_STAGE_0_03h);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 132);
                            break;
                        case 132:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 140);
                            break;
                        case 2010:
                            Talk(SAY_STAGE_1_09);
                            m_uiUpdateTimer = 9000;
                            instance->SetData(TYPE_EVENT, 2020);
                            break;
                        case 3050:
                            Talk(SAY_STAGE_2_02h);
                            m_uiUpdateTimer = 15000;
                            instance->SetData(TYPE_EVENT, 3060);
                            break;
                        case 3070:
                            Talk(SAY_STAGE_2_04h);
                            m_uiUpdateTimer = 6000;
                            instance->SetData(TYPE_EVENT, 3080);
                            break;
                        case 3081:
                            Talk(SAY_STAGE_2_05h);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 3091);
                            break;
                        case 4030:
                            Talk(SAY_STAGE_3_03h);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 4040);
                            break;
                    }
                } else m_uiUpdateTimer -= uiDiff;
                instance->SetData(TYPE_EVENT_TIMER, m_uiUpdateTimer);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_garrosh_tocAI(creature);
        }
};

class npc_varian_toc : public CreatureScript
{
    public:

        npc_varian_toc() : CreatureScript("npc_varian_toc") { }

        struct npc_varian_tocAI : public ScriptedAI
        {
            npc_varian_tocAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = me->GetInstanceScript();
            }

            InstanceScript* instance;
            uint32 m_uiUpdateTimer;

            void Reset() {}

            void AttackStart(Unit* /*who*/) {}

            void UpdateAI(const uint32 uiDiff)
            {
                if (!instance)
                    return;

                if (instance->GetData(TYPE_EVENT_NPC) != NPC_VARIAN)
                    return;

                m_uiUpdateTimer = instance->GetData(TYPE_EVENT_TIMER);
                if (m_uiUpdateTimer <= uiDiff)
                {
                    switch (instance->GetData(TYPE_EVENT))
                    {
                        case 120:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_TALK);
                            Talk(SAY_STAGE_0_03a);
                            m_uiUpdateTimer = 2000;
                            instance->SetData(TYPE_EVENT, 122);
                            break;
                        case 122:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 130);
                            break;
                        case 2020:
                            Talk(SAY_STAGE_1_10);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 2030);
                            break;
                        case 3051:
                            Talk(SAY_STAGE_2_02a);
                            m_uiUpdateTimer = 10000;
                            instance->SetData(TYPE_EVENT, 3061);
                            break;
                        case 3071:
                            Talk(SAY_STAGE_2_04a);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 3081);
                            break;
                        case 3080:
                            Talk(SAY_STAGE_2_05a);
                            m_uiUpdateTimer = 3000;
                            instance->SetData(TYPE_EVENT, 3090);
                            break;
                        case 4020:
                            Talk(SAY_STAGE_3_03a);
                            m_uiUpdateTimer = 5000;
                            instance->SetData(TYPE_EVENT, 4040);
                            break;
                    }
                } else m_uiUpdateTimer -= uiDiff;
                instance->SetData(TYPE_EVENT_TIMER, m_uiUpdateTimer);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_varian_tocAI(creature);
        }
};

#define MAX_ITEMSWITCH      353

uint32 itemswitch[MAX_ITEMSWITCH][2] =
{
    // Alliance ID, Horde ID
    {46958, 47255},
    {46959, 47252},
    {46960, 47251},
    {46961, 47253},
    {46962, 47254},
    {46963, 47260},
    {46964, 47421},
    {46965, 47412},
    {46966, 47413},
    {46967, 47414},
    {46968, 47415},
    {46969, 47416},
    {46970, 47257},
    {46971, 47418},
    {46972, 47258},
    {46973, 47419},
    {46974, 47259},
    {46975, 47420},
    {46976, 47256},
    {46977, 47417},
    {46979, 47261},
    {46980, 47422},
    {46985, 47263},
    {46986, 47424},
    {46988, 47262},
    {46989, 47423},
    {46990, 47265},
    {46991, 47426},
    {46992, 47264},
    {46993, 47425},
    {46994, 47267},
    {46995, 47428},
    {46996, 47266},
    {46997, 47269},
    {46999, 47268},
    {47000, 47270},
    {47001, 47427},
    {47002, 47429},
    {47004, 47431},
    {47041, 47271},
    {47042, 47275},
    {47043, 47272},
    {47051, 47274},
    {47052, 47273},
    {47053, 47276},
    {47054, 47327},
    {47055, 47277},
    {47056, 47280},
    {47057, 47279},
    {47059, 47432},
    {47060, 47433},
    {47061, 47434},
    {47062, 47435},
    {47063, 47436},
    {47064, 47437},
    {47066, 47438},
    {47067, 47440},
    {47068, 47441},
    {47069, 47285},
    {47070, 47282},
    {47071, 47284},
    {47072, 47283},
    {47073, 47281},
    {47074, 47442},
    {47075, 47443},
    {47076, 47444},
    {47077, 47445},
    {47078, 47446},
    {47079, 47287},
    {47080, 47290},
    {47081, 47286},
    {47082, 47288},
    {47083, 47289},
    {47084, 47447},
    {47085, 47448},
    {47086, 47449},
    {47087, 47450},
    {47088, 47451},
    {47089, 47291},
    {47090, 47295},
    {47092, 47293},
    {47093, 47294},
    {47094, 47292},
    {47095, 47452},
    {47096, 47453},
    {47097, 47454},
    {47098, 47455},
    {47099, 47456},
    {47104, 47300},
    {47105, 47297},
    {47106, 47296},
    {47107, 47299},
    {47108, 47298},
    {47109, 47457},
    {47110, 47458},
    {47111, 47459},
    {47112, 47460},
    {47113, 47461},
    {47114, 47302},
    {47115, 47303},
    {47116, 47305},
    {47121, 47304},
    {47126, 47301},
    {47129, 47462},
    {47130, 47463},
    {47131, 47464},
    {47132, 47465},
    {47133, 47466},
    {47138, 47309},
    {47139, 47307},
    {47140, 47308},
    {47141, 47306},
    {47142, 47310},
    {47143, 47467},
    {47144, 47468},
    {47145, 47469},
    {47146, 47470},
    {47147, 47471},
    {47148, 47314},
    {47149, 47315},
    {47150, 47312},
    {47151, 47313},
    {47152, 47311},
    {47153, 47472},
    {47154, 47473},
    {47155, 47474},
    {47156, 47475},
    {47157, 47476},
    {47182, 47316},
    {47183, 47320},
    {47184, 47319},
    {47186, 47318},
    {47187, 47317},
    {47188, 47477},
    {47189, 47478},
    {47190, 47479},
    {47191, 47480},
    {47192, 47481},
    {47193, 47322},
    {47194, 47321},
    {47195, 47323},
    {47203, 47324},
    {47204, 47325},
    {47205, 47482},
    {47206, 47483},
    {47207, 47484},
    {47208, 47485},
    {47209, 47486},
    {47223, 47278},
    {47224, 47439},
    {47225, 47328},
    {47233, 47329},
    {47234, 47330},
    {47235, 47326},
    {47236, 47487},
    {47237, 47489},
    {47238, 47490},
    {47239, 47491},
    {47240, 47492},
    {47578, 47854},
    {47607, 47849},
    {47608, 47853},
    {47609, 47851},
    {47610, 47850},
    {47611, 47852},
    {47612, 47856},
    {47613, 47857},
    {47614, 47859},
    {47615, 47858},
    {47616, 47860},
    {47617, 47855},
    {47618, 47862},
    {47619, 47864},
    {47620, 47865},
    {47621, 47866},
    {47622, 47640},
    {47623, 47641},
    {47624, 47644},
    {47625, 47645},
    {47626, 47643},
    {47627, 47642},
    {47628, 47650},
    {47629, 47646},
    {47630, 47649},
    {47631, 47648},
    {47632, 47652},
    {47633, 47653},
    {47634, 47651},
    {47635, 47647},
    {47654, 47639},
    {47655, 47638},
    {47656, 47637},
    {47657, 47636},
    {47663, 47861},
    {47669, 47863},
    {47676, 47871},
    {47679, 47872},
    {47680, 47869},
    {47683, 47867},
    {47700, 47888},
    {47703, 47868},
    {47717, 47876},
    {47718, 47875},
    {47719, 47878},
    {47720, 47877},
    {47721, 47873},
    {47724, 47874},
    {47725, 47881},
    {47726, 47879},
    {47727, 47882},
    {47728, 47880},
    {47736, 47886},
    {47737, 47884},
    {47738, 47885},
    {47739, 47887},
    {47740, 47883},
    {47741, 47907},
    {47742, 47913},
    {47743, 47892},
    {47744, 47893},
    {47745, 47889},
    {47746, 47891},
    {47747, 47890},
    {47808, 47898},
    {47809, 47894},
    {47810, 47899},
    {47811, 47896},
    {47812, 47895},
    {47813, 47897},
    {47814, 47903},
    {47815, 47900},
    {47816, 47905},
    {47829, 47901},
    {47830, 47902},
    {47832, 47904},
    {47834, 47911},
    {47835, 47910},
    {47836, 47908},
    {47837, 47909},
    {47838, 47906},
    {47915, 47988},
    {47916, 47989},
    {47917, 47990},
    {47918, 47991},
    {47919, 47992},
    {47920, 47993},
    {47921, 47994},
    {47922, 47995},
    {47923, 47996},
    {47924, 47997},
    {47925, 47998},
    {47926, 47999},
    {47927, 48000},
    {47928, 48001},
    {47929, 48002},
    {47930, 48003},
    {47931, 48004},
    {47932, 48005},
    {47933, 48006},
    {47934, 48007},
    {47935, 48008},
    {47938, 48010},
    {47939, 48011},
    {47940, 48012},
    {47941, 48013},
    {47942, 48014},
    {47943, 48015},
    {47944, 48016},
    {47945, 48017},
    {47946, 48018},
    {47947, 48019},
    {47948, 48020},
    {47949, 48021},
    {47950, 48022},
    {47951, 48023},
    {47952, 48024},
    {47953, 48025},
    {47954, 48026},
    {47955, 48027},
    {47956, 48028},
    {47957, 48030},
    {47958, 48032},
    {47959, 48034},
    {47960, 48036},
    {47961, 48038},
    {47962, 48039},
    {47963, 48040},
    {47964, 48041},
    {47965, 48042},
    {47966, 48043},
    {47967, 48044},
    {47968, 48045},
    {47969, 48046},
    {47970, 48047},
    {47971, 48048},
    {47972, 48049},
    {47973, 48050},
    {47974, 48051},
    {47975, 48052},
    {47976, 48053},
    {47977, 48054},
    {47978, 48055},
    {47979, 48056},
    {49231, 49232},
    {49234, 49233},
    {49235, 49236},
    {49238, 49237},
    {47003, 47430},
    {47711, 47870},
    {47937, 48009},
    {47506, 47513},
    {47515, 47516},
    {47517, 47518},
    {47519, 47520},
    {47521, 47523},
    {47524, 47525},
    {47526, 47528},
    {47545, 47546},
    {47547, 47548},
    {47549, 47550},
    {47552, 47551},
    {47553, 47554},
    {48671, 48666},
    {48672, 48667},
    {48673, 48668},
    {48674, 48669},
    {48675, 48670},
    {48708, 48701},
    {48709, 48693},
    {48710, 48705},
    {48711, 48697},
    {48712, 48703},
    {48713, 48695},
    {48714, 48699},
    {49044, 49046},
    {47570, 47571},
    {47572, 47573},
    {47574, 47575},
    {47576, 47577},
    {47579, 47580},
    {47581, 47582},
    {47583, 47584},
    {47585, 47586},
    {47587, 47588},
    {47589, 47590},
    {47591, 47592},
    {47593, 47594},
    {47595, 47596},
    {47597, 47598},
    {47599, 47600},
    {47602, 47601},
    {47603, 47604},
    {47605, 47606}
};

class npc_pdk_murloc_toc : public CreatureScript
{
    public:
        npc_pdk_murloc_toc() : CreatureScript("npc_pdk_murloc_toc") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        InstanceScript* instance = creature->GetInstanceScript();

        if (!instance)
            return false;

        if (player->isInCombat() || instance->IsEncounterInProgress())
            return true;

        Creature* temp = Unit::GetCreature((*creature), instance->GetData64(NPC_ANUBARAK));

        // Prevent this processing if we are the upper floor murloc, only allow it for the lower floor!
        // Murloc is spawned at 140 Z on the lower floor right now
        if (creature->GetPositionZ() <= 150.0f)
            if (!temp || instance->GetData(TYPE_ANUBARAK) == DONE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Teleportiere mich vor die Instanz!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Tausche meine Items um!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);

        if (player->GetRaidDifficulty() == RAID_DIFFICULTY_10MAN_HEROIC) // add check for dedicated insanity in 10 man heroic
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Sind wir bereit für den sicheren Wahnsinn?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);

        player->SEND_GOSSIP_MENU(50030, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        if (!player)
            return true;

        player->CLOSE_GOSSIP_MENU();

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                player->TeleportTo(571, 8515.552f, 725.856f, 558.3f, 1.61f);
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                for (uint32 i = 0; i < MAX_ITEMSWITCH; i++)
                {
                    if (player->GetTeamId() == TEAM_HORDE)
                    {
                        if (Item* item = player->GetItemByEntry(itemswitch[i][0]))
                        {
                            ItemPosCountVec dest;
                            InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemswitch[i][1], 1);

                            if (msg == EQUIP_ERR_OK)
                            {
                                sLog->outInfo(LOG_FILTER_TSCR, "PDK Murloc Item Switch: Item %u swapped with item %u for player %s", itemswitch[i][0], itemswitch[i][1], player->GetName());

                                player->StoreNewItem(dest, itemswitch[i][1], true, Item::GenerateItemRandomPropertyId(itemswitch[i][1]));
                                player->DestroyItemCount(itemswitch[i][0], 1, true, false);
                            }
                        }
                    }
                    else if (player->GetTeamId() == TEAM_ALLIANCE)
                    {
                        if (Item* item = player->GetItemByEntry(itemswitch[i][1]))
                        {
                            ItemPosCountVec dest;
                            InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemswitch[i][0], 1);

                            if (msg == EQUIP_ERR_OK)
                            {
                                sLog->outInfo(LOG_FILTER_TSCR, "PDK Murloc Item Switch: Item %u swapped with item %u for player %s", itemswitch[i][1], itemswitch[i][0], player->GetName());

                                player->StoreNewItem(dest, itemswitch[i][0], true, Item::GenerateItemRandomPropertyId(itemswitch[i][0]));
                                player->DestroyItemCount(itemswitch[i][1], 1, true, false);
                            }
                        }
                    }
                }
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                if (InstanceScript* instance = player->GetInstanceScript())
                {
                    Group* group = player->GetGroup();
                    if (!group)
                        return true;

                    player->PlayerTalkClass->ClearMenus();

                    if (group->GetMembersCount() == 0)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Oops, da ist etwas schief gelaufen!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                    else
                        for (GroupReference* itr = group->GetFirstMember(); itr != 0; itr = itr->next())
                            if (Player* member = itr->getSource())
                            {
                                if (member->isGameMaster())
                                    continue;
                                instance->SetData64(DATA_TRIBUTE_TO_DEDICATED_INSTANY_DUMMY_CHECK, member->GetGUID());
                                player->ADD_GOSSIP_ITEM(instance->GetData(DATA_TRIBUTE_TO_DEDICATED_INSTANY_DUMMY_CHECK) > 0 ? GOSSIP_ICON_DOT : GOSSIP_ICON_BATTLE, member->GetName(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
                            }

                    player->SEND_GOSSIP_MENU(50031, creature->GetGUID());
                }
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                // do nothing when player clicked on a players name in dedicated insanity submenu
                break;
        }

        return true;
    }
};

class DedicatedInsanityItemCheck : public PlayerScript
{
    public:
        DedicatedInsanityItemCheck() : PlayerScript("DedicatedInsanityItemCheck") { }

    void OnEquipItem(Player* player, uint32 /*item*/)
    {
        if (player->GetMapId() != 649 || player->GetRaidDifficulty() != RAID_DIFFICULTY_10MAN_HEROIC)
            return; // Dedicated Insanity is limited to ToC10 (Heroic)

        if (!player->isInCombat())
            return; // Complete Gearcheck is done on SetData In_PROGRESS, so we need to check only when in combat (like weapon changes etc.)

        if (InstanceScript* instance = player->GetInstanceScript())
            instance->SetData64(DATA_TRIBUTE_TO_DEDICATED_INSANITY_CHECK, player->GetGUID());
    }

};

void AddSC_trial_of_the_crusader()
{
    new npc_announcer_toc10();
    new boss_lich_king_toc();
    new npc_fizzlebang_toc();
    new npc_tirion_toc();
    new npc_garrosh_toc();
    new npc_varian_toc();
    new npc_pdk_murloc_toc();
    new DedicatedInsanityItemCheck();
}
