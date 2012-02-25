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

#include "ScriptPCH.h"
#include "naxxramas.h"

//Stalagg
enum StalaggYells
{
    SAY_STAL_AGGRO          = -1533023, //not used
    SAY_STAL_SLAY           = -1533024, //not used
    SAY_STAL_DEATH          = -1533025  //not used
};

enum StalagSpells
{
    SPELL_POWERSURGE        = 54529,
    H_SPELL_POWERSURGE      = 28134,
    SPELL_ENRAGE_LIGHTNING  = 64215
};

//Feugen
enum FeugenYells
{
    SAY_FEUG_AGGRO          = -1533026, //not used
    SAY_FEUG_SLAY           = -1533027, //not used
    SAY_FEUG_DEATH          = -1533028 //not used
};

enum FeugenSpells
{
    SPELL_STATICFIELD       = 28135,
    H_SPELL_STATICFIELD     = 54528,
    SPELL_VISUAL            = 45537
};

// Thaddius DoAction
enum ThaddiusActions
{
    ACTION_FEUGEN_RESET,
    ACTION_FEUGEN_DIED,
    ACTION_STALAGG_RESET,
    ACTION_STALAGG_DIED
};

//generic
#define C_TESLA_COIL            16218           //the coils (emotes "Tesla Coil overloads!")

//Thaddius
enum ThaddiusYells
{
    SAY_GREET               = -1533029, //not used
    SAY_AGGRO_1             = -1533030,
    SAY_AGGRO_2             = -1533031,
    SAY_AGGRO_3             = -1533032,
    SAY_SLAY                = -1533033,
    SAY_ELECT               = -1533034, //not used
    SAY_DEATH               = -1533035,
    SAY_SCREAM1             = -1533036, //not used
    SAY_SCREAM2             = -1533037, //not used
    SAY_SCREAM3             = -1533038, //not used
    SAY_SCREAM4             = -1533039 //not used
};

enum ThaddiusSpells
{
    SPELL_POLARITY_SHIFT        = 28089,
    SPELL_BALL_LIGHTNING        = 28299,
    SPELL_CHAIN_LIGHTNING       = 28167,
    H_SPELL_CHAIN_LIGHTNING     = 54531,
    SPELL_BERSERK               = 27680,
    SPELL_POSITIVE_1            = 28059,
    SPELL_POSITIVE_2            = 29659,
    SPELL_NEGATIVE_1            = 28084,
    SPELL_NEGATIVE_2            = 29660,
    SPELL_POSITIVE_CHARGE       = 28062,
    SPELL_POSITIVE_CHARGE_STACK = 29659,
    SPELL_NEGATIVE_CHARGE       = 28085,
    SPELL_NEGATIVE_CHARGE_STACK = 29660
};

enum Events
{
    EVENT_NONE,
    EVENT_SHIFT,
    EVENT_CHAIN,
    EVENT_BERSERK,
};

enum Achievement
{
    DATA_POLARITY_SWITCH    = 76047605,
};

const Position EnragePositions[2] =
{
    {3528.02f, -2952.79f, 319.2f, 4.0215f}, // Feugen
    {3487.25f, -2911.86f, 318.96f, 3.7144f} // Stalagg
};

#define MIN_POS_Z_ADDS      307.0f
#define MIN_POS_Z_BOSS      299.0f

class boss_thaddius : public CreatureScript
{
public:
    boss_thaddius() : CreatureScript("boss_thaddius") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_thaddiusAI (creature);
    }

    struct boss_thaddiusAI : public BossAI
    {
        boss_thaddiusAI(Creature* c) : BossAI(c, BOSS_THADDIUS)
        {
            instance = c->GetInstanceScript();
        }

        InstanceScript* instance;
        uint32 EnrageTimer;
        bool enrage;
        bool polaritySwitch;

        void Reset()
        {
            _Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
            me->SetReactState(REACT_PASSIVE);
            enrage = false;
            EnrageTimer = 1000;

            if (instance)
            {
                Creature* pFeugen = me->GetCreature(*me, instance->GetData64(DATA_FEUGEN));
                Creature* pStalagg = me->GetCreature(*me, instance->GetData64(DATA_STALAGG));
                if (pFeugen && pStalagg)
                {
                    pFeugen->Respawn();
                    pStalagg->Respawn();
                }
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            if (!(rand()%5))
                DoScriptText(SAY_SLAY, me);
        }

        void JustDied(Unit* /*Killer*/)
        {
            DoRemovePolarity();
            _JustDied();
            DoScriptText(SAY_DEATH, me);
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();
            DoRemovePolarity();
            DoScriptText(RAND(SAY_AGGRO_1, SAY_AGGRO_2, SAY_AGGRO_3), me);
            events.ScheduleEvent(EVENT_SHIFT, 10000);
            events.ScheduleEvent(EVENT_CHAIN, urand(10000, 20000));
            events.ScheduleEvent(EVENT_BERSERK, 360000);
        }

        void SetData(uint32 id, uint32 data)
        {
            if (id == DATA_POLARITY_SWITCH)
                polaritySwitch = data ? true : false;
        }

        uint32 GetData(uint32 id)
        {
            if (id != DATA_POLARITY_SWITCH)
                return 0;

            return uint32(polaritySwitch);
        }

        void DoRemovePolarity()
        {
            if (instance)
            {
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_1);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_2);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_1);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_2);
            }
        }

        void UpdateAI(const uint32 diff)
        {
            Creature* pFeugen = NULL;
            Creature* pStalagg = NULL;

            if (instance)
            {
                pFeugen = me->GetCreature(*me, instance->GetData64(DATA_FEUGEN));
                pStalagg = me->GetCreature(*me, instance->GetData64(DATA_STALAGG));
            }

            if (!pFeugen || !pStalagg)
                return;

            if (!pStalagg->isAlive() && !pFeugen->isAlive() && !me->HasReactState(REACT_AGGRESSIVE))
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_STUNNED);
                me->SetReactState(REACT_AGGRESSIVE);
            }

            if (!UpdateVictim())
                return;

            if ((events.GetTimer() > 15000 && !me->IsWithinMeleeRange(me->getVictim())) || me->GetPositionZ() < MIN_POS_Z_BOSS)
                enrage = true;
            else enrage = false;

            if (enrage)
            {
                if (EnrageTimer <= diff)
                {
                    DoCast(me->getVictim(), SPELL_BALL_LIGHTNING, true);
                    EnrageTimer = 1000;
                } else EnrageTimer -= diff;
            }

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SHIFT:
                        DoCastAOE(SPELL_POLARITY_SHIFT);
                        events.ScheduleEvent(EVENT_SHIFT, 30000);
                        return;
                    case EVENT_CHAIN:
                        DoCast(me->getVictim(), RAID_MODE(SPELL_CHAIN_LIGHTNING, H_SPELL_CHAIN_LIGHTNING));
                        events.ScheduleEvent(EVENT_CHAIN, urand(10000, 20000));
                        return;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK);
                        events.ScheduleEvent(EVENT_BERSERK, 60000 * 10);
                        return;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

};


class mob_stalagg : public CreatureScript
{
public:
    mob_stalagg() : CreatureScript("mob_stalagg") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_stalaggAI(creature);
    }

    struct mob_stalaggAI : public ScriptedAI
    {
        mob_stalaggAI(Creature* c) : ScriptedAI(c)
        {
            instance = c->GetInstanceScript();
        }

        uint32 PowerSurgeTimer;
        uint32 JumpTimer;
        uint32 ReviveTimer;
        bool enableRevive;
        float threatSaver;
        bool enableThreatTimer;
        uint32 ThreatTimer;
        Unit* Jumper;
        bool enrage;
        uint32 EnrageTimer;
        InstanceScript* instance;

        void EnterCombat(Unit* /*who*/)
        {
            if (instance)
                instance->SetBossState(BOSS_THADDIUS, IN_PROGRESS);
        }

        void Reset()
        {
            if (instance)
                instance->SetBossState(BOSS_THADDIUS, NOT_STARTED);
            PowerSurgeTimer = urand(20000, 25000);
            JumpTimer = 30000;
            enableRevive = false;
            ReviveTimer = 15000;
            threatSaver = 0.0f;
            enableThreatTimer = false;
            ThreatTimer = 2500;
            Jumper = NULL;
            enrage = false;
            EnrageTimer = 500;
        }

        void UpdateAI(const uint32 uiDiff);
    };

};


class mob_feugen : public CreatureScript
{
public:
    mob_feugen() : CreatureScript("mob_feugen") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_feugenAI(creature);
    }

    struct mob_feugenAI : public ScriptedAI
    {
        mob_feugenAI(Creature* c) : ScriptedAI(c)
        {
            instance = c->GetInstanceScript();
        }

        uint32 StaticFieldTimer;
        uint32 JumpTimer;
        uint32 ReviveTimer;
        bool enableRevive;
        float threatSaver;
        bool enableThreatTimer;
        uint32 ThreatTimer;
        Unit* Jumper;
        bool enrage;
        uint32 EnrageTimer;
        InstanceScript* instance;

        void EnterCombat(Unit* /*who*/)
        {
            if (instance)
                instance->SetBossState(BOSS_THADDIUS, IN_PROGRESS);
        }

        void Reset()
        {
            if (instance)
                instance->SetBossState(BOSS_THADDIUS, NOT_STARTED);
            StaticFieldTimer = 5000;
            JumpTimer = 30000;
            enableRevive = false;
            ReviveTimer = 15000;
            threatSaver = 0.0f;
            enableThreatTimer = false;
            ThreatTimer = 2500;
            Jumper = NULL;
            enrage = false;
            EnrageTimer = 500;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            Creature* pStalagg = NULL;

            if (!instance)
                return;

            pStalagg = me->GetCreature(*me, instance->GetData64(DATA_STALAGG));
            if (!pStalagg)
                return;

            if (pStalagg->isInCombat() && !me->isInCombat())
            {
                DoZoneInCombat();
                if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0, true))
                    AttackStart(target);
            }

            if (!pStalagg->isAlive() && me->isAlive())
                enableRevive = true;

            if (enableRevive)
            {
                if (ReviveTimer <= uiDiff)
                {
                    enableRevive = false;
                    if (me->isAlive())
                    {
                        pStalagg->Respawn();
                        pStalagg->SetHealth(uint32(pStalagg->GetMaxHealth() * 0.5f));
                        CAST_AI(mob_stalagg::mob_stalaggAI, pStalagg->AI())->JumpTimer = JumpTimer;
                    }
                    ReviveTimer = 15000;
                } else ReviveTimer -= uiDiff;
            }

            if (!UpdateVictim())
                return;

            if (me->GetDistance(EnragePositions[0]) > 65.0f || me->GetPositionZ() < MIN_POS_Z_ADDS)
                enrage = true;
            else
                enrage = false;

            if (enrage)
            {
                if (EnrageTimer <= uiDiff)
                {
                    DoCast(me->getVictim(), SPELL_ENRAGE_LIGHTNING, true);
                    EnrageTimer = 500;
                } else EnrageTimer -= uiDiff;
            }

            if (StaticFieldTimer <= uiDiff)
            {
                DoCast(me, RAID_MODE(SPELL_STATICFIELD, H_SPELL_STATICFIELD));
                StaticFieldTimer = 3000;
            } else StaticFieldTimer -= uiDiff;

            if (JumpTimer <= uiDiff)
            {
                Jumper = me->getVictim();
                threatSaver = DoGetThreat(me->getVictim());
                DoModifyThreatPercent(me->getVictim(), -100);
                me->getVictim()->GetMotionMaster()->MoveJump(pStalagg->GetPositionX(), pStalagg->GetPositionY(), pStalagg->GetPositionZ(), 20, 20);
                enableThreatTimer = true;
                JumpTimer = 30000;
            } else JumpTimer -= uiDiff;

            if (enableThreatTimer)
            {
                if (ThreatTimer <= uiDiff)
                {
                    enableThreatTimer = false;
                    pStalagg->AddThreat(Jumper, threatSaver);
                    ThreatTimer = 2500;
                } else ThreatTimer -= uiDiff;
            }

            DoMeleeAttackIfReady();
        }
    };

};

class spell_thaddius_pos_neg_charge : public SpellScriptLoader
{
    public:
        spell_thaddius_pos_neg_charge() : SpellScriptLoader("spell_thaddius_pos_neg_charge") { }

        class spell_thaddius_pos_neg_charge_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_thaddius_pos_neg_charge_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_POSITIVE_CHARGE))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_POSITIVE_CHARGE_STACK))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_NEGATIVE_CHARGE))
                    return false;
                if (!sSpellMgr->GetSpellInfo(SPELL_NEGATIVE_CHARGE_STACK))
                    return false;
                return true;
            }

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleTargets(std::list<Unit*>& targetList)
            {
                uint8 count = 0;
                for (std::list<Unit*>::iterator ihit = targetList.begin(); ihit != targetList.end(); ++ihit)
                    if ((*ihit)->GetGUID() != GetCaster()->GetGUID())
                        if (Player* target = (*ihit)->ToPlayer())
                            if (target->HasAura(GetTriggeringSpell()->Id))
                                ++count;

                if (count)
                {
                    uint32 spellId = 0;

                    if (GetSpellInfo()->Id == SPELL_POSITIVE_CHARGE)
                        spellId = SPELL_POSITIVE_CHARGE_STACK;
                    else // if (GetSpellInfo()->Id == SPELL_NEGATIVE_CHARGE)
                        spellId = SPELL_NEGATIVE_CHARGE_STACK;

                    GetCaster()->SetAuraStack(spellId, GetCaster(), count);
                }
            }

            void HandleDamage(SpellEffIndex /*effIndex*/)
            {
                if (!GetTriggeringSpell())
                    return;

                Unit* target = GetHitUnit();
                Unit* caster = GetCaster();

                if (target->HasAura(GetTriggeringSpell()->Id))
                    SetHitDamage(0);
                else
                {
                    if (target->GetTypeId() == TYPEID_PLAYER && caster->IsAIEnabled)
                        caster->ToCreature()->AI()->SetData(DATA_POLARITY_SWITCH, 1);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_thaddius_pos_neg_charge_SpellScript::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_thaddius_pos_neg_charge_SpellScript::HandleTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_thaddius_pos_neg_charge_SpellScript();
        }
};

class achievement_polarity_switch : public AchievementCriteriaScript
{
    public:
        achievement_polarity_switch() : AchievementCriteriaScript("achievement_polarity_switch") { }

        bool OnCheck(Player* /*source*/, Unit* target)
        {
            return target && target->GetAI()->GetData(DATA_POLARITY_SWITCH);
        }
};

void mob_stalagg::mob_stalaggAI::UpdateAI(const uint32 uiDiff)
{
    Creature* pFeugen = NULL;

    if (!instance)
        return;

    pFeugen = me->GetCreature(*me, instance->GetData64(DATA_FEUGEN));
    if (!pFeugen)
        return;

    if (pFeugen->isInCombat() && !me->isInCombat())
    {
        me->SetInCombatWithZone();
        if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0, true))
            AttackStart(target);
    }

    if (!pFeugen->isAlive() && me->isAlive())
        enableRevive = true;

    if (enableRevive)
    {
        if (ReviveTimer <= uiDiff)
        {
            enableRevive = false;
            if (me->isAlive())
            {
                pFeugen->Respawn();
                pFeugen->SetHealth(uint32(pFeugen->GetMaxHealth() * 0.5f));
                CAST_AI(mob_feugen::mob_feugenAI, pFeugen->AI())->JumpTimer = JumpTimer;
            }
            ReviveTimer = 15000;
        } else ReviveTimer -= uiDiff;
    }

    if (!UpdateVictim())
        return;

    if (me->GetDistance(EnragePositions[1]) > 65.0f || me->GetPositionZ() < MIN_POS_Z_ADDS)
        enrage = true;
    else
        enrage = false;

    if (enrage)
    {
        if (EnrageTimer <= uiDiff)
        {
            DoCast(me->getVictim(), SPELL_ENRAGE_LIGHTNING, true);
            EnrageTimer = 500;
        } else EnrageTimer -= uiDiff;
    }

    if (PowerSurgeTimer <= uiDiff)
    {
        DoCast(me, RAID_MODE(SPELL_POWERSURGE, H_SPELL_POWERSURGE));
        PowerSurgeTimer = urand(15000, 20000);
    } else PowerSurgeTimer -= uiDiff;

    if (JumpTimer <= uiDiff)
    {
        Jumper = me->getVictim();
        threatSaver = DoGetThreat(me->getVictim());
        DoModifyThreatPercent(me->getVictim(), -100);
        me->getVictim()->GetMotionMaster()->MoveJump(pFeugen->GetPositionX(), pFeugen->GetPositionY(), pFeugen->GetPositionZ(), 20, 20);
        enableThreatTimer = true;
        JumpTimer = 30000;
    } else JumpTimer -= uiDiff;

    if (enableThreatTimer)
    {
        if (ThreatTimer <= uiDiff)
        {
            enableThreatTimer = false;
            pFeugen->AddThreat(Jumper, threatSaver);
            ThreatTimer = 2500;
        } else ThreatTimer -= uiDiff;
    }

    DoMeleeAttackIfReady();
}

class mob_tesla_thaddius : public CreatureScript
{
public:
    mob_tesla_thaddius() : CreatureScript("mob_tesla_thaddius") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_tesla_thaddiusAI(creature);
    }

    struct mob_tesla_thaddiusAI : public Scripted_NoMovementAI
    {
        mob_tesla_thaddiusAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            instance = me->GetInstanceScript();
        }

        uint32 CheckTimer;
        InstanceScript* instance;

        void DoRemovePolarity()
        {
            if (instance)
            {
                if (instance->GetBossState(BOSS_THADDIUS) != IN_PROGRESS)
                {
                    instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_1);
                    instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POSITIVE_2);
                    instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_1);
                    instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_NEGATIVE_2);
                }
            }
        }

        void Reset()
        {
            CastVisual();
            CheckTimer = 3000;
        }

        void CastVisual()
        {
            if (instance)
            {
                Creature* pFeugen = me->GetCreature(*me, instance->GetData64(DATA_FEUGEN));
                Creature* pStalagg = me->GetCreature(*me, instance->GetData64(DATA_STALAGG));
                if (pFeugen && pStalagg)
                {
                    if (!pStalagg->HasAura(SPELL_VISUAL) && pStalagg->isAlive() && me->GetDistance(pStalagg) < me->GetDistance(pFeugen))
                        DoCast(pStalagg, SPELL_VISUAL, true);
                    if (!pFeugen->HasAura(SPELL_VISUAL) && pFeugen->isAlive() && me->GetDistance(pFeugen) < me->GetDistance(pStalagg))
                        DoCast(pFeugen, SPELL_VISUAL, true);
                }
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (CheckTimer <= uiDiff)
            {
                DoRemovePolarity();
                CastVisual();
                CheckTimer = 3000;
            } else CheckTimer -= uiDiff;
        }
    };
};

void AddSC_boss_thaddius()
{
    new boss_thaddius();
    new mob_stalagg();
    new mob_feugen();
    new spell_thaddius_pos_neg_charge();
    new achievement_polarity_switch();
    new mob_tesla_thaddius();
}
