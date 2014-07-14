/*
 *
 * Copyright (C) 2011-2014 ArkCORE <http://www.arkania.net/>
 *
 * Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
 *
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
SDName: Westfall
SD%Complete: 90
SDComment: Quest support: 1651
SDCategory: Westfall
EndScriptData */

/* ContentData
npc_daphne_stilwell
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

/*######
## npc_daphne_stilwell
######*/

enum DaphneStilwell
{
    // Yells
    SAY_DS_START        = 0,
    SAY_DS_DOWN_1       = 1,
    SAY_DS_DOWN_2       = 2,
    SAY_DS_DOWN_3       = 3,
    SAY_DS_PROLOGUE     = 4,

    // Spells
    SPELL_SHOOT         = 6660,

    // Quests
    QUEST_TOME_VALOR    = 1651,

    // Creatures
    NPC_DEFIAS_RAIDER   = 6180,

    // Equips
    EQUIP_ID_RIFLE      = 2511
};

class npc_daphne_stilwell : public CreatureScript
{
public:
    npc_daphne_stilwell() : CreatureScript("npc_daphne_stilwell") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_TOME_VALOR)
        {
            creature->AI()->Talk(SAY_DS_START);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_daphne_stilwell::npc_daphne_stilwellAI, creature->AI()))
                pEscortAI->Start(true, true, player->GetGUID());
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_daphne_stilwellAI(creature);
    }

    struct npc_daphne_stilwellAI : public npc_escortAI
    {
        npc_daphne_stilwellAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 uiWPHolder;
        uint32 uiShootTimer;

        void Reset() override
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                switch (uiWPHolder)
                {
                    case 7:
                        Talk(SAY_DS_DOWN_1);
                        break;
                    case 8:
                        Talk(SAY_DS_DOWN_2);
                        break;
                    case 9:
                        Talk(SAY_DS_DOWN_3);
                        break;
                }
            }
            else
                uiWPHolder = 0;

            uiShootTimer = 0;
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            uiWPHolder = waypointId;

            switch (waypointId)
            {
                case 4:
                    SetEquipmentSlots(false, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE, EQUIP_ID_RIFLE);
                    me->SetSheath(SHEATH_STATE_RANGED);
                    me->HandleEmoteCommand(EMOTE_STATE_USE_STANDING_NO_SHEATHE);
                    break;
                case 7:
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11450.836f, 1569.755f, 54.267f, 4.230f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11449.697f, 1569.124f, 54.421f, 4.206f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11448.237f, 1568.307f, 54.620f, 4.206f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 8:
                    me->SetSheath(SHEATH_STATE_RANGED);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11450.836f, 1569.755f, 54.267f, 4.230f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11449.697f, 1569.124f, 54.421f, 4.206f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11448.237f, 1568.307f, 54.620f, 4.206f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11448.037f, 1570.213f, 54.961f, 4.283f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 9:
                    me->SetSheath(SHEATH_STATE_RANGED);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11450.836f, 1569.755f, 54.267f, 4.230f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11449.697f, 1569.124f, 54.421f, 4.206f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11448.237f, 1568.307f, 54.620f, 4.206f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11448.037f, 1570.213f, 54.961f, 4.283f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11449.018f, 1570.738f, 54.828f, 4.220f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 10:
                    SetRun(false);
                    break;
                case 11:
                    Talk(SAY_DS_PROLOGUE);
                    break;
                case 13:
                    SetEquipmentSlots(true);
                    me->SetSheath(SHEATH_STATE_UNARMED);
                    me->HandleEmoteCommand(EMOTE_STATE_USE_STANDING_NO_SHEATHE);
                    break;
                case 17:
                    player->GroupEventHappens(QUEST_TOME_VALOR, me);
                    break;
            }
        }

        void AttackStart(Unit* who) override
        {
            if (!who)
                return;

            if (me->Attack(who, false))
            {
                me->AddThreat(who, 0.0f);
                me->SetInCombatWith(who);
                who->SetInCombatWith(me);

                me->GetMotionMaster()->MoveChase(who, 30.0f);
            }
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->AI()->AttackStart(me);
        }

        void Update(const uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (uiShootTimer <= diff)
            {
                uiShootTimer = 1500;

                if (!me->IsWithinDist(me->GetVictim(), ATTACK_DISTANCE))
                    DoCastVictim(SPELL_SHOOT);
            } else uiShootTimer -= diff;
        }
    };
};

// #############################################  quest 26209: Murder Was The Case That They Gave Me

enum eQuest26209
{
    NPC_INVESTIGATOR_42559 = 42559,
    NPC_INVESTIGATOR_42309 = 42309,
    NPC_HORATIO_LANE = 42308,
    NPC_WEST_PLAINS_DRIFTERS = 42391,
    NPC_HOMELESS_STORMWIND_CITZEN = 42386,
    NPC_TRANSIENT = 42383,
    NPC_RAGMUFFIN = 42413,
    QUEST_MURDER_WAS_THE_CASE_THAT_THEY_GAVE_ME = 26209,
};

class npc_investigator42559 : public CreatureScript
{
public:
    npc_investigator42559() : CreatureScript("npc_investigator42559") { }

    struct npc_investigator42559AI : public ScriptedAI
    {
        npc_investigator42559AI(Creature *c) : ScriptedAI(c) { }


        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_investigator42559AI(creature);
    }
};

class npc_investigator42309 : public CreatureScript
{
public:
    npc_investigator42309() : CreatureScript("npc_investigator42309") { }

    struct npc_investigator42309AI : public ScriptedAI
    {
        npc_investigator42309AI(Creature *c) : ScriptedAI(c) { }


        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_investigator42309AI(creature);
    }
};

class npc_horatio_lane : public CreatureScript
{
public:
    npc_horatio_lane() : CreatureScript("npc_horatio_lane") { }

    struct npc_horatio_laneAI : public ScriptedAI
    {
        npc_horatio_laneAI(Creature* creature) : ScriptedAI(creature)
        {
            m_homePosition = Position(-9850.017578f, 916.479980f, 30.302572f, 0.0f);
            m_investigationPosition = Position(-9852.655273f, 910.777222f, 29.948130f, 0.0f);
        }

        uint32  m_timer;
        uint32  m_phase;
        uint32  m_cooldown;
        Position m_homePosition, m_investigationPosition;

        void Reset() override
        {
            m_timer = 1000; m_phase = 0; m_cooldown = 0;
            me->RemoveAllAuras();
            me->HandleEmoteCommand(EMOTE_STATE_STAND);
            me->SetWalk(true);
            me->GetMotionMaster()->MovePoint(0, m_homePosition);
            me->SetFacingTo(3.95f);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (Player* m_player = who->ToPlayer())
            if (me->GetDistance2d(m_player) < 5 && m_phase == 0)
            {
                m_phase = 1; m_timer = 2000; m_cooldown = 300000;
            }
        }


        void UpdateAI(uint32 diff) override
        {
            if (m_timer <= diff)
            {
                m_timer = 1000;
                DoWork();
            }
            else
                m_timer -= diff;

            if (m_cooldown > 0)
            {
                if (m_cooldown <= diff)
                {
                    m_phase = 8; m_timer = 1000;
                }
                else
                    m_cooldown -= diff;
            }

            if (!UpdateVictim())
                return;
            else
                DoMeleeAttackIfReady();
        }

        void DoWork()
        {
            switch (m_phase)
            {
            case 1:
                if (Creature* invest = me->FindNearestCreature(NPC_INVESTIGATOR_42309, 15.0f))
                    invest->AI()->Talk(5);

                m_phase = 2; m_timer = 5000;
                break;
            case 2:
                if (Creature* invest = me->FindNearestCreature(NPC_INVESTIGATOR_42309, 15.0f))
                    invest->AI()->Talk(0);

                m_phase = 3; m_timer = 5000;
                break;
            case 3:
                if (Creature* invest = me->FindNearestCreature(NPC_INVESTIGATOR_42559, 15.0f))
                    invest->AI()->Talk(urand(0, 3));

                m_phase = 4; m_timer = 4000;
                break;
            case 4:
                Talk(0);
                me->GetMotionMaster()->MovePoint(0, m_investigationPosition);
                m_phase = 5; m_timer = 5000;
                break;
            case 5:
                Talk(1);
                me->SetFacingTo(5.083f);
                me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                m_phase = 6; m_timer = 5000;
                break;
            case 6:
                Talk(2);
                m_phase = 7; m_timer = 5000;
                break;
            case 7:
                m_phase = 8; m_timer = 5000;
                break;
            case 8:
                me->GetMotionMaster()->MovePoint(0, m_homePosition);
                m_phase = 9; m_timer = 3000;
                break;
            case 9:
                me->HandleEmoteCommand(EMOTE_STATE_STAND);
                me->SetFacingTo(3.95f);
                m_phase = 10; m_timer = 60000;
                break;
            case 10:
                m_phase = 0; m_timer = 0; m_cooldown = 0;
                break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_horatio_laneAI(creature);
    }
};



void AddSC_westfall()
{
    new npc_daphne_stilwell();
    new npc_investigator42559();
    new npc_investigator42309();
    new npc_horatio_lane();
    // new npc_west_plains_drifters();
    // new npc_homeless_stormwind_citizen();
    // new npc_transient();
    // new npc_ragamuffin();

}
