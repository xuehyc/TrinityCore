/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef ADT_H
#define ADT_H

#include "cascfile.h"
#include "wmo.h"
#include "model.h"

#pragma pack(push, 1)
namespace ADT
{
    struct MDDF
    {
        uint32 Id;
        uint32 UniqueId;
        Vec3D Position;
        Vec3D Rotation;
        uint16 Scale;
        uint16 Flags;
    };

    struct MODF
    {
        uint32 Id;
        uint32 UniqueId;
        Vec3D Position;
        Vec3D Rotation;
        AaBox3D Bounds;
        uint16 Flags;
        uint16 DoodadSet;   // can be larger than number of doodad sets in WMO
        uint16 NameSet;
        uint16 Scale;
    };
}
#pragma pack(pop)

struct ADTOutputCache
{
    uint32 Flags;
    std::vector<uint8> Data;
};

class ADTFile
{
private:
    CASCFile _file;
    std::string Adtfilename;
    bool cacheable;
    std::vector<ADTOutputCache>* dirfileCache;
public:
    ADTFile(char* filename, bool cache);
    ~ADTFile();
    std::vector<std::string> WmoInstanceNames;
    std::vector<std::string> ModelInstanceNames;
    bool init(uint32 map_num, uint32 originalMapId);
    bool initFromCache(uint32 map_num, uint32 originalMapId);
};

char const* GetPlainName(char const* FileName);
char* GetPlainName(char* FileName);
char* GetExtension(char* FileName);
void FixNameCase(char* name, size_t len);
void FixNameSpaces(char* name, size_t len);
//void fixMapNamen(char *name, size_t len);

#endif
