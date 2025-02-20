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
//#include "ScriptMgr.h"
//#include "ScriptedCreature.h"
//#include "ObjectMgr.h"
//#include "ScriptMgr.h"
//
//#define BOSS_XUEN 0
//
//enum eSpells
//{
//};
//
//enum eEvents
//{
//};
//
//enum eCreatures
//{
//};
//
//enum eSays
//{
//};
//
//enum eActions
//{
//};
//
//class boss_xuen : public CreatureScript
//{
//    public:
//        boss_xuen() : CreatureScript("boss_xuen") { }
//
//        struct boss_xuenAI : public BossAI
//        {
//            boss_xuenAI(Creature* creature) : BossAI(creature, BOSS_XUEN) { }
//
//            EventMap events;
//
//            void Reset() override
//            {
//                events.Reset();
//
//                _Reset();
//            }
//
//            void KilledUnit(Unit* who) override
//            {
//                if (who->ToPlayer())
//                    //Talk(TALK_SLAY);
//                        return;
//            }
//
//            void EnterCombat(Unit* /*attacker*/) override
//            {
//            }
//
//            void JustDied(Unit* /*killer*/) override
//            {
//            }
//
//            void DoAction(const int32 /*action*/) override
//            {
//            }
//
//            void UpdateAI(uint32 diff) override
//            {
//                if (!UpdateVictim())
//                    return;
//
//                if (me->HasUnitState(UNIT_STATE_CASTING))
//                    return;
//
//                events.Update(diff);
//
//                /*switch (events.ExecuteEvent())
//                {
//                    default:
//                        break;
//                }*/
//
//                DoMeleeAttackIfReady();
//            }
//        };
//
//        CreatureAI* GetAI(Creature* creature) const override
//        {
//            return new boss_xuenAI(creature);
//        }
//};
//
//void AddSC_boss_xuen()
//{
//    new boss_xuen();
//}
