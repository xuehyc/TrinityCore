﻿////XCore 2023.3.13
//void AddMaelstromScripts()
//{};


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
void AddSC_kezan();
void AddSC_deepholm();
void AddSC_instance_stonecore(); // Stonecore
void AddSC_stonecore();
void AddSC_boss_corborus();
void AddSC_boss_slabhide();
void AddSC_boss_ozruk();
void AddSC_boss_high_priestess_azil();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddMaelstromScripts()
{
    AddSC_kezan();
    AddSC_deepholm();
    AddSC_instance_stonecore(); // Stonecore
    AddSC_stonecore();
    AddSC_boss_corborus();
    AddSC_boss_slabhide();
    AddSC_boss_ozruk();
    AddSC_boss_high_priestess_azil();
}
