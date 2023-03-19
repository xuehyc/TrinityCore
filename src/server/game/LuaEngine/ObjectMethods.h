/*
* Copyright (C) 2010 - 2020 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.md for more information
*/

#ifndef OBJECTMETHODS_H
#define OBJECTMETHODS_H

/***
 * A basic game object (either an [Item] or a [WorldObject]).
 *
 * Objects in MaNGOS/Trinity are stored an a giant block of "values".
 * Subclasses of Object, like [WorldObject], extend the block with more data specific to that subclass.
 * Further subclasses, like [Player], extend it even further.
 *
 * A detailed map of all the fields in this data block can be found in the UpdateFields.h file of your emulator
 *   (it varies depending on the expansion supported).
 *
 * The GetValue methods in this class (e.g. [Object:GetInt32Value]) provide low-level access to the data block.
 * Other methods, like [Object:HasFlag] and [Object:GetScale], merely wrap the GetValue methods and provide a simpler interface.
 *
 * Inherits all methods from: none
 */
namespace LuaObject
{
    /**
     * Returns `true` if the [Object] has been added to its [Map], otherwise `false`.
     *
     * @return bool inWorld
     */
    int IsInWorld(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->IsInWorld());
        return 1;
    }

    /**
     * Returns the scale/size of the [Object].
     *
     * This affects the size of a [WorldObject] in-game, but [Item]s don't have a "scale".
     *
     * @return float scale
     */
    int GetScale(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->GetObjectScale());
        return 1;
    }

    /**
     * Returns the entry of the [Object].
     *
     * [Player]s do not have an "entry".
     *
     * @return uint32 entry
     */
    int GetEntry(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->GetEntry());
        return 1;
    }

    /**
     * Returns the GUID of the [Object].
     * 
     * GUID is an unique identifier for the object.
     * 
     * However on MaNGOS and cMangos creatures and gameobjects inside different maps can share
     * the same GUID but not on the same map.
     * 
     * On TrinityCore this value is unique across all maps
     *
     * @return ObjectGuid guid
     */
    int GetGUID(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->GET_GUID());
        return 1;
    }

    /**
     * Returns the low-part of the [Object]'s GUID.
     * 
     * On TrinityCore all low GUIDs are different for all objects of the same type.
     * For example creatures in instances are assigned new GUIDs when the Map is created.
     * 
     * On MaNGOS and cMaNGOS low GUIDs are unique only on the same map.
     * For example creatures in instances use the same low GUID assigned for that spawn in the database.
     * This is why to identify a creature you have to know the instanceId and low GUID. See [Map:GetIntstanceId]
     *
     * @return uint32 guidLow
     */
    int GetGUIDLow(lua_State* L, Object* obj)
    {
        Eluna::Push(L, (uint32)obj->GetGUID().GetCounter());
        return 1;
    }

    /**
     * Returns the TypeId of the [Object].
     *
     *     enum TypeID
     *     {
     *         TYPEID_OBJECT        = 0,
     *         TYPEID_ITEM          = 1,
     *         TYPEID_CONTAINER     = 2,
     *         TYPEID_UNIT          = 3,
     *         TYPEID_PLAYER        = 4,
     *         TYPEID_GAMEOBJECT    = 5,
     *         TYPEID_DYNAMICOBJECT = 6,
     *         TYPEID_CORPSE        = 7
     *     };
     *
     * @return uint8 typeID
     */
    int GetTypeId(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->GetTypeId());
        return 1;
    }

    /**
     * Sets the [Object]'s scale/size to the given value.
     *
     * @param float scale
     */
    int SetScale(lua_State* L, Object* obj)
    {
        float size = Eluna::CHECKVAL<float>(L, 2);

        obj->SetObjectScale(size);
        return 0;
    }

    /**
    * Sets the data at the specified index to the given value, converted to an unsigned 32-bit integer.
    *
    * @param uint16 index
    * @param uint32 value
    */
    /*int SetUInt32Value(lua_State* L, Object* obj)
    {
        uint16 index = Eluna::CHECKVAL<uint16>(L, 2);
        uint32 value = Eluna::CHECKVAL<uint32>(L, 3);
        obj->SetUInt32Value(index, value);
        return 0;
    }*/

    /**
     * Attempts to convert the [Object] to a [Corpse].
     *
     * If the [Object] is not a [Corpse], returns `nil`.
     *
     * @return [Corpse] corpse : the [Object] as a [Corpse], or `nil`
     */
    int ToCorpse(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->ToCorpse());
        return 1;
    }

    /**
     * Attempts to convert the [Object] to a [GameObject].
     *
     * If the [Object] is not a [GameObject], returns `nil`.
     *
     * @return [GameObject] gameObject : the [Object] as a [GameObject], or `nil`
     */
    int ToGameObject(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->ToGameObject());
        return 1;
    }

    /**
     * Attempts to convert the [Object] to a [Unit].
     *
     * If the [Object] is not a [Unit], returns `nil`.
     *
     * @return [Unit] unit : the [Object] as a [Unit], or `nil`
     */
    int ToUnit(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->ToUnit());
        return 1;
    }

    /**
     * Attempts to convert the [Object] to a [Creature].
     *
     * If the [Object] is not a [Creature], returns `nil`.
     *
     * @return [Creature] creature : the [Object] as a [Creature], or `nil`
     */
    int ToCreature(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->ToCreature());
        return 1;
    }

    /**
     * Attempts to convert the [Object] to a [Player].
     *
     * If the [Object] is not a [Player], returns `nil`.
     *
     * @return [Player] player : the [Object] as a [Player], or `nil`
     */
    int ToPlayer(lua_State* L, Object* obj)
    {
        Eluna::Push(L, obj->ToPlayer());
        return 1;
    }
};
#endif
