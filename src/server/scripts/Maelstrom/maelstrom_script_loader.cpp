/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

// This is where scripts' loading functions should be declared:
void AddSC_kezan();
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
    AddSC_instance_stonecore(); // Stonecore
    AddSC_stonecore();
    AddSC_boss_corborus();
    AddSC_boss_slabhide();
    AddSC_boss_ozruk();
    AddSC_boss_high_priestess_azil();
}
