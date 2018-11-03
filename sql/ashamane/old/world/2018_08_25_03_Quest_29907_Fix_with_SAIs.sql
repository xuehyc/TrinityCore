-- Quest 29907
-- Chen Stormstout 56133 (questgiver)
-- Chen Stormstout 56343 (objetive)
-- Li Li 56344
UPDATE `creature` SET `spawntimesecs`=15 WHERE `id` in (56133,56344);

-- Chen Stormstout 56133 (questgiver) SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=56133;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (56133);
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,
`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(56133,0,0,1,19,0,100,0,29907,0,100,100,12,56343,6,100,0,0,0,8,0,0,0,519.149048,-695.134277,247.259842,4.42429,'On quest 29907 accepted - Summon Chen Stormstout 56343'),
(56133,0,1,2,19,0,100,0,29907,0,100,100,41,100,0,0,0,0,0,11,56344,30,0,0,0,0,0,'Despawn Li Li in 30 yards'),
(56133,0,2,3,19,0,100,0,29907,0,100,100,12,56344,6,100,0,0,0,8,0,0,0,520.813965,-700.552063,247.244476,3.47318,'Summon Li Li 56344'),
(56133,0,3,4,19,0,100,0,29907,0,100,100,41,100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Despawn Chen Stormstout 56133');

-- Chen Stormstout 56343 (objetive)) SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=56343;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (56343,563430);
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,
`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(56343,0,1,2,25,0,100,0,0,0,3000,3000,53,1,563430,0,0,0,0,7,0,0,0,0,0,0,0,'Chen Stormstout - on just summoned - start WP'),
(56343,0,2,3,40,0,100,0,4,0,0,0,54,35000,0,0,0,0,0,7,0,0,0,0,0,0,0,'Chen Stormstout - on waypoint 4 - wp pause 35 secs'),
(56343,0,3,4,40,0,100,0,4,0,0,0,33,56343,0,0,0,0,0,18,20,0,0,0,0,0,0, 'Chen Stormstout - on wp 4 reached - Kill credit 56343 quest 29907'),
(56343,0,4,0,40,0,100,0,4,0,0,0,80,563430,2,0,0,0,0,1,0,0,0,0,0,0,0,'Chen Stormstout - on wp 4 - run event script'),
(563430,9,0,0,1,0,100,0,1000,1000,0,0,1,0,1000,0,0,0,0,1,0,0,0,0,0,0,0,'Chen Stormstout - say text0'),
(563430,9,1,0,1,0,100,0,5000,5000,0,0,1,1,1000,0,0,0,0,1,0,0,0,0,0,0,0,'Chen Stormstout - say text1'),
(563430,9,2,0,1,0,100,0,10000,10000,0,0,1,0,1000,0,0,0,0,11,56204,30,0,0,0,0,0,'Pang Thunderfoot - say text0'),
(563430,9,3,0,1,0,100,0,10000,10000,0,0,1,2,1000,0,0,0,0,1,0,0,0,0,0,0,0,'Chen Stormstout - say text2'),
(563430,9,4,0,1,0,100,0,5000,5000,0,0,1,3,1000,0,0,0,0,1,0,0,0,0,0,0,0,'Chen Stormstout - say text3'),
(563430,9,5,0,1,0,100,0,5000,5000,0,0,17,13,0,0,0,0,0,1,0,0,0,0,0,0,0,'Chen Stormstout - on wp 7 reached - plays the sit emote'),
(563430,9,6,0,1,0,100,0,1000,1000,0,0,1,1,1000,0,0,0,0,11,56344,30,0,0,0,0,0,'Chen Stormstout - on wp 7 reached - Li Li say text0'),
(563430,9,7,0,1,0,100,0,1000,1000,60000,60000,17,5,0,0,0,0,0,11,56344,30,0,0,0,0,0,'Chen Stormstout - Li Li plays the exclamation emote'),
(563430,9,8,0,61,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,11,56344,30,0,0,0,0,0,'Despawn Li Li in 10 secs in 30 yards'),
(563430,9,9,0,61,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Despawn in 1 secs Chen Stormstout');


-- Chen Stormstout 56343 Waypoint 
DELETE FROM `waypoints` WHERE `entry`=563430 or `entry`=5634300;
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(563430,1,519.149048,-695.134277,247.259842,'Chen Stormstout waypoint 1'),
(563430,2,529.228516,-692.409607,247.885727,'Chen Stormstout waypoint 2'),
(563430,3,536.906494,-612.810913,258.635681,'Chen Stormstout waypoint 3'),
(563430,4,542.859436,-608.191833,262.795197,'Chen Stormstout waypoint 4'),
(563430,5,535.393250,-611.821472,258.609497,'Chen Stormstout waypoint 5'),
(563430,6,535.21891,-600.938538,258.393097,'Chen Stormstout waypoint 6'),
(563430,7,534.207825,-602.059204,258.394226,'Chen Stormstout waypoint 7');


-- Chen Stormstout 56343 creature_text
DELETE FROM `creature_text` WHERE `CreatureID`=56343;
INSERT INTO `creature_text` (`CreatureID`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(56343,0,0,'I''m called Chen, and this is my niece, Li Li.',12,0,100,0,0,0,'Chen Stormstout'),
(56343,1,0,'May we stay here at your farmhouse for a while? We do not have much in the way of money, but I will gladly share some of my famous ale with you.',12,0,100,0,0,0,'Chen Stormstout'),
(56343,2,0,'Thanks you! We will not trouble you for long.',12,0,100,0,0,0,'Chen Stormstout'),
(56343,3,0,'Interesting, He does not like beer?, A very strange Land, indeed.',12,0,100,0,0,0,'Chen Stormstout');

-- Pang Thunderfoot 56204 creature_text
DELETE FROM `creature_text` WHERE `CreatureID`=56204;
INSERT INTO `creature_text` (`CreatureID`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(56204,0,0,'Greetings, Chen, Li li. You may stay, but I do not need any of your ale.',12,0,100,0,0,0,'Pang Thunderfoot');


-- Li Li 56344 SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=56344;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (56344);
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,
`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(56344,0,0,1,25,0,100,0,0,0,3000,3000,53,1,563440,0,0,0,0,7,0,0,0,0,0,0,0,'Li Li - on just summoned - start WP'),
(56344,0,1,0,61,0,100,1,0,0,100,100,1,0,1000,0,0,0,0,1,0,0,0,0,0,0,0,'Li Li - say text0');

-- Li Li 56344 Waypoint 
DELETE FROM `waypoints` WHERE `entry`=563440;
INSERT INTO `waypoints`(`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(563440,1,520.813965,-700.552063,247.244476,'Li Li waypoint 1'),
(563440,2,535.426880,-675.629578,251.910065,'Li Li waypoint 2'),
(563440,3,527.343018,-616.624390,258.723083,'Li Li waypoint 3');


-- Li Li 56344 creature_text
DELETE FROM `creature_text` WHERE `creatureID`=56344;
INSERT INTO `creature_text` (`creatureID`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(56344,0,0,'Finally!',12,0,100,0,0,0,'Li Li'),
(56344,1,0,'Really, uncle? We''are stoping already? We only moved, like, ten feet?',12,0,100,0,0,0,'Li Li');