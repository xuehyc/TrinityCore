-- test - duskhaven to graymane mannor gameobjects

DELETE FROM `gameobject` WHERE `guid`=20406515;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (20406515, 196399, 654, 4714, 4756, 1, 0, 0, 385, -1, -1817.84, 2333.37, 36.3445, 3.79899, 0, 0, -0.946463, 0.322813, 120, 255, 1, 0, '', 25383);
DELETE FROM `gameobject_template_addon` WHERE `entry`=196399;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`, `WorldEffectID`) 
VALUES (196399, 0, 6, 0, 0, 0);

DELETE FROM `gameobject` WHERE `guid`=20406513;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (20406513, 196412, 654, 4755, 4756, 1, 0, 0, 385, -1, -1872.92, 2073.58, 89.1548, 1.54751, 0, 0, 0.698826, 0.715292, 120, 255, 1, 0, '', 25383);
DELETE FROM `gameobject_template_addon` WHERE `entry`=196412;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`, `WorldEffectID`) 
VALUES (196412, 0, 6, 0, 0, 0);

DELETE FROM `gameobject` WHERE `guid`=20406509;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (20406509, 196401, 654, 4755, 4756, 1, 0, 0, 385, -1, -1681.84, 2507.57, 97.7786, 3.93862, 0, 0, -0.921639, 0.388047, 120, 255, 1, 0, '', 25383);
DELETE FROM `gameobject_template_addon` WHERE `entry`=196401;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`, `WorldEffectID`) 
VALUES (196401, 0, 6, 0, 0, 0);

DELETE FROM `gameobject` WHERE `guid`=51003228;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (51003228, 196880, 654, 4714, 4786, 1, 0, 0, 385, -1, -1865.89, 2232.71, 42.3229, 5.37562, 0, 0, -0.43837, 0.898795, 7200, 255, 1, 0, '', 26365);

DELETE FROM `gameobject` WHERE `guid`=51003227;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (51003227, 196879, 654, 4714, 4786, 1, 0, 0, 385, -1, -1869.11, 2229.79, 42.3233, 1.72787, 0, 0, 0.760405, 0.649449, 7200, 255, 1, 0, '', 26365);

DELETE FROM `gameobject` WHERE `guid`=51003225;


