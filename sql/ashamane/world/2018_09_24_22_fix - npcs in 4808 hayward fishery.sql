-- fix - max level for npc 36488 forsaken castaway

UPDATE creature_template SET maxlevel=12 WHERE entry=36488;

-- fix - duplicate npcs in 4808 hayward fishery

DELETE FROM `creature` WHERE `guid`=801930;
DELETE FROM `creature` WHERE `guid`=801935;
DELETE FROM `creature` WHERE `guid`=801944;
DELETE FROM `creature` WHERE `guid`=801932;
DELETE FROM `creature` WHERE `guid`=801943;
DELETE FROM `creature` WHERE `guid`=801934;
DELETE FROM `creature` WHERE `guid`=801939;
DELETE FROM `creature` WHERE `guid`=801933;
DELETE FROM `creature` WHERE `guid`=801936;
DELETE FROM `creature` WHERE `guid`=801941;
DELETE FROM `creature` WHERE `guid`=801940;
DELETE FROM `creature` WHERE `guid`=801937;

DELETE FROM `creature_addon` WHERE `guid`=801930;
DELETE FROM `creature_addon` WHERE `guid`=801935;
DELETE FROM `creature_addon` WHERE `guid`=801944;
DELETE FROM `creature_addon` WHERE `guid`=801932;
DELETE FROM `creature_addon` WHERE `guid`=801943;
DELETE FROM `creature_addon` WHERE `guid`=801934;
DELETE FROM `creature_addon` WHERE `guid`=801939;
DELETE FROM `creature_addon` WHERE `guid`=801933;
DELETE FROM `creature_addon` WHERE `guid`=801936;
DELETE FROM `creature_addon` WHERE `guid`=801941;
DELETE FROM `creature_addon` WHERE `guid`=801940;
DELETE FROM `creature_addon` WHERE `guid`=801937;

-- fix - corect area added for npcs in area 4808 hayward fishery

DELETE FROM `creature` WHERE `guid`=801907;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801907, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2317.77, 2320.37, 2.61017, 4.86947, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801909;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801909, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2308.17, 2288.2, 0.257101, 5.63615, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801911;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801911, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2306.66, 2289.37, 0.201157, 5.10943, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801912;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801912, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2308.91, 2285.9, 0.332749, 0.0242409, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801915;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801915, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2303.49, 2271.79, 0.0961541, 5.54674, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801916;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801916, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2309.84, 2279.13, 0.412626, 6.17889, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801917;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801917, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2304.24, 2270.52, 0.108939, 5.9507, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801919;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801919, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2341.83, 2307.64, 0.51961, 5.63741, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
DELETE FROM `creature` WHERE `guid`=801921;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (801921, 36488, 654, 4714, 4808, 3, 0, 183, 0, -1, 0, 0, -2350.44, 2277.98, 0.408028, 0.593412, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);
