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

/* Script Data Start
SDName: Boss malygos
Script Data End */

// TO-DOs:
// Implement a better pathing for Malygos.
// Find sniffed spawn position for chest
// Implement a better way to disappear the gameobjects
// Implement achievements
// Remove hack that re-adds targets to the aggro list after they enter to a vehicle when it works as expected
// Improve whatever can be improved :)

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "PassiveAI.h"
#include "eye_of_eternity.h"
#include "ScriptedEscortAI.h"
#include "Vehicle.h"

enum Achievements
{
    ACHIEV_TIMED_START_EVENT                      = 20387,

    ACHIEV_POKE_IN_THE_EYE                        = 1869,
    ACHIEV_POKE_IN_THE_EYE_H                      = 1870,
    ACHIEV_POKE_IN_THE_EYE_COUNT                  = 9,
    ACHIEV_POKE_IN_THE_EYE_H_COUNT                = 21,
};

enum Events
{
    // =========== PHASE ONE ===============
    EVENT_ARCANE_BREATH = 1,
    EVENT_ARCANE_STORM  = 2,
    EVENT_VORTEX        = 3,
    EVENT_POWER_SPARKS  = 4,

    // =========== PHASE TWO ===============
    EVENT_SURGE_POWER   = 5, // wowhead is wrong, Surge of Power is casted instead of Arcane Pulse (source sniffs!)
    EVENT_SUMMON_ARCANE = 6,
    EVENT_DEEP_BREATH = 7,

    // =========== PHASE TWO ===============
    EVENT_SURGE_POWER_PHASE_3 = 8,
    EVENT_STATIC_FIELD = 9,

    // =============== YELLS ===============
    EVENT_YELL_0 = 10,
    EVENT_YELL_1 = 11,
    EVENT_YELL_2 = 12,
    EVENT_YELL_3 = 13,
    EVENT_YELL_4 = 14,
};

enum Phases
{
    PHASE_ONE = 1,
    PHASE_TWO = 2,
    PHASE_THREE = 3
};

enum Spells
{
    SPELL_ARCANE_BREATH = 56272,
    SPELL_ARCANE_STORM  = 57459,
    SPELL_BERSEKER      = 60670,
    SPELL_BERSEKER_EFFECT = 61715,

    SPELL_VORTEX_1 = 56237, // seems that frezze object animation
    SPELL_VORTEX_2 = 55873, // visual effect
    SPELL_VORTEX_3 = 56105, // this spell must handle all the script - casted by the boss and to himself
    //SPELL_VORTEX_4 = 55853, // damage | used to enter to the vehicle - defined in eye_of_eternity.h
    //SPELL_VORTEX_5 = 56263, // damage | used to enter to the vehicle - defined in eye_of_eternity.h
    SPELL_VORTEX_6 = 73040, // teleport - (casted to all raid) | caster 30090 | target player

    SPELL_SUMMON_POWER_PARK = 56142,
    SPELL_POWER_SPARK_VISUAL = 55845,
    SPELL_POWER_SPARK_DEATH = 55852,
    SPELL_POWER_SPARK_DEATH_TRIGGERED = 55849,
    SPELL_POWER_SPARK_MALYGOS = 56152,

    SPELL_SUMMON_ARCANE_BOMB = 56429,
    SPELL_ARCANE_OVERLOAD = 56432,
    SPELL_ARCANE_OVERLOAD_TRIGGERED = 56438,
    SPELL_SUMMOM_RED_DRAGON = 56070,
    SPELL_SURGE_POWER = 57407,
    SPELL_STATIC_FIELD = 57430,
    SPELL_VISUAL_HACK_SACRED_SHIELD_TEMP = 70491
};

enum Movements
{
    MOVE_VORTEX = 1,
    MOVE_PHASE_TWO,
    MOVE_DEEP_BREATH_ROTATION,
    MOVE_INIT_PHASE_ONE,
    MOVE_CENTER_PLATFORM
};

enum Seats
{
    SEAT_0 = 0,
};

enum Factions
{
    FACTION_FRIENDLY = 35,
    FACTION_HOSTILE = 14
};

enum MalygosEvents
{
    DATA_SUMMON_DEATHS, // phase 2
    DATA_PHASE
};

#define TEN_MINUTES 600000

enum MalygosSays
{
    SAY_AGGRO_P_ONE,
    SAY_KILLED_PLAYER_P_ONE,
    SAY_END_P_ONE,
    SAY_AGGRO_P_TWO,
    SAY_ANTI_MAGIC_SHELL, // not sure when execute it
    SAY_MAGIC_BLAST,  // not sure when execute it
    SAY_KILLED_PLAYER_P_TWO,
    SAY_END_P_TWO,
    SAY_INTRO_P_THREE,
    SAY_AGGRO_P_THREE,
    SAY_SURGE_POWER,  // not sure when execute it
    SAY_BUFF_SPARK,
    SAY_KILLED_PLAYER_P_THREE,
    SAY_SPELL_CASTING_P_THREE,
    SAY_DEATH,
    WHISPER_SURGE
};

#define EMOTE_CUSTOM_SURGE         -1999801

#define MAX_HOVER_DISK_WAYPOINTS 18

// Sniffed data (x, y,z)
const Position HoverDiskWaypoints[MAX_HOVER_DISK_WAYPOINTS] =
{
   {782.9821f, 1296.652f, 282.1114f, 0.0f},
   {779.5459f, 1287.228f, 282.1393f, 0.0f},
   {773.0028f, 1279.52f, 282.4164f, 0.0f},
   {764.3626f, 1274.476f, 282.4731f, 0.0f},
   {754.3961f, 1272.639f, 282.4171f, 0.0f},
   {744.4422f, 1274.412f, 282.222f, 0.0f},
   {735.575f, 1279.742f, 281.9674f, 0.0f},
   {729.2788f, 1287.187f, 281.9943f, 0.0f},
   {726.1191f, 1296.688f, 282.2997f, 0.0f},
   {725.9396f, 1306.531f, 282.2448f, 0.0f},
   {729.3045f, 1316.122f, 281.9108f, 0.0f},
   {735.8322f, 1323.633f, 282.1887f, 0.0f},
   {744.4616f, 1328.999f, 281.9948f, 0.0f},
   {754.4739f, 1330.666f, 282.049f, 0.0f},
   {764.074f, 1329.053f, 281.9949f, 0.0f},
   {772.8409f, 1323.951f, 282.077f, 0.0f},
   {779.5085f, 1316.412f, 281.9145f, 0.0f},
   {782.8365f, 1306.778f, 282.3035f, 0.0f},
};

#define GROUND_Z 268

// Source: Sniffs (x, y,z)
#define MALYGOS_MAX_WAYPOINTS 16
const Position MalygosPhaseTwoWaypoints[MALYGOS_MAX_WAYPOINTS] =
{
    {812.7299f, 1391.672f, 283.2763f, 0.0f},
    {848.2912f, 1358.61f, 283.2763f, 0.0f},
    {853.9227f, 1307.911f, 283.2763f, 0.0f},
    {847.1437f, 1265.538f, 283.2763f, 0.0f},
    {839.9229f, 1245.245f, 283.2763f, 0.0f},
    {827.3463f, 1221.818f, 283.2763f, 0.0f},
    {803.2727f, 1203.851f, 283.2763f, 0.0f},
    {772.9372f, 1197.981f, 283.2763f, 0.0f},
    {732.1138f, 1200.647f, 283.2763f, 0.0f},
    {693.8761f, 1217.995f, 283.2763f, 0.0f},
    {664.5038f, 1256.539f, 283.2763f, 0.0f},
    {650.1497f, 1303.485f, 283.2763f, 0.0f},
    {662.9109f, 1350.291f, 283.2763f, 0.0f},
    {677.6391f, 1377.607f, 283.2763f, 0.0f},
    {704.8198f, 1401.162f, 283.2763f, 0.0f},
    {755.2642f, 1417.1f, 283.2763f, 0.0f},
};

#define MAX_MALYGOS_POS 2
const Position MalygosPositions[MAX_MALYGOS_POS] =
{
    {754.544f, 1301.71f, 320.0f, 0.0f},
    {754.39f, 1301.27f, 292.91f, 0.0f},
};

const Position CentergroundPosition = {754.544f, 1301.71f, GROUND_Z};

class boss_malygos : public CreatureScript
{
public:
    boss_malygos() : CreatureScript("boss_malygos") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_malygosAI(creature);
    }

    struct boss_malygosAI : public BossAI
    {
        boss_malygosAI(Creature* creature) : BossAI(creature, DATA_MALYGOS_EVENT)
        {
            // If we enter in combat when MovePoint generator is active, it overrwrites our homeposition
            _homePosition = creature->GetHomePosition();
        }

        void Reset()
        {
            _Reset();

            _bersekerTimer = 0;
            _currentPos = 0;

            SetPhase(PHASE_ONE, true);

            _delayedMovementTimer = 8000;
            _delayedMovement = false;

            _summonDeaths = 0;

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

            _cannotMove = true;

            me->SetCanFly(true);

            powerSparkBuffCount = 0;
            powerSparkBuffTimer = 10000;
            powerSparkBuffTimerEnabled = false;

            deepBreathCount = 0;

            updateOrientationPhase2 = false;
            updateOrientationPhase3 = false;
            targetGuid1 = 0;
            targetGuid2 = 0;
            targetGuid3 = 0;
            summonGuid1 = 0;
            summonGuid2 = 0;

            participants.clear();

            std::list<Creature*> despawnCreatureList;
            me->GetCreatureListWithEntryInGrid(despawnCreatureList, NPC_ARCANE_OVERLOAD, 250.0f);

            if (!despawnCreatureList.empty())
            {
                for (std::list<Creature*>::const_iterator itr = despawnCreatureList.begin(); itr != despawnCreatureList.end(); ++itr)
                {
                    if (Creature* creature = (*itr))
                    {
                        creature->DespawnOrUnsummon();
                    }
                }
            }

            if (instance)
                instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
        }

        uint32 GetData(uint32 data)
        {
            if (data == DATA_SUMMON_DEATHS)
                return _summonDeaths;
            else if (data == DATA_PHASE)
                return _phase;

            return 0;
        }

        void SetData(uint32 data, uint32 value)
        {
            if (data == DATA_SUMMON_DEATHS && _phase == PHASE_TWO && value < 20)
            {
                _summonDeaths = value;

                if (_summonDeaths >= RAID_MODE(4, 12))
                    StartPhaseThree();
            }
        }

        void EnterEvadeMode()
        {
            bool foundtarget = false;

            if (me->GetMap())
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();

                if (me->GetMap()->IsDungeon() && !players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* player = itr->getSource();
                        if (player && !player->isGameMaster() && player->isAlive())
                        {
                            foundtarget = true;

                            me->SetInCombatWith(player);
                            player->SetInCombatWith(me);
                            me->AddThreat(player, 0.0f);

                            if (Vehicle* pVehicle = player->GetVehicle())
                            {
                                if (Unit* vehicleCreature = pVehicle->GetBase())
                                {
                                    me->SetInCombatWith(vehicleCreature);
                                    vehicleCreature->SetInCombatWith(me);
                                    me->AddThreat(vehicleCreature, 0.0f);
                                }
                            }
                        }
                    }
                }
            }

            if (foundtarget)
                return;

            me->SetHomePosition(_homePosition);

            me->SetDisableGravity(true);

            BossAI::EnterEvadeMode();

            if (instance)
                instance->SetBossState(DATA_MALYGOS_EVENT, FAIL);
        }

        void SetPhase(uint8 phase, bool setEvents = false)
        {
            events.Reset();

            events.SetPhase(phase);
            _phase = phase;

            if (setEvents)
                SetPhaseEvents();
        }

        void StartPhaseThree()
        {
            if (!instance)
                return;

            SetPhase(PHASE_THREE, true);

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

            // this despawns Hover Disks
            summons.DespawnAll();
            // players that used Hover Disk are no in the aggro list
            me->SetInCombatWithZone();
            std::list<HostileReference*> &m_threatlist = me->getThreatManager().getThreatList();
            for (std::list<HostileReference*>::const_iterator itr = m_threatlist.begin(); itr!= m_threatlist.end(); ++itr)
            {
                if (Unit* target = (*itr)->getTarget())
                {
                    if (target->GetTypeId() != TYPEID_PLAYER)
                        continue;

                    // The rest is handled in the AI of the vehicle.
                    target->CastSpell(target, SPELL_SUMMOM_RED_DRAGON, true);
                }
            }

            if (GameObject* go = GameObject::GetGameObject(*me, instance->GetData64(DATA_PLATFORM)))
            {
                go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED); // In sniffs it has this flag, but i don't know how is applied.
                go->EnableCollision(false);
            }

            // pos sniffed
            me->GetMotionMaster()->MoveIdle();
            me->GetMotionMaster()->MovePoint(MOVE_CENTER_PLATFORM, MalygosPositions[0].GetPositionX(), MalygosPositions[0].GetPositionY(), MalygosPositions[0].GetPositionZ());
        }

        void SetPhaseEvents()
        {
            switch (_phase)
            {
                case PHASE_ONE:
                    events.ScheduleEvent(EVENT_ARCANE_BREATH, urand(15, 20)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_ARCANE_STORM, urand(5, 10)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_VORTEX, urand(30, 40)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_POWER_SPARKS, urand(30, 35)*IN_MILLISECONDS, 0, _phase);
                    break;
                case PHASE_TWO:
                    events.ScheduleEvent(EVENT_YELL_0, 0, 0, _phase);
                    events.ScheduleEvent(EVENT_YELL_1, 24*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_SURGE_POWER, urand(60, 70)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_SUMMON_ARCANE, urand(2, 5)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_DEEP_BREATH, urand(35, 45)*IN_MILLISECONDS, 0, _phase);
                    break;
                case PHASE_THREE:
                    events.ScheduleEvent(EVENT_YELL_2, 0, 0, _phase);
                    events.ScheduleEvent(EVENT_YELL_3, 8*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_YELL_4, 16*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_SURGE_POWER_PHASE_3, urand(7, 16)*IN_MILLISECONDS, 0, _phase);
                    events.ScheduleEvent(EVENT_STATIC_FIELD, urand(20, 30)*IN_MILLISECONDS, 0, _phase);
                    break;
                default:
                    break;
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();

            me->SetDisableGravity(false);
            me->SetCanFly(false);

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

            Talk(SAY_AGGRO_P_ONE);

            DoCast(SPELL_BERSEKER); // periodic aura, first tick in 10 minutes

            if (instance)
            {
                instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);

                // Remember players that were in Zone when combat started, relevant for Poke in the Eye Achievement
                Map* _map = me->GetMap();
                Map::PlayerList const& _playerList = _map->GetPlayers();

                for (Map::PlayerList::const_iterator itr = _playerList.begin(); itr != _playerList.end(); ++itr)
                {
                    if (Player* player = itr->getSource())
                    {
                        if (player->isGameMaster())
                            continue;

                        participants.push_back(player->GetGUID());
                    }
                }

            }

        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            switch (_phase)
            {
                case PHASE_ONE:
                    Talk(SAY_KILLED_PLAYER_P_ONE);
                    break;
                case PHASE_TWO:
                    Talk(SAY_KILLED_PLAYER_P_TWO);
                    break;
                case PHASE_THREE:
                    Talk(SAY_KILLED_PLAYER_P_THREE);
                    break;
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_POWER_SPARK_MALYGOS)
            {
                if (Creature* creature = caster->ToCreature())
                    creature->DespawnOrUnsummon();

                Talk(SAY_BUFF_SPARK);
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!me->isInCombat())
                return;

            if (who->GetEntry() == NPC_POWER_SPARK && !who->HasAura(SPELL_POWER_SPARK_DEATH))
            {
                // not sure about the distance | I think it is better check this here than in the UpdateAI function...
                if (who->GetDistance(me) <= 2.5f)
                {
                    powerSparkBuffCount++;
                    powerSparkBuffTimer = 10000;
                    powerSparkBuffTimerEnabled = true;

                    who->CastSpell(me, SPELL_POWER_SPARK_MALYGOS, true);
                }
            }
        }

        void PrepareForVortex()
        {
            me->SetDisableGravity(true);
            me->SetCanFly(true);

            me->GetMotionMaster()->MovementExpired();
            me->GetMotionMaster()->MovePoint(MOVE_VORTEX, MalygosPositions[1].GetPositionX(), MalygosPositions[1].GetPositionY(), MalygosPositions[1].GetPositionZ());
            // continues in MovementInform function.
        }

        void DamageTaken(Unit* attacker, uint32& damage)
        {
            // Attacker has the damage increasing aura - damage value already increased - search for further Power Sparks nearby
            if (attacker->HasAura(SPELL_POWER_SPARK_DEATH_TRIGGERED))
            {
                std::list<Creature*> sparkCreatureList;
                attacker->GetCreatureListWithEntryInGrid(sparkCreatureList, NPC_POWER_SPARK, 8.0f);

                if (!sparkCreatureList.empty())
                {
                    uint8 count = sparkCreatureList.size();

                    if (count >= 1)
                    {
                        // We have at least one power spark in rage - recalculate damage values
                        uint32 basedamage = (uint32)(0.66f * damage);

                        if (attacker->GetTypeId() == TYPEID_PLAYER && count > 1)
                            attacker->SendSpellNonMeleeDamageLog(me, 5176, (uint32)((basedamage * (1 + (count * 0.5f))) - (basedamage * 1.5f)), SPELL_SCHOOL_MASK_NORMAL, 0, 0, true, 0, false);

                        damage = (uint32)(basedamage * (1 + (count * 0.5f)));
                    }
                }
            }
        }

        void DamageDealt(Unit* victim, uint32& damage, DamageEffectType /*damageType*/)
        {
            if (me->HasAura(SPELL_POWER_SPARK_MALYGOS) && powerSparkBuffCount >= 1)
            {
                uint32 basedamage = (uint32)(0.66f * damage);

                if (victim->GetTypeId() == TYPEID_PLAYER && powerSparkBuffCount > 1)
                    me->SendSpellNonMeleeDamageLog(victim, 5176, (uint32)((basedamage * (1 + (powerSparkBuffCount * 0.5f))) - (basedamage * 1.5f)), SPELL_SCHOOL_MASK_NORMAL, 0, 0, true, 0, false);

                damage = (uint32)(basedamage * (1 + (powerSparkBuffCount * 0.5f)));
            }
        }

        void DoSimulateDeepBreath()
        {
            if (me->GetMap())
            {
                Map::PlayerList const& players = me->GetMap()->GetPlayers();

                if (me->GetMap()->IsDungeon() && !players.isEmpty())
                {
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                    {
                        Player* player = itr->getSource();

                        // Only apply to alive and not disk flying players
                        if (player && !player->isGameMaster() && player->isAlive() && !player->GetVehicle())
                        {
                            int32 dmg = 0;

                            if (player->HasAura(SPELL_ARCANE_OVERLOAD_TRIGGERED))
                                dmg = 2500;
                            else
                                dmg = 5000;

                            if (me->HasAura(SPELL_BERSEKER_EFFECT))
                            {
                                dmg = dmg * 10;
                            }

                            me->DealDamage(player, dmg);
                            me->SendSpellNonMeleeDamageLog(player, 5176, dmg, SPELL_SCHOOL_MASK_NORMAL, 0, 0, true, 0, false);
                        }
                    }
                }
            }
        }

        void DoSimulateSurge(uint8 count)
        {
            for (uint8 i = 0; i < count; i++)
            {
                if (Unit* target = GetTargetPhaseThree(true))
                {
                    if (Creature* trigger = me->SummonCreature(NPC_SURGE_TRIGGER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 7000))
                    {
                        if (me->HasAura(SPELL_BERSEKER_EFFECT))
                        {
                            me->AddAura(SPELL_BERSEKER_EFFECT, trigger);
                        }

                        // Send whisper to vehicle riding player
                        if (target->GetVehicleKit())
                            if (target->GetVehicleKit()->GetPassenger(0) && target->GetVehicleKit()->GetPassenger(0)->GetTypeId() == TYPEID_PLAYER)
                                Talk(WHISPER_SURGE, target->GetVehicleKit()->GetPassenger(0)->GetGUID());

                        if (i == 0)
                        {
                            summonGuid1 = trigger->GetGUID();
                            targetGuid2 = target->GetGUID();
                        }
                        else if (i == 1)
                        {
                            summonGuid2 = trigger->GetGUID();
                            targetGuid3 = target->GetGUID();
                        }

                        me->SetInCombatWith(target);
                        me->SetFacingToObject(target);
                        trigger->GetMotionMaster()->MoveIdle();
                        trigger->CastSpell(target, SPELL_SURGE_POWER, true);
                    }
                }
            }
        }

        void DoSummonArcaneBomb()
        {
            if (Creature* trigger = me->SummonCreature(NPC_SURGE_TRIGGER, CentergroundPosition, TEMPSUMMON_TIMED_DESPAWN, 2000))
            {
                Position RandomPos;
                trigger->GetRandomNearPosition(RandomPos, 40.0f);

                trigger->NearTeleportTo(RandomPos.GetPositionX(), RandomPos.GetPositionY(), RandomPos.GetPositionZ(), 0.0f, false);
                trigger->CastSpell(trigger, SPELL_SUMMON_ARCANE_BOMB, true);
            }
        }

        void ExecuteVortex()
        {
            DoCast(me, SPELL_VORTEX_1, true);
            DoCast(me, SPELL_VORTEX_2, true);

            // the vortex execution continues in the dummy effect of this spell (see its script)
            DoCast(me, SPELL_VORTEX_3, true);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            switch (id)
            {
                case MOVE_VORTEX:
                    me->GetMotionMaster()->MoveIdle();
                    ExecuteVortex();
                    break;
                case MOVE_DEEP_BREATH_ROTATION:
                    _currentPos = _currentPos == MALYGOS_MAX_WAYPOINTS - 1 ? 0 : _currentPos+1;
                    _delayedMovement = true;
                    break;
                case MOVE_INIT_PHASE_ONE:
                    me->SetInCombatWithZone();
                    break;
                case MOVE_CENTER_PLATFORM:
                    // Malygos is already flying here, there is no need to set it again.
                    _cannotMove = false;
                    // malygos will move into center of platform and then he does not chase dragons, he just turns to his current target.
                    me->GetMotionMaster()->MoveIdle();
                    break;
            }
        }

        void StartPhaseTwo()
        {
            SetPhase(PHASE_TWO, true);

            me->SetDisableGravity(true);
            me->SetCanFly(true);
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            me->GetMotionMaster()->MovePoint(MOVE_DEEP_BREATH_ROTATION, MalygosPhaseTwoWaypoints[0]);

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

            for (uint8 i = 0; i < RAID_MODE(2, 6); i++)
            {
                uint8 position = 0;

                if (i > 0)
                    position = (i * 3) - 1;

                const int32 valueForAI = position;

                Creature* summon = me->SummonCreature(NPC_HOVER_DISK_CASTER, HoverDiskWaypoints[valueForAI]);

                if (summon && summon->IsAIEnabled)
                    summon->AI()->DoAction(valueForAI);
            }

            for (uint8 i = 0; i < RAID_MODE(2, 6); i++)
            {
                // not sure about its position.
                if (Creature* summon = me->SummonCreature(NPC_HOVER_DISK_MELEE, 782.9821f, 1296.652f, GROUND_Z))
                {
                    summon->SetInCombatWithZone();

                    // Force attacking players here instead of pets
                    if (Unit* randomPlayerTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                    {
                        summon->AddThreat(randomPlayerTarget, 100.0f);

                        if (summon->GetVehicleKit())
                            if (summon->GetVehicleKit()->GetPassenger(0))
                                summon->GetVehicleKit()->GetPassenger(0)->AddThreat(randomPlayerTarget, 100.0f);
                    }
                }
            }
        }

        void SendMovementFlagUpdatesOfAllSummons()
        {
            std::list<Creature*> updateCreatureList;
            me->GetCreatureListWithEntryInGrid(updateCreatureList, NPC_HOVER_DISK_MELEE, 250.0f);
            me->GetCreatureListWithEntryInGrid(updateCreatureList, NPC_HOVER_DISK_CASTER, 250.0f);
            me->GetCreatureListWithEntryInGrid(updateCreatureList, NPC_SCION_OF_ETERNITY, 250.0f);
            me->GetCreatureListWithEntryInGrid(updateCreatureList, NPC_NEXUS_LORD, 250.0f);

            if (!updateCreatureList.empty())
            {
                for (std::list<Creature*>::const_iterator itr = updateCreatureList.begin(); itr != updateCreatureList.end(); ++itr)
                {
                    if (Creature* creature = (*itr))
                    {
                        creature->SendMovementFlagUpdate();
                    }
                }
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            // the boss is handling vortex => Do not update timers
            if (me->HasAura(SPELL_VORTEX_2))
                return;

            events.Update(diff);

            if (powerSparkBuffTimerEnabled)
            {
                if (powerSparkBuffTimer <= diff)
                {
                    powerSparkBuffCount = 0;
                    powerSparkBuffTimerEnabled = false;
                } else powerSparkBuffTimer -= diff;
            }

            if (_phase == PHASE_THREE)
            {
                if (!_cannotMove)
                {
                    // it can change if the player falls from the vehicle.
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != IDLE_MOTION_TYPE)
                    {
                        me->GetMotionMaster()->MovementExpired();
                        me->GetMotionMaster()->MoveIdle();
                    }
                } else
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
                    {
                        me->GetMotionMaster()->MovementExpired();
                        me->GetMotionMaster()->MovePoint(MOVE_CENTER_PLATFORM, MalygosPositions[0].GetPositionX(), MalygosPositions[0].GetPositionY(), MalygosPositions[0].GetPositionZ());
                    }
                }
            }

            // we need a better way for pathing
            if (_delayedMovement)
            {
                if (_delayedMovementTimer <= diff)
                {
                    me->GetMotionMaster()->MovePoint(MOVE_DEEP_BREATH_ROTATION, MalygosPhaseTwoWaypoints[_currentPos]);
                    _delayedMovementTimer = 8000;
                    _delayedMovement = false;
                } _delayedMovementTimer -= diff;
            }

            // at 50 % health malygos switch to phase 2
            if (me->GetHealthPct() <= 50.0f && _phase == PHASE_ONE)
                StartPhaseTwo();

            // the boss is handling vortex
            if (me->HasAura(SPELL_VORTEX_2))
                return;

            // We can't cast if we are casting already.
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_YELL_2:
                        Talk(SAY_END_P_TWO);
                        break;
                    case EVENT_YELL_3:
                        Talk(SAY_INTRO_P_THREE);
                        break;
                    case EVENT_YELL_4:
                        Talk(SAY_AGGRO_P_THREE);
                        break;
                    case EVENT_YELL_0:
                        Talk(SAY_END_P_ONE);
                        break;
                    case EVENT_YELL_1:
                        Talk(SAY_AGGRO_P_TWO);
                        break;
                    case EVENT_ARCANE_BREATH:
                        DoCast(me->getVictim(), SPELL_ARCANE_BREATH);
                        events.ScheduleEvent(EVENT_ARCANE_BREATH, urand(35, 60)*IN_MILLISECONDS, 0, PHASE_ONE);
                        break;
                    case EVENT_ARCANE_STORM:
                        DoCast(me->getVictim(), SPELL_ARCANE_STORM);
                        events.ScheduleEvent(EVENT_ARCANE_STORM, urand(5, 10)*IN_MILLISECONDS, 0, PHASE_ONE);
                        break;
                    case EVENT_VORTEX:
                        PrepareForVortex();
                        events.ScheduleEvent(EVENT_VORTEX, urand(60, 80)*IN_MILLISECONDS, 0, PHASE_ONE);
                        break;
                    case EVENT_POWER_SPARKS:
                        instance->SetData(DATA_POWER_SPARKS_HANDLING, 0);
                        events.ScheduleEvent(EVENT_POWER_SPARKS, urand(30, 35)*IN_MILLISECONDS, 0, PHASE_ONE);
                        break;
                    case EVENT_SURGE_POWER:
                        if (updateOrientationPhase2)
                        {
                            updateOrientationPhase2 = false;

                            if (Unit* target = me->GetUnit((*me), targetGuid1))
                                me->SetFacingToObject(target);

                            targetGuid1 = 0;
                            events.ScheduleEvent(EVENT_SURGE_POWER, urand(58, 68)*IN_MILLISECONDS, 0, PHASE_TWO);
                        }
                        else
                        {
                            updateOrientationPhase2 = true;
                            me->GetMotionMaster()->MoveIdle();
                            _delayedMovement = true;

                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            {
                                targetGuid1 = target->GetGUID();
                                Talk(WHISPER_SURGE, target->GetGUID());
                                DoCast(target, SPELL_SURGE_POWER, true);
                            }

                            events.ScheduleEvent(EVENT_SURGE_POWER, 2500, 0, PHASE_TWO);
                        }
                        break;
                    case EVENT_SUMMON_ARCANE:
                        DoSummonArcaneBomb();
                        SendMovementFlagUpdatesOfAllSummons();
                        events.ScheduleEvent(EVENT_SUMMON_ARCANE, urand(12, 15)*IN_MILLISECONDS, 0, PHASE_TWO);
                        break;
                    case EVENT_DEEP_BREATH:
                        deepBreathCount++;
                        DoSimulateDeepBreath();

                        if (deepBreathCount == 5)
                        {
                            deepBreathCount = 0;
                            events.ScheduleEvent(EVENT_DEEP_BREATH, urand(35, 45)*IN_MILLISECONDS, 0, PHASE_TWO);
                        }
                        else
                            events.ScheduleEvent(EVENT_DEEP_BREATH, 1*IN_MILLISECONDS, 0, PHASE_TWO);

                        break;
                    case EVENT_SURGE_POWER_PHASE_3:
                        if (updateOrientationPhase3)
                        {
                            updateOrientationPhase3 = false;

                            if (targetGuid1)
                                if (Unit* mytarget = me->GetUnit((*me), targetGuid1))
                                    me->SetFacingToObject(mytarget);

                            if (targetGuid2)
                                if (Unit* trigger1target = me->GetUnit((*me), targetGuid2))
                                    if (summonGuid1)
                                        if (Unit* trigger1 = me->GetUnit((*me), summonGuid1))
                                            trigger1->SetFacingToObject(trigger1target);

                            if (targetGuid3)
                                if (Unit* trigger2target = me->GetUnit((*me), targetGuid3))
                                    if (summonGuid2)
                                        if (Unit* trigger2 = me->GetUnit((*me), summonGuid2))
                                            trigger2->SetFacingToObject(trigger2target);

                            targetGuid1 = 0;
                            targetGuid2 = 0;
                            targetGuid3 = 0;
                            summonGuid1 = 0;
                            summonGuid2 = 0;
                            events.ScheduleEvent(EVENT_SURGE_POWER_PHASE_3, (5, 14)*IN_MILLISECONDS, 0, PHASE_THREE);
                        }
                        else
                        {
                            updateOrientationPhase3 = true;

                            if (Unit* targetMalygos = GetTargetPhaseThree(true))
                            {
                                // Send whisper to vehicle riding player
                                if (targetMalygos->GetVehicleKit())
                                    if (targetMalygos->GetVehicleKit()->GetPassenger(0) && targetMalygos->GetVehicleKit()->GetPassenger(0)->GetTypeId() == TYPEID_PLAYER)
                                        Talk(WHISPER_SURGE, targetMalygos->GetVehicleKit()->GetPassenger(0)->GetGUID());

                                targetGuid1 = targetMalygos->GetGUID();
                                DoCast(targetMalygos, SPELL_SURGE_POWER, true);
                            }

                            if (me->GetMap())
                                if (me->GetMap()->GetSpawnMode() == 1)
                                    DoSimulateSurge(2);

                            events.ScheduleEvent(EVENT_SURGE_POWER_PHASE_3, 2500, 0, PHASE_THREE);
                        }
                        break;
                    case EVENT_STATIC_FIELD:
                        DoCast(GetTargetPhaseThree(), SPELL_STATIC_FIELD);
                        events.ScheduleEvent(EVENT_STATIC_FIELD, urand(20, 30)*IN_MILLISECONDS, 0, PHASE_THREE);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        Unit* GetTargetPhaseThree(bool forSurge = false)
        {
            Unit* target = NULL;

            if (forSurge)
                target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, false, -SPELL_VISUAL_HACK_SACRED_SHIELD_TEMP);
            else
                target = SelectTarget(SELECT_TARGET_RANDOM, 0);

            // No further processing if target is null object here, could cause crash
            if (target == NULL)
                return target;

            // we are a drake
            if (target->GetVehicleKit())
            {
                if (forSurge)
                {
                    target->AddAura(SPELL_VISUAL_HACK_SACRED_SHIELD_TEMP, target);

                    if (Unit* pPassenger = target->GetVehicleKit()->GetPassenger(0))
                        pPassenger->AddAura(SPELL_VISUAL_HACK_SACRED_SHIELD_TEMP, pPassenger);
                }
                return target;
            }

            // we are a player using a drake (or at least you should)
            if (target->GetTypeId() == TYPEID_PLAYER)
            {
                if (Unit* base = target->GetVehicleBase())
                {
                    if (forSurge)
                    {
                        target->AddAura(SPELL_VISUAL_HACK_SACRED_SHIELD_TEMP, target);
                        base->AddAura(SPELL_VISUAL_HACK_SACRED_SHIELD_TEMP, base);
                    }

                    return base;
                }
            }

            // is a player falling from a vehicle?
            return NULL;
        }

        void JustDied(Unit* /*killer*/)
        {
            // ugly hackfix for poke in the eye...
            if (participants.size() < uint32(DUNGEON_MODE(ACHIEV_POKE_IN_THE_EYE_COUNT, ACHIEV_POKE_IN_THE_EYE_H_COUNT)))
                if (AchievementEntry const* pAE = sAchievementStore.LookupEntry(DUNGEON_MODE(ACHIEV_POKE_IN_THE_EYE, ACHIEV_POKE_IN_THE_EYE_H)))
                    for (std::list<uint64>::const_iterator itr = participants.begin(); itr != participants.end(); ++itr)
                        if (Player* player = ObjectAccessor::FindPlayer((*itr)))
                            player->CompletedAchievement(pAE);

            Talk(SAY_DEATH);
            _JustDied();
        }

    private:
        uint8 _phase;

        uint8 powerSparkBuffCount;
        uint32 powerSparkBuffTimer;
        bool powerSparkBuffTimerEnabled;

        uint32 _bersekerTimer;
        uint8 _currentPos; // used for phase 2 rotation...
        bool _delayedMovement; // used in phase 2.
        uint32 _delayedMovementTimer; // used in phase 2
        uint8 _summonDeaths;
        Position _homePosition; // it can get bugged because core thinks we are pathing
        bool _mustTalk;
        bool _cannotMove;

        uint8 deepBreathCount;
        bool updateOrientationPhase2;
        bool updateOrientationPhase3;

        uint64 targetGuid1, targetGuid2, targetGuid3, summonGuid1, summonGuid2;

        std::list<uint64> participants;
    };

};

class spell_malygos_vortex_dummy : public SpellScriptLoader
{
public:
    spell_malygos_vortex_dummy() : SpellScriptLoader("spell_malygos_vortex_dummy") {}

    class spell_malygos_vortex_dummy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_malygos_vortex_dummy_SpellScript)

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();

            if (!caster)
                return;

            // each player will enter to the trigger vehicle (entry 30090) already spawned (each one can hold up to 5 players, it has 5 seats)
            // the players enter to the vehicles casting SPELL_VORTEX_4 OR SPELL_VORTEX_5
            if (InstanceScript* instance = caster->GetInstanceScript())
                instance->SetData(DATA_VORTEX_HANDLING, 0);

            // the rest of the vortex execution continues when SPELL_VORTEX_2 is removed.
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_malygos_vortex_dummy_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_malygos_vortex_dummy_SpellScript();
    }
};

class spell_malygos_vortex_visual : public SpellScriptLoader
{
    public:
        spell_malygos_vortex_visual() : SpellScriptLoader("spell_malygos_vortex_visual") { }

        class spell_malygos_vortex_visual_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_malygos_vortex_visual_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                {
                    std::list<HostileReference*> &m_threatlist = caster->getThreatManager().getThreatList();
                    for (std::list<HostileReference*>::const_iterator itr = m_threatlist.begin(); itr!= m_threatlist.end(); ++itr)
                    {
                        if (Unit* target = (*itr)->getTarget())
                        {
                            Player* targetPlayer = target->ToPlayer();

                            if (!targetPlayer || targetPlayer->isGameMaster())
                                continue;

                            if (InstanceScript* instance = caster->GetInstanceScript())
                            {
                                // teleport spell - i am not sure but might be it must be casted by each vehicle when its passenger leaves it
                                if (Creature* trigger = caster->GetMap()->GetCreature(instance->GetData64(DATA_TRIGGER)))
                                    trigger->CastSpell(targetPlayer, SPELL_VORTEX_6, true);
                            }
                        }
                    }

                    if (Creature* malygos = caster->ToCreature())
                    {
                        // This is a hack, we have to re add players to the threat list because when they enter to the vehicles they are removed.
                        // Anyway even with this issue, the boss does not enter in evade mode - this prevents iterate an empty list in the next vortex execution.
                        malygos->SetInCombatWithZone();

                        malygos->SetDisableGravity(false);
                        malygos->SetCanFly(false);

                        malygos->GetMotionMaster()->MoveChase(caster->getVictim());
                        malygos->RemoveAura(SPELL_VORTEX_1);
                    }
                }

            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_malygos_vortex_visual_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_malygos_vortex_visual_AuraScript();
        }
};

class spell_malygos_arcane_storm : public SpellScriptLoader
{
public:
    spell_malygos_arcane_storm() : SpellScriptLoader("spell_malygos_arcane_storm") {}

    class spell_malygos_arcane_storm_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_malygos_arcane_storm_SpellScript)

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            std::list<WorldObject*> newTargets;

            if (!targets.empty())
            {
                for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                {
                    // Randomize 33%
                    if (!(urand(0, 2)) && (*itr))
                    {
                        newTargets.push_back((*itr));
                    }
                }

                targets = newTargets;
            }
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_malygos_arcane_storm_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_malygos_arcane_storm_SpellScript();
    }
};

class npc_portal_eoe: public CreatureScript
{
public:
    npc_portal_eoe() : CreatureScript("npc_portal_eoe") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_portal_eoeAI(creature);
    }

    struct npc_portal_eoeAI : public ScriptedAI
    {
        npc_portal_eoeAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void Reset()
        {
            _summonTimer = urand(5, 7)*IN_MILLISECONDS;
        }

        void UpdateAI(uint32 const diff)
        {
            if (_instance)
            {
                if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                {
                    if (malygos->AI()->GetData(DATA_PHASE) != PHASE_ONE)
                    {
                        me->RemoveAura(SPELL_PORTAL_OPENED);
                        DoCast(me, SPELL_PORTAL_VISUAL_CLOSED, true);
                    }
                }
            }

            if (!me->HasAura(SPELL_PORTAL_OPENED))
                return;

            if (_summonTimer <= diff)
            {
                DoCast(SPELL_SUMMON_POWER_PARK);
                _summonTimer = urand(8, 10)*IN_MILLISECONDS;
            } else
                _summonTimer -= diff;
        }

        void JustSummoned(Creature* summon)
        {
            summon->SetInCombatWithZone();
        }

    private:
        uint32 _summonTimer;
        InstanceScript* _instance;
    };
};


class npc_power_spark: public CreatureScript
{
public:
    npc_power_spark() : CreatureScript("npc_power_spark") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_power_sparkAI(creature);
    }

    struct npc_power_sparkAI : public ScriptedAI
    {
        npc_power_sparkAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void EnterEvadeMode()
        {
            me->DespawnOrUnsummon();
        }

        void Reset()
        {
            _falling = false;
            me->SetCanFly(true);
            me->SetReactState(REACT_PASSIVE);
            MoveToMalygos();
        }

        void MoveToMalygos()
        {
            DoCast(me, SPELL_POWER_SPARK_VISUAL, true);

            me->GetMotionMaster()->MoveIdle();

            if (_instance)
            {
                if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                    me->GetMotionMaster()->MoveFollow(malygos, 0.0f, 0.0f);
            }
        }

        void UpdateAI(uint32 const /*diff*/)
        {
            if (!_instance)
                return;

            if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
            {
                if (malygos->AI()->GetData(DATA_PHASE) != PHASE_ONE || !malygos->isInCombat())
                {
                    me->DespawnOrUnsummon();
                    return;
                }

                if (!_falling)
                {
                    if (malygos->HasAura(SPELL_VORTEX_1))
                    {
                        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != IDLE_MOTION_TYPE)
                        {
                            me->StopMoving();
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MoveIdle();
                        }

                        return;
                    }

                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != FOLLOW_MOTION_TYPE)
                        me->GetMotionMaster()->MoveFollow(malygos, 0.0f, 0.0f);
                }
            }
        }

        void DamageTaken(Unit* /*done_by*/, uint32& damage)
        {
            if (damage >= me->GetHealth() && !_falling)
            {
                _falling = true;
                damage = 0;
                me->GetMotionMaster()->MoveFall();
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                DoCast(me, SPELL_POWER_SPARK_DEATH, true);
                me->DespawnOrUnsummon(60000);
            }
        }

    private:
        InstanceScript* _instance;
        bool _falling;
    };
};

class npc_hover_disk : public CreatureScript
{
public:
    npc_hover_disk() : CreatureScript("npc_hover_disk") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hover_diskAI(creature);
    }

    struct npc_hover_diskAI : public npc_escortAI
    {
        npc_hover_diskAI(Creature* creature) : npc_escortAI(creature)
        {
            if (me->GetEntry() == NPC_HOVER_DISK_CASTER)
                me->SetReactState(REACT_PASSIVE);
             else
                me->SetInCombatWithZone();

            _instance = creature->GetInstanceScript();
        }

        void PassengerBoarded(Unit* unit, int8 /*seat*/, bool apply)
        {
            if (apply)
            {
                if (unit->GetTypeId() == TYPEID_UNIT)
                {
                    me->setFaction(FACTION_HOSTILE);
                    unit->ToCreature()->SetInCombatWithZone();
                }
            }
            else
            {
                // Error found: This is not called if the passenger is a player

                if (unit->GetTypeId() == TYPEID_UNIT)
                {
                    // This will only be called if the passenger dies
                    if (_instance)
                    {
                        if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                            malygos->AI()->SetData(DATA_SUMMON_DEATHS, malygos->AI()->GetData(DATA_SUMMON_DEATHS)+1);
                    }

                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                }

                me->GetMotionMaster()->MoveIdle();

                if (me->GetEntry() == NPC_HOVER_DISK_MELEE)
                {
                    // Hack: Fall ground function can fail (remember the platform is a gameobject), we will teleport the disk to the ground
                    if (me->GetPositionZ() > GROUND_Z)
                        me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), GROUND_Z, 0);
                    me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                    me->setFaction(FACTION_FRIENDLY);
                    me->AI()->EnterEvadeMode();
                }
                else
                    me->SetVisible(false); // Hide the enemy flying disks of the Scion of Eternity
            }
        }

        void EnterEvadeMode()
        {
            // we dont evade
        }

        void DoAction(int32 const action)
        {
            if (me->GetEntry() != NPC_HOVER_DISK_CASTER)
                return;

            // Prevent overflows here
            if (action > MAX_HOVER_DISK_WAYPOINTS || action < 0)
                return;

            // Add all waypoints after current pos
            for (uint8 i = action; i < MAX_HOVER_DISK_WAYPOINTS; i++)
                AddWaypoint(i, HoverDiskWaypoints[i].GetPositionX(), HoverDiskWaypoints[i].GetPositionY(), HoverDiskWaypoints[i].GetPositionZ());

            // Add all waypoints before current pos and current pos
            for (uint8 i = 0; i < action+1; i++)
                AddWaypoint(i, HoverDiskWaypoints[i].GetPositionX(), HoverDiskWaypoints[i].GetPositionY(), HoverDiskWaypoints[i].GetPositionZ());

            Start(true, false, 0,0, false, true);
        }

        void UpdateEscortAI(const uint32 /*diff*/)
        {
            // we dont do melee damage!
        }

        void WaypointReached(uint32 /*waypointId*/)
        {

        }

    private:
        InstanceScript* _instance;
    };
};


// The reason of this AI is to make the creature able to enter in combat otherwise the spell casting of SPELL_ARCANE_OVERLOAD fails.
class npc_arcane_overload : public CreatureScript
{
public:
    npc_arcane_overload() : CreatureScript("npc_arcane_overload") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_arcane_overloadAI (creature);
    }

    struct npc_arcane_overloadAI : public ScriptedAI
    {
        npc_arcane_overloadAI(Creature* creature) : ScriptedAI(creature) {}

        void AttackStart(Unit* who)
        {
            DoStartNoMovement(who);
        }

        void Reset()
        {
            DoCast(me, SPELL_ARCANE_OVERLOAD, false);
        }

        void UpdateAI(uint32 const /*diff*/)
        {
            // we dont do melee damage!
        }

    };
};

class npc_scion_of_eternity : public CreatureScript
{
public:
    npc_scion_of_eternity() : CreatureScript("npc_scion_of_eternity") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_scion_of_eternityAI (creature);
    }

    struct npc_scion_of_eternityAI : public ScriptedAI
    {
        npc_scion_of_eternityAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 _arcaneBarrageTimer;

        void Reset()
        {
            _arcaneBarrageTimer = urand(3000, 5000);
        }

        void UpdateAI(uint32 const diff)
        {
            // Immediately despawn if not on vehicle
            if (!me->GetVehicle())
                me->DespawnOrUnsummon();

            if (_arcaneBarrageTimer <= diff)
            {
                int32 dmg = 0;

                if (!me->GetMap())
                    return;

                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                {
                    if (target->HasAura(SPELL_ARCANE_OVERLOAD_TRIGGERED))
                    {
                        if (me->GetMap()->GetSpawnMode() == 1)
                        {
                            dmg = urand(8483, 9518);
                        }
                        else
                        {
                            dmg = urand(7069, 7931);
                        }
                    }
                    else
                    {
                        if (me->GetMap()->GetSpawnMode() == 1)
                        {
                            dmg = urand(16965, 19035);
                        }
                        else
                        {
                            dmg = urand(14138, 15862);
                        }
                    }

                    if (dmg > 0)
                    {
                        if (me->HasAura(SPELL_BERSEKER_EFFECT))
                        {
                            dmg = dmg * 10;
                        }

                        me->DealDamage(target, dmg);
                        me->SendSpellNonMeleeDamageLog(target, 44425, dmg, SPELL_SCHOOL_MASK_NORMAL, 0, 0, true, 0, false);
                    }
                }

                _arcaneBarrageTimer = urand(4000, 6000);
            } else _arcaneBarrageTimer -= diff;

            DoMeleeAttackIfReady();
        }

    };
};

// SmartAI does not work correctly for this (vehicles)
class npc_wyrmrest_skytalon : public CreatureScript
{
public:
    npc_wyrmrest_skytalon() : CreatureScript("npc_wyrmrest_skytalon") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_wyrmrest_skytalonAI (creature);
    }

    struct npc_wyrmrest_skytalonAI : public NullCreatureAI
    {
        npc_wyrmrest_skytalonAI(Creature* creature) : NullCreatureAI(creature)
        {
            _instance = creature->GetInstanceScript();

            _timer = 1000;
            _entered = false;
        }

        // we can't call this in reset function, it fails.
        void MakePlayerEnter()
        {
            if (!_instance)
                return;

            if (Unit* summoner = me->ToTempSummon()->GetSummoner())
            {
                if (Creature* malygos = Unit::GetCreature(*me, _instance->GetData64(DATA_MALYGOS)))
                {
                    summoner->CastSpell(me, SPELL_RIDE_RED_DRAGON, true);
                    float victimThreat = malygos->getThreatManager().getThreat(summoner);
                    malygos->getThreatManager().resetAllAggro();
                    malygos->AI()->AttackStart(me);
                    malygos->AddThreat(me, victimThreat);
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!_entered)
            {
                if (_timer <= diff)
                {
                    MakePlayerEnter();
                    _entered = true;
                } else
                    _timer -= diff;
            }
        }

    private:
        InstanceScript* _instance;
        uint32 _timer;
        bool _entered;
    };
};

enum AlexstraszaYells
{
    SAY_ONE,
    SAY_TWO,
    SAY_THREE,
    SAY_FOUR
};

class npc_alexstrasza_eoe : public CreatureScript
{
public:
    npc_alexstrasza_eoe() : CreatureScript("npc_alexstrasza_eoe") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_alexstrasza_eoeAI (creature);
    }

    struct npc_alexstrasza_eoeAI : public ScriptedAI
    {
        npc_alexstrasza_eoeAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset()
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_YELL_1, 0);
        }

        void UpdateAI(uint32 const /*diff*/)
        {
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_YELL_1:
                        Talk(SAY_ONE);
                        _events.ScheduleEvent(EVENT_YELL_2, 4*IN_MILLISECONDS);
                        break;
                    case EVENT_YELL_2:
                        Talk(SAY_TWO);
                        _events.ScheduleEvent(EVENT_YELL_3, 4*IN_MILLISECONDS);
                        break;
                    case EVENT_YELL_3:
                        Talk(SAY_THREE);
                        _events.ScheduleEvent(EVENT_YELL_4, 7*IN_MILLISECONDS);
                        break;
                    case EVENT_YELL_4:
                        Talk(SAY_FOUR);
                        break;
                }
            }
        }
    private:
        EventMap _events;
    };
};

class achievement_denyin_the_scion : public AchievementCriteriaScript
{
    public:
        achievement_denyin_the_scion() : AchievementCriteriaScript("achievement_denyin_the_scion") {}

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Unit* disk = source->GetVehicleBase())
                if (disk->GetEntry() == NPC_HOVER_DISK_CASTER || disk->GetEntry() == NPC_HOVER_DISK_MELEE)
                    return true;
            return false;
        }
};

void AddSC_boss_malygos()
{
    new boss_malygos();
    new npc_portal_eoe();
    new npc_power_spark();
    new npc_hover_disk();
    new npc_arcane_overload();
    new npc_wyrmrest_skytalon();
    new spell_malygos_vortex_dummy();
    new spell_malygos_vortex_visual();
    new npc_alexstrasza_eoe();
    new achievement_denyin_the_scion();
    new npc_scion_of_eternity();
    new spell_malygos_arcane_storm();
}
