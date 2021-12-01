/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef __UPDATEDATA_H
#define __UPDATEDATA_H

#include "Define.h"
#include "ByteBuffer.h"
#include "ObjectGuid.h"
#include <set>

class WorldPacket;

enum OBJECT_UPDATE_TYPE
{
    UPDATETYPE_VALUES               = 0,
    UPDATETYPE_CREATE_OBJECT        = 1,
    UPDATETYPE_CREATE_OBJECT2       = 2,
    UPDATETYPE_OUT_OF_RANGE_OBJECTS = 3,
};

enum OBJECT_UPDATE_FLAGS
{
    UPDATEFLAG_NONE                  = 0x0000,
    UPDATEFLAG_SELF                  = 0x0001,
    UPDATEFLAG_TRANSPORT             = 0x0002,
    UPDATEFLAG_HAS_TARGET            = 0x0004,
    UPDATEFLAG_LIVING                = 0x0008,
    UPDATEFLAG_STATIONARY_POSITION   = 0x0010,
    UPDATEFLAG_VEHICLE               = 0x0020,
    UPDATEFLAG_TRANSPORT_POSITION    = 0x0040,
    UPDATEFLAG_ROTATION              = 0x0080,
    UPDATEFLAG_ANIMKITS              = 0x0100,
    UPDATEFLAG_AREATRIGGER           = 0x0200,
    UPDATEFLAG_GAMEOBJECT            = 0x0400,
    //UPDATEFLAG_REPLACE_ACTIVE        = 0x0800,
    //UPDATEFLAG_NO_BIRTH_ANIM         = 0x1000,
    //UPDATEFLAG_ENABLE_PORTALS        = 0x2000,
    //UPDATEFLAG_PLAY_HOVER_ANIM       = 0x4000,
    //UPDATEFLAG_IS_SUPPRESSING_GREETINGS = 0x8000
    //UPDATEFLAG_SCENEOBJECT           = 0x10000,
    //UPDATEFLAG_SCENE_PENDING_INSTANCE = 0x20000
};

class UpdateData
{
    public:
        UpdateData(uint32 map);
        UpdateData(UpdateData&& right) : m_map(right.m_map), m_blockCount(right.m_blockCount),
            m_outOfRangeGUIDs(std::move(right.m_outOfRangeGUIDs)),
            m_data(std::move(right.m_data))
        {
        }

        void AddOutOfRangeGUID(GuidSet& guids);
        void AddOutOfRangeGUID(ObjectGuid guid);
        void AddUpdateBlock(const ByteBuffer &block);
        bool BuildPacket(WorldPacket* packet);
        bool HasData() const { return m_blockCount > 0 || !m_outOfRangeGUIDs.empty(); }
        void Clear();

        GuidSet const& GetOutOfRangeGUIDs() const { return m_outOfRangeGUIDs; }

    protected:
        uint32 m_map;
        uint32 m_blockCount;
        GuidSet m_outOfRangeGUIDs;
        ByteBuffer m_data;

        UpdateData(UpdateData const& right) = delete;
        UpdateData& operator=(UpdateData const& right) = delete;
};
#endif
