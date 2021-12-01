/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef VMAPEXPORT_H
#define VMAPEXPORT_H

#include "Define.h"
#include <string>
#include <unordered_map>

enum ModelFlags
{
    MOD_M2 = 1,
    MOD_HAS_BOUND = 1 << 1,
    MOD_PARENT_SPAWN = 1 << 2
};

struct WMODoodadData;

extern const char * szWorkDirWmo;
extern std::unordered_map<std::string, WMODoodadData> WmoDoodads;

uint32 GenerateUniqueObjectId(uint32 clientId, uint16 clientDoodadId);

bool FileExists(const char * file);

bool ExtractSingleWmo(std::string& fname);
bool ExtractSingleModel(std::string& fname);

void ExtractGameobjectModels();

#endif
