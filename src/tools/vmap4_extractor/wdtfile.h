/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef WDTFILE_H
#define WDTFILE_H

#include "cascfile.h"
#include "wmo.h"
#include <memory>
#include <string>
#include <vector>

class ADTFile;

class WDTFile
{
public:
    WDTFile(char const* storagePath, std::string mapName, bool cache);
    ~WDTFile();
    bool init(uint32 mapId);

    ADTFile* GetMap(int32 x, int32 y);
    void FreeADT(ADTFile* adt);
private:
    CASCFile _file;
    std::string _mapName;
    std::vector<std::string> _wmoNames;
    struct ADTCache
    {
        std::unique_ptr<ADTFile> file[64][64];
    };
    std::unique_ptr<ADTCache> _adtCache;
};

#endif
