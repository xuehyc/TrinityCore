START TRANSACTION;
## Fix for Quest 12140  - All Hail Roanauk!
## Texts from http://www.landoflegends.de/mantis/view.php?id=1044
SET @taunka         = 26810;
SET @npctext        = @taunka*10;
SET @dbscriptstring = 2000000200;
SET @quest          = 12140;

## Insert texts for Raonauk Icemist
## Take High IDs, original IDs come from WDB Data - We have no data so take high IDs so they will not be overwritten
-- Taking NPC-ID*10
REPLACE INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`lang0`,`prob0`,`em0_0`,`em0_1`,`em0_2`,`em0_3`,`em0_4`,`em0_5`,`text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,`text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,`text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,`text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,`text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,`text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,`text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,`WDBVerified`) VALUES
 -- ID
 (@npctext+0,
 -- text0_0,text0_1,lang0,prob0,em0_0,em0_1,em0_2,em0_3,em0_4,em0_5,
  'Thank you for rescuing me, $N.',NULL,0,100,0,0,0,0,0,0,
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
 -- ID
 (@npctext+1,
 -- text0_0,text0_1,lang0,prob0,em0_0,em0_1,em0_2,em0_3,em0_4,em0_5,
  'It would be an honor to battle alongside of you as a member of the Horde. $N, I accept your offer..',NULL,0,100,0,0,0,0,0,0,
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

-- German
REPLACE INTO `locales_npc_text` (`entry`, `Text0_0_loc3`) VALUES
 (@npctext+0, 'Ich danke dir für meine Rettung, $N.'),
 (@npxtext+1, 'Es ist mir eine Ehre, als Mitglied der Horde an eurer Seite zu kämpfen. $N, ich akzeptiere euer Angebot.');


### Gossip Itself
-- Use different gossip_menu_option IDs then planned :| planned: @npctext+1
SET @gossip_menu = 50020;
## Set npc_flag Gossip and Gossip Menu ID
UPDATE `creature_template` SET `npcflag` = `npcflag`|1, `gossip_menu_id` = @gossip_menu WHERE `entry` = @taunka;

## Create Initial Gossip Menu
DELETE FROM `gossip_menu` WHERE `entry` BETWEEN @gossip_menu+0 AND @gossip_menu+9;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
 (@gossip_menu+0,@npctext+0), -- Initial Page
 (@gossip_menu+1,@npctext+1); -- First Page

## Create Gossip Selects & Menu
-- Script-ID consists of menu_id followed by id
DELETE FROM `gossip_menu_option` WHERE `menu_id` BETWEEN @gossip_menu+0 AND @gossip_menu+9;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES
 -- Option on Initial Page to Second Page
 -- `menu_id`, `id`, `option_icon`,
 (@gossip_menu+0,1,0,
 -- `option_text`,
 'Greetings, High Chief. Would you do me the honor of accepting my invitation to join the horde as an official member and leader of the Taunka ?.',
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
 'It is you who honor me, High Chief. Please read form this scroll. It is the oath of alegiance.',
 -- `option_id`, `npc_option_npcflag`,
 1,1,
 -- `action_menu_id`, `action_poi_id`, `action_script_id`,
 0,0,@gossip_menu,
 -- `box_coded`, `box_money`, `box_text`
 0,0,NULL);

-- German
REPLACE INTO `locales_gossip_menu_option` (`menu_id`,`id`, `option_text_loc3`) VALUES
 (@gossip_menu+0,1,'Seid gegrüßt, Oberhäuptling. Würdet Ihr mir die Ehre erweisen, als Anführer der Taunka ein offizielles Mitglied der Horde zu werden ?'),
 (@gossip_menu+1,1,'Ihr seid es der mich ehrt, Oberhäuptling. Bitte lest diese Schriftrolle vor. Es ist der Blutschwur der Horde.');


## NPC Speeches  - loc3: German
REPLACE INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
 (@dbscriptstring+0, 'We will walk together, $N.', NULL, NULL, 'Wir werden gemeinsam gehen, $N.', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+1, 'Gather, brothers and sisters.', NULL, NULL, 'Versammelt euch, Brüder und Schwestern.', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+2, '$C reads from the scroll as the other Taunka gather around him.', NULL, NULL, '$C liest aus der Schriftrolle, während sich die anderen Taunka um ihn sammeln.', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+3, 'Lok\'tar ogar! Victory or death - it is these words that bind me to the Horde! For they are the most sacred and fundamental of truths to any warrior of the Horde.', NULL, NULL, 'Lok\'tar ogar! Sieg oder Tod - Es sind diese Worte, die mich an die Horde binden! Sie sind die heiligsten und grundlegensten Wahrheiten jedes Kriegers der Horde.', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+4, 'I give my flesh and blood freely to the Warchief. I am the instrument of my Warchief\'s desire. I am a weapon of my Warchief\'s command!', NULL, NULL, 'Ich gebe mein Fleisch und Blut frei dem Kriegsherrn. Ich bin das Instrument des Willens meines Kriegsherrn. Ich bin eine Waffe unter dem Kommando meines Kriegsherrn!', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+5, 'From this moment until the end of days I live and die - For the Horde!', NULL, NULL, 'Von diesem Moment an bis zum Ende aller Tage lebe und sterbe ich - Für die Horde!', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+6, 'For my Taunka brothers and sisters! FOR THE HORDE!', NULL, NULL, 'Für meine Brüder und Schwestern der Taunka! FÜR DIE HORDE!', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+7, 'Welcome to the Horde, High Chief. Lok\'tar ogar!', NULL, NULL, 'Willkommen bei der Horde, Oberhäuptling. Lok\'tar ogar!', NULL, NULL, NULL, NULL, NULL),
 (@dbscriptstring+8, 'FOR THE HORDE!', NULL, NULL, 'FÜR DIE HORDE!', NULL, NULL, NULL, NULL, NULL);

DELETE FROM `gossip_scripts` WHERE `id` = @gossip_menu;
## Create Gossip Script for Giving KillCredit on click
INSERT INTO `gossip_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
 (@gossip_menu, 0,33,      0,0,0,0,0,0,0),           -- Close Gossip Menu
 (@gossip_menu, 1, 0,0,0,@dbscriptstring+1,0,0,0,0), -- Roanauk Icemist says: Gather, brothers and sisters.
 (@gossip_menu, 3, 0,2,0,@dbscriptstring+2,0,0,0,0), -- Roanauk Icemist reads from the scroll as the other Taunka gather around him.
 (@gossip_menu, 6, 0,0,0,@dbscriptstring+3,0,0,0,0), -- Roanauk Icemist says: Lok'tar ogar! Victory or death - it is these words that bind me to the Horde! For they are the most sacred and fundamental of truths to any warrior of the Horde.
 (@gossip_menu,12, 0,0,0,@dbscriptstring+4,0,0,0,0), -- Roanauk Icemist says: I give my flesh and blood freely to the Warchief. I am the instrument of my Warchief's desire. I am a weapon of my Warchief's command!
 (@gossip_menu,17, 0,0,0,@dbscriptstring+5,0,0,0,0), -- Roanauk Icemist says: From this moment until the end of days I live and die - For the Horde!
 (@gossip_menu,22, 0,1,0,@dbscriptstring+6,0,0,0,0), -- Roanauk Icemist yells: For my Taunka brothers and sisters! FOR THE HORDE!
 (@gossip_menu,23, 8,@taunka,1,          0,0,0,0,0); -- Give KillCredit on Click

## Create StartScript for Quest
UPDATE `quest_template` SET `StartScript` = @quest WHERE `entry` = @quest;
DELETE FROM `quest_start_scripts` WHERE `id` = @quest;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
 (@quest, 1, 0, 0, 0, @dbscriptstring+0, 0, 0, 0, 0),
 (@quest, 3, 3, 0,10,                 0, 3839.040527, 1541.338989, 89.724403, 0), -- Walk to 1st Point
 (@quest,13, 3, 0, 5,                 0, 3868.041016, 1571.651978, 89.724403, 0), -- Walk to 2nd Point
 (@quest,18, 3, 0,10,                 0, 3873.028076, 1592.851196, 90.113358, 0), -- Walk to Roanauk
 (@quest,29,30, 0, 0,                 0, 0, 0, 0, 0.529162),                      -- Turn to face Roanauk
 -- Not the best Way, but my only :S
 (@quest,45, 0, 0, 0,@dbscriptstring+7,  0,0,0,0), -- Overlord Agmar says: Welcome to the Horde, High Chief. Lok'tar ogar!
 (@quest,50, 0, 1, 0,@dbscriptstring+8,  0,0,0,0), -- Overlord Agmar yells: FOR THE HORDE!
 (@quest,60, 3, 0, 5,                 0, 3868.041016, 1571.651978, 89.724403, 0), -- Walk back to 2nd Point
 (@quest,65, 3, 0,10,                 0, 3839.040527, 1541.338989, 89.724403, 0), -- Walk back to 1st Point
 (@quest,75, 3, 0,10,                 0, 3842.36    , 1488.56    , 92.6322  , 0), -- Walk back to Spawn-Point
 (@quest,85,30, 0, 0,                 0, 0, 0, 0, 1.59434);                       -- Turn to face Roanauk

-- Bind Gossip to Quest
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = @gossip_menu+0 AND `ConditionTypeOrReference` = 9 AND ConditionValue1 = 12140;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `Comment`) VALUES
 (15, @gossip_menu+0, 1, 0, 9, 12140, 0, 0, 0, 'Bind Gossip Menu of Roanauk Icemist to Quest');

/*
After accepting quest 
0 Overlord Agmar says: We will walk together, <name>. 

Roanauk Icemist: Thank you for rescuing me, <name>.
Klickbarer Text: Greetings, High Chief. Would you do me the honor of accepting my invitation to join the horde as an official member and leader of the Taunka ?

Roanauk Icemist: It would be an honor to battle alongside of you as a member of the Horde. <name>, i accept your offer.
Klickbarer Text: It is you who honor me, High Chief. Please read form this scroll. It is the oath of alegiance.

1 Roanauk Icemist says: Gather, brothers and sisters. 
2 Roanauk Icemist reads from the scroll as the other Taunka gather around him. 
3 Roanauk Icemist says: Lok'tar ogar! Victory or death - it is these words that bind me to the Horde! For they are the most sacred and fundamental of truths to any warrior of the Horde. 
4 Roanauk Icemist says: I give my flesh and blood freely to the Warchief. I am the instrument of my Warchief's desire. I am a weapon of my Warchief's command! 
5 Roanauk Icemist says: From this moment until the end of days I live and die - For the Horde! 
6 Roanauk Icemist yells: For my Taunka brothers and sisters! FOR THE HORDE! 
7 Overlord Agmar says: Welcome to the Horde, High Chief. Lok'tar ogar! 
8 Overlord Agmar yells: FOR THE HORDE!
*/
COMMIT;