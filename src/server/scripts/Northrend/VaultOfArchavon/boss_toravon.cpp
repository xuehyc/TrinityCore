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

/*** SQL START ***
UPDATE `creature_template` SET `ScriptName`='boss_toravon' WHERE `entry`='38433';
UPDATE `creature_template` SET `ScriptName`='mob_frost_warder' WHERE `entry`='38482';
UPDATE `creature_template` SET `ScriptName`='mob_frozen_orb_stalker' WHERE `entry`='38461';
UPDATE `creature_template` SET `ScriptName`='mob_frozen_orb' WHERE `entry`='38456';
*** SQL END ***/

#include "ScriptPCH.h"
#include "vault_of_archavon.h"

// Spells Toravon
#define SPELL_FREEZING_GROUND   RAID_MODE(72090,72104)  // don't know cd... using 20 secs.
#define SPELL_WHITEOUT          RAID_MODE(72034,72096)  // Every 38 sec. cast. (after SPELL_FROZEN_ORB)
#define SPELL_FROZEN_MALLET     RAID_MODE(72122, 71993)

// Spells Frost Warder
#define SPELL_FROST_BLAST   RAID_MODE(72123,72124)      // don't know cd... using 20 secs.

// Spell Frozen Orb
#define SPELL_FROZEN_ORB_DMG    72081   // priodic dmg aura
#define SPELL_FROZEN_ORB_AURA   72067   // make visible

// Events boss
enum Events
{
    EVENT_FREEZING_GROUND   = 1,
    EVENT_FROZEN_ORB        = 2,
    EVENT_WHITEOUT          = 3,

    EVENT_FROST_BLAST       = 4,
};

// Mob Frozen Orb
#define MOB_FROZEN_ORB 38456    // 1 in 10 mode and 3 in 25 mode

class boss_toravon : public CreatureScript
{
    public:
        boss_toravon() : CreatureScript("boss_toravon") { }

        struct boss_toravonAI : public BossAI
        {
            boss_toravonAI(Creature* creature) : BossAI(creature, DATA_TORAVON)
            {
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoCast(me, SPELL_FROZEN_MALLET);

                events.ScheduleEvent(EVENT_FROZEN_ORB, 11000);
                events.ScheduleEvent(EVENT_WHITEOUT, 13000);
                events.ScheduleEvent(EVENT_FREEZING_GROUND, 15000);

                _EnterCombat();
            }

            void UpdateAI(const uint32 diff)
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
                        case EVENT_FROZEN_ORB:
                            for (uint8 i = 0; i < RAID_MODE(1,3); i++)
                            {
                                Position NearPos;
                                me->GetNearPosition(NearPos, 10.0f, 0.0f);
                                me->SummonCreature(MOB_FROZEN_ORB, NearPos, TEMPSUMMON_CORPSE_DESPAWN);
                            }
                            events.ScheduleEvent(EVENT_FROZEN_ORB, 38000);
                            break;
                        case EVENT_WHITEOUT:
                            DoCast(me, SPELL_WHITEOUT);
                            events.ScheduleEvent(EVENT_WHITEOUT, 38000);
                            break;
                        case EVENT_FREEZING_GROUND:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                                DoCast(target, SPELL_FREEZING_GROUND);
                            events.ScheduleEvent(EVENT_FREEZING_GROUND, 20000);
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_toravonAI(creature);
        }
};

/*######
##  Mob Frost Warder
######*/
class mob_frost_warder : public CreatureScript
{
    public:
        mob_frost_warder() : CreatureScript("mob_frost_warder") { }

        struct mob_frost_warderAI : public ScriptedAI
        {
            mob_frost_warderAI(Creature* c) : ScriptedAI(c) {}

            void Reset()
            {
                events.Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                DoZoneInCombat();

                DoCast(me, SPELL_FROZEN_MALLET);

                events.ScheduleEvent(EVENT_FROST_BLAST, 5000);
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (events.ExecuteEvent() == EVENT_FROST_BLAST)
                {
                    DoCastVictim(SPELL_FROST_BLAST);
                    events.ScheduleEvent(EVENT_FROST_BLAST, 20000);
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new mob_frost_warderAI(creature);
        }
};


/*######
##  Mob Frozen Orb
######*/
class mob_frozen_orb : public CreatureScript
{
public:
    mob_frozen_orb() : CreatureScript("mob_frozen_orb") { }

    struct mob_frozen_orbAI : public ScriptedAI
    {
        mob_frozen_orbAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void Reset()
        {
            done = false;
            killTimer = 60000; // if after this time there is no victim -> destroy!
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoZoneInCombat();
        }

        void UpdateAI(const uint32 diff)
        {
            if (!done)
            {
                DoCast(me, SPELL_FROZEN_ORB_AURA, true);
                DoCast(me, SPELL_FROZEN_ORB_DMG, true);
                done = true;
            }

            if (killTimer <= diff)
            {
                if (!UpdateVictim())
                    me->DespawnOrUnsummon();
                killTimer = 10000;
            }
            else
                killTimer -= diff;
        }

    private:
        uint32 killTimer;
        bool done;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_frozen_orbAI(creature);
    }
};

void AddSC_boss_toravon()
{
    new boss_toravon();
    new mob_frost_warder();
    new mob_frozen_orb();
}
