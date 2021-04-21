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
#include "CreatureAI.h"
#include "DBCStructure.h"
#include "GameTime.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "TemporarySummon.h"
#include "PhasingHandler.h"

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
                Creature* drowning = me->FindNearestCreature(36440, 2.0f);
                player->KilledMonsterCredit(36450);
                drowning->DisappearAndDie();
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
                Creature* horse = me->FindNearestCreature(36540, 5.0f);
                player->FindNearestCreature(36540, 5.0f, true);
                player->KilledMonsterCredit(36560);
                horse->DisappearAndDie();
                return true;
            }
            return false;

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

/* Quest Fix 24438
https://www.wowhead.com/quest=24438/exodus
https://www.wowhead.com/npc=44928/stagecoach-carriage
Added missing Stagecoach
Original SQL to Restore:
DELETE FROM `creature_template` WHERE  `entry`=198888;
DELETE FROM `creature` WHERE  `guid`=396668;
UPDATE `creature` SET `PhaseId`='186' WHERE  `guid`=256018;
UPDATE `world`.`creature` SET `PhaseId`='186' WHERE  `guid`=256108;
*/
class stagecoach : public CreatureScript
{
public:

    stagecoach() : CreatureScript("stagecoach") {}

    struct stagecoachAI : public ScriptedAI
    {
        stagecoachAI(Creature* creature) : ScriptedAI(creature) { }

        bool GossipHello(Player* player) override
        {
            if (player->IsInCombat())
            {
                ClearGossipMenuFor(player);
                ChatHandler(player->GetSession()).PSendSysMessage("You are still in combat!");
                return true;
            }
            else
            {
                return OnGossipHello(player, me);
            }
        }

        static bool OnGossipHello(Player* player, Creature* creature)
        {
            AddGossipItemFor(player, GOSSIP_ICON_TALK, "I am ready to go!", GOSSIP_SENDER_MAIN, 11);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
            return true;
        }

        bool GossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            return OnGossipSelect(player, me, sender, action);
        }

        bool OnGossipSelect(Player* player, Creature* _creature, uint32 /*sender*/, uint32 uiAction)
        {
            ClearGossipMenuFor(player);

            switch (uiAction)
            {

            case 11:

                if (player)
                {
                    if (player->GetTeam() == ALLIANCE && player->GetQuestStatus(24438) == QUEST_STATUS_COMPLETE)//EXODUS
                    {
                        AddGossipItemFor(player, GOSSIP_ICON_TALK, "I am ready to go!", GOSSIP_SENDER_MAIN, 1);//Check
                    }
                    AddGossipItemFor(player, GOSSIP_ICON_TALK, "I'm not ready yet", GOSSIP_SENDER_MAIN, 1111);
                    SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
                }
                break;

            case 1111://close
                CloseGossipMenuFor(player);
                break;

            case 1://Menu
                player->TeleportTo(654, -2216.50f, 1809.03f, 11.77f, 2.9544f);
                if (!player->GetPhaseShift().HasPhase(186))
                PhasingHandler::AddPhase(player, 186, true);
                break;
               
            default:

                break;
            }
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new stagecoachAI(creature);
    }
};

/*
Battle for Gilneas Kill Credit Workaround.
https://www.wowhead.com/quest=24904/the-battle-for-gilneas-city
UPDATE `creature` SET `npcflag`='1', `ScriptName`='krennan' WHERE  `guid`=256580;
*/
class krennan : public CreatureScript
{
public:

    krennan() : CreatureScript("krennan") {}

    struct krennanAI : public ScriptedAI
    {
        krennanAI(Creature* creature) : ScriptedAI(creature) { }

        bool GossipHello(Player* player) override
        {
            if (player->IsInCombat())
            {
                ClearGossipMenuFor(player);
                ChatHandler(player->GetSession()).PSendSysMessage("You are still in combat!");
                return true;
            }
            else
            {
                return OnGossipHello(player, me);
            }
        }

        static bool OnGossipHello(Player* player, Creature* creature)
        {
            AddGossipItemFor(player, GOSSIP_ICON_TALK, "Hey There!", GOSSIP_SENDER_MAIN, 11);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
            return true;
        }

        bool GossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            return OnGossipSelect(player, me, sender, action);
        }

        bool OnGossipSelect(Player* player, Creature* _creature, uint32 /*sender*/, uint32 uiAction)
        {
            ClearGossipMenuFor(player);

            switch (uiAction)
            {

            case 11:

                if (player)
                {
                    if (player->GetTeam() == ALLIANCE && player->GetQuestStatus(24904) == QUEST_STATUS_INCOMPLETE)//EXODUS
                    {
                        AddGossipItemFor(player, GOSSIP_ICON_TALK, "I am ready to go!", GOSSIP_SENDER_MAIN, 1);//Check
                    }
                    AddGossipItemFor(player, GOSSIP_ICON_TALK, "I'm not ready yet", GOSSIP_SENDER_MAIN, 1111);
                    SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
                }
                break;

            case 1111://close
                CloseGossipMenuFor(player);
                break;

            case 1://Menu
                player->KilledMonsterCredit(38854);
                break;

            default:

                break;
            }
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new krennanAI(creature);
    }
};

/*Quest 10069 The Ways of the Light
https://www.wowhead.com/quest=10069/ways-of-the-light
Auto Complete script
Setting it to auto complete in the sql isnt working.
Setting it to disable isnt working in the sql database.
Quest Template for this isnt not in the hotfixes or dbc files.
How the quest is according to wowhead\official guide\ youtube is not the same as how it is presented in the game.
We can not have two learn spell requirements in this quest tempalte of cpp with how cpp has it being presented
which isnt how the quest suppose to be.
Quest complete command does not complete the quest because of the above.
This is the only solution I can provide until further comes from the CPP themselves.
~MDic
*/
class BEPTF : public PlayerScript
{
public:
    BEPTF() : PlayerScript("BEPTF") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (Player->getClass() == CLASS_PALADIN && Player->GetAreaId() == 3431)
        {
            if (Player->GetQuestStatus(10069) == QUEST_STATUS_NONE)//The Light of Dawn
            {
                Player->AddQuest(sObjectMgr->GetQuestTemplate(10069), nullptr);
                Player->RewardQuest(sObjectMgr->GetQuestTemplate(10069), false, Player);
            }
            if (Player->GetQuestStatus(10069) == QUEST_STATUS_INCOMPLETE)//The Light of Dawn
            {
                Player->RewardQuest(sObjectMgr->GetQuestTemplate(10069), false, Player);
            }
        }
    }
};

void AddSC_Band_aid()
{
    new drowningwatchmen();
    new lornacrowley36457();
    new stagecoach();
    new krennan();
    new BEPTF();
}
