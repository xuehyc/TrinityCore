/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "UpdateData.h"
#include "Errors.h"
#include "WorldPacket.h"
#include "Opcodes.h"

UpdateData::UpdateData(uint32 map) : m_map(map), m_blockCount(0) { }

void UpdateData::AddOutOfRangeGUID(GuidSet& guids)
{
    m_outOfRangeGUIDs.insert(guids.begin(), guids.end());
}

void UpdateData::AddOutOfRangeGUID(ObjectGuid guid)
{
    m_outOfRangeGUIDs.insert(guid);
}

void UpdateData::AddUpdateBlock(const ByteBuffer &block)
{
    m_data.append(block);
    ++m_blockCount;
}

bool UpdateData::BuildPacket(WorldPacket* packet)
{
    ASSERT(packet->empty());                                // shouldn't happen
    packet->Initialize(SMSG_UPDATE_OBJECT, 2 + 4 + (m_outOfRangeGUIDs.empty() ? 0 : 1 + 4 + 9 * m_outOfRangeGUIDs.size()) + m_data.wpos());

    *packet << uint32(m_blockCount);
    *packet << uint16(m_map);

    if (packet->WriteBit(!m_outOfRangeGUIDs.empty()))
    {
        *packet << uint16(0);   // object limit to instantly destroy - objects before this index on m_outOfRangeGUIDs list get "smoothly phased out"
        *packet << uint32(m_outOfRangeGUIDs.size());

        for (GuidSet::const_iterator i = m_outOfRangeGUIDs.begin(); i != m_outOfRangeGUIDs.end(); ++i)
            *packet << *i;
    }

    *packet << uint32(m_data.size());
    packet->append(m_data);
    return true;
}

void UpdateData::Clear()
{
    m_data.clear();
    m_outOfRangeGUIDs.clear();
    m_blockCount = 0;
    m_map = 0;
}
