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

class instance_ulduar : public InstanceMapScript
{
public:
    instance_ulduar() : InstanceMapScript("instance_ulduar", 603) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_ulduar_InstanceMapScript(pMap);
    }

    struct instance_ulduar_InstanceMapScript : public InstanceScript
    {
        instance_ulduar_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {};

        uint32 uiEncounter[MAX_ENCOUNTER];

        std::string m_strInstData;

        uint64 uiLeviathanGUID;
        uint64 uiIgnisGUID;
        uint64 uiRazorscaleGUID;
        uint64 uiRazorscaleController;
        uint64 uiRazorHarpoonGUIDs[4];
        uint64 uiExpCommanderGUID;
        uint64 uiXT002GUID;
        uint64 uiAssemblyGUIDs[3];
        uint64 uiKologarnGUID;
        uint64 uiLeftArmGUID;
        uint64 uiRightArmGUID;
        uint64 uiAuriayaGUID;

        uint64 uiMimironTrainGUID;
        uint64 uiMimironGUID;
        uint64 uiLeviathanMKIIGUID;
        uint64 uiVX001GUID;
        uint64 uiAerialUnitGUID;
        uint64 uiMagneticCoreGUID;
        uint64 uiMimironElevatorGUID;
        std::list<uint64> uiMimironDoorGUIDList;

        uint64 uiHodirGUID;

        uint64 uiThorimGUID;
        uint64 uiThorimDoorGUID;
        uint64 uiRunicColossusGUID;
        uint64 uiRuneGiantGUID;
        uint64 uiRunicDoorGUID;
        uint64 uiStoneDoorGUID;

        uint64 uiFreyaGUID;
        uint64 uiElderBrightleafGUID;
        uint64 uiElderIronbranchGUID;
        uint64 uiElderStonebarkGUID;

        uint64 uiWayToYoggGUID;
        uint64 uiVezaxGUID;

        uint64 uiYoggSaronGUID;
        uint64 uiSaraGUID;

        uint64 uiAlgalonGUID;
        uint64 uiAlgalonBridgeGUID;
        uint64 uiAlgalonBridgeVisualGUID;
        uint64 uiAlgalonBridgeDoorGUID;
        uint64 uiAlgalonGlobeGUID;
        uint64 uiAlgalonDoor1GUID;
        uint64 uiAlgalonDoor2GUID;
        uint64 uiAlgalonAccessGUID;

        uint64 uiLeviathanDoor[7];
        uint64 uiLeviathanGateGUID;
        uint64 uiVezaxDoorGUID;
        uint64 uiYoggSaronDoorGUID;
        uint64 uiYoggSaronBrainDoor1GUID;
        uint64 uiYoggSaronBrainDoor2GUID;
        uint64 uiYoggSaronBrainDoor3GUID;

        uint64 uiKologarnChestGUID;
        uint64 uiKologarnBridgeGUID;
        uint64 uiKologarnDoorGUID;
        uint64 uiThorimChestGUID;
        uint64 uiHodirChestGUID;
        uint64 uiFreyaChestGUID;

        std::set<uint64> mRubbleSpawns;

        uint32 uiSupportKeeperFlag;
        uint32 uiPlayerDeathFlag;
        uint32 uiAlgalonKillCount;
        uint32 uiCountdownTimer;

        uint32 uiAlgalonCountdown;
        //   62 - not ready to engage
        //   61 - ready to engage, not engaged yet
        // < 61 - engaged, timer running
        //    0 - failed

        void Initialize()
        {
            SetBossNumber(MAX_ENCOUNTER);
            uiIgnisGUID             = 0;
            uiRazorscaleGUID        = 0;
            uiRazorscaleController  = 0;
            uiExpCommanderGUID      = 0;
            uiXT002GUID             = 0;
            uiKologarnGUID          = 0;
            uiLeftArmGUID           = 0;
            uiRightArmGUID          = 0;
            uiAuriayaGUID           = 0;
            uiMimironTrainGUID      = 0;
            uiMimironElevatorGUID   = 0;
            uiMimironGUID           = 0;
            uiLeviathanMKIIGUID     = 0;
            uiHodirGUID             = 0;
            uiThorimGUID            = 0;
            uiThorimDoorGUID        = 0;
            uiRunicDoorGUID         = 0;
            uiStoneDoorGUID         = 0;
            uiFreyaGUID             = 0;
            uiVezaxGUID             = 0;
            uiYoggSaronGUID         = 0;
            uiAlgalonGUID           = 0;
            uiAlgalonBridgeGUID     = 0;
            uiAlgalonBridgeVisualGUID = 0;
            uiAlgalonBridgeDoorGUID = 0;
            uiAlgalonGlobeGUID      = 0;
            uiAlgalonDoor1GUID      = 0;
            uiAlgalonDoor2GUID      = 0;
            uiAlgalonAccessGUID     = 0;
            uiSaraGUID              = 0;
            uiKologarnChestGUID     = 0;
            uiKologarnBridgeGUID    = 0;
            uiKologarnChestGUID     = 0;
            uiThorimChestGUID       = 0;
            uiHodirChestGUID        = 0;
            uiFreyaChestGUID        = 0;
            uiLeviathanGateGUID     = 0;
            uiVezaxDoorGUID         = 0;
            uiWayToYoggGUID         = 0;
            uiYoggSaronDoorGUID     = 0;
            uiYoggSaronBrainDoor1GUID = 0;
            uiYoggSaronBrainDoor2GUID = 0;
            uiYoggSaronBrainDoor3GUID = 0;
            uiSupportKeeperFlag     = 0;
            uiPlayerDeathFlag      = 0;
            uiAlgalonKillCount = 0;
            uiAlgalonCountdown = 62;
            uiCountdownTimer = 1*MINUTE*IN_MILLISECONDS;

            memset(uiEncounter, 0, sizeof(uiEncounter));
            memset(uiAssemblyGUIDs, 0, sizeof(uiAssemblyGUIDs));
            memset(&uiLeviathanDoor, 0, sizeof(uiLeviathanDoor));
            memset(uiRazorHarpoonGUIDs, 0, sizeof(uiRazorHarpoonGUIDs));
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (uiEncounter[i] == IN_PROGRESS)
                    return true;
            }

            return false;
        }

        uint32 TypeToDeadFlag(uint32 type)
        {
            uint32 return_value = 1;
            for(uint32 i = 0; i < type; i++)
            {
                return_value *= 2;
            }
            return return_value;
        }

        void OnPlayerKilled(Player *pPlayer) 
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            {
                if (uiEncounter[i] == IN_PROGRESS)
                {
                    if(i < TYPE_ALGALON)
                        uiPlayerDeathFlag |= eBossDeadFlags(TypeToDeadFlag(i));
                    else if(i == TYPE_ALGALON)
                        uiAlgalonKillCount++; // He feeds on your tears
                }
            }
        }

        void OnPlayerEnter(Player* player)
        {
            // I try to remove Achievement Progress in Boss Kills without Dying on Enter without a PermBind ...
            // This will work for 90% of all Players ... someone will found the backdoor (and i try to close this later)
            if(InstancePlayerBind* bind = player->GetBoundInstance(instance->GetId(),instance->GetDifficulty()))
            {
                if(bind->perm)
                    return;

                uint32 achievement = instance->GetDifficulty() == RAID_DIFFICULTY_10MAN_NORMAL? ACHIEVEMENT_CHAMPION_OF_ULDUAR : ACHIEVEMENT_CONQUEROR_OF_ULDUAR;

                if(!player->HasAchieved(achievement))
                   player->GetAchievementMgr().RemoveAchievement(achievement);
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target = NULL*/, uint32 /*miscvalue1 = 0*/)
        {
            switch(criteria_id)
            {
            // Kills without Death Achievement
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_FLAMELEVIATAN_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_FLAMELEVIATAN_25:
                return !(uiPlayerDeathFlag & DEAD_FLAME_LEVIATHAN);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_IGNIS_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_IGNIS_25:
                return !(uiPlayerDeathFlag & DEAD_IGNIS);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_RAZORSCALE_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_RAZORSCALE_25:
                return !(uiPlayerDeathFlag & DEAD_RAZORSCALE);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_XT002_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_XT002_25:
                return !(uiPlayerDeathFlag & DEAD_XT002);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_ASSEMBLY_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_ASSEMBLY_25:
                return !(uiPlayerDeathFlag & DEAD_ASSEMBLY);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_KOLOGARN_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_KOLOGARN_25:
                return !(uiPlayerDeathFlag & DEAD_KOLOGARN);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_AURIAYA_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_AURIAYA_25:
                return !(uiPlayerDeathFlag & DEAD_AURIAYA);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_HODIR_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_HODIR_25:
                return !(uiPlayerDeathFlag & DEAD_HODIR);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_THORIM_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_THORIM_25:
                return !(uiPlayerDeathFlag & DEAD_THORIM);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_FREYA_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_FREYA_25:
                return !(uiPlayerDeathFlag & DEAD_FREYA);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_MIMIRON_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_MIMIRON_25:
                return !(uiPlayerDeathFlag & DEAD_MIMIRON);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_VEZAX_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_VEZAX_25:
                return !(uiPlayerDeathFlag & DEAD_VEZAX);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_YOGGSARON_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_YOGGSARON_25:
                return !(uiPlayerDeathFlag & DEAD_YOGGSARON);
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_ALGALON_10:
            case ACHIEVEMENT_CRITERIA_KILL_WITHOUT_DEATHS_ALGALON_25:
                return !(uiAlgalonKillCount);
            }
            // Yogg-Saron
            switch(criteria_id)
            {
            case ACHIEVEMENT_CRITERIA_THE_ASSASSINATION_OF_KING_LLANE_10:
            case ACHIEVEMENT_CRITERIA_THE_ASSASSINATION_OF_KING_LLANE_25:
                {
                    if(GetBossState(TYPE_YOGGSARON) != IN_PROGRESS)
                        return false;

                    if(Creature* Sara = instance->GetCreature(uiSaraGUID))
                        return (Sara->AI()->GetData(DATA_PORTAL_PHASE) == 0);

                    return false;
                }
            case ACHIEVEMENT_CRITERIA_THE_TORTURED_CHAMPION_10:
            case ACHIEVEMENT_CRITERIA_THE_TORTURED_CHAMPION_25:
                {
                    if(GetBossState(TYPE_YOGGSARON) != IN_PROGRESS)
                        return false;

                    if(Creature* Sara = instance->GetCreature(uiSaraGUID))
                        return (Sara->AI()->GetData(DATA_PORTAL_PHASE) == 2);

                    return false;
                }
            case ACHIEVEMENT_CRITERIA_FORGING_OF_THE_DEMON_SOUL_10:
            case ACHIEVEMENT_CRITERIA_FORGING_OF_THE_DEMON_SOUL_25:
                {
                    if(GetBossState(TYPE_YOGGSARON) != IN_PROGRESS)
                        return false;

                    if(Creature* Sara = instance->GetCreature(uiSaraGUID))
                        return (Sara->AI()->GetData(DATA_PORTAL_PHASE) == 1);

                    return false;
                }
            }
            return false;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch(creature->GetEntry())
            {
                case NPC_LEVIATHAN:
                    uiLeviathanGUID = creature->GetGUID();
                    break;
                case NPC_IGNIS:
                    uiIgnisGUID = creature->GetGUID();
                    break;
                case NPC_RAZORSCALE:
                    uiRazorscaleGUID = creature->GetGUID();
                    break;
                case NPC_RAZORSCALE_CONTROLLER:
                    uiRazorscaleController = creature->GetGUID();
                    break;
                case NPC_EXPEDITION_COMMANDER:
                    uiExpCommanderGUID = creature->GetGUID();
                    return;
                case NPC_XT002:
                    uiXT002GUID = creature->GetGUID();
                    break;

                // Assembly of Iron
                case NPC_STEELBREAKER:
                    uiAssemblyGUIDs[0] = creature->GetGUID();
                    break;
                case NPC_MOLGEIM:
                    uiAssemblyGUIDs[1] = creature->GetGUID();
                    break;
                case NPC_BRUNDIR:
                    uiAssemblyGUIDs[2] = creature->GetGUID();
                    break;

                // Kologarn
                case NPC_KOLOGARN:
                    uiKologarnGUID = creature->GetGUID();
                    break;
                case NPC_KOLOGARN_BRIDGE:
                    // The below hacks are courtesy of the grid/visibilitysystem
                    if (GetBossState(TYPE_KOLOGARN) == DONE)
                    {
                        creature->SetDeadByDefault(true);
                        creature->setDeathState(CORPSE);
                        creature->DestroyForNearbyPlayers();
                        creature->UpdateObjectVisibility(true);
                    }
                    else
                    {
                        creature->SetDeadByDefault(false);
                        creature->setDeathState(CORPSE);
                        creature->RemoveCorpse(true);
                    }
                    break;

                case NPC_AURIAYA:
                    uiAuriayaGUID = creature->GetGUID();
                    break;

                // Mimiron
                case NPC_MIMIRON:
                    uiMimironGUID = creature->GetGUID();
                    break;
                case NPC_LEVIATHAN_MKII: uiLeviathanMKIIGUID = creature->GetGUID(); break;
                case NPC_VX_001: uiVX001GUID = creature->GetGUID(); break;
                case NPC_AERIAL_COMMAND_UNIT: uiAerialUnitGUID = creature->GetGUID(); break;
                case NPC_MAGNETIC_CORE: uiMagneticCoreGUID = creature->GetGUID(); break;

                case NPC_HODIR:
                    uiHodirGUID = creature->GetGUID();
                    break;

                // Thorim
                case NPC_THORIM:
                    uiThorimGUID = creature->GetGUID();
                    break;
                case NPC_RUNIC_COLOSSUS:
                    uiRunicColossusGUID = creature->GetGUID();
                    break;
                case NPC_RUNE_GIANT:
                    uiRuneGiantGUID = creature->GetGUID();
                    break;

                // Freya
                case NPC_FREYA:
                    uiFreyaGUID = creature->GetGUID();
                    break;
                case NPC_ELDER_BRIGHTLEAF:
                    uiElderBrightleafGUID = creature->GetGUID();
                    creature->setActive(true);
                    break;
                case NPC_ELDER_IRONBRANCH:
                    uiElderIronbranchGUID = creature->GetGUID();
                    creature->setActive(true);
                    break;
                case NPC_ELDER_STONEBARK:
                    uiElderStonebarkGUID = creature->GetGUID();
                    creature->setActive(true);
                    break;

                case NPC_VEZAX:
                    uiVezaxGUID = creature->GetGUID();
                    break;

                // Yogg-Saron
                case NPC_YOGGSARON:
                    uiYoggSaronGUID = creature->GetGUID();
                    break;
                case NPC_SARA:
                    uiSaraGUID = creature->GetGUID();
                    break;

                case NPC_ALGALON:
                    uiAlgalonGUID = creature->GetGUID();
                    if (uiAlgalonCountdown < 62)
                        creature->setFaction(7);
                    break;
            }

         }

        void OnGameObjectCreate(GameObject* go)
        {
            switch(go->GetEntry())
            {
                case GO_KOLOGARN_CHEST_HERO:
                case GO_KOLOGARN_CHEST:
                    uiKologarnChestGUID = go->GetGUID();
                    break;
                case GO_KOLOGARN_BRIDGE:
                    uiKologarnBridgeGUID = go->GetGUID();
                    if (GetBossState(TYPE_KOLOGARN) == DONE)
                        HandleGameObject(0, false, go);
                    break;
                case GO_KOLOGARN_DOOR:
                    uiKologarnDoorGUID = go->GetGUID();
                    break;
                case GO_THORIM_CHEST_HERO:
                case GO_THORIM_CHEST:
                    uiThorimChestGUID = go->GetGUID();
                    break;
                case GO_THORIM_ENCOUNTER_DOOR:
                    uiThorimDoorGUID = go->GetGUID();
                    break;
                case GO_THORIM_STONE_DOOR:
                    uiStoneDoorGUID = go->GetGUID();
                    break;
                case GO_THORIM_RUNIC_DOOR:
                    uiRunicDoorGUID = go->GetGUID();
                    break;
                case GO_HODIR_CHEST_HERO:
                case GO_HODIR_CHEST:
                    uiHodirChestGUID = go->GetGUID();
                    break;
                case GO_FREYA_CHEST_HERO:
                case GO_FREYA_CHEST:
                    uiFreyaChestGUID = go->GetGUID();
                    break;
                case GO_LEVIATHAN_DOOR:
                    //uiLeviathanDoor[flag] = go->GetGUID();
                    //HandleGameObject(NULL, true, go);
                    //flag++;
                    //if (flag == 7)
                    //    flag =0;
                    AddDoor(go, true);
                    break;
                case GO_LEVIATHAN_GATE:
                    uiLeviathanGateGUID = go->GetGUID();
                    if (GetBossState(TYPE_LEVIATHAN) == DONE)
                        go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                    else
                        HandleGameObject(NULL, false, go);
                    break;
                case GO_MIMIRON_TRAIN:
                    go->setActive(true);
                    uiMimironTrainGUID = go->GetGUID();
                    break;
                case GO_MIMIRON_ELEVATOR:
                    go->setActive(true);
                    uiMimironElevatorGUID = go->GetGUID();
                    break;
                case GO_MIMIRON_DOOR_1:
                case GO_MIMIRON_DOOR_2:
                case GO_MIMIRON_DOOR_3:
                    go->setActive(true);
                    uiMimironDoorGUIDList.push_back(go->GetGUID());
                    break;
                case GO_WAY_TO_YOGG:
                    uiWayToYoggGUID = go->GetGUID();
                    // DEBUG
                    //if(GetBossState(TYPE_FREYA) == DONE &&
                    //    GetBossState(TYPE_MIMIRON) == DONE &&
                    //    GetBossState(TYPE_HODIR) == DONE &&
                    //    GetBossState(TYPE_THORIM) == DONE)
                        go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
                    break;
                case GO_VEZAX_DOOR:
                    uiVezaxDoorGUID = go->GetGUID();
                    HandleGameObject(NULL, GetBossState(TYPE_VEZAX) == DONE, go);
                    break;
                case GO_YOGGSARON_DOOR:
                    uiYoggSaronDoorGUID = go->GetGUID();
                    HandleGameObject(NULL, true, go);
                    break;
                case GO_YOGGBRAIN_DOOR_1:
                    uiYoggSaronBrainDoor1GUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_YOGGBRAIN_DOOR_2:
                    uiYoggSaronBrainDoor2GUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                case GO_RAZOR_HARPOON_1:
                    uiRazorHarpoonGUIDs[0] = go->GetGUID();
                    break;
                case GO_RAZOR_HARPOON_2:
                    uiRazorHarpoonGUIDs[1] = go->GetGUID();
                    break;
                case GO_RAZOR_HARPOON_3:
                    uiRazorHarpoonGUIDs[2] = go->GetGUID();
                    break;
                case GO_RAZOR_HARPOON_4:
                    uiRazorHarpoonGUIDs[3] = go->GetGUID();
                    break;
                case GO_YOGGBRAIN_DOOR_3:
                    uiYoggSaronBrainDoor3GUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_PLATFORM:
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_BRIDGE:
                    uiAlgalonBridgeGUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_B_VISUAL:
                    uiAlgalonBridgeVisualGUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_B_DOOR:
                    uiAlgalonBridgeDoorGUID = go->GetGUID();
                    HandleGameObject(NULL, true, go);
                    break;
                case GO_ALGALON_GLOBE:
                    uiAlgalonGlobeGUID = go->GetGUID();
                    HandleGameObject(NULL, false, go);
                    break;
                case GO_ALGALON_DOOR_1:
                    uiAlgalonDoor1GUID = go->GetGUID();
                    HandleGameObject(NULL, uiAlgalonCountdown < 62 ? true : false, go);
                    break;
                case GO_ALGALON_DOOR_2:
                    uiAlgalonDoor2GUID = go->GetGUID();
                    HandleGameObject(NULL, uiAlgalonCountdown < 62 ? true : false, go);
                    break;
                case GO_ALGALON_ACCESS:
                    uiAlgalonAccessGUID = go->GetGUID();
                    if (uiAlgalonCountdown < 62)
                    {
                        go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_UNK1);
                        go->SetGoState(GO_STATE_ACTIVE);
                    }
                    break;
            }
        }

        void ProcessEvent(GameObject* /*go*/, uint32 eventId)
        {
            // Flame Leviathan's Tower Event triggers
           Creature* pFlameLeviathan = instance->GetCreature(uiLeviathanGUID);

            if (pFlameLeviathan && pFlameLeviathan->isAlive()) //No leviathan, no event triggering ;)
                switch(eventId)
                {
                    case EVENT_TOWER_OF_STORM_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(1);
                        break;
                    case EVENT_TOWER_OF_FROST_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(2);
                        break;
                    case EVENT_TOWER_OF_FLAMES_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(3);
                        break;
                    case EVENT_TOWER_OF_LIFE_DESTROYED:
                        pFlameLeviathan->AI()->DoAction(4);
                        break;
                }
        }

        void ProcessEvent(Unit* /*unit*/, uint32 /*eventId*/)
        {
        }

        bool SetBossState(uint32 type, EncounterState state)
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if(uiEncounter[type] != DONE)
                uiEncounter[type] = state;
            if(state == DONE)
                SaveToDB();

            switch (type)
            {
                case TYPE_LEVIATHAN:
                    if (state == IN_PROGRESS)
                        for (uint8 uiI = 0; uiI < 7; ++uiI)
                            HandleGameObject(uiLeviathanDoor[uiI],false);
                    else
                        for (uint8 uiI = 0; uiI < 7; ++uiI)
                            HandleGameObject(uiLeviathanDoor[uiI],true);
                    break;
                case TYPE_IGNIS:
                case TYPE_RAZORSCALE:
                case TYPE_XT002:
                case TYPE_ASSEMBLY:
                case TYPE_AURIAYA:
                    break;
                case TYPE_MIMIRON:
                    for(std::list<uint64>::iterator i = uiMimironDoorGUIDList.begin(); i != uiMimironDoorGUIDList.end(); i++)
                    {
                        if(GameObject* obj = instance->GetGameObject(*i))
                            obj->SetGoState(state == IN_PROGRESS ? GO_STATE_READY : GO_STATE_ACTIVE );
                    }
                    break;
                case TYPE_VEZAX:
                    if (state == DONE)
                        HandleGameObject(uiVezaxDoorGUID, true);
                    break;
                case TYPE_YOGGSARON:
                if(state == IN_PROGRESS)
                    HandleGameObject(uiYoggSaronDoorGUID,false);
                else
                    HandleGameObject(uiYoggSaronDoorGUID,true);
                    break;
                case TYPE_KOLOGARN:
                    if (state == DONE)
                    {
                        if (GameObject* go = instance->GetGameObject(uiKologarnChestGUID))
                            go->SetRespawnTime(go->GetRespawnDelay());
                        HandleGameObject(uiKologarnBridgeGUID, false);
                    }

                    HandleGameObject(uiKologarnDoorGUID, state != IN_PROGRESS);
                    break;
                case TYPE_HODIR:
                    if (state == DONE)
                        if (GameObject* go = instance->GetGameObject(uiHodirChestGUID))
                            go->SetRespawnTime(go->GetRespawnDelay());
                    break;
                case TYPE_THORIM:
                    if (state == DONE)
                        if (GameObject* go = instance->GetGameObject(uiThorimChestGUID))
                            go->SetRespawnTime(go->GetRespawnDelay());

                    if(GameObject* obj = instance->GetGameObject(uiThorimDoorGUID))
                        obj->SetGoState(state == IN_PROGRESS ? GO_STATE_READY : GO_STATE_ACTIVE );

                    break;
                case TYPE_FREYA:
                    if (state == DONE)
                        if (GameObject* go = instance->GetGameObject(uiFreyaChestGUID))
                            go->SetRespawnTime(go->GetRespawnDelay());
                    break;
                case TYPE_ALGALON:
                    switch (state)
                    {
                        case SPECIAL:
                            if (Creature* algalon = instance->GetCreature(uiAlgalonGUID))
                                algalon->setFaction(7);
                            HandleGameObject(uiAlgalonDoor1GUID, true);
                            HandleGameObject(uiAlgalonDoor2GUID, true);
                            uiAlgalonCountdown = 61;
                            SaveToDB();
                            break;
                        case NOT_STARTED:
                            HandleGameObject(uiAlgalonGlobeGUID, false);
                            HandleGameObject(uiAlgalonBridgeGUID, false);
                            HandleGameObject(uiAlgalonBridgeVisualGUID, false);
                            HandleGameObject(uiAlgalonBridgeDoorGUID, true);
                            break;
                        case IN_PROGRESS:
                            if (uiAlgalonCountdown > 60)
                            {
                                uiAlgalonCountdown = 60;
                                DoUpdateWorldState(WORLDSTATE_ALGALON_SHOW, 1);
                                DoUpdateWorldState(WORLDSTATE_ALGALON_TIME, uiAlgalonCountdown);
                                SaveToDB();
                            }
                            HandleGameObject(uiAlgalonGlobeGUID, true);
                            HandleGameObject(uiAlgalonBridgeGUID, true);
                            HandleGameObject(uiAlgalonBridgeVisualGUID, true);
                            HandleGameObject(uiAlgalonBridgeDoorGUID, false);
                            break;
                        case DONE:
                            //uiAlgalonCountdown = 1;
                            //uiCountdownTimer = 0;
                            HandleGameObject(uiAlgalonGlobeGUID, false);
                            HandleGameObject(uiAlgalonBridgeGUID, false);
                            HandleGameObject(uiAlgalonBridgeVisualGUID, false);
                            HandleGameObject(uiAlgalonBridgeDoorGUID, true);
                            break;
                    }
                    break;
             }

             if(GetBossState(TYPE_FREYA) == DONE &&
                 GetBossState(TYPE_MIMIRON) == DONE &&
                 GetBossState(TYPE_HODIR) == DONE &&
                 GetBossState(TYPE_THORIM) == DONE)
                if (GameObject* go = instance->GetGameObject(uiWayToYoggGUID))
                        go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_LOCKED);
             return true;
        }

        EncounterState GetBossState(uint32 type)
        {
            if(type > MAX_ENCOUNTER)
                return NOT_STARTED;

            return EncounterState(uiEncounter[type]);
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case TYPE_COLOSSUS:
                    uiEncounter[TYPE_COLOSSUS] = data;
                    if (data == 2)
                    {
                        if (Creature* pBoss = instance->GetCreature(uiLeviathanGUID))
                            pBoss->AI()->DoAction(10);
                        if (GameObject* pGate = instance->GetGameObject(uiLeviathanGateGUID))
                            pGate->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                        SaveToDB();
                    }
                    break;
                case DATA_CALL_TRAM:
                    if (GameObject* go = instance->GetGameObject(uiMimironTrainGUID))
                        go->UseDoorOrButton();
                    break;
                case DATA_MIMIRON_ELEVATOR:
                    if (GameObject* go = instance->GetGameObject(uiMimironElevatorGUID))
                        go->SetGoState(GOState(data));
                    break;
                case DATA_RUNIC_DOOR:
                    if (GameObject* go = instance->GetGameObject(uiRunicDoorGUID))
                        go->SetGoState(GOState(data));
                    break;
                case DATA_ADD_HELP_FLAG:
                    uiSupportKeeperFlag |= eKeeperSupport(data);
                    break;
                default:
                    break;
            }
        }

        void SetData64(uint32 type, uint64 data)
        {
            switch (type)
            {
                case DATA_LEFT_ARM:
                    uiLeftArmGUID = data;
                    break;
                case DATA_RIGHT_ARM:
                    uiRightArmGUID = data;
                    break;
            }
        }

        uint64 GetData64(uint32 data)
        {
            switch(data)
            {
                case TYPE_LEVIATHAN:            return uiLeviathanGUID;
                case TYPE_IGNIS:                return uiIgnisGUID;
                case TYPE_RAZORSCALE:           return uiRazorscaleGUID;
                case DATA_RAZORSCALE_CONTROL:   return uiRazorscaleController;
                case TYPE_XT002:                return uiXT002GUID;
                case TYPE_KOLOGARN:             return uiKologarnGUID;
                case DATA_LEFT_ARM:             return uiLeftArmGUID;
                case DATA_RIGHT_ARM:            return uiRightArmGUID;
                case TYPE_AURIAYA:              return uiAuriayaGUID;
                // Mimiron
                case TYPE_MIMIRON:              return uiMimironGUID;
                case DATA_LEVIATHAN_MK_II:      return uiLeviathanMKIIGUID;
                case DATA_VX_001:               return uiVX001GUID;
                case DATA_AERIAL_UNIT:          return uiAerialUnitGUID;
                case DATA_MAGNETIC_CORE:        return uiMagneticCoreGUID;

                case TYPE_HODIR:                return uiHodirGUID;

                // Thorim
                case TYPE_THORIM:               return uiThorimGUID;
                case DATA_RUNIC_COLOSSUS:       return uiRunicColossusGUID;
                case DATA_RUNE_GIANT:           return uiRuneGiantGUID;

                // Freya
                case TYPE_FREYA:                return uiFreyaGUID;
                case TYPE_ELDER_BRIGHTLEAF:     return uiElderBrightleafGUID;
                case TYPE_ELDER_IRONBRANCH:     return uiElderIronbranchGUID;
                case TYPE_ELDER_STONEBARK:      return uiElderStonebarkGUID;

                case TYPE_VEZAX:                return uiVezaxGUID;

                // Yogg-Saron
                case TYPE_YOGGSARON:            return uiYoggSaronGUID;
                case TYPE_SARA:                 return uiSaraGUID;
                // Algalon
                case TYPE_ALGALON:              return uiAlgalonGUID;
                // razorscale expedition commander
                case DATA_EXP_COMMANDER:        return uiExpCommanderGUID;
                case GO_RAZOR_HARPOON_1:        return uiRazorHarpoonGUIDs[0];
                case GO_RAZOR_HARPOON_2:        return uiRazorHarpoonGUIDs[1];
                case GO_RAZOR_HARPOON_3:        return uiRazorHarpoonGUIDs[2];
                case GO_RAZOR_HARPOON_4:        return uiRazorHarpoonGUIDs[3];
                // Assembly of Iron
                case DATA_STEELBREAKER:         return uiAssemblyGUIDs[0];
                case DATA_MOLGEIM:              return uiAssemblyGUIDs[1];
                case DATA_BRUNDIR:              return uiAssemblyGUIDs[2];

                case TYPE_BRAIN_DOOR_1 :        return uiYoggSaronBrainDoor1GUID;
                case TYPE_BRAIN_DOOR_2 :        return uiYoggSaronBrainDoor2GUID;
                case TYPE_BRAIN_DOOR_3 :        return uiYoggSaronBrainDoor3GUID;
            }

            return 0;
        }

        uint32 GetData(uint32 type)
        {
            switch(type)
            {
                case TYPE_COLOSSUS:
                    return uiEncounter[type];
                case DATA_KEEPER_SUPPORT_YOGG:
                    return uiSupportKeeperFlag;
            }

            return 0;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "U U " << GetBossSaveData() << GetData(TYPE_COLOSSUS) << " " << uiPlayerDeathFlag << " " << uiAlgalonCountdown;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn)
        {
            if (!strIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(strIn);

            char dataHead1, dataHead2;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'U' && dataHead2 == 'U')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;

                    if (i == TYPE_COLOSSUS)
                        SetData(i, tmpState);
                    else
                        SetBossState(i, EncounterState(tmpState));
                }
                uint32 tmpState, tmpState2, tmpState3;
                loadStream >> tmpState >> tmpState2 >> tmpState3;
                // tmpState == GetData(TYPE_COLOSSUS) (?)
                uiPlayerDeathFlag = tmpState2;
                uiAlgalonCountdown = tmpState3;
            }

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        void Update(uint32 diff)
        {
            if (uiAlgalonCountdown && uiAlgalonCountdown < 61)
            {
                if (uiCountdownTimer < diff)
                {
                    uiAlgalonCountdown--;

                    if (uiAlgalonCountdown)
                    {
                        DoUpdateWorldState(WORLDSTATE_ALGALON_SHOW, 1);
                        DoUpdateWorldState(WORLDSTATE_ALGALON_TIME, uiAlgalonCountdown);
                    }
                    else
                    {
                        DoUpdateWorldState(WORLDSTATE_ALGALON_SHOW, 0);
                    }
                    SaveToDB();
                    uiCountdownTimer += 1*MINUTE*IN_MILLISECONDS;
                }
                uiCountdownTimer -= diff;
            }
        }
    };
};

class go_call_tram : public GameObjectScript
{
public:
    go_call_tram() : GameObjectScript("go_call_tram") { }

    bool OnGossipHello(Player* /*pPlayer*/, GameObject* pGo)
    {
        InstanceScript* pInstance = pGo->GetInstanceScript();

        if (!pInstance)
            return false;

        switch(pGo->GetEntry())
        {
            case 194914:
            case 194438:
                pInstance->SetData(DATA_CALL_TRAM, 0);
                break;
            case 194912:
            case 194437:
                pInstance->SetData(DATA_CALL_TRAM, 1);
                break;
        }
        return true;
    }
};


void AddSC_instance_ulduar()
{
    new instance_ulduar();
    new go_call_tram();
}
