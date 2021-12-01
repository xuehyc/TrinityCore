/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CascHandles_h__
#define CascHandles_h__

#include <CascPort.h>
#include <memory>

namespace boost
{
    namespace filesystem
    {
        class path;
    }
}

namespace CASC
{
    struct StorageDeleter
    {
        typedef HANDLE pointer;
        void operator()(HANDLE handle);
    };

    struct FileDeleter
    {
        typedef HANDLE pointer;
        void operator()(HANDLE handle);
    };

    typedef std::unique_ptr<HANDLE, StorageDeleter> StorageHandle;
    typedef std::unique_ptr<HANDLE, FileDeleter> FileHandle;

    char const* HumanReadableCASCError(DWORD error);

    StorageHandle OpenStorage(boost::filesystem::path const& path, DWORD localeMask);
    DWORD GetBuildNumber(StorageHandle const& storage);
    DWORD GetInstalledLocalesMask(StorageHandle const& storage);

    FileHandle OpenFile(StorageHandle const& storage, char const* fileName, DWORD localeMask, bool printErrors = false);
    DWORD GetFileSize(FileHandle const& file, PDWORD fileSizeHigh);
    DWORD GetFilePointer(FileHandle const& file);
    bool ReadFile(FileHandle const& file, void* buffer, DWORD bytes, PDWORD bytesRead);
}

#endif // CascHandles_h__
