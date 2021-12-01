/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DB2CascFileSource_h__
#define DB2CascFileSource_h__

#include "DB2FileLoader.h"
#include "CascHandles.h"
#include <string>

struct DB2CascFileSource : public DB2FileSource
{
    DB2CascFileSource(CASC::StorageHandle const& storage, std::string fileName);
    bool IsOpen() const override;
    bool Read(void* buffer, std::size_t numBytes) override;
    std::size_t GetPosition() const override;
    std::size_t GetFileSize() const override;
    char const* GetFileName() const override;

private:
    CASC::FileHandle _fileHandle;
    std::string _fileName;
};

#endif // DB2CascFile_h__
