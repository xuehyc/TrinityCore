/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "DB2CascFileSource.h"
#include <CascLib.h>

DB2CascFileSource::DB2CascFileSource(CASC::StorageHandle const& storage, std::string fileName)
{
    _fileHandle = CASC::OpenFile(storage, fileName.c_str(), CASC_LOCALE_NONE, true);
    _fileName = std::move(fileName);
}

bool DB2CascFileSource::IsOpen() const
{
    return _fileHandle != nullptr;
}

bool DB2CascFileSource::Read(void* buffer, std::size_t numBytes)
{
    DWORD bytesRead = 0;
    return CASC::ReadFile(_fileHandle, buffer, numBytes, &bytesRead) && numBytes == bytesRead;
}

std::size_t DB2CascFileSource::GetPosition() const
{
    return CASC::GetFilePointer(_fileHandle);
}

std::size_t DB2CascFileSource::GetFileSize() const
{
    DWORD sizeLow = 0;
    DWORD sizeHigh = 0;
    sizeLow = CASC::GetFileSize(_fileHandle, &sizeHigh);
    return std::size_t(uint64(sizeLow) | (uint64(sizeHigh) << 32));
}

char const* DB2CascFileSource::GetFileName() const
{
    return _fileName.c_str();
}
