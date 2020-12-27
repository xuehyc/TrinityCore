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

/// \addtogroup world The World
/// @{
/// \file

#ifndef __WORLD_H
#define __WORLD_H

#include "Common.h"
#include "AsyncCallbackProcessor.h"
#include "DatabaseEnvFwd.h"
#include "LockedQueue.h"
#include "ObjectGuid.h"
#include "SharedDefines.h"
#include "Timer.h"
#include <atomic>
#include <list>
#include <map>
#include <unordered_map>

class Player;
class WorldPacket;
class WorldSession;
class WorldSocket;
struct Realm;

// ServerMessages.dbc
enum ServerMessageType
{
    SERVER_MSG_SHUTDOWN_TIME      = 1,
    SERVER_MSG_RESTART_TIME       = 2,
    SERVER_MSG_STRING             = 3,
    SERVER_MSG_SHUTDOWN_CANCELLED = 4,
    SERVER_MSG_RESTART_CANCELLED  = 5
};

enum ShutdownMask : uint32
{
    SHUTDOWN_MASK_RESTART = 1,
    SHUTDOWN_MASK_IDLE    = 2,
    SHUTDOWN_MASK_FORCE   = 4
};

enum ShutdownExitCode : uint32
{
    SHUTDOWN_EXIT_CODE = 0,
    ERROR_EXIT_CODE    = 1,
    RESTART_EXIT_CODE  = 2
};

/// Timers for different object refresh rates
enum WorldTimers
{
    WUPDATE_AUCTIONS,
    WUPDATE_AUCTIONS_PENDING,
    WUPDATE_UPTIME,
    WUPDATE_CORPSES,
    WUPDATE_EVENTS,
    WUPDATE_CLEANDB,
    WUPDATE_AUTOBROADCAST,
    WUPDATE_DELETECHARS,
    WUPDATE_AHBOT,
    WUPDATE_PINGDB,
    WUPDATE_CHECK_FILECHANGES,
    WUPDATE_WHO_LIST,
    WUPDATE_CHANNEL_SAVE,
    WUPDATE_COUNT
};

/// Can be used in SMSG_AUTH_RESPONSE packet
enum BillingPlanFlags
{
    SESSION_NONE            = 0x00,
    SESSION_UNUSED          = 0x01,
    SESSION_RECURRING_BILL  = 0x02,
    SESSION_FREE_TRIAL      = 0x04,
    SESSION_IGR             = 0x08,
    SESSION_USAGE           = 0x10,
    SESSION_TIME_MIXTURE    = 0x20,
    SESSION_RESTRICTED      = 0x40,
    SESSION_ENABLE_CAIS     = 0x80
};

enum RealmZone
{
    REALM_ZONE_UNKNOWN       = 0,                           // any language
    REALM_ZONE_DEVELOPMENT   = 1,                           // any language
    REALM_ZONE_UNITED_STATES = 2,                           // extended-Latin
    REALM_ZONE_OCEANIC       = 3,                           // extended-Latin
    REALM_ZONE_LATIN_AMERICA = 4,                           // extended-Latin
    REALM_ZONE_TOURNAMENT_5  = 5,                           // basic-Latin at create, any at login
    REALM_ZONE_KOREA         = 6,                           // East-Asian
    REALM_ZONE_TOURNAMENT_7  = 7,                           // basic-Latin at create, any at login
    REALM_ZONE_ENGLISH       = 8,                           // extended-Latin
    REALM_ZONE_GERMAN        = 9,                           // extended-Latin
    REALM_ZONE_FRENCH        = 10,                          // extended-Latin
    REALM_ZONE_SPANISH       = 11,                          // extended-Latin
    REALM_ZONE_RUSSIAN       = 12,                          // Cyrillic
    REALM_ZONE_TOURNAMENT_13 = 13,                          // basic-Latin at create, any at login
    REALM_ZONE_TAIWAN        = 14,                          // East-Asian
    REALM_ZONE_TOURNAMENT_15 = 15,                          // basic-Latin at create, any at login
    REALM_ZONE_CHINA         = 16,                          // East-Asian
    REALM_ZONE_CN1           = 17,                          // basic-Latin at create, any at login
    REALM_ZONE_CN2           = 18,                          // basic-Latin at create, any at login
    REALM_ZONE_CN3           = 19,                          // basic-Latin at create, any at login
    REALM_ZONE_CN4           = 20,                          // basic-Latin at create, any at login
    REALM_ZONE_CN5           = 21,                          // basic-Latin at create, any at login
    REALM_ZONE_CN6           = 22,                          // basic-Latin at create, any at login
    REALM_ZONE_CN7           = 23,                          // basic-Latin at create, any at login
    REALM_ZONE_CN8           = 24,                          // basic-Latin at create, any at login
    REALM_ZONE_TOURNAMENT_25 = 25,                          // basic-Latin at create, any at login
    REALM_ZONE_TEST_SERVER   = 26,                          // any language
    REALM_ZONE_TOURNAMENT_27 = 27,                          // basic-Latin at create, any at login
    REALM_ZONE_QA_SERVER     = 28,                          // any language
    REALM_ZONE_CN9           = 29,                          // basic-Latin at create, any at login
    REALM_ZONE_TEST_SERVER_2 = 30,                          // any language
    REALM_ZONE_CN10          = 31,                          // basic-Latin at create, any at login
    REALM_ZONE_CTC           = 32,
    REALM_ZONE_CNC           = 33,
    REALM_ZONE_CN1_4         = 34,                          // basic-Latin at create, any at login
    REALM_ZONE_CN2_6_9       = 35,                          // basic-Latin at create, any at login
    REALM_ZONE_CN3_7         = 36,                          // basic-Latin at create, any at login
    REALM_ZONE_CN5_8         = 37                           // basic-Latin at create, any at login
};

/// Storage class for commands issued for delayed execution
struct WH_GAME_API CliCommandHolder
{
    using Print = void(*)(void*, std::string_view);
    using CommandFinished = void(*)(void*, bool success);

    void* m_callbackArg;
    char* m_command;
    Print m_print;
    CommandFinished m_commandFinished;

    CliCommandHolder(void* callbackArg, char const* command, Print zprint, CommandFinished commandFinished);
    ~CliCommandHolder();

private:
    CliCommandHolder(CliCommandHolder const& right) = delete;
    CliCommandHolder& operator=(CliCommandHolder const& right) = delete;
};

typedef std::unordered_map<uint32, WorldSession*> SessionMap;

struct CharacterInfo
{
    std::string Name;
    uint32 AccountId;
    uint8 Class;
    uint8 Race;
    uint8 Sex;
    uint8 Level;
    ObjectGuid::LowType GuildId;
    uint32 ArenaTeamId[3];
};

/// The World
class WH_GAME_API World
{
    public:
        static World* instance();

        static std::atomic<uint32> m_worldLoopCounter;

        WorldSession* FindSession(uint32 id) const;
        void AddSession(WorldSession* s);
        void SendAutoBroadcast();
        bool RemoveSession(uint32 id);
        /// Get the number of current active sessions
        void UpdateMaxSessionCounters();
        SessionMap const& GetAllSessions() const { return m_sessions; }
        uint32 GetActiveAndQueuedSessionCount() const { return m_sessions.size(); }
        uint32 GetActiveSessionCount() const { return m_sessions.size() - m_QueuedPlayer.size(); }
        uint32 GetQueuedSessionCount() const { return m_QueuedPlayer.size(); }
        /// Get the maximum number of parallel sessions on the server since last reboot
        uint32 GetMaxQueuedSessionCount() const { return m_maxQueuedSessionCount; }
        uint32 GetMaxActiveSessionCount() const { return m_maxActiveSessionCount; }
        /// Get number of players
        inline uint32 GetPlayerCount() const { return m_PlayerCount; }
        inline uint32 GetMaxPlayerCount() const { return m_MaxPlayerCount; }
        /// Increase/Decrease number of players
        inline void IncreasePlayerCount()
        {
            m_PlayerCount++;
            m_MaxPlayerCount = std::max(m_MaxPlayerCount, m_PlayerCount);
        }
        inline void DecreasePlayerCount() { m_PlayerCount--; }

        Player* FindPlayerInZone(uint32 zone);

        /// Deny clients?
        bool IsClosed() const;

        /// Close world
        void SetClosed(bool val);

        /// Security level limitations
        AccountTypes GetPlayerSecurityLimit() const { return m_allowedSecurityLevel; }
        void SetPlayerSecurityLimit(AccountTypes sec);
        void LoadDBAllowedSecurityLevel();

        /// Active session server limit
        void SetPlayerAmountLimit(uint32 limit) { m_playerLimit = limit; }
        uint32 GetPlayerAmountLimit() const { return m_playerLimit; }

        //player Queue
        typedef std::list<WorldSession*> Queue;
        void AddQueuedPlayer(WorldSession*);
        bool RemoveQueuedPlayer(WorldSession* session);
        int32 GetQueuePos(WorldSession*);
        bool HasRecentlyDisconnected(WorldSession*);

        /// @todo Actions on m_allowMovement still to be implemented
        /// Is movement allowed?
        bool getAllowMovement() const { return m_allowMovement; }
        /// Allow/Disallow object movements
        void SetAllowMovement(bool allow) { m_allowMovement = allow; }

        /// Set the string for new characters (first login)
        void SetNewCharString(std::string const& str) { m_newCharString = str; }
        /// Get the string for new characters (first login)
        std::string const& GetNewCharString() const { return m_newCharString; }

        LocaleConstant GetDefaultDbcLocale() const { return m_defaultDbcLocale; }

        /// Get the path where data (dbc, maps) are stored on disk
        std::string const& GetDataPath() const { return m_dataPath; }

        /// Next daily quests and random bg reset time
        time_t GetNextDailyQuestsResetTime() const { return m_NextDailyQuestReset; }
        time_t GetNextWeeklyQuestsResetTime() const { return m_NextWeeklyQuestReset; }
        time_t GetNextRandomBGResetTime() const { return m_NextRandomBGReset; }

        /// Get the maximum skill level a player can reach
        uint16 GetConfigMaxSkillValue() const;

        void SetInitialWorldSettings();
        void LoadConfigSettings(bool reload = false);

        void SendWorldText(uint32 string_id, ...);
        void SendGlobalText(char const* text, WorldSession* self);
        void SendGMText(uint32 string_id, ...);
        void SendServerMessage(ServerMessageType messageID, std::string stringParam = "", Player* player = nullptr);
        void SendGlobalMessage(WorldPacket const* packet, WorldSession* self = nullptr, uint32 team = 0);
        void SendGlobalGMMessage(WorldPacket const* packet, WorldSession* self = nullptr, uint32 team = 0);
        bool SendZoneMessage(uint32 zone, WorldPacket const* packet, WorldSession* self = nullptr, uint32 team = 0);
        void SendZoneText(uint32 zone, const char *text, WorldSession* self = nullptr, uint32 team = 0);

        /// Are we in the middle of a shutdown?
        bool IsShuttingDown() const { return m_ShutdownTimer > 0; }
        uint32 GetShutDownTimeLeft() const { return m_ShutdownTimer; }
        void ShutdownServ(uint32 time, uint32 options, uint8 exitcode, const std::string& reason = std::string());
        uint32 ShutdownCancel();
        void ShutdownMsg(bool show = false, Player* player = nullptr, const std::string& reason = std::string());
        static uint8 GetExitCode() { return m_ExitCode; }
        static void StopNow(uint8 exitcode) { m_stopEvent = true; m_ExitCode = exitcode; }
        static bool IsStopped() { return m_stopEvent; }

        void Update(uint32 diff);
        void UpdateSessions(uint32 diff);

        void setWorldState(uint32 index, uint64 value);
        uint64 getWorldState(uint32 index) const;
        void LoadWorldStates();

        /// Are we on a "Player versus Player" server?
        bool IsPvPRealm() const;
        bool IsFFAPvPRealm() const;

        void KickAll();
        void KickAllLess(AccountTypes sec);

        // for max speed access
        static float GetMaxVisibleDistanceOnContinents()    { return m_MaxVisibleDistanceOnContinents; }
        static float GetMaxVisibleDistanceInInstances()     { return m_MaxVisibleDistanceInInstances;  }
        static float GetMaxVisibleDistanceInBG()            { return m_MaxVisibleDistanceInBG;         }
        static float GetMaxVisibleDistanceInArenas()        { return m_MaxVisibleDistanceInArenas;     }

        static int32 GetVisibilityNotifyPeriodOnContinents(){ return m_visibility_notify_periodOnContinents; }
        static int32 GetVisibilityNotifyPeriodInInstances() { return m_visibility_notify_periodInInstances;  }
        static int32 GetVisibilityNotifyPeriodInBG()        { return m_visibility_notify_periodInBG;         }
        static int32 GetVisibilityNotifyPeriodInArenas()    { return m_visibility_notify_periodInArenas;     }

        void ProcessCliCommands();
        void QueueCliCommand(CliCommandHolder* commandHolder) { cliCmdQueue.add(commandHolder); }

        void ForceGameEventUpdate();

        void UpdateRealmCharCount(uint32 accid);

        LocaleConstant GetAvailableDbcLocale(LocaleConstant locale) const { if (m_availableDbcLocaleMask & (1 << locale)) return locale; else return m_defaultDbcLocale; }

        // used World DB version
        void LoadDBVersion();
        char const* GetDBVersion() const { return m_DBVersion.c_str(); }

        void LoadAutobroadcasts();

        void UpdateAreaDependentAuras();

        uint32 GetCleaningFlags() const { return m_CleaningFlags; }
        void SetCleaningFlags(uint32 flags) { m_CleaningFlags = flags; }
        void ResetEventSeasonalQuests(uint16 event_id);

        void ReloadRBAC();

        void RemoveOldCorpses();
        void TriggerGuidWarning();
        void TriggerGuidAlert();
        bool IsGuidWarning() { return _guidWarn; }
        bool IsGuidAlert() { return _guidAlert; }

    protected:
        void _UpdateGameTime();

        // callback for UpdateRealmCharacters
        void _UpdateRealmCharCount(PreparedQueryResult resultCharCount);

        void InitQuestResetTimes();
        void CheckQuestResetTimes();
        void ResetDailyQuests();
        void ResetWeeklyQuests();
        void ResetMonthlyQuests();

        void InitRandomBGResetTime();
        void InitCalendarOldEventsDeletionTime();
        void InitGuildResetTime();
        void ResetRandomBG();
        void CalendarDeleteOldEvents();
        void ResetGuildCap();
    private:
        World();
        ~World();

        static std::atomic<bool> m_stopEvent;
        static uint8 m_ExitCode;
        uint32 m_ShutdownTimer;
        uint32 m_ShutdownMask;

        uint32 m_CleaningFlags;

        bool m_isClosed;

        IntervalTimer m_timers[WUPDATE_COUNT];

        SessionMap m_sessions;
        typedef std::unordered_map<uint32, time_t> DisconnectMap;
        DisconnectMap m_disconnects;
        uint32 m_maxActiveSessionCount;
        uint32 m_maxQueuedSessionCount;
        uint32 m_PlayerCount;
        uint32 m_MaxPlayerCount;

        std::string m_newCharString;

        typedef std::map<uint32, uint64> WorldStatesMap;
        WorldStatesMap m_worldstates;
        uint32 m_playerLimit;
        AccountTypes m_allowedSecurityLevel;
        LocaleConstant m_defaultDbcLocale;                     // from config for one from loaded DBC locales
        uint32 m_availableDbcLocaleMask;                       // by loaded DBC
        void DetectDBCLang();
        bool m_allowMovement;
        std::string m_dataPath;

        // for max speed access
        static float m_MaxVisibleDistanceOnContinents;
        static float m_MaxVisibleDistanceInInstances;
        static float m_MaxVisibleDistanceInBG;
        static float m_MaxVisibleDistanceInArenas;

        static int32 m_visibility_notify_periodOnContinents;
        static int32 m_visibility_notify_periodInInstances;
        static int32 m_visibility_notify_periodInBG;
        static int32 m_visibility_notify_periodInArenas;

        // CLI command holder to be thread safe
        LockedQueue<CliCommandHolder*> cliCmdQueue;

        // next daily quests and random bg reset time
        time_t m_NextDailyQuestReset;
        time_t m_NextWeeklyQuestReset;
        time_t m_NextMonthlyQuestReset;
        time_t m_NextRandomBGReset;
        time_t m_NextCalendarOldEventsDeletionTime;
        time_t m_NextGuildReset;

        //Player Queue
        Queue m_QueuedPlayer;

        // sessions that are added async
        void AddSession_(WorldSession* s);
        LockedQueue<WorldSession*> addSessQueue;

        // used versions
        std::string m_DBVersion;

        typedef std::map<uint8, std::string> AutobroadcastsMap;
        AutobroadcastsMap m_Autobroadcasts;

        typedef std::map<uint8, uint8> AutobroadcastsWeightMap;
        AutobroadcastsWeightMap m_AutobroadcastsWeights;

        void ProcessQueryCallbacks();

        void SendGuidWarning();
        void DoGuidWarningRestart();
        void DoGuidAlertRestart();
        QueryCallbackProcessor _queryProcessor;

        std::string _guidWarningMsg;
        std::string _alertRestartReason;

        std::mutex _guidAlertLock;

        bool _guidWarn;
        bool _guidAlert;
        uint32 _warnDiff;
        time_t _warnShutdownTime;

    friend class debug_commandscript;
};

WH_GAME_API extern Realm realm;

#define sWorld World::instance()

#endif
/// @}
