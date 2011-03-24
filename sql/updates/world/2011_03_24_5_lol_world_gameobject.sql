-- Quest 11416, 11417 Eyes of the eagle
DELETE FROM `gameobject` WHERE `id` IN (186814,190283);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(42458,186814,571,1,1,1597.404,-3903.790,79.702,0,0,0,0,0,60,100,1),
(42459,190283,571,1,1,1597.404,-3903.790,79.702,0,0,0,0,0,60,100,1);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry` IN(186814,190283);
UPDATE `creature_template` SET `AIName`='SmartAI', `speed_walk`=3.5, `InhabitType`=7 WHERE `entry`=24518;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (186814,190283,24518);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Talonshrike's egg script
(186814,1,0,0,64,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,24518,100,0,0,0,0,0, 'On egg use notify Talonshrike'),
(190283,1,0,0,64,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,24518,100,0,0,0,0,0, 'On egg use notify Talonshrike'),
-- Talonshrike script
(24518,0,0,0,38,0,100,0,0,1,0,0,69,0,0,0,0,0,0,8,0,0,0,1597.404,-3903.790,79.702,0, 'On notification fly to nest'),
(24518,0,1,0,0,0,100,0,5000,5000,10000,12000,11,49865,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Use Eye Peck'),
(24518,0,2,0,0,0,100,0,3000,3000,5000,7000,11,32909,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Use Talon Strike');