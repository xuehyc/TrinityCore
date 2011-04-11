-- QUEST 11322 "The cleansing"
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=186649;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_H`=14, `faction_A`=14 WHERE `entry`=27959;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27959,186649,2795900,18664900);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Frostblade Shrine script
(186649,1,0,0,64,0,100,0,0,0,0,0,80,18664900,0,2,0,0,0,1,0,0,0,0,0,0,0, 'On Frostblade Shrine use start script'),
(18664900,9,0,0,0,0,100,0,0,0,0,0,75,43351,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Cast Cleansing Soul on player'),
(18664900,9,1,0,0,0,100,0,10000,10000,0,0,85,50167,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Summon Inner Turmoil'),
-- Inner Turmoil script
(27959,0,0,1,54,0,100,0,0,0,0,0,85,50218,0,0,0,0,0,1,0,0,0,0,0,0,0,'On spawn copy the invoker'),
(27959,0,1,0,61,0,100,0,0,0,0,0,80,2795900,0,2,0,0,0,1,0,0,0,0,0,0,0,'Start script'),
(27959,0,2,0,2,0,100,0x01,0,50,0,0,1,2,0,0,0,0,0,7,0,0,0,0,0,0,0,'On 50% HP wisper text 2'),
(27959,0,3,4,6,0,100,0,0,0,0,0,1,3,0,0,0,0,0,7,0,0,0,0,0,0,0,'On death wisper text 3'),
(27959,0,4,0,61,0,100,0,0,0,0,0,75,50237,0,0,0,0,0,7,0,0,0,0,0,0,0,'Apply Slow Fall'),
(2795900,9,0,0,0,0,100,0,0,0,0,0,18,131072,0,0,0,0,0,1,0,0,0,0,0,0,0,'Set unit_flags'),
(2795900,9,1,0,0,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Disable movement'),
(2795900,9,2,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Wisper text 0'),
(2795900,9,3,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Wisper text 1'),
(2795900,9,4,0,0,0,100,0,6000,6000,0,0,19,131072,0,0,0,0,0,1,0,0,0,0,0,0,0,'Remove unit_flags'),
(2795900,9,5,0,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Enable movement');

DELETE FROM `creature_text` WHERE `entry`=27959;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27959,0,0,'You think that you can get rid of me through meditation?',4,0,100,1,0,0,'Inner Turmoil text 0'),
(27959,1,0,'Fool! I will destroy you and finally become that which has been building inside of you all of these years!',4,0,100,1,0,0,'Inner Turmoil text 1'),
(27959,2,0,'You cannot defeat me. I''m an inseparable part of you!',4,0,100,1,0,0,'Inner Turmoil text 50%'),
(27959,3,0,'NOOOOOOOoooooooooo!',4,0,100,1,0,0,'Inner Turmoil text death');

DELETE FROM `gameobject` WHERE `guid` IN (87584,87585);