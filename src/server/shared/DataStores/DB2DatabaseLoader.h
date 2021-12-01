/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DB2_DATABASE_LOADER_H
#define DB2_DATABASE_LOADER_H

#include "DB2FileLoader.h"
#include <string>
#include <vector>

enum HotfixDatabaseStatements : uint32;

struct SHARED_API DB2LoadInfo : public DB2FileLoadInfo
{
    DB2LoadInfo();
    DB2LoadInfo(DB2FieldMeta const* fields, std::size_t fieldCount, DB2Meta const* meta, HotfixDatabaseStatements statement);

    HotfixDatabaseStatements Statement;
};

class SHARED_API DB2DatabaseLoader
{
public:
    DB2DatabaseLoader(std::string const& storageName, DB2LoadInfo const* loadInfo) : _storageName(storageName), _loadInfo(loadInfo) { }

    char* Load(uint32& records, char**& indexTable, char*& stringHolders, std::vector<char*>& stringPool);
    void LoadStrings(uint32 locale, uint32 records, char** indexTable, std::vector<char*>& stringPool);
    static char* AddString(char const** holder, std::string const& value);

private:
    std::string _storageName;
    DB2LoadInfo const* _loadInfo;
};

#endif
