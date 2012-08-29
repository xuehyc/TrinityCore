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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "InstanceScript.h"
#include "naxxramas.h"

const DoorData doorData[] =
{
    {181126,    BOSS_ANUBREKHAN, DOOR_TYPE_ROOM,     BOUNDARY_S},
    {181235,    BOSS_ANUBREKHAN, DOOR_TYPE_PASSAGE,  0},
    {181195,    BOSS_ANUBREKHAN, DOOR_TYPE_PASSAGE,  0},
    {181235,    BOSS_FAERLINA,  DOOR_TYPE_ROOM,     BOUNDARY_S},
    {194022,    BOSS_FAERLINA,  DOOR_TYPE_PASSAGE,  0},
    {181197,    BOSS_FAERLINA,  DOOR_TYPE_PASSAGE,  0},
    {181209,    BOSS_FAERLINA,  DOOR_TYPE_PASSAGE,  0},
    {181197,    BOSS_MAEXXNA,   DOOR_TYPE_ROOM,     BOUNDARY_SW},
    {181209,    BOSS_MAEXXNA,   DOOR_TYPE_ROOM,     BOUNDARY_SW},
    {181200,    BOSS_NOTH,      DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181201,    BOSS_NOTH,      DOOR_TYPE_PASSAGE,  BOUNDARY_E},
    {181202,    BOSS_NOTH,      DOOR_TYPE_PASSAGE,  0},
    {181202,    BOSS_HEIGAN,    DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181203,    BOSS_HEIGAN,    DOOR_TYPE_PASSAGE,  BOUNDARY_E},
    {181241,    BOSS_HEIGAN,    DOOR_TYPE_PASSAGE,  0},
    {181496,    BOSS_HEIGAN,    DOOR_TYPE_PASSAGE,  0},
    {181241,    BOSS_LOATHEB,   DOOR_TYPE_ROOM,     BOUNDARY_W},
    {181123,    BOSS_PATCHWERK, DOOR_TYPE_PASSAGE,  0},
    {181123,    BOSS_GROBBULUS, DOOR_TYPE_ROOM,     0},
    {181120,    BOSS_GLUTH,     DOOR_TYPE_PASSAGE,  BOUNDARY_NW},
    {181121,    BOSS_GLUTH,     DOOR_TYPE_PASSAGE,  0},
    {181121,    BOSS_THADDIUS,  DOOR_TYPE_ROOM,     0},
    {181124,    BOSS_RAZUVIOUS, DOOR_TYPE_PASSAGE,  0},
    {181124,    BOSS_GOTHIK,    DOOR_TYPE_ROOM,     BOUNDARY_N},
    {181125,    BOSS_GOTHIK,    DOOR_TYPE_PASSAGE,  BOUNDARY_S},
    {181119,    BOSS_GOTHIK,    DOOR_TYPE_PASSAGE,  0},
    {181119,    BOSS_HORSEMEN,  DOOR_TYPE_ROOM,     BOUNDARY_NE},
    {181225,    BOSS_SAPPHIRON, DOOR_TYPE_PASSAGE,  BOUNDARY_W},
    {181228,    BOSS_SAPPHIRON, DOOR_TYPE_PASSAGE,  BOUNDARY_W},
    {181228,    BOSS_KELTHUZAD, DOOR_TYPE_ROOM,     BOUNDARY_S},
    {0,         0,              DOOR_TYPE_ROOM,     0}, // EOF
};

const MinionData minionData[] =
{
    //{16573,     BOSS_ANUBREKHAN},     there is no spawn point in db, so we do not add them here
    {16506,     BOSS_FAERLINA},
    {16803,     BOSS_RAZUVIOUS},
    {16063,     BOSS_HORSEMEN},
    {16064,     BOSS_HORSEMEN},
    {16065,     BOSS_HORSEMEN},
    {30549,     BOSS_HORSEMEN},
    {0,         0, }
};

enum eEnums
{
    GO_HORSEMEN_CHEST_HERO  = 193426,
    GO_HORSEMEN_CHEST       = 181366,                   //four horsemen event, DoRespawnGameObject() when event == DONE
    GO_GOTHIK_GATE          = 181170,
    GO_KELTHUZAD_PORTAL01   = 181402,
    GO_KELTHUZAD_PORTAL02   = 181403,
    GO_KELTHUZAD_PORTAL03   = 181404,
    GO_KELTHUZAD_PORTAL04   = 181405,
    GO_KELTHUZAD_TRIGGER    = 181444,

    SPELL_ERUPTION          = 29371
};

const float HeiganPos[2] = {2796, -3707};
const float HeiganEruptionSlope[3] =
{
    (-3685 - HeiganPos[1]) /(2724 - HeiganPos[0]),
    (-3647 - HeiganPos[1]) /(2749 - HeiganPos[0]),
    (-3637 - HeiganPos[1]) /(2771 - HeiganPos[0]),
};

// 0  H      x
//  1        ^
//   2       |
//    3  y<--o
inline uint32 GetEruptionSection(float x, float y)
{
    y -= HeiganPos[1];
    if (y < 1.0f)
        return 0;

    x -= HeiganPos[0];
    if (x > -1.0f)
        return 3;

    float slope = y/x;
    for (uint32 i = 0; i < 3; ++i)
        if (slope > HeiganEruptionSlope[i])
            return i;
    return 3;
}

class instance_naxxramas : public InstanceMapScript
{
public:
    instance_naxxramas() : InstanceMapScript("instance_naxxramas", 533) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_naxxramas_InstanceMapScript(map);
    }

    struct instance_naxxramas_InstanceMapScript : public InstanceScript
    {
        instance_naxxramas_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_BOSS_NUMBER);
            LoadDoorData(doorData);
            LoadMinionData(minionData);
        }

        std::set<uint64> heiganEruptionGUID[4];
        uint64 gothikGateGUID;
        uint64 horsemenChestGUID;
        uint64 sapphironGUID;
        uint64 faerlinaGUID;
        uint64 thaneGUID;
        uint64 ladyGUID;
        uint64 baronGUID;
        uint64 sirGUID;

        uint64 thaddiusGUID;
        uint64 heiganGUID;
        uint64 feugenGUID;
        uint64 stalaggGUID;

        uint64 kelthuzadGUID;
        uint64 kelthuzadTriggerGUID;
        uint64 portalsGUID[4];

        uint32 AbominationCount;

        GOState gothikDoorState;

        time_t minHorsemenDiedTime;
        time_t maxHorsemenDiedTime;

        uint32 playerDied;

        void Initialize()
        {
            gothikGateGUID            = 0;
            horsemenChestGUID         = 0;
            sapphironGUID             = 0;
            faerlinaGUID              = 0;
            thaneGUID                 = 0;
            ladyGUID                  = 0;
            baronGUID                 = 0;
            sirGUID                   = 0;
            thaddiusGUID              = 0;
            heiganGUID                = 0;
            feugenGUID                = 0;
            stalaggGUID               = 0;
            kelthuzadGUID             = 0;
            kelthuzadTriggerGUID      = 0;

            playerDied                = 0;
            gothikDoorState           = GO_STATE_ACTIVE;

            memset(portalsGUID, 0, sizeof(portalsGUID));
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case 15989: sapphironGUID = creature->GetGUID(); return;
                case 15953: faerlinaGUID = creature->GetGUID(); return;
                case 16064: thaneGUID = creature->GetGUID(); return;
                case 16065: ladyGUID = creature->GetGUID(); return;
                case 30549: baronGUID = creature->GetGUID(); return;
                case 16063: sirGUID = creature->GetGUID(); return;
                case 15928: thaddiusGUID = creature->GetGUID(); return;
                case 15936: heiganGUID = creature->GetGUID(); return;
                case 15930: feugenGUID = creature->GetGUID(); return;
                case 15929: stalaggGUID = creature->GetGUID(); return;
                case 15990: kelthuzadGUID = creature->GetGUID(); return;
            }

            AddMinion(creature, true);
        }

        void OnCreatureRemove(Creature* creature)
        {
            AddMinion(creature, false);
        }

        void OnGameObjectCreate(GameObject* go)
        {
            if (go->GetGOInfo()->displayId == 6785 || go->GetGOInfo()->displayId == 1287)
            {
                uint32 section = GetEruptionSection(go->GetPositionX(), go->GetPositionY());
                heiganEruptionGUID[section].insert(go->GetGUID());

                return;
            }

            switch (go->GetEntry())
            {
                case GO_GOTHIK_GATE:
                    gothikGateGUID = go->GetGUID();
                    go->SetGoState(gothikDoorState);
                    break;
                case GO_HORSEMEN_CHEST:
                    horsemenChestGUID = go->GetGUID();
                    break;
                case GO_HORSEMEN_CHEST_HERO:
                    horsemenChestGUID = go->GetGUID();
                    break;
                case GO_KELTHUZAD_PORTAL01:
                    portalsGUID[0] = go->GetGUID();
                    break;
                case GO_KELTHUZAD_PORTAL02:
                    portalsGUID[1] = go->GetGUID();
                    break;
                case GO_KELTHUZAD_PORTAL03:
                    portalsGUID[2] = go->GetGUID();
                    break;
                case GO_KELTHUZAD_PORTAL04:
                    portalsGUID[3] = go->GetGUID();
                    break;
                case GO_KELTHUZAD_TRIGGER:
                    kelthuzadTriggerGUID = go->GetGUID();
                    break;
                default:
                    break;
            }

            AddDoor(go, true);
        }

        void OnGameObjectRemove(GameObject* go)
        {
            if (go->GetGOInfo()->displayId == 6785 || go->GetGOInfo()->displayId == 1287)
            {
                uint32 section = GetEruptionSection(go->GetPositionX(), go->GetPositionY());

                heiganEruptionGUID[section].erase(go->GetGUID());
                return;
            }

            switch (go->GetEntry())
            {
                case GO_BIRTH:
                    if (sapphironGUID)
                    {
                        if (Creature* pSapphiron = instance->GetCreature(sapphironGUID))
                            pSapphiron->AI()->DoAction(DATA_SAPPHIRON_BIRTH);
                        return;
                    }
                    break;
                default:
                    break;
            }

            AddDoor(go, false);
        }

        void OnUnitDeath(Unit* unit)
        {
            if (unit->GetTypeId() == TYPEID_PLAYER && IsEncounterInProgress())
            {
                playerDied = 1;
                SaveToDB();
            }
        }

        void SetData(uint32 id, uint32 value)
        {
            switch (id)
            {
                case DATA_HEIGAN_ERUPT:
                    HeiganErupt(value);
                    break;
                case DATA_GOTHIK_GATE:
                    if (GameObject* gothikGate = instance->GetGameObject(gothikGateGUID))
                        gothikGate->SetGoState(GOState(value));
                    gothikDoorState = GOState(value);
                    break;
                case DATA_HORSEMEN0:
                case DATA_HORSEMEN1:
                case DATA_HORSEMEN2:
                case DATA_HORSEMEN3:
                    if (value == NOT_STARTED)
                    {
                        minHorsemenDiedTime = 0;
                        maxHorsemenDiedTime = 0;
                    }
                    else if (value == DONE)
                    {
                        time_t now = time(NULL);

                        if (minHorsemenDiedTime == 0)
                            minHorsemenDiedTime = now;

                        maxHorsemenDiedTime = now;
                    }
                    break;
                case DATA_ABOMINATION_KILLED:
                    AbominationCount = value;
                    break;
            }
        }

        uint32 GetData(uint32 id)
        {
            switch (id)
            {
                case DATA_ABOMINATION_KILLED:
                    return AbominationCount;
                default:
                    break;
            }

            return 0;
        }

        uint64 GetData64(uint32 id)
        {
            switch (id)
            {
            case DATA_FAERLINA:
                return faerlinaGUID;
            case DATA_THANE:
                return thaneGUID;
            case DATA_LADY:
                return ladyGUID;
            case DATA_BARON:
                return baronGUID;
            case DATA_SIR:
                return sirGUID;
            case DATA_THADDIUS:
                return thaddiusGUID;
            case DATA_HEIGAN:
                return heiganGUID;
            case DATA_FEUGEN:
                return feugenGUID;
            case DATA_STALAGG:
                return stalaggGUID;
            case DATA_KELTHUZAD:
                return kelthuzadGUID;
            case DATA_KELTHUZAD_PORTAL01:
                return portalsGUID[0];
            case DATA_KELTHUZAD_PORTAL02:
                return portalsGUID[1];
            case DATA_KELTHUZAD_PORTAL03:
                return portalsGUID[2];
            case DATA_KELTHUZAD_PORTAL04:
                return portalsGUID[3];
            case DATA_KELTHUZAD_TRIGGER:
                return kelthuzadTriggerGUID;
            }
            return 0;
        }

        bool SetBossState(uint32 id, EncounterState state)
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;

            if (id == BOSS_HORSEMEN && state == DONE)
            {
                if (GameObject* pHorsemenChest = instance->GetGameObject(horsemenChestGUID))
                    pHorsemenChest->SetRespawnTime(pHorsemenChest->GetRespawnDelay());
            }

            return true;
        }

        void HeiganErupt(uint32 section)
        {
            for (uint32 i = 0; i < 4; ++i)
            {
                if (i == section)
                    continue;

                for (std::set<uint64>::const_iterator itr = heiganEruptionGUID[i].begin(); itr != heiganEruptionGUID[i].end(); ++itr)
                {
                    if (GameObject* pHeiganEruption = instance->GetGameObject(*itr))
                    {
                        pHeiganEruption->SendCustomAnim(pHeiganEruption->GetGoAnimProgress());
                        pHeiganEruption->CastSpell(NULL, SPELL_ERUPTION);
                    }
                }
            }
        }

        // This Function is called in CheckAchievementCriteriaMeet and CheckAchievementCriteriaMeet is called before SetBossState(bossId, DONE),
        // so to check if all bosses are done the checker must exclude 1 boss, the last done, if there is at most 1 encouter in progress when is
        // called this function then all bosses are done. The one boss that check is the boss that calls this function, so it is dead.
        bool AreAllEncoutersDone()
        {
            uint32 numBossAlive = 0;
            for (uint32 i = 0; i < MAX_BOSS_NUMBER; ++i)
                if (GetBossState(i) != DONE)
                    numBossAlive++;

            if (numBossAlive > 1)
                return false;
            return true;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target = NULL*/, uint32 /*miscvalue1 = 0*/)
        {
            switch (criteria_id)
            {
                case 7600:  // Criteria for achievement 2176: And They Would All Go Down Together 15sec of each other 10-man
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_10MAN_NORMAL && (maxHorsemenDiedTime - minHorsemenDiedTime) < 15)
                        return true;
                    return false;
                case 7601:  // Criteria for achievement 2177: And They Would All Go Down Together 15sec of each other 25-man
                    if (Difficulty(instance->GetSpawnMode()) == RAID_DIFFICULTY_25MAN_NORMAL && (maxHorsemenDiedTime - minHorsemenDiedTime) < 15)
                        return true;
                    return false;
                // Difficulty checks are done on DB.
                // Criteria for achievement 2186: The Immortal (25-man)
                case 13233: // The Four Horsemen
                case 13234: // Maexxna
                case 13235: // Thaddius
                case 13236: // Loatheb
                case 7616:  // Kel'Thuzad
                // Criteria for achievement 2187: The Undying (10-man)
                case 13237: // The Four Horsemen
                case 13238: // Maexxna
                case 13239: // Loatheb
                case 13240: // Thaddius
                case 7617:  // Kel'Thuzad
                    if (AreAllEncoutersDone() && !playerDied)
                        return true;
                    return false;
            }
            return false;
        }

        std::string GetSaveData()
        {
            std::ostringstream saveStream;
            saveStream << GetBossSaveData() << gothikDoorState << ' ' << playerDied;
            return saveStream.str();
        }

        void Load(const char * data)
        {
            std::istringstream loadStream(LoadBossState(data));
            uint32 temp, buff, buff2;

            for (uint32 i = 0; i < MAX_BOSS_NUMBER; ++i)
                loadStream >> temp;

            loadStream >> buff;
            gothikDoorState = GOState(buff);
            loadStream >> buff2;
            playerDied = buff2;
        }
    };
};


const Position TargetPos[3] =
{
    {3176.42f, -3132.7f, 295.0f, 0.0f},
    {3154.90f, -3123.03f, 295.0f, 0.0f},
    {3136.50f, -3118.55f, 295.0f, 0.0f}
};

class mob_living_poison : public CreatureScript
{
public:
    mob_living_poison() : CreatureScript("mob_living_poison") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_living_poisonAI(creature);
    }

    struct mob_living_poisonAI : public ScriptedAI
    {
        mob_living_poisonAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 SpawnTimer;

        void Reset()
        {
            SpawnTimer = 8000;
            LivingPoisonStart();
        }

        void LivingPoisonStart()
        {
            if (me->GetPositionX() <= 3160.0f && me->GetPositionX() >= 3150.0f)
                me->GetMotionMaster()->MovePoint(1, TargetPos[0].GetPositionX(), TargetPos[0].GetPositionY(), TargetPos[0].GetPositionZ());
            else if (me->GetPositionX() <= 3150.0f && me->GetPositionX() >= 3135.0f)
                me->GetMotionMaster()->MovePoint(1, TargetPos[1].GetPositionX(), TargetPos[1].GetPositionY(), TargetPos[1].GetPositionZ());
            else if (me->GetPositionX() <= 3135.0f && me->GetPositionX() >= 3125.0f)
                me->GetMotionMaster()->MovePoint(1, TargetPos[2].GetPositionX(), TargetPos[2].GetPositionY(), TargetPos[2].GetPositionZ());
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == 1 && me->isSummon())
                me->DespawnOrUnsummon();
            else if (id == 1)
                me->SetVisible(false);

        }

        void MoveInLineOfSight(Unit* who)
        {
            if (me->IsHostileTo(who) && me->GetExactDist(who->GetPositionX(), who->GetPositionY(), who->GetPositionZ()) <= 2.5f && !me->IsVisible() == false && who->isAlive())
            {
                me->DealDamage(who, 30000);
                me->SetVisible(false);
            }
        }

        void UpdateAI(uint32 const diff)
        {
            if (me->GetInstanceScript())
                if (me->GetInstanceScript()->GetBossState(BOSS_GROBBULUS) == DONE)
                {
                    me->DespawnOrUnsummon();
                    return;
            }

            if (SpawnTimer <= diff && !me->isSummon())
            {
                DoSummon(me->GetEntry(), me->GetHomePosition());
                SpawnTimer = 8000;
            } else SpawnTimer -= diff;
        }
    };
};

#define SPELL_SLIME             49870

class mob_slime_trigger : public CreatureScript
{
public:
    mob_slime_trigger() : CreatureScript("mob_slime_trigger") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_slime_triggerAI(creature);
    }

    struct mob_slime_triggerAI : public ScriptedAI
    {
        mob_slime_triggerAI(Creature* creature) : ScriptedAI(creature) {}

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (me->GetPositionX() <= 3350.0f && me->GetPositionX() >= 3000.0f && me->GetPositionY() <= -3100.0f && me->GetPositionY() >= -3300.0f)
            {
                if (me->GetExactDist(who->GetPositionX(), who->GetPositionY(), who->GetPositionZ()) <= 3.35f && who->isAlive() && !who->HasAura(SPELL_SLIME))
                    if (me->GetInstanceScript())
                        if (me->GetInstanceScript()->GetBossState(BOSS_PATCHWERK) == IN_PROGRESS)
                            who->AddAura(SPELL_SLIME, who);
            }
            else
            {
                if (who->isAlive() && who->IsInWater() && !CAST_PLR(who)->isGameMaster())
                    me->Kill(who, false);
            }
        }
    };
};

class mob_avoid_corpsedecay : public CreatureScript
{
public:
    mob_avoid_corpsedecay() : CreatureScript("mob_avoid_corpsedecay") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mob_avoid_corpsedecayAI(creature);
    }

    struct mob_avoid_corpsedecayAI : public CombatAI
    {
        mob_avoid_corpsedecayAI(Creature* c) : CombatAI(c) {}

        uint32 combatStopTimer;
        bool combatStopEnabled;

        void MoveInLineOfSight(Unit* who)
        {
            if (!who || !me->GetMap())
                return;

            if (me->GetEntry() == 16236) // Augenstrunk
            {
                if (me->IsHostileTo(who) && me->GetDistance(who) <= 25.0f && !me->isInCombat())
                    if (me->Attack(who, false))
                    {
                        DoCast(who, me->GetMap()->IsHeroic() ? 54805 : 29407);
                        me->GetMotionMaster()->MoveIdle();
                        combatStopEnabled = true;
                        combatStopTimer = 6000;
                    }
            }
            else
                CombatAI::MoveInLineOfSight(who);
        }

        void JustDied(Unit* killer)
        {
            CombatAI::JustDied(killer);
            me->SetRespawnTime(me->GetRespawnDelay());
            me->setDeathState(DEAD);
            me->SelectNearbyTarget();
        }

        void UpdateAI(uint32 const diff)
        {
            if (me->GetEntry() == 16236) // Augenstrunk
            {
                if (!me->isInCombat())
                    return;
                else if (me->getThreatManager().isThreatListEmpty())
                {
                    EnterEvadeMode();
                    return;
                }

                if (combatStopTimer <= diff && combatStopEnabled)
                {
                    combatStopEnabled = false;
                    me->DeleteThreatList();
                }else combatStopTimer -= diff;
            }
            else
            {
                CombatAI::UpdateAI(diff);
            }
        }
    };
};

class npc_portal_naxxramas : public CreatureScript
{
public:
    npc_portal_naxxramas() : CreatureScript("npc_portal_naxxramas") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (!creature || !player || !creature->GetInstanceScript() || creature->GetMapId() != 533)
            return false;

        float x, y;
        creature->GetPosition(x, y);

        // Loatheb Teleporter
        if (x <= 2914.0f && x >= 2904.0f && y <= -4020.0f && y >= -4030.0f)
            if (creature->GetInstanceScript()->GetBossState(BOSS_LOATHEB) == DONE)
            {
                player->CastSpell(player, 72613, true); // Sapphiron Exit Spell, teleports to center
                return true;
            }

        // Four Horsemen Teleporter
        if (x <= 2498.0f && x >= 2488.0f && y <= -2916.0f && y >= -2926.0f)
            if (creature->GetInstanceScript()->GetBossState(BOSS_HORSEMEN) == DONE)
            {
                player->CastSpell(player, 72613, true); // Sapphiron Exit Spell, teleports to center
                return true;
            }

        // Maexxna Teleporter
        if (x <= 3474.0f && x >= 3464.0f && y <= -3929.0f && y >= -3939.0f)
            if (creature->GetInstanceScript()->GetBossState(BOSS_MAEXXNA) == DONE)
            {
                player->CastSpell(player, 72613, true); // Sapphiron Exit Spell, teleports to center
                return true;
            }

        // Thaddius Teleporter
        if (x <= 3543.0f && x >= 3533.0f && y <= -2931.0f && y >= -2941.0f)
            if (creature->GetInstanceScript()->GetBossState(BOSS_THADDIUS) == DONE)
            {
                player->CastSpell(player, 72613, true); // Sapphiron Exit Spell, teleports to center
                return true;
            }

        return false;
    }
};

void AddSC_instance_naxxramas()
{
    new instance_naxxramas();
    new mob_living_poison();
    new mob_slime_trigger();
    new mob_avoid_corpsedecay();
    new npc_portal_naxxramas();
}
