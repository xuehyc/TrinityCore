-- fix - duskhaven questobject 196394 in phase 181

DELETE FROM `gameobject` WHERE `id`=196394;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (51003240, 196394, 654, 0, 0, 1, 0, 0, 385, -1, -1926.27, 2408.62, 30.0234, 5.44543, 0, 0, -0.406736, 0.913545, 200, 255, 1, 0, '', 26365);

-- fix - black gunpowder keg in phase 182

DELETE FROM `gameobject` WHERE `id`=196403;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(51003243, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1904.02, 2312.95, 39.607, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003245, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1941.55, 2252.75, 35.7991, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003246, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1931.98, 2245.92, 35.8118, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003247, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1898.46, 2384.36, 30.1194, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003248, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1987.77, 2304.11, 30.5889, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003249, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1961.19, 2370.83, 29.094, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003250, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -2007.88, 2287.72, 29.4369, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003251, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1942.48, 2404.08, 30.0043, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003252, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1978.85, 2383.12, 25.1076, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 26365),
(51003253, 196403, 654, 4714, 4786, 1, 0, 182, 0, -1, -1931.51, 2407.5, 29.977, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365);

-- fix - granda's good clothes 196472 to phase 183

DELETE FROM `gameobject` WHERE `guid`=51003260;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(51003260, 196472, 654, 4714, 5720, 3, 0, 183, 385, -1, -2116.14, 2431.93, 13.0241, 3.25506, 0, 0, -0.998391, 0.0567021, 200, 255, 1, 0, '', 26365);

-- fix - linen wraped book 196473 add and phase 183

DELETE FROM `gameobject` WHERE `guid`=51003230;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(51003230, 196473, 654, 4714, 5720, 3, 0, 183, 385, -1, -2156.559, 2371.467, 10.88052, 1.658062, 0, 0, 0.737277, 0.6755905, 200, 255, 1, 0, '', 27547);

-- fix - add objects for quest 14404 not-quite-shipshape

DELETE FROM `gameobject` WHERE `guid` IN (51003220, 51003221, 51003222);
INSERT INTO `gameobject` 
(`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(51003220, 196810, 654, 4714, 4808, 3, 0, 183, 385, -1, -2361.653, 2261.066, 2.320014, 0.8377575, 0, 0, 0.4067364, 0.9135455, 200, 255, 1, 0, '', 27547), 
(51003221, 196809, 654, 4714, 4808, 3, 0, 183, 385, -1, -2347.024, 2304.012, 0.37202, 0, 0, 0, 0, 1, 200, 255, 1, 0, '', 27547),
(51003222, 196808, 654, 4714, 4808, 3, 0, 183, 385, -1, -2337.033, 2257.335, 0.328134, 0, 0, 0, 0, 1, 200, 255, 0, 0, '', 27547);

