/*
Racial Traits Swap NPC
SPP DEV MDIC
SQL Assistance by Nemesis Dev Jinnai
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

#define LOCALE_EXIT_0 "[EXIT]"
#define LOCALE_BACK_0 "[BACK]"
#define LOCALE_GOLD_0 " Gold."
#define LOCALE_BES_0 "Blood Elf Racial Trait Swap -"
#define LOCALE_DRS_0 "Draenei Racial Trait Swap  -"
#define LOCALE_DWS_0 "Dwarven Racial Trait Swap -"
#define LOCALE_GNS_0 "Gnome Racial Trait Swap -"
#define LOCALE_HUS_0 "Human Racial Trait Swap -"
#define LOCALE_NES_0 "Night Elf Racial Trait Swap -"
#define LOCALE_ORC_0 "Orc Racial Trait Swap -"
#define LOCALE_TUR_0 "Tauren Racial Trait Swap -"
#define LOCALE_TRL_0 "Troll Racial Trait Swap -"
#define LOCALE_UND_0 "Undead Racial Trait Swap -"
#define LOCALE_WOR_0 "Worgen Racial Trait Swap -"
#define LOCALE_GOB_0 "Goblin Racial Trait Swap -"

class SPPCATA_Race_Trait_announce : public PlayerScript
{
public:
    SPPCATA_Race_Trait_announce() : PlayerScript("SPPCATA_Race_Trait_announce") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault("SPPCATA.Racial.Trait.Swap.Announce.enable", true))
        {
            ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cFF90EE90SPP Cata Racial Trait Swap NPC |rmodule.");
        }
    }
};

class npc_race_trait_swap : public CreatureScript
{
public:

    npc_race_trait_swap() : CreatureScript("npc_race_trait_swap") { }

    struct npc_race_trait_swapAI : public ScriptedAI
    {
        npc_race_trait_swapAI(Creature* creature) : ScriptedAI(creature) { }

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
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Racial Trait Swap", GOSSIP_SENDER_MAIN, 11);
            SendGossipMenuFor(player, 98888, creature->GetGUID());
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
            const int32 RTS1 = sConfigMgr->GetIntDefault("Racial.Traits.Swap.Gold", 100);
            char const* localizedExit;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedExit = LOCALE_EXIT_0;
            }
            char const* localizedBack;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedBack = LOCALE_BACK_0;
            }
            char const* localizedGold;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedGold = LOCALE_GOLD_0;
            }
            char const* localizedBES;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedBES = LOCALE_BES_0;
            }
            char const* localizedDRS;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedDRS = LOCALE_DRS_0;
            }
            char const* localizedDWS;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedDWS = LOCALE_DWS_0;
            }
            char const* localizedGNS;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedGNS = LOCALE_GNS_0;
            }
            char const* localizedHUS;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedHUS = LOCALE_HUS_0;
            }
            char const* localizedNES;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedNES = LOCALE_NES_0;
            }
            char const* localizedORC;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedORC = LOCALE_ORC_0;
            }
            char const* localizedTUR;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedTUR = LOCALE_TUR_0;
            }
            char const* localizedTRL;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedTRL = LOCALE_TRL_0;
            }
            char const* localizedUND;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedUND = LOCALE_UND_0;
            }
            char const* localizedWOR;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedWOR = LOCALE_WOR_0;
            }
            char const* localizedGOB;
            switch (player->GetSession()->GetSessionDbcLocale())
            {
            case LOCALE_enUS: default: localizedGOB = LOCALE_GOB_0;
            }

            std::ostringstream messageBE;
            messageBE << localizedBES << RTS1 << localizedGold;
            std::ostringstream messageDR;
            messageDR << localizedDRS << RTS1 << localizedGold;
            std::ostringstream messageDW;
            messageDW << localizedDWS << RTS1 << localizedGold;
            std::ostringstream messageGN;
            messageGN << localizedGNS << RTS1 << localizedGold;
            std::ostringstream messageHU;
            messageHU << localizedHUS << RTS1 << localizedGold;
            std::ostringstream messageNE;
            messageNE << localizedNES << RTS1 << localizedGold;
            std::ostringstream messageOR;
            messageOR << localizedORC << RTS1 << localizedGold;
            std::ostringstream messageTA;
            messageTA << localizedTUR << RTS1 << localizedGold;
            std::ostringstream messageTR;
            messageTR << localizedTRL << RTS1 << localizedGold;
            std::ostringstream messageUN;
            messageUN << localizedUND << RTS1 << localizedGold;
            std::ostringstream messageWO;
            messageWO << localizedWOR << RTS1 << localizedGold;
            std::ostringstream messageGB;
            messageGB << localizedGOB << RTS1 << localizedGold;
            ClearGossipMenuFor(player);

            switch (uiAction)
            {

            case 11:

                if (player)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageBE.str(), GOSSIP_SENDER_MAIN, 1);//Blood Elf Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageDR.str(), GOSSIP_SENDER_MAIN, 2);//Draenei Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageDW.str(), GOSSIP_SENDER_MAIN, 3);//Dwarves Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageGN.str(), GOSSIP_SENDER_MAIN, 4);//Gnome Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageHU.str(), GOSSIP_SENDER_MAIN, 5);//Human Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageNE.str(), GOSSIP_SENDER_MAIN, 6);//Night Elf Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageOR.str(), GOSSIP_SENDER_MAIN, 7);//Orc Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageTA.str(), GOSSIP_SENDER_MAIN, 8);//Tauren Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageTR.str(), GOSSIP_SENDER_MAIN, 9);//Troll Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageUN.str(), GOSSIP_SENDER_MAIN, 10);//Undead Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageWO.str(), GOSSIP_SENDER_MAIN, 1112);//Worgen Selection
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, messageGB.str(), GOSSIP_SENDER_MAIN, 1122);//Goblin Selection
                    AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                    SendGossipMenuFor(player, 98888, _creature->GetGUID());
                }
                break;

            case 1111://close
                CloseGossipMenuFor(player);
                break;

            case 1://Blood Elf Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Pride of the Blood Elves", GOSSIP_SENDER_MAIN, 112);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988881, _creature->GetGUID());
                break;

            case 112://Blood Elf
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(28877, false);//Arcane Affinity
                player->LearnSpell(822, false);// Magic Resistance
                if (player->getClass() == CLASS_DEATH_KNIGHT)
                {
                    player->LearnSpell(50613, false);//Arcane Torrent
                }
                if (player->getClass() == CLASS_HUNTER || player->getClass() == CLASS_MAGE || player->getClass() == CLASS_PALADIN || player->getClass() == CLASS_WARLOCK)
                {
                    player->LearnSpell(28730, false);//Arcane Torrent
                }
                if (player->getClass() == CLASS_ROGUE)
                {
                    player->LearnSpell(25046, false);//Arcane Torrent
                }
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 2://Draenei Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Light of the Draenei", GOSSIP_SENDER_MAIN, 212);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988882, _creature->GetGUID());
                break;

            case 212://Draenei
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(28875, false);// Gem Cutting
                if (player->getClass() == CLASS_DEATH_KNIGHT)
                {
                    player->LearnSpell(59545, false);//Gift of Naaru
                    player->LearnSpell(59539, false);//Shadow Resistance
                }
                if (player->getClass() == CLASS_DEATH_KNIGHT || player->getClass() == CLASS_HUNTER || player->getClass() == CLASS_PALADIN || player->getClass() == CLASS_WARRIOR)
                {
                    player->LearnSpell(6562, false);//Heroic Presence
                }
                if (player->getClass() == CLASS_HUNTER)
                {
                    player->LearnSpell(59543, false);//Gift of Naaru
                    player->LearnSpell(59536, false);//Shadow Resistance
                }
                if (player->getClass() == CLASS_MAGE)
                {
                    player->LearnSpell(59548, false);//Gift of Naaru
                    player->LearnSpell(59541, false);//Shadow Resistance
                }
                if (player->getClass() == CLASS_MAGE || player->getClass() == CLASS_PRIEST || player->getClass() == CLASS_SHAMAN)
                {
                    player->LearnSpell(28878, false);//Heroic Presence
                }
                if (player->getClass() == CLASS_PALADIN)
                {
                    player->LearnSpell(59542, false);//Gift of Naaru
                    player->LearnSpell(59535, false);//Shadow Resistance
                }
                if (player->getClass() == CLASS_PRIEST)
                {
                    player->LearnSpell(59544, false);//Gift of Naaru
                    player->LearnSpell(59538, false);//Shadow Resistance
                }
                if (player->getClass() == CLASS_SHAMAN)
                {
                    player->LearnSpell(59547, false);//Gift of Naaru
                    player->LearnSpell(59540, false);//Shadow Resistance
                }
                if (player->getClass() == CLASS_SHAMAN)
                {
                    player->LearnSpell(28880, false);//Gift of Naaru
                    player->LearnSpell(59221, false);//Shadow Resistance
                }
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 3://Dwarves Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Iron Will of the Dwarves", GOSSIP_SENDER_MAIN, 31);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988883, _creature->GetGUID());
                break;

            case 31://Dwarves
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(92682, false);//Explorer
                player->LearnSpell(20596, false);//Frost Resistance
                player->LearnSpell(20595, false);//Gun Specialization
                player->LearnSpell(59224, false);//Mace Specialization
                player->LearnSpell(20594, false);//Stoneform
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 4://Gnome Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Technological Might of the Gnomes", GOSSIP_SENDER_MAIN, 41);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988884, _creature->GetGUID());
                break;

            case 41://Gnome
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occur and money is deducted
                player->LearnSpell(20592, false);//Arcane Resistance
                player->LearnSpell(20593, false);//Engineering Specialization
                player->LearnSpell(20589, false);//Escape Artist
                player->LearnSpell(20591, false);//Expansive Mind
                player->LearnSpell(92680, false);//Shortblade Specialization
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 5://Human Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Human Spirit", GOSSIP_SENDER_MAIN, 51);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988885, _creature->GetGUID());
                break;

            case 51://Human
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(20599, false);//Diplomacy
                player->LearnSpell(59752, false);//Every man for himself
                player->LearnSpell(20864, false);//Mace Specialization
                player->LearnSpell(20597, false);//Sword Specialization
                player->LearnSpell(20598, false);//The Human Spirit
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 6://Night Elf Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Ancient Night Elves", GOSSIP_SENDER_MAIN, 61);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988886, _creature->GetGUID());
                break;

            case 61://Night Elf
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(20583, false);//Nature Resistance
                player->LearnSpell(20582, false);//Quickness
                player->LearnSpell(58984, false);//Shadowmeld
                player->LearnSpell(20585, false);//Wisp Spirit
                if (player->getClass() == CLASS_DEATH_KNIGHT || player->getClass() == CLASS_DRUID || player->getClass() == CLASS_HUNTER || player->getClass() == CLASS_MAGE || player->getClass() == CLASS_PRIEST || player->getClass() == CLASS_ROGUE || player->getClass() == CLASS_WARRIOR)
                {
                    player->LearnSpell(21009, false);//Elusiveness
                }
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 7://Orc Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Strength of the Orc", GOSSIP_SENDER_MAIN, 71);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988887, _creature->GetGUID());
                break;

            case 71://Orc
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(20574, false);//Axe Specialization
                player->LearnSpell(20573, false);//Hardiness
                if (player->getClass() == CLASS_DEATH_KNIGHT)
                {
                    player->LearnSpell(54562, false);//Command
                }
                if (player->getClass() == CLASS_DEATH_KNIGHT || player->getClass() == CLASS_HUNTER || player->getClass() == CLASS_ROGUE || player->getClass() == CLASS_WARRIOR)
                {
                    player->LearnSpell(20572, false);//Blood Fury
                }
                if (player->getClass() == CLASS_DRUID || player->getClass() == CLASS_PALADIN || player->getClass() == CLASS_PRIEST || player->getClass() == CLASS_ROGUE || player->getClass() == CLASS_WARRIOR)
                {
                    player->LearnSpell(21563, false);//Command
                }
                if (player->getClass() == CLASS_HUNTER)
                {
                    player->LearnSpell(20576, false);//Command
                }
                if (player->getClass() == CLASS_SHAMAN || player->getClass() == CLASS_MAGE)
                {
                    player->LearnSpell(33697, false);//Blood Fury
                    player->LearnSpell(65222, false);//Command
                }
                if (player->getClass() == CLASS_WARLOCK)
                {
                    player->LearnSpell(33702, false);//Blood Fury
                    player->LearnSpell(20575, false);//Command
                }
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 8://Tauren Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Endurance of the Taurens", GOSSIP_SENDER_MAIN, 81);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988888, _creature->GetGUID());
                break;

            case 81://Tauren
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(20552, false);//Cultivation
                player->LearnSpell(20550, false);//Endurance
                player->LearnSpell(20551, false);//Nature Resistance
                player->LearnSpell(20549, false);//Warstomp
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 9://Troll Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Vodoo of the Trolls", GOSSIP_SENDER_MAIN, 91);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988889, _creature->GetGUID());
                break;

            case 91://Troll
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(20557, false);//Beast Slaying
                player->LearnSpell(26297, false);//Berserking
                player->LearnSpell(26290, false);//Bow Specialization
                player->LearnSpell(58943, false);//Da Voodoo Shuffle
                player->LearnSpell(20555, false);//Regeneration
                player->LearnSpell(20558, false);//Throwing Specialization
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Undead:
                player->RemoveSpell(20577, false, false);// unlearn Cannibalize
                player->RemoveSpell(20579, false, false);// unlearn Shadow Resistance
                player->RemoveSpell(5227, false, false);// unlearn Underwater Breating
                player->RemoveSpell(7744, false, false);// unlearn Will of the Forsaken
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 10://Undead Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Will of the Forsaken", GOSSIP_SENDER_MAIN, 101);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988880, _creature->GetGUID());
                break;

            case 101://Undead
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(20577, false);//Cannibalize
                player->LearnSpell(20579, false);//Shadow Resistance
                player->LearnSpell(5227, false);//Underwater Breating
                player->LearnSpell(7744, false);//Will of the Forsaken
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 1112://worgen Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Determination of the Worgen", GOSSIP_SENDER_MAIN, 11121);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988890, _creature->GetGUID());
                break;

            case 11121://Worgen
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(68976, false);//Aberration
                player->LearnSpell(68978, false);//Flayer
                player->LearnSpell(68975, false);//Viciousness
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //Goblin
                player->RemoveSpell(69070, false, false);//Unlearn Rocket Jump
                player->RemoveSpell(69041, false, false);//Unlearn Rocket Barrage
                player->RemoveSpell(69044, false, false);//Unlearn Best Deal Anywhere
                player->RemoveSpell(69045, false, false);//Unlearn Better Living Through Chemistry
                player->RemoveSpell(69042, false, false);//Unlearn Time is money
                break;

            case 1122://Goblin Selection
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Commit to the Versatility of the Goblin", GOSSIP_SENDER_MAIN, 11221);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedBack, GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_TALK, localizedExit, GOSSIP_SENDER_MAIN, 1111);
                SendGossipMenuFor(player, 988891, _creature->GetGUID());
                break;

            case 11221://Goblin
                CloseGossipMenuFor(player);
                if (!player->HasEnoughMoney(int64(RTS1 * GOLD)))//gold check
                    return true;
                player->ModifyMoney(int64(-RTS1 * GOLD));//Deducting the money if check passes
                player->CastSpell(player, 47292);//Level up visual effect to let you know the transaction did occure and money is deducted
                player->LearnSpell(69070, false);//Rocket Jump
                player->LearnSpell(69041, false);//Rocket Barrage
                player->LearnSpell(69044, false);//Best Deal Anywhere
                player->LearnSpell(69045, false);//Better Living Through Chemistry
                player->LearnSpell(69042, false);//Time is money
                //blood elf:
                player->RemoveSpell(28877, false, false);// unlearn Arcane Affinity
                player->RemoveSpell(822, false, false);// unlearn Magic Resistance
                //~DK
                player->RemoveSpell(50613, false, false);// unlearn Arcane Torrent
                //~Hunter, mage, paladin, priest, warlock
                player->RemoveSpell(28730, false, false);// unlearn Arcane Torrent
                //~Rogue
                player->RemoveSpell(25046, false, false);// unlearn Arcane Torrent
                //Draenei:
                player->RemoveSpell(28875, false, false);// unlearn Gemcutting
                //~DK
                player->RemoveSpell(59545, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59539, false, false);// unlearnShadow Resistance
                //~DK, Hunter, Paladin, Warrior
                player->RemoveSpell(6562, false, false);// unlearn Heroic Presence
                //~Hunter
                player->RemoveSpell(59543, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59536, false, false);// unlearn Shadow Resistance
                //~Mage
                player->RemoveSpell(59548, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59541, false, false);// unlearn Shadow Resistance
                //~Mage, Priest, Shaman
                player->RemoveSpell(28878, false, false);// unlearn Heroic Presence
                //~Paladin
                player->RemoveSpell(59542, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59535, false, false);// unlearn Shadow Resistance
                //~Priest
                player->RemoveSpell(59544, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59538, false, false);// unlearn Shadow Resistance
                //~Shaman
                player->RemoveSpell(59547, false, false);// unlearn Gift of the Narru
                player->RemoveSpell(59540, false, false);// unlearn Shadow Resistance
                //~Warrior
                player->RemoveSpell(28880, false, false);// unlearn Gift of Naaru
                player->RemoveSpell(59221, false, false);// unlearn Shadow Resistance
                //Dwarven:
                player->RemoveSpell(92682, false, false);// unlearn Explorer
                player->RemoveSpell(20596, false, false);// unlearn Frost Resistance
                player->RemoveSpell(20595, false, false);// unlearn Gun Specialization
                player->RemoveSpell(59224, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20594, false, false);// unlearn Stoneform
                //Gnome:
                player->RemoveSpell(20592, false, false);// unlearn Arcane Resistance
                player->RemoveSpell(20593, false, false);// unlearn Engineering Specialization
                player->RemoveSpell(20589, false, false);// unlearn Escape Artist
                player->RemoveSpell(20591, false, false);// unlearn Expansive Mind
                player->RemoveSpell(92680, false, false);//Shortblade Specialization
                //Human:
                player->RemoveSpell(20599, false, false);// unlearn Diplomacy
                player->RemoveSpell(59752, false, false);// unlearn Every man for himself
                player->RemoveSpell(20864, false, false);// unlearn Mace Specialization
                player->RemoveSpell(20597, false, false);// unlearn Sword Specialization
                player->RemoveSpell(20598, false, false);// unlearn The Human Spirit
                //Night Elf:
                player->RemoveSpell(20583, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20582, false, false);// unlearn Quickness
                player->RemoveSpell(58984, false, false);// unlearn Shadowmeld
                player->RemoveSpell(20585, false, false);// unlearn Wisp Spirit
                //~DK, Hunter, Druid, Hunter, Priest, Rogue, Warrior
                player->RemoveSpell(21009, false, false);// unlearn Elusiveness
                //Orc:
                player->RemoveSpell(20574, false, false);// unlearn Axe Specialization
                player->RemoveSpell(20573, false, false);// unlearn Hardiness
                //~DK
                player->RemoveSpell(54562, false, false);// unlearn Command
                //~DK, hunter, rogue, warrior
                player->RemoveSpell(20572, false, false);// unlearn Blood Fury
                //~Druid, mage, paladin, priest, rogue, warrior
                player->RemoveSpell(21563, false, false);// unlearn Command
                //~Hunter
                player->RemoveSpell(20576, false, false);// unlearn Command
                //~Shaman
                player->RemoveSpell(33697, false, false);// unlearn Blood fury
                player->RemoveSpell(65222, false, false);// unlearn Command
                //~Warlock
                player->RemoveSpell(33702, false, false);// unlearn Blood Fury
                player->RemoveSpell(20575, false, false);// unlearn Command
                //Tauren:
                player->RemoveSpell(20552, false, false);// unlearn Cultivation
                player->RemoveSpell(20550, false, false);// unlearn Endurance
                player->RemoveSpell(20551, false, false);// unlearn Nature Resistance
                player->RemoveSpell(20549, false, false);// unlearn Warstomp
                //Troll:
                player->RemoveSpell(20557, false, false);// unlearn Beast Slaying
                player->RemoveSpell(26297, false, false);// unlearn Berserking
                player->RemoveSpell(26290, false, false);// unlearn Bow Specialization
                player->RemoveSpell(58943, false, false);// unlearn Da Voodoo Shuffle
                player->RemoveSpell(20555, false, false);// unlearn Regeneration
                player->RemoveSpell(20558, false, false);// unlearn Throwing Specialization
                //worgen
                player->RemoveSpell(68976, false, false);//Unlearn Aberration
                player->RemoveSpell(68978, false, false);//Unlearn Flayer
                player->RemoveSpell(68975, false, false);//Unlearn Viciousness
                break;
            default:

                break;
            }
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_race_trait_swapAI(creature);
    }
};

void AddSC_racial_traits_npc()
{
    new SPPCATA_Race_Trait_announce();
    new npc_race_trait_swap();
}
