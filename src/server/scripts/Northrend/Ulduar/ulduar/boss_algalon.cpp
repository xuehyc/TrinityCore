/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
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
#include "ulduar.h"

enum Spells
{
    SPELL_ASCEND                    = 64487,
    SPELL_BERSERK                   = 47008,
    SPELL_BIG_BANG_10               = 64443,
    SPELL_BIG_BANG_25               = 64584,
    SPELL_COSMIC_SMASH_10           = 62301,
    SPELL_COSMIC_SMASH_25           = 64598,
    SPELL_PHASE_PUNCH               = 64412,
    SPELL_PHASE_PUNCH_PHASE         = 64417,
    SPELL_QUANTUM_STRIKE_10         = 64395,
    SPELL_QUANTUM_STRIKE_25         = 64592,
    SPELL_BLACK_HOLE_DOT            = 62169,
    SPELL_BLACK_HOLE_EXPLOSION      = 64122,
    SPELL_ARCANE_BARAGE_10          = 64599,
    SPELL_ARCANE_BARAGE_25          = 64607,

    SPELL_BOSS_FINISHED             = 65184,
};

enum Creatures
{
    CREATURE_COLLAPSING_STAR        = 32955,
    CREATURE_BLACK_HOLE             = 32953,
    CREATURE_LIVING_CONSTELLATION   = 33052,
    CREATURE_DARK_MATTER            = 33089
};

enum Yells
{
    SAY_AGGRO                                   = -1603000,
    SAY_SLAY_1                                  = -1603001,
    SAY_SLAY_2                                  = -1603002,
    SAY_ENGAGED_FOR_FIRST_TIME                  = -1603003,
    SAY_PHASE_2                                 = -1603004,
    SAY_SUMMON_COLLAPSING_STAR                  = -1603005,
    SAY_DEATH_1                                 = -1603006,
    SAY_DEATH_2                                 = -1603007,
    SAY_DEATH_3                                 = -1603008,
    SAY_DEATH_4                                 = -1603009,
    SAY_DEATH_5                                 = -1603010,
    SAY_BERSERK                                 = -1603011,
    SAY_BIG_BANG_1                              = -1603012,
    SAY_BIG_BANG_2                              = -1603013,
    SAY_TIMER_1                                 = -1603014,
    SAY_TIMER_2                                 = -1603015,
    SAY_TIMER_3                                 = -1603016,
    SAY_SUMMON_1                                = -1603017,
    SAY_SUMMON_2                                = -1603018,
    SAY_SUMMON_3                                = -1603019,
};

enum Events
{
    EVENT_NONE,
    EVENT_ASCEND,
    EVENT_BERSERK,
    EVENT_BIGBANG,
    EVENT_COSMICSMASH,
    EVENT_PHASEPUNCH,
    EVENT_QUANTUMSTRIKE,
    EVENT_COLLAPSINGSTAR,
};

class boss_algalon : public CreatureScript
{
public:
    boss_algalon() : CreatureScript("boss_algalon") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_algalonAI(pCreature);
    }

    struct boss_algalonAI : public BossAI
    {
        boss_algalonAI(Creature* c) : BossAI(c, TYPE_ALGALON)
        {
            summon = false;
        }

        std::list<uint64> m_lCollapsingStarGUIDList;

        uint32 phase;
        uint32 stepTimer;
        uint32 step;
        bool enrage;
        bool summon;

        void Reset()
        {
            _Reset();
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

            phase = 1;
            stepTimer = 0;
            enrage = false;
        }

        void EnterCombat(Unit* who)
        {
            _EnterCombat();

            if (summon)
            {
                me->InterruptSpell(CURRENT_CHANNELED_SPELL);
                DoZoneInCombat(who->ToCreature());
            }
            else
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_PASSIVE);
                step = 1;
            }

            //events.ScheduleEvent(EVENT_ASCEND, 8*MINUTE*IN_MILLISECONDS);
            //events.ScheduleEvent(EVENT_BERSERK, 6*MINUTE*IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_BIGBANG, 90*IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_PHASEPUNCH, 15*IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_QUANTUMSTRIKE, urand(4*IN_MILLISECONDS, 14*IN_MILLISECONDS));
            events.ScheduleEvent(EVENT_COSMICSMASH, 25*IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_COLLAPSINGSTAR, urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS));
        }

        void FinishEncounter()
        {
            instance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_BOSS_FINISHED);
        }

        void KilledUnit(Unit * /*victim*/)
        {
            DoScriptText(RAND(SAY_SLAY_1, SAY_SLAY_2), me);
        }

        void JumpToNextStep(uint32 timer)
        {
            stepTimer = timer;
            ++step;
        }

        /*
        void DespawnCollapsingStar()
        {
            if (m_lCollapsingStarGUIDList.empty())
                return;

            for (std::list<uint64>::const_iterator itr = m_lCollapsingStarGUIDList.begin(); itr != m_lCollapsingStarGUIDList.end(); ++itr)
            {
                if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                {
                    if (pTemp->isAlive())
                        pTemp->DespawnOrUnsummon();
                }
            }
            m_lCollapsingStarGUIDList.clear();
        }
        void JustSummoned(Creature* pSummoned)
        {
            if (pSummoned->GetEntry() == CREATURE_COLLAPSING_STAR)
            {
                Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0);
                if (me->getVictim())
                    pSummoned->AI()->AttackStart(pTarget ? pTarget : me->getVictim());
                m_lCollapsingStarGUIDList.push_back(pSummoned->GetGUID());
            }
        }
        void SummonCollapsingStar(Unit* target)
        {
            DoScriptText(SAY_SUMMON_COLLAPSING_STAR, me);
            me->SummonCreature(CREATURE_COLLAPSING_STAR,target->GetPositionX()+15.0f,target->GetPositionY()+15.0f,target->GetPositionZ(),0, TEMPSUMMON_TIMED_DESPAWN, 100000);
            //me->SummonCreature(CREATURE_BLACK_HOLE,target->GetPositionX()+15.0f,target->GetPositionY()+15.0f,target->GetPositionZ(),0, TEMPSUMMON_TIMED_DESPAWN, 27000);
        }*/

        void SpellHitTarget(Unit* target, const SpellEntry* spell)
        {
            if (spell->Id == SPELL_PHASE_PUNCH)
                if (Aura* phasePunch = target->GetAura(SPELL_PHASE_PUNCH))
                    if (phasePunch->GetStackAmount() > 4)
                    {
                        target->CastSpell(target, SPELL_PHASE_PUNCH_PHASE, true);
                        target->CastSpell(target, SPELL_BLACK_HOLE_DOT, true);
                        target->RemoveAurasDueToSpell(SPELL_PHASE_PUNCH);
                    }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (phase == 1 && HealthBelowPct(20))
            {
                phase = 2;
                DoScriptText(SAY_PHASE_2, me);
            }

            if (HealthBelowPct(2))
            {
                me->SummonGameObject(GO_GIFT_OF_THE_OBSERVER, 1634.258667f, -295.101166f,417.321381f,0,0,0,0,0,0);

                // All of them. or random?
                DoScriptText(SAY_DEATH_1, me);
                DoScriptText(SAY_DEATH_2, me);
                DoScriptText(SAY_DEATH_3, me);
                DoScriptText(SAY_DEATH_4, me);
                DoScriptText(SAY_DEATH_5, me);

                me->DisappearAndDie();
                _JustDied();

                return;
            }

            if (phase == 1)
            {
                if (!summon)
                {
                    if (stepTimer <= diff)
                    {
                        switch (step)
                        {
                            case 1:
                                DoScriptText(SAY_SUMMON_1, me);
                                JumpToNextStep(7500);
                                break;
                            case 2:
                                DoScriptText(SAY_SUMMON_2, me);
                                JumpToNextStep(6000);
                                break;
                            case 3:
                                DoScriptText(SAY_SUMMON_3, me);
                                JumpToNextStep(11000);
                                break;
                            case 4:
                                DoScriptText(SAY_ENGAGED_FOR_FIRST_TIME, me);
                                JumpToNextStep(11000);
                                break;
                            case 5:
                                DoScriptText(SAY_AGGRO, me);
                                JumpToNextStep(7000);
                                break;
                            case 6:
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                me->SetReactState(REACT_AGGRESSIVE);
                                summon = true;
                                break;
                        }
                    } else stepTimer -= diff;
                    return;
                }

                _DoAggroPulse(diff);
                events.Update(diff);

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_BIGBANG:
                            DoScriptText(RAND(SAY_BIG_BANG_1, SAY_BIG_BANG_2), me);
                            DoCast(me->getVictim(), RAID_MODE(SPELL_BIG_BANG_10, SPELL_BIG_BANG_25));
                            events.ScheduleEvent(EVENT_BIGBANG, 90*IN_MILLISECONDS);
                            break;
                        case EVENT_PHASEPUNCH:
                            DoCast(me->getVictim(), SPELL_PHASE_PUNCH, true);
                            events.ScheduleEvent(EVENT_PHASEPUNCH, 15*IN_MILLISECONDS);
                            break;
                        case EVENT_QUANTUMSTRIKE:
                            DoCast(me->getVictim(), RAID_MODE(SPELL_QUANTUM_STRIKE_10, SPELL_QUANTUM_STRIKE_25));
                            events.ScheduleEvent(EVENT_QUANTUMSTRIKE, urand(4*IN_MILLISECONDS, 14*IN_MILLISECONDS));
                            break;
                        case EVENT_COSMICSMASH:
                            DoCast(SelectTarget(SELECT_TARGET_RANDOM, 0), RAID_MODE(SPELL_COSMIC_SMASH_10, SPELL_COSMIC_SMASH_25));
                            events.ScheduleEvent(EVENT_COSMICSMASH, 25*IN_MILLISECONDS);
                            break;
                        case EVENT_COLLAPSINGSTAR:
                            //SummonCollapsingStar(Unit* target)
                            events.ScheduleEvent(EVENT_COLLAPSINGSTAR, urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS));
                            break;
                        default:
                            break;
                    }
                }   

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea(diff);
            }

            if (phase == 2)
            {
                if (enrage)
                {
                    //if (Ascend_Timer <= diff)
                    //{
                        DoCast(me, SPELL_ASCEND);
                        DoScriptText(SAY_BERSERK, me);
                        //Ascend_Timer = urand(360000,365000);
                        enrage = true;
                    //} else Ascend_Timer -= diff;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

//Collapsing Star
class mob_collapsing_star : public CreatureScript
{
public:
    mob_collapsing_star() : CreatureScript("mob_collapsing_star") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new mob_collapsing_starAI(pCreature);
    }

    struct mob_collapsing_starAI : public ScriptedAI
    {
        mob_collapsing_starAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;

        uint32 BlackHoleExplosion_Timer;

        void Reset()
        {
            BlackHoleExplosion_Timer = 0;
        }

        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (BlackHoleExplosion_Timer <= diff)
            {
                me->CastSpell(me, SPELL_BLACK_HOLE_EXPLOSION, false);
                BlackHoleExplosion_Timer = 0;
            } else BlackHoleExplosion_Timer -= diff;
        }
    };
};

class go_planetarium_access : public GameObjectScript
{
public:
    go_planetarium_access() : GameObjectScript("go_planetarium_access") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        InstanceScript* pInstance = go->GetInstanceScript();

        if (player->HasItemCount(45796, 1) || player->HasItemCount(45798, 1))
        {
            pInstance->SetBossState(TYPE_ALGALON, SPECIAL);
            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_UNK1);
            go->SetGoState(GO_STATE_ACTIVE);
        }
        return true;
    }
};

void AddSC_boss_algalon()
{
    new boss_algalon();
    new mob_collapsing_star();
    new go_planetarium_access();
}
