/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

// This is where scripts' loading functions should be declared:
void AddSC_outdoorpvp_hp();
void AddSC_outdoorpvp_na();
void AddSC_outdoorpvp_si();
void AddSC_outdoorpvp_tf();
void AddSC_outdoorpvp_zm();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddOutdoorPvPScripts()
{
    AddSC_outdoorpvp_hp();
    AddSC_outdoorpvp_na();
    AddSC_outdoorpvp_si();
    AddSC_outdoorpvp_tf();
    AddSC_outdoorpvp_zm();
}
