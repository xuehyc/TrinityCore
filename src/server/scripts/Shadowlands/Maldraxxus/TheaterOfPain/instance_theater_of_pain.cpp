/*
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
#include "Player.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "AreaTrigger.h"
#include "AreaTriggerAI.h"
#include "InstanceScript.h"
#include "theater_of_pain.h"
#include "An_Affront_to_Challengers.cpp"
#include "Boss_Gorechop.cpp"
#include "Boss_Kul_tharok.cpp"
#include "Boss_Mordretha_the_Endless_Empress.cpp"
#include "Boss_Xav_the_Unfallen.cpp"

 //2293
struct instance_theater_of_pain : public InstanceScript
{
    instance_theater_of_pain(InstanceMap* map) : InstanceScript(map) {  }
};

void AddSC_instance_theater_of_pain()
{
}