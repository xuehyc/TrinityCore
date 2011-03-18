-- QUEST 12261 "No Place to Run"
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=27430;

DELETE FROM `creature_text` WHERE `entry` IN (27430);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27430,0,0, 'The %s gains in power.',2,0,100,0,0,0, 'Destructive Ward power up'),
(27430,1,0, 'The %s is fully charged up.',2,0,100,0,0,0, 'Destructive Ward fully charged');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27430,2743000); 	
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(27430,0,0,0,54,0,100,0,0,0,0,0,80,2743000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On summon run script'),
(2743000,9,0,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,1,0,60,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Power up'),
(2743000,9,2,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,3,0,60,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Power up'),
(2743000,9,4,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,5,0,60,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Power up'),
(2743000,9,6,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,7,0,60,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Fully charged'),
(2743000,9,8,0,60,0,100,0,2000,2000,0,0,11,52409,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Give quest credit'),
(2743000,9,9,0,60,0,100,0,1000,1000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn');
