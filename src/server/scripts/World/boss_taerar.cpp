/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
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

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"

/*
 * TODO:
 * - Handle Mark of Nature properly
 * - Fix player tank summoning when wandering off too far
 */

/*
  -- SQL-texts:
  DELETE FROM `creature_text` WHERE `entry`=14890;
  INSERT INTO `creature_text`(`entry`,`groupid`,`text`,`type`,`comment`) VALUES
  (14890,0,'Peace is but a fleeting dream! Let the NIGHTMARE reign!',14,'Taerar - SAY_TAERAR_AGGRO'),
  (14890,1,'Children of Madness - I release you upon this world!',14,'Taerar - SAY_TAERAR_SUMMON_SHADE');
*/

// NOTE: The shade-effect is not 100% verified - seems to be the
// correct one, but doesn't seem to be removed properly o.O

enum DragonSpells
{
    SPELL_TAIL_SWEEP        = 15847,
    SPELL_SUMMON_PLAYER     = 24776,
    SPELL_DREAM_FOG         = 24777,    // 24778 triggers serverside spell 24781
    SPELL_SEEPING_FOG_1     = 24813,    // summon left
    SPELL_SEEPING_FOG_2     = 24814,    // summon right
    SPELL_NOXIOUS_BREATH    = 24818,
    SPELL_MARK_OF_NATURE_T  = 25040,    // Mark of Nature trigger
    SPELL_MARK_OF_NATURE_A  = 25041,    // Mark of Nature aura
    SPELL_AURA_OF_NATURE    = 25043,    // Used in combo with Mark of Nature aura to put player into sleep for 2 minutes, not 4 seconds
};

/* TAERAR */

enum TaerarTexts
{
    SAY_TAERAR_AGGRO        = 0,
    SAY_TAERAR_SUMMON_SHADE = 1,
};

enum TaerarSpells
{
    SPELL_BELLOWING_ROAR    = 22686,
    SPELL_SHADE             = 24313,
    SPELL_SUMMON_SHADE_1    = 24841,
    SPELL_SUMMON_SHADE_2    = 24842,
    SPELL_SUMMON_SHADE_3    = 24843,
    SPELL_ARCANE_BLAST      = 24857,
};

enum TaerarEvents
{
    EVENT_SEEPING_FOG       = 1,
    EVENT_NOXIOUS_BREATH    = 2,
    EVENT_TAIL_SWEEP        = 3,
    EVENT_ARCANE_BLAST      = 4,
    EVENT_BELLOWING_ROAR    = 5,
};

uint32 const shadeSpells[] =
{
    SPELL_SUMMON_SHADE_1, SPELL_SUMMON_SHADE_2, SPELL_SUMMON_SHADE_3
};

class boss_taerar : public CreatureScript
{
    public:
        boss_taerar() : CreatureScript("boss_taerar") { }

        struct boss_taerarAI : public BossAI
        {
            boss_taerarAI(Creature* creature) : BossAI(creature, 0)
            {
                _stage = 0;
                _shades = 0;
                _banished = false;
                _banishedTimer = 0;
            }

            void Reset()
            {
                _Reset();

                _stage = 0;
                _shades = 0;
                _banished = false;
                _banishedTimer = 0;

                me->RemoveAurasDueToSpell(SPELL_SHADE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);

                events.ScheduleEvent(EVENT_SEEPING_FOG, urand(5000, 10000));
                events.ScheduleEvent(EVENT_NOXIOUS_BREATH, 8000);
                events.ScheduleEvent(EVENT_TAIL_SWEEP, 4000);
                events.ScheduleEvent(EVENT_ARCANE_BLAST, 12000);
                events.ScheduleEvent(EVENT_BELLOWING_ROAR, 30000);
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(SAY_TAERAR_AGGRO);
                DoCast(SPELL_MARK_OF_NATURE_A);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                {
                    me->AddAura(SPELL_MARK_OF_NATURE_T, victim);
                }
            }

            void JustSummoned(Creature* shade)
            {
                summons.Summon(shade);
                Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, -10.0f, true);
                if (!target)
                    target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true);
                shade->AI()->AttackStart(target);
            }

            void SummonedCreatureDies(Creature* /*shade*/, Unit* /*killer*/)
            {
                --_shades;
            }

            void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/)
            {
                // At 75, 50 or 25 percent health, we need to activate the shades and go "banished"
                // Note: _stage holds the amount of times they have been summoned
                if (!_banished && !HealthAbovePct(75 - 25 * _stage))
                {
                    _banished = true;
                    _banishedTimer = 60000;

                    me->InterruptNonMeleeSpells(false);
                    DoStopAttack();

                    Talk(SAY_TAERAR_SUMMON_SHADE);

                    int count = sizeof(shadeSpells) / sizeof(uint32);
                    for (int i = 0; i < count; ++i)
                        DoCastVictim(shadeSpells[i], true);
                    _shades += count;

                    DoCast(me, SPELL_SHADE);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_PASSIVE);

                    ++_stage;
                }
            }

            void UpdateAI(uint32 const diff)
            {
                if (!UpdateVictim())
                    return;

                if (me->HasUnitState(UNIT_STAT_CASTING))
                    return;

                if (_banished)
                {
                    // If all three shades are dead, OR it has taken too long, end the current event and get Taerar back into business
                    if (_banishedTimer <= diff || !_shades)
                    {
                        _banished = false;

                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                        me->RemoveAurasDueToSpell(SPELL_SHADE);
                        me->SetReactState(REACT_AGGRESSIVE);
                    // _banishtimer has not expired, and we still have active shades:
                    }
                    else
                        _banishedTimer -= diff;

                    return;
                }

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SEEPING_FOG:
                            DoCast(me, SPELL_SEEPING_FOG_1, true);
                            DoCast(me, SPELL_SEEPING_FOG_2, true);
                            events.ScheduleEvent(EVENT_SEEPING_FOG, urand(8000, 15000));
                            break;
                        case EVENT_NOXIOUS_BREATH:
                            DoCastVictim(SPELL_NOXIOUS_BREATH);
                            events.ScheduleEvent(EVENT_NOXIOUS_BREATH, urand(14000, 20000));
                            break;
                        case EVENT_TAIL_SWEEP:
                            DoCast(me, SPELL_TAIL_SWEEP);
                            events.ScheduleEvent(EVENT_TAIL_SWEEP, 2000);
                            break;
                        case EVENT_ARCANE_BLAST:
                            DoCastVictim(SPELL_ARCANE_BLAST);
                            events.ScheduleEvent(EVENT_ARCANE_BLAST, urand(7000, 12000));
                            break;
                        case EVENT_BELLOWING_ROAR:
                            DoCastVictim(SPELL_BELLOWING_ROAR);
                            events.ScheduleEvent(EVENT_BELLOWING_ROAR, urand(20000, 30000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            bool    _banished;                              // used for shades activation testing
            uint32  _banishedTimer;                         // counter for banishment timeout
            uint8   _shades;                                // keep track of how many shades are dead
            uint8   _stage;                                 // check which "shade phase" we're at (75-50-25 percentage counters)
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_taerarAI(creature);
        }
};

/*
 * Taerars shades
 */

enum ShadeEvents
{
    EVENT_SHADE_POISON_CLOUD    = 1,
    EVENT_SHADE_ACID_BREATH     = 2,
};

enum ShadeSpells
{
    SPELL_POISON_CLOUD          = 24840,
    SPELL_ACID_BREATH           = 20667,
};

class boss_shadeoftaerar : public CreatureScript
{
    public:
        boss_shadeoftaerar() : CreatureScript("boss_shade_of_taerar") { }

        struct boss_shadeoftaerarAI : public ScriptedAI
        {
            boss_shadeoftaerarAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_SHADE_POISON_CLOUD, 30000);
                _events.ScheduleEvent(EVENT_SHADE_ACID_BREATH, 12000);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SHADE_POISON_CLOUD:
                            DoCast(me, SPELL_POISON_CLOUD);
                            _events.ScheduleEvent(EVENT_SHADE_POISON_CLOUD, 30000);
                            break;
                        case EVENT_SHADE_ACID_BREATH:
                            DoCast(me, SPELL_ACID_BREATH);
                            _events.ScheduleEvent(EVENT_SHADE_ACID_BREATH, 12000);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_shadeoftaerarAI(creature);
        }
};

class npc_dream_fog : public CreatureScript
{
    public:
        npc_dream_fog() : CreatureScript("npc_dream_fog") { }

        struct npc_dream_fogAI : public ScriptedAI
        {
            npc_dream_fogAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                me->SetSpeed(MOVE_WALK,2.0f);

                _movementTimer = urand(5000, 7500);
            }

            void UpdateAI(const uint32 diff)
            {
                if (_movementTimer)
                {
                    me->GetMotionMaster()->MoveRandom(25.0f);
                    _movementTimer = urand(5000, 7500);
                    DoCast(me, SPELL_DREAM_FOG);
                }
                else
                    _movementTimer -= diff;
            }

        private:
            uint32  _movementTimer;                         // counter for movement-change
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_dream_fogAI(creature);
        }
};

void AddSC_boss_taerar()
{
    new boss_taerar();
    new boss_shadeoftaerar();
    new npc_dream_fog();
}
