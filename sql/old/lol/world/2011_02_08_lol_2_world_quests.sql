START TRANSACTION;
## Fix for Quest 11983  - Blood Oath of the Horde
## Texts from http://www.wowpedia.org/index.php?title=Quest:Blood_Oath_of_the_Horde&oldid=2587818
SET @taunka = 26179;
SET @npctext= @taunka*10;

## Insert texts for the Taunka Tauren
## Take High IDs, original IDs come from WDB Data - We have no data so take high IDs so they will not be overwritten
-- Taking NPC-ID*10
REPLACE INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`lang0`,`prob0`,`em0_0`,`em0_1`,`em0_2`,`em0_3`,`em0_4`,`em0_5`,`text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,`text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,`text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,`text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,`text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,`text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,`text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,`WDBVerified`) VALUES
 -- ID
 (@npctext+0,
 -- text0_0,text0_1,lang0,prob0,em0_0,em0_1,em0_2,em0_3,em0_4,em0_5,
  'We are a people without a home to call our own now.',NULL,0,100,0,0,0,0,0,0,
 -- `text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- WDBVerified
 -1),
 (@npctext+1,
 -- text0_0,text0_1,lang0,prob0,em0_0,em0_1,em0_2,em0_3,em0_4,em0_5,
  'Will the Horde grant me chance to battle the Scourge?',NULL,0,100,0,0,0,0,0,0,
 -- `text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- WDBVerified
 -1),
 (@npctext+2,
 -- text0_0,text0_1,lang0,prob0,em0_0,em0_1,em0_2,em0_3,em0_4,em0_5,
  'To avenge my people, to drive out the blight that has engulfed our land - I will take your oath. I will pledge all that I have and all that I am to the Horde.',NULL,0,100,0,0,0,0,0,0,
 -- `text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- WDBVerified
 -1),
 (@npctext+3,
 -- text0_0,text0_1,lang0,prob0,em0_0,em0_1,em0_2,em0_3,em0_4,em0_5,
  'Lok\'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde.\n\nI give my flesh and blood freely to the Warchief. I am the instrument of my Warchief\'s desire. I am a weapon of my Warchief\'s command.\n\n
From this moment until the end of days I live and die - FOR THE HORDE!',NULL,0,100,0,0,0,0,0,0,
 -- `text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- `text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,
  NULL,NULL,0,0,0,0,0,0,0,0,
 -- WDBVerified
 -1);

### Gossip Itself
-- Use different gossip_menu_option IDs then planned :| planned: @npctext+1
SET @gossip_menu = 50010;
## Set npc_flag Gossip and Gossip Menu ID
UPDATE `creature_template` SET `npcflag` = `npcflag`|1, `gossip_menu_id` = @gossip_menu WHERE `entry` = @taunka;

## Create Initial Gossip Menu
DELETE FROM `gossip_menu` WHERE `entry` BETWEEN @gossip_menu+0 AND @gossip_menu+9;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
 (@gossip_menu+0,@npctext+0), -- Initial Page
 (@gossip_menu+1,@npctext+1), -- Page 2 
 (@gossip_menu+2,@npctext+2), -- Page 3
 (@gossip_menu+3,@npctext+3); -- Page 4

## Create Gossip Selects & Menu
-- Script-ID consists of menu_id followed by id
DELETE FROM `gossip_menu_option` WHERE `menu_id` BETWEEN @gossip_menu+0 AND @gossip_menu+9;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES
 -- Option on Initial Page to Second Page
 -- `menu_id`, `id`, `option_icon`,
 (@gossip_menu+0,1,0,
 -- `option_text`,
 'Worry no more, taunka. The Horde will save and protect you and your people, but first you must swear allegiance to the Warchief by taking the blood oath of the Horde.',
 -- `option_id`, `npc_option_npcflag`,
 1,1,
 -- `action_menu_id`, `action_poi_id`, `action_script_id`,
 @gossip_menu+1,0,0,
 -- `box_coded`, `box_money`, `box_text`
 0,0,NULL),
 -- Option on Second Page to Third Page
 -- `menu_id`, `id`, `option_icon`,
 (@gossip_menu+1,1,0,
 -- `option_text`,
 'Yes, taunka. Retribution is a given right of all members of the Horde.',
 -- `option_id`, `npc_option_npcflag`,
 1,1,
 -- `action_menu_id`, `action_poi_id`, `action_script_id`,
 @gossip_menu+2,0,0,
 -- `box_coded`, `box_money`, `box_text`
 0,0,NULL),
 -- Option on Third Page to Fourth Page
 -- `menu_id`, `id`, `option_icon`,
 (@gossip_menu+2,1,0,
 -- `option_text`,
 'Then repeat after me: "Lok\'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde.\n\nI give my flesh and blood freely to the Warchief. I am the instrument of my Warchief\'s desire. I am a weapon of my Warchief\'s command.\n\nrom this moment until the end of days I live and die - For the Horde!"',
 -- `option_id`, `npc_option_npcflag`,
 1,1,
 -- `action_menu_id`, `action_poi_id`, `action_script_id`,
 @gossip_menu+3,0,0,
 -- `box_coded`, `box_money`, `box_text`
 0,0,NULL),
 -- Option on Fourth Page to Give Kill Credit
 -- `menu_id`, `id`, `option_icon`,
 (@gossip_menu+3,1,0,
 -- `option_text`,
 'For the Horde!\n\n Arm yourself from the crates that surround us and report to Agmar\'s Hammer, east of here. Your first trial as a member of the Horde is to survive the journey.\n\n Lok\'tar ogar!',
 -- `option_id`, `npc_option_npcflag`,
 1,1,
 -- `action_menu_id`, `action_poi_id`, `action_script_id`,
 0,0,@gossip_menu,
 -- `box_coded`, `box_money`, `box_text`
 0,0,NULL);

DELETE FROM `gossip_scripts` WHERE `id` = @gossip_menu;
## Create Gossip Script for Giving KillCredit on click
INSERT INTO `gossip_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
 (@gossip_menu,0,33,      0,0,0,0,0,0,0), -- Close Gossip Menu
 (@gossip_menu,2, 8,@taunka,1,0,0,0,0,0); -- Give KillCredit on Click

-- Bind Gossip to Quest
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = @gossip_menu+0 AND `ConditionTypeOrReference` = 9 AND ConditionValue1 = 11983;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `Comment`) VALUES
 (15, @gossip_menu+0, 1, 0, 9, 11983, 0, 0, 0, 'Bind Gossip Menu of Roanauk Icemist to Quest');

/*
TAUNKA: We are a people without a home to call our own now. 
PLAYER: Worry no more, taunka. The Horde will save and protect you and your people, but first you must swear allegiance to the Warchief by taking the blood oath of the Horde. 

TAUNKA: Will the Horde grant me chance to battle the Scourge? 
PLAYER: Yes, taunka. Retribution is a given right of all members of the Horde. 

TAUNKA: To avenge my people, to drive out the blight that has engulfed our land - I will take your oath. I will pledge all that I have and all that I am to the Horde. 
PLAYER: Then repeat after me: "Lok'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde. 
I give my flesh and blood freely to the Warchief. I am the instrument of my Warchief's desire. I am a weapon of my Warchief's command. 
From this moment until the end of days I live and die - For the Horde!" 

TAUNKA: Lok'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde. 

I give my flesh and blood freely to the Warchief. I am the instrument of my Warchief's desire. I am a weapon of my Warchief's command. 

From this moment until the end of days I live and die - FOR THE HORDE! 
PLAYER: For the Horde! 
Arm yourself from the crates that surround us and report to Agmar's Hammer, east of here. Your first trial as a member of the Horde is to survive the journey. 
Lok'tar ogar!
*/
COMMIT;