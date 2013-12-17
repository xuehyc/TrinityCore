/*
 *
 * Copyright (C) 2011-2013 ArkCORE <http://www.arkania.net/>
 *
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 *
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
SDName: Gilneas
SD%Complete: 1
SDComment: Quest support: 14078
SDCategory: Gilneas
EndScriptData */

/* ContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

enum Data
{
};

enum Data64
{
};

enum CreatureIds
{
    NPC_PRINCE_LIAM_GREYMANE                          = 34913,
    NPC_GILNEAS_CITY_GUARD                            = 34916,
    NPC_RAMPAGING_WORGEN_1                            = 34884,
    NPC_RAMPAGING_WORGEN_2                            = 35660,
    NPC_BLOODFANG_WORGEN                              = 35118,
    NPC_SERGEANT_CLEESE                               = 35839,
    NPC_MYRIAM_SPELLWALKER                            = 35872,
    NPC_GILNEAN_ROYAL_GUARD                           = 35232,
    NPC_FRIGHTENED_CITIZEN_1                          = 34981,
    NPC_FRIGHTENED_CITIZEN_2                          = 35836,
    NPC_DARIUS_CROWLEY                                = 35230,
    NPC_NORTHGATE_REBEL_1                             = 36057,//phase 8 outside cathedral
    NPC_NORTHGATE_REBEL_2                             = 41015,//phase 1024 inside cathedral
    NPC_BLOODFANG_STALKER_C1                          = 35229,//Main spawns
    NPC_BLOODFANG_STALKER_C2                          = 51277,
    NPC_BLOODFANG_STALKER_CREDIT                      = 35582,
	SPELL_PHASE_QUEST_2                               = 59073,
    NPC_CROWLEY_HORSE                                 = 35231
};

enum GameObjectIds
{
};

enum QuestIds
{
    QUEST_LOCKDOWN                                     = 14078,
    QUEST_EVAC_MERC_SQUA                               = 14098,
	QUEST_SAVE_KRENNAN_ARANAS                          = 14293,
	QUEST_SACRIFICES                                   = 14212
};

enum SpellIds
{
    SPELL_ENRAGE                                       = 8599,
    SPELL_FROSTBOLT_VISUAL_ONLY                        = 74277, //Dummy spell, visual only
    SPELL_SUMMON_CROWLEY                               = 67004,
    SPELL_RIDE_HORSE                                   = 43671,
    SPELL_THROW_TORCH                                  = 67063,
    SPELL_RIDE_VEHICLE_HARDCODED                       = 46598
};


class npc_lieutenant_walden_p1 : public CreatureScript
{
public:
    npc_lieutenant_walden_p1() : CreatureScript("npc_lieutenant_walden_p1") {}

    bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 /*opt*/)
    {
        if(quest->GetQuestId() == QUEST_LOCKDOWN) OVERRIDE
        {
            player->CastSpell(player, SPELL_PHASE_QUEST_2, true);
        }
        return true;
    }
};

/*######
## AddSC
######*/

void AddSC_gilneas()
{
    new npc_lieutenant_walden_p1();
}
