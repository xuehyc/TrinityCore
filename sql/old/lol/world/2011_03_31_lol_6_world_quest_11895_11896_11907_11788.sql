-- Quest 11895 "Master the Storm", Quest 11896 "Weakness to Lightning", Quest 11907 "The Sub-Chieftains" and Quest 11788 "Lefty Loosey, Righty Tighty"
DELETE FROM `creature` WHERE `id`=26048;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(107478,26048,571,1,1,16988,0,3410.110,4128.981,18.054,5.699,60,0,0,8982,3155,0,0,0,0,0);

DELETE FROM `gameobject` WHERE `id` IN (188109,187987);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(188898,187987,571,1,1,3793.746,4805.559,-12.185,5.667,0,0,0,1,300,100,1),
(188899,188109,571,1,1,3791.950,4804.803,-12.158,4.571,0,0,0,1,300,100,1);

UPDATE `creature_template` SET `AIName`='SmartAI', `npcflag`=`npcflag` | 16777216 WHERE `entry`=26048;
UPDATE `creature_template` SET `unit_flags`=4, `AIName`='SmartAI' WHERE `entry`=26045;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25752;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25753;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25758;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25792;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=26048;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(26048,74772,11895,1,0,0,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26048,2604800,26045,25752,25753,25758,25792);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26048,0,0,0,8,0,100,0,74772,0,0,0,80,2604800,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit start script'),
(2604800,9,0,0,60,0,100,0,0,0,0,0,12,26045,1,60000,0,1,0,8,0,0,0,3399.917,4135.566,18.054,5.699, 'Summon Storm Tempest'),
(2604800,9,1,0,60,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn'),
(26045,0,0,0,25,0,100,0,0,0,0,0,11,35487,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On summon Storm Tempest cast Lightning Cloud'),
(26045,0,1,0,4,0,100,0,0,0,60000,60000,1,0,0,0,0,0,0,2,0,0,0,0,0,0,0, 'On aggro Storm Tempest say text'),
(26045,0,2,0,0,0,100,0,0,0,4000,5000,11,15659,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Storm Tempest cast Chain Lightning'),
(26045,0,3,0,0,0,50,0,0,0,3000,4000,11,31272,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Storm Tempest cast Wind Shock'),
(26045,0,4,0,6,0,100,0,0,0,0,0,85,46424,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On death apply Master the Storm'),
(25752,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25752,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25752,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25753,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25753,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25753,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25758,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25758,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25758,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25792,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25792,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25792,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura');

DELETE FROM `creature_text` WHERE `entry`=26045;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26045,0,0,'You will not defeat me, puny $R!',0,0,100,0,0,0, 'Storm Tempest text');

DELETE FROM `spell_scripts` WHERE `id` IN (46550);
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(46550,0,0,14,46424,0,0,0,0,0,0);