-- fix - powering our defenses eversong
DELETE FROM `creature` WHERE `guid`=210219198;

DELETE FROM `gameobject` WHERE `guid`=49512;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (49512, 300067, 530, 1, 1, 1, 0, 0, 0, -1, 8277.38, -7213.13, 137.63, 0, 0, 0, 0, 1, 300, 0, 0, 1, '', 0);

DELETE FROM `gameobject_addon` WHERE `guid`=49512;
INSERT INTO `gameobject_addon` (`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`, `WorldEffectID`) 
VALUES (49512, 0, 0, 0, 1, 8, 1000, 0);

DELETE FROM `gameobject_template` WHERE `entry`=300067;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) 
VALUES (300067, 8, 299, 'Eversong Runestone', '', '', '', 1, 1363, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 1);
