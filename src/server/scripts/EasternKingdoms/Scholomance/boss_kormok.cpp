/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "scholomance.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_SHADOWBOLT_VOLLEY             = 20741,
    SPELL_BONE_SHIELD                   = 27688,

    SPELL_SUMMON_BONE_MAGES             = 27695,

    SPELL_SUMMON_BONE_MAGE_FRONT_LEFT   = 27696,
    SPELL_SUMMON_BONE_MAGE_FRONT_RIGHT  = 27697,
    SPELL_SUMMON_BONE_MAGE_BACK_RIGHT   = 27698,
    SPELL_SUMMON_BONE_MAGE_BACK_LEFT    = 27699,

    SPELL_SUMMON_BONE_MINIONS           = 27687
};

enum Events
{
    EVENT_SHADOWBOLT_VOLLEY = 1,
    EVENT_BONE_SHIELD,
    EVENT_SUMMON_MINIONS
};

class boss_kormok : public CreatureScript
{
public:
    boss_kormok() : CreatureScript("boss_kormok") { }

    struct boss_kormokAI : public ScriptedAI
    {
        boss_kormokAI(Creature* creature) : ScriptedAI(creature)
        {
            Initialize();
        }

        void Initialize()
        {
            Mages = false;
        }

        void Reset() override
        {
            Initialize();
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_SHADOWBOLT_VOLLEY, 10000);
            events.ScheduleEvent(EVENT_BONE_SHIELD, 2000);
            events.ScheduleEvent(EVENT_SUMMON_MINIONS, 15000);
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->AI()->AttackStart(me->GetVictim());
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage) override
        {
            if (me->HealthBelowPctDamaged(25, damage) && !Mages)
            {
                DoCast(SPELL_SUMMON_BONE_MAGES);
                Mages = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SHADOWBOLT_VOLLEY:
                        DoCastVictim(SPELL_SHADOWBOLT_VOLLEY);
                        events.ScheduleEvent(EVENT_SHADOWBOLT_VOLLEY, 15000);
                        break;
                    case EVENT_BONE_SHIELD:
                        DoCastVictim(SPELL_BONE_SHIELD);
                        events.ScheduleEvent(EVENT_BONE_SHIELD, 45000);
                        break;
                    case EVENT_SUMMON_MINIONS:
                        DoCast(SPELL_SUMMON_BONE_MINIONS);
                        events.ScheduleEvent(EVENT_SUMMON_MINIONS, 12000);
                        break;
                    default:
                        break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
            }

            DoMeleeAttackIfReady();
        }

        private:
            EventMap events;
            bool Mages;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<boss_kormokAI>(creature);
    }
};

uint32 const SummonMageSpells[4] =
{
    SPELL_SUMMON_BONE_MAGE_FRONT_LEFT,
    SPELL_SUMMON_BONE_MAGE_FRONT_RIGHT,
    SPELL_SUMMON_BONE_MAGE_BACK_RIGHT,
    SPELL_SUMMON_BONE_MAGE_BACK_LEFT,
};

// 27695 - Summon Bone Mages
class spell_kormok_summon_bone_mages : SpellScriptLoader
{
    public:
        spell_kormok_summon_bone_mages() : SpellScriptLoader("spell_kormok_summon_bone_mages") { }

        class spell_kormok_summon_bone_magesSpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kormok_summon_bone_magesSpellScript);

            bool Validate(SpellInfo const* /*spell*/) override
            {
                return ValidateSpellInfo(SummonMageSpells);
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                for (uint32 i = 0; i < 2; ++i)
                    GetCaster()->CastSpell(GetCaster(), SummonMageSpells[urand(0, 3)], true);
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_magesSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_kormok_summon_bone_magesSpellScript();
        }
};

// 27687 - Summon Bone Minions
class spell_kormok_summon_bone_minions : SpellScriptLoader
{
    public:
       spell_kormok_summon_bone_minions() : SpellScriptLoader("spell_kormok_summon_bone_minions") { }

    class spell_kormok_summon_bone_minionsSpellScript : public SpellScript
    {
        PrepareSpellScript(spell_kormok_summon_bone_minionsSpellScript);

        bool Validate(SpellInfo const* /*spell*/) override
        {
            return ValidateSpellInfo({ SPELL_SUMMON_BONE_MINIONS });
        }

        void HandleScript(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);

            // Possible spells to handle this not found.
            for (uint32 i = 0; i < 4; ++i)
                GetCaster()->SummonCreature(NPC_BONE_MINION, GetCaster()->GetPositionX() + float(irand(-7, 7)), GetCaster()->GetPositionY() + float(irand(-7, 7)), GetCaster()->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 120000);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_minionsSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_kormok_summon_bone_minionsSpellScript();
    }
};

void AddSC_boss_kormok()
{
    new boss_kormok();
    new spell_kormok_summon_bone_mages();
    new spell_kormok_summon_bone_minions();
}
