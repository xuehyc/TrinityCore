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
SDName: Silvermoon_City
SD%Complete: 100
SDComment: Quest support: 9685
SDCategory: Silvermoon City
EndScriptData */

/* ContentData
npc_blood_knight_stillblade
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

/*#######
# npc_blood_knight_stillblade
#######*/
enum eStillbladeData
{
    SAY_HEAL                    = -1000193,

    QUEST_REDEEMING_THE_DEAD    = 9685,
    SPELL_SHIMMERING_VESSEL     = 31225,
    SPELL_REVIVE_SELF           = 32343,
};

class npc_blood_knight_stillblade : public CreatureScript
{
public:
    npc_blood_knight_stillblade() : CreatureScript("npc_blood_knight_stillblade") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_blood_knight_stillbladeAI (creature);
    }

    struct npc_blood_knight_stillbladeAI : public ScriptedAI
    {
        npc_blood_knight_stillbladeAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 lifeTimer;
        bool spellHit;

        void Reset()
        {
            lifeTimer = 120000;
            me->SetStandState(UNIT_STAND_STATE_DEAD);
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 7);   // lay down
            spellHit = false;
        }

        void EnterCombat(Unit* /*who*/)
        {
        }

        void MoveInLineOfSight(Unit* /*who*/)
        {
        }

        void UpdateAI(const uint32 diff)
        {
            if (me->IsStandState())
            {
                if (lifeTimer <= diff)
                    me->AI()->EnterEvadeMode();
                else
                    lifeTimer -= diff;
            }
        }

        void SpellHit(Unit* Hitter, const SpellInfo* Spellkind)
        {
            if ((Spellkind->Id == SPELL_SHIMMERING_VESSEL) && !spellHit &&
                (Hitter->GetTypeId() == TYPEID_PLAYER) && (CAST_PLR(Hitter)->IsActiveQuest(QUEST_REDEEMING_THE_DEAD)))
            {
                CAST_PLR(Hitter)->AreaExploredOrEventHappens(QUEST_REDEEMING_THE_DEAD);
                DoCast(me, SPELL_REVIVE_SELF);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->SetUInt32Value(UNIT_DYNAMIC_FLAGS, 0);
                //me->RemoveAllAuras();
                DoScriptText(SAY_HEAL, me);
                spellHit = true;
            }
        }
    };
};

/*#####
# npc_lorthemar_theron
######*/

enum LorthemarTheron
{
    SPELL_ARCANE_SHOCK      = 59715,
    SPELL_CLEAVE_LORTHEMAR  = 15284,
    SPELL_MANA_BURN         = 33385,
    SPELL_MASS_CHARM        = 33384,

    QUEST_DEFENDING_HORDE       = 60001,

    NOTIFY_COOLDOWN             = 600000,

    SCALING_5                   = 73816,
    SCALING_10                  = 73818,
    SCALING_15                  = 73819,
    SCALING_20                  = 73820,
    SCALING_25                  = 73821,
    SCALING_30                  = 73822,
};

// predicate function to select valid targets for mana burn
struct ManaBurnTargetSelector : public std::unary_function<Unit*, bool>
{
    ManaBurnTargetSelector() {}

    bool operator()(Unit const* target) const
    {
        return target->getPowerType() == POWER_MANA;
    }
};

class npc_lorthemar_theron : public CreatureScript
{
public:
    npc_lorthemar_theron() : CreatureScript("npc_lorthemar_theron") { }

    struct npc_lorthemar_theronAI : public ScriptedAI
    {
        npc_lorthemar_theronAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

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

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true);

            events.Reset();
            events.ScheduleEvent(SPELL_ARCANE_SHOCK, 9000);
            events.ScheduleEvent(SPELL_CLEAVE_LORTHEMAR, 5000);
            events.ScheduleEvent(SPELL_MANA_BURN, 12000);
            // events.ScheduleEvent(SPELL_MASS_CHARM, 16000);
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

        void EnterCombat(Unit* /*who*/) {
            if (notifyCooldown == 0)
            {
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\achievement_leader_lorthemar_theron.blp:24|t Lor'themar Theron: Sie fallen in Quel'Thalas ein!", 0, 0);
                notifyCooldown = NOTIFY_COOLDOWN;
            }
            me->CallForHelp(100.0f);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            Talk(0);
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
                    case SPELL_ARCANE_SHOCK:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                            DoCast(target, SPELL_ARCANE_SHOCK);
                        events.ScheduleEvent(SPELL_ARCANE_SHOCK, urand(9000, 11000));
                        break;
                    case SPELL_CLEAVE_LORTHEMAR:
                        DoCastVictim(SPELL_CLEAVE_LORTHEMAR, true);
                        events.ScheduleEvent(SPELL_CLEAVE_LORTHEMAR, urand(5000, 7000));
                        break;
                    case SPELL_MANA_BURN:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, ManaBurnTargetSelector()))
                            DoCast(target, SPELL_MANA_BURN);
                        events.ScheduleEvent(SPELL_MANA_BURN, urand(12000, 15000));
                        break;
                    case SPELL_MASS_CHARM: // currently increases worldserver load by a massive amount until kernel kills it through out of memory
                        // DoCast(me, SPELL_MASS_CHARM);
                        // Results in: WorldSocket::SendPacket enqueue_tail failed
                        events.ScheduleEvent(SPELL_MASS_CHARM, urand(16000, 20000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lorthemar_theronAI(creature);
    }

};

void AddSC_silvermoon_city()
{
    new npc_blood_knight_stillblade();
    new npc_lorthemar_theron();
}
