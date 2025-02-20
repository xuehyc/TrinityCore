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
//SDName: Arathi Highlands
//SD%Complete: 100
//SDComment: Quest support: 665
//SDCategory: Arathi Highlands
//EndScriptData */
//
///* ContentData
//npc_professor_phizzlethorpe
//EndContentData */
//
//#include "ScriptMgr.h"
//#include "ScriptedCreature.h"
//#include "ScriptedEscortAI.h"
//#include "Player.h"
//#include "Spell.h"
//#include "SpellInfo.h"
//#include "ScriptedGossip.h"
//#include "SpellScript.h"
//#include "PhasingHandler.h"
//
///*######
//## npc_professor_phizzlethorpe
//######*/
//
//enum ProfessorPhizzlethorpe
//{
//    // Yells
//    SAY_PROGRESS_1          = 0,
//    SAY_PROGRESS_2          = 1,
//    SAY_PROGRESS_3          = 2,
//    EMOTE_PROGRESS_4        = 3,
//    SAY_AGGRO               = 4,
//    SAY_PROGRESS_5          = 5,
//    SAY_PROGRESS_6          = 6,
//    SAY_PROGRESS_7          = 7,
//    EMOTE_PROGRESS_8        = 8,
//    SAY_PROGRESS_9          = 9,
//    EVENT_SAY_3             = 1,
//    EVENT_SAY_6             = 2,
//    EVENT_SAY_8             = 3,
//
//    // Quests
//    QUEST_SUNKEN_TREASURE   = 665,
//    QUEST_GOGGLE_BOGGLE     = 26050,
//    // Creatures
//    NPC_VENGEFUL_SURGE      = 2776,
//    FACTION_SUNKEN_TREASURE = 113
//};
//
//struct npc_professor_phizzlethorpe : public npc_escortAI
//{
//    npc_professor_phizzlethorpe(Creature* creature) : npc_escortAI(creature) { }
//
//    void WaypointReached(uint32 waypointId) 
//    {
//        Player* player = GetPlayerForEscort();
//        if (!player)
//            return;
//
//        switch (waypointId)
//        {
//            case 6:
//                Talk(SAY_PROGRESS_2, player);
//                events.ScheduleEvent(EVENT_SAY_3, 3000);
//                break;
//            case 8:
//                Talk(EMOTE_PROGRESS_4);
//                me->SummonCreature(NPC_VENGEFUL_SURGE, -2065.505f, -2136.88f, 22.20362f, 1.0f, TEMPSUMMON_CORPSE_DESPAWN, 0);
//                me->SummonCreature(NPC_VENGEFUL_SURGE, -2059.249f, -2134.88f, 21.51582f, 1.0f, TEMPSUMMON_CORPSE_DESPAWN, 0);
//                break;
//            case 11:
//                Talk(SAY_PROGRESS_5, player);
//                events.ScheduleEvent(EVENT_SAY_6, 11000);
//                break;
//            case 17:
//                Talk(SAY_PROGRESS_7, player);
//                events.ScheduleEvent(EVENT_SAY_8, 6000);
//                break;
//        }
//    }
//
//    void JustSummoned(Creature* summoned) 
//    {
//        summoned->AI()->AttackStart(me);
//    }
//
//    void EnterCombat(Unit* /*who*/) 
//    {
//        Talk(SAY_AGGRO);
//    }
//
//    void sQuestAccept(Player* player, Quest const* quest) 
//    {
//        if (quest->GetQuestId() == QUEST_SUNKEN_TREASURE)
//        {
//            Talk(SAY_PROGRESS_1, player);
//            npc_escortAI::Start(false, false, player->GetGUID(), quest);
//            me->SetFaction(FACTION_SUNKEN_TREASURE);
//        }
//    }
//
//    void UpdateAI(uint32 diff) 
//    {
//        Player* player = GetPlayerForEscort();
//        if (!player)
//            return;
//
//        events.Update(diff);
//
//        while (uint32 event = events.ExecuteEvent())
//        {
//            switch (event)
//            {
//                case EVENT_SAY_3:
//                    Talk(SAY_PROGRESS_3, player);
//                    break;
//                case EVENT_SAY_6:
//                    Talk(SAY_PROGRESS_6, player);
//                    SetRun();
//                    break;
//                case EVENT_SAY_8:
//                    Talk(EMOTE_PROGRESS_8);
//                    Talk(SAY_PROGRESS_9, player);
//                    player->GroupEventHappens(QUEST_GOGGLE_BOGGLE, me);
//                    break;
//            }
//        }
//        npc_escortAI::UpdateAI(diff);
//    }
//
//    EventMap events;
//};
//
//// I decided not to delete a piece of code, it may come in handy in the future.
//// This code creates a second copy of Myzrael and appears to be outdated for the BFA 
//// since Myzrael appears without this script.
//// enum Myzrael
//// {
////     NPC_MYZRAEL = 2755
//// };
//
//// class spell_summon_myzrael : public SpellScript
//// {
////     PrepareSpellScript(spell_summon_myzrael);
//
////     void HandleDummy(SpellEffIndex /*effIndex*/)
////     {
////         if (Creature* myzrael = GetCaster()->SummonCreature(NPC_MYZRAEL, -948.493f, -3113.98f, 50.4207f, 3.14159f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 90000))
////         {
////             myzrael->SetReactState(REACT_AGGRESSIVE);
////             myzrael->SetFaction(14);
////             myzrael->AddUnitFlag(UNIT_FLAG_PVP_ATTACKABLE);
////         }
////     }
//
////     void Register() override
////     {
////         OnEffectHitTarget += SpellEffectFn(spell_summon_myzrael::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
////     }
//// };
//
//class arathi_highlands : public PlayerScript
//{
//public:
//    arathi_highlands() : PlayerScript("arathi_highlands") { }
//    
//    void OnUpdateZone(Player* player, uint32 newZone, uint32 /*oldZone*/, uint32 /*newArea*/) override
//    {
//        if (player->getLevel() == 120 && player->GetZoneId() == 9734 && newZone == 9734)
//            PhasingHandler::AddPhase(player, 11292, true);
//
//        if (player->getLevel() == 120 && player->GetZoneId() != 9734 && newZone != 9734)
//            PhasingHandler::RemovePhase(player, 11292, true);
//    }
//};
//
//void AddSC_arathi_highlands()
//{
//    RegisterCreatureAI(npc_professor_phizzlethorpe);
//    // RegisterSpellScript(spell_summon_myzrael);
//    RegisterPlayerScript(arathi_highlands);
//}
