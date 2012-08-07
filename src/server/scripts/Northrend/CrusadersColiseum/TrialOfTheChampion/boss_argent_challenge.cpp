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

/* ScriptData
SDName: Argent Challenge Encounter.
SD%Complete: 50 %
SDComment: AI for Argent Soldiers are not implemented. AI from bosses need more improvements.
SDCategory: Trial of the Champion
EndScriptData */

#include "ScriptPCH.h"
#include "trial_of_the_champion.h"
#include "ScriptedEscortAI.h"

enum eSpells
{
    //Eadric
    SPELL_EADRIC_ACHIEVEMENT    = 68197,
    SPELL_HAMMER_JUSTICE        = 66863,
    SPELL_HAMMER_JUSTICE_STUN   = 66940,
    SPELL_HAMMER_RIGHTEOUS      = 66867,
    SPELL_HAMMER_OVERRIDE_BAR   = 66904, // overrides players cast bar
    SPELL_HAMMER_THROWBACK_DMG  = 66905, // the hammer that is thrown back by the player
    SPELL_RADIANCE              = 66935,
    SPELL_VENGEANCE             = 66865,

    //Paletress
    SPELL_CONFESSOR_ACHIEVEMENT = 68206,
    SPELL_SMITE                 = 66536,
    SPELL_SMITE_H               = 67674,
    SPELL_HOLY_FIRE             = 66538,
    SPELL_HOLY_FIRE_H           = 67676,
    SPELL_RENEW                 = 66537,
    SPELL_RENEW_H               = 67675,
    SPELL_HOLY_NOVA             = 66546,
    SPELL_SHIELD                = 66515,
    SPELL_CONFESS               = 66680,
    SPELL_SUMMON_MEMORY         = 66545,

    //Npc_argent_soldier
    SPELL_STRIKE_H              = 67237,
    SPELL_CLEAVE                = 15284,
    SPELL_PUMMEL                = 67235,
    SPELL_PAIN                  = 34941,
    SPELL_PAIN_H                = 34942,
    SPELL_MIND_H                = 67229,
    SPELL_SMITE_ADD             = 36176,
    SPELL_SMITE_ADD_H           = 67289,
    SPELL_LIGHT                 = 67247,
    SPELL_LIGHT_H               = 67290,
    SPELL_FLURRY                = 67233,
    SPELL_FINAL_H               = 67255,
    SPELL_DIVINE_H              = 67251,
    SPELL_FONT                  = 67194,

    //Memory
    SPELL_OLD_WOUNDS            = 66620,
    SPELL_OLD_WOUNDS_H          = 67679,
    SPELL_SHADOWS_PAST          = 66619,
    SPELL_SHADOWS_PAST_H        = 67678,
    SPELL_WAKING_NIGHTMARE      = 66552,
    SPELL_WAKING_NIGHTMARE_H    = 67677
};

class OrientationCheck : public std::unary_function<Unit*, bool>
{
    public:
        explicit OrientationCheck(Unit* _caster) : caster(_caster) { }
        bool operator() (Unit* unit)
        {
            return !unit->isInFront(caster, 40.0f, 2.5f);
        }

    private:
        Unit* caster;
};

class spell_eadric_radiance : public SpellScriptLoader
{
    public:
        spell_eadric_radiance() : SpellScriptLoader("spell_eadric_radiance") { }
        class spell_eadric_radiance_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_eadric_radiance_SpellScript);
            void FilterTargets(std::list<Unit*>& unitList)
            {
                unitList.remove_if (OrientationCheck(GetCaster()));
            }

            void Register()
            {
                OnUnitTargetSelect += SpellUnitTargetFn(spell_eadric_radiance_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnUnitTargetSelect += SpellUnitTargetFn(spell_eadric_radiance_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_eadric_radiance_SpellScript();
        }
};

class spell_eadric_hoj : public SpellScriptLoader
{
    public:
        spell_eadric_hoj() : SpellScriptLoader("spell_eadric_hoj") { }
        class spell_eadric_hoj_SpellScript: public SpellScript
        {
            PrepareSpellScript(spell_eadric_hoj_SpellScript);
            void HandleOnHit()
            {
                if (GetHitUnit() && GetHitUnit()->GetTypeId() == TYPEID_PLAYER)
                    if (!GetHitUnit()->HasAura(SPELL_HAMMER_JUSTICE_STUN)) // FIXME: Has Catched Hammer...
                    {
                        SetHitDamage(0);
                        GetHitUnit()->AddAura(SPELL_HAMMER_OVERRIDE_BAR, GetHitUnit());
                    }

            }

            void Register()
            {
                OnHit += SpellHitFn(spell_eadric_hoj_SpellScript::HandleOnHit);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_eadric_hoj_SpellScript();
        }
};

enum eEnums
{
    SAY_START_6                             = -1999951,
    SAY_START_7                             = -1999954,
    SAY_START_8                             = -1999941
};

class boss_eadric : public CreatureScript
{
public:
    boss_eadric() : CreatureScript("boss_eadric") { }
    struct boss_eadricAI : public ScriptedAI
    {
        boss_eadricAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            bCredit = false;
            creature->SetReactState(REACT_PASSIVE);
            creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        InstanceScript* instance;

        uint32 uiVenganceTimer;
        uint32 uiRadianceTimer;
        uint32 uiHammerJusticeTimer;
        uint32 uiResetTimer;

        bool bDone;
        bool bCredit;

        void Reset()
        {
            uiVenganceTimer = 10000;
            uiRadianceTimer = 16000;
            uiHammerJusticeTimer = 25000;
            uiResetTimer = 5000;
            me->GetMotionMaster()->MovePoint(1, 746.71f, 661.02f, 411.69f);
            me->SetOrientation(4.714f);

            bDone = false;
        }

        void DamageTaken(Unit* /*done_by*/, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                if (!bCredit)
                {
                    bCredit = true;
                    HandleSpellOnPlayersInInstanceToC5(me, 68575);
                }
                EnterEvadeMode();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                DoScriptText(SAY_START_8, me);
                me->setFaction(35);
                bDone = true;

                if (instance)
                {
                    if (GameObject* go = GameObject::GetGameObject(*me, instance->GetData64(DATA_MAIN_GATE)))
                        instance->HandleGameObject(go->GetGUID(), true);

                    if (GameObject* go = GameObject::GetGameObject(*me, instance->GetData64(DATA_MAIN_GATE1)))
                        instance->HandleGameObject(go->GetGUID(), true);

                    // Instance encounter counting mechanics
                    // instance->UpdateEncounterState(ENCOUNTER_CREDIT_CAST_SPELL, 68574, me);

                    instance->SetData(BOSS_ARGENT_CHALLENGE_E, DONE);
                }
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spell)
        {
            if (IsHeroic() && !bDone)
                if (caster->GetTypeId() == TYPEID_PLAYER)
                    if (spell->Id == SPELL_HAMMER_THROWBACK_DMG && me->GetHealth() <= uint32(spell->Effects[0].BasePoints))
                        DoCast(caster, SPELL_EADRIC_ACHIEVEMENT);
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (bDone && uiResetTimer <= uiDiff)
            {
                me->GetMotionMaster()->MovePoint(0, 746.87f, 665.87f, 411.75f);
                bDone = false;
            } else uiResetTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (uiHammerJusticeTimer <= uiDiff)
            {
                me->InterruptNonMeleeSpells(true);

                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 250, true))
                {
                    if (target && target->isAlive())
                    {
                        DoCast(target, SPELL_HAMMER_JUSTICE);
                        DoCast(target, SPELL_HAMMER_RIGHTEOUS);
                    }
                }
                uiHammerJusticeTimer = 25000;
            } else uiHammerJusticeTimer -= uiDiff;

            if (uiVenganceTimer <= uiDiff)
            {
                DoCast(me, SPELL_VENGEANCE);

                uiVenganceTimer = 10000;
            } else uiVenganceTimer -= uiDiff;

            if (uiRadianceTimer <= uiDiff)
            {
                DoCastAOE(SPELL_RADIANCE);

                uiRadianceTimer = 16000;
            } else uiRadianceTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_eadricAI(creature);
    }
};

class boss_paletress : public CreatureScript
{
public:
    boss_paletress() : CreatureScript("boss_paletress") { }

    struct boss_paletressAI : public ScriptedAI
    {
        boss_paletressAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();

            bCredit = false;

            MemoryGUID = 0;
            creature->SetReactState(REACT_PASSIVE);
            creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            creature->RestoreFaction();
        }

        InstanceScript* instance;

        Creature* pMemory;
        uint64 MemoryGUID;

        bool bHealth;
        bool bDone;
        bool bCredit;

        uint32 uiHolyFireTimer;
        uint32 uiHolySmiteTimer;
        uint32 uiRenewTimer;
        uint32 uiResetTimer;

        void Reset()
        {
            me->RemoveAllAuras();

            uiHolyFireTimer     = urand(9000, 12000);
            uiHolySmiteTimer    = urand(5000, 7000);
            uiRenewTimer        = urand(2000, 5000);

            uiResetTimer        = 7000;

            me->GetMotionMaster()->MovePoint(1, 746.71f, 661.02f, 411.69f);
            me->SetOrientation(4.714f);

            bHealth = false;
            bDone = false;

            if (Creature* pMemory = Unit::GetCreature(*me, MemoryGUID))
                if (pMemory->isAlive())
                    pMemory->DespawnOrUnsummon();
        }

        void SetData(uint32 uiId, uint32 /*uiValue*/)
        {
            if (uiId == 1)
                me->RemoveAura(SPELL_SHIELD);
        }

        void DamageTaken(Unit* /*done_by*/, uint32 &damage)
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                if (!bCredit)
                {
                    bCredit = true;
                    HandleSpellOnPlayersInInstanceToC5(me, 68574);
                }
                EnterEvadeMode();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                DoScriptText(SAY_START_7, me);
                me->setFaction(35);
                bDone = true;

                if (instance)
                {
                    if (GameObject* go = GameObject::GetGameObject(*me, instance->GetData64(DATA_MAIN_GATE)))
                        instance->HandleGameObject(go->GetGUID(), true);

                    if (GameObject* go = GameObject::GetGameObject(*me, instance->GetData64(DATA_MAIN_GATE1)))
                        instance->HandleGameObject(go->GetGUID(), true);

                    // Instance encounter counting mechanics
                    // instance->UpdateEncounterState(ENCOUNTER_CREDIT_CAST_SPELL, 68574, me);

                    instance->SetData(BOSS_ARGENT_CHALLENGE_P, DONE);
                }
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (bDone && uiResetTimer <= uiDiff)
            {
                me->GetMotionMaster()->MovePoint(0, 746.87f, 665.87f, 411.75f);
                bDone = false;
            } else uiResetTimer -= uiDiff;

            if (!UpdateVictim())
                return;

            if (uiHolyFireTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 250, true))
                {
                    if (target && target->isAlive())
                        DoCast(target, SPELL_HOLY_FIRE);
                }
                 if (me->HasAura(SPELL_SHIELD))
                    uiHolyFireTimer = 13000;
                else
                    uiHolyFireTimer = urand(9000, 12000);
            } else uiHolyFireTimer -= uiDiff;

            if (uiHolySmiteTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 250, true))
                {
                    if (target && target->isAlive())
                        DoCast(target, SPELL_SMITE);
                }
                if (me->HasAura(SPELL_SHIELD))
                    uiHolySmiteTimer = 9000;
                else
                    uiHolySmiteTimer = urand(5000, 7000);
            } else uiHolySmiteTimer -= uiDiff;

            if (me->HasAura(SPELL_SHIELD))
            {
                if (uiRenewTimer <= uiDiff)
                {
                    me->InterruptNonMeleeSpells(true);
                    uint8 uiTarget = urand(0, 1);
                    switch (uiTarget)
                    {
                        case 0:
                            DoCast(me, SPELL_RENEW);
                            break;
                        case 1:
                            if (Creature* pMemory = Unit::GetCreature(*me, MemoryGUID))
                                if (pMemory->isAlive())
                                    DoCast(pMemory, SPELL_RENEW);
                            break;
                    }
                    uiRenewTimer = urand(15000, 17000);
                } else uiRenewTimer -= uiDiff;
            }

            if (!bHealth && !HealthAbovePct(25))
            {
                DoScriptText(SAY_START_6, me);
                me->InterruptNonMeleeSpells(true);
                DoCastAOE(SPELL_HOLY_NOVA, false);
                DoCast(me, SPELL_SHIELD);

                // This does NOT work! AOE will hit every player target causing multiple spawns
                // DoCastAOE(SPELL_SUMMON_MEMORY, false);
                uint8 uiRandom = urand(0, 25);
                uint32 uiSpells[26] = {66704, 66705, 66706, 66707, 66709, 66710, 66711, 66712, 66713, 66714, 66715, 66708, 66708, 66691, 66692, 66694, 66695, 66696, 66697, 66698, 66699, 66700, 66701, 66702, 66703, 66543};
                DoCast(me, uiSpells[uiRandom], true);

                DoCastAOE(SPELL_CONFESS, false);

                bHealth = true;
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon)
        {
            if (summon)
            {
                MemoryGUID = summon->GetGUID();
                DoZoneInCombat(summon);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_paletressAI(creature);
    }
};

class npc_memory : public CreatureScript
{
public:
    npc_memory() : CreatureScript("npc_memory") { }

    struct npc_memoryAI : public ScriptedAI
    {
        npc_memoryAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 uiOldWoundsTimer;
        uint32 uiShadowPastTimer;
        uint32 uiWakingNightmare;

        void Reset()
        {
            uiOldWoundsTimer = 12000;
            uiShadowPastTimer = 5000;
            uiWakingNightmare = 7000;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (!UpdateVictim())
                return;

            if (uiOldWoundsTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                {
                    if (target && target->isAlive())
                        DoCast(target, SPELL_OLD_WOUNDS);
                }
                uiOldWoundsTimer = 12000;
            }else uiOldWoundsTimer -= uiDiff;

            if (uiWakingNightmare <= uiDiff)
            {
                DoCast(me, SPELL_WAKING_NIGHTMARE);
                uiWakingNightmare = urand(10000, 25000);
            }else uiWakingNightmare -= uiDiff;

            if (uiShadowPastTimer <= uiDiff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                {
                    if (target && target->isAlive())
                        DoCast(target, SPELL_SHADOWS_PAST);
                }
                uiShadowPastTimer = 5000;
            }else uiShadowPastTimer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer)
        {
            // TODO:
        	// DoCast(killer, SPELL_CONFESSOR_ACHIEVEMENT);

            if (me->isSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    if (summoner->isAlive())
                        summoner->GetAI()->SetData(1, 0);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_memoryAI(creature);
    }
};

class npc_argent_soldier : public CreatureScript
{
public:
    npc_argent_soldier() : CreatureScript("npc_argent_soldier") { }

    // THIS AI NEEDS MORE IMPROVEMENTS
    struct npc_argent_soldierAI : public npc_escortAI
    {
        npc_argent_soldierAI(Creature* creature) : npc_escortAI(creature)
        {
            instance = creature->GetInstanceScript();
            me->SetReactState(REACT_DEFENSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE);
            SetDespawnAtEnd(false);
            uiWaypoint = 0;
        }

        InstanceScript* instance;

        uint8 uiWaypoint;

        uint32 uiStrikeTimer;
        uint32 uiCleaveTimer;
        uint32 uiPummelTimer;
        uint32 uiPainTimer;
        uint32 uiMindTimer;
        uint32 uiSsmiteTimer;
        uint32 uiFontTimer;
        uint32 uiLightTimer;
        uint32 uiFlurryTimer;
        uint32 uiFinalTimer;
        uint32 uiDivineTimer;
        uint32 uiResetTimer;

        void Reset()
        {
            uiStrikeTimer = 4000;
            uiCleaveTimer = 5000;
            uiPummelTimer = 8000;
            uiPainTimer = 6000;
            uiMindTimer = 7000;
            uiSsmiteTimer = 9000;

            uiResetTimer = 3000;
            uiLightTimer = 2000;
            uiFontTimer = 30000;
            uiFlurryTimer = 14000;
            uiFinalTimer = 21000;
            uiDivineTimer = 20000;
        }

        void WaypointReached(uint32 uiPoint)
        {
            if (uiPoint == 0)
            {
                switch (uiWaypoint)
                {
                    case 0:
                        me->SetOrientation(5.81f);
                        break;
                    case 1:
                        me->SetOrientation(4.60f);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        break;
                }
            }

            if (uiPoint == 1)
            {
                switch (uiWaypoint)
                {
                    case 0:
                        me->SetOrientation(5.81f);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        break;
                    case 2:
                        me->SetOrientation(2.79f);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);

                        if (instance)
                            if (GameObject* go = GameObject::GetGameObject(*me, instance->GetData64(DATA_MAIN_GATE)))
                                instance->HandleGameObject(go->GetGUID(), false);
                        break;
                }

                me->SendMovementFlagUpdate();
            }
        }

        void SetData(uint32 uiType, uint32 /*uiData*/)
        {
            switch (me->GetEntry())
            {
                case NPC_ARGENT_LIGHWIELDER:
                    switch (uiType)
                    {
                        case 0:
                            AddWaypoint(0, 737.14f, 655.42f, 412.88f);
                            AddWaypoint(1, 712.14f, 628.42f, 411.88f);
                            break;
                        case 1:
                            AddWaypoint(0, 742.44f, 650.29f, 411.79f);
                            break;
                        case 2:
                            AddWaypoint(0, 756.14f, 655.42f, 411.88f);
                            AddWaypoint(1, 781.626f, 629.383f, 411.892f);
                            break;
                    }
                    break;
                case NPC_ARGENT_MONK:
                    switch (uiType)
                    {
                        case 0:
                            AddWaypoint(0, 737.14f, 655.42f, 412.88f);
                            AddWaypoint(1, 713.12f, 632.97f, 411.90f);
                            break;
                        case 1:
                            AddWaypoint(0, 746.73f, 650.24f, 411.56f);
                            break;
                        case 2:
                            AddWaypoint(0, 756.14f, 655.42f, 411.88f);
                            AddWaypoint(1, 781.351f, 633.146f, 411.907f);
                            break;
                    }
                    break;
                case NPC_PRIESTESS:
                    switch (uiType)
                    {
                        case 0:
                            AddWaypoint(0, 737.14f, 655.42f, 412.88f);
                            AddWaypoint(1, 715.06f, 637.07f, 411.91f);
                            break;
                        case 1:
                            AddWaypoint(0, 750.72f, 650.20f, 411.77f);
                            break;
                        case 2:
                            AddWaypoint(0, 756.14f, 655.42f, 411.88f);
                            AddWaypoint(1, 780.439f, 636.681f, 411.918f);
                            break;
                    }
                    break;
            }

            Start(false, true, 0);
            uiWaypoint = uiType;
        }

        void UpdateAI(const uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;

            switch (me->GetEntry())
            {
                case NPC_ARGENT_LIGHWIELDER:
                {
                    if (IsHeroic())
                    {
                        if (uiCleaveTimer <= uiDiff)
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                               DoCast(target, SPELL_STRIKE_H);

                            uiCleaveTimer = 20000;
                        } else uiCleaveTimer -= uiDiff;
                    }

                    if (uiStrikeTimer <= uiDiff)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(target, SPELL_CLEAVE);

                        uiStrikeTimer = 25000;
                    } else uiStrikeTimer -= uiDiff;
                
                    if (uiLightTimer <= uiDiff)
                    {
                        DoCast(me, DUNGEON_MODE(SPELL_LIGHT, SPELL_LIGHT_H));

                        uiLightTimer = urand(15000, 17000);
                    } else uiLightTimer -= uiDiff;
                    break;
                }
                case NPC_ARGENT_MONK:
                {
                    if (IsHeroic())
                    {
                        if (uiDivineTimer <= uiDiff)
                        {
                            DoCast(me, SPELL_DIVINE_H);

                            uiDivineTimer = 85000;
                        } else uiDivineTimer -= uiDiff;

                        if (uiFinalTimer <= uiDiff)
                        {
                            DoCast(me, SPELL_FINAL_H);

                            uiFinalTimer = 70000;
                        } else uiFinalTimer -= uiDiff;
                    }

                    if (uiPummelTimer <= uiDiff)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(target, SPELL_PUMMEL);

                        uiPummelTimer = 35000;
                    } else uiPummelTimer -= uiDiff;
                
                    if (uiFlurryTimer <= uiDiff)
                    {
                        DoCast(me, SPELL_FLURRY);

                        uiFlurryTimer = 22000;
                    } else uiFlurryTimer -= uiDiff;
                    break;
                }
                case NPC_PRIESTESS:
                {
                    if (uiFontTimer <= uiDiff)
                    {
                        DoCast(me,SPELL_FONT);

                        uiFontTimer = urand(15000, 17000);
                    } else uiFontTimer -= uiDiff;

                    if (uiPainTimer <= uiDiff)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(target, DUNGEON_MODE(SPELL_PAIN, SPELL_PAIN_H));

                        uiPainTimer = 30000;
                    } else uiPainTimer -= uiDiff;

                    if (IsHeroic())
                    {
                        if (uiMindTimer <= uiDiff)
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_MIND_H);

                            uiMindTimer = 90000;
                        } else uiMindTimer -= uiDiff;
                    }

                    if (uiSsmiteTimer <= uiDiff)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(target, DUNGEON_MODE(SPELL_SMITE_ADD, SPELL_SMITE_ADD_H));

                        uiSsmiteTimer = 25000;
                    } else uiSsmiteTimer -= uiDiff;
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            if (instance)
                instance->SetData(DATA_ARGENT_SOLDIER_DEFEATED, instance->GetData(DATA_ARGENT_SOLDIER_DEFEATED) + 1);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_argent_soldierAI(creature);
    }
};

class achievement_toc5_argent_challenge : public AchievementCriteriaScript
{
    public:
        uint32 creature_entry;

        achievement_toc5_argent_challenge(const char* name, uint32 original_entry) : AchievementCriteriaScript(name) {
            creature_entry = original_entry;
        }

        bool OnCheck(Player* source, Unit* target)
        {
            if (!target)
                return false;

            if (Creature* creature = target->ToCreature())
                if (creature->GetOriginalEntry() == creature_entry)
                    return true;

            return false;
        }
};

void AddSC_boss_argent_challenge()
{
    new boss_eadric();
    new spell_eadric_radiance();
    new spell_eadric_hoj();
    new boss_paletress();
    new npc_memory();
    new npc_argent_soldier();
    new achievement_toc5_argent_challenge("achievement_toc5_paletress", NPC_PALETRESS);
    new achievement_toc5_argent_challenge("achievement_toc5_eadric", NPC_EADRIC);
}
