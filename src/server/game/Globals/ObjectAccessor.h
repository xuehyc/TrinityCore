/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_OBJECTACCESSOR_H
#define SERVER_OBJECTACCESSOR_H

#include "ObjectGuid.h"
#include <unordered_map>

class AreaTrigger;
class Conversation;
class Corpse;
class Creature;
class DynamicObject;
class GameObject;
class Map;
class Object;
class Pet;
class Player;
class Transport;
class Unit;
class WorldObject;

namespace boost
{
    class shared_mutex;
}

template <class T>
class GAME_API HashMapHolder
{
    //Non instanceable only static
    HashMapHolder() { }

public:
    typedef std::unordered_map<ObjectGuid, T*> MapType;

    static void Insert(T* o);

    static void Remove(T* o);

    static T* Find(ObjectGuid guid);

    static MapType& GetContainer();

    static boost::shared_mutex* GetLock();
};

namespace ObjectAccessor
{
    // these functions return objects only if in map of specified object
    GAME_API WorldObject* GetWorldObject(WorldObject const&, ObjectGuid const&);
    GAME_API Object* GetObjectByTypeMask(WorldObject const&, ObjectGuid const&, uint32 typemask);
    GAME_API Corpse* GetCorpse(WorldObject const& u, ObjectGuid const& guid);
    GAME_API GameObject* GetGameObject(WorldObject const& u, ObjectGuid const& guid);
    GAME_API Transport* GetTransportOnMap(WorldObject const& u, ObjectGuid const& guid);
    GAME_API Transport* GetTransport(ObjectGuid const& guid);
    GAME_API DynamicObject* GetDynamicObject(WorldObject const& u, ObjectGuid const& guid);
    GAME_API AreaTrigger* GetAreaTrigger(WorldObject const& u, ObjectGuid const& guid);
    GAME_API Conversation* GetConversation(WorldObject const& u, ObjectGuid const& guid);
    GAME_API Unit* GetUnit(WorldObject const&, ObjectGuid const& guid);
    GAME_API Creature* GetCreature(WorldObject const& u, ObjectGuid const& guid);
    GAME_API Pet* GetPet(WorldObject const&, ObjectGuid const& guid);
    GAME_API Player* GetPlayer(Map const*, ObjectGuid const& guid);
    GAME_API Player* GetPlayer(WorldObject const&, ObjectGuid const& guid);
    GAME_API Creature* GetCreatureOrPetOrVehicle(WorldObject const&, ObjectGuid const&);

    // these functions return objects if found in whole world
    // ACCESS LIKE THAT IS NOT THREAD SAFE
    GAME_API Player* FindPlayer(ObjectGuid const&);
    GAME_API Player* FindPlayerByName(std::string const& name);
    GAME_API Player* FindPlayerByLowGUID(ObjectGuid::LowType lowguid);

    // this returns Player even if he is not in world, for example teleporting
    GAME_API Player* FindConnectedPlayer(ObjectGuid const&);
    GAME_API Player* FindConnectedPlayerByName(std::string const& name);

    // when using this, you must use the hashmapholder's lock
    GAME_API HashMapHolder<Player>::MapType const& GetPlayers();

    template<class T>
    void AddObject(T* object)
    {
        HashMapHolder<T>::Insert(object);
    }

    template<class T>
    void RemoveObject(T* object)
    {
        HashMapHolder<T>::Remove(object);
    }

    template<>
    void AddObject(Player* player);

    template<>
    void RemoveObject(Player* player);

    GAME_API void SaveAllPlayers();
};

#endif
