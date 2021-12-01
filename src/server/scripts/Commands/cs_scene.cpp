/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "Chat.h"
#include "DB2Stores.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "RBAC.h"
#include "WorldSession.h"

class scene_commandscript : public CommandScript
{
public:
    scene_commandscript() : CommandScript("scene_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> sceneCommandTable =
        {
            { "debug",          rbac::RBAC_PERM_COMMAND_SCENE_DEBUG,        false, &HandleDebugSceneCommand,        "" },
            { "play",           rbac::RBAC_PERM_COMMAND_SCENE_PLAY,         false, &HandlePlaySceneCommand,         "" },
            { "playpackage",    rbac::RBAC_PERM_COMMAND_SCENE_PLAY_PACKAGE, false, &HandlePlayScenePackageCommand,  "" },
            { "cancel",         rbac::RBAC_PERM_COMMAND_SCENE_CANCEL,       false, &HandleCancelSceneCommand,       "" }
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "scene",          rbac::RBAC_PERM_COMMAND_SCENE,              true, NULL,                             "", sceneCommandTable }
        };
        return commandTable;
    }

    static bool HandleDebugSceneCommand(ChatHandler* handler, char const* /*args*/)
    {
        if (Player* player = handler->GetSession()->GetPlayer())
        {
            player->GetSceneMgr().ToggleDebugSceneMode();
            handler->PSendSysMessage(player->GetSceneMgr().IsInDebugSceneMode() ? LANG_COMMAND_SCENE_DEBUG_ON : LANG_COMMAND_SCENE_DEBUG_OFF);
        }

        return true;
    }

    static bool HandlePlaySceneCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char const* sceneIdStr = strtok((char*)args, " ");

        if (!sceneIdStr)
            return false;

        uint32 sceneId = atoi(sceneIdStr);
        Player* target = handler->getSelectedPlayerOrSelf();

        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!sObjectMgr->GetSceneTemplate(sceneId))
            return false;

        target->GetSceneMgr().PlayScene(sceneId);
        return true;
    }

    static bool HandlePlayScenePackageCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char const* scenePackageIdStr = strtok((char*)args, " ");
        char const* flagsStr = strtok(NULL, "");

        if (!scenePackageIdStr)
            return false;

        uint32 scenePackageId = atoi(scenePackageIdStr);
        uint32 flags = flagsStr ? atoi(flagsStr) : SCENEFLAG_UNK16;
        Player* target = handler->getSelectedPlayerOrSelf();

        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!sSceneScriptPackageStore.HasRecord(scenePackageId))
            return false;

        target->GetSceneMgr().PlaySceneByPackageId(scenePackageId, flags);
        return true;
    }

    static bool HandleCancelSceneCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* target = handler->getSelectedPlayerOrSelf();

        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 id = atoi((char*)args);

        if (!sSceneScriptPackageStore.HasRecord(id))
            return false;

        target->GetSceneMgr().CancelSceneByPackageId(id);
        return true;
    }
};

void AddSC_scene_commandscript()
{
    new scene_commandscript();
}
