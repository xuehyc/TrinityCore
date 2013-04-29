/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
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
 * Scripts for spells with SPELLFAMILY_SHAMAN and SPELLFAMILY_GENERIC spells used by shaman players.
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "spell_sha_".
 */

#include "Player.h"
#include "ScriptMgr.h"
#include "GridNotifiers.h"
#include "Unit.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"

enum ShamanSpells
{
    SPELL_HUNTER_INSANITY                       = 95809,
    SPELL_MAGE_TEMPORAL_DISPLACEMENT            = 80354,
    SPELL_SHAMAN_ANCESTRAL_AWAKENING_PROC       = 52752,
    SPELL_SHAMAN_BIND_SIGHT                     = 6277,
    SPELL_SHAMAN_EARTH_SHIELD_HEAL              = 379,
    SPELL_SHAMAN_EXHAUSTION                     = 57723,
	SPELL_SHAMAN_FIRE_NOVA_R1                   = 1535,
    SPELL_SHAMAN_FIRE_NOVA_TRIGGERED_R1         = 8349,
    SPELL_SHAMAN_FLAME_SHOCK                    = 8050,
    SPELL_SHAMAN_GLYPH_OF_EARTH_SHIELD          = 63279,
    SPELL_SHAMAN_GLYPH_OF_HEALING_STREAM_TOTEM  = 55456,
    SPELL_SHAMAN_GLYPH_OF_MANA_TIDE             = 55441,
    SPELL_SHAMAN_GLYPH_OF_THUNDERSTORM          = 62132,
    SPELL_SHAMAN_LAVA_FLOWS_R1                  = 51480,
    SPELL_SHAMAN_LAVA_FLOWS_TRIGGERED_R1        = 65264,
    SPELL_SHAMAN_SATED                          = 57724,
    SPELL_SHAMAN_STORM_EARTH_AND_FIRE           = 51483,
    SPELL_SHAMAN_TOTEM_EARTHBIND_EARTHGRAB      = 64695,
    SPELL_SHAMAN_TOTEM_EARTHBIND_TOTEM          = 6474,
    SPELL_SHAMAN_TOTEM_EARTHEN_POWER            = 59566,
    SPELL_SHAMAN_TOTEM_HEALING_STREAM_HEAL      = 52042,
	SPELL_SHAMAN_TOTEM_TOTEMIC_WRATH            = 77746,
    SPELL_SHAMAN_TOTEM_TOTEMIC_WRATH_AURA       = 77747,
	SPELL_SHAMAN_EARTHQUAKE_KNOCKDOWN           = 77505,
	SPELL_SHAMAN_FULMINATION                    = 88766,
    SPELL_SHAMAN_FULMINATION_TRIGGERED          = 88767,
    SPELL_SHAMAN_FULMINATION_INFO               = 95774,
	SPELL_SHAMAN_LIGHTNING_SHIELD_PROC          = 26364,
};

enum ShamanSpellIcons
{
    SHAMAN_ICON_ID_SOOTHING_RAIN                = 2011,
    SHAMAN_ICON_ID_SHAMAN_LAVA_FLOW             = 3087
};

// 52759 - Ancestral Awakening
/// Updated 4.3.4
class spell_sha_ancestral_awakening_proc : public SpellScriptLoader
{
    public:
        spell_sha_ancestral_awakening_proc() : SpellScriptLoader("spell_sha_ancestral_awakening_proc") { }

        class spell_sha_ancestral_awakening_proc_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_ancestral_awakening_proc_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_ANCESTRAL_AWAKENING_PROC))
                    return false;
                return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                int32 damage = GetEffectValue();
                if (GetCaster() && GetHitUnit())
                    GetCaster()->CastCustomSpell(GetHitUnit(), SPELL_SHAMAN_ANCESTRAL_AWAKENING_PROC, &damage, NULL, NULL, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_ancestral_awakening_proc_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_ancestral_awakening_proc_SpellScript();
        }
};

// 2825 - Bloodlust
/// Updated 4.3.4
class spell_sha_bloodlust : public SpellScriptLoader
{
    public:
        spell_sha_bloodlust() : SpellScriptLoader("spell_sha_bloodlust") { }

        class spell_sha_bloodlust_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_bloodlust_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_SATED))
                    return false;
                return true;
            }

            void RemoveInvalidTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(Trinity::UnitAuraCheck(true, SPELL_SHAMAN_SATED));
                targets.remove_if(Trinity::UnitAuraCheck(true, SPELL_HUNTER_INSANITY));
                targets.remove_if(Trinity::UnitAuraCheck(true, SPELL_MAGE_TEMPORAL_DISPLACEMENT));
            }

            void ApplyDebuff()
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_SHAMAN_SATED, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_bloodlust_SpellScript::RemoveInvalidTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_RAID);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_bloodlust_SpellScript::RemoveInvalidTargets, EFFECT_1, TARGET_UNIT_CASTER_AREA_RAID);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_bloodlust_SpellScript::RemoveInvalidTargets, EFFECT_2, TARGET_UNIT_CASTER_AREA_RAID);
                AfterHit += SpellHitFn(spell_sha_bloodlust_SpellScript::ApplyDebuff);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_bloodlust_SpellScript();
        }
};

// 1064 - Chain Heal
/// Updated 4.3.4
class spell_sha_chain_heal : public SpellScriptLoader
{
    public:
        spell_sha_chain_heal() : SpellScriptLoader("spell_sha_chain_heal") { }

        class spell_sha_chain_heal_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_chain_heal_SpellScript);

            bool Load()
            {
                firstHeal = true;
                riptide = false;
                amount = 0;
                return true;
            }

            void HandleHeal(SpellEffIndex /*effIndex*/)
            {
                if (firstHeal)
                {
                    // Check if the target has Riptide
                    if (AuraEffect* aurEff = GetHitUnit()->GetAuraEffect(SPELL_AURA_PERIODIC_HEAL, SPELLFAMILY_SHAMAN, 0, 0, 0x10, GetCaster()->GetGUID()))
                    {
                        riptide = true;
                        amount = aurEff->GetSpellInfo()->Effects[EFFECT_2].CalcValue();
                        // Consume it
                        GetHitUnit()->RemoveAura(aurEff->GetBase());
                    }
                    firstHeal = false;
                }
                // Riptide increases the Chain Heal effect by 25%
                if (riptide)
                {
                    uint32 bonus = CalculatePct(GetHitHeal(), amount);
                    SetHitHeal(GetHitHeal() + bonus);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_chain_heal_SpellScript::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
            }

            bool firstHeal;
            bool riptide;
            uint32 amount;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_chain_heal_SpellScript();
        }
};

// -974 - Earth Shield
class spell_sha_earth_shield : public SpellScriptLoader
{
    public:
        spell_sha_earth_shield() : SpellScriptLoader("spell_sha_earth_shield") { }

        class spell_sha_earth_shield_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_earth_shield_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_EARTH_SHIELD_HEAL))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_GLYPH_OF_EARTH_SHIELD))
                    return false;
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool & /*canBeRecalculated*/)
            {
                if (Unit* caster = GetCaster())
                {
                    amount = caster->SpellHealingBonusDone(GetUnitOwner(), GetSpellInfo(), amount, HEAL);
                    amount = GetUnitOwner()->SpellHealingBonusTaken(caster, GetSpellInfo(), amount, HEAL);

                    // Glyph of Earth Shield
                    //! WORKAROUND
                    //! this glyph is a proc
                    if (AuraEffect* glyph = caster->GetAuraEffect(SPELL_SHAMAN_GLYPH_OF_EARTH_SHIELD, EFFECT_0))
                        AddPct(amount, glyph->GetAmount());
                }
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();

                //! HACK due to currenct proc system implementation
                if (Player* player = GetTarget()->ToPlayer())
                    if (player->HasSpellCooldown(SPELL_SHAMAN_EARTH_SHIELD_HEAL))
                        return;

                GetTarget()->CastCustomSpell(SPELL_SHAMAN_EARTH_SHIELD_HEAL, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), GetTarget(), true, NULL, aurEff, GetCasterGUID());

                if (Player* player = GetTarget()->ToPlayer())
                    player->AddSpellCooldown(SPELL_SHAMAN_EARTH_SHIELD_HEAL, 0, time(NULL) + 3);
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_earth_shield_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_DUMMY);
                OnEffectProc += AuraEffectProcFn(spell_sha_earth_shield_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_earth_shield_AuraScript();
        }
};

// 6474 - Earthbind Totem - Fix Talent:Earthen Power, Earth's Grasp
/// Updated 4.3.4
class spell_sha_earthbind_totem : public SpellScriptLoader
{
    public:
        spell_sha_earthbind_totem() : SpellScriptLoader("spell_sha_earthbind_totem") { }

        class spell_sha_earthbind_totem_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_earthbind_totem_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_EARTHBIND_TOTEM) || !sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_EARTHEN_POWER))
                    return false;
                return true;
            }

            void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
            {
                if (!GetCaster())
                    return;
                if (Player* owner = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself())
                    if (AuraEffect* aur = owner->GetDummyAuraEffect(SPELLFAMILY_SHAMAN, 2289, 0))
                        if (roll_chance_i(aur->GetBaseAmount()))
                            GetTarget()->CastSpell((Unit*)NULL, SPELL_SHAMAN_TOTEM_EARTHEN_POWER, true);
            }

            void Apply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster())
                    return;
                Player* owner = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself();
                if (!owner)
                    return;
                // Earth's Grasp
                if (AuraEffect* aurEff = owner->GetAuraEffectOfRankedSpell(SPELL_SHAMAN_STORM_EARTH_AND_FIRE, EFFECT_1))
                {
                    if (roll_chance_i(aurEff->GetAmount()))
                        GetCaster()->CastSpell(GetCaster(), SPELL_SHAMAN_TOTEM_EARTHBIND_EARTHGRAB, false);
                }
            }

            void Register()
            {
                 OnEffectPeriodic += AuraEffectPeriodicFn(spell_sha_earthbind_totem_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
                 OnEffectApply += AuraEffectApplyFn(spell_sha_earthbind_totem_AuraScript::Apply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_earthbind_totem_AuraScript();
        }
};

class EarthenPowerTargetSelector
{
    public:
        EarthenPowerTargetSelector() { }

        bool operator() (WorldObject* target)
        {
            if (!target->ToUnit())
                return true;

            if (!target->ToUnit()->HasAuraWithMechanic(1 << MECHANIC_SNARE))
                return true;

            return false;
        }
};

// 59566 - Earthen Power
class spell_sha_earthen_power : public SpellScriptLoader
{
    public:
        spell_sha_earthen_power() : SpellScriptLoader("spell_sha_earthen_power") { }

        class spell_sha_earthen_power_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_earthen_power_SpellScript);

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                unitList.remove_if(EarthenPowerTargetSelector());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_earthen_power_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_earthen_power_SpellScript();
        }
};

// 1535 Fire Nova
class spell_sha_fire_nova : public SpellScriptLoader
{
public:
    spell_sha_fire_nova() : SpellScriptLoader("spell_sha_fire_nova") { }

    class spell_sha_fire_nova_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_sha_fire_nova_SpellScript);

        bool Validate(SpellInfo const* spellInfo)
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_FIRE_NOVA_R1))
                return false;
            if (sSpellMgr->GetFirstSpellInChain(SPELL_SHAMAN_FIRE_NOVA_R1) != sSpellMgr->GetFirstSpellInChain(spellInfo->Id))
                return false;

            uint8 rank = sSpellMgr->GetSpellRank(spellInfo->Id);
            if (!sSpellMgr->GetSpellWithRank(SPELL_SHAMAN_FIRE_NOVA_TRIGGERED_R1, rank, true))
                return false;
            return true;
        }

        SpellCastResult CheckFireTotem()
        {
            // fire totem
            if (!GetCaster()->m_SummonSlot[1])
            {
                SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_HAVE_FIRE_TOTEM);
                return SPELL_FAILED_CUSTOM_ERROR;
            }

            return SPELL_CAST_OK;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            uint8 rank = sSpellMgr->GetSpellRank(GetSpellInfo()->Id);
            if (uint32 spellId = sSpellMgr->GetSpellWithRank(SPELL_SHAMAN_FIRE_NOVA_TRIGGERED_R1, rank))
            {
                Creature* totem = caster->GetMap()->GetCreature(caster->m_SummonSlot[1]);
                if (totem && totem->isTotem())
                    totem->CastSpell(totem, spellId, true);
            }
        }

        void Register()
        {
            OnCheckCast += SpellCheckCastFn(spell_sha_fire_nova_SpellScript::CheckFireTotem);
            OnEffectHitTarget += SpellEffectFn(spell_sha_fire_nova_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_sha_fire_nova_SpellScript();
    }
};

// 8050 -Flame Shock
/// Updated 4.3.4
class spell_sha_flame_shock : public SpellScriptLoader
{
    public:
        spell_sha_flame_shock() : SpellScriptLoader("spell_sha_flame_shock") { }

        class spell_sha_flame_shock_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_flame_shock_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_LAVA_FLOWS_R1))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_LAVA_FLOWS_TRIGGERED_R1))
                    return false;
                return true;
            }

            void HandleDispel(DispelInfo* /*dispelInfo*/)
            {
                if (Unit* caster = GetCaster())
                {
                    // Lava Flows
                    if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_SHAMAN, SHAMAN_ICON_ID_SHAMAN_LAVA_FLOW, EFFECT_0))
                    {
                        if (sSpellMgr->GetFirstSpellInChain(SPELL_SHAMAN_LAVA_FLOWS_R1) != sSpellMgr->GetFirstSpellInChain(aurEff->GetId()))
                            return;

                        int32 basepoints = aurEff->GetAmount();
                        caster->CastCustomSpell(caster, SPELL_SHAMAN_LAVA_FLOWS_TRIGGERED_R1, &basepoints, NULL, NULL, true);
                    }
                }
            }

            void Register()
            {
                AfterDispel += AuraDispelFn(spell_sha_flame_shock_AuraScript::HandleDispel);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_flame_shock_AuraScript();
        }
};

// 52041 - Healing Stream Totem
/// Updated 4.3.4
class spell_sha_healing_stream_totem : public SpellScriptLoader
{
    public:
        spell_sha_healing_stream_totem() : SpellScriptLoader("spell_sha_healing_stream_totem") { }

        class spell_sha_healing_stream_totem_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_healing_stream_totem_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                return sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_HEALING_STREAM_HEAL);
            }

            void HandleDummy(SpellEffIndex /* effIndex */)
            {
                int32 damage = GetEffectValue();
                SpellInfo const* triggeringSpell = GetTriggeringSpell();
                if (Unit* target = GetHitUnit())
                    if (Unit* caster = GetCaster())
                    {
                        if (Unit* owner = caster->GetOwner())
                        {
                            if (triggeringSpell)
                                damage = int32(owner->SpellHealingBonusDone(target, triggeringSpell, damage, HEAL));

                            // Soothing Rains
                            if (AuraEffect* dummy = owner->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_SHAMAN, SHAMAN_ICON_ID_SOOTHING_RAIN, EFFECT_0))
                                AddPct(damage, dummy->GetAmount());

                            damage = int32(target->SpellHealingBonusTaken(owner, triggeringSpell, damage, HEAL));
                        }
                        caster->CastCustomSpell(target, SPELL_SHAMAN_TOTEM_HEALING_STREAM_HEAL, &damage, 0, 0, true, 0, 0, GetOriginalCaster()->GetGUID());
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_healing_stream_totem_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_healing_stream_totem_SpellScript();
        }
};

// 32182 - Heroism
/// Updated 4.3.4
class spell_sha_heroism : public SpellScriptLoader
{
    public:
        spell_sha_heroism() : SpellScriptLoader("spell_sha_heroism") { }

        class spell_sha_heroism_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_heroism_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_EXHAUSTION))
                    return false;
                return true;
            }

            void RemoveInvalidTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(Trinity::UnitAuraCheck(true, SPELL_SHAMAN_EXHAUSTION));
                targets.remove_if(Trinity::UnitAuraCheck(true, SPELL_HUNTER_INSANITY));
                targets.remove_if(Trinity::UnitAuraCheck(true, SPELL_MAGE_TEMPORAL_DISPLACEMENT));
            }

            void ApplyDebuff()
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_SHAMAN_EXHAUSTION, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_heroism_SpellScript::RemoveInvalidTargets, EFFECT_0, TARGET_UNIT_CASTER_AREA_RAID);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_heroism_SpellScript::RemoveInvalidTargets, EFFECT_1, TARGET_UNIT_CASTER_AREA_RAID);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_heroism_SpellScript::RemoveInvalidTargets, EFFECT_2, TARGET_UNIT_CASTER_AREA_RAID);
                AfterHit += SpellHitFn(spell_sha_heroism_SpellScript::ApplyDebuff);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_heroism_SpellScript();
        }
};

// 60103 - Lava Lash
/// Updated 4.3.4
class spell_sha_lava_lash : public SpellScriptLoader
{
    public:
        spell_sha_lava_lash() : SpellScriptLoader("spell_sha_lava_lash") { }

        class spell_sha_lava_lash_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_lava_lash_SpellScript)

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_PLAYER;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                if (Player* caster = GetCaster()->ToPlayer())
                {
                    int32 damage = GetEffectValue();
                    int32 hitDamage = GetHitDamage();
                    if (caster->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
                    {
                        // Damage is increased by 25% if your off-hand weapon is enchanted with Flametongue.
                        if (caster->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_SHAMAN, 0x200000, 0, 0))
                            AddPct(hitDamage, damage);
                        SetHitDamage(hitDamage);
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_lava_lash_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
            }

        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_lava_lash_SpellScript();
        }
};

// 16191 - Mana Tide
/// Updated 4.3.4
class spell_sha_mana_tide_totem : public SpellScriptLoader
{
    public:
        spell_sha_mana_tide_totem() : SpellScriptLoader("spell_sha_mana_tide_totem") { }

        class spell_sha_mana_tide_totem_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sha_mana_tide_totem_AuraScript);

            void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
            {
                ///@TODO: Exclude the "short term" buffs from the stat value
                if (Unit* caster = GetCaster())
                    if (Unit* owner = caster->GetOwner())
                        amount = CalculatePct(owner->GetStat(STAT_SPIRIT), aurEff->GetAmount());
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_sha_mana_tide_totem_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_STAT);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sha_mana_tide_totem_AuraScript();
        }
};

// -51490 - Thunderstorm
class spell_sha_thunderstorm : public SpellScriptLoader
{
    public:
        spell_sha_thunderstorm() : SpellScriptLoader("spell_sha_thunderstorm") { }

        class spell_sha_thunderstorm_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sha_thunderstorm_SpellScript);

            void HandleKnockBack(SpellEffIndex effIndex)
            {
                // Glyph of Thunderstorm
                if (GetCaster()->HasAura(SPELL_SHAMAN_GLYPH_OF_THUNDERSTORM))
                    PreventHitDefaultEffect(effIndex);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sha_thunderstorm_SpellScript::HandleKnockBack, EFFECT_2, SPELL_EFFECT_KNOCK_BACK);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sha_thunderstorm_SpellScript();
        }
};

// 77746 - Totemic Wrath
class spell_sha_totemic_wrath : public SpellScriptLoader
{
public:
    spell_sha_totemic_wrath() : SpellScriptLoader("spell_sha_totemic_wrath") { }

    class spell_sha_totemic_wrath_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_sha_totemic_wrath_AuraScript); 

        bool Validate(SpellInfo const* /*spellEntry*/)
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_TOTEMIC_WRATH)) 
                return false;
            if (!sSpellMgr->GetSpellInfo(SPELL_SHAMAN_TOTEM_TOTEMIC_WRATH_AURA))
                return false;
            return true;
        }

        void HandleEffectApply(AuraEffect const * aurEff, AuraEffectHandleModes /*mode*/)
        {

            // applied by a totem - cast the real aura if owner has the talent
            if (Unit *caster = aurEff->GetBase()->GetCaster())
                if (caster->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_GENERIC, 2019, 0))
                    caster->CastSpell(caster, SPELL_SHAMAN_TOTEM_TOTEMIC_WRATH_AURA, true, NULL, aurEff);
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_sha_totemic_wrath_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_sha_totemic_wrath_AuraScript();
    }
};

// 73920 - Healing Rain
class spell_sha_healing_rain : public SpellScriptLoader
{
public:
    spell_sha_healing_rain() : SpellScriptLoader("spell_sha_healing_rain") { }

    class spell_sha_healing_rain_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_sha_healing_rain_AuraScript);

        void OnTick(AuraEffect const* /*aurEff*/)
        {
            if (DynamicObject* dynObj = GetCaster()->GetDynObject(73920))
                GetCaster()->CastSpell(dynObj->GetPositionX(), dynObj->GetPositionY(), dynObj->GetPositionZ(), 73921, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_sha_healing_rain_AuraScript::OnTick, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_sha_healing_rain_AuraScript();
    }
};

// 61882 - Earthquake
class spell_sha_earthquake : public SpellScriptLoader
{
public:
    spell_sha_earthquake() : SpellScriptLoader("spell_sha_earthquake") { }

    class spell_sha_earthquake_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_sha_earthquake_AuraScript);

        void earthquake(AuraEffect const* /*aurEff*/)
        {
            if (!GetCaster())
                 return;

            if (DynamicObject* dynObj = GetCaster()->GetDynObject(61882))
            {
                GetCaster()->CastSpell(dynObj->GetPositionX(), dynObj->GetPositionY(), dynObj->GetPositionZ(), 77478, true);
            if (roll_chance_i(10))
                GetCaster()->CastSpell(dynObj->GetPositionX(), dynObj->GetPositionY(), dynObj->GetPositionZ(), 77505, true);
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_sha_earthquake_AuraScript::earthquake, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_sha_earthquake_AuraScript();
    }
};

//88766 Fulmination handled in 8042 Earth Shock
class spell_sha_fulmination: public SpellScriptLoader 
{
public:
    spell_sha_fulmination() : SpellScriptLoader ("spell_sha_fulmination") {}

    class spell_sha_fulmination_SpellScript: public SpellScript 
	{
        PrepareSpellScript(spell_sha_fulmination_SpellScript)

        void HandleFulmination(SpellEffIndex effIndex) 
        {
            //make caster cast a spell on a unit target of effect
            Unit *target = GetHitUnit();
            Unit *caster = GetCaster();
                if (!target || !caster)
                    return;

            AuraEffect *fulminationAura = caster->GetDummyAuraEffect(SPELLFAMILY_SHAMAN, 2010, 0);
                if (!caster->HasAura(88766))
                    return; 

            Aura * lightningShield = caster->GetAura(324);
                if (!lightningShield)
                    return;

            uint32 IsCharges = lightningShield->GetCharges();
                if (IsCharges <= 3)
                    return;

            uint8 usedCharges = IsCharges - 3;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_SHAMAN_LIGHTNING_SHIELD_PROC);

            int32 basePoints = (caster->CalculateSpellDamage(target, spellInfo, 0) * 1.2f);
            int32 damage = usedCharges * (caster->SpellDamageBonusDone(target, spellInfo, basePoints, SPELL_DIRECT_DAMAGE,effIndex));

            caster->CastCustomSpell(target, SPELL_SHAMAN_FULMINATION_TRIGGERED, &damage, NULL, NULL, true, NULL, fulminationAura);
            lightningShield->SetCharges(IsCharges - usedCharges);
        }

        void Register() 
        {
            OnEffectHitTarget += SpellEffectFn(spell_sha_fulmination_SpellScript::HandleFulmination,EFFECT_FIRST_FOUND, SPELL_EFFECT_ANY);
        }
    };

    SpellScript *GetSpellScript() const 
	{
        return new spell_sha_fulmination_SpellScript();
    }
};

void AddSC_shaman_spell_scripts()
{
    new spell_sha_ancestral_awakening_proc();
    new spell_sha_bloodlust();
    new spell_sha_chain_heal();
    new spell_sha_earth_shield();
    new spell_sha_earthbind_totem();
    new spell_sha_earthen_power();
    new spell_sha_fire_nova();
    new spell_sha_flame_shock();
    new spell_sha_healing_stream_totem();
    new spell_sha_heroism();
    new spell_sha_lava_lash();
    new spell_sha_mana_tide_totem();
    new spell_sha_thunderstorm();
    new spell_sha_totemic_wrath();
    new spell_sha_healing_rain();
    new spell_sha_earthquake();
	new spell_sha_fulmination();
}