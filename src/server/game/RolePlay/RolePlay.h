#ifndef _Roleplay_H
#define _Roleplay_H

#include "ObjectMgr.h"
#include "GameObject.h"
#include "Creature.h"
#include "Log.h"
#include "CreatureOutfit.h"
#include "Item.h"
#include "UpdateField.h"
#include <fmt/printf.h>

struct PlayerExtraData
{
    ObjectGuid::LowType selectedCreatureGuid;
};

typedef std::unordered_map<ObjectGuid::LowType, PlayerExtraData> PlayerExtraDataContainer;

struct CustomNpcData
{
    std::string key;
    uint32 templateId;
    std::vector<ObjectGuid::LowType> spawns;
};

typedef std::unordered_map<std::string, CustomNpcData> CustomNpcDataContainer;

struct CreatureExtraData
{
    CreatureExtraData() : scale(-1.0f), creatorBnetAccId(0), creatorPlayerId(0),
        modifierBnetAccId(0), modifierPlayerId(0), created(0), modified(0), phaseMask(1),
        displayLock(false), displayId(0), nativeDisplayId(0), genderLock(false), gender(0),
        swim(true), gravity(true), fly(false) { }

    float scale;
    uint32 creatorBnetAccId;
    uint64 creatorPlayerId;
    uint32 modifierBnetAccId;
    uint64 modifierPlayerId;
    time_t created;
    time_t modified;
    uint32 phaseMask;
    bool displayLock;
    uint32 displayId;
    uint32 nativeDisplayId;
    bool genderLock;
    uint8 gender;
    bool swim;
    bool gravity;
    bool fly;
};

typedef std::unordered_map<uint64, CreatureExtraData> CreatureExtraContainer;

struct CreatureTemplateExtraData
{
    bool disabled;
};

typedef std::unordered_map<uint32, CreatureTemplateExtraData> CreatureTemplateExtraContainer;

class Map;

using G3D::Vector3;

enum RotationAxis
{
    AXIS_ROLL,
    AXIS_PITCH,
    AXIS_YAW
};

class TC_GAME_API Roleplay
{
private:
    Roleplay();
    ~Roleplay();
public:
    static Roleplay* instance();
    void LoadAllTables();

    // Creature
    void LoadCreatureExtras();
    void LoadCreatureTemplateExtras();
    void SetCreatureTemplateExtraDisabledFlag(uint32 entryId, bool disabled);
    void SaveCreature(Creature* creature);
    void CreatureSetModifyHistory(Creature* creature, Player* modifier);
    void CreatureMove(Creature* creature, float x, float y, float z, float o);
    void CreatureTurn(Creature* creature, float o);
    void CreatureDelete(Creature* creature);
    void CreatureSetEmote(Creature* creature, uint32 emoteId);
    void CreatureSetMount(Creature* creature, uint32 mountId);
    void CreatureSetAuraToggle(Creature* creature, uint32 auraId, bool toggle);
    void CreatureSetBytes1(Creature* creature);
    void CreatureSetBytes2(Creature* creature);
    void CreatureSetGravity(Creature* creature, bool toggle);
    void CreatureSetSwim(Creature* creature, bool toggle);
    void CreatureSetFly(Creature* creature, bool toggle);
    bool CreatureCanSwim(Creature const* creature);
    bool CreatureCanWalk(Creature const* creature);
    bool CreatureCanFly(Creature const* creature);
    Creature* CreatureCreate(Player* creator, CreatureTemplate const* creatureTemplate);
    void CreatureRefresh(Creature* creature);
    CreatureExtraData const* GetCreatureExtraData(uint64 guid);
    CreatureTemplateExtraData const* GetCreatureTemplateExtraData(uint32 entry);
    void SetCreatureSelectionForPlayer(ObjectGuid::LowType playerId, ObjectGuid::LowType creatureId);
    ObjectGuid::LowType GetSelectedCreatureGuidFromPlayer(ObjectGuid::LowType playerId);
    Creature* GetAnyCreature(ObjectGuid::LowType lowguid);
    Creature* GetAnyCreature(Map* map, ObjectGuid::LowType lowguid, uint32 entry);

    // Misc
    std::string GetMapName(uint32 mapId);
    std::string ToChatLink(std::string type, uint64 key, std::string name) { return "|cffffffff|" + type + ":" + fmt::sprintf("%llu", key) + "|h[" + name + "]|h|r"; }
    std::string GetChatLinkKey(std::string const& src, std::string type);
    std::string ToDateTimeString(time_t t);
    std::string ToDateString(time_t t);

    // Custom NPCs
    CustomNpcDataContainer GetCustomNpcContainer() { return _customNpcStore; }
    bool CustomNpcNameExists(std::string const& key) { return _customNpcStore.count(key) > 0; }
    uint32 GetEntryIdForNpc(std::string const& key) { return _customNpcStore[key].templateId; }
    uint8 GetModelVariationCountForNpc(std::string const& key);
    uint8 GetEquipmentVariationCountForNpc(std::string const& key);
    void LoadCustomNpcs();
    void CreateCustomNpcFromPlayer(Player* player, std::string const& key);
    void SetCustomNpcOutfitEquipmentSlot(std::string const& key, uint8 variationId, EquipmentSlots slot, int32 displayId);
    void SetCustomNpcOutfitRace(std::string const& key, uint8 variationId, Races race);
    void SetCustomNpcOutfitGender(std::string const& key, uint8 variationId, Gender gender);
    void SetCustomNpcLeftHand(std::string const& key, uint8 variationId, int32 itemId, int32 appearanceModId);
    void SetCustomNpcRightHand(std::string const& key, uint8 variationId, int32 itemId, int32 appearanceModId);
    void SetCustomNpcRanged(std::string const& key, uint8 variationId, int32 itemId, int32 appearanceModId);
    void SetCustomNpcName(std::string const& key, std::string const& displayName);
    void SetCustomNpcSubName(std::string const& key, std::string const& subName);
    void SetCustomNpcCustomizations(std::string const& key, uint8 variationId, Player* player);
    void SetCustomNpcDisplayId(std::string const& key, uint8 variationId, uint32 displayId);
    void SetCustomNpcModelScale(std::string const& key, uint8 variationId, float displayScale);
    void SetCustomNpcRank(std::string const& key, uint32 rank);
    void SetCustomNpcGuild(std::string const& key, uint8 variationId, uint64 guildId);
    void SetCustomNpcTameable(std::string const& key, bool tameable);
    void LoadCustomNpcSpawn(uint32 templateId, ObjectGuid::LowType spawn);
    void RemoveCustomNpcVariation(std::string const& key, uint8 variationId);
    void DeleteCustomNpc(std::string const& key);

protected:
    PlayerExtraDataContainer _playerExtraDataStore;
    CreatureExtraContainer _creatureExtraStore;
    CreatureTemplateExtraContainer _creatureTemplateExtraStore;
    CustomNpcDataContainer _customNpcStore;

private:
    void SaveNpcOutfitToDb(uint32 templateId, uint8 variationId);
    void SaveCustomNpcDataToDb(CustomNpcData outfitData);
    void SaveNpcCreatureTemplateToDb(CreatureTemplate cTemplate);
    void SaveNpcEquipmentInfoToDb(uint32 templateId, uint8 variationId);
    void SaveNpcModelInfo(CreatureModel model, uint32 creatureTemplateId, uint8 variationId);
    void ReloadSpawnedCustomNpcs(std::string const& key);
    void EnsureNpcModelExists(uint32 templateId, uint8 variationId);
    void EnsureNpcOutfitExists(uint32 templateId, uint8 variationId, float displayScale = 1.0f);
    void EnsureEquipmentInfoExists(uint32 templateId, uint8 variationId);
};

#define sRoleplay Roleplay::instance()

#endif
