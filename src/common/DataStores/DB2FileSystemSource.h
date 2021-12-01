/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DB2FileSystemSource_h__
#define DB2FileSystemSource_h__

#include "DB2FileLoader.h"
#include <string>

struct COMMON_API DB2FileSystemSource : public DB2FileSource
{
    DB2FileSystemSource(std::string const& fileName);
    ~DB2FileSystemSource();
    bool IsOpen() const override;
    bool Read(void* buffer, std::size_t numBytes) override;
    std::size_t GetPosition() const override;
    std::size_t GetFileSize() const override;
    char const* GetFileName() const override;

private:
    std::string _fileName;
    FILE* _file;
};

#endif // DB2FileSystemSource_h__
