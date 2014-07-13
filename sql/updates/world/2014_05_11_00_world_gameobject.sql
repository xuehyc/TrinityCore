ALTER TABLE `gameobject` ADD `VerifiedBuild` SMALLINT(5) DEFAULT '0';

DELETE FROM `gameobject` WHERE `guid`=404292;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(404292, 193986, 571, 1, 1, 7917.546, -2461.021, 1135.937, 3.071766, 0, 0, 0, 1, 120, 255, 1, 15595); -- Gravestone
