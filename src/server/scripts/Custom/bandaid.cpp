/*
This is the bandaid script
Designed to just assist with progress for whatever scenario\quest line that is need.
This script is a hit subject to change. If sql is include please make notes of it.
SPP DEV MDic
*/

#include "Chat.h"
#include "Config.h"
#include "Creature.h"
#include "GameEventMgr.h"
#include "Item.h"
#include "ItemEnchantmentMgr.h"
#include "Player.h"
#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "WorldSession.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "Group.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "SpellInfo.h"
#include "SpellScript.h"

// npc id 36440 quest https://www.wowhead.com/quest=14395 Gasping for air
// Worgen Quest Starter zone
// this is not blizzlike at all, but click on the drowninged watchmen give your the credit
// so you can progress. This is strictly a bandaid to allow progression
//sql for world:
//UPDATE `creature_template` SET `npcflag`='1', `ScriptName`='drowningwatchmen' WHERE  `entry`=36440;
class drowningwatchmen : public CreatureScript
{
public:

    drowningwatchmen() : CreatureScript("drowningwatchmen") {}

    struct drowningwatchmenAI : public ScriptedAI
    {
        drowningwatchmenAI(Creature* creature) : ScriptedAI(creature) { }

        bool GossipHello(Player* player) override
        {
            if (player->GetQuestStatus(14395) == QUEST_STATUS_INCOMPLETE)
            {
                player->KilledMonsterCredit(36450);
                return true;
            }
            return false;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new drowningwatchmenAI(creature);
    }
};

//https://www.wowhead.com/quest=14416/the-hungry-ettin
//mountain horse turn in trigger near npc lorna crowley
// npc id 36457 Lorna Crowley
// horse id 36540
// horse credit 36560
// sql for world:
//UPDATE `creature_template` SET `ScriptName`='lornacrowley36457' WHERE  `entry`=36457;
class lornacrowley36457 : public CreatureScript
{
public:
    lornacrowley36457() : CreatureScript("lornacrowley36457") { }

    struct lornacrowley36457AI : public ScriptedAI
    {
        lornacrowley36457AI(Creature* creature) : ScriptedAI(creature) { }

        bool GossipHello(Player* player) override
        {
            if (player->GetQuestStatus(14416) == QUEST_STATUS_INCOMPLETE)
            {
                player->FindNearestCreature(36540, 5.0f, true);
                {
                    player->KilledMonsterCredit(36560);
                    return true;
                }
                return false;
            }

            if (me->IsQuestGiver())
                player->PrepareQuestMenu(me->GetGUID());

            player->TalkedToCreature(me->GetEntry(), me->GetGUID());
            SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new lornacrowley36457AI(creature);
    }
};

void AddSC_Band_aid()
{
    new drowningwatchmen();
    new lornacrowley36457();
}
