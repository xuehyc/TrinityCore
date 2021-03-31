/*
 * EventBridge.cpp
 *
 *  Created on: 31 Jan 2011
 *      Author: sergio
 */

#include <pthread.h>
#include <stdlib.h>
#include <iostream>
#include <stdio.h>
#include <ctime>

#include "EventBridge.h"
#include "Item.h"
#include "GameTime.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "ScriptSystem.h"
#include "Transport.h"
#include "Vehicle.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "GossipDef.h"
#include "CreatureAI.h"
#include "Player.h"
#include "Group.h"
#include "Guild.h"
#include "Spell.h"
#include "AuctionHouseMgr.h"
#include "Channel.h"
#include "WorldPacket.h"
#include "rapidjson/document.h"
#include "rapidjson/writer.h"
#include "rapidjson/stringbuffer.h"
#include "restclient/restclient.h"
#include "ObjectAccessor.h"
#include "MapManager.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "geohash/geohash.hpp"

#include <queue>
#include <boost/thread.hpp>  

template <typename T>
class SynchronisedQueue
{
public:

    SynchronisedQueue()
    {
        RequestToEnd = false;  
        EnqueueData = true;
    }
    void Enqueue(const T& data)
    {
        boost::unique_lock<boost::mutex> lock(m_mutex);

        if(EnqueueData)
        {
            m_queue.push(data);
            m_cond.notify_one();
        }
    } 


    bool TryDequeue(T& result)
    {
        boost::unique_lock<boost::mutex> lock(m_mutex);

        while (m_queue.empty() && (! RequestToEnd)) 
        { 
            m_cond.wait(lock);
        }

        if( RequestToEnd )
        {
             DoEndActions();
             return false;
        }

        result= m_queue.front(); m_queue.pop();

        return true;
    }

    void StopQueue()
    {
        RequestToEnd =  true;
        Enqueue(NULL);        
    }

    int Size()
    {
        boost::unique_lock<boost::mutex> lock(m_mutex);
        return m_queue.size();
    }

private:

    void DoEndActions()
    {
        EnqueueData = false;

        while (!m_queue.empty())  
        {
            m_queue.pop();
        }
    }

    std::queue<T> m_queue;              // Use STL queue to store data
    boost::mutex m_mutex;               // The mutex to synchronise on
    boost::condition_variable m_cond;   // The condition to wait for

    bool RequestToEnd;
    bool EnqueueData;
};

const char* idToEventType[] = {"EVENT_TYPE_EMOTE", "EVENT_TYPE_ITEM_USE", "EVENT_TYPE_ITEM_EXPIRE",
  "EVENT_TYPE_GOSSIP_HELLO", "EVENT_TYPE_GOSSIP_SELECT", "EVENT_TYPE_GOSSIP_SELECT_CODE",
  "EVENT_TYPE_GOSSIP_HELLO_OBJECT", "EVENT_TYPE_GOSSIP_SELECT_OBJECT", "EVENT_TYPE_GOSSIP_SELECT_CODE_OBJECT",
  "EVENT_TYPE_QUEST_ACCEPT", "EVENT_TYPE_QUEST_SELECT", "EVENT_TYPE_QUEST_STATUS_CHANGE", "EVENT_TYPE_QUEST_REWARD",
  "EVENT_TYPE_GET_DIALOG_STATUS", "EVENT_TYPE_QUEST_ACCEPT_OBJECT", "EVENT_TYPE_QUEST_SELECT_OBJECT",
  "EVENT_TYPE_QUEST_COMPLETE_OBJECT", "EVENT_TYPE_QUEST_REWARD_OBJECT", "EVENT_TYPE_GET_DIALOG_STATUS_OBJECT",
  "EVENT_TYPE_OBJECT_CHANGED", "EVENT_TYPE_OBJECT_UPDATE", "EVENT_TYPE_AREA_TRIGGER", "EVENT_TYPE_WEATHER_CHANGE",
  "EVENT_TYPE_WEATHER_UPDATE", "EVENT_TYPE_PVP_KILL", "EVENT_TYPE_CREATURE_KILL", "EVENT_TYPE_KILLED_BY_CREATURE",
  "EVENT_TYPE_MONEY_CHANGED", "EVENT_TYPE_LEVEL_CHANGED", "EVENT_TYPE_CREATURE_UPDATE", "EVENT_TYPE_PLAYER_UPDATE",
  "EVENT_TYPE_ITEM_REMOVE", "EVENT_TYPE_GAME_OBJECT_DESTROYED", "EVENT_TYPE_GAME_OBJECT_DAMAGED",
  "EVENT_TYPE_GAME_OBJECT_LOOT_STATE_CHANGED", "EVENT_TYPE_AUCTION_ADD", "EVENT_TYPE_AUCTION_REMOVE",
  "EVENT_TYPE_AUCTION_SUCCESSFUL" ,"EVENT_TYPE_AUCTION_EXPIRE", "EVENT_TYPE_PLAYER_CHAT",
  "EVENT_TYPE_PLAYER_SPELL_CAST", "EVENT_TYPE_PLAYER_LOGIN", "EVENT_TYPE_PLAYER_LOGOUT",
  "EVENT_TYPE_PLAYER_CREATE", "EVENT_TYPE_PLAYER_DELETE", "EVENT_TYPE_PLAYER_SAVE",
  "EVENT_TYPE_PLAYER_UPDATE_ZONE", "EVENT_TYPE_HEAL", "EVENT_TYPE_DAMAGE"
};

const char*					endMsg		= "\n";
const int					port_out	= 6969;
const int					port_in		= 6970;
const char*					ebServerHost	= "conciens.mooo.com";
struct hostent*					host;
struct sockaddr_in				server_addr;
SynchronisedQueue<rapidjson::Document*>		queue;

static bool removeQuestFromDB() {
    SQLTransaction<WorldDatabaseConnection> trans = WorldDatabase.BeginTransaction();
    PreparedStatement<WorldDatabaseConnection>* stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_QUEST_CREATURE_STARTER);
    stmt->setInt32(0, 999999);
    trans->Append(stmt);
    WorldDatabase.DirectCommitTransaction(trans);

    trans = WorldDatabase.BeginTransaction();
    stmt = WorldDatabase.GetPreparedStatement(WORLD_DEL_QUEST_CREATURE_ENDER);
    stmt->setInt32(0, 999999);
    trans->Append(stmt);
    WorldDatabase.DirectCommitTransaction(trans);

    trans = WorldDatabase.BeginTransaction();
    WorldDatabase.GetPreparedStatement(WORLD_DEL_QUEST_TEMPLATE);
    stmt->setInt32(0, 999999);
    trans->Append(stmt);
    WorldDatabase.DirectCommitTransaction(trans);
    
    return true;
}

static bool addQuestToDB() {
    SQLTransaction<WorldDatabaseConnection> trans = WorldDatabase.BeginTransaction();
    
    PreparedStatement<WorldDatabaseConnection>* stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_QUEST_TEMPLATE);
    stmt->setInt32(0, 999999);
    stmt->setInt8(1, 2);
    stmt->setInt8(2, 1);
    stmt->setInt8(3, 1);
    stmt->setInt8(4, 80);
    stmt->setInt32(26, 80000000);
    stmt->setString(82, "Title");
    stmt->setString(83, "Objectives.");
    stmt->setString(84, "Details.");
    stmt->setString(85, "End text.");
    stmt->setString(86, "Completed.");
    stmt->setString(87, "Offer reward.");
    stmt->setString(89, "Completed.");
    stmt->setInt32(105, 6260);
    stmt->setInt8(111, 2);    
    trans->Append(stmt);
    
    stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_QUEST_CREATURE_STARTER);
    stmt->setInt16(0, 295);
    stmt->setInt32(1, 999999);
    trans->Append(stmt);
    
    stmt = WorldDatabase.GetPreparedStatement(WORLD_INS_QUEST_CREATURE_ENDER);
    stmt->setInt16(0, 295);
    stmt->setInt32(1, 999999);
    trans->Append(stmt);
    
    WorldDatabase.DirectCommitTransaction(trans);
    
    return true;
}

static bool reloadAllQuests()
{
    TC_LOG_INFO("misc", "Re-Loading Quest Area Triggers...");
    sObjectMgr->LoadQuestAreaTriggers();
    TC_LOG_INFO("misc", "DB table `areatrigger_involvedrelation` (quest area triggers) reloaded.");
    TC_LOG_INFO("misc", "Re-Loading Quest POI ..." );
    sObjectMgr->LoadQuestPOI();
    TC_LOG_INFO("misc", "DB Table `quest_poi` and `quest_poi_points` reloaded.");
    TC_LOG_INFO("misc", "Re-Loading Quest Templates...");
    sObjectMgr->LoadQuests();
    TC_LOG_INFO("misc", "DB table `quest_template` (quest definitions) reloaded.");

    /// dependent also from `gameobject` but this table not reloaded anyway
    TC_LOG_INFO("misc", "Re-Loading GameObjects for quests...");
    sObjectMgr->LoadGameObjectForQuests();
    TC_LOG_INFO("misc", "Data GameObjects for quests reloaded.");

    TC_LOG_INFO("misc", "Re-Loading Quests Relations...");
    sObjectMgr->LoadQuestStartersAndEnders();
    TC_LOG_INFO("misc", "DB tables `*_queststarter` and `*_questender` reloaded.");
    
    return true;
}

static bool updateCreature(uint64 guid)
{
    const SessionMap& sessions = sWorld->GetAllSessions();
    
    for(std::unordered_map<uint32, WorldSession* >::const_iterator itr = sessions.begin();itr != sessions.end();++itr)
    {
	WorldSession* ws = itr->second;
	if(ws->GetPlayer())
	{
	    Creature *obj = ObjectAccessor::GetCreatureOrPetOrVehicle(*ws->GetPlayer(), ObjectGuid(guid));
	    int phaseMask = obj->GetPhaseMask();
	    int tmpPhaseMask = phaseMask == 2 ? 3 : 2;
	    obj->SendUpdateToPlayer(ws->GetPlayer());
	    obj->SetPhaseMask(tmpPhaseMask, true);
	    obj->SendUpdateToPlayer(ws->GetPlayer());
	    obj->SetPhaseMask(phaseMask, true);
	    obj->SendUpdateToPlayer(ws->GetPlayer());
	}
    }
    
    return true;
}

static bool createGameObject(int objectId, int mapId, float x, float y, float z, float o)
{
    char* spawntimeSecs = strtok(NULL, " ");
    const GameObjectTemplate* objectInfo = sObjectMgr->GetGameObjectTemplate(objectId);

    if (!objectInfo)
    {
        TC_LOG_INFO("server.loading", "LANG_GAMEOBJECT_NOT_EXIST %d", objectId);
        return false;
    }

    if (objectInfo->displayId && !sGameObjectDisplayInfoStore.LookupEntry(objectInfo->displayId))
    {
        // report to DB errors log as in loading case
        TC_LOG_ERROR("sql.sql", "Gameobject (Entry %u GoType: %u) have invalid displayId (%u), not spawned.", objectId, objectInfo->type, objectInfo->displayId);
        TC_LOG_INFO("server.loading", "LANG_GAMEOBJECT_HAVE_INVALID_DATA %d", objectId);
        return false;
    }
    
    Map* map = sMapMgr->FindMap(mapId, 0);
  
    GameObject* object = new GameObject;
    Position pos = { x, y, z, o };
    QuaternionData rot = QuaternionData::fromEulerAnglesZYX(o, 0.f, 0.f);
    uint32 guidLow = map->GenerateLowGuid<HighGuid::GameObject>();

    if (!object->Create(guidLow, objectInfo->entry, map, uint32(PHASEMASK_ANYWHERE), pos, rot, 0, GO_STATE_READY))
    {
        delete object;
        return false;
    }

    if (spawntimeSecs)
    {
        uint32 value = atoi((char*)spawntimeSecs);
        object->SetRespawnTime(value);
    }

    // fill the gameobject data and save to the db
    object->SaveToDB(map->GetId(), (1 << map->GetSpawnMode()), uint32(PHASEMASK_ANYWHERE));
    // delete the old object and do a clean load from DB with a fresh new GameObject instance.
    // this is required to avoid weird behavior and memory leaks
    delete object;

    object = new GameObject();
    // this will generate a new guid if the object is in an instance
    if (!object->LoadFromDB(guidLow, map, true))
    {
        delete object;
        return false;
    }

    /// @todo is it really necessary to add both the real and DB table guid here ?
    sObjectMgr->AddGameobjectToGrid(guidLow, sObjectMgr->GetGameObjectData(guidLow));

    TC_LOG_INFO("server.loading", "LANG_GAMEOBJECT_ADD %d %s %d %f %f %f", objectId, objectInfo->name.c_str(), guidLow, x, y, z);
    return true;
}

void processActions(rapidjson::Document& d)
{
  for(rapidjson::Value::ConstValueIterator itr = d["actions"].Begin(); itr != d["actions"].End(); ++itr)
  {
    const rapidjson::Value& action = *itr;
    const char* actionId = action["action-id"].GetString();
    const ObjectGuid guid(HighGuid::GameObject, (uint32)295, (uint32)80346);

    if(!strcmp(actionId, "create"))
    {
      createGameObject(action["object-id"].GetInt(), action["map-id"].GetInt(), action["x"].GetFloat(),
          action["y"].GetFloat(), action["z"].GetFloat(), action["o"].GetFloat());
    }
    else if(!strcmp(actionId, "reload-quests"))
    {
      reloadAllQuests();
    }
    else if(!strcmp(actionId, "add-quest"))
    {
      addQuestToDB();
      reloadAllQuests();
      updateCreature(guid);
    }
    else if(!strcmp(actionId, "remove-quest"))
    {
      removeQuestFromDB();
      reloadAllQuests();
      updateCreature(guid);
    }
  }
}

bool checkPortTCP(short int dwPort, const char *ipAddressStr)
{  
    struct sockaddr_in server_addr;         
    int sock;   
    struct hostent*		host;
    struct timeval timeout;
    timeout.tv_sec = 1;
    timeout.tv_usec = 0;

    host = gethostbyname(ipAddressStr);
    sock = (int) socket(AF_INET, SOCK_STREAM, 0);

    server_addr.sin_family = AF_INET;
    server_addr.sin_addr = *((struct in_addr *) host->h_addr);
    bzero(&(server_addr.sin_zero), 8);
    server_addr.sin_port = htons(dwPort);
    setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&timeout, sizeof(timeout));
    int result = connect(sock, (struct sockaddr *) &server_addr, sizeof(struct sockaddr));
	
    close(sock);
    
    if (result == 0) {
      return true;
    }
    else return false; 
}  

void* processMessages(void *)
{
	pthread_t thread1;
	rapidjson::Document 	events, actions;
	rapidjson::Document* 	d;
	int size;
	rapidjson::Document::AllocatorType& allocator = events.GetAllocator();
	std::list<rapidjson::Document*> l;
	
	events.SetArray();
	size = queue.Size();
	// TC_LOG_INFO("server.loading", "Sending events, size: %d", size);
	for(int i=0;i<size;i++) {
	  bool correct = queue.TryDequeue(d);
	  if(correct) {
	    rapidjson::Value v(rapidjson::kObjectType);
	    for(rapidjson::Document::MemberIterator it = d->MemberBegin(); it != d->MemberEnd(); ++it) {
	      v.AddMember(it->name, it->value, allocator);
	    }
	    l.push_back(d);
	    events.PushBack(v, allocator);
	  }
	}
	
	rapidjson::StringBuffer buffer;
	rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);
	events.Accept(writer);

	if(size > 0 && checkPortTCP(3000, "conciens.mooo.com")) {
	  RestClient::Response r = RestClient::post("http://conciens.mooo.com:3000/event", "text/json", buffer.GetString());
	  actions.Parse(r.body.c_str());
	  processActions(actions);
	}

	while(!l.empty()) {
	  d = l.front();
	  l.pop_front();
	  delete d;
	}
		
	sleep(1);
	pthread_create(&thread1, NULL, processMessages, NULL);
	
	//if (strcmp(recv_data, "q") == 0 || strcmp(recv_data, "Q") == 0)
	//{
	//	close(sock);
	//	break;
	//}

	//else
	//	printf("\nRecieved data = %s ", recv_data);

	//printf("\nSEND (q or Q to quit) : ");
	//gets(send_data);
	
	return NULL;
}

EventBridge::EventBridge()
{
	pthread_t	thread1;

	TC_LOG_INFO("server.loading", "EventBridge: Starting EventBridge...");
	
	/* Create independent threads each of which will execute function */
	pthread_create(&thread1, NULL, processMessages, NULL);

	/* Wait till threads are complete before main continues. Unless we  */
	/* wait we run the risk of executing an exit which will terminate   */
	/* the process and all threads before the threads have completed.   */
	//pthread_join( thread1, NULL);
}

EventBridge::~EventBridge()
{
	// TODO Auto-generated destructor stub
}

std::tm epoch_strt = {0, 0, 0, 1, 0, 70, 0, 0, -1, 0, 0};
std::time_t basetime = std::mktime(&epoch_strt);
float shiftCoordinate = 32.0 * 1600.0 / 3.0;

void EventBridge::sendEvent(const int event_type, const Player* player, const Creature* creature, const uint32 num,
			    const Item* item, const Quest* quest, const SpellCastTargets* targets,
			    const ItemTemplate* proto, const uint32 num2, const char* st, const GameObject* go,
			    const AreaTriggerEntry* area, const Weather* weather, const int state,
			    const float grade, const Unit* target, const AuctionHouseObject* ah,
			    const AuctionEntry* entry, const Group* group, const Guild* guild,
			    const Channel* channel, const Spell* spell, const Unit* actor)
{
	float	x, y, z, o, lat, lng;
  int mapId = 0;
  x = y = z = o = lat = lng = 0.0;
  char *geohash, *gharea, *ghsector;

	rapidjson::Document* d = new rapidjson::Document();
	rapidjson::Value jsonNums(rapidjson::kArrayType);
	rapidjson::Value jsonPlayer(rapidjson::kObjectType);
	rapidjson::Value jsonActor(rapidjson::kObjectType);
	rapidjson::Value jsonCreature (rapidjson::kObjectType);
	rapidjson::Value jsonItem (rapidjson::kObjectType);
	rapidjson::Value jsonQuest (rapidjson::kObjectType);
	rapidjson::Value jsonTarget (rapidjson::kObjectType);
	rapidjson::Value jsonItemTemplate (rapidjson::kObjectType);
	rapidjson::Value jsonGameObject (rapidjson::kObjectType);
	rapidjson::Value jsonWeather (rapidjson::kObjectType);
	rapidjson::Value jsonAuctionHouseObject (rapidjson::kObjectType);
	rapidjson::Value jsonAuctionEntry (rapidjson::kObjectType);
	rapidjson::Value jsonGroup (rapidjson::kObjectType);
	rapidjson::Value jsonGuild (rapidjson::kObjectType);
	rapidjson::Value jsonChannel (rapidjson::kObjectType);
	rapidjson::Value jsonSpell (rapidjson::kObjectType);
	rapidjson::Value jsonGeometry (rapidjson::kObjectType);
	rapidjson::Document::AllocatorType& a = d->GetAllocator();
	d->SetObject();
	
  std::time_t curtime = GameTime::GetGameTime();
  uint32 nsecs = std::difftime(curtime, basetime);

  d->AddMember(rapidjson::StringRef("timestamp"), nsecs, a);
  d->AddMember(rapidjson::StringRef("interval"), ((int)(nsecs/900)) * 900, a);
	d->AddMember(rapidjson::StringRef("event-type"), rapidjson::StringRef(idToEventType[event_type]), a);
	d->AddMember(rapidjson::StringRef("app"), rapidjson::StringRef(idToEventType[event_type]), a);
	
	jsonNums.PushBack(num, a).PushBack(num2, a);
	d->AddMember("num-values", jsonNums, a);
	
	if(st != NULL) {
	  TC_LOG_INFO("server.loading", "%s", st);
	  rapidjson::Value s;
	  s.SetString(st, strlen(st), a);
	  d->AddMember("string-value", s, a);
	}
	
	if(area != NULL) {
	  d->AddMember("area", area->ID, a);
	}

    if(player != NULL) {
        player->GetPosition(x, y, z, o);
        mapId = player->GetMapId();
        jsonPlayer.AddMember("guid", player->GetGUID().GetEntry(), a);
        jsonPlayer.AddMember("name", rapidjson::StringRef(player->GetName().c_str()), a);
        jsonPlayer.AddMember("level", player->GetLevel(), a);
        rapidjson::Value s;
        const char* text = player->GetName().c_str();
        s.SetString(text, strlen(text), a);
        jsonPlayer.AddMember("description", s, a);
        jsonPlayer.AddMember("x", x, a);
        jsonPlayer.AddMember("y", y, a);
        jsonPlayer.AddMember("z", z, a);
        jsonPlayer.AddMember("o", o, a);
        jsonPlayer.AddMember("map", mapId, a);
        d->AddMember("player", jsonPlayer, a);
    }

    if(actor != NULL) {
        actor->GetPosition(x, y, z, o);
        mapId = actor->GetMapId();
        jsonActor.AddMember("guid", actor->GetGUID().GetEntry(), a);
        jsonActor.AddMember("name", rapidjson::StringRef(actor->GetName().c_str()), a);
        jsonActor.AddMember("level", actor->GetLevel(), a);
        rapidjson::Value s;
        const char* text = actor->GetName().c_str();
        s.SetString(text, strlen(text), a);
        jsonActor.AddMember("description", s, a);
        jsonActor.AddMember("x", x, a);
        jsonActor.AddMember("y", y, a);
        jsonActor.AddMember("z", z, a);
        jsonActor.AddMember("o", o, a);
        jsonActor.AddMember("map", mapId, a);
        d->AddMember("actor", jsonActor, a);
    }

    if(target != NULL) {
        target->GetPosition(x, y, z, o);
        mapId = target->GetMapId();
        jsonTarget.AddMember("guid", target->GetGUID().GetEntry(), a);
        jsonTarget.AddMember("name", rapidjson::StringRef(target->GetName().c_str()), a);
        jsonTarget.AddMember("level", target->GetLevel(), a);
        jsonTarget.AddMember("x", x, a);
        jsonTarget.AddMember("y", y, a);
        jsonTarget.AddMember("z", z, a);
        jsonTarget.AddMember("o", o, a);
        jsonTarget.AddMember("map", mapId, a);
        d->AddMember("target", jsonTarget, a);
    }

    if(creature != NULL) {
        creature->GetPosition(x, y, z, o);
        mapId = creature->GetMapId();
        jsonCreature.AddMember("guid", creature->GetGUID().GetEntry(), a);
        jsonCreature.AddMember("name", rapidjson::StringRef(creature->GetName().c_str()), a);
        jsonCreature.AddMember("level", creature->GetLevel(), a);
        jsonCreature.AddMember("x", x, a);
        jsonCreature.AddMember("y", y, a);
        jsonCreature.AddMember("z", z, a);
        jsonCreature.AddMember("o", o, a);
        jsonCreature.AddMember("map", mapId, a);
        d->AddMember("creature", jsonCreature, a);
    }

    if(item != NULL) {
        jsonItem.AddMember("guid", item->GetEntry(), a);
        jsonItem.AddMember("name", rapidjson::StringRef(item->GetTemplate()->Name1.c_str()), a);
        d->AddMember("item", jsonItem, a);
    }

    if(quest != NULL) {
        jsonQuest.AddMember("id", quest->GetQuestId(), a);
        jsonQuest.AddMember("name", rapidjson::StringRef(quest->GetTitle().c_str()), a);
        jsonQuest.AddMember("description", rapidjson::StringRef(quest->GetDetails().c_str()), a);
        d->AddMember("quest", jsonQuest, a);
    }

	if(targets != NULL && targets->GetObjectTarget() != NULL) {
	  targets->GetObjectTarget()->GetPosition(x, y, z, o);
    mapId = targets->GetObjectTarget()->GetMapId();
	  jsonTarget.AddMember("guid", targets->GetObjectTarget()->GetGUID().GetEntry(), a);
	  jsonTarget.AddMember("name", rapidjson::StringRef(targets->GetObjectTarget()->GetName().c_str()), a);
	  jsonTarget.AddMember("x", x, a);
	  jsonTarget.AddMember("y", y, a);
	  jsonTarget.AddMember("z", z, a);
	  jsonTarget.AddMember("o", o, a);
	  jsonTarget.AddMember("map", mapId, a);
	  d->AddMember("target", jsonTarget, a);
	}

	if(proto != NULL) {
	  jsonItemTemplate.AddMember("id", proto->ItemId, a);
	  jsonItemTemplate.AddMember("name", rapidjson::StringRef(proto->Name1.c_str()), a);
	  d->AddMember("item-template", jsonItemTemplate, a);
	}

	if(go != NULL) {
	  go->GetPosition(x, y, z, o);
    mapId = go->GetMapId();
	  jsonGameObject.AddMember("guid", go->GetGUID().GetEntry(), a);
	  jsonGameObject.AddMember("name", rapidjson::StringRef(go->GetName().c_str()), a);
	  jsonGameObject.AddMember("x", x, a);
	  jsonGameObject.AddMember("y", y, a);
	  jsonGameObject.AddMember("z", z, a);
	  jsonGameObject.AddMember("o", o, a);
	  jsonGameObject.AddMember("map", mapId, a);
	  d->AddMember("game-object", jsonGameObject, a);
	}
	 
	if(weather != NULL) {
	  jsonWeather.AddMember("zone", weather->GetZone(), a);
	  jsonWeather.AddMember("state", state, a);
	  jsonWeather.AddMember("grade", grade, a);
	  d->AddMember("weather", jsonWeather, a);
	}
	
	if(ah != NULL) {
	  jsonAuctionHouseObject.AddMember("count", ah->Getcount(), a);
	  d->AddMember("auction-house-object", jsonAuctionHouseObject, a);
	}
	
	if(entry != NULL) {
	  jsonAuctionEntry.AddMember("id", entry->itemGUIDLow, a);
	  jsonAuctionEntry.AddMember("bid", entry->bid, a);
	  jsonAuctionEntry.AddMember("bidder", entry->bidder, a);
	  d->AddMember("auction-house-object", jsonAuctionHouseObject, a);
	}
	
	if(group != NULL) {
	  jsonGroup.AddMember("guid", group->GetLowGUID(), a);
	  jsonGroup.AddMember("leader-guid", group->GetLeaderGUID(), a);
	  jsonGroup.AddMember("leader-name", rapidjson::StringRef(group->GetLeaderName()), a);
	  rapidjson::Value jsonGroupMemberList(rapidjson::kArrayType);
	  
	  const Group::MemberSlotList& msl = group->GetMemberSlots();
	  for(std::list<Group::MemberSlot>::const_iterator it = msl.cbegin(); it != msl.cend(); it++) {
	    rapidjson::Value jsonGroupMember(rapidjson::kObjectType);
	    jsonGroupMember.AddMember("guid", it->guid, a);
	    jsonGroupMember.AddMember("name", rapidjson::StringRef(it->name.c_str()), a);
	    jsonGroupMemberList.PushBack(jsonGroupMember, a);
	  }
	  
	  jsonGroup.AddMember("member-list", jsonGroupMemberList, a);
	  d->AddMember("group", jsonGroup, a);
	}
	
	if(guild != NULL) {
	  jsonGuild.AddMember("id", guild->GetId(), a);
	  jsonGuild.AddMember("name",rapidjson::StringRef( guild->GetName().c_str()), a);
	  d->AddMember("guild", jsonGuild, a);
	}
	
	if(channel != NULL) {
	  jsonChannel.AddMember("id", channel->GetChannelId(), a);
	  jsonChannel.AddMember("name", rapidjson::StringRef(channel->GetName().c_str()), a);
	  d->AddMember("channel", jsonChannel, a);
	}
	
	if(spell != NULL) {
	  jsonSpell.AddMember("id", spell->GetSpellInfo()->Id, a);
      std::array<const char*, 16> arr = spell->GetSpellInfo()->SpellName;
      const char **data = arr.data();
	  jsonSpell.AddMember("name", rapidjson::StringRef(data[0]), a);
	  jsonSpell.AddMember("family", spell->GetSpellInfo()->SpellFamilyName, a);
	  d->AddMember("spell", jsonSpell, a);
	}

  if(x != 0 && y != 0 && z != 0) {
    rapidjson::Value jsonGeohash, jsonArea, jsonSector;

    lat = ((mapId * 100000.0) + y + shiftCoordinate) / 1000000.0;
    lng = ((mapId * 100000.0) + x + shiftCoordinate) / 1000000.0;
    jsonGeometry.AddMember("lat", lat, a);
    jsonGeometry.AddMember("lng", lng, a);
    d->AddMember("geometry", jsonGeometry, a);
    d->AddMember("lat", lat, a);
    d->AddMember("lng", lng, a);
    geohash = geohash_encode(lat, lng, 12);
    gharea = geohash_encode(lat, lng, 6);
    ghsector = geohash_encode(lat, lng, 7);
    jsonGeohash.SetString(geohash, 12, a);
    jsonArea.SetString(gharea, 6, a);
    jsonSector.SetString(ghsector, 7, a);
    d->AddMember("geohash", jsonGeohash, a);
    d->AddMember("area", jsonArea, a);
    d->AddMember("sector", jsonSector, a);
    free(geohash);
    free(gharea);
    free(ghsector);
  }

	queue.Enqueue(d);
}
