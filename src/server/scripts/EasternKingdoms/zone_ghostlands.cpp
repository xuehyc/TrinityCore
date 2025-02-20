///*
// * Copyright (C) 2022 BfaCore Reforged
// *
// * This program is free software; you can redistribute it and/or modify it
// * under the terms of the GNU General Public License as published by the
// * Free Software Foundation; either version 2 of the License, or (at your
// * option) any later version.
// *
// * This program is distributed in the hope that it will be useful, but WITHOUT
// * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// * more details.
// *
// * You should have received a copy of the GNU General Public License along
// * with this program. If not, see <http://www.gnu.org/licenses/>.
// */
//
///* ScriptData
//SDName: Ghostlands
//SD%Complete: 100
//SDComment:
//SDCategory: Ghostlands
//EndScriptData */
//
///* ContentData
//npc_ranger_lilatha
//EndContentData */
//
//#include "ScriptMgr.h"
//#include "GameObject.h"
//#include "Player.h"
//#include "ScriptedEscortAI.h"
//#include "ScriptedGossip.h"
//#include "TemporarySummon.h"
//#include "WorldSession.h"
//
///*######
//
//## npc_ranger_lilatha
//######*/
//
//enum RangerLilatha
//{
//    SAY_START                           = 0,
//    SAY_PROGRESS1                       = 1,
//    SAY_PROGRESS2                       = 2,
//    SAY_PROGRESS3                       = 3,
//    SAY_END1                            = 4,
//    SAY_END2                            = 5,
//    SAY_CAPTAIN_ANSWER                  = 0,
//    QUEST_ESCAPE_FROM_THE_CATACOMBS     = 9212,
//    GO_CAGE                             = 181152,
//    NPC_CAPTAIN_HELIOS                  = 16220,
//    NPC_MUMMIFIED_HEADHUNTER            = 16342,
//    NPC_SHADOWPINE_ORACLE               = 16343,
//    FACTION_QUEST_ESCAPE                = 113
//};
//
//class npc_ranger_lilatha : public CreatureScript
//{
//public:
//    npc_ranger_lilatha() : CreatureScript("npc_ranger_lilatha") { }
//
//    struct npc_ranger_lilathaAI : public npc_escortAI
//    {
//        npc_ranger_lilathaAI(Creature* creature) : npc_escortAI(creature) { }
//
//        void WaypointReached(uint32 waypointId) override
//        {
//            Player* player = GetPlayerForEscort();
//            if (!player)
//                return;
//
//            switch (waypointId)
//            {
//                case 0:
//                    me->SetStandState(UNIT_STAND_STATE_STAND);
//                    if (GameObject* Cage = me->FindNearestGameObject(GO_CAGE, 20))
//                        Cage->SetGoState(GO_STATE_ACTIVE);
//                    Talk(SAY_START, player);
//                    break;
//                case 5:
//                    Talk(SAY_PROGRESS1, player);
//                    break;
//                case 11:
//                    Talk(SAY_PROGRESS2, player);
//                    me->SetFacingTo(4.762841f);
//                    break;
//                case 18:
//                    {
//                        Talk(SAY_PROGRESS3, player);
//                        TempSummon* Summ1 = me->SummonCreature(NPC_MUMMIFIED_HEADHUNTER, 7627.083984f, -7532.538086f, 152.128616f, 1.082733f, TEMPSUMMON_DEAD_DESPAWN, 0);
//                        TempSummon* Summ2 = me->SummonCreature(NPC_SHADOWPINE_ORACLE, 7620.432129f, -7532.550293f, 152.454865f, 0.827478f, TEMPSUMMON_DEAD_DESPAWN, 0);
//                        if (Summ1 && Summ2)
//                        {
//                            Summ1->Attack(me, true);
//                            Summ2->Attack(player, true);
//                        }
//                        AttackStart(Summ1);
//                    }
//                    break;
//                case 19:
//                    me->SetWalk(false);
//                    break;
//                case 25:
//                    me->SetWalk(true);
//                    break;
//                case 30:
//                    player->GroupEventHappens(QUEST_ESCAPE_FROM_THE_CATACOMBS, me);
//                    break;
//                case 32:
//                    me->SetFacingTo(2.978281f);
//                    Talk(SAY_END1, player);
//                    break;
//                case 33:
//                    me->SetFacingTo(5.858011f);
//                    Talk(SAY_END2, player);
//                    Creature* CaptainHelios = me->FindNearestCreature(NPC_CAPTAIN_HELIOS, 50);
//                    if (CaptainHelios)
//                        CaptainHelios->AI()->Talk(SAY_CAPTAIN_ANSWER, player);
//                    break;
//            }
//        }
//
//        void Reset() override
//        {
//            if (GameObject* Cage = me->FindNearestGameObject(GO_CAGE, 20))
//                Cage->SetGoState(GO_STATE_READY);
//        }
//    };
//
//    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
//    {
//        if (quest->GetQuestId() == QUEST_ESCAPE_FROM_THE_CATACOMBS)
//        {
//            creature->SetFaction(FACTION_QUEST_ESCAPE);
//
//            if (npc_escortAI* pEscortAI = CAST_AI(npc_ranger_lilatha::npc_ranger_lilathaAI, creature->AI()))
//                pEscortAI->Start(true, false, player->GetGUID());
//        }
//        return true;
//    }
//
//    CreatureAI* GetAI(Creature* creature) const override
//    {
//        return new npc_ranger_lilathaAI(creature);
//    }
//
//};
//
///*######
//## npc_rathis_tomber
//######*/
//
//class npc_rathis_tomber : public CreatureScript
//{
//public:
//    npc_rathis_tomber() : CreatureScript("npc_rathis_tomber") {}
//
//    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
//    {
//        player->PlayerTalkClass->ClearMenus();
//        if (action == GOSSIP_ACTION_TRADE)
//            player->GetSession()->SendListInventory(creature->GetGUID());
//        return true;
//    }
//
//    bool OnGossipHello(Player* player, Creature* creature) override
//    {
//        if (creature->IsQuestGiver())
//            player->PrepareQuestMenu(creature->GetGUID());
//
//        if (creature->IsVendor() && player->GetQuestRewardStatus(9152))
//        {
//            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
//            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
//        }
//        else
//            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
//
//        return true;
//    }
//};
//
//void AddSC_ghostlands()
//{
//    new npc_rathis_tomber();
//    new npc_ranger_lilatha();
//}
