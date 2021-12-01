/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "Realm.h"
#include "IpAddress.h"
#include "IpNetwork.h"
#include "StringFormat.h"
#include <algorithm>
#include <cctype>

void Realm::SetName(std::string name)
{
    Name = name;
    NormalizedName = std::move(name);
    NormalizedName.erase(std::remove_if(NormalizedName.begin(), NormalizedName.end(), ::isspace), NormalizedName.end());
}

boost::asio::ip::address Realm::GetAddressForClient(boost::asio::ip::address const& clientAddr) const
{
    boost::asio::ip::address realmIp;

    // Attempt to send best address for client
    if (clientAddr.is_loopback())
    {
        // Try guessing if realm is also connected locally
        if (LocalAddress->is_loopback() || ExternalAddress->is_loopback())
            realmIp = clientAddr;
        else
        {
            // Assume that user connecting from the machine that bnetserver is located on
            // has all realms available in his local network
            realmIp = *LocalAddress;
        }
    }
    else
    {
        if (clientAddr.is_v4() && Server::Net::IsInNetwork(LocalAddress->to_v4(), LocalSubnetMask->to_v4(), clientAddr.to_v4()))
            realmIp = *LocalAddress;
        else
            realmIp = *ExternalAddress;
    }

    // Return external IP
    return realmIp;
}

uint32 Realm::GetConfigId() const
{
    return ConfigIdByType[Type];
}

uint32 const Realm::ConfigIdByType[MAX_CLIENT_REALM_TYPE] =
{
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
};

std::string Battlenet::RealmHandle::GetAddressString() const
{
    return Server::StringFormat("%u-%u-%u", Region, Site, Realm);
}

std::string Battlenet::RealmHandle::GetSubRegionAddress() const
{
    return Server::StringFormat("%u-%u-0", Region, Site);
}
