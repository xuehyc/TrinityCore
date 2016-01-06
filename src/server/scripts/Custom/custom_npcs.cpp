/*
* Copyright (C) 2008-2014 TrinityCore <http://www.trinitycore.org/>
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

/* ScriptData
SDName: custom_standard_of_conquest
SD%Complete: 100
SDComment: This NPC conquers a zone for the guild of the player that spawns it.
SDCategory: Custom
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "NullSecMgr.h"
#include "GuildMgr.h"
#include "ObjectMgr.h"

#define MAX_STANDARD_HEALTH 100000
#define TIME_TO_REGEN 60000               // 10 minutes
#define TIME_TO_CLAIM 180000              // 30 minutes
#define TIME_TO_DESPAWN 60000             // 5 seconds
#define TIME_TO_REMOVE_STEALTH 10000      // 10 seconds
#define MAX_REMOVE_STEALTH_DISTANCE 80.0f // 80 meters

enum States
{
    STANDARD_STATE_NONE     = 1,
    STANDARD_STATE_CLAIMING = 2,
    STANDARD_STATE_CLAIMED  = 3
};

class npc_standard_of_conquest : public CreatureScript
{
public:
    npc_standard_of_conquest() : CreatureScript("npc_standard_of_conquest") { }

    struct npc_standard_of_conquestAI : ScriptedAI
    {
        npc_standard_of_conquestAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
            standardState = STANDARD_STATE_NONE;
            claimTimer = TIME_TO_CLAIM;
            despawnTimer = TIME_TO_DESPAWN;
            regenTimer = TIME_TO_REGEN;
            removeStealthTimer = TIME_TO_REMOVE_STEALTH;
            standardOwner = NULL;
            guildZoneId = sNullSecMgr->GetNullSecGuildZone(me->GetZoneId(), me->GetAreaId());
        }

        uint32 claimTimer;
        uint32 despawnTimer;
        uint32 regenTimer;
        uint32 removeStealthTimer;
        uint32 standardState;
        uint32 guildZoneId;
        Guild* standardOwner;

        void InitializeAI() override
        {
            // This NPC can be only spawned in conquerable areas
            if (!guildZoneId)
                DeleteMe();

            me->SetMaxHealth(MAX_STANDARD_HEALTH / 4);
            me->SetHealth(MAX_STANDARD_HEALTH / 4);
            standardOwner = sNullSecMgr->GetGuildZoneAttacker(guildZoneId);
        }

        void Reset() override
        {
            claimTimer = TIME_TO_CLAIM;
            despawnTimer = TIME_TO_DESPAWN;
            regenTimer = TIME_TO_REGEN;
            removeStealthTimer = TIME_TO_REMOVE_STEALTH;
        }

        void EnterEvadeMode() override
        {
            if (standardState == STANDARD_STATE_CLAIMED)
                sNullSecMgr->SetGuildZoneUnderAttack(guildZoneId, false);
        }
        
        void DamageTaken(Unit* doneBy, uint32& damage) override
        {
            regenTimer = TIME_TO_REGEN;

            if (doneBy->GetTypeId() == TYPEID_PLAYER)
            {
                Guild* attacker = doneBy->ToPlayer()->GetGuild();
                if (attacker == standardOwner || !attacker)
                    damage = 0;
                else
                    sNullSecMgr->SetGuildZoneUnderAttack(guildZoneId, true, attacker);
            }
            else
                damage = 0;
        }

        void JustDied(Unit* /*killer*/) override
        {
            DeleteMe();
        }

        void UpdateAI(uint32 diff) override
        {
            if (standardState == STANDARD_STATE_NONE)
            {
                // NPC has just been summoned by a player to conquer a zone
                if (standardOwner)
                    standardState = STANDARD_STATE_CLAIMING;
                else
                {
                    // NPC has spawned in an already conquered zone, the owner is the zone controller.
                    standardOwner = sNullSecMgr->GetNullSecZoneOwner(guildZoneId);
                    if (standardOwner)
                    {
                        me->SetMaxHealth(MAX_STANDARD_HEALTH);
                        me->SetHealth(MAX_STANDARD_HEALTH);
                        standardState = STANDARD_STATE_CLAIMED;
                    }
                    // This case should not be possible anyway...
                    else
                        DeleteMe();
                }
            }

            if (standardState == STANDARD_STATE_CLAIMING)
            {
                if (claimTimer <= diff)
                {
                    me->SetMaxHealth(MAX_STANDARD_HEALTH);
                    me->SetHealth(MAX_STANDARD_HEALTH);
                    standardState = STANDARD_STATE_CLAIMED;
                    sNullSecMgr->SetNullSecZoneOwner(guildZoneId, standardOwner);
                }
                else
                    claimTimer -= diff;
            }

            if (standardState == STANDARD_STATE_CLAIMED)
            {
                if (removeStealthTimer <= diff)
                {
                    std::list<Player*> nearPlayers;
                    me->GetPlayerListInGrid(nearPlayers, MAX_REMOVE_STEALTH_DISTANCE);
                    for (std::list<Player*>::iterator itr = nearPlayers.begin(); itr != nearPlayers.end(); ++itr)
                    {
                        if ((*itr)->GetGuild() != standardOwner)
                            (*itr)->RemoveAurasByType(SPELL_AURA_MOD_STEALTH);
                    }
                    removeStealthTimer = TIME_TO_REMOVE_STEALTH;
                }
                else
                    removeStealthTimer -= diff;
            }
            
            if (UpdateVictim())
            {
                if (regenTimer <= diff)
                {
                    EnterEvadeMode();
                    regenTimer = TIME_TO_REGEN;
                }
                else
                    regenTimer -= diff;
            }
        }

        void DeleteMe()
        {
            if (standardState == STANDARD_STATE_CLAIMED && standardOwner)
                sNullSecMgr->RemoveGuildZoneOwner(guildZoneId);

            sNullSecMgr->SetGuildZoneUnderAttack(guildZoneId, false);
            me->CombatStop();
            me->DeleteFromDB();
            me->AddObjectToRemoveList();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_standard_of_conquestAI(creature);
    }
};

class npc_null_sec_gossip : public CreatureScript
{
public:
    npc_null_sec_gossip() : CreatureScript("npc_null_sec_gossip") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->GetZoneSecurityLevel() != ZONE_SECURITY_LEVEL_NULL)
            return false;

        if (player->IsGameMaster())
            return false;

        // The NPC will interact with the player only if his/her guild has conquered the zone or the zone has no owner
        Guild* zoneOwner = sNullSecMgr->GetNullSecZoneOwner(sNullSecMgr->GetNullSecGuildZone(creature->GetZoneId(), creature->GetAreaId()));
        if (zoneOwner == NULL)
            return false;

        if (player->GetGuild() == zoneOwner)
            return false;

        // do not interact with the player
        creature->Say("Lo siento pero no hablo con extrangeros. Es mejor que te vayas.", LANG_UNIVERSAL);
        player->PlayerTalkClass->ClearMenus();
        return true;
    }

    struct npc_null_sec_gossipAI : ScriptedAI
    {
        npc_null_sec_gossipAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void InitializeAI() override
        {
            // Add gossip flag if the unit doesn't have it
            if (!me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_null_sec_gossipAI(creature);
    }
};

/*######
## npc_tour_guide
######*/

#define QUEST_ID_HORDE_TOUR    50001
#define QUEST_ID_ALLIANCE_TOUR 50003
#define NPC_THUUL_IMAGE        50001
#define NPC_MALIN_IMAGE        50002
#define SAY_FOLLOW_THE_IMAGE   "Sigue a mi imagen, novato!"

class npc_tour_guide : public CreatureScript
{
public:
    npc_tour_guide() : CreatureScript("npc_tour_guide") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        uint32 npcId = 0;
        if (quest->GetQuestId() == QUEST_ID_HORDE_TOUR)
            npcId = NPC_THUUL_IMAGE;
        else if (quest->GetQuestId() == QUEST_ID_ALLIANCE_TOUR)
            npcId = NPC_MALIN_IMAGE;

        if (!npcId)
            return true;

        // Spawn the NPC
        Map* map = creature->GetMap();
        Creature* npcImage = new Creature();
        uint32 tempGuid = map->GenerateLowGuid<HighGuid::Unit>();
        if (!npcImage->Create(tempGuid, map, player->GetPhaseMaskForSpawn(), npcId, creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), creature->GetOrientation()))
        {
            delete npcImage;
            return false;
        }
        // Add to map
        map->AddToMap(npcImage);

        // TODO: Dialogue to DB
        creature->Say(SAY_FOLLOW_THE_IMAGE, LANG_UNIVERSAL);

        uint32 ficticialDamage = 0;
        npcImage->GetAI()->DamageTaken(player, ficticialDamage);
        return true;
    }
};

// This enum is used in the next two npc scripts

enum ImagePhases
{
    PHASE_MOVING_PVP_1       = 0,
    PHASE_MOVING_PVP_2       = 1,
    PHASE_PVP                = 2,
    PHASE_MOVING_BANK_1      = 3,
    PHASE_MOVING_BANK_2      = 4,
    PHASE_BANK               = 5,
    PHASE_MOVING_PROFESSIONS = 6,
    PHASE_PROFESSIONS        = 7,
    PHASE_MOVING_END_1       = 8,
    PHASE_MOVING_END_2       = 9,
    PHASE_END                = 10
};

/*######
## npc_thuul_image
######*/

enum ThuulImageTexts
{
    SAY_THUUL_MORE_JOUNG            = 0,
    SAY_THUUL_PVP_GENERAL           = 1,
    SAY_THUUL_PVP_HIGH_SEC          = 2,
    SAY_THUUL_PVP_LOW_SEC           = 3,
    SAY_THUUL_PVP_NULL_SEC          = 4,
    SAY_THUUL_PVP_CONQUERABLE_ZONES = 5,
    SAY_THUUL_FOLLOW_1              = 6,
    SAY_THUUL_BANKER                = 7,
    SAY_THUUL_FOLLOW_2              = 8,
    SAY_THUUL_PROFESSIONS_1         = 9,
    SAY_THUUL_PROFESSIONS_2         = 10,
    SAY_THUUL_PROFESSIONS_3         = 11,
    SAY_THUUL_NO_SOULBOUNDS         = 12,
    SAY_THUUL_FINISHING             = 13,
    SAY_THUUL_GOOD_LUCK             = 14,
    SAY_THUUL_TOO_FAR               = 15
};

enum ThuulImageWP
{
    WP_HALL_OF_LEGENDS_1 = 0,
    WP_HALL_OF_LEGENDS_2 = 1,
    WP_BANK_1            = 2,
    WP_BANK_2            = 3,
    WP_PROFESSIONS       = 4,
    WP_END_1             = 5,
    WP_END_2             = 6
};

const Position ThuulWP[7] = {
    { 1548.24f, -4209.17f, 43.21f, 0.10059f },
    { 1670.26f, -4225.17f, 56.39f, 3.72601f },
    { 1696.17f, -4276.21f, 33.58f, 4.71088f },
    { 1625.45f, -4374.25f, 12.00f, 3.87680f },
    { 1729.80f, -4480.47f, 31.90f, 5.08867f },
    { 1774.20f, -4535.73f, 24.79f, 6.25558f },
    { 1860.29f, -4513.38f, 23.87f, 3.64982f }
};

const float ThuulTeleportOrcPos[4] = { -610.07f, -4253.52f, 39.04f, 3.28122f };
const float ThuulTeleportTaurenPos[4] = { -2917.97f, -257.45f, 52.98f, 0.0f };
const float ThuulTeleportUndeadPos[4] = { 1665.48f, 1678.08f, 120.53f, 0.0f };

class npc_thuul_image : public CreatureScript
{
public:
    npc_thuul_image() : CreatureScript("npc_thuul_image") { }

    struct npc_thuul_imageAI : ScriptedAI
    {
        npc_thuul_imageAI(Creature* creature) : ScriptedAI(creature)
        {
            phase = PHASE_MOVING_PVP_1;
            nextSay = SAY_THUUL_MORE_JOUNG;
            teleportTimer = 0;
            sayTimer = 600000;
            forceDespawnTimer = 900000; // 15 minutes
            player = NULL;
        }

        uint8 phase;
        uint8 nextSay;
        Player* player;
        uint32 sayTimer;  // Controls time between talks
        uint32 teleportTimer;
        uint32 forceDespawnTimer;

        void EnterEvadeMode() override
        {
            DeleteMe();
        }

        void DamageTaken(Unit* doneBy, uint32& damage) override
        {
            if (doneBy->GetTypeId() != TYPEID_PLAYER)
            {
                damage = 0;
                return;
            }

            if (player)
            {
                damage = 0;
                return;
            }

            player = doneBy->ToPlayer();
            // Start first movement
            me->GetMotionMaster()->MovePoint(1, ThuulWP[WP_HALL_OF_LEGENDS_1], true);
            nextSay = SAY_THUUL_MORE_JOUNG;
            sayTimer = 3000;
        }

        void UpdateAI(uint32 diff) override
        {
            // Emergency check, for example if player disconnects,
            // the NPC will despawn in several minutes.
            if (forceDespawnTimer <= diff)
                DeleteMe();
            else
                forceDespawnTimer -= diff;

            // Player has disconnected / is not set yet?
            if (!player)
                return;

            // If the player is too far from the NPC, set the mission as failed.
            if (player->GetDistance(me->GetPosition()) > 50.0f)
            {
                Talk(SAY_THUUL_TOO_FAR, player);
                player->SetQuestStatus(QUEST_ID_HORDE_TOUR, QUEST_STATUS_FAILED);
                DeleteMe();
            }

            // Control phases
            switch (phase)
            {
                case PHASE_MOVING_PVP_1:
                    if (me->GetDistance(ThuulWP[WP_HALL_OF_LEGENDS_1]) < 1.0f)
                    {
                        me->GetMotionMaster()->MovePoint(1, ThuulWP[WP_HALL_OF_LEGENDS_2]);
                        phase = PHASE_MOVING_PVP_2;
                    }
                    break;
                case PHASE_MOVING_PVP_2:
                    if (me->GetDistance(ThuulWP[WP_HALL_OF_LEGENDS_2]) < 1.0f)
                    {
                        sayTimer = 2000;
                        phase = PHASE_PVP;
                    }
                    break;
                case PHASE_MOVING_BANK_1:
                    if (me->GetDistance(ThuulWP[WP_BANK_1]) < 1.0f)
                    {
                        me->GetMotionMaster()->MovePoint(1, ThuulWP[WP_BANK_2]);
                        phase = PHASE_MOVING_BANK_2;
                    }
                    break;
                case PHASE_MOVING_BANK_2:
                    if (me->GetDistance(ThuulWP[WP_BANK_2]) < 1.0f)
                    {
                        sayTimer = 2000;
                        phase = PHASE_BANK;
                    }
                    break;
                case PHASE_MOVING_PROFESSIONS:
                    if (me->GetDistance(ThuulWP[WP_PROFESSIONS]) < 1.0f)
                    {
                        sayTimer = 2000;
                        me->GetMotionMaster()->Clear();
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(1, ThuulWP[WP_END_1], true);
                        phase = PHASE_MOVING_END_1;
                    }
                    break;
                case PHASE_MOVING_END_1:
                    if (me->GetDistance(ThuulWP[WP_END_1]) < 1.0f)
                    {
                        me->GetMotionMaster()->MovePoint(1, ThuulWP[WP_END_2], true);
                        phase = PHASE_MOVING_END_2;
                    }
                    break;
                case PHASE_MOVING_END_2:
                    if (me->GetDistance(ThuulWP[WP_END_2]) < 1.0f)
                    {
                        sayTimer = 2000;
                        teleportTimer = 60000;
                        phase = PHASE_END;
                    }
                    break;
                default:
                    break;
            }

            // Control say timer (also phases when the chat ends)
            if (sayTimer <= diff && nextSay <= SAY_THUUL_GOOD_LUCK)
            {
                me->ToCreature()->Say(nextSay, player);
                switch (nextSay)
                {
                    case SAY_THUUL_MORE_JOUNG:
                        sayTimer = 600000;
                        break;
                    case SAY_THUUL_PVP_GENERAL:
                        me->SetFacingToObject(player);
                        sayTimer = 7000;
                        break;
                    case SAY_THUUL_PVP_HIGH_SEC:
                        sayTimer = 10000;
                        break;
                    case SAY_THUUL_PVP_LOW_SEC:
                        sayTimer = 13000;
                        break;
                    case SAY_THUUL_PVP_NULL_SEC:
                        sayTimer = 11000;
                        break;
                    case SAY_THUUL_PVP_CONQUERABLE_ZONES:
                        sayTimer = 10000;
                        break;
                    case SAY_THUUL_FOLLOW_1:
                        sayTimer = 600000;
                        me->GetMotionMaster()->MovePoint(1, ThuulWP[WP_BANK_1], true);
                        phase = PHASE_MOVING_BANK_1;
                        break;
                    case SAY_THUUL_BANKER:
                        me->SetFacingToObject(player);
                        sayTimer = 10000;
                        break;
                    case SAY_THUUL_FOLLOW_2:
                        sayTimer = 600000;
                        me->GetMotionMaster()->MovePoint(1, ThuulWP[WP_PROFESSIONS], true);
                        phase = PHASE_MOVING_PROFESSIONS;
                        break;
                    case SAY_THUUL_PROFESSIONS_1:
                        sayTimer = 12000;
                        break;
                    case SAY_THUUL_PROFESSIONS_2:
                        sayTimer = 12000;
                        break;
                    case SAY_THUUL_PROFESSIONS_3:
                        sayTimer = 10000;
                        break;
                    case SAY_THUUL_NO_SOULBOUNDS:
                        sayTimer = 600000;
                        break;
                    case SAY_THUUL_FINISHING:
                        me->SetFacingToObject(player);
                        sayTimer = 9000;
                        break;
                    case SAY_THUUL_GOOD_LUCK:
                        teleportTimer = 3000;
                        break;
                    default:
                        break;
                }
                ++nextSay;
            }
            else
                sayTimer -= diff;

            // Control teleport
            if (phase == PHASE_END)
            {
                if (teleportTimer <= diff)
                {
                    switch (player->getRace())
                    {
                        case RACE_ORC:
                        case RACE_TROLL:
                            player->TeleportTo(1, ThuulTeleportOrcPos[0], ThuulTeleportOrcPos[1], ThuulTeleportOrcPos[2], ThuulTeleportOrcPos[3]);
                            break;
                        case RACE_TAUREN:
                            player->TeleportTo(1, ThuulTeleportTaurenPos[0], ThuulTeleportTaurenPos[1], ThuulTeleportTaurenPos[2], ThuulTeleportTaurenPos[3]);
                            break;
                        case RACE_UNDEAD_PLAYER:
                            player->TeleportTo(0, ThuulTeleportUndeadPos[0], ThuulTeleportUndeadPos[1], ThuulTeleportUndeadPos[2], ThuulTeleportUndeadPos[3]);
                            break;
                        default:
                            break;
                    }
                    DeleteMe();
                }
                else
                    teleportTimer -= diff;
            }
        }

        void DeleteMe()
        {
            me->CombatStop();
            me->CleanupsBeforeDelete();
            me->AddObjectToRemoveList();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_thuul_imageAI(creature);
    }
};

/*######
## npc_malin_image
######*/

enum MalinImageTexts
{
    SAY_MALIN_MORE_JOUNG            = 0,
    SAY_MALIN_PVP_HIGH_SEC          = 1,
    SAY_MALIN_PVP_LOW_SEC           = 2,
    SAY_MALIN_PVP_NULL_SEC          = 3,
    SAY_MALIN_PVP_CONQUERABLE_ZONES = 4,
    SAY_MALIN_FOLLOW_1              = 5,
    SAY_MALIN_BANKER                = 6,
    SAY_MALIN_FOLLOW_2              = 7,
    SAY_MALIN_PROFESSIONS_1         = 8,
    SAY_MALIN_PROFESSIONS_2         = 9,
    SAY_MALIN_PROFESSIONS_3         = 10,
    SAY_MALIN_NO_SOULBOUNDS         = 11,
    SAY_MALIN_PVP_GENERAL           = 12,
    SAY_MALIN_FINISHING             = 13,
    SAY_MALIN_GOOD_LUCK             = 14,
    SAY_MALIN_TOO_FAR               = 15
};

enum MalinImageWP
{
    WP_MAGE_QUARTER   = 0,
    WP_BRIDGE_1       = 1,
    WP_BANK           = 2,
    WP_TRADE_QUARTER  = 3,
    WP_BRIDGE_2       = 4,
    WP_OLD_TOWN       = 5,
    WP_CHAMPIONS_HALL = 6
};

const Position MalinWP[7] = {
    { -8916.56f, 786.25f, 87.22f, 0.67f },
    { -8856.15f, 741.06f, 100.66f, 5.21f },
    { -8913.28f, 625.00f, 99.52f, 0.48f },
    { -8803.16f, 593.46f, 97.27f, 5.87f },
    { -8717.90f, 516.45f, 96.77f, 4.46f },
    { -8721.50f, 424.04f, 97.85f, 4.17f },
    { -8773.59f, 416.46f, 103.95f, 5.32f }
};

const float MalinTeleportDwarfPos[4] = { -6232.01f, 333.55f, 383.18f, 3.65f };
const float MalinTeleportNightElfPos[4] = { 10318.66f, 830.67f, 1326.38f, 3.32f };
const float MalinTeleportHumanPos[4] = { -8950.61f, -132.75f, 83.52f, 0.17f };

class npc_malin_image : public CreatureScript
{
public:
    npc_malin_image() : CreatureScript("npc_malin_image") { }

    struct npc_malin_imageAI : ScriptedAI
    {
        npc_malin_imageAI(Creature* creature) : ScriptedAI(creature)
        {
            phase = WP_MAGE_QUARTER;
            nextSay = SAY_MALIN_MORE_JOUNG;
            teleportTimer = 0;
            sayTimer = 600000;
            forceDespawnTimer = 900000; // 15 minutes
            player = NULL;
        }

        uint8 phase;
        uint8 nextSay;
        Player* player;
        uint32 sayTimer;  // Controls time between talks
        uint32 teleportTimer;
        uint32 forceDespawnTimer;

        void EnterEvadeMode() override
        {
            DeleteMe();
        }

        void DamageTaken(Unit* doneBy, uint32& damage) override
        {
            if (doneBy->GetTypeId() != TYPEID_PLAYER)
            {
                damage = 0;
                return;
            }

            if (player)
            {
                damage = 0;
                return;
            }

            player = doneBy->ToPlayer();
            // Start first movement
            me->SetWalk(true);
            me->GetMotionMaster()->MovePoint(1, MalinWP[WP_MAGE_QUARTER], true);
            nextSay = SAY_MALIN_MORE_JOUNG;
            sayTimer = 3000;
        }

        void UpdateAI(uint32 diff) override
        {
            // Emergency check, for example if player disconnects,
            // the NPC will despawn in several minutes.
            if (forceDespawnTimer <= diff)
                DeleteMe();
            else
                forceDespawnTimer -= diff;

            // Player has disconnected / is not set yet?
            if (!player)
                return;

            // If the player is too far from the NPC, set the mission as failed.
            if (player->GetDistance(me->GetPosition()) > 50.0f)
            {
                Talk(SAY_MALIN_TOO_FAR, player);
                player->SetQuestStatus(QUEST_ID_ALLIANCE_TOUR, QUEST_STATUS_FAILED);
                DeleteMe();
            }

            // Control phases
            switch (phase)
            {
            case PHASE_MOVING_PVP_1:
                if (me->GetDistance(MalinWP[WP_MAGE_QUARTER]) < 1.0f)
                {
                    me->GetMotionMaster()->MovePoint(1, MalinWP[WP_BRIDGE_1]);
                    phase = PHASE_MOVING_PVP_2;
                }
                break;
            case PHASE_MOVING_PVP_2:
                if (me->GetDistance(MalinWP[WP_BRIDGE_1]) < 1.0f)
                {
                    me->SetWalk(false);
                    me->GetMotionMaster()->MovePoint(1, MalinWP[WP_BANK]);
                    sayTimer = 1000;
                    phase = PHASE_MOVING_BANK_1;
                }
                break;
            case PHASE_MOVING_BANK_1:
                if (me->GetDistance(MalinWP[WP_BANK]) < 1.0f)
                {
                    sayTimer = 2000;
                    phase = PHASE_BANK;
                }
                break;
            case PHASE_MOVING_BANK_2:
                if (me->GetDistance(MalinWP[WP_TRADE_QUARTER]) < 1.0f)
                {
                    me->GetMotionMaster()->MovePoint(1, MalinWP[WP_BRIDGE_2]);
                    phase = PHASE_MOVING_PROFESSIONS;
                }
                break;
            case PHASE_MOVING_PROFESSIONS:
                if (me->GetDistance(MalinWP[WP_BRIDGE_2]) < 1.0f)
                {
                    sayTimer = 2000;
                    me->GetMotionMaster()->Clear();
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(1, MalinWP[WP_OLD_TOWN], true);
                    phase = PHASE_MOVING_END_1;
                }
                break;
            case PHASE_MOVING_END_1:
                if (me->GetDistance(MalinWP[WP_OLD_TOWN]) < 1.0f)
                {
                    me->GetMotionMaster()->MovePoint(1, MalinWP[WP_CHAMPIONS_HALL], true);
                    phase = PHASE_MOVING_END_2;
                }
                break;
            case PHASE_MOVING_END_2:
                if (me->GetDistance(MalinWP[WP_CHAMPIONS_HALL]) < 1.0f)
                {
                    sayTimer = 2000;
                    teleportTimer = 60000;
                    phase = PHASE_END;
                }
                break;
            default:
                break;
            }

            // Control say timer (also phases when the chat ends)
            if (sayTimer <= diff && nextSay <= SAY_MALIN_GOOD_LUCK)
            {
                Talk(nextSay, player);
                switch (nextSay)
                {
                case SAY_MALIN_MORE_JOUNG:
                    sayTimer = 7000;
                    break;
                case SAY_MALIN_PVP_HIGH_SEC:
                    sayTimer = 12000;
                    break;
                case SAY_MALIN_PVP_LOW_SEC:
                    sayTimer = 15000;
                    break;
                case SAY_MALIN_PVP_NULL_SEC:
                    sayTimer = 15000;
                    break;
                case SAY_MALIN_PVP_CONQUERABLE_ZONES:
                    sayTimer = 600000;
                    break;
                case SAY_MALIN_FOLLOW_1:
                    sayTimer = 600000;
                    break;
                case SAY_MALIN_BANKER:
                    sayTimer = 10000;
                    break;
                case SAY_MALIN_FOLLOW_2:
                    sayTimer = 600000;
                    me->GetMotionMaster()->MovePoint(1, MalinWP[WP_TRADE_QUARTER]);
                    phase = PHASE_MOVING_BANK_2;
                    break;
                case SAY_MALIN_PROFESSIONS_1:
                    sayTimer = 13000;
                    break;
                case SAY_MALIN_PROFESSIONS_2:
                    sayTimer = 13000;
                    break;
                case SAY_MALIN_PROFESSIONS_3:
                    sayTimer = 12000;
                    break;
                case SAY_MALIN_NO_SOULBOUNDS:
                    sayTimer = 600000;
                    break;
                case SAY_MALIN_PVP_GENERAL:
                    me->SetFacingToObject(player);
                    sayTimer = 7000;
                    break;
                case SAY_MALIN_FINISHING:
                    sayTimer = 9000;
                    break;
                case SAY_MALIN_GOOD_LUCK:
                    teleportTimer = 3000;
                    break;
                default:
                    break;
                }
                ++nextSay;
            }
            else
                sayTimer -= diff;

            // Control teleport
            if (phase == PHASE_END)
            {
                if (teleportTimer <= diff)
                {
                    switch (player->getRace())
                    {
                        case RACE_DWARF:
                        case RACE_GNOME:
                            player->TeleportTo(0, MalinTeleportDwarfPos[0], MalinTeleportDwarfPos[1], MalinTeleportDwarfPos[2], MalinTeleportDwarfPos[3]);
                            break;
                        case RACE_NIGHTELF:
                            player->TeleportTo(1, MalinTeleportNightElfPos[0], MalinTeleportNightElfPos[1], MalinTeleportNightElfPos[2], MalinTeleportNightElfPos[3]);
                            break;
                        case RACE_HUMAN:
                            player->TeleportTo(0, MalinTeleportHumanPos[0], MalinTeleportHumanPos[1], MalinTeleportHumanPos[2], MalinTeleportHumanPos[3]);
                            break;
                        default:
                            break;
                    }
                    DeleteMe();
                }
                else
                    teleportTimer -= diff;
            }
        }

        void DeleteMe()
        {
            me->CombatStop();
            me->CleanupsBeforeDelete();
            me->AddObjectToRemoveList();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_malin_imageAI(creature);
    }
};

void AddSC_custom_npcs()
{
    new npc_standard_of_conquest();
    new npc_null_sec_gossip();
    new npc_tour_guide();
    new npc_thuul_image();
    new npc_malin_image();
}
