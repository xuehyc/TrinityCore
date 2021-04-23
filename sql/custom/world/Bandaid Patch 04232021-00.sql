-- Quest: Feast or Famine Missing Quest Texts
SET @QUEST_ID := 26230;
DELETE FROM `quest_offer_reward` WHERE id = @QUEST_ID;
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`) VALUES
(@QUEST_ID, "Just smellin' you comin' got my stomach rumblin'! We're gonna eat like kings tonight!");
DELETE FROM `quest_request_items` WHERE id = @QUEST_ID;
INSERT INTO `quest_request_items` (`ID`, `CompletionText`) VALUES
(@QUEST_ID, "Dirt pies don't make themselves - usually.");

-- Wanted: James Clark Missing Quest Texts
SET @QUEST_ID2 := 26152; 
DELETE FROM `quest_offer_reward` WHERE `ID` = @QUEST_ID2;
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`) VALUES
(@QUEST_ID2, "And justice is served!");

DELETE FROM `quest_request_items` WHERE `ID` = @QUEST_ID2;
INSERT INTO `quest_request_items` (`ID`, `CompletionText`) VALUES
(@QUEST_ID2, "Turning in a bounty?");

-- https://www.wowhead.com/npc=52358/craggle-wobbletop
-- Itesm for sale fix on gossip
UPDATE `gossip_menu_option` SET `OptionType` = 3 WHERE `MenuId` = 12759;

-- Captain Lancy Revshon Mounted on Horse
UPDATE `creature_template_addon` SET `mount` = 28912 WHERE `entry` = 49877; 

-- Quest: Meet Two Shoed Lou Fix
-- https://www.wowhead.com/quest=26215/meet-two-shoed-lou
DELETE FROM `spell_area` WHERE `area`=109 AND `spell` IN (76630,79346);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) VALUES
(76630,109,0,26232,0,0,2,3,0,41),
(79346,109,26232,26266,0,0,2,3,66,41);

-- Quest: Last Meal Quest Item obtainable only durning quest fix
-- https://www.wowhead.com/item=50219/side-of-stag-meat
-- https://www.wowhead.com/quest=24675/last-meal
UPDATE `creature_loot_template` SET `QuestRequired` = '1' WHERE `Item` = '50219' AND `Entry` = '37786' AND `Item` = '50219';

-- Dead Mines trash formations and fix-- Ogre Bodyguard
SET @GUID1 := 375862; -- Check this GUID
SET @GUID2 := 375930; -- Check this GUID
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48262;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-@GUID1,-@GUID2) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Ogre Bodyguard 1
(-@GUID1,0,0,0,1,0,100,0,2000,2000,60000,60000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 0"),
(-@GUID1,0,1,0,1,0,100,0,10000,10000,60000,60000,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 2"),
(-@GUID1,0,2,0,1,0,100,0,18000,18000,60000,60000,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 4"),
(-@GUID1,0,3,0,1,0,100,0,26000,26000,60000,60000,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 6"),
(-@GUID1,0,4,0,1,0,100,0,34000,34000,60000,60000,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 8"),
(-@GUID1,0,5,0,1,0,100,0,42000,42000,60000,60000,0,1,10,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 10"),
(-@GUID1,0,6,0,4,0,30,0,0,0,0,0,0,1,11,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - On Aggro - Say Line 11"),
(-@GUID1,0,7,0,0,0,100,0,4000,6000,12000,16000,0,11,91050,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ogre Bodyguard - In Combat - Cast 'Bonk'"),
(-@GUID1,0,8,0,0,0,100,0,10000,12000,23000,25000,0,11,91053,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - In Combat - Cast 'Frenzy'"),
-- Ogre Bodyguard 2
(-@GUID2,0,0,0,1,0,100,0,6000,6000,60000,60000,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 1"),
(-@GUID2,0,1,0,1,0,100,0,14000,14000,60000,60000,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 3"),
(-@GUID2,0,2,0,1,0,100,0,22000,22000,60000,60000,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 5"),
(-@GUID2,0,3,0,1,0,100,0,30000,30000,60000,60000,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 7"),
(-@GUID2,0,4,0,1,0,100,0,34000,34000,60000,60000,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 8"),
(-@GUID2,0,5,0,1,0,100,0,38000,38000,60000,60000,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - Out of Combat - Say Line 9"),
(-@GUID2,0,6,0,4,0,30,0,0,0,0,0,0,1,11,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - On Aggro - Say Line 11"),
(-@GUID2,0,7,0,0,0,100,0,4000,6000,12000,16000,0,11,91050,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ogre Bodyguard - In Combat - Cast 'Bonk'"),
(-@GUID2,0,8,0,0,0,100,0,10000,12000,23000,25000,0,11,91053,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Bodyguard - In Combat - Cast 'Frenzy'");

DELETE FROM `creature_text` WHERE `CreatureID`=48262;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(48262,0,0,"Me da best bodyguard!",12,0,100,396,0,0,0,48523,0,"Ogre Bodyguard"),
(48262,1,0,"No, me!",12,0,100,396,0,0,0,48524,0,"Ogre Bodyguard"),
(48262,2,0,"Me got a board for hit things!",12,0,100,36,0,0,0,48525,0,"Ogre Bodyguard"),
(48262,3,0,"Mine gots a nail in it!",12,0,100,36,0,0,0,48526,0,"Ogre Bodyguard"),
(48262,4,0,"Mine gots a bigger nail!",12,0,100,15,0,0,0,48527,0,"Ogre Bodyguard"),
(48262,5,0,"Mine gots a RUSTY nail!",12,0,100,15,0,0,0,48528,0,"Ogre Bodyguard"),
(48262,6,0,"Dats dangerous.",12,0,100,396,0,0,0,48529,0,"Ogre Bodyguard"),
(48262,7,0,"Only for da bad guys.",12,0,100,396,0,0,0,48530,0,"Ogre Bodyguard"),
(48262,8,0,"%s laughs.",16,0,100,153,0,0,0,45054,0,"Ogre Bodyguard"),
(48262,9,0,"But I'm da best at watchin' da door!",12,0,100,396,0,0,0,48531,0,"Ogre Bodyguard"),
(48262,10,0,"No I am!",12,0,100,15,0,0,0,48532,0,"Ogre Bodyguard"),
(48262,11,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,0,1927,0,"Ogre Bodyguard"),
(48262,11,1,"I'll crush you!",12,0,100,0,0,0,0,1925,0,"Ogre Bodyguard"),
(48262,11,2,"Me smash! You die!",12,0,100,0,0,0,0,1926,0,"Ogre Bodyguard");

-- Defias Overseer
SET @GUID3 := 375905; -- Check this GUID
SET @GUID4 := 376021; -- Check this GUID
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48421;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-@GUID3,-@GUID4) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Defias Overseer 1
(-@GUID3,0,0,0,1,0,100,0,2000,2000,120000,120000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 0"),
(-@GUID3,0,1,0,1,0,100,0,13000,13000,120000,120000,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 2"),
(-@GUID3,0,2,0,1,0,100,0,23000,23000,120000,120000,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 4"),
(-@GUID3,0,3,0,1,0,100,0,31000,31000,120000,120000,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 6"),
(-@GUID3,0,4,0,1,0,100,0,38000,38000,120000,120000,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 8"),
-- Defias Overseer 2
(-@GUID4,0,0,0,1,0,100,0,9000,9000,120000,120000,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 1"),
(-@GUID4,0,1,0,1,0,100,0,18000,18000,120000,120000,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 3"),
(-@GUID4,0,2,0,1,0,100,0,27000,27000,120000,120000,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 5"),
(-@GUID4,0,3,0,1,0,100,0,35000,35000,120000,120000,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 7"),
(-@GUID4,0,4,0,1,0,100,0,43000,43000,120000,120000,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Overseer - Out of Combat - Say Line 9");

DELETE FROM `creature_text` WHERE `CreatureID`=48421;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(48421,0,0,"It's broken.",12,0,100,25,0,0,0,48628,0,"Defias Overseer"),
(48421,1,0,"It's not broken!",12,0,100,274,0,0,0,48629,0,"Defias Overseer"),
(48421,2,0,"Why's it shooting steam out of the side there, then?",12,0,100,6,0,0,0,48630,0,"Defias Overseer"),
(48421,3,0,"That's the...pressure release valve.",12,0,100,396,0,0,0,48631,0,"Defias Overseer"),
(48421,4,0,"In the middle of the pipe?",12,0,100,6,0,0,0,48632,0,"Defias Overseer"),
(48421,5,0,"Er...backup release valve?",12,0,100,6,0,0,0,48633,0,"Defias Overseer"),
(48421,6,0,"We should tell the Admiral.",12,0,100,396,0,0,0,48634,0,"Defias Overseer"),
(48421,7,0,"You tell him.",12,0,100,396,0,0,0,48636,0,"Defias Overseer"),
(48421,8,0,"No way!  He gives me the creeps!",12,0,100,274,0,0,0,48637,0,"Defias Overseer"),
(48421,9,0,"I know!  The way he looks at you with those hungry eyes.  I'm afraid to even turn my back!",12,0,100,5,0,0,0,48638,0,"Defias Overseer");

-- Kobold Digger
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48229;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48229 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48229,0,0,0,4,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kobold Digger - On Aggro - Say Line 0"),
(48229,0,1,0,0,0,100,0,4000,6000,8000,12000,0,11,89663,0,0,0,0,0,1,0,0,0,0,0,0,0,"Kobold Digger - In Combat - Cast 'Candle Blast'");

DELETE FROM `creature_text` WHERE `CreatureID`=48229;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(48229,0,0,"Yip! Me kill!",12,0,100,0,0,0,1920,0,"Kobold Digger"),
(48229,0,1,"Me no run from $C like you!",12,0,100,0,0,0,1921,0,"Kobold Digger"),
(48229,0,2,"You no take candle!",12,0,100,0,0,0,1868,0,"Kobold Digger");

-- Ogre Henchman
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48230;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48230 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48230,0,0,0,4,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Henchman - On Aggro - Say Line 0"),
(48230,0,1,0,0,0,100,0,4000,6000,11000,13000,0,11,91045,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ogre Henchman - In Combat - Cast 'Uppercut'"),
(48230,0,2,0,0,0,100,0,10000,10000,60000,60000,0,11,89652,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ogre Henchman - In Combat - Cast 'Ogrish Motivation'");

DELETE FROM `creature_text` WHERE `CreatureID`=48230;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(48230,0,0,"Raaar!!! Me smash $r!",12,0,100,0,0,0,1927,0,"Ogre Henchman"),
(48230,0,1,"Me smash! You die!",12,0,100,0,0,0,1926,0,"Ogre Henchman"),
(48230,0,2,"I'll crush you!",12,0,100,0,0,0,1925,0,"Ogre Henchman");

-- Mining Powder
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48284;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48284 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48284,0,0,1,32,0,100,1,1,1000000,0,0,0,11,89769,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Powder - On Damage Taken - Cast 'Explode' (No Repeat)"),
(48284,0,1,0,61,0,100,0,0,0,0,0,0,41,500,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Powder - On Damage Taken - Despawn (No Repeat)");

-- Goblin Overseer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48279;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48279 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48279,0,0,0,4,0,100,0,0,0,0,0,0,11,91034,0,0,0,0,0,1,0,0,0,0,0,0,0,"Goblin Overseer - On Aggro - Cast 'Threatening Shout'"),
(48279,0,1,0,0,0,100,0,3000,5000,8000,12000,0,11,91036,0,0,0,0,0,5,0,0,0,0,0,0,0,"Goblin Overseer - In Combat - Cast 'Motivate'");

-- Mining Monkey
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry` IN (48278,48440,48441,48442);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (48278,48440,48441,48442) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Mining Monkey (entry: 48278)
(48278,0,0,0,11,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Respawn - Set Rooted On"),
(48278,0,1,0,0,0,100,0,0,0,2000,4000,0,11,91038,64,0,0,0,0,2,0,0,0,0,0,0,0,"Mining Monkey - In Combat - Cast 'Throw'"),
(48278,0,2,3,8,0,100,1,90094,0,0,0,0,2,2263,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Faction 2263"),
(48278,0,3,4,61,0,100,0,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Rooted Off"),
(48278,0,4,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,25,20,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Start Attacking"),
-- Mining Monkey (entry: 48440)
(48440,0,0,0,11,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Respawn - Set Rooted On"),
(48440,0,1,0,0,0,100,0,0,0,2000,4000,0,11,91038,64,0,0,0,0,2,0,0,0,0,0,0,0,"Mining Monkey - In Combat - Cast 'Throw'"),
(48440,0,2,3,8,0,100,1,90094,0,0,0,0,2,2263,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Faction 2263"),
(48440,0,3,4,61,0,100,0,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Rooted Off"),
(48440,0,4,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,25,20,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Start Attacking"),
-- Mining Monkey (entry: 48441)
(48441,0,0,0,11,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Respawn - Set Rooted On"),
(48441,0,1,0,0,0,100,0,0,0,2000,4000,0,11,91038,64,0,0,0,0,2,0,0,0,0,0,0,0,"Mining Monkey - In Combat - Cast 'Throw'"),
(48441,0,2,3,8,0,100,1,90094,0,0,0,0,2,2263,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Faction 2263"),
(48441,0,3,4,61,0,100,0,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Rooted Off"),
(48441,0,4,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,25,20,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Start Attacking"),
-- Mining Monkey (entry: 48442)
(48442,0,0,0,11,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Respawn - Set Rooted On"),
(48442,0,1,0,0,0,100,0,0,0,2000,4000,0,11,91038,64,0,0,0,0,2,0,0,0,0,0,0,0,"Mining Monkey - In Combat - Cast 'Throw'"),
(48442,0,2,3,8,0,100,1,90094,0,0,0,0,2,2263,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Faction 2263"),
(48442,0,3,4,61,0,100,0,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Set Rooted Off"),
(48442,0,4,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,25,20,0,0,0,0,0,0,"Mining Monkey - On Spell Hit 'Go Bananas' - Start Attacking");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=90094;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,90094,0,0,31,0,3,48440,0,0,0,0,"","Spell 'Go Bananas' can only target creature 'Mining Monkey'"),
(13,1,90094,0,0,35,1,0,2,4,0,0,0,"","Spell 'Go Bananas' can only target closest creature 'Mining Monkey'"),
(13,1,90094,0,1,31,0,3,48278,0,0,0,0,"","Spell 'Go Bananas' can only target creature 'Mining Monkey'"),
(13,1,90094,0,1,35,1,0,2,4,0,0,0,"","Spell 'Go Bananas' can only target closest creature 'Mining Monkey'"),
(13,1,90094,0,2,35,1,0,2,4,0,0,0,"","Spell 'Go Bananas' can only target closest creature 'Mining Monkey'"),
(13,1,90094,0,2,31,0,3,48441,0,0,0,0,"","Spell 'Go Bananas' can only target creature 'Mining Monkey'"),
(13,1,90094,0,3,35,1,0,2,4,0,0,0,"","Spell 'Go Bananas' can only target closest creature 'Mining Monkey'"),
(13,1,90094,0,3,31,0,3,48442,0,0,0,0,"","Spell 'Go Bananas' can only target creature 'Mining Monkey'");

-- Mine Bunny
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48351;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48351 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48351,0,0,0,0,0,100,0,3000,5000,7000,9000,0,11,91032,0,0,0,0,0,5,0,0,0,0,0,0,0,"Mine Bunny - In Combat - Cast 'Drunken Haze'");

-- Oaf Lackey
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48445;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48445 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48445,0,0,0,4,0,100,0,0,0,0,0,0,11,90098,0,0,0,0,0,2,0,0,0,0,0,0,0,"Oaf Lackey - On Aggro - Cast 'Axe to the Head'"),
(48445,0,1,0,2,0,100,1,0,30,0,0,0,11,8599,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oaf Lackey - Between 0-30% Health - Cast Enrage (No Repeat)"),
(48445,0,2,0,2,0,100,1,0,30,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Oaf Lackey - Between 0-30% Health - Say Line 0 (No Repeat)");

DELETE FROM `creature_text` WHERE `CreatureID`=48445;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(48445,0,0,"%s goes into a frenzy!",16,0,100,0,0,0,2384,0,"Oaf Lackey");

-- Defias Miner
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48419;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48419 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48419,0,0,0,0,0,100,0,4000,6000,8000,12000,0,11,90994,0,0,0,0,0,5,0,0,0,0,0,0,0,"Defias Miner - In Combat - Cast 'Tunnel'"),
(48419,0,1,0,2,0,100,1,0,20,0,0,0,11,91009,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Miner - Between 0-20% Health - Cast 'Renegade Strength' (No Repeat)");

-- Defias Digger
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48420;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48420 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48420,0,0,0,0,0,100,0,4000,6000,8000,12000,0,11,90994,0,0,0,0,0,5,0,0,0,0,0,0,0,"Defias Digger - In Combat - Cast 'Tunnel'"),
(48420,0,1,0,2,0,100,1,0,20,0,0,0,11,91009,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Digger - Between 0-20% Health - Cast 'Renegade Strength' (No Repeat)");

-- Defias Envoker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48418;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48418 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4841800 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48418,0,0,0,0,0,100,0,2000,3000,5000,7000,0,11,91004,64,0,0,0,0,5,0,0,0,0,0,0,0,"Defias Envoker - In Combat - Cast 'Holy Fire'"),
(48418,0,1,0,11,0,100,0,0,0,0,0,0,11,92001,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Envoker - On Aggro - Cast 'Envoker's Shield'"),
(48418,0,2,0,60,0,100,0,5000,5000,25000,25000,0,80,4841800,2,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Envoker - Update - Run Script"),
(4841800,9,0,0,0,0,100,0,0,0,0,0,0,11,90047,0,0,0,0,0,19,48419,40,0,0,0,0,0,"Defias Envoker - On Script - Cast 'Renegade Strength'"),
(4841800,9,1,0,0,0,100,0,15000,15000,0,0,0,92,0,90047,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Envoker - On Script - Interrupt Spell");

-- Defias Enforcer
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48502;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48502 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48502,0,0,0,4,0,100,0,0,0,0,0,0,11,90928,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Enforcer - On Aggro - Cast 'Charge'"),
(48502,0,1,0,0,0,100,0,5000,7000,17000,19000,0,11,90929,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Enforcer - In Combat - Cast 'Recklessness'"),
(48502,0,2,0,2,0,100,0,0,40,8000,11000,0,11,90925,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Enforcer - Between 0-40% Health - Cast 'Bloodbath'");

-- Defias Blood Wizard
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48417;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48417 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48417,0,0,0,0,0,100,0,0,0,3000,5000,0,11,90938,64,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Blood Wizard - In Combat - Cast 'Bloodbolt'"),
(48417,0,1,0,0,0,100,0,5000,5000,35000,35000,0,11,90932,0,0,0,0,0,5,0,0,0,0,0,0,0,"Defias Blood Wizard - In Combat - Cast 'Ragezone'"),
(48417,0,2,0,16,0,100,0,90947,30,12000,14000,0,11,90947,0,0,0,0,0,7,0,0,0,0,0,0,0,"Defias Blood Wizard - On Friendly Missing Buff 'Bloodwash' - Cast 'Bloodwash'"),
(48417,0,3,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Blood Wizard - Between 0-15% Health - Flee For Assist (No Repeat)");

-- Defias Shadowguard
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48505;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48505 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48505,0,0,0,2,0,100,0,0,50,15000,18000,0,11,90958,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Shadowguard - Between 0-50% Health - Cast 'Evasion'"),
(48505,0,1,0,0,0,100,0,7000,9000,12000,14000,0,11,90956,0,0,0,0,0,5,0,0,0,0,0,0,0,"Defias Shadowguard - In Combat - Cast 'Shadowstep'"),
(48505,0,2,0,0,0,100,0,3000,5000,9000,11000,0,11,90951,2,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Shadowguard - In Combat - Cast 'Sinister Strike'"),
(48505,0,3,0,0,0,100,0,12000,14000,24000,28000,0,11,90960,2,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Shadowguard - In Combat - Cast 'Whirling Blades'"),
(48505,0,4,0,25,0,100,0,0,0,0,0,0,11,90954,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Shadowguard - On Reset - Cast 'Camouflage'");

-- Monstrous Parrot
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48447;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48447 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48447,0,0,0,0,0,100,0,3000,5000,16000,19000,0,11,90920,0,0,0,0,0,2,0,0,0,0,0,0,0,"Monstrous Parrot - In Combat - Cast 'Eye Peck'"),
(48447,0,1,0,0,0,100,0,7000,9000,9000,12000,0,11,90913,0,0,0,0,0,2,0,0,0,0,0,0,0,"Monstrous Parrot - In Combat - Cast 'Eye Gouge'");

-- Albino Eyegouger
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48448;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48448 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48448,0,0,0,0,0,100,0,3000,5000,16000,19000,0,11,90920,0,0,0,0,0,2,0,0,0,0,0,0,0,"Albino Eyegouger - In Combat - Cast 'Eye Peck'"),
(48448,0,1,0,0,0,100,0,7000,9000,9000,12000,0,11,90913,0,0,0,0,0,2,0,0,0,0,0,0,0,"Albino Eyegouger - In Combat - Cast 'Eye Gouge'");

-- Brilliant Macaw
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48449;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48449 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48449,0,0,0,0,0,100,0,3000,5000,16000,19000,0,11,90920,0,0,0,0,0,2,0,0,0,0,0,0,0,"Brilliant Macaw - In Combat - Cast 'Eye Peck'"),
(48449,0,1,0,0,0,100,0,7000,9000,9000,12000,0,11,90913,0,0,0,0,0,2,0,0,0,0,0,0,0,"Brilliant Macaw - In Combat - Cast 'Eye Gouge'");

-- Sunwing Squawker
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48450;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48450 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48450,0,0,0,0,0,100,0,3000,5000,16000,19000,0,11,90920,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sunwing Squawker - In Combat - Cast 'Eye Peck'"),
(48450,0,1,0,0,0,100,0,7000,9000,9000,12000,0,11,90913,0,0,0,0,0,2,0,0,0,0,0,0,0,"Sunwing Squawker - In Combat - Cast 'Eye Gouge'");

-- Ol' Beaky
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48451;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48451 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48451,0,0,0,0,0,100,0,3000,5000,16000,19000,0,11,90920,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ol' Beaky - In Combat - Cast 'Eye Peck'"),
(48451,0,1,0,0,0,100,0,7000,9000,9000,12000,0,11,90913,0,0,0,0,0,2,0,0,0,0,0,0,0,"Ol' Beaky - In Combat - Cast 'Eye Gouge'");

-- Defias Pirate
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48522;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48522 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48522,0,0,0,9,0,100,0,5,25,2000,2000,0,11,90905,0,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Pirate - Within 5-25 Range - Cast 'Leaping Cleave'");

-- Defias Squallshaper
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=48521;
DELETE FROM `smart_scripts` WHERE `entryorguid`=48521 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(48521,0,0,0,0,0,100,0,0,0,3000,5000,0,11,90398,64,0,0,0,0,2,0,0,0,0,0,0,0,"Defias Squallshaper - In Combat - Cast 'Seaswell'"),
(48521,0,1,0,14,0,100,4,200000,40,20000,30000,0,11,90914,0,0,0,0,0,7,0,0,0,0,0,0,0,"Defias Squallshaper - On Friendly Health Deficit - Cast 'Riptide'"),
(48521,0,2,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Defias Squallshaper - Between 0-15% Health - Flee For Assist (No Repeat)");