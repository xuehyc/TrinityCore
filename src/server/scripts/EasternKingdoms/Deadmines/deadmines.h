/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef DEF_DEADMINES_H
#define DEF_DEADMINES_H

#define DataHeader "DM"
#define DMScriptName "instance_deadmines"

uint32 const EncounterCount = 6;

enum DMDataTypes
{
    // Encounters
    DATA_GLUBTOK            = 0,
    DATA_HELUX_GEARBREAKER  = 1,
    DATA_FOE_REAPER_5000    = 2,
    DATA_ADMIRAL_RIPSNARL   = 3,
    DATA_CAPTAIN_COOKIE     = 4,
    DATA_VANESSA_VAN_CLEEF  = 5,

    DATA_TEAM_IN_INSTANCE   = 6,
    DATA_FIREWALL_PLATTER   = 7,
};

enum DMCreatures
{
    // Bosses
    BOSS_GLUBTOK                    = 47162,

    // Horde Creatures
    NPC_SLINKY_SHARPSHIV            = 46906,
    NPC_KAGTHA                      = 46889,
    NPC_MISS_MAYHEM                 = 46902,
    NPC_SHATTERED_HAND_ASSASSIN     = 46890,
    NPC_MAYHEM_REAPER_PROTOTYPE     = 46903,

    // Alliance Creatures
    NPC_STORMWIND_INVESTIGATOR      = 46614,
    NPC_CRIME_SCENE_ALARM_O_BOT     = 46613,
    NPC_STORMWIND_DEFENDER          = 50595,
    NPC_LIEUTENANT_HORATIO_LAINE    = 46612,
    NPC_QUARTERMASTER_LEWIS         = 491,

    // Encounter Related
    NPC_GENERAL_PURPOSE_DUMMY_JMF   = 45979,
    NPC_GLUBTOK_FIREWALL_PLATTER    = 48974,
    NPC_FIREWALL_PLATTER_1A         = 48975,
    NPC_FIREWALL_PLATTER_1B         = 49039,
    NPC_FIREWALL_PLATTER_1C         = 49040,
    NPC_FIREWALL_PLATTER_2A         = 48976,
    NPC_FIREWALL_PLATTER_2B         = 49041,
    NPC_FIREWALL_PLATTER_2C         = 49042,
    NPC_GENERAL_PURPOSE_BUNNY_L2    = 47242,
    NPC_FIRE_BLOSSOM_BUNNY          = 47282,
    NPC_FROST_BLOSSOM_BUNNY         = 47284,
};

enum DMGameObjects
{
    GO_FACTORY_DOOR     = 13965,
    GO_IRONCLAD_DOOR    = 16397,
    GO_DEFIAS_CANNON    = 16398,
    GO_DOOR_LEVER       = 101833,
    GO_MR_SMITE_CHEST   = 144111
};


template<class AI>
AI* GetDeadminesAI(Creature* creature)
{
    return GetInstanceAI<AI>(creature, DMScriptName);
}

#endif
