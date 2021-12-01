/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef AZJOL_NERUB_H_
#define AZJOL_NERUB_H_

#include "CreatureAIImpl.h"

#define AzjolNerubScriptName "instance_azjol_nerub"
#define DataHeader           "AN"

uint32 const EncounterCount = 3;

enum ANDataTypes
{
    // Encounter States/Boss GUIDs
    DATA_KRIKTHIR_THE_GATEWATCHER   = 0,
    DATA_HADRONOX                   = 1,
    DATA_ANUBARAK                   = 2,

    // Additional Data
    DATA_WATCHER_NARJIL,
    DATA_WATCHER_GASHRA,
    DATA_WATCHER_SILTHIK,
    DATA_ANUBARAK_WALL,
    DATA_ANUBARAK_WALL_2
};

enum ANCreatureIds
{
    NPC_KRIKTHIR                    = 28684,
    NPC_HADRONOX                    = 28921,
    NPC_ANUBARAK                    = 29120,

    NPC_WATCHER_NARJIL              = 28729,
    NPC_WATCHER_GASHRA              = 28730,
    NPC_WATCHER_SILTHIK             = 28731
};

enum ANGameObjectIds
{
    GO_KRIKTHIR_DOOR                = 192395,
    GO_ANUBARAK_DOOR_1              = 192396,
    GO_ANUBARAK_DOOR_2              = 192397,
    GO_ANUBARAK_DOOR_3              = 192398
};

// These are passed as -action to AI's DoAction to differentiate between them and boss scripts' own actions
enum ANInstanceActions
{
    ACTION_GATEWATCHER_GREET        = 1
};

template<typename AI>
inline AI* GetAzjolNerubAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, AzjolNerubScriptName);
}

#endif // AZJOL_NERUB_H_
