/* Skip Death Knight Module
   Original Module From Single Player Project Consolidated Skip Module
   Rewritten for TC 434 By Single Player Project Developer MDic
   Original Concept from conanhun513
*/

#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Common.h"
#include "Chat.h"
#include "Creature.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptPCH.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SharedDefines.h"
#include "World.h"
#include "WorldSession.h"

class SPP_skip_deathknight_announce : public PlayerScript
{
public:
    SPP_skip_deathknight_announce() : PlayerScript("SPP_skip_deathknight_announce") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault("Skip.Deathknight.Starter.Announce.enable", true))
        {
            ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SPP Skip Deathknight Starter |rmodule.");
        }
    }
};

class SPP_skip_goblin_announce : public PlayerScript
{
public:
    SPP_skip_goblin_announce() : PlayerScript("SPP_skip_goblin_announce") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault("Skip.Goblin.Starter.Announce.enable", true))
        {
            ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SPP Skip Goblin Starter |rmodule.");
        }
    }
};

class SPP_skip_worgen_announce : public PlayerScript
{
public:
    SPP_skip_worgen_announce() : PlayerScript("SPP_skip_worgen_announce") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault("Skip.Worgen.Starter.Announce.enable", true))
        {
            ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SPP Skip Worgen Starter |rmodule.");
        }
    }
};

class SPP_skip_deathknight : public PlayerScript
{
public:
    SPP_skip_deathknight() : PlayerScript("SPP_skip_deathknight") { }

    void OnLogin(Player* player, bool firstLogin) override
    {
        int DKL = sConfigMgr->GetFloatDefault("Skip.Deathknight.Start.Level", 58);

        if (sConfigMgr->GetBoolDefault("Skip.Deathknight.Starter.Enable", true))
        {
            if (player->GetAreaId() == 4342)
            {
                if (!firstLogin)
                    return;
                player->SetLevel(DKL);
                player->LearnSpell(53428, false);//runeforging
                player->LearnSpell(53441, false);//runeforging
                player->LearnSpell(53344, false);//runeforging
                player->LearnSpell(62158, false);//runeforging
                player->LearnSpell(33391, false);//journeyman riding
                player->LearnSpell(54586, false);//runeforging credit
                player->LearnSpell(48778, false);//acherus deathcharger
                player->LearnSkillRewardedSpells(776, 375);//Runeforging
                player->LearnSkillRewardedSpells(960, 375);//Runeforging
                player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 38661, true);//Greathelm of the Scourge Champion
                player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 38666, true);//Plated Saronite Bracers
                player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 38668, true);//The Plaguebringer's Girdle
                player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 38667, true);//Bloodbane's Gauntlets of Command
                player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 38665, true);//Saronite War Plate
                player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 38669, true);//Engraved Saronite Legplates
                player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 38663, true);// Blood-Soaked Saronite Plated Spaulders
                player->EquipNewItem(EQUIPMENT_SLOT_FEET, 38670, true);//Greaves of the Slaughter
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 38675, true);//Signet of the Dark Brotherhood
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 38674, true);//Soul Harvester's Charm
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 38671, true);//Valanar's Signet Ring
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 38672, true);// Keleseth's Signet Ring
                player->AddItem(39320, true);//Sky Darkener's Shroud of Blood
                player->AddItem(38664, true);//Sky Darkener's Shroud of the Unholy
                player->AddItem(39322, true);//Shroud of the North Wind
                player->AddItem(38632, true);//Greatsword of the Ebon Blade
                player->AddItem(6948, true);//Hearthstone
                player->AddItem(38707, true);//Runed Soulblade
                player->AddItem(40483, true);//Insignia of the Scourge

                if (player->GetQuestStatus(12657) == QUEST_STATUS_NONE)//The Might Of The Scourge
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12657), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12657), false, player);
                }
                if (player->GetQuestStatus(12801) == QUEST_STATUS_NONE)//The Light of Dawn
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12801), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12801), false, player);
                }
                if (player->GetTeam() == ALLIANCE && player->GetQuestStatus(13188) == QUEST_STATUS_NONE)//Where Kings Walk
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13188), nullptr);
                else if (player->GetTeam() == HORDE && player->GetQuestStatus(13189) == QUEST_STATUS_NONE)//Saurfang's Blessing
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13189), nullptr);
                if (player->GetTeam() == ALLIANCE)
                    player->TeleportTo(0, -8833.37f, 628.62f, 94.00f, 1.06f);//Stormwind
                else
                    player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);//Orgrimmar
                ObjectAccessor::SaveAllPlayers();//Save
            }
        }

        if (sConfigMgr->GetBoolDefault("GM.Skip.Deathknight.Starter.Enable", true))
        {
            if (player->GetSession()->GetSecurity() >= SEC_MODERATOR && player->GetAreaId() == 4342)
            {
                if (!firstLogin)
                    return;
                player->SetLevel(DKL);
                player->LearnSpell(53428, false);//runeforging
                player->LearnSpell(53441, false);//runeforging
                player->LearnSpell(53344, false);//runeforging
                player->LearnSpell(62158, false);//runeforging
                player->LearnSpell(33391, false);//journeyman riding
                player->LearnSpell(54586, false);//runeforging credit
                player->LearnSpell(48778, false);//acherus deathcharger
                player->LearnSkillRewardedSpells(776, 375);//Runeforging
                player->LearnSkillRewardedSpells(960, 375);//Runeforging
                player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 38661, true);//Greathelm of the Scourge Champion
                player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 38666, true);//Plated Saronite Bracers
                player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 38668, true);//The Plaguebringer's Girdle
                player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 38667, true);//Bloodbane's Gauntlets of Command
                player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 38665, true);//Saronite War Plate
                player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 38669, true);//Engraved Saronite Legplates
                player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 38663, true);// Blood-Soaked Saronite Plated Spaulders
                player->EquipNewItem(EQUIPMENT_SLOT_FEET, 38670, true);//Greaves of the Slaughter
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 38675, true);//Signet of the Dark Brotherhood
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 38674, true);//Soul Harvester's Charm
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 38671, true);//Valanar's Signet Ring
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 38672, true);// Keleseth's Signet Ring
                player->AddItem(39320, true);//Sky Darkener's Shroud of Blood
                player->AddItem(38664, true);//Sky Darkener's Shroud of the Unholy
                player->AddItem(39322, true);//Shroud of the North Wind
                player->AddItem(38632, true);//Greatsword of the Ebon Blade
                player->AddItem(6948, true);//Hearthstone
                player->AddItem(38707, true);//Runed Soulblade
                player->AddItem(40483, true);//Insignia of the Scourge

                if (player->GetQuestStatus(12657) == QUEST_STATUS_NONE)//The Might Of The Scourge
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12657), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12657), false, player);
                }
                if (player->GetQuestStatus(12801) == QUEST_STATUS_NONE)//The Light of Dawn
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12801), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12801), false, player);
                }
                if (player->GetTeam() == ALLIANCE && player->GetQuestStatus(13188) == QUEST_STATUS_NONE)//Where Kings Walk
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13188), nullptr);
                else if (player->GetTeam() == HORDE && player->GetQuestStatus(13189) == QUEST_STATUS_NONE)//Saurfang's Blessing
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13189), nullptr);
                if (player->GetTeam() == ALLIANCE)
                    player->TeleportTo(0, -8833.37f, 628.62f, 94.00f, 1.06f);//Stormwind
                else
                    player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);//Orgrimmar
                ObjectAccessor::SaveAllPlayers();//Save
            }
        }
    }
};


class spp_skip_goblin : public PlayerScript
{
public:
    spp_skip_goblin() : PlayerScript("spp_skip_goblin") { }

    void OnLogin(Player* Player, bool firstLogin) override
    {
        int GBL = sConfigMgr->GetFloatDefault("Skip.Goblin.Start.Level", 16);

        if (sConfigMgr->GetBoolDefault("Skip.Goblin.Starter.Enable", true))
        {
            if (Player->GetMapId() == 648)
            {
                if (!firstLogin)
                    return;
                Player->SetLevel(GBL);
                Player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);
                if (Player->GetQuestStatus(25267) == QUEST_STATUS_NONE)
                {
                    Player->AddQuest(sObjectMgr->GetQuestTemplate(25267), NULL);//Message for Garrosh
                }
                ObjectAccessor::SaveAllPlayers();
            }
        }

        if (sConfigMgr->GetBoolDefault("GM.Skip.Goblin.Starter.Enable", true))
        {
            if (Player->GetSession()->GetSecurity() >= SEC_MODERATOR && Player->GetMapId() == 648)
            {
                if (!firstLogin)
                    return;
                Player->SetLevel(GBL);
                Player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);
                if (Player->GetQuestStatus(25267) == QUEST_STATUS_NONE)//Message for Garrosh
                {
                    Player->AddQuest(sObjectMgr->GetQuestTemplate(25267), NULL);
                }
                ObjectAccessor::SaveAllPlayers();
            }
        }
    }
};

class spp_skip_worgen : public PlayerScript
{
public:
    spp_skip_worgen() : PlayerScript("spp_skip_worgen") { }

    void OnLogin(Player* Player, bool firstLogin) override
    {
        int WGL = sConfigMgr->GetFloatDefault("Skip.Worgen.Start.Level", 18);

        if (sConfigMgr->GetBoolDefault("Skip.Worgen.Starter.Enable", true))
        {
            if (Player->GetMapId() == 654)
            {
                if (!firstLogin)
                    return;
                Player->LearnSpell(72792, false); // Learn Racials
                Player->LearnSpell(72857, false); // Learn Two Forms
                Player->LearnSpell(95759, false); // Learn Darkflight
                Player->TeleportTo(1, 8181.060059f, 999.103027f, 7.253240f, 6.174160f);
                Player->SetLevel(WGL);
                ObjectAccessor::SaveAllPlayers();
            }
        }

        if (sConfigMgr->GetBoolDefault("GM.Skip.Worgen.Starter.Enable", true))
        {
            if (Player->GetSession()->GetSecurity() >= SEC_MODERATOR && Player->GetMapId() == 654)
            {
                if (!firstLogin)
                    return;
                Player->LearnSpell(72792, false); // Learn Racials
                Player->LearnSpell(72857, false); // Learn Two Forms
                Player->LearnSpell(95759, false); // Learn Darkflight
                Player->TeleportTo(1, 8181.060059f, 999.103027f, 7.253240f, 6.174160f);
                Player->SetLevel(WGL);
                ObjectAccessor::SaveAllPlayers();
            }
        }
    }
};

#define LOCALE_LICHKING_0 "I wish to skip the Death Knight starter questline."
#define LOCALE_LICHKING_1 "죽음의 기사 스타터 퀘스트 라인을 건너뛰고 싶습니다."
#define LOCALE_LICHKING_2 "Je souhaite sauter la série de quêtes de démarrage du Chevalier de la mort."
#define LOCALE_LICHKING_3 "Ich möchte die Todesritter-Starter-Questreihe überspringen."
#define LOCALE_LICHKING_4 "我想跳過死亡騎士新手任務線。"
#define LOCALE_LICHKING_5 "我想跳過死亡騎士新手任務線。"
#define LOCALE_LICHKING_6 "Deseo saltarme la línea de misiones de inicio del Caballero de la Muerte."
#define LOCALE_LICHKING_7 "Deseo saltarme la línea de misiones de inicio del Caballero de la Muerte."
#define LOCALE_LICHKING_8 "Я хочу пропустить начальную цепочку заданий Рыцаря Смерти."

class spp_optional_deathknight_skip : public CreatureScript
{
public:
    spp_optional_deathknight_skip() : CreatureScript("npc_tc_skip_lich") { }

    struct npc_SkipLichAI : public ScriptedAI
    {
        npc_SkipLichAI(Creature* creature) : ScriptedAI(creature) { }

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

        bool GossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            return OnGossipSelect(player, me, sender, action);
        }

        static bool OnGossipHello(Player* player, Creature* me)
        {
            if (me->IsQuestGiver())
                player->PrepareQuestMenu(me->GetGUID());

            if (sConfigMgr->GetBoolDefault("Skip.Deathknight.Optional.Enable", true))
            {
                char const* localizedEntry;
                switch (player->GetSession()->GetSessionDbcLocale())
                {
                case LOCALE_koKR: localizedEntry = LOCALE_LICHKING_1; break;
                case LOCALE_frFR: localizedEntry = LOCALE_LICHKING_2; break;
                case LOCALE_deDE: localizedEntry = LOCALE_LICHKING_3; break;
                case LOCALE_zhCN: localizedEntry = LOCALE_LICHKING_4; break;
                case LOCALE_zhTW: localizedEntry = LOCALE_LICHKING_5; break;
                case LOCALE_esES: localizedEntry = LOCALE_LICHKING_6; break;
                case LOCALE_esMX: localizedEntry = LOCALE_LICHKING_7; break;
                case LOCALE_ruRU: localizedEntry = LOCALE_LICHKING_8; break;
                case LOCALE_enUS: default: localizedEntry = LOCALE_LICHKING_0;
                }
                player->PrepareQuestMenu(me->GetGUID());
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, localizedEntry, GOSSIP_SENDER_MAIN, 11);
            }

            player->TalkedToCreature(me->GetEntry(), me->GetGUID());
            SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* /*_creature*/, uint32 /*sender*/, uint32 gossipListId)
        {
            int DKL = sConfigMgr->GetFloatDefault("Skip.Deathknight.Start.Level", 58);
            ClearGossipMenuFor(player);

            switch (gossipListId)
            {
            case 11:
                if (player)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Yes", GOSSIP_SENDER_MAIN, 12);
                    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "No", GOSSIP_SENDER_MAIN, 13);
                    SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
                }
                break;

            case 12:
                if (player->getLevel() <= DKL)
                {
                    player->SetLevel(DKL);
                }
                player->LearnSpell(53428, false);//runeforging
                player->LearnSpell(53441, false);//runeforging
                player->LearnSpell(53344, false);//runeforging
                player->LearnSpell(62158, false);//runeforging
                player->LearnSpell(33391, false);//journeyman riding
                player->LearnSpell(54586, false);//runeforging credit
                player->LearnSpell(48778, false);//acherus deathcharger
                player->LearnSkillRewardedSpells(776, 375);//Runeforging
                player->LearnSkillRewardedSpells(960, 375);//Runeforging
                player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 38661, true);//Greathelm of the Scourge Champion
                player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 38666, true);//Plated Saronite Bracers
                player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 38668, true);//The Plaguebringer's Girdle
                player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 38667, true);//Bloodbane's Gauntlets of Command
                player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 38665, true);//Saronite War Plate
                player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 38669, true);//Engraved Saronite Legplates
                player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 38663, true);// Blood-Soaked Saronite Plated Spaulders
                player->EquipNewItem(EQUIPMENT_SLOT_FEET, 38670, true);//Greaves of the Slaughter
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 38675, true);//Signet of the Dark Brotherhood
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 38674, true);//Soul Harvester's Charm
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 38671, true);//Valanar's Signet Ring
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 38672, true);// Keleseth's Signet Ring
                player->AddItem(39320, true);//Sky Darkener's Shroud of Blood
                player->AddItem(38664, true);//Sky Darkener's Shroud of the Unholy
                player->AddItem(39322, true);//Shroud of the North Wind
                player->AddItem(38632, true);//Greatsword of the Ebon Blade
                player->AddItem(6948, true);//Hearthstone
                player->AddItem(38707, true);//Runed Soulblade
                player->AddItem(40483, true);//Insignia of the Scourge

                if (player->GetQuestStatus(12657) == QUEST_STATUS_NONE)//The Might Of The Scourge
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12657), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12657), false, player);
                }
                if (player->GetQuestStatus(12801) == QUEST_STATUS_NONE)//The Light of Dawn
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12801), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12801), false, player);
                }
                if (player->GetTeam() == ALLIANCE && player->GetQuestStatus(13188) == QUEST_STATUS_NONE)//Where Kings Walk
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13188), nullptr);
                else if (player->GetTeam() == HORDE && player->GetQuestStatus(13189) == QUEST_STATUS_NONE)//Saurfang's Blessing
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13189), nullptr);
                if (player->GetTeam() == ALLIANCE)
                    player->TeleportTo(0, -8833.37f, 628.62f, 94.00f, 1.06f);//Stormwind
                else
                    player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);//Orgrimmar
                ObjectAccessor::SaveAllPlayers();//Save
                CloseGossipMenuFor(player);
                break;

            case 13://close
                CloseGossipMenuFor(player);
                break;

            default:

                break;
            }
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_SkipLichAI(creature);
    }
};

#define LOCALE_GOBSKIP_0 "I wish to skip the Goblin starter questline."
#define LOCALE_GOBSKIP_1 "고블린 스타터 퀘스트 라인을 건너뛰고 싶습니다."
#define LOCALE_GOBSKIP_2 "Je souhaite sauter la série de quêtes de démarrage des gobelins."
#define LOCALE_GOBSKIP_3 "Ich möchte die Goblin-Starter-Questreihe überspringen."
#define LOCALE_GOBSKIP_4 "我想跳過地精初學者任務線。"
#define LOCALE_GOBSKIP_5 "我想跳過地精初學者任務線。"
#define LOCALE_GOBSKIP_6 "Deseo omitir la línea de misiones de inicio de goblin."
#define LOCALE_GOBSKIP_7 "Deseo omitir la línea de misiones de inicio de goblin."
#define LOCALE_GOBSKIP_8 "Я хочу пропустить стартовую цепочку заданий гоблинов."

class spp_optional_goblin_skip : public CreatureScript
{
public:
    spp_optional_goblin_skip() : CreatureScript("npc_tc_skip_gob") { }

    struct npc_SkipGobAI : public ScriptedAI
    {
        npc_SkipGobAI(Creature* creature) : ScriptedAI(creature) { }

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

        bool GossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            return OnGossipSelect(player, me, sender, action);
        }

        static bool OnGossipHello(Player* player, Creature* me)
        {
            if (me->IsQuestGiver())
                player->PrepareQuestMenu(me->GetGUID());

            if (sConfigMgr->GetBoolDefault("Skip.Goblin.Optional.Enable", true))
            {
                char const* localizedEntry;
                switch (player->GetSession()->GetSessionDbcLocale())
                {
                case LOCALE_koKR: localizedEntry = LOCALE_GOBSKIP_1; break;
                case LOCALE_frFR: localizedEntry = LOCALE_GOBSKIP_2; break;
                case LOCALE_deDE: localizedEntry = LOCALE_GOBSKIP_3; break;
                case LOCALE_zhCN: localizedEntry = LOCALE_GOBSKIP_4; break;
                case LOCALE_zhTW: localizedEntry = LOCALE_GOBSKIP_5; break;
                case LOCALE_esES: localizedEntry = LOCALE_GOBSKIP_6; break;
                case LOCALE_esMX: localizedEntry = LOCALE_GOBSKIP_7; break;
                case LOCALE_ruRU: localizedEntry = LOCALE_GOBSKIP_8; break;
                case LOCALE_enUS: default: localizedEntry = LOCALE_GOBSKIP_0;
                }
                player->PrepareQuestMenu(me->GetGUID());
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, localizedEntry, GOSSIP_SENDER_MAIN, 21);
            }

            player->TalkedToCreature(me->GetEntry(), me->GetGUID());
            SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* /*_creature*/, uint32 /*sender*/, uint32 gossipListId)
        {
            int GBL = sConfigMgr->GetFloatDefault("Skip.Goblin.Start.Level", 16);
            ClearGossipMenuFor(player);

            switch (gossipListId)
            {
            case 21:
                if (player)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Yes", GOSSIP_SENDER_MAIN, 22);
                    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "No", GOSSIP_SENDER_MAIN, 23);
                    SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
                }
                break;

            case 22:
                if (player->getLevel() <= GBL)
                {
                    player->SetLevel(GBL);
                }
                player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);
                if (player->GetQuestStatus(25267) == QUEST_STATUS_NONE)
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(25267), NULL);//Message for Garrosh
                }
                ObjectAccessor::SaveAllPlayers();//Save
                CloseGossipMenuFor(player);
                break;

            case 23://close
                CloseGossipMenuFor(player);
                break;

            default:

                break;
            }
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_SkipGobAI(creature);
    }
};

#define LOCALE_WORSKIP_0 "I wish to skip the Worgen starter questline."
#define LOCALE_WORSKIP_1 "늑대인간 스타터 퀘스트 라인을 건너뛰고 싶습니다."
#define LOCALE_WORSKIP_2 "Je souhaite sauter la série de quêtes de démarrage Worgen."
#define LOCALE_WORSKIP_3 "Ich möchte die Worgen-Starter-Questreihe überspringen."
#define LOCALE_WORSKIP_4 "我想跳過狼人新手任務線。"
#define LOCALE_WORSKIP_5 "我想跳過狼人新手任務線。"
#define LOCALE_WORSKIP_6 "Deseo omitir la línea de misiones de inicio de los huargen."
#define LOCALE_WORSKIP_7 "Deseo omitir la línea de misiones de inicio de los huargen."
#define LOCALE_WORSKIP_8 "Я хочу пропустить начальную цепочку заданий воргенов."

class spp_optional_worgen_skip : public CreatureScript
{
public:
    spp_optional_worgen_skip() : CreatureScript("npc_tc_skip_worg") { }

    struct npc_SkipWorgAI : public ScriptedAI
    {
        npc_SkipWorgAI(Creature* creature) : ScriptedAI(creature) { }

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

        bool GossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            return OnGossipSelect(player, me, sender, action);
        }

        static bool OnGossipHello(Player* player, Creature* me)
        {
            if (me->IsQuestGiver())
                player->PrepareQuestMenu(me->GetGUID());

            if (sConfigMgr->GetBoolDefault("Skip.Worgen.Optional.Enable", true))
            {
                char const* localizedEntry;
                switch (player->GetSession()->GetSessionDbcLocale())
                {
                case LOCALE_koKR: localizedEntry = LOCALE_WORSKIP_1; break;
                case LOCALE_frFR: localizedEntry = LOCALE_WORSKIP_2; break;
                case LOCALE_deDE: localizedEntry = LOCALE_WORSKIP_3; break;
                case LOCALE_zhCN: localizedEntry = LOCALE_WORSKIP_4; break;
                case LOCALE_zhTW: localizedEntry = LOCALE_WORSKIP_5; break;
                case LOCALE_esES: localizedEntry = LOCALE_WORSKIP_6; break;
                case LOCALE_esMX: localizedEntry = LOCALE_WORSKIP_7; break;
                case LOCALE_ruRU: localizedEntry = LOCALE_WORSKIP_8; break;
                case LOCALE_enUS: default: localizedEntry = LOCALE_WORSKIP_0;
                }
                player->PrepareQuestMenu(me->GetGUID());
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, localizedEntry, GOSSIP_SENDER_MAIN, 31);
            }

            player->TalkedToCreature(me->GetEntry(), me->GetGUID());
            SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* /*_creature*/, uint32 /*sender*/, uint32 gossipListId)
        {
            int WGL = sConfigMgr->GetFloatDefault("Skip.Worgen.Start.Level", 16);
            ClearGossipMenuFor(player);

            switch (gossipListId)
            {
            case 31:
                if (player)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Yes", GOSSIP_SENDER_MAIN, 32);
                    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "No", GOSSIP_SENDER_MAIN, 33);
                    SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
                }
                break;

            case 32:
                if (player->getLevel() <= WGL)
                {
                    player->SetLevel(WGL);
                }
                player->LearnSpell(72792, false); // Learn Racials
                player->LearnSpell(72857, false); // Learn Two Forms
                player->LearnSpell(95759, false); // Learn Darkflight
                player->TeleportTo(1, 8181.060059f, 999.103027f, 7.253240f, 6.174160f);
                player->SetLevel(WGL);
                ObjectAccessor::SaveAllPlayers();// Save
                CloseGossipMenuFor(player);
                break;

            case 33://close
                CloseGossipMenuFor(player);
                break;

            default:

                break;
            }
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_SkipWorgAI(creature);
    }
};
void AddSC_skip_StarterArea()
{
    new SPP_skip_deathknight_announce;
    new SPP_skip_goblin_announce;
    new SPP_skip_worgen_announce;
    new SPP_skip_deathknight;
    new spp_skip_goblin;
    new spp_skip_worgen;
    new spp_optional_deathknight_skip;
    new spp_optional_goblin_skip();
    new spp_optional_worgen_skip();
}
