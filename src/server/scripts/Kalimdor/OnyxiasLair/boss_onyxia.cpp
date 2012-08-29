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
SDName: Boss_Onyxia
SD%Complete: 95
SDComment: <Known bugs>
               Ground visual for Deep Breath effect;
               Not summoning whelps on phase 3 (lacks info)
           </Known bugs>
SDCategory: Onyxia's Lair
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "onyxias_lair.h"

enum Yells
{
    SAY_AGGRO                   = -1249000,
    SAY_KILL                    = -1249001,
    SAY_PHASE_2_TRANS           = -1249002,
    SAY_PHASE_3_TRANS           = -1249003,
    EMOTE_BREATH                = -1249004,
};

enum Spells
{
    // Phase 1 spells
    SPELL_WING_BUFFET           = 18500,
    SPELL_FLAME_BREATH          = 18435,
    SPELL_CLEAVE                = 68868,
    SPELL_TAIL_SWEEP            = 68867,

    // Phase 2 spells
    SPELL_DEEP_BREATH           = 23461,
    SPELL_FIREBALL              = 18392,

    //Not much choise about these. We have to make own defintion on the direction/start-end point
    SPELL_BREATH_NORTH_TO_SOUTH = 17086,                    // 20x in "array"
    SPELL_BREATH_SOUTH_TO_NORTH = 18351,                    // 11x in "array"

    SPELL_BREATH_EAST_TO_WEST   = 18576,                    // 7x in "array"
    SPELL_BREATH_WEST_TO_EAST   = 18609,                    // 7x in "array"

    SPELL_BREATH_SE_TO_NW       = 18564,                    // 12x in "array"
    SPELL_BREATH_NW_TO_SE       = 18584,                    // 12x in "array"
    SPELL_BREATH_SW_TO_NE       = 18596,                    // 12x in "array"
    SPELL_BREATH_NE_TO_SW       = 18617,                    // 12x in "array"

    //SPELL_BREATH                = 21131,                  // 8x in "array", different initial cast than the other arrays

    // Phase 3 spells
    SPELL_BELLOWING_ROAR         = 18431,
};

struct OnyxMove
{
    uint8 LocId;
    uint8 LocIdEnd;
    uint32 SpellId;
    float fX, fY, fZ;
};

static OnyxMove MoveData[8]=
{
    {0, 1, SPELL_BREATH_WEST_TO_EAST,   -33.5561f, -182.682f, -56.9457f}, //west
    {1, 0, SPELL_BREATH_EAST_TO_WEST,   -31.4963f, -250.123f, -55.1278f}, //east
    {2, 4, SPELL_BREATH_NW_TO_SE,         6.8951f, -180.246f, -55.896f}, //north-west
    {3, 5, SPELL_BREATH_NE_TO_SW,        10.2191f, -247.912f, -55.896f}, //north-east
    {4, 2, SPELL_BREATH_SE_TO_NW,       -63.5156f, -240.096f, -55.477f}, //south-east
    {5, 3, SPELL_BREATH_SW_TO_NE,       -58.2509f, -189.020f, -55.790f}, //south-west
    {6, 7, SPELL_BREATH_SOUTH_TO_NORTH, -65.8444f, -213.809f, -55.2985f}, //south
    {7, 6, SPELL_BREATH_NORTH_TO_SOUTH,  22.8763f, -217.152f, -55.0548f}, //north
};

Position const MiddleRoomLocation = {-23.6155f, -215.357f, -55.7344f, 0.0f};

Position const SpawnLocations[3]=
{
    //Whelps
    {-30.127f, -254.463f, -89.440f, 0.0f},
    {-30.817f, -177.106f, -89.258f, 0.0f},
    //Lair Guard
    {-145.950f, -212.831f, -68.659f, 0.0f}
};

class boss_onyxia : public CreatureScript
{
public:
    boss_onyxia() : CreatureScript("boss_onyxia") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_onyxiaAI (creature);
    }

    struct boss_onyxiaAI : public ScriptedAI
    {
        boss_onyxiaAI(Creature* creature) : ScriptedAI(creature), Summons(me)
        {
            instance = creature->GetInstanceScript();
            Reset();
        }

        InstanceScript* instance;
        SummonList Summons;

        uint32 Phase;

        uint32 FlameBreathTimer;
        uint32 CleaveTimer;
        uint32 TailSweepTimer;
        uint32 WingBuffetTimer;

        uint8 MovePoint;
        uint32 MovementTimer;
        OnyxMove* PointData;

        uint32 FireballTimer;
        uint32 WhelpTimer;
        uint32 LairGuardTimer;
        uint32 DeepBreathTimer;

        uint32 BellowingRoarTimer;

        uint8 SummonWhelpCount;
        bool IsMoving;

        uint32 CheckPlayerSummonWhelpTimer;
        uint32 SummonWhelpPhase3Timer;
        uint8 SummonLairGuardCount;
        bool LogWhelpSummons;

        void Reset()
        {
            if (!IsCombatMovementAllowed())
                SetCombatMovement(true);

            Phase = PHASE_START;

            FlameBreathTimer = urand(10000, 20000);
            TailSweepTimer = urand(15000, 20000);
            CleaveTimer = urand(2000, 5000);
            WingBuffetTimer = urand(10000, 20000);

            MovePoint = urand(0, 5);
            MovementTimer = 20000;
            PointData = GetMoveData();

            FireballTimer = 15000;
            WhelpTimer = 1000;
            LairGuardTimer = 15000;
            DeepBreathTimer = 85000;

            BellowingRoarTimer = 30000;

            CheckPlayerSummonWhelpTimer = 1000;
            SummonWhelpPhase3Timer = 15000;
            LogWhelpSummons = true;

            Summons.DespawnAll();
            SummonWhelpCount = 0;
            SummonLairGuardCount = 0;
            IsMoving = false;

            if (instance)
            {
                instance->SetData(DATA_ONYXIA, NOT_STARTED);
                instance->SetData(DATA_ONYXIA_PHASE, Phase);
                instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT,  ACHIEV_TIMED_START_EVENT);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            DoScriptText(SAY_AGGRO, me);
            me->SetInCombatWithZone();

            if (instance)
            {
                instance->SetData(DATA_ONYXIA, IN_PROGRESS);
                instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT,  ACHIEV_TIMED_START_EVENT);
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (instance)
                instance->SetData(DATA_ONYXIA, DONE);

            Summons.DespawnAll();
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->SetInCombatWithZone();
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                summoned->AI()->AttackStart(target);

            switch (summoned->GetEntry())
            {
                case NPC_WHELP:
                if (LogWhelpSummons)
                    ++SummonWhelpCount;
                    break;
                case NPC_LAIRGUARD:
                    summoned->setActive(true);
                    ++SummonLairGuardCount;
                    break;
            }
            Summons.Summon(summoned);
        }

        void SummonedCreatureDespawn(Creature* summon)
        {
            Summons.Despawn(summon);
        }

        void KilledUnit(Unit* /*victim*/)
        {
            DoScriptText(SAY_KILL, me);
        }

        void SpellHit(Unit* /*pCaster*/, const SpellInfo* Spell)
        {
            if (Spell->Id == SPELL_BREATH_EAST_TO_WEST ||
                Spell->Id == SPELL_BREATH_WEST_TO_EAST ||
                Spell->Id == SPELL_BREATH_SE_TO_NW ||
                Spell->Id == SPELL_BREATH_NW_TO_SE ||
                Spell->Id == SPELL_BREATH_SW_TO_NE ||
                Spell->Id == SPELL_BREATH_NE_TO_SW)
            {
                PointData = GetMoveData();
                MovePoint = PointData->LocIdEnd;

                me->SetSpeed(MOVE_FLIGHT, 1.5f);
                me->GetMotionMaster()->MovePoint(8, MiddleRoomLocation);
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == POINT_MOTION_TYPE)
            {
                switch (id)
                {
                    case 8:
                        PointData = GetMoveData();
                        if (PointData)
                        {
                            me->SetSpeed(MOVE_FLIGHT, 1.0f);
                            me->GetMotionMaster()->MovePoint(PointData->LocId, PointData->fX, PointData->fY, PointData->fZ);
                        }
                        break;
                    case 9:
                        me->GetMotionMaster()->MoveChase(me->getVictim());
                        BellowingRoarTimer = 1000;
                        break;
                    default:
                        IsMoving = false;
                        break;
                }
            }
        }

        void SpellHitTarget(Unit* target, const SpellInfo* Spell)
        {
            //Workaround - Couldn't find a way to group this spells (All Eruption)
            if (((Spell->Id >= 17086 && Spell->Id <= 17095) ||
                (Spell->Id == 17097) ||
                (Spell->Id >= 18351 && Spell->Id <= 18361) ||
                (Spell->Id >= 18564 && Spell->Id <= 18576) ||
                (Spell->Id >= 18578 && Spell->Id <= 18607) ||
                (Spell->Id == 18609) ||
                (Spell->Id >= 18611 && Spell->Id <= 18628) ||
                (Spell->Id >= 21132 && Spell->Id <= 21133) ||
                (Spell->Id >= 21135 && Spell->Id <= 21139) ||
                (Spell->Id >= 22191 && Spell->Id <= 22202) ||
                (Spell->Id >= 22267 && Spell->Id <= 22268)) &&
                (target->GetTypeId() == TYPEID_PLAYER))
            {
                if (instance)
                {
                    instance->SetData(DATA_SHE_DEEP_BREATH_MORE, FAIL);
                }
            }
        }

        OnyxMove* GetMoveData()
        {
            uint8 MaxCount = sizeof(MoveData)/sizeof(OnyxMove);

            for (uint8 i = 0; i < MaxCount; ++i)
            {
                if (MoveData[i].LocId == MovePoint)
                    return &MoveData[i];
            }

            return NULL;
        }

        void SetNextRandomPoint()
        {
            uint8 MaxCount = sizeof(MoveData)/sizeof(OnyxMove);

            uint8 iTemp = urand(0, MaxCount-1);

            if (iTemp >= MovePoint)
                ++iTemp;

            MovePoint = iTemp;
        }

        void CheckPlayersCoordinatesSummonWhelps()
        {
            Map* map = me->GetMap();
            if (map && map->IsDungeon())
            {
                Map::PlayerList const &PlayerList = map->GetPlayers();
                if (!PlayerList.isEmpty())
                {
                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if (!i->getSource() || !i->getSource()->isAlive())
                            continue;

                        float x = i->getSource()->GetPositionX(), y = i->getSource()->GetPositionY(), z = i->getSource()->GetPositionZ();

                        if ((x >= -23.8f || (x <= -23.8f && x >= -70.4f && y <= -177.7f && y >= -251.1f) ||
                            (x <= -70.4f && x >= -76.1f && y <= -183.7f && y >= -248.0f) ||
                            (x <= -76.1f && x >= -85.0f && y <= -187.8f && y >= -239.1f) ||
                            (x <= -85.0f && x >= -88.0f && y <= -191.3f && y >= -237.0f) ||
                            (x <= -88.0f && x >= -106.5f && y <= -203.3f && y >= -224.5f && z >= -89.0f)) &&
                            (z <= -62.0f && z >= -95.0f))
                            continue;
                        else
                        {
                            i->getSource()->TeleportTo(249, 4.9f, -217.8f, -86.0f, 3.123f);
                            LogWhelpSummons = false;
                            for (uint8 count = 0; count < RAID_MODE(5,10); count++)
                                me->SummonCreature(NPC_WHELP, 4.9f, -217.8f, -86.0f, 3.123f, TEMPSUMMON_CORPSE_DESPAWN);

                            LogWhelpSummons = true;
                        }
                    }
                }
            }
        }

        void UpdateAI(const uint32 Diff)
        {
            if (!UpdateVictim())
                return;

            if (CheckPlayerSummonWhelpTimer <= Diff)
            {
                CheckPlayersCoordinatesSummonWhelps();
                CheckPlayerSummonWhelpTimer = 1000;
            }
            else
                CheckPlayerSummonWhelpTimer -= Diff;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            //Common to PHASE_START && PHASE_END
            if (Phase == PHASE_START || Phase == PHASE_END)
            {
                //Specific to PHASE_START || PHASE_END
                if (Phase == PHASE_START)
                {
                    if (HealthBelowPct(60))
                    {
                        SetCombatMovement(false);
                        Phase = PHASE_BREATH;
                        me->GetMotionMaster()->Clear(false);
                        me->GetMotionMaster()->MoveIdle();
                        me->SetCanFly(true);

                        if (instance)
                            instance->SetData(DATA_ONYXIA_PHASE, Phase);

                        DoScriptText(SAY_PHASE_2_TRANS, me);

                        if (PointData)
                            me->GetMotionMaster()->MovePoint(PointData->LocId, PointData->fX, PointData->fY, PointData->fZ);

                        WhelpTimer = 1000;
                        return;
                    }
                }
                else
                {
                    if (BellowingRoarTimer <= Diff)
                    {
                        DoCastVictim(SPELL_BELLOWING_ROAR);
                        // Eruption
                        GameObject* Floor = NULL;
                        Trinity::GameObjectInRangeCheck check(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 15);
                        Trinity::GameObjectLastSearcher<Trinity::GameObjectInRangeCheck> searcher(me, Floor, check);
                        me->VisitNearbyGridObject(30, searcher);
                        if (instance && Floor)
                            instance->SetData64(DATA_FLOOR_ERUPTION_GUID, Floor->GetGUID());
                        BellowingRoarTimer = 30000;
                    }
                    else
                        BellowingRoarTimer -= Diff;

                    if (SummonWhelpPhase3Timer <= Diff)
                    {
                        LogWhelpSummons = false;
                        for (uint8 counter = 0; counter < RAID_MODE(1,2); counter++)
                        {
                            me->SummonCreature(NPC_WHELP, SpawnLocations[0].GetPositionX(), SpawnLocations[0].GetPositionY(), SpawnLocations[0].GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_DESPAWN);
                            me->SummonCreature(NPC_WHELP, SpawnLocations[1].GetPositionX(), SpawnLocations[1].GetPositionY(), SpawnLocations[1].GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_DESPAWN);
                        }
                        LogWhelpSummons = true;
                        SummonWhelpPhase3Timer = 15000;
                    }
                    else
                        SummonWhelpPhase3Timer -= Diff;
                }

                if (FlameBreathTimer <= Diff)
                {
                    DoCastVictim(SPELL_FLAME_BREATH);
                    FlameBreathTimer = urand(10000, 20000);
                }
                else
                    FlameBreathTimer -= Diff;

                if (TailSweepTimer <= Diff)
                {
                    DoCastAOE(SPELL_TAIL_SWEEP);
                    TailSweepTimer = urand(15000, 20000);
                }
                else
                    TailSweepTimer -= Diff;

                if (CleaveTimer <= Diff)
                {
                    DoCastVictim(SPELL_CLEAVE);
                    CleaveTimer = urand(2000, 5000);
                }
                else
                    CleaveTimer -= Diff;

                if (WingBuffetTimer <= Diff)
                {
                    DoCastVictim(SPELL_WING_BUFFET);
                    WingBuffetTimer = urand(15000, 30000);
                }
                else
                    WingBuffetTimer -= Diff;

                DoMeleeAttackIfReady();
            }
            else
            {
                if (HealthBelowPct(40))
                {
                    Phase = PHASE_END;
                    if (instance)
                        instance->SetData(DATA_ONYXIA_PHASE, Phase);
                    DoScriptText(SAY_PHASE_3_TRANS, me);

                    SetCombatMovement(true);
                    me->SetCanFly(false);
                    IsMoving = false;
                    me->GetMotionMaster()->MovePoint(9, me->GetHomePosition());
                    return;
                }

                if (DeepBreathTimer <= Diff)
                {
                    if (!IsMoving)
                    {
                        if (me->IsNonMeleeSpellCasted(false))
                            me->InterruptNonMeleeSpells(false);

                        DoScriptText(EMOTE_BREATH, me);
                        DoCast(me, PointData->SpellId);
                        DeepBreathTimer = 70000;
                    }
                }
                else
                    DeepBreathTimer -= Diff;

                if (MovementTimer <= Diff)
                {
                    if (!IsMoving)
                    {
                        SetNextRandomPoint();
                        PointData = GetMoveData();

                        if (!PointData)
                            return;

                        me->GetMotionMaster()->MovePoint(PointData->LocId, PointData->fX, PointData->fY, PointData->fZ);
                        IsMoving = true;
                        MovementTimer = 25000;
                    }
                }
                else
                    MovementTimer -= Diff;

                if (FireballTimer <= Diff)
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            DoCast(target, SPELL_FIREBALL);

                        FireballTimer = 8000;
                    }
                }
                else
                    FireballTimer -= Diff;

                if (LairGuardTimer <= Diff)
                {
                    me->SummonCreature(NPC_LAIRGUARD, SpawnLocations[2], TEMPSUMMON_CORPSE_DESPAWN);
                    if (SummonLairGuardCount >= RAID_MODE(1,2))
                    {
                        SummonLairGuardCount = 0;
                        LairGuardTimer = 30000;
                    }
                    else
                        LairGuardTimer = 2000;
                }
                else
                    LairGuardTimer -= Diff;

                if (WhelpTimer <= Diff)
                {
                    LogWhelpSummons = true;
                    me->SummonCreature(NPC_WHELP, SpawnLocations[0], TEMPSUMMON_CORPSE_DESPAWN);
                    me->SummonCreature(NPC_WHELP, SpawnLocations[1], TEMPSUMMON_CORPSE_DESPAWN);
                    if (SummonWhelpCount >= RAID_MODE(20, 40))
                    {
                        SummonWhelpCount = 0;
                        WhelpTimer = 90000;
                    }
                    else
                        WhelpTimer = 500;
                }
                else
                    WhelpTimer -= Diff;
            }
        }
    };

};

void AddSC_boss_onyxia()
{
    new boss_onyxia();
}
