-- Quest 11324, 11326 "Alpha Worg"
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_H`=14, `faction_A`=14 WHERE `entry`=24277;
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id`=24210; -- Riven Widow Cocoons disable random movement

DELETE FROM `creature_addon` WHERE `guid`=199999;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(199999,1999990,0,0,0,0,'49415 0'); -- Invisibility and waypoint asignment

DELETE FROM `creature` WHERE `id`=24277;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(199999,24277,571,1,1,22233,0,2461.043,-3099.657,141.533,5.812,300,0,0,13936,0,0,2,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=24277;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24277,0,0,0,0,0,100,0,2000,4000,10000,12000,11,50046,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Gnaw Bone'),
(24277,0,1,0,0,0,100,0,1000,3000,15000,18000,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Rend'),
(24277,0,2,0,0,0,100,0,1500,2500,4000,6000,11,31279,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Swipe'),
(24277,0,3,0,0,0,100,0,10000,12000,20000,25000,11,6749,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Wide Swipe'),
(24277,0,4,5,2,0,100,0x01,0,50,0,0,3,0,26791,0,0,0,0,1,0,0,0,0,0,0,0,'Below 50% transform to worgen model'),
(24277,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Say text Garwal');

DELETE FROM `waypoint_data` WHERE `id`=1999990;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(1999990,1,2461.043,-3099.657,141.533,0,0,0,100,0),
(1999990,2,2502.133,-3097.822,134.418,0,0,0,100,0),
(1999990,3,2559.702,-3097.267,121.556,0,0,0,100,0),
(1999990,4,2622.817,-3088.243,120.314,0,0,0,100,0),
(1999990,5,2638.738,-3096.804,121.635,0,0,0,100,0),
(1999990,6,2696.031,-3118.550,110.453,0,0,0,100,0),
(1999990,7,2744.101,-3110.267,115.296,0,0,0,100,0),
(1999990,8,2774.326,-3109.235,111.222,0,0,0,100,0),
(1999990,9,2797.473,-3106.683,110.129,0,0,0,100,0),
(1999990,10,2831.518,-3105.365,100.868,0,0,0,100,0),
(1999990,11,2847.851,-3089.628,91.186,0,0,0,100,0),
(1999990,12,2874.736,-3063.742,85.386,0,0,0,100,0),
(1999990,13,2872.254,-3045.130,82.085,0,0,0,100,0),
(1999990,14,2867.529,-3020.512,84.268,0,0,0,100,0),
(1999990,15,2811.413,-3018.185,88.837,0,0,0,100,0),
(1999990,16,2772.952,-3014.391,92.935,0,0,0,100,0),
(1999990,17,2700.462,-2996.456,92.247,0,0,0,100,0),
(1999990,18,2666.411,-2986.375,96.447,0,0,0,100,0),
(1999990,19,2649.578,-2979.369,95.366,0,0,0,100,0),
(1999990,20,2598.768,-2987.893,109.434,0,0,0,100,0),
(1999990,21,2560.210,-2988.716,111.262,0,0,0,100,0),
(1999990,22,2526.068,-3031.698,121.382,0,0,0,100,0),
(1999990,23,2501.948,-3041.872,126.281,0,0,0,100,0),
(1999990,24,2477.311,-3053.944,138.013,0,0,0,100,0),
(1999990,25,2467.604,-3071.109,141.345,0,0,0,100,0);

DELETE FROM `creature_text` WHERE `entry`=24277;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(24277,0,0,'Enough of this charade!',1,0,100,0,0,0,'Garwal morph text');

DELETE FROM `spell_scripts` WHERE `id`=50103;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(50103,0,0,14,43060,1,0,0,0,0,0); -- Remove Eyes of the Eagle on quest turn in


DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (43682,50104);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(43682,43060,1,'Apply Eyes of the Eagle'),
(50104,50103,1,'Remove Eyes of the Eagle');

UPDATE `quest_template` SET `SrcSpell`=43682 WHERE `entry` IN (11324,11326);