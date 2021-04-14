/* Quest Fix 14400
https://www.wowhead.com/quest=14400/i-cant-wear-this
https://www.wowhead.com/object=196472/grandmas-good-clothes
phase change for game object 196472 Grandma's Good Clothes
Original SQL to restore:
UPDATE `gameobject` SET `PhaseId`='181' WHERE  `guid`=236357;
*/

UPDATE `gameobject` SET `PhaseId`='183' WHERE  `guid`=236357;

/*Quest Fix 14465
Duplicate Gate Fix
https://www.wowhead.com/quest=14465/to-greymane-manor
Original sql to restore:
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `phaseMask`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES (235520, 196399, 654, 4714, 4714, 1, 0, 1, 0, 431, -1, -1817.84, 2333.37, 36.3445, 3.79899, 0, 0, -0.946463, 0.322813, 300, 255, 1, '', 25383);
*/
DELETE FROM `gameobject` WHERE  `guid`=236492;
/*Quest Fix 14465
NPCS Not Phased even with relog test.
https://www.wowhead.com/quest=14465/to-greymane-manor
Original SQL to restore:
UPDATE `creature` SET `PhaseId`='184' WHERE  `areaID`=4817;
*/
UPDATE `creature` SET `PhaseId`='183' WHERE  `areaID`=4817;