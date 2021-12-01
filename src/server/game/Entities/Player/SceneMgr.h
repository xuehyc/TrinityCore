/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SceneMgr_h__
#define SceneMgr_h__

#include "Common.h"
#include <map>

enum SceneFlags
{
    SCENEFLAG_UNK1           = 0x01,
    SCENEFLAG_CANCEL_AT_END  = 0x02,
    SCENEFLAG_NOT_CANCELABLE = 0x04,
    SCENEFLAG_UNK8           = 0x08,
    SCENEFLAG_UNK16          = 0x10, // 16, most common value
    SCENEFLAG_UNK32          = 0x20,
};

class Player;
struct Position;
struct SceneTemplate;

typedef std::map<uint32, SceneTemplate const*> SceneTemplateByInstance;

class GAME_API SceneMgr
{
public:
    SceneMgr(Player* player);

    Player* GetPlayer() const { return _player; }

    uint32 PlayScene(uint32 sceneId, Position const* position = nullptr);
    uint32 PlaySceneByTemplate(SceneTemplate const* sceneTemplate, Position const* position = nullptr);
    uint32 PlaySceneByPackageId(uint32 sceneScriptPackageId, uint32 playbackflags = SCENEFLAG_UNK16, Position const* position = nullptr);
    void CancelScene(uint32 sceneInstanceID, bool removeFromMap = true);

    void OnSceneTrigger(uint32 sceneInstanceID, std::string const& triggerName);
    void OnSceneCancel(uint32 sceneInstanceID);
    void OnSceneComplete(uint32 sceneInstanceID);

    void RecreateScene(uint32 sceneScriptPackageId, uint32 playbackflags = SCENEFLAG_UNK16, Position const* position = nullptr)
    {
        CancelSceneByPackageId(sceneScriptPackageId);
        PlaySceneByPackageId(sceneScriptPackageId, playbackflags, position);
    }

    bool HasScene(uint32 sceneInstanceID, uint32 sceneScriptPackageId = 0) const;

    void AddInstanceIdToSceneMap(uint32 sceneInstanceID, SceneTemplate const* sceneTemplate);
    void CancelSceneBySceneId(uint32 sceneId);
    void CancelSceneByPackageId(uint32 sceneScriptPackageId);
    void RemoveSceneInstanceId(uint32 sceneInstanceID);
    void RemoveAurasDueToSceneId(uint32 sceneId);

    SceneTemplate const* GetSceneTemplateFromInstanceId(uint32 sceneInstanceID);
    uint32 GetActiveSceneCount(uint32 sceneScriptPackageId = 0);
    SceneTemplateByInstance const& GetSceneTemplateByInstanceMap() const { return _scenesByInstance; }

    uint32 GetNewStandaloneSceneInstanceID() { return ++_standaloneSceneInstanceID; }

    void ToggleDebugSceneMode() { _isDebuggingScenes = !_isDebuggingScenes; }
    bool IsInDebugSceneMode() const { return _isDebuggingScenes; }

private:
    Player* _player;
    SceneTemplateByInstance _scenesByInstance;
    uint32 _standaloneSceneInstanceID;
    bool _isDebuggingScenes;
};

#endif // SceneMgr_h__
