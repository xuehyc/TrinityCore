/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef __NPCHANDLER_H
#define __NPCHANDLER_H

struct NpcTextData
{
    float Probability;
    uint32 BroadcastTextID;
};

#define MAX_NPC_TEXT_OPTIONS 8

struct NpcText
{
    NpcTextData Data[MAX_NPC_TEXT_OPTIONS];
};

struct PageTextLocale
{
    std::vector<std::string> Text;
};

#endif
