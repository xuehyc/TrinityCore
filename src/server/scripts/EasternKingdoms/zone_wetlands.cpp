﻿/*
 * Copyright (C) 2022 BfaCore Reforged
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
SDName: Wetlands
SD%Complete: 80
SDComment: Quest support: 1249
SDCategory: Wetlands
EndScriptData */

/* ContentData
npc_mikhail
npc_tapoke_slim_jahn
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include <SmartScript.h>
#include "UnitAI.h"
#include <PlayerAI.h>

/*######
## npc_tapoke_slim_jahn
######*/

enum TapokeSlim
{
    QUEST_MISSING_DIPLO_PT11    = 1249,
    SPELL_STEALTH               = 1785,
    SPELL_CALL_FRIENDS          = 16457,                    //summons 1x friend
    NPC_SLIMS_FRIEND            = 4971,
    NPC_TAPOKE_SLIM_JAHN        = 4962
};

class npc_tapoke_slim_jahn : public CreatureScript
{
public:
    npc_tapoke_slim_jahn() : CreatureScript("npc_tapoke_slim_jahn") { }

    //CreatureAI* GetAI(Creature* creature) const override
    //{
    //    return new npc_tapoke_slim_jahnAI(creature);
    //}

    //struct npc_tapoke_slim_jahnAI : public npc_escortAI
    //{
    //    npc_tapoke_slim_jahnAI(Creature* creature) : npc_escortAI(creature)
    //    {
    //        Initialize();
    //    }

    //    void Initialize()
    //    {
    //        IsFriendSummoned = false;
    //    }

    //    bool IsFriendSummoned;

    //    void Reset() 
    //    {
    //        if (!HasEscortState(STATE_ESCORT_ESCORTING))
    //            Initialize();
    //    }

    //    void WaypointReached(uint32 waypointId) 
    //    {
    //        switch (waypointId)
    //        {
    //            case 2:
    //                if (me->HasStealthAura())
    //                    me->RemoveAurasByType(SPELL_AURA_MOD_STEALTH);
    //                SetRun();
    //                me->SetFaction(FACTION_ENEMY);
    //                break;
    //        }
    //    }

    //    void EnterCombat(Unit* /*who*/) 
    //    {
    //        if (HasEscortState(STATE_ESCORT_ESCORTING) && !IsFriendSummoned && GetPlayerForEscort())
    //        {
    //            for (uint8 i = 0; i < 3; ++i)
    //                DoCast(me, SPELL_CALL_FRIENDS, true);

    //            IsFriendSummoned = true;
    //        }
    //    }

    //    void JustSummoned(Creature* summoned) 
    //    {
    //        if (Player* player = GetPlayerForEscort())
    //            summoned->AI()->AttackStart(player);
    //    }

    //    void AttackedBy(Unit* pAttacker) 
    //    {
    //        if (me->GetVictim())
    //            return;

    //        if (me->IsFriendlyTo(pAttacker))
    //            return;

    //        AttackStart(pAttacker);
    //    }

    //    void DamageTaken(Unit* /*pDoneBy*/, uint32& uiDamage) 
    //    {
    //        if (HealthBelowPct(20))
    //        {
    //            if (Player* player = GetPlayerForEscort())
    //            {
    //                player->GroupEventHappens(QUEST_MISSING_DIPLO_PT11, me);

    //                uiDamage = 0;

    //                me->RestoreFaction();
    //                me->RemoveAllAuras();
    //                me->DeleteThreatList();
    //                me->CombatStop(true);

    //                SetRun(false);
    //            }
    //        }
    //    }
    //};
};

/*######
## npc_mikhail
######*/

class npc_mikhail : public CreatureScript
{
public:
    npc_mikhail() : CreatureScript("npc_mikhail") { }

    bool OnQuestAccept(Player* /*player*/, Creature* creature, const Quest* quest) 
    {
        if (quest->GetQuestId() == QUEST_MISSING_DIPLO_PT11)
        {
            Creature* pSlim = creature->FindNearestCreature(NPC_TAPOKE_SLIM_JAHN, 25.0f);

            if (!pSlim)
                return false;

            if (!pSlim->HasStealthAura())
                pSlim->CastSpell(pSlim, SPELL_STEALTH, true);

            /*if (npc_tapoke_slim_jahn::npc_tapoke_slim_jahnAI* pEscortAI = CAST_AI(npc_tapoke_slim_jahn::npc_tapoke_slim_jahnAI, pSlim->AI()))
                pEscortAI->Start(false, false, player->GetGUID(), quest);*/
        }
        return false;
    }
};

enum MarshFire
{
    NPC_MARSH_FIRE       = 41628,
    QUEST_FOR_PEATS_SAKE = 25939
};

class spell_water_blast : public SpellScript
{
    PrepareSpellScript(spell_water_blast);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (!GetHitUnit() || !GetCaster()->IsPlayer() || !GetHitUnit()->ToCreature())
            return;

        GetCaster()->ToPlayer()->RewardPlayerAndGroupAtEvent(NPC_MARSH_FIRE, GetCaster());
        //GetHitUnit()->ToCreature()->DisappearAndDie();
    }

    void SelectTarget(WorldObject*& target)
    {
        target = GetCaster()->FindNearestCreature(NPC_MARSH_FIRE, 10.0f, true);
    }

    void Register() override
    {
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_water_blast::SelectTarget, EFFECT_0, TARGET_UNIT_NEARBY_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_water_blast::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};





/*######
## AddSC
######*/

void AddSC_wetlands()
{
    new npc_tapoke_slim_jahn();
    new npc_mikhail();
    RegisterSpellScript(spell_water_blast);
}
