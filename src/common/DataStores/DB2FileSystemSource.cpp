/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "DB2FileSystemSource.h"
#include <boost/filesystem/operations.hpp>

DB2FileSystemSource::DB2FileSystemSource(std::string const& fileName)
{
    _fileName = fileName;
    _file = fopen(_fileName.c_str(), "rb");
}

DB2FileSystemSource::~DB2FileSystemSource()
{
    if (_file)
        fclose(_file);
}

bool DB2FileSystemSource::IsOpen() const
{
    return _file != nullptr;
}

bool DB2FileSystemSource::Read(void* buffer, std::size_t numBytes)
{
    return fread(buffer, numBytes, 1, _file) == 1;
}

std::size_t DB2FileSystemSource::GetPosition() const
{
    return ftell(_file);
}

std::size_t DB2FileSystemSource::GetFileSize() const
{
    boost::system::error_code error;
    std::size_t size = boost::filesystem::file_size(_fileName, error);
    return !error ? size : 0;
}

char const* DB2FileSystemSource::GetFileName() const
{
    return _fileName.c_str();
}
