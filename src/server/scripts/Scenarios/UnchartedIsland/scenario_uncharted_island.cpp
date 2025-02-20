/*
 * Copyright 2021 ShadowCore
 * Copyright 2023 AzgathCore
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
#include "CombatAI.h"
#include "Creature.h"
#include "CreatureGroups.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Scenario.h"
#include "uncharted_island.h"


struct scenario_uncharted_island_tutorial : public InstanceScript
{
    scenario_uncharted_island_tutorial(InstanceMap* map) : InstanceScript(map) { }

    void OnPlayerEnter(Player* player) override
    {
        if (!player->GetScenario())
            return;

        Creature* rez = ObjectAccessor::GetCreature(*player, guid_rez);
        if (rez != nullptr)
        {
           // std::string text = "";
            rez->AI()->Talk(0);
        }
    }

    void OnCompletedCriteriaTree(CriteriaTree const* /*tree*/)
    {
            
    }

    void OnCreatureCreate(Creature* creature) override
    {
        switch (creature->GetEntry())
        {
        case NPC_CAPTAIN_REZ:
            guid_rez = creature->GetGUID();
            break;
        default:
            break;
        }
    };

    ObjectGuid GetGuidData(uint32 type) const override
    {
        switch (type)
        {
        case DATA_CAPTAIN_REZ:
            return guid_rez;
        default:
            break;
        }
        return ObjectGuid::Empty;
    }
protected:
    ObjectGuid guid_rez;
};

void AddSC_scenario_uncharted_island_tutorial()
{
    
}
