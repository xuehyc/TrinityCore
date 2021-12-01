/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DB2Meta_h__
#define DB2Meta_h__

#include "Define.h"

struct COMMON_API DB2Meta
{
    DB2Meta(int32 indexField, uint32 fieldCount, uint32 layoutHash, char const* types, uint8 const* arraySizes, int32 parentIndexField);

    bool HasIndexFieldInData() const;

    // Returns field index for data loaded in our structures (ID field is appended in the front if not present in db2 file data section)
    uint32 GetIndexField() const;

    // Returns size of final loaded structure
    uint32 GetRecordSize() const;

    int32 GetParentIndexFieldOffset() const;

    uint32 GetDbIndexField() const;
    uint32 GetDbFieldCount() const;

    int32 IndexField;
    int32 ParentIndexField;
    uint32 FieldCount;
    uint32 LayoutHash;
    char const* Types;
    uint8 const* ArraySizes;
};

struct COMMON_API DB2FieldMeta
{
    DB2FieldMeta(bool isSigned, DBCFormer type, char const* name);

    bool IsSigned;
    DBCFormer Type;
    char const* Name;
};

#endif // DB2Meta_h__
