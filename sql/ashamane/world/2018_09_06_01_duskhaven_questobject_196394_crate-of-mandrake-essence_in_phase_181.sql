-- fix - duskhaven questobject 196394 in phase 181

DELETE FROM `gameobject` WHERE `guid`=51003240;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (51003240, 196394, 654, 0, 0, 1, 0, 181, 0, -1, -1926.27, 2408.62, 30.0234, 5.44543, 0, 0, -0.406736, 0.913545, 7200, 255, 1, 0, '', 26365);

-- fix - horse spell round-up horse 68903

UPDATE `creature_template` SET `spell1`='68903' AND `unit_flags`='16777216' WHERE  `entry`=36540;
