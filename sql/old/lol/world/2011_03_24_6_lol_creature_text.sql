-- Fix for Quests 12203 'Loken's Orders' and 12185 'Put On Your Best Face For Loken'
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=188596;
DELETE FROM `smart_scripts` WHERE `entryorguid`=188596;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(188596,1,0,0,64,0,100,0,0,0,0,0,80,18859600,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Lokens Pedistal - Start Script'),
(18859600,9,0,0,0,0,100,0,2000,2000,0,0,12,27212,1,32000,0,0,0,8,0,0,0,3404.76,-5394.60,270.19,1.2, 'Summon Immage of Loken'),
(18859600,9,1,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,11,27212,10,0,0,0,0,0, 'Immage of Loken - Speach 1'),
(18859600,9,2,0,0,0,100,0,2000,2000,0,0,1,1,0,0,0,0,0,11,27212,10,0,0,0,0,0, 'Immage of Loken - Speach 2'),
(18859600,9,3,0,0,0,100,0,7000,7000,0,0,1,2,0,0,0,0,0,11,27212,10,0,0,0,0,0, 'Immage of Loken - Speach 3'),
(18859600,9,4,0,0,0,100,0,6000,6000,0,0,1,3,0,0,0,0,0,11,27212,10,0,0,0,0,0, 'Immage of Loken - Speach 4'),
(18859600,9,5,0,0,0,100,0,7000,7000,0,0,1,4,0,0,0,0,0,11,27212,10,0,0,0,0,0, 'Immage of Loken - Speach 5'),
(18859600,9,6,0,0,0,100,0,0,0,0,0,33,27212,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Lokens Pedistal - Quest Credit');

DELETE FROM `creature_text` WHERE `entry`=27212;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27212,0,0, 'You\'re late, overseer.',0,0,100,25,0,0, 'Image of Loken'),
(27212,1,0, 'Destiny will not wait. Your craftsmen must increase their production of the war golems before the stone giant leader and his army reach Ulduar.',0,0,100,25,0,0, 'Image of Loken'),
(27212,2,0, 'Tell your rune-smiths to continue converting what stone giants you can. Those that will not submit must be destroyed.',0,0,100,25,0,0, 'Image of Loken'),
(27212,3,0, 'If the stone giants interfere with our work at Ulduar, I will hold you and your thane responsible. Mortal must not be allowed to come to the aid of the giants. ',0,0,100,25,0,0, 'Image of Loken'),
(27212,4,0, 'Return to your duties, overseer. Be certain to impress upon your workers the urgency of their tasks.',0,0,100,25,0,0, 'Image of Loken');
