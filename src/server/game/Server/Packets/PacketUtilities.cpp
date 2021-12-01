/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "PacketUtilities.h"
#include "Errors.h"
#include <sstream>

WorldPackets::PacketArrayMaxCapacityException::PacketArrayMaxCapacityException(std::size_t requestedSize, std::size_t sizeLimit)
{
    std::ostringstream builder;
    builder << "Attempted to read more array elements from packet " << requestedSize << " than allowed " << sizeLimit;
    message().assign(builder.str());
}

void WorldPackets::CheckCompactArrayMaskOverflow(std::size_t index, std::size_t limit)
{
    ASSERT(index < limit, "Attempted to insert " SZFMTD " values into CompactArray but it can only hold " SZFMTD, index, limit);
}
