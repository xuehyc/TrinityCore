/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "GameConfig.h"
#include "Config.h"
#include "Object.h"
#include "Log.h"
#include "Player.h"
#include "ServerMotd.h"
#include "World.h"
#include "Types.h"
#include <unordered_map>

namespace
{
    std::unordered_map<std::string, bool> _boolConfigs;
    std::unordered_map<std::string, std::string> _stringConfigs;
    std::unordered_map<std::string, int32> _intConfigs;
    std::unordered_map<std::string, float> _floatConfigs;
}

GameConfig* GameConfig::instance()
{
    static GameConfig instance;
    return &instance;
}

void GameConfig::Load(bool reload)
{
    LOG_INFO("config", "%s game configuraton:", reload ? "Reloading" : "Loading");

    LoadBoolConfigs(reload);
    LoadStringConfigs(reload);
    LoadIntConfigs(reload);
    LoadFloatConfigs(reload);

    LOG_INFO("config", "");
}

// Add option
template<>
WH_GAME_API void GameConfig::AddOption<bool>(std::string const& optionName, std::optional<bool> const& def /*= std::nullopt*/) const
{
    // Check exist option
    auto itr = _boolConfigs.find(optionName);
    if (itr != _boolConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is already exists", optionName.c_str());
        return;
    }

    _boolConfigs.emplace(optionName, sConfigMgr->GetBoolDefault(optionName, def == std::nullopt ? false : *def));
}

template<>
WH_GAME_API void GameConfig::AddOption<std::string>(std::string const& optionName, std::optional<std::string> const& def /*= std::nullopt*/) const
{
    // Check exist option
    auto itr = _stringConfigs.find(optionName);
    if (itr != _stringConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is already exists", optionName.c_str());
        return;
    }

    _stringConfigs.emplace(std::make_pair(optionName, sConfigMgr->GetStringDefault(optionName, def == std::nullopt ? "" : *def)));
}

template<>
WH_GAME_API void GameConfig::AddOption<int32>(std::string const& optionName, std::optional<int32> const& def /*= std::nullopt*/) const
{
    // Check exist option
    auto itr = _intConfigs.find(optionName);
    if (itr != _intConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is already exists", optionName.c_str());
        return;
    }

    _intConfigs.emplace(std::make_pair(optionName, sConfigMgr->GetIntDefault(optionName, def == std::nullopt ? 0 : *def)));
}

template<>
WH_GAME_API void GameConfig::AddOption<uint32>(std::string const& optionName, std::optional<uint32> const& def /*= std::nullopt*/) const
{
    AddOption<int32>(optionName, def);
}

template<>
WH_GAME_API void GameConfig::AddOption<float>(std::string const& optionName, std::optional<float> const& def /*= std::nulloptf*/) const
{
    // Check exist option
    auto itr = _floatConfigs.find(optionName);
    if (itr != _floatConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is already exists", optionName.c_str());
        return;
    }

    _floatConfigs.emplace(std::make_pair(optionName, sConfigMgr->GetFloatDefault(optionName, def == std::nullopt ? 1.0f : *def)));
}

// Get option
template<>
WH_GAME_API bool GameConfig::GetOption<bool>(std::string const& optionName, std::optional<bool> const& def /*= std::nullopt*/) const
{
    // Check exist option
    auto itr = _boolConfigs.find(optionName);
    if (itr == _boolConfigs.end())
    {
        auto retValue = def == std::nullopt ? false : *def;
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists. Returned (%s)", optionName.c_str(), retValue ? "true" : "false");
        return retValue;
    }

    return _boolConfigs.at(optionName);
}

template<>
WH_GAME_API std::string GameConfig::GetOption<std::string>(std::string const& optionName, std::optional<std::string> const& def /*= std::nullopt*/) const
{
    // Check exist option
    auto itr = _stringConfigs.find(optionName);
    if (itr == _stringConfigs.end())
    {
        auto retValue = def == std::nullopt ? "" : *def;
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists. Returned (%s)", optionName.c_str(), retValue.c_str());
        return retValue;
    }

    return _stringConfigs.at(optionName);
}

template<>
WH_GAME_API int32 GameConfig::GetOption<int32>(std::string const& optionName, std::optional<int32> const& def /*= std::nullopt*/) const
{
    // Check exist option
    auto itr = _intConfigs.find(optionName);
    if (itr == _intConfigs.end())
    {
        auto retValue = def == std::nullopt ? 0 : *def;
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists. Returned (%u)", optionName.c_str(), retValue);
        return retValue;
    }

    return _intConfigs.at(optionName);
}

template<>
WH_GAME_API uint32 GameConfig::GetOption<uint32>(std::string const& optionName, std::optional<uint32> const& def /*= std::nullopt*/) const
{
    return static_cast<uint32>(GetOption<int32>(optionName, def));
}

template<>
WH_GAME_API float GameConfig::GetOption<float>(std::string const& optionName, std::optional<float> const& def /*= std::nulloptf*/) const
{
    // Check exist option
    auto itr = _floatConfigs.find(optionName);
    if (itr == _floatConfigs.end())
    {
        auto retValue = def == std::nullopt ? 1.0f : *def;
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists. Returned (%f)", optionName.c_str(), retValue);
        return retValue;
    }

    return _floatConfigs.at(optionName);
}

// Set option
template<>
WH_GAME_API void GameConfig::SetOption<bool>(std::string const& optionName, bool const& value) const
{
    // Check exist option
    auto itr = _boolConfigs.find(optionName);
    if (itr == _boolConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists", optionName.c_str());
        return;
    }

    _boolConfigs.erase(optionName);
    _boolConfigs.emplace(optionName, value);
}

template<>
WH_GAME_API void GameConfig::SetOption<std::string>(std::string const& optionName, std::string const& value) const
{
    // Check exist option
    auto itr = _stringConfigs.find(optionName);
    if (itr == _stringConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists", optionName.c_str());
        return;
    }

    _stringConfigs.erase(optionName);
    _stringConfigs.emplace(optionName, value);
}

template<>
WH_GAME_API void GameConfig::SetOption<int32>(std::string const& optionName, int32 const& value) const
{
    // Check exist option
    auto itr = _intConfigs.find(optionName);
    if (itr == _intConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists", optionName.c_str());
        return;
    }

    _intConfigs.erase(optionName);
    _intConfigs.emplace(optionName, value);
}

template<>
WH_GAME_API void GameConfig::SetOption<uint32>(std::string const& optionName, uint32 const& value) const
{
    SetOption<int32>(optionName, value);
}

template<>
WH_GAME_API void GameConfig::SetOption<float>(std::string const& optionName, float const& value) const
{
    // Check exist option
    auto itr = _floatConfigs.find(optionName);
    if (itr == _floatConfigs.end())
    {
        LOG_ERROR("config", "> GameConfig: option (%s) is not exists", optionName.c_str());
        return;
    }

    _floatConfigs.erase(optionName);
    _floatConfigs.emplace(optionName, value);
}

// Loading
void GameConfig::LoadBoolConfigs(bool reload /*= false*/)
{
    if (reload)
        _boolConfigs.clear();

    AddOption<bool>("Language.SupportOnlyDefault", true);
    AddOption<bool>("AllowTickets", true);
    AddOption<bool>("DeletedCharacterTicketTrace");
    AddOption<bool>("DurabilityLoss.InPvP");
    AddOption<bool>("AddonChannel");
    AddOption<bool>("CleanCharacterDB");
    AddOption<bool>("PreserveCustomChannels");
    AddOption<bool>("GridUnload", true);
    AddOption<bool>("BaseMapLoadAllGrids");
    AddOption<bool>("InstanceMapLoadAllGrids");
    AddOption<bool>("PlayerSave.Stats.SaveOnlyOnLogout", true);
    AddOption<bool>("Creature.RegenHPCannotReachTargetInRaid", true);
    AddOption<bool>("AllowTwoSide.Interaction.Calendar");
    AddOption<bool>("AllowTwoSide.Interaction.Channel");
    AddOption<bool>("AllowTwoSide.Interaction.Group");
    AddOption<bool>("AllowTwoSide.Interaction.Guild");
    AddOption<bool>("AllowTwoSide.Interaction.Auction");
    AddOption<bool>("AllowTwoSide.Trade");
    AddOption<bool>("AllFlightPaths");
    AddOption<bool>("InstantFlightPaths");
    AddOption<bool>("Instance.IgnoreLevel");
    AddOption<bool>("Instance.IgnoreRaid");
    AddOption<bool>("CastUnstuck");
    AddOption<bool>("GM.AllowInvite");
    AddOption<bool>("GM.LowerSecurity");
    AddOption<bool>("SkillChance.Prospecting");
    AddOption<bool>("SkillChance.Milling");
    AddOption<bool>("ActivateWeather");
    AddOption<bool>("AlwaysMaxSkillForLevel");
    AddOption<bool>("Event.Announce");
    AddOption<bool>("Quests.EnableQuestTracker");
    AddOption<bool>("Quests.IgnoreRaid");
    AddOption<bool>("Quests.IgnoreAutoAccept");
    AddOption<bool>("Quests.IgnoreAutoComplete");
    AddOption<bool>("DetectPosCollision");
    AddOption<bool>("Channel.RestrictedLfg");
    AddOption<bool>("ChatFakeMessagePreventing");
    AddOption<bool>("Death.CorpseReclaimDelay.PvP");
    AddOption<bool>("Death.CorpseReclaimDelay.PvE");
    AddOption<bool>("Death.Bones.World");
    AddOption<bool>("Death.Bones.BattlegroundOrArena");
    AddOption<bool>("Die.Command.Mode");
    AddOption<bool>("DeclinedNames");
    AddOption<bool>("Battleground.CastDeserter");
    AddOption<bool>("Battleground.QueueAnnouncer.Enable");
    AddOption<bool>("Battleground.QueueAnnouncer.PlayerOnly");
    AddOption<bool>("Battleground.StoreStatistics.Enable");
    AddOption<bool>("Battleground.TrackDeserters.Enable");
    AddOption<bool>("Battleground.GiveXPForKills");
    AddOption<bool>("Arena.AutoDistributePoints");
    AddOption<bool>("Arena.QueueAnnouncer.Enable");
    AddOption<bool>("Arena.ArenaSeason.InProgress");
    AddOption<bool>("ArenaLog.ExtendedInfo");
    AddOption<bool>("OffhandCheckAtSpellUnlearn");
    AddOption<bool>("Respawn.DynamicEscortNPC");
    AddOption<bool>("mmap.enablePathFinding");
    AddOption<bool>("vmap.enableIndoorCheck");
    AddOption<bool>("vmap.enableLOS");
    AddOption<bool>("vmap.enableHeight");
    AddOption<bool>("PlayerStart.AllSpells");
    AddOption<bool>("ResetDuelCooldowns");
    AddOption<bool>("ResetDuelHealthMana");
    AddOption<bool>("PlayerStart.MapsExplored");
    AddOption<bool>("PlayerStart.AllReputation");
    AddOption<bool>("AlwaysMaxWeaponSkill");
    AddOption<bool>("PvPToken.Enable");
    AddOption<bool>("AllowTrackBothResources");
    AddOption<bool>("NoResetTalentsCost");
    AddOption<bool>("ShowKickInWorld");
    AddOption<bool>("ShowMuteInWorld");
    AddOption<bool>("ShowBanInWorld");
    AddOption<bool>("Mute.AddAfterLogin.Enable");
    AddOption<bool>("Warden.Enabled");
    AddOption<bool>("DBC.EnforceItemAttributes");
    AddOption<bool>("InstancesResetAnnounce");
    AddOption<bool>("AutoBroadcast.On");
    AddOption<bool>("PlayerDump.DisallowPaths");
    AddOption<bool>("PlayerDump.DisallowOverwrite");
    AddOption<bool>("Wintergrasp.Enable");
    AddOption<bool>("Stats.Limits.Enable");
    AddOption<bool>("Allow.IP.Based.Action.Logging");
    AddOption<bool>("Calculate.Creature.Zone.Area.Data");
    AddOption<bool>("Calculate.Gameoject.Zone.Area.Data");
    AddOption<bool>("HotSwap.Enabled");
    AddOption<bool>("HotSwap.EnableReCompiler");
    AddOption<bool>("HotSwap.EnableEarlyTermination");
    AddOption<bool>("HotSwap.EnableBuildFileRecreation");
    AddOption<bool>("HotSwap.EnableInstall");
    AddOption<bool>("HotSwap.EnablePrefixCorrection");
    AddOption<bool>("PreventRenameCharacterOnCustomization");
    AddOption<bool>("PartyRaidWarnings");
    AddOption<bool>("CacheDataQueries");
    AddOption<bool>("CheckGameObjectLoS");

    LOG_INFO("config", "> Loaded %u bool configs", static_cast<uint32>(_boolConfigs.size()));
}

void GameConfig::LoadStringConfigs(bool reload /*= false*/)
{
    if (reload)
        _stringConfigs.clear();

    AddOption<std::string>("DataDir", "./");
    AddOption<std::string>("PlayerStart.String");
    AddOption<std::string>("Motd");
    AddOption<std::string>("Respawn.WarningMessage");
    AddOption<std::string>("Respawn.AlertRestartReason");

    LOG_INFO("config", "> Loaded %u string configs", static_cast<uint32>(_stringConfigs.size()));
}

void GameConfig::LoadIntConfigs(bool reload /*= false*/)
{
    std::unordered_map<std::string, int32> _notChangeConfigs;

    if (reload)
    {
        _notChangeConfigs =
        {
            { "WorldServerPort", GetOption<int32>("WorldServerPort") },
            { "GameType", GetOption<int32>("GameType") },
            { "RealmZone", GetOption<int32>("RealmZone") },
            { "MaxPlayerLevel", GetOption<int32>("MaxPlayerLevel") },
            { "Expansion", GetOption<int32>("Expansion") }
        };
    }

    if (reload)
        _intConfigs.clear();

    AddOption<int32>("PlayerLimit");
    AddOption<int32>("Server.LoginInfo");
    AddOption<int32>("XP.Boost.Daymask");
    AddOption<int32>("Compression");
    AddOption<int32>("PersistentCharacterCleanFlags");
    AddOption<int32>("Auction.GetAllScanDelay");
    AddOption<int32>("Auction.SearchDelay");
    AddOption<int32>("ChatLevelReq.Channel");
    AddOption<int32>("ChatLevelReq.Whisper");
    AddOption<int32>("ChatLevelReq.Emote");
    AddOption<int32>("ChatLevelReq.Say");
    AddOption<int32>("ChatLevelReq.Yell");
    AddOption<int32>("PartyLevelReq");
    AddOption<int32>("LevelReq.Trade");
    AddOption<int32>("LevelReq.Ticket");
    AddOption<int32>("LevelReq.Auction");
    AddOption<int32>("LevelReq.Mail");
    AddOption<int32>("PreserveCustomChannelDuration");
    AddOption<int32>("PreserveCustomChannelInterval");
    AddOption<int32>("PlayerSaveInterval");
    AddOption<int32>("DisconnectToleranceInterval");
    AddOption<int32>("PlayerSave.Stats.MinLevel");
    AddOption<int32>("GridCleanUpDelay");
    AddOption<int32>("MapUpdateInterval");
    AddOption<int32>("WorldServerPort");
    AddOption<int32>("ChangeWeatherInterval");
    AddOption<int32>("SocketTimeOutTime");
    AddOption<int32>("SocketTimeOutTimeActive");
    AddOption<int32>("SessionAddDelay");
    AddOption<int32>("MinQuestScaledXPRatio");
    AddOption<int32>("MinCreatureScaledXPRatio");
    AddOption<int32>("MinDiscoveredScaledXPRatio");
    AddOption<int32>("GameType");
    AddOption<int32>("RealmZone");
    AddOption<int32>("StrictPlayerNames");
    AddOption<int32>("StrictCharterNames");
    AddOption<int32>("StrictPetNames");
    AddOption<int32>("MinPlayerName");
    AddOption<int32>("MinCharterName");
    AddOption<int32>("MinPetName");
    AddOption<int32>("Guild.CharterCost");
    AddOption<int32>("ArenaTeam.CharterCost.2v2");
    AddOption<int32>("ArenaTeam.CharterCost.3v3");
    AddOption<int32>("ArenaTeam.CharterCost.5v5");
    AddOption<int32>("CharacterCreating.Disabled");
    AddOption<int32>("CharacterCreating.Disabled.RaceMask");
    AddOption<int32>("CharacterCreating.Disabled.ClassMask");
    AddOption<int32>("CharactersPerRealm");
    AddOption<int32>("CharactersPerAccount");
    AddOption<int32>("DeathKnightsPerRealm");
    AddOption<int32>("CharacterCreating.MinLevelForDeathKnight");
    AddOption<int32>("SkipCinematics");
    AddOption<int32>("MaxPlayerLevel");
    AddOption<int32>("MinDualSpecLevel");
    AddOption<int32>("StartPlayerLevel");
    AddOption<int32>("StartDeathKnightPlayerLevel");
    AddOption<int32>("StartPlayerMoney");
    AddOption<int32>("MaxHonorPoints");
    AddOption<int32>("StartHonorPoints");
    AddOption<int32>("MaxArenaPoints");
    AddOption<int32>("StartArenaPoints");
    AddOption<int32>("RecruitAFriend.MaxLevel");
    AddOption<int32>("RecruitAFriend.MaxDifference");
    AddOption<int32>("Instance.ResetTimeHour");
    AddOption<int32>("Instance.UnloadDelay");
    AddOption<int32>("Quests.DailyResetTime");
    AddOption<int32>("Quests.WeeklyResetWDay");
    AddOption<int32>("MaxPrimaryTradeSkill");
    AddOption<int32>("MinPetitionSigns");
    AddOption<int32>("GM.LoginState");
    AddOption<int32>("GM.Visible");
    AddOption<int32>("GM.Chat");
    AddOption<int32>("GM.WhisperingTo");
    AddOption<int32>("GM.FreezeAuraDuration");
    AddOption<int32>("GM.InGMList.Level");
    AddOption<int32>("GM.InWhoList.Level");
    AddOption<int32>("GM.StartLevel");
    AddOption<int32>("GM.ForceShutdownThreshold");
    AddOption<int32>("Visibility.GroupMode");
    AddOption<int32>("MailDeliveryDelay");
    AddOption<int32>("CleanOldMailTime");
    AddOption<int32>("UpdateUptimeInterval");
    AddOption<int32>("LogDB.Opt.ClearInterval");
    AddOption<int32>("LogDB.Opt.ClearTime");
    AddOption<int32>("SkillChance.Orange");
    AddOption<int32>("SkillChance.Yellow");
    AddOption<int32>("SkillChance.Green");
    AddOption<int32>("SkillChance.Grey");
    AddOption<int32>("SkillChance.MiningSteps");
    AddOption<int32>("SkillChance.SkinningSteps");
    AddOption<int32>("SkillGain.Crafting");
    AddOption<int32>("SkillGain.Defense");
    AddOption<int32>("SkillGain.Gathering");
    AddOption<int32>("SkillGain.Weapon");
    AddOption<int32>("MaxOverspeedPings");
    AddOption<int32>("DisableWaterBreath");
    AddOption<int32>("Expansion");
    AddOption<int32>("ChatFlood.MessageCount");
    AddOption<int32>("ChatFlood.MessageDelay");
    AddOption<int32>("ChatFlood.MuteTime");
    AddOption<int32>("CreatureFamilyAssistanceDelay");
    AddOption<int32>("CreatureFamilyFleeDelay");
    AddOption<int32>("WorldBossLevelDiff");
    AddOption<int32>("Quests.LowLevelHideDiff");
    AddOption<int32>("Quests.HighLevelHideDiff");
    AddOption<int32>("Battleground.Random.ResetHour");
    AddOption<int32>("Calendar.DeleteOldEventsHour");
    AddOption<int32>("Guild.ResetHour");
    AddOption<int32>("TalentsInspecting");
    AddOption<int32>("ChatStrictLinkChecking.Severity");
    AddOption<int32>("ChatStrictLinkChecking.Kick");
    AddOption<int32>("Corpse.Decay.NORMAL");
    AddOption<int32>("Corpse.Decay.RARE");
    AddOption<int32>("Corpse.Decay.ELITE");
    AddOption<int32>("Corpse.Decay.RAREELITE");
    AddOption<int32>("Corpse.Decay.WORLDBOSS");
    AddOption<int32>("Death.SicknessLevel");
    AddOption<int32>("Battleground.ReportAFK");
    AddOption<int32>("Battleground.InvitationType");
    AddOption<int32>("Battleground.PrematureFinishTimer");
    AddOption<int32>("Battleground.PremadeGroupWaitForMatch");
    AddOption<int32>("Arena.MaxRatingDifference");
    AddOption<int32>("Arena.RatingDiscardTimer");
    AddOption<int32>("Arena.PreviousOpponentsDiscardTimer");
    AddOption<int32>("Arena.RatedUpdateTimer");
    AddOption<int32>("Arena.AutoDistributeInterval");
    AddOption<int32>("Arena.ArenaSeason.ID");
    AddOption<int32>("Arena.ArenaStartRating");
    AddOption<int32>("Arena.ArenaStartPersonalRating");
    AddOption<int32>("Arena.ArenaStartMatchmakerRating");
    AddOption<int32>("Creature.PickPocketRefillDelay");
    AddOption<int32>("Creature.MovingStopTimeForPlayer");
    AddOption<int32>("Guild.EventLogRecordsCount");
    AddOption<int32>("Guild.BankEventLogRecordsCount");
    AddOption<int32>("Visibility.Notify.Period.OnContinents");
    AddOption<int32>("Visibility.Notify.Period.InInstances");
    AddOption<int32>("Visibility.Notify.Period.InBG");
    AddOption<int32>("Visibility.Notify.Period.InArenas");
    AddOption<int32>("CharDelete.Method");
    AddOption<int32>("CharDelete.MinLevel");
    AddOption<int32>("CharDelete.DeathKnight.MinLevel");
    AddOption<int32>("CharDelete.KeepDays");
    AddOption<int32>("NoGrayAggro.Above");
    AddOption<int32>("NoGrayAggro.Below");
    AddOption<int32>("Respawn.MinCheckIntervalMS");
    AddOption<int32>("Respawn.DynamicMode");
    AddOption<int32>("Respawn.GuidWarnLevel");
    AddOption<int32>("Respawn.GuidAlertLevel");
    AddOption<int32>("Respawn.RestartQuietTime");
    AddOption<int32>("Respawn.DynamicMinimumCreature");
    AddOption<int32>("Respawn.DynamicMinimumGameObject");
    AddOption<int32>("Respawn.WarningFrequency");
    AddOption<int32>("MaxWhoListReturns");
    AddOption<int32>("HonorPointsAfterDuel");
    AddOption<int32>("PvPToken.MapAllowType");
    AddOption<int32>("PvPToken.ItemID");
    AddOption<int32>("PvPToken.ItemCount");
    AddOption<int32>("MapUpdate.Threads");
    AddOption<int32>("Command.LookupMaxResults");
    AddOption<int32>("Warden.NumInjectionChecks");
    AddOption<int32>("Warden.NumLuaSandboxChecks");
    AddOption<int32>("Warden.NumClientModChecks");
    AddOption<int32>("Warden.BanDuration");
    AddOption<int32>("Warden.ClientCheckHoldOff");
    AddOption<int32>("Warden.ClientCheckFailAction");
    AddOption<int32>("Warden.ClientResponseDelay");
    AddOption<int32>("DungeonFinder.OptionsMask");
    AddOption<int32>("Account.PasswordChangeSecurity");
    AddOption<int32>("Battleground.RewardWinnerHonorFirst");
    AddOption<int32>("Battleground.RewardWinnerArenaFirst");
    AddOption<int32>("Battleground.RewardWinnerHonorLast");
    AddOption<int32>("Battleground.RewardWinnerArenaLast");
    AddOption<int32>("Battleground.RewardLoserHonorFirst");
    AddOption<int32>("Battleground.RewardLoserHonorLast");
    AddOption<int32>("AccountInstancesPerHour");
    AddOption<int32>("AutoBroadcast.Center");
    AddOption<int32>("AutoBroadcast.Timer");
    AddOption<int32>("MaxPingTime");
    AddOption<int32>("Wintergrasp.PlayerMax");
    AddOption<int32>("Wintergrasp.PlayerMin");
    AddOption<int32>("Wintergrasp.PlayerMinLvl");
    AddOption<int32>("Wintergrasp.BattleTimer");
    AddOption<int32>("Wintergrasp.NoBattleTimer");
    AddOption<int32>("Wintergrasp.CrashRestartTimer");
    AddOption<int32>("PacketSpoof.Policy");
    AddOption<int32>("PacketSpoof.BanMode");
    AddOption<int32>("PacketSpoof.BanDuration");
    AddOption<int32>("BirthdayTime");
    AddOption<int32>("AuctionHouseBot.Update.Interval");
    AddOption<int32>("DBC.Locale");
    AddOption<int32>("RealmID");

    if (reload)
        AddOption<int32>("ClientCacheVersion");

    // Custom
    AddOption<int32>("Antispam.Mail.Controller");

    // Check options can't be changed at worldserver.conf reload
    if (reload)
    {
        for (auto const& itr : _notChangeConfigs)
        {
            uint32 val = sConfigMgr->GetIntDefault(itr.first, itr.second);
            uint32 tempIntOption = itr.second;

            if (val != tempIntOption)
                LOG_ERROR("config", "%s option can't be changed at worldserver.conf reload, using current value (%u)", itr.first.c_str(), tempIntOption);

            SetOption<int32>(itr.first, tempIntOption);
        }
    }

    LOG_INFO("config", "> Loaded %u int configs", static_cast<uint32>(_intConfigs.size()));
}

void GameConfig::LoadFloatConfigs(bool reload /*= false*/)
{
    if (reload)
        _floatConfigs.clear();

    AddOption<float>("Rate.Health");
    AddOption<float>("Rate.Mana");
    AddOption<float>("Rate.Rage.Income");
    AddOption<float>("Rate.Rage.Loss");
    AddOption<float>("Rate.RunicPower.Income");
    AddOption<float>("Rate.RunicPower.Loss");
    AddOption<float>("Rate.Focus");
    AddOption<float>("Rate.Energy");
    AddOption<float>("Rate.Skill.Discovery");
    AddOption<float>("Rate.Drop.Item.Poor");
    AddOption<float>("Rate.Drop.Item.Normal");
    AddOption<float>("Rate.Drop.Item.Uncommon");
    AddOption<float>("Rate.Drop.Item.Rare");
    AddOption<float>("Rate.Drop.Item.Epic");
    AddOption<float>("Rate.Drop.Item.Legendary");
    AddOption<float>("Rate.Drop.Item.Artifact");
    AddOption<float>("Rate.Drop.Item.Referenced");
    AddOption<float>("Rate.Drop.Item.ReferencedAmount");
    AddOption<float>("Rate.Drop.Money");
    AddOption<float>("Rate.XP.Kill");
    AddOption<float>("Rate.XP.BattlegroundKill");
    AddOption<float>("Rate.XP.Quest");
    AddOption<float>("Rate.XP.Explore");
    AddOption<float>("XP.Boost.Rate");
    AddOption<float>("Rate.RepairCost");
    AddOption<float>("Rate.Reputation.Gain");
    AddOption<float>("Rate.Reputation.LowLevel.Kill");
    AddOption<float>("Rate.Reputation.LowLevel.Quest");
    AddOption<float>("Rate.Reputation.RecruitAFriendBonus");
    AddOption<float>("Rate.Creature.Normal.Damage");
    AddOption<float>("Rate.Creature.Elite.Elite.Damage");
    AddOption<float>("Rate.Creature.Elite.RAREELITE.Damage");
    AddOption<float>("Rate.Creature.Elite.WORLDBOSS.Damage");
    AddOption<float>("Rate.Creature.Elite.RARE.Damage");
    AddOption<float>("Rate.Creature.Normal.HP");
    AddOption<float>("Rate.Creature.Elite.Elite.HP");
    AddOption<float>("Rate.Creature.Elite.RAREELITE.HP");
    AddOption<float>("Rate.Creature.Elite.WORLDBOSS.HP");
    AddOption<float>("Rate.Creature.Elite.RARE.HP");
    AddOption<float>("Rate.Creature.Normal.SpellDamage");
    AddOption<float>("Rate.Creature.Elite.Elite.SpellDamage");
    AddOption<float>("Rate.Creature.Elite.RAREELITE.SpellDamage");
    AddOption<float>("Rate.Creature.Elite.WORLDBOSS.SpellDamage");
    AddOption<float>("Rate.Creature.Elite.RARE.SpellDamage");
    AddOption<float>("Rate.Creature.Aggro");
    AddOption<float>("Rate.Rest.InGame");
    AddOption<float>("Rate.Rest.Offline.InTavernOrCity");
    AddOption<float>("Rate.Rest.Offline.InWilderness");
    AddOption<float>("Rate.Damage.Fall");
    AddOption<float>("Rate.Auction.Time");
    AddOption<float>("Rate.Auction.Deposit");
    AddOption<float>("Rate.Auction.Cut");
    AddOption<float>("Rate.Honor");
    AddOption<float>("Rate.ArenaPoints");
    AddOption<float>("Rate.InstanceResetTime");
    AddOption<float>("Rate.Talent");
    AddOption<float>("Rate.MoveSpeed");
    AddOption<float>("Rate.Corpse.Decay.Looted", 0.5f);
    AddOption<float>("DurabilityLoss.OnDeath", 10.0f);
    AddOption<float>("DurabilityLossChance.Damage", 0.5f);
    AddOption<float>("DurabilityLossChance.Absorb", 0.5f);
    AddOption<float>("DurabilityLossChance.Parry", 0.5f);
    AddOption<float>("DurabilityLossChance.Block", 0.5f);
    AddOption<float>("Rate.Quest.Money.Reward");
    AddOption<float>("Rate.Quest.Money.Max.Level.Reward");
    AddOption<float>("MaxGroupXPDistance", 74.0f);
    AddOption<float>("MaxRecruitAFriendBonusDistance", 100.0f);
    AddOption<float>("MonsterSight", 50.0f);
    AddOption<float>("GM.TicketSystem.ChanceOfGMSurvey", 50.0f);
    AddOption<float>("CreatureFamilyFleeAssistanceRadius", 30.0f);
    AddOption<float>("CreatureFamilyAssistanceRadius", 10.0f);
    AddOption<float>("ThreatRadius", 60.0f);
    AddOption<float>("ListenRange.Say", 25.0f);
    AddOption<float>("ListenRange.TextEmote", 25.0f);
    AddOption<float>("ListenRange.Yell", 300.0f);
    AddOption<float>("Arena.ArenaWinRatingModifier1", 48.0f);
    AddOption<float>("Arena.ArenaWinRatingModifier2", 24.0f);
    AddOption<float>("Arena.ArenaLoseRatingModifier", 24.0f);
    AddOption<float>("Arena.ArenaMatchmakerRatingModifier", 24.0f);
    AddOption<float>("Visibility.Distance.Continents", DEFAULT_VISIBILITY_DISTANCE);
    AddOption<float>("Visibility.Distance.Instances", DEFAULT_VISIBILITY_INSTANCE);
    AddOption<float>("Visibility.Distance.BG", DEFAULT_VISIBILITY_BGARENAS);
    AddOption<float>("Visibility.Distance.Arenas", DEFAULT_VISIBILITY_BGARENAS);
    AddOption<float>("Respawn.DynamicRateCreature");
    AddOption<float>("Respawn.DynamicRateGameObject");
    AddOption<float>("Stats.Limits.Dodge");
    AddOption<float>("Stats.Limits.Parry");
    AddOption<float>("Stats.Limits.Block");
    AddOption<float>("Stats.Limits.Crit");

    LOG_INFO("config", "> Loaded %u float configs", static_cast<uint32>(_floatConfigs.size()));
}
