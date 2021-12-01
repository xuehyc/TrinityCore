/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef EquipementSet_h__
#define EquipementSet_h__

#include "Define.h"
#include "ObjectGuid.h"
#include <array>
#include <map>

enum EquipmentSetUpdateState
{
    EQUIPMENT_SET_UNCHANGED = 0,
    EQUIPMENT_SET_CHANGED   = 1,
    EQUIPMENT_SET_NEW       = 2,
    EQUIPMENT_SET_DELETED   = 3
};

#define EQUIPEMENT_SET_SLOTS 19

struct EquipmentSetInfo
{
    enum EquipmentSetType : int32
    {
        EQUIPMENT   = 0,
        TRANSMOG    = 1
    };

    /// Data sent in EquipmentSet related packets
    struct EquipmentSetData
    {
        EquipmentSetType Type = EQUIPMENT;
        uint64 Guid = 0;                                        ///< Set Identifier
        uint32 SetID = 0;                                       ///< Index
        uint32 IgnoreMask = 0;                                  ///< Mask of EquipmentSlot
        int32 AssignedSpecIndex = -1;                           ///< Index of character specialization that this set is automatically equipped for
        std::string SetName;
        std::string SetIcon;
        std::array<ObjectGuid, EQUIPEMENT_SET_SLOTS> Pieces;
        std::array<int32, EQUIPEMENT_SET_SLOTS> Appearances;    ///< ItemModifiedAppearanceID
        std::array<int32, 2> Enchants;                          ///< SpellItemEnchantmentID
    } Data;

    /// Server-side data
    EquipmentSetUpdateState State = EQUIPMENT_SET_NEW;
};

#define MAX_EQUIPMENT_SET_INDEX 20                          // client limit

typedef std::map<uint64, EquipmentSetInfo> EquipmentSetContainer;

#endif // EquipementSet_h__
