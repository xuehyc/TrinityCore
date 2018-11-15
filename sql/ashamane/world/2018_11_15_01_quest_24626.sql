-- https://www.wowhead.com/quest=24626/young-and-vicious
-- https://www.wowhead.com/item=50053/bloodtalon-lasso  
-- https://www.wowhead.com/spell=70927/raptor-rope		

-- https://www.wowhead.com/npc=38002/swiftclaw
UPDATE `creature_template` SET `AIName`='SmartAI', `flags_extra`=128 WHERE `entry`=38002;
DELETE FROM `creature` WHERE `guid`=280000117;
INSERT INTO `creature`(`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(280000117, 38002, 1, 0, 0, 0, 0, 0, 0, -1, 0, 0, -1282.06, -5454.94, 14.534, 3.2009, 300, 0, 0, 87, 0, 0, 16777218, 0, 0, 0, 0, 0, '');

-- Swiftclaw SAI 38002
DELETE FROM `smart_scripts` WHERE `entryorguid`=38002;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,
`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(38002,0,0,1,10,0,100,0,1,30,0,0,33,38002,0,0,0,0,0,18,20,0,0,0,0,0,0,'Swiftclaw - Event OOC LOS - Kill Credit 38002 Quest 24626'),
(38002,0,1,2,61,0,100,0,0,0,0,0,41,5000,0,0,0,0,0,11,37989,30,0,0,0,0,0,'Despawn Swiftclaw 10 secs in 30 yards'),
(38002,0,2,3,0,0,100,0,0,0,0,0,12,37989,6,100,0,0,0,8,0,0,0,-1613.27,-5379.43,1.49129,1.34578,'Summon Swiftclaw 37989');

-- https://www.wowhead.com/npc=37989/swiftclaw
UPDATE `creature_template` SET `npcflag` = 16777216 WHERE `entry`=37989;
UPDATE `creature_template_addon` SET `path_id`=379890, `auras`='' WHERE `entry`=37989;
DELETE FROM `creature_queststarter` WHERE `id`=37989 AND `quest`=24626;

-- Swiftclaw SAI 37989
DELETE FROM `smart_scripts` WHERE `entryorguid`=37989;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,
`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37989,0,0,0,73,0,100,512,0,0,0,0,11,70943,0,0,0,0,0,7,0,0,0,0,0,0,0,''),	
(37989,0,1,0,1,0,100,512,1000,1000,1000,1000,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'');	

-- Waypoint Data for Swiftclaw
DELETE FROM `waypoint_data` WHERE `id`=379890;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(379890,  1, -1612.48, -5352.93, 4.65875, 0, 0, 1, 0, 100, 0),
(379890,  2, -1608.73, -5337.01, 6.85531, 0, 0, 1, 0, 100, 0),
(379890,  3, -1604.20, -5325.97, 6.28620, 0, 0, 1, 0, 100, 0),
(379890,  4, -1580.95, -5296.14, 8.39253, 0, 0, 1, 0, 100, 0),
(379890,  5, -1572.17, -5284.74, 8.21174, 0, 0, 1, 0, 100, 0),
(379890,  6, -1553.30, -5297.28, 9.10978, 0, 0, 1, 0, 100, 0),
(379890,  7, -1556.17, -5321.02, 7.75006, 0, 0, 1, 0, 100, 0),
(379890,  8, -1572.56, -5343.27, 6.80740, 0, 0, 1, 0, 100, 0),
(379890,  9, -1584.71, -5362.15, 4.28742, 0, 0, 1, 0, 100, 0),
(379890, 10, -1599.52, -5373.36, 1.73533, 0, 0, 1, 0, 100, 0),
(379890, 11, -1608.75, -5379.53, 1.01366, 0, 0, 1, 0, 100, 0);

-- https://www.wowhead.com/npc=38988/notera
UPDATE `creature_template` SET `gossip_menu_id`='' WHERE `entry`=38988;
DELETE FROM `smart_scripts` WHERE `entryorguid`=38988;
DELETE FROM `gossip_menu_option` WHERE `MenuId`=38988;
