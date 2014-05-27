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

#define MAX_STANDARD_HEALTH 100000
#define TIME_TO_REGEN 60000 // 10 minutes
#define TIME_TO_CLAIM 180000   // 30 minutes
#define TIME_TO_DESPAWN 60000      // 5 seconds

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
            standardOwner = NULL;
            guildZoneId = sNullSecMgr->GetNullSecGuildZone(me->GetZoneId(), me->GetAreaId());
        }

        uint32 claimTimer;
        uint32 despawnTimer;
        uint32 regenTimer;
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

            if (!me->IsAlive())
                DeleteMe();
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

void AddSC_npc_standard_of_conquest()
{
    new npc_standard_of_conquest();
}

