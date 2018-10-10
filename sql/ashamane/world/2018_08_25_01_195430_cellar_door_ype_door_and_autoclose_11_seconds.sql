-- fix - 195430 cellar door type door and autoclose 11 seconds
DELETE FROM `gameobject` WHERE `guid`=20406504;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (20406504, 195430, 654, 4755, 4756, 1, 0, 0, 379, -1, -1790.04, 1435.53, 21.7363, 1.66817, -0.0106378, 0.0138349, 0.740533, 0.671794, 120, 255, 1, 0, '', 25383);
DELETE FROM `gameobject_addon` WHERE `guid`=20406504;
INSERT INTO `gameobject_addon` (`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`, `WorldEffectID`) 
VALUES (20406504, 0, 0, 0.942641, -0.333807, 0, 0, 0);
UPDATE `gameobject_template` SET  `Data0`=0 AND `Data1`=0 AND `Data2`=11000  WHERE entry=195430;
