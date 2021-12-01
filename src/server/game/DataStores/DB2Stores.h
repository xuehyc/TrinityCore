/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_DB2STORES_H
#define SERVER_DB2STORES_H

#include "DB2Store.h"
#include "DB2Structure.h"
#include "SharedDefines.h"
#include <map>
#include <set>
#include <unordered_map>
#include <unordered_set>
#include <vector>

 // temporary hack until includes are sorted out (don't want to pull in Windows.h)
#ifdef GetClassName
#undef GetClassName
#endif

class DB2HotfixGeneratorBase;

GAME_API extern DB2Storage<AchievementEntry>                     sAchievementStore;
GAME_API extern DB2Storage<AnimKitEntry>                         sAnimKitStore;
GAME_API extern DB2Storage<AreaTableEntry>                       sAreaTableStore;
GAME_API extern DB2Storage<AreaTriggerEntry>                     sAreaTriggerStore;
GAME_API extern DB2Storage<ArmorLocationEntry>                   sArmorLocationStore;
GAME_API extern DB2Storage<ArtifactEntry>                        sArtifactStore;
GAME_API extern DB2Storage<ArtifactCategoryEntry>                sArtifactCategoryStore;
GAME_API extern DB2Storage<ArtifactAppearanceEntry>              sArtifactAppearanceStore;
GAME_API extern DB2Storage<ArtifactAppearanceSetEntry>           sArtifactAppearanceSetStore;
GAME_API extern DB2Storage<ArtifactPowerEntry>                   sArtifactPowerStore;
GAME_API extern DB2Storage<ArtifactPowerPickerEntry>             sArtifactPowerPickerStore;
GAME_API extern DB2Storage<ArtifactTierEntry>                    sArtifactTierStore;
GAME_API extern DB2Storage<ArtifactUnlockEntry>                  sArtifactUnlockStore;
GAME_API extern DB2Storage<AuctionHouseEntry>                    sAuctionHouseStore;
GAME_API extern DB2Storage<BankBagSlotPricesEntry>               sBankBagSlotPricesStore;
GAME_API extern DB2Storage<BannedAddonsEntry>                    sBannedAddonsStore;
GAME_API extern DB2Storage<BarberShopStyleEntry>                 sBarberShopStyleStore;
GAME_API extern DB2Storage<BattlePetBreedQualityEntry>           sBattlePetBreedQualityStore;
GAME_API extern DB2Storage<BattlePetBreedStateEntry>             sBattlePetBreedStateStore;
GAME_API extern DB2Storage<BattlePetSpeciesEntry>                sBattlePetSpeciesStore;
GAME_API extern DB2Storage<BattlePetSpeciesStateEntry>           sBattlePetSpeciesStateStore;
GAME_API extern DB2Storage<BattlemasterListEntry>                sBattlemasterListStore;
GAME_API extern DB2Storage<BroadcastTextEntry>                   sBroadcastTextStore;
GAME_API extern DB2Storage<Cfg_RegionsEntry>                     sCfgRegionsStore;
GAME_API extern DB2Storage<CharStartOutfitEntry>                 sCharStartOutfitStore;
GAME_API extern DB2Storage<CharTitlesEntry>                      sCharTitlesStore;
GAME_API extern DB2Storage<ChatChannelsEntry>                    sChatChannelsStore;
GAME_API extern DB2Storage<ChrClassesEntry>                      sChrClassesStore;
GAME_API extern DB2Storage<ChrRacesEntry>                        sChrRacesStore;
GAME_API extern DB2Storage<ChrSpecializationEntry>               sChrSpecializationStore;
GAME_API extern DB2Storage<CinematicCameraEntry>                 sCinematicCameraStore;
GAME_API extern DB2Storage<CinematicSequencesEntry>              sCinematicSequencesStore;
GAME_API extern DB2Storage<ConversationLineEntry>                sConversationLineStore;
GAME_API extern DB2Storage<CreatureDisplayInfoEntry>             sCreatureDisplayInfoStore;
GAME_API extern DB2Storage<CreatureDisplayInfoExtraEntry>        sCreatureDisplayInfoExtraStore;
GAME_API extern DB2Storage<CreatureFamilyEntry>                  sCreatureFamilyStore;
GAME_API extern DB2Storage<CreatureModelDataEntry>               sCreatureModelDataStore;
GAME_API extern DB2Storage<CreatureTypeEntry>                    sCreatureTypeStore;
GAME_API extern DB2Storage<CriteriaEntry>                        sCriteriaStore;
GAME_API extern DB2Storage<CriteriaTreeEntry>                    sCriteriaTreeStore;
GAME_API extern DB2Storage<CurrencyTypesEntry>                   sCurrencyTypesStore;
GAME_API extern DB2Storage<CurveEntry>                           sCurveStore;
GAME_API extern DB2Storage<DestructibleModelDataEntry>           sDestructibleModelDataStore;
GAME_API extern DB2Storage<DifficultyEntry>                      sDifficultyStore;
GAME_API extern DB2Storage<DungeonEncounterEntry>                sDungeonEncounterStore;
GAME_API extern DB2Storage<DurabilityCostsEntry>                 sDurabilityCostsStore;
GAME_API extern DB2Storage<DurabilityQualityEntry>               sDurabilityQualityStore;
GAME_API extern DB2Storage<EmotesEntry>                          sEmotesStore;
GAME_API extern DB2Storage<EmotesTextEntry>                      sEmotesTextStore;
GAME_API extern DB2Storage<FactionEntry>                         sFactionStore;
GAME_API extern DB2Storage<FactionTemplateEntry>                 sFactionTemplateStore;
GAME_API extern DB2Storage<GameObjectDisplayInfoEntry>           sGameObjectDisplayInfoStore;
GAME_API extern DB2Storage<GameObjectsEntry>                     sGameObjectsStore;
GAME_API extern DB2Storage<GarrAbilityEntry>                     sGarrAbilityStore;
GAME_API extern DB2Storage<GarrBuildingEntry>                    sGarrBuildingStore;
GAME_API extern DB2Storage<GarrBuildingPlotInstEntry>            sGarrBuildingPlotInstStore;
GAME_API extern DB2Storage<GarrClassSpecEntry>                   sGarrClassSpecStore;
GAME_API extern DB2Storage<GarrFollowerEntry>                    sGarrFollowerStore;
GAME_API extern DB2Storage<GarrFollowerXAbilityEntry>            sGarrFollowerXAbilityStore;
GAME_API extern DB2Storage<GarrPlotEntry>                        sGarrPlotStore;
GAME_API extern DB2Storage<GarrPlotBuildingEntry>                sGarrPlotBuildingStore;
GAME_API extern DB2Storage<GarrPlotInstanceEntry>                sGarrPlotInstanceStore;
GAME_API extern DB2Storage<GarrSiteLevelEntry>                   sGarrSiteLevelStore;
GAME_API extern DB2Storage<GarrSiteLevelPlotInstEntry>           sGarrSiteLevelPlotInstStore;
GAME_API extern DB2Storage<GemPropertiesEntry>                   sGemPropertiesStore;
GAME_API extern DB2Storage<GlyphPropertiesEntry>                 sGlyphPropertiesStore;
GAME_API extern DB2Storage<GuildColorBackgroundEntry>            sGuildColorBackgroundStore;
GAME_API extern DB2Storage<GuildColorBorderEntry>                sGuildColorBorderStore;
GAME_API extern DB2Storage<GuildColorEmblemEntry>                sGuildColorEmblemStore;
GAME_API extern DB2Storage<GuildPerkSpellsEntry>                 sGuildPerkSpellsStore;
GAME_API extern DB2Storage<HolidaysEntry>                        sHolidaysStore;
GAME_API extern DB2Storage<ImportPriceArmorEntry>                sImportPriceArmorStore;
GAME_API extern DB2Storage<ImportPriceQualityEntry>              sImportPriceQualityStore;
GAME_API extern DB2Storage<ImportPriceShieldEntry>               sImportPriceShieldStore;
GAME_API extern DB2Storage<ImportPriceWeaponEntry>               sImportPriceWeaponStore;
GAME_API extern DB2Storage<ItemAppearanceEntry>                  sItemAppearanceStore;
GAME_API extern DB2Storage<ItemArmorQualityEntry>                sItemArmorQualityStore;
GAME_API extern DB2Storage<ItemArmorShieldEntry>                 sItemArmorShieldStore;
GAME_API extern DB2Storage<ItemArmorTotalEntry>                  sItemArmorTotalStore;
GAME_API extern DB2Storage<ItemBagFamilyEntry>                   sItemBagFamilyStore;
GAME_API extern DB2Storage<ItemDamageAmmoEntry>                  sItemDamageAmmoStore;
GAME_API extern DB2Storage<ItemDamageOneHandEntry>               sItemDamageOneHandStore;
GAME_API extern DB2Storage<ItemDamageOneHandCasterEntry>         sItemDamageOneHandCasterStore;
GAME_API extern DB2Storage<ItemDamageTwoHandEntry>               sItemDamageTwoHandStore;
GAME_API extern DB2Storage<ItemDamageTwoHandCasterEntry>         sItemDamageTwoHandCasterStore;
GAME_API extern DB2Storage<ItemDisenchantLootEntry>              sItemDisenchantLootStore;
GAME_API extern DB2Storage<ItemEffectEntry>                      sItemEffectStore;
GAME_API extern DB2Storage<ItemEntry>                            sItemStore;
GAME_API extern DB2Storage<ItemExtendedCostEntry>                sItemExtendedCostStore;
GAME_API extern DB2Storage<ItemLimitCategoryEntry>               sItemLimitCategoryStore;
GAME_API extern DB2Storage<ItemModifiedAppearanceEntry>          sItemModifiedAppearanceStore;
GAME_API extern DB2Storage<ItemPriceBaseEntry>                   sItemPriceBaseStore;
GAME_API extern DB2Storage<ItemRandomPropertiesEntry>            sItemRandomPropertiesStore;
GAME_API extern DB2Storage<ItemRandomSuffixEntry>                sItemRandomSuffixStore;
GAME_API extern DB2Storage<ItemSearchNameEntry>                  sItemSearchNameStore;
GAME_API extern DB2Storage<ItemSetEntry>                         sItemSetStore;
GAME_API extern DB2Storage<ItemSetSpellEntry>                    sItemSetSpellStore;
GAME_API extern DB2Storage<ItemSparseEntry>                      sItemSparseStore;
GAME_API extern DB2Storage<ItemSpecEntry>                        sItemSpecStore;
GAME_API extern DB2Storage<ItemSpecOverrideEntry>                sItemSpecOverrideStore;
GAME_API extern DB2Storage<ItemUpgradeEntry>                     sItemUpgradeStore;
GAME_API extern DB2Storage<LFGDungeonsEntry>                     sLFGDungeonsStore;
GAME_API extern DB2Storage<LiquidTypeEntry>                      sLiquidTypeStore;
GAME_API extern DB2Storage<LockEntry>                            sLockStore;
GAME_API extern DB2Storage<MailTemplateEntry>                    sMailTemplateStore;
GAME_API extern DB2Storage<MapEntry>                             sMapStore;
GAME_API extern DB2Storage<ModifierTreeEntry>                    sModifierTreeStore;
GAME_API extern DB2Storage<MountCapabilityEntry>                 sMountCapabilityStore;
GAME_API extern DB2Storage<MountEntry>                           sMountStore;
GAME_API extern DB2Storage<MovieEntry>                           sMovieStore;
GAME_API extern DB2Storage<OverrideSpellDataEntry>               sOverrideSpellDataStore;
GAME_API extern DB2Storage<PhaseEntry>                           sPhaseStore;
GAME_API extern DB2Storage<PlayerConditionEntry>                 sPlayerConditionStore;
GAME_API extern DB2Storage<PowerDisplayEntry>                    sPowerDisplayStore;
GAME_API extern DB2Storage<PvpTalentEntry>                       sPvpTalentStore;
GAME_API extern DB2Storage<PvpTalentUnlockEntry>                 sPvpTalentUnlockStore;
GAME_API extern DB2Storage<QuestFactionRewardEntry>              sQuestFactionRewardStore;
GAME_API extern DB2Storage<QuestMoneyRewardEntry>                sQuestMoneyRewardStore;
GAME_API extern DB2Storage<QuestSortEntry>                       sQuestSortStore;
GAME_API extern DB2Storage<QuestXPEntry>                         sQuestXPStore;
GAME_API extern DB2Storage<RandPropPointsEntry>                  sRandPropPointsStore;
GAME_API extern DB2Storage<RewardPackEntry>                      sRewardPackStore;
GAME_API extern DB2Storage<SandboxScalingEntry>                  sSandboxScalingStore;
GAME_API extern DB2Storage<ScalingStatDistributionEntry>         sScalingStatDistributionStore;
GAME_API extern DB2Storage<ScenarioEntry>                        sScenarioStore;
GAME_API extern DB2Storage<ScenarioStepEntry>                    sScenarioStepStore;
GAME_API extern DB2Storage<SkillLineEntry>                       sSkillLineStore;
GAME_API extern DB2Storage<SceneScriptPackageEntry>              sSceneScriptPackageStore;
GAME_API extern DB2Storage<SkillLineAbilityEntry>                sSkillLineAbilityStore;
GAME_API extern DB2Storage<SkillRaceClassInfoEntry>              sSkillRaceClassInfoStore;
GAME_API extern DB2Storage<SoundKitEntry>                        sSoundKitStore;
GAME_API extern DB2Storage<SpellEntry>                           sSpellStore;
GAME_API extern DB2Storage<SpellAuraOptionsEntry>                sSpellAuraOptionsStore;
GAME_API extern DB2Storage<SpellAuraRestrictionsEntry>           sSpellAuraRestrictionsStore;
GAME_API extern DB2Storage<SpellCastTimesEntry>                  sSpellCastTimesStore;
GAME_API extern DB2Storage<SpellCastingRequirementsEntry>        sSpellCastingRequirementsStore;
GAME_API extern DB2Storage<SpellCategoriesEntry>                 sSpellCategoriesStore;
GAME_API extern DB2Storage<SpellCategoryEntry>                   sSpellCategoryStore;
GAME_API extern DB2Storage<SpellClassOptionsEntry>               sSpellClassOptionsStore;
GAME_API extern DB2Storage<SpellCooldownsEntry>                  sSpellCooldownsStore;
GAME_API extern DB2Storage<SpellDurationEntry>                   sSpellDurationStore;
GAME_API extern DB2Storage<SpellEffectEntry>                     sSpellEffectStore;
GAME_API extern DB2Storage<SpellEquippedItemsEntry>              sSpellEquippedItemsStore;
GAME_API extern DB2Storage<SpellFocusObjectEntry>                sSpellFocusObjectStore;
GAME_API extern DB2Storage<SpellInterruptsEntry>                 sSpellInterruptsStore;
GAME_API extern DB2Storage<SpellItemEnchantmentEntry>            sSpellItemEnchantmentStore;
GAME_API extern DB2Storage<SpellItemEnchantmentConditionEntry>   sSpellItemEnchantmentConditionStore;
GAME_API extern DB2Storage<SpellLearnSpellEntry>                 sSpellLearnSpellStore;
GAME_API extern DB2Storage<SpellLevelsEntry>                     sSpellLevelsStore;
GAME_API extern DB2Storage<SpellMiscEntry>                       sSpellMiscStore;
GAME_API extern DB2Storage<SpellPowerEntry>                      sSpellPowerStore;
GAME_API extern DB2Storage<SpellProcsPerMinuteEntry>             sSpellProcsPerMinuteStore;
GAME_API extern DB2Storage<SpellRadiusEntry>                     sSpellRadiusStore;
GAME_API extern DB2Storage<SpellRangeEntry>                      sSpellRangeStore;
GAME_API extern DB2Storage<SpellReagentsEntry>                   sSpellReagentsStore;
GAME_API extern DB2Storage<SpellScalingEntry>                    sSpellScalingStore;
GAME_API extern DB2Storage<SpellShapeshiftEntry>                 sSpellShapeshiftStore;
GAME_API extern DB2Storage<SpellShapeshiftFormEntry>             sSpellShapeshiftFormStore;
GAME_API extern DB2Storage<SpellTargetRestrictionsEntry>         sSpellTargetRestrictionsStore;
GAME_API extern DB2Storage<SpellTotemsEntry>                     sSpellTotemsStore;
GAME_API extern DB2Storage<SpellVisualKitEntry>                  sSpellVisualKitStore;
GAME_API extern DB2Storage<SpellXSpellVisualEntry>               sSpellXSpellVisualStore;
GAME_API extern DB2Storage<SummonPropertiesEntry>                sSummonPropertiesStore;
GAME_API extern DB2Storage<TalentEntry>                          sTalentStore;
GAME_API extern DB2Storage<TaxiNodesEntry>                       sTaxiNodesStore;
GAME_API extern DB2Storage<TaxiPathEntry>                        sTaxiPathStore;
GAME_API extern DB2Storage<TransmogHolidayEntry>                 sTransmogHolidayStore;
GAME_API extern DB2Storage<TransmogSetEntry>                     sTransmogSetStore;
GAME_API extern DB2Storage<TransmogSetGroupEntry>                sTransmogSetGroupStore;
GAME_API extern DB2Storage<TransmogSetItemEntry>                 sTransmogSetItemStore;
GAME_API extern DB2Storage<TransportAnimationEntry>              sTransportAnimationStore;
GAME_API extern DB2Storage<TransportRotationEntry>               sTransportRotationStore;
GAME_API extern DB2Storage<UnitPowerBarEntry>                    sUnitPowerBarStore;
GAME_API extern DB2Storage<VehicleEntry>                         sVehicleStore;
GAME_API extern DB2Storage<VehicleSeatEntry>                     sVehicleSeatStore;
GAME_API extern DB2Storage<WorldEffectEntry>                     sWorldEffectStore;
GAME_API extern DB2Storage<WorldMapAreaEntry>                    sWorldMapAreaStore;
GAME_API extern DB2Storage<WorldMapOverlayEntry>                 sWorldMapOverlayStore;
GAME_API extern DB2Storage<WorldSafeLocsEntry>                   sWorldSafeLocsStore;
GAME_API extern DB2Storage<WorldStateExpressionEntry>            sWorldStateExpressionStore;

struct TaxiPathBySourceAndDestination
{
    TaxiPathBySourceAndDestination() : ID(0), price(0) { }
    TaxiPathBySourceAndDestination(uint32 _id, uint32 _price) : ID(_id), price(_price) { }

    uint32 ID;
    uint32 price;
};

typedef std::map<uint32, TaxiPathBySourceAndDestination> TaxiPathSetForSource;
typedef std::map<uint32, TaxiPathSetForSource> TaxiPathSetBySource;

typedef std::vector<TaxiPathNodeEntry const*> TaxiPathNodeList;
typedef std::vector<TaxiPathNodeList> TaxiPathNodesByPath;

GAME_API extern TaxiMask                                         sTaxiNodesMask;
GAME_API extern TaxiMask                                         sOldContinentsNodesMask;
GAME_API extern TaxiMask                                         sHordeTaxiNodesMask;
GAME_API extern TaxiMask                                         sAllianceTaxiNodesMask;
GAME_API extern TaxiPathSetBySource                              sTaxiPathSetBySource;
GAME_API extern TaxiPathNodesByPath                              sTaxiPathNodesByPath;

#define DEFINE_DB2_SET_COMPARATOR(structure) \
    struct structure ## Comparator \
    { \
        bool operator()(structure const* left, structure const* right) const { return Compare(left, right); } \
        static bool Compare(structure const* left, structure const* right); \
    };

class GAME_API DB2Manager
{
public:
    DEFINE_DB2_SET_COMPARATOR(MountTypeXCapabilityEntry)

    typedef std::vector<ItemBonusEntry const*> ItemBonusList;
    typedef std::unordered_map<uint32, std::unordered_map<uint32, MapDifficultyEntry const*>> MapDifficultyContainer;
    typedef std::set<MountTypeXCapabilityEntry const*, MountTypeXCapabilityEntryComparator> MountTypeXCapabilitySet;
    typedef std::vector<MountXDisplayEntry const*> MountXDisplayContainer;

    static DB2Manager& Instance();

    void LoadStores(std::string const& dataPath, uint32 defaultLocale);
    DB2StorageBase const* GetStorage(uint32 type) const;

    void LoadHotfixData();
    std::map<uint64, int32> const& GetHotfixData() const;

    std::vector<uint32> GetAreasForGroup(uint32 areaGroupId) const;
    static bool IsInArea(uint32 objectAreaId, uint32 areaId);
    std::vector<ArtifactPowerEntry const*> GetArtifactPowers(uint8 artifactId) const;
    std::unordered_set<uint32> const* GetArtifactPowerLinks(uint32 artifactPowerId) const;
    ArtifactPowerRankEntry const* GetArtifactPowerRank(uint32 artifactPowerId, uint8 rank) const;
    static char const* GetBroadcastTextValue(BroadcastTextEntry const* broadcastText, LocaleConstant locale = DEFAULT_LOCALE, uint8 gender = GENDER_MALE, bool forceGender = false);
    bool HasCharacterFacialHairStyle(uint8 race, uint8 gender, uint8 variationId) const;
    bool HasCharSections(uint8 race, uint8 gender, CharBaseSectionVariation variation) const;
    CharSectionsEntry const* GetCharSectionEntry(uint8 race, uint8 gender, CharBaseSectionVariation variation, uint8 variationIndex, uint8 color) const;
    CharStartOutfitEntry const* GetCharStartOutfitEntry(uint8 race, uint8 class_, uint8 gender) const;
    static char const* GetClassName(uint8 class_, LocaleConstant locale = DEFAULT_LOCALE);
    uint32 GetPowerIndexByClass(Powers power, uint32 classId) const;
    static char const* GetChrRaceName(uint8 race, LocaleConstant locale = DEFAULT_LOCALE);
    ChrSpecializationEntry const* GetChrSpecializationByIndex(uint32 class_, uint32 index) const;
    ChrSpecializationEntry const* GetDefaultChrSpecializationForClass(uint32 class_) const;
    static char const* GetCreatureFamilyPetName(uint32 petfamily, uint32 locale);
    float GetCurveValueAt(uint32 curveId, float x) const;
    EmotesTextSoundEntry const* GetTextSoundEmoteFor(uint32 emote, uint8 race, uint8 gender, uint8 class_) const;
    std::vector<uint32> const* GetFactionTeamList(uint32 faction) const;
    HeirloomEntry const* GetHeirloomByItemId(uint32 itemId) const;
    std::vector<uint32> const* GetGlyphBindableSpells(uint32 glyphPropertiesId) const;
    std::vector<uint32> const* GetGlyphRequiredSpecs(uint32 glyphPropertiesId) const;
    ItemBonusList const* GetItemBonusList(uint32 bonusListId) const;
    uint32 GetItemBonusListForItemLevelDelta(int16 delta) const;
    std::set<uint32> GetItemBonusTree(uint32 itemId, uint32 itemContext) const;
    ItemChildEquipmentEntry const* GetItemChildEquipment(uint32 itemId) const;
    ItemClassEntry const* GetItemClassByOldEnum(uint32 itemClass) const;
    bool HasItemCurrencyCost(uint32 itemId) const;
    std::vector<ItemLimitCategoryConditionEntry const*> const* GetItemLimitCategoryConditions(uint32 categoryId) const;
    uint32 GetItemDisplayId(uint32 itemId, uint32 appearanceModId) const;
    ItemModifiedAppearanceEntry const* GetItemModifiedAppearance(uint32 itemId, uint32 appearanceModId) const;
    ItemModifiedAppearanceEntry const* GetDefaultItemModifiedAppearance(uint32 itemId) const;
    std::vector<ItemSetSpellEntry const*> const* GetItemSetSpells(uint32 itemSetId) const;
    std::vector<ItemSpecOverrideEntry const*> const* GetItemSpecOverrides(uint32 itemId) const;
    static LFGDungeonsEntry const* GetLfgDungeon(uint32 mapId, Difficulty difficulty);
    static uint32 GetDefaultMapLight(uint32 mapId);
    static uint32 GetLiquidFlags(uint32 liquidType);
    MapDifficultyContainer const& GetMapDifficulties() const;
    MapDifficultyEntry const* GetDefaultMapDifficulty(uint32 mapId, Difficulty* difficulty = nullptr) const;
    MapDifficultyEntry const* GetMapDifficultyData(uint32 mapId, Difficulty difficulty) const;
    MapDifficultyEntry const* GetDownscaledMapDifficultyData(uint32 mapId, Difficulty &difficulty) const;
    std::string GetNameGenEntry(uint8 race, uint8 gender) const;
    MountEntry const* GetMount(uint32 spellId) const;
    MountEntry const* GetMountById(uint32 id) const;
    MountTypeXCapabilitySet const* GetMountCapabilities(uint32 mountType) const;
    MountXDisplayContainer const* GetMountDisplays(uint32 mountId) const;
    ResponseCodes ValidateName(std::wstring const& name, LocaleConstant locale) const;
    std::vector<uint32> const* GetPhasesForGroup(uint32 group) const;
    PowerTypeEntry const* GetPowerTypeEntry(Powers power) const;
    PowerTypeEntry const* GetPowerTypeByName(std::string const& name) const;
    uint8 GetPvpItemLevelBonus(uint32 itemId) const;
    uint8 GetMaxPrestige() const;
    static PVPDifficultyEntry const* GetBattlegroundBracketByLevel(uint32 mapid, uint32 level);
    static PVPDifficultyEntry const* GetBattlegroundBracketById(uint32 mapid, BattlegroundBracketId id);
    uint32 GetRewardPackIDForPvpRewardByHonorLevelAndPrestige(uint8 honorLevel, uint8 prestige) const;
    uint32 GetRequiredHonorLevelForPvpTalent(PvpTalentEntry const* talentInfo) const;
    std::vector<PvpTalentEntry const*> const& GetPvpTalentsByPosition(uint32 class_, uint32 tier, uint32 column) const;
    std::vector<QuestPackageItemEntry const*> const* GetQuestPackageItems(uint32 questPackageID) const;
    std::vector<QuestPackageItemEntry const*> const* GetQuestPackageItemsFallback(uint32 questPackageID) const;
    uint32 GetQuestUniqueBitFlag(uint32 questId);
    std::vector<RewardPackXCurrencyTypeEntry const*> const* GetRewardPackCurrencyTypesByRewardID(uint32 rewardPackID) const;
    std::vector<RewardPackXItemEntry const*> const* GetRewardPackItemsByRewardID(uint32 rewardPackID) const;
    uint32 GetRulesetItemUpgrade(uint32 itemId) const;
    SkillRaceClassInfoEntry const* GetSkillRaceClassInfo(uint32 skill, uint8 race, uint8 class_);
    std::vector<SpecializationSpellsEntry const*> const* GetSpecializationSpells(uint32 specId) const;
    static bool IsValidSpellFamiliyName(SpellFamilyNames family);
    std::vector<SpellPowerEntry const*> GetSpellPowers(uint32 spellId, Difficulty difficulty = DIFFICULTY_NONE, bool* hasDifficultyPowers = nullptr) const;
    std::vector<SpellProcsPerMinuteModEntry const*> GetSpellProcsPerMinuteMods(uint32 spellprocsPerMinuteId) const;
    std::vector<TalentEntry const*> const& GetTalentsByPosition(uint32 class_, uint32 tier, uint32 column) const;
    static bool IsTotemCategoryCompatibleWith(uint32 itemTotemCategoryId, uint32 requiredTotemCategoryId);
    bool IsToyItem(uint32 toy) const;
    std::vector<TransmogSetEntry const*> const* GetTransmogSetsForItemModifiedAppearance(uint32 itemModifiedAppearanceId) const;
    std::vector<TransmogSetItemEntry const*> const* GetTransmogSetItems(uint32 transmogSetId) const;
    WMOAreaTableEntry const* GetWMOAreaTable(int32 rootId, int32 adtId, int32 groupId) const;
    uint32 GetVirtualMapForMapAndZone(uint32 mapId, uint32 zoneId) const;
    void Zone2MapCoordinates(uint32 areaId, float& x, float& y) const;
    void Map2ZoneCoordinates(uint32 areaId, float& x, float& y) const;
    static void DeterminaAlternateMapPosition(uint32 mapId, float x, float y, float z, uint32* newMapId = nullptr, DBCPosition2D* newPos = nullptr);

private:
    friend class DB2HotfixGeneratorBase;
    void InsertNewHotfix(uint32 tableHash, uint32 recordId);
    uint32 _maxHotfixId = 0;
};

#define sDB2Manager DB2Manager::Instance()

#endif
