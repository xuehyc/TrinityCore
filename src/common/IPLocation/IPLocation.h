/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "Define.h"
#include <string>
#include <vector>

struct IpLocationRecord
{
    IpLocationRecord() : IpFrom(0), IpTo(0) { }
    IpLocationRecord(uint32 ipFrom, uint32 ipTo, std::string countryCode, std::string countryName)
        : IpFrom(ipFrom), IpTo(ipTo), CountryCode(std::move(countryCode)), CountryName(std::move(countryName)) { }

    uint32 IpFrom;
    uint32 IpTo;
    std::string CountryCode;
    std::string CountryName;
};

class COMMON_API IpLocationStore
{
    public:
        IpLocationStore();
        ~IpLocationStore();
        static IpLocationStore* Instance();

        void Load();
        IpLocationRecord const* GetLocationRecord(std::string const& ipAddress) const;

    private:
        std::vector<IpLocationRecord> _ipLocationStore;
};

#define sIPLocation IpLocationStore::Instance()
