/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
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

// This is where scripts' loading functions should be declared:


// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddSC_FireWorksOnLevelUp();
void AddSolocraftScripts();
void AddSC_skip_StarterArea();
void AddSC_start_equipment();
void AddSC_XpWeekend();
void AddSC_AutoBalance();
void AddLfgSoloScripts();
void AddMoneyForKillsScripts();
void AddGainHonorGuardScripts();
void AddGainConquestGuardScripts();
void AddSC_Death_Announcer();
void AddSC_save_on_levelup();
void AddSC_WhoLoggedScripts();
void AddSC_racial_traits_npc();
void AddSC_Band_aid();
void AddSC_announce_login();

void AddCustomScripts()
{
    AddSC_FireWorksOnLevelUp();
	AddSolocraftScripts();
	AddSC_skip_StarterArea();
    AddSC_start_equipment();
    AddSC_XpWeekend();
    AddSC_AutoBalance();
    AddLfgSoloScripts();
    AddMoneyForKillsScripts();
    AddGainHonorGuardScripts();
    AddGainConquestGuardScripts();
    AddSC_Death_Announcer();
    AddSC_save_on_levelup();
    AddSC_WhoLoggedScripts();
    AddSC_racial_traits_npc();
    AddSC_Band_aid();
    AddSC_announce_login();
}
