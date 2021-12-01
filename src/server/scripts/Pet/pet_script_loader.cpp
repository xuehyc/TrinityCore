/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

// This is where scripts' loading functions should be declared:
void AddSC_deathknight_pet_scripts();
void AddSC_generic_pet_scripts();
void AddSC_hunter_pet_scripts();
void AddSC_mage_pet_scripts();
void AddSC_priest_pet_scripts();
void AddSC_shaman_pet_scripts();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddPetScripts()
{
    AddSC_deathknight_pet_scripts();
    AddSC_generic_pet_scripts();
    AddSC_hunter_pet_scripts();
    AddSC_mage_pet_scripts();
    AddSC_priest_pet_scripts();
    AddSC_shaman_pet_scripts();
}
