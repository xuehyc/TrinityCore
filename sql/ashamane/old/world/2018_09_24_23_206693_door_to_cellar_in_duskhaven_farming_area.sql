-- fix - 206693 door to cellar in duskhaven farming area open in phase 182 and 183
DELETE FROM `gameobject` WHERE `guid`=20406565;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(20406565, 206693, 654, 4755, 4756, 1, 0, 0, 439, -1, -1880.47, 2545.83, 3.08704, 3.82227, 0.019753, 0.00699425, -0.942434, 0.333734, 120, 255, 0, 0, '', 25383);
