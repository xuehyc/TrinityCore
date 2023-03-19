/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
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

/*
 * Scripts for spells with SPELLFAMILY_WARRIOR and SPELLFAMILY_GENERIC spells used by warrior players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_warr_".
 */

#include "ScriptMgr.h"
#include "Map.h"
#include "MoveSpline.h"
#include "PathGenerator.h"
#include "Player.h"
#include "SpellMgr.h"
#include "SpellAuraEffects.h"
#include "SpellHistory.h"
#include "SpellScript.h"

#include "AreaTrigger.h"
#include "AreaTriggerAI.h"
#include "AreaTriggerTemplate.h"
#include "Creature.h"
#include "Item.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Spell.h"
#include "SpellPackets.h"
#include "Unit.h"



enum WarriorSpells
{
    SPELL_WARRIOR_BLADESTORM_PERIODIC_WHIRLWIND     = 50622,
    SPELL_WARRIOR_BLOODTHIRST_HEAL                  = 117313,
    SPELL_WARRIOR_CHARGE                            = 34846,
    SPELL_WARRIOR_CHARGE_EFFECT                     = 218104,
    SPELL_WARRIOR_CHARGE_EFFECT_BLAZING_TRAIL       = 198337,
    SPELL_WARRIOR_CHARGE_PAUSE_RAGE_DECAY           = 109128,
    SPELL_WARRIOR_CHARGE_ROOT_EFFECT                = 105771,
    SPELL_WARRIOR_CHARGE_SLOW_EFFECT                = 236027,
    SPELL_WARRIOR_COLOSSUS_SMASH                    = 167105,
    SPELL_WARRIOR_COLOSSUS_SMASH_EFFECT             = 208086,
    SPELL_WARRIOR_EXECUTE                           = 20647,
    SPELL_WARRIOR_GLYPH_OF_THE_BLAZING_TRAIL        = 123779,
    SPELL_WARRIOR_GLYPH_OF_HEROIC_LEAP              = 159708,
    SPELL_WARRIOR_GLYPH_OF_HEROIC_LEAP_BUFF         = 133278,
    SPELL_WARRIOR_HEROIC_LEAP_JUMP                  = 94954,
    SPELL_WARRIOR_IMPENDING_VICTORY                 = 202168,
    SPELL_WARRIOR_IMPENDING_VICTORY_HEAL            = 202166,
    SPELL_WARRIOR_IMPROVED_HEROIC_LEAP              = 157449,
    SPELL_WARRIOR_MORTAL_STRIKE                     = 12294,
    SPELL_WARRIOR_MORTAL_WOUNDS                     = 213667,
    SPELL_WARRIOR_RALLYING_CRY                      = 97463,
    SPELL_WARRIOR_SHOCKWAVE                         = 46968,
    SPELL_WARRIOR_SHOCKWAVE_STUN                    = 132168,
    SPELL_WARRIOR_STOICISM                          = 70845,
    SPELL_WARRIOR_STORM_BOLT_STUN                   = 132169,
    SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_1   = 12723,
    SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_2   = 26654,
    SPELL_WARRIOR_TAUNT                             = 355,
    SPELL_WARRIOR_TRAUMA_EFFECT                     = 215537,
    SPELL_WARRIOR_VICTORIOUS                        = 32216,
    SPELL_WARRIOR_VICTORY_RUSH_HEAL                 = 118779,
    SPELL_WARRIOR_RAVAGER_SUMMON                    = 227876,
    SPELL_WARRIOR_RAVAGER_DAMAGE                    = 156287,
    SPELL_WARRIOR_RAVAGER_ENERGIZE                  = 248439,
    SPELL_WARRIOR_RAVAGER_PARRY                     = 227744,
    NPC_WARRIOR_RAVAGER                             = 76168,
    SPELL_WARRIOR_SHIELD_BLOCKC_TRIGGERED           = 132404,
    SPELL_WARRIOR_HEAVY_REPERCUSSIONS               = 203177,
    SPELL_WARRIOR_RENEWED_FURY                      = 202288,
    SPELL_WARRIOR_RENEWED_FURY_EFFECT               = 202289,
    SPELL_WARRIOR_VENGEANCE_FOCUSED_RAGE            = 202573,
    SPELL_WARRIOR_VENGEANCE_AURA                    = 202572,
    SPELL_WARRIOR_IGNORE_PAIN                       = 190456,
    SPELL_WARRIOR_LAST_STAND                        = 12975,
    SPELL_WARRIOR_SLAM_ARMS                         = 1464,
    SPELL_WARRIOR_SUDDEN_DEATH                      = 280721,
    SPELL_WARRIOR_SUDDEN_DEATH_PROC                 = 280776,
    SPELL_WARRIOR_BOUNDING_STRIDE                   = 202163,
    SPELL_WARRIOR_BOUNDING_STRIDE_SPEED             = 202164,
};

enum WarriorMisc
{
    SPELL_VISUAL_BLAZING_CHARGE = 26423
};

// 23881 - Bloodthirst
class spell_warr_bloodthirst : public SpellScript
{
    PrepareSpellScript(spell_warr_bloodthirst);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_BLOODTHIRST_HEAL });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), SPELL_WARRIOR_BLOODTHIRST_HEAL, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_warr_bloodthirst::HandleDummy, EFFECT_3, SPELL_EFFECT_DUMMY);
    }
};

// 100 - Charge
class spell_warr_charge : public SpellScript
{
    PrepareSpellScript(spell_warr_charge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo
        ({
            SPELL_WARRIOR_CHARGE_EFFECT,
            SPELL_WARRIOR_CHARGE_EFFECT_BLAZING_TRAIL
        });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        uint32 spellId = SPELL_WARRIOR_CHARGE_EFFECT;
        if (GetCaster()->HasAura(SPELL_WARRIOR_GLYPH_OF_THE_BLAZING_TRAIL))
            spellId = SPELL_WARRIOR_CHARGE_EFFECT_BLAZING_TRAIL;

        GetCaster()->CastSpell(GetHitUnit(), spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_charge::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 126661 - Warrior Charge Drop Fire Periodic
class spell_warr_charge_drop_fire_periodic : public AuraScript
{
    PrepareAuraScript(spell_warr_charge_drop_fire_periodic);

    void DropFireVisual(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (GetTarget()->IsSplineEnabled())
        {
            for (uint32 i = 0; i < 5; ++i)
            {
                int32 timeOffset = 6 * i * aurEff->GetPeriod() / 25;
                Movement::Location loc = GetTarget()->movespline->ComputePosition(timeOffset);
                GetTarget()->SendPlaySpellVisual(Position(loc.x, loc.y, loc.z), SPELL_VISUAL_BLAZING_CHARGE, 0, 0, 1.f, true);
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_warr_charge_drop_fire_periodic::DropFireVisual, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 198337 - Charge Effect (dropping Blazing Trail)
// 218104 - Charge Effect
class spell_warr_charge_effect : public SpellScript
{
    PrepareSpellScript(spell_warr_charge_effect);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo
        ({
            SPELL_WARRIOR_CHARGE_PAUSE_RAGE_DECAY,
            SPELL_WARRIOR_CHARGE_ROOT_EFFECT,
            SPELL_WARRIOR_CHARGE_SLOW_EFFECT
        });
    }

    void HandleCharge(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        caster->CastSpell(caster, SPELL_WARRIOR_CHARGE_PAUSE_RAGE_DECAY, CastSpellExtraArgs(TRIGGERED_FULL_MASK).AddSpellMod(SPELLVALUE_BASE_POINT0, 0));
        caster->CastSpell(target, SPELL_WARRIOR_CHARGE_ROOT_EFFECT, true);
        caster->CastSpell(target, SPELL_WARRIOR_CHARGE_SLOW_EFFECT, true);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_warr_charge_effect::HandleCharge, EFFECT_0, SPELL_EFFECT_CHARGE);
    }
};

// 167105 - Colossus Smash 7.1.5
class spell_warr_colossus_smash : public SpellScript
{
    PrepareSpellScript(spell_warr_colossus_smash);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_COLOSSUS_SMASH_EFFECT });
    }

    void HandleOnHit()
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_WARRIOR_COLOSSUS_SMASH_EFFECT, true);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_warr_colossus_smash::HandleOnHit);
    }
};

// 6544 - Heroic leap
class spell_warr_heroic_leap : public SpellScript
{
    PrepareSpellScript(spell_warr_heroic_leap);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_HEROIC_LEAP_JUMP });
    }

    SpellCastResult CheckElevation()
    {
        if (WorldLocation const* dest = GetExplTargetDest())
        {
            if (GetCaster()->HasUnitMovementFlag(MOVEMENTFLAG_ROOT))
                return SPELL_FAILED_ROOTED;

            if (GetCaster()->GetMap()->Instanceable())
            {
                float range = GetSpellInfo()->GetMaxRange(true, GetCaster()) * 1.5f;

                PathGenerator generatedPath(GetCaster());
                generatedPath.SetPathLengthLimit(range);

                bool result = generatedPath.CalculatePath(dest->GetPositionX(), dest->GetPositionY(), dest->GetPositionZ(), false);
                if (generatedPath.GetPathType() & PATHFIND_SHORT)
                    return SPELL_FAILED_OUT_OF_RANGE;
                else if (!result || generatedPath.GetPathType() & PATHFIND_NOPATH)
                    return SPELL_FAILED_NOPATH;
            }
            else if (dest->GetPositionZ() > GetCaster()->GetPositionZ() + 4.0f)
                return SPELL_FAILED_NOPATH;

            return SPELL_CAST_OK;
        }

        return SPELL_FAILED_NO_VALID_TARGETS;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (WorldLocation* dest = GetHitDest())
            GetCaster()->CastSpell(*dest, SPELL_WARRIOR_HEROIC_LEAP_JUMP, true);

        if (Unit* caster = GetCaster())
            if (caster->HasAura(SPELL_WARRIOR_BOUNDING_STRIDE))
                caster->CastSpell(caster, SPELL_WARRIOR_BOUNDING_STRIDE_SPEED, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_warr_heroic_leap::CheckElevation);
        OnEffectHit += SpellEffectFn(spell_warr_heroic_leap::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// Heroic Leap (triggered by Heroic Leap (6544)) - 178368
class spell_warr_heroic_leap_jump : public SpellScript
{
    PrepareSpellScript(spell_warr_heroic_leap_jump);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_WARRIOR_GLYPH_OF_HEROIC_LEAP,
            SPELL_WARRIOR_GLYPH_OF_HEROIC_LEAP_BUFF,
            SPELL_WARRIOR_IMPROVED_HEROIC_LEAP,
            SPELL_WARRIOR_TAUNT
        });
    }

    void AfterJump(SpellEffIndex /*effIndex*/)
    {
        if (GetCaster()->HasAura(SPELL_WARRIOR_GLYPH_OF_HEROIC_LEAP))
            GetCaster()->CastSpell(GetCaster(), SPELL_WARRIOR_GLYPH_OF_HEROIC_LEAP_BUFF, true);
        if (GetCaster()->HasAura(SPELL_WARRIOR_IMPROVED_HEROIC_LEAP))
            GetCaster()->GetSpellHistory()->ResetCooldown(SPELL_WARRIOR_TAUNT, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_warr_heroic_leap_jump::AfterJump, EFFECT_1, SPELL_EFFECT_JUMP_DEST);
    }
};

// 202168 - Impending Victory
class spell_warr_impending_victory : public SpellScript
{
    PrepareSpellScript(spell_warr_impending_victory);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_IMPENDING_VICTORY_HEAL });
    }

    void HandleAfterCast()
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, SPELL_WARRIOR_IMPENDING_VICTORY_HEAL, true);
        caster->RemoveAurasDueToSpell(SPELL_WARRIOR_VICTORIOUS);
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_warr_impending_victory::HandleAfterCast);
    }
};

// 5246 - Intimidating Shout
class spell_warr_intimidating_shout : public SpellScript
{
    PrepareSpellScript(spell_warr_intimidating_shout);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        unitList.remove(GetExplTargetWorldObject());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_warr_intimidating_shout::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_warr_intimidating_shout::FilterTargets, EFFECT_2, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// 70844 - Item - Warrior T10 Protection 4P Bonus
class spell_warr_item_t10_prot_4p_bonus : public AuraScript
{
    PrepareAuraScript(spell_warr_item_t10_prot_4p_bonus);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_STOICISM })
            && spellInfo->GetEffects().size() > EFFECT_1;
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* target = eventInfo.GetActionTarget();
        int32 bp0 = CalculatePct(target->GetMaxHealth(), GetEffectInfo(EFFECT_1).CalcValue());
        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
        args.AddSpellBP0(bp0);
        target->CastSpell(nullptr, SPELL_WARRIOR_STOICISM, args);
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_warr_item_t10_prot_4p_bonus::HandleProc);
    }
};

// 12294 - Mortal Strike 7.1.5
class spell_warr_mortal_strike : public SpellScript
{
    PrepareSpellScript(spell_warr_mortal_strike);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_MORTAL_WOUNDS });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_WARRIOR_MORTAL_WOUNDS, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_mortal_strike::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 97462 - Rallying Cry
class spell_warr_rallying_cry : public SpellScript
{
    PrepareSpellScript(spell_warr_rallying_cry);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_RALLYING_CRY });
    }

    bool Load() override
    {
        return GetCaster()->GetTypeId() ==  TYPEID_PLAYER;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
        args.AddSpellMod(SPELLVALUE_BASE_POINT0, int32(GetHitUnit()->CountPctFromMaxHealth(GetEffectValue())));

        GetCaster()->CastSpell(GetHitUnit(), SPELL_WARRIOR_RALLYING_CRY, args);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_rallying_cry::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 46968 - Shockwave
class spell_warr_shockwave : public SpellScript
{
    PrepareSpellScript(spell_warr_shockwave);

    bool Validate(SpellInfo const* spellInfo) override
    {
        if (!ValidateSpellInfo({ SPELL_WARRIOR_SHOCKWAVE, SPELL_WARRIOR_SHOCKWAVE_STUN }))
            return false;

        return spellInfo->GetEffects().size() > EFFECT_3;
    }

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_PLAYER;
    }

    void HandleStun(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), SPELL_WARRIOR_SHOCKWAVE_STUN, true);
        ++_targetCount;
    }

    // Cooldown reduced by 20 sec if it strikes at least 3 targets.
    void HandleAfterCast()
    {
        if (_targetCount >= uint32(GetEffectInfo(EFFECT_0).CalcValue()))
            GetCaster()->ToPlayer()->GetSpellHistory()->ModifyCooldown(GetSpellInfo()->Id, Seconds(-GetEffectInfo(EFFECT_3).CalcValue()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_shockwave::HandleStun, EFFECT_0, SPELL_EFFECT_DUMMY);
        AfterCast += SpellCastFn(spell_warr_shockwave::HandleAfterCast);
    }

    uint32 _targetCount = 0;
};

// 107570 - Storm Bolt
    class spell_warr_storm_bolt : public SpellScript
    {
        PrepareSpellScript(spell_warr_storm_bolt);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo
            ({
                SPELL_WARRIOR_STORM_BOLT_STUN
            });
        }

        void HandleOnHit(SpellEffIndex /*effIndex*/)
        {
            GetCaster()->CastSpell(GetHitUnit(), SPELL_WARRIOR_STORM_BOLT_STUN, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_warr_storm_bolt::HandleOnHit, EFFECT_1, SPELL_EFFECT_DUMMY);
        }
    };

// 52437 - Sudden Death
class spell_warr_sudden_death : public AuraScript
{
    PrepareAuraScript(spell_warr_sudden_death);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_COLOSSUS_SMASH });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // Remove cooldown on Colossus Smash
        if (Player* player = GetTarget()->ToPlayer())
            player->GetSpellHistory()->ResetCooldown(SPELL_WARRIOR_COLOSSUS_SMASH, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectRemoveFn(spell_warr_sudden_death::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL); // correct?
    }
};

// 12328, 18765, 35429 - Sweeping Strikes
class spell_warr_sweeping_strikes : public AuraScript
{
    PrepareAuraScript(spell_warr_sweeping_strikes);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_1, SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_2 });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        _procTarget = eventInfo.GetActor()->SelectNearbyTarget(eventInfo.GetProcTarget());
        return _procTarget != nullptr;
    }

    void HandleProc(AuraEffect* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (DamageInfo* damageInfo = eventInfo.GetDamageInfo())
        {
            SpellInfo const* spellInfo = damageInfo->GetSpellInfo();
            if (spellInfo && (spellInfo->Id == SPELL_WARRIOR_BLADESTORM_PERIODIC_WHIRLWIND || (spellInfo->Id == SPELL_WARRIOR_EXECUTE && !_procTarget->HasAuraState(AURA_STATE_WOUNDED_20_PERCENT))))
            {
                // If triggered by Execute (while target is not under 20% hp) or Bladestorm deals normalized weapon damage
                GetTarget()->CastSpell(_procTarget, SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_2, aurEff);
            }
            else
            {
                CastSpellExtraArgs args(aurEff);
                args.AddSpellMod(SPELLVALUE_BASE_POINT0, damageInfo->GetDamage());
                GetTarget()->CastSpell(_procTarget, SPELL_WARRIOR_SWEEPING_STRIKES_EXTRA_ATTACK_1, args);
            }
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_sweeping_strikes::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_warr_sweeping_strikes::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }

    Unit* _procTarget = nullptr;
};

// 215538 - Trauma
class spell_warr_trauma : public AuraScript
{
    PrepareAuraScript(spell_warr_trauma);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_TRAUMA_EFFECT });
    }

    void HandleProc(AuraEffect* aurEff, ProcEventInfo& eventInfo)
    {
        Unit* target = eventInfo.GetActionTarget();
        //Get 25% of damage from the spell casted (Slam & Whirlwind) plus Remaining Damage from Aura
        int32 damage = int32(CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), aurEff->GetAmount()) / sSpellMgr->AssertSpellInfo(SPELL_WARRIOR_TRAUMA_EFFECT, GetCastDifficulty())->GetMaxTicks());
        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
        args.AddSpellMod(SPELLVALUE_BASE_POINT0, damage);
        GetCaster()->CastSpell(target, SPELL_WARRIOR_TRAUMA_EFFECT, args);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_warr_trauma::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 28845 - Cheat Death
class spell_warr_t3_prot_8p_bonus : public AuraScript
{
    PrepareAuraScript(spell_warr_t3_prot_8p_bonus);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (eventInfo.GetActionTarget()->HealthBelowPct(20))
            return true;

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (damageInfo && damageInfo->GetDamage())
            if (GetTarget()->HealthBelowPctDamaged(20, damageInfo->GetDamage()))
                return true;

        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_warr_t3_prot_8p_bonus::CheckProc);
    }
};

// 32215 - Victorious State
class spell_warr_victorious_state : public AuraScript
{
    PrepareAuraScript(spell_warr_victorious_state);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_IMPENDING_VICTORY });
    }

    void HandleOnProc(AuraEffect* /*aurEff*/, ProcEventInfo& procInfo)
    {
        if (procInfo.GetActor()->GetTypeId() == TYPEID_PLAYER && procInfo.GetActor()->ToPlayer()->GetPrimarySpecialization() == TALENT_SPEC_WARRIOR_FURY)
            PreventDefaultAction();

        procInfo.GetActor()->GetSpellHistory()->ResetCooldown(SPELL_WARRIOR_IMPENDING_VICTORY, true);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_warr_victorious_state::HandleOnProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 34428 - Victory Rush
class spell_warr_victory_rush : public SpellScript
{
    PrepareSpellScript(spell_warr_victory_rush);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo
        ({
            SPELL_WARRIOR_VICTORIOUS,
            SPELL_WARRIOR_VICTORY_RUSH_HEAL
        });
    }

    void HandleHeal()
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, SPELL_WARRIOR_VICTORY_RUSH_HEAL, true);
        caster->RemoveAurasDueToSpell(SPELL_WARRIOR_VICTORIOUS);
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_warr_victory_rush::HandleHeal);
    }
};

// 23920 Spell Reflect
class spell_warr_spell_reflect : public SpellScriptLoader
{
public:
    spell_warr_spell_reflect() : SpellScriptLoader("spell_warr_spell_reflect") { }

    class spell_warr_spell_reflect_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warr_spell_reflect_AuraScript);

        void OnApply(const AuraEffect* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* caster = GetCaster();
            if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
                return;

            Item* item = caster->ToPlayer()->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
            if (item && item->GetTemplate()->GetInventoryType() == INVTYPE_SHIELD)
                caster->CastSpell(caster, 146120, true);
            else if (caster->GetFaction() == 1732) // Alliance
                caster->CastSpell(caster, 147923, true);
            else // Horde
                caster->CastSpell(caster, 146122, true);
        }

        void OnRemove(const AuraEffect* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* caster = GetCaster();
            if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
                return;

            // Visuals
            caster->RemoveAura(146120);
            caster->RemoveAura(147923);
            caster->RemoveAura(146122);
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_warr_spell_reflect_AuraScript::OnApply, EFFECT_0, SPELL_AURA_REFLECT_SPELLS, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            OnEffectRemove += AuraEffectRemoveFn(spell_warr_spell_reflect_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_REFLECT_SPELLS, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_warr_spell_reflect_AuraScript();
    }
};

// Ravager - 152277
// Ravager - 228920
class spell_warr_ravager : public SpellScript
{
    PrepareSpellScript(spell_warr_ravager);

    void HandleOnHit(SpellEffIndex /* effIndex */)
    {
        if (WorldLocation const* dest = GetExplTargetDest())
            GetCaster()->CastSpell(dest->GetPosition(), SPELL_WARRIOR_RAVAGER_SUMMON, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_warr_ravager::HandleOnHit, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

// Ravager - 152277
// Ravager - 228920
class aura_warr_ravager : public AuraScript
{
    PrepareAuraScript(aura_warr_ravager);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* player = GetTarget()->ToPlayer())
            if (player->GetSpecializationId() == TALENT_SPEC_WARRIOR_PROTECTION)
                player->CastSpell(player, SPELL_WARRIOR_RAVAGER_PARRY, true);
    }

    void OnTick(AuraEffect const* /*aurEff*/)
    {
        if (Creature* creature = GetTarget()->GetSummonedCreatureByEntry(NPC_WARRIOR_RAVAGER))
            GetTarget()->CastSpell(creature->GetPosition(), SPELL_WARRIOR_RAVAGER_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(aura_warr_ravager::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_warr_ravager::OnTick, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// Ravager Damage - 156287
class spell_warr_ravager_damage : public SpellScript
{
    PrepareSpellScript(spell_warr_ravager_damage);

    void HandleOnHitTarget(SpellEffIndex /*effIndex*/)
    {
        if (!_alreadyProc)
        {
            GetCaster()->CastSpell(GetCaster(), SPELL_WARRIOR_RAVAGER_ENERGIZE, true);
            _alreadyProc = true;
        }
        if (GetCaster()->HasAura(262304)) // Deep Wounds
            GetCaster()->CastSpell(GetHitUnit(), 262115, true); // Deep Wounds
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_ravager_damage::HandleOnHitTarget, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }

private:
    bool _alreadyProc = false;
};

// Ravager - 76168
struct npc_warr_ravager : public ScriptedAI
{
    npc_warr_ravager(Creature* creature) : ScriptedAI(creature) { }

    enum eDatas
    {
        RAVAGER_DISPLAYID = 55644,
        SPELL_RAVAGER_VISUAL = 153709
    };

    void IsSummonedBy(WorldObject* summoner) override
    {
        me->SetDisplayId(RAVAGER_DISPLAYID);
        me->CastSpell(me, SPELL_RAVAGER_VISUAL, true);
        me->SetReactState(ReactStates::REACT_PASSIVE);
        me->AddUnitState(UnitState::UNIT_STATE_ROOT);
        me->SetUnitFlag(UnitFlags(UNIT_FLAG_UNINTERACTIBLE |
            UNIT_FLAG_NON_ATTACKABLE_2 |
            UNIT_FLAG_PLAYER_CONTROLLED));

        if (summoner == nullptr || !summoner->IsPlayer())
            return;

        if (Player* player = summoner->ToPlayer())
        {
            if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EquipmentSlots::EQUIPMENT_SLOT_MAINHAND))
            {
                if (ItemTemplate const* l_Proto = sObjectMgr->GetItemTemplate(item->GetModifier(ITEM_MODIFIER_TRANSMOG_APPEARANCE_ALL_SPECS)))
                    me->SetVirtualItem(0, l_Proto->GetId());
                else
                    me->SetVirtualItem(0, item->GetTemplate()->GetId());
            }

            if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EquipmentSlots::EQUIPMENT_SLOT_OFFHAND))
            {
                if (ItemTemplate const* l_Proto = sObjectMgr->GetItemTemplate(item->GetModifier(ITEM_MODIFIER_TRANSMOG_APPEARANCE_ALL_SPECS)))
                    me->SetVirtualItem(2, l_Proto->GetId());
                else
                    me->SetVirtualItem(2, item->GetTemplate()->GetId());
            }
        }
    }
};

// 2565
class spell_warr_shield_block : public SpellScriptLoader
{
public:
    spell_warr_shield_block() : SpellScriptLoader("spell_warr_shield_block") { }

    class spell_warr_shield_block_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_warr_shield_block_SpellScript);

        void HandleOnHit()
        {
            if (Player* _player = GetCaster()->ToPlayer())
                _player->CastSpell(_player, SPELL_WARRIOR_SHIELD_BLOCKC_TRIGGERED, true);
        }

        void Register() override
        {
            OnHit += SpellHitFn(spell_warr_shield_block_SpellScript::HandleOnHit);
        }
    };

    class spell_warr_shield_block_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warr_shield_block_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_WARRIOR_SHIELD_BLOCKC_TRIGGERED, DIFFICULTY_NONE))
                return false;
            return true;
        }

        void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* caster = GetCaster())
                if (caster->HasAura(SPELL_WARRIOR_HEAVY_REPERCUSSIONS))
                    amount += 30;
        }

        void Register() override
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_warr_shield_block_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_NONE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_warr_shield_block_SpellScript();
    }

    AuraScript* GetAuraScript() const override
    {
        return new spell_warr_shield_block_AuraScript();
    }
};

//190456 - Ignore Pain
class spell_warr_ignore_pain : public SpellScript
{
    PrepareSpellScript(spell_warr_ignore_pain);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARRIOR_RENEWED_FURY, SPELL_WARRIOR_VENGEANCE_FOCUSED_RAGE });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->HasAura(SPELL_WARRIOR_RENEWED_FURY))
                caster->CastSpell(caster, SPELL_WARRIOR_RENEWED_FURY_EFFECT, true);
            if (caster->HasAura(SPELL_WARRIOR_VENGEANCE_AURA))
                caster->CastSpell(caster, SPELL_WARRIOR_VENGEANCE_FOCUSED_RAGE, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_ignore_pain::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

//190456 - Ignore Pain
class aura_warr_ignore_pain : public AuraScript
{
    PrepareAuraScript(aura_warr_ignore_pain);

    int32 m_ExtraSpellCost;

    bool Load() override
    {
        Unit* caster = GetCaster();
        // In this phase the initial 20 Rage cost is removed already
        // We just check for bonus.
        m_ExtraSpellCost = std::min(caster->GetPower(POWER_RAGE), 400);
        return true;
    }

    void CalcAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* caster = GetCaster())
        {
            amount = (float)(22.3f * caster->GetTotalAttackPowerValue(BASE_ATTACK)) * (float(m_ExtraSpellCost + 200) / 600.0f);
            int32 m_newRage = caster->GetPower(POWER_RAGE) - m_ExtraSpellCost;
            if (m_newRage < 0)
                m_newRage = 0;
            caster->SetPower(POWER_RAGE, m_newRage);
            /*if (Player* player = caster->ToPlayer())
                player->SendPowerUpdate(POWER_RAGE, m_newRage);*/
        }
    }

    void OnAbsorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& /*absorbAmount*/)
    {
        if (Unit* caster = GetCaster())
        {
            SpellInfo const* spellInfo = GetSpellInfo();
            if (!spellInfo)
                return;

            SpellNonMeleeDamage spell(caster, caster->GetVictim(), spellInfo, { spellInfo->GetSpellXSpellVisualId(caster), 0 }, spellInfo->GetSchoolMask());
            spell.damage = dmgInfo.GetDamage() - dmgInfo.GetDamage() * 0.9f;
            spell.cleanDamage = spell.damage;
            caster->DealSpellDamage(&spell, false);
            caster->SendSpellNonMeleeDamageLog(&spell);
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(aura_warr_ignore_pain::CalcAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(aura_warr_ignore_pain::OnAbsorb, EFFECT_0);
    }
};

/// Updated 8.3.7
// 12975 - Last Stand
class spell_warr_last_stand : public SpellScriptLoader
{
public:
    spell_warr_last_stand() : SpellScriptLoader("spell_warr_last_stand") { }

    class spell_warr_last_stand_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_warr_last_stand_SpellScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_WARRIOR_LAST_STAND, DIFFICULTY_NONE))
                return false;
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            int32 healthModSpellBasePoints0 = int32(caster->CountPctFromMaxHealth(GetEffectValue()));

            caster->CastSpell(caster, SPELL_WARRIOR_LAST_STAND, &healthModSpellBasePoints0);
        }

        void Register() override
        {
            // add dummy effect spell handler to Last Stand
            OnEffectHit += SpellEffectFn(spell_warr_last_stand_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
            OnEffectHit += SpellEffectFn(spell_warr_last_stand_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_HEAL_PCT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_warr_last_stand_SpellScript();
    }
};

/// Shattering Throw - 64382
class spell_warr_shattering_throw : public SpellScriptLoader
{
public:
    spell_warr_shattering_throw() : SpellScriptLoader("spell_warr_shattering_throw") { }

    class spell_warr_shattering_throw_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_warr_shattering_throw_SpellScript);

        enum eSpells
        {
            ShatteringThrowDispel = 64380,
        };

        void HandleDamage(SpellEffIndex /*p_EffIndex*/)
        {
            Player* l_Player = GetCaster()->ToPlayer();
            Unit* l_Target = GetHitUnit();

            if (l_Player == nullptr || l_Target == nullptr)
                return;

            if (l_Target->IsImmunedToDamage(GetSpellInfo()))
            {
                l_Player->CastSpell(l_Target, eSpells::ShatteringThrowDispel, true);
                return;
            }

            if (l_Player->GetSpecializationId() == TALENT_SPEC_WARRIOR_FURY)
                SetHitDamage(GetHitDamage() * 1.2f);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_warr_shattering_throw_SpellScript::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_warr_shattering_throw_SpellScript();
    }
};

/// Commanding Shout - 469,  Battle Shout - 6673
class spell_warr_shout : public SpellScriptLoader
{
public:
    spell_warr_shout() : SpellScriptLoader("spell_warr_shout") { }

    class spell_warr_shout_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_warr_shout_AuraScript);

        enum eSpells
        {
            CommandingShout = 469,
            BattleShout = 6673
        };

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* l_Target = GetTarget();
            Unit* l_Caster = GetCaster();

            if (l_Caster == nullptr)
                return;

            if (GetSpellInfo()->Id == eSpells::BattleShout && l_Target->HasAura(eSpells::CommandingShout, l_Caster->GetGUID()))
                l_Target->RemoveAura(eSpells::CommandingShout, l_Caster->GetGUID());
            else if (GetSpellInfo()->Id == eSpells::CommandingShout && l_Target->HasAura(eSpells::BattleShout, l_Caster->GetGUID()))
                l_Target->RemoveAura(eSpells::BattleShout, l_Caster->GetGUID());
        }

        void Register() override
        {
            switch (m_scriptSpellId)
            {
            case eSpells::BattleShout:
                OnEffectApply += AuraEffectApplyFn(spell_warr_shout_AuraScript::OnApply, EFFECT_0, SPELL_AURA_MOD_ATTACK_POWER_PCT, AURA_EFFECT_HANDLE_REAL);
                break;
            case eSpells::CommandingShout:
                OnEffectApply += AuraEffectApplyFn(spell_warr_shout_AuraScript::OnApply, EFFECT_0, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, AURA_EFFECT_HANDLE_REAL);
                break;
            default:
                break;
            }
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_warr_shout_AuraScript();
    }
};

// 1680 Whirlwind
class spell_warr_wirlwind_dmg : public SpellScript
{
    PrepareSpellScript(spell_warr_wirlwind_dmg);

    void HandleOnHitTarget(SpellEffIndex /*effIndex*/)
    {
        if (Player* caster = GetCaster()->ToPlayer())
        {
            if (caster->HasAura(202316)) // Fervor of Battle
            {
                if (Unit* target = caster->GetSelectedUnit())
                {
                    if (caster->IsValidAttackTarget(target))
                    {
                        caster->CastSpell(target, SPELL_WARRIOR_SLAM_ARMS, true);
                    }
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_wirlwind_dmg::HandleOnHitTarget, EFFECT_0, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

// 163201  - Execute
// 217955  - Execute
// 281000  - Execute
class spell_warr_execute : public SpellScript
{
    PrepareSpellScript(spell_warr_execute);

    float m_powerTaken = 0.f;

    void HandleAfterHit()
    {
        if (Unit* target = GetHitUnit())
            if (target->IsAlive())
                GetCaster()->ModifyPower(POWER_RAGE, CalculatePct(m_powerTaken, GetEffectInfo(EFFECT_1).BasePoints));

        GetCaster()->Variables.Remove("spell_warr_execute_damages::multiplier");
        GetCaster()->RemoveAurasDueToSpell(SPELL_WARRIOR_SUDDEN_DEATH);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_warr_execute::HandleAfterHit);
    }
};

// 260798  - Executes damages
class spell_warr_execute_damages : public SpellScript
{
    PrepareSpellScript(spell_warr_execute_damages);

    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        float damageMultiplier = GetCaster()->Variables.GetValue<float>("spell_warr_execute_damages::multiplier", 1.f);
        SetHitDamage(GetHitDamage() * damageMultiplier);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_execute_damages::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

//385952 - Shield Charge
class spell_warr_shiel_charge : public SpellScript
{
    PrepareSpellScript(spell_warr_shiel_charge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo
        ({
            385953
        });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), 385953, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warr_shiel_charge::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};


void AddSC_warrior_spell_scripts()
{
    RegisterSpellScript(spell_warr_bloodthirst);
    RegisterSpellScript(spell_warr_charge);
    RegisterSpellScript(spell_warr_charge_drop_fire_periodic);
    RegisterSpellScript(spell_warr_charge_effect);
    RegisterSpellScript(spell_warr_colossus_smash);
    RegisterSpellScript(spell_warr_heroic_leap);
    RegisterSpellScript(spell_warr_heroic_leap_jump);
    RegisterSpellScript(spell_warr_impending_victory);
    RegisterSpellScript(spell_warr_intimidating_shout);
    RegisterSpellScript(spell_warr_item_t10_prot_4p_bonus);
    RegisterSpellScript(spell_warr_mortal_strike);
    RegisterSpellScript(spell_warr_rallying_cry);
    RegisterSpellScript(spell_warr_shockwave);
    RegisterSpellScript(spell_warr_storm_bolt);
    RegisterSpellScript(spell_warr_sudden_death);
    RegisterSpellScript(spell_warr_sweeping_strikes);
    RegisterSpellScript(spell_warr_trauma);
    RegisterSpellScript(spell_warr_t3_prot_8p_bonus);
    RegisterSpellScript(spell_warr_victorious_state);
    RegisterSpellScript(spell_warr_victory_rush);

    //new
    new spell_warr_spell_reflect();
    RegisterSpellAndAuraScriptPair(spell_warr_ravager, aura_warr_ravager);
    RegisterCreatureAI(npc_warr_ravager);
    RegisterSpellScript(spell_warr_ravager_damage);
    new spell_warr_shield_block();
    RegisterSpellAndAuraScriptPair(spell_warr_ignore_pain, aura_warr_ignore_pain);
    new spell_warr_last_stand();
    new spell_warr_shattering_throw();
    new spell_warr_shout();
    RegisterSpellScript(spell_warr_wirlwind_dmg);
    RegisterSpellScript(spell_warr_shiel_charge);
}
