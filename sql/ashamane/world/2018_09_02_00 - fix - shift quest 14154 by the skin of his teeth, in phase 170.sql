-- fix - remove spawned worgen (35456, 35457) on top of stoneward prison

DELETE FROM `creature` WHERE `guid`=20556649;
DELETE FROM `creature` WHERE `guid`=20556648;
DELETE FROM `creature` WHERE `guid`=20556646;
DELETE FROM `creature` WHERE `guid`=20556645;
DELETE FROM `creature` WHERE `guid`=20556644;
DELETE FROM `creature` WHERE `guid`=20556643;
DELETE FROM `creature` WHERE `guid`=20556642;
DELETE FROM `creature` WHERE `guid`=20556641;
DELETE FROM `creature` WHERE `guid`=20556640;
DELETE FROM `creature` WHERE `guid`=20556639;
DELETE FROM `creature` WHERE `guid`=20556638;
DELETE FROM `creature` WHERE `guid`=20556637;
DELETE FROM `creature` WHERE `guid`=20556636;
DELETE FROM `creature` WHERE `guid`=20556635;
DELETE FROM `creature` WHERE `guid`=20556634;
DELETE FROM `creature` WHERE `guid`=20556633;
DELETE FROM `creature` WHERE `guid`=20556632;
DELETE FROM `creature` WHERE `guid`=20556631;
DELETE FROM `creature` WHERE `guid`=20556630;
DELETE FROM `creature` WHERE `guid`=20556629;
DELETE FROM `creature` WHERE `guid`=20556628;
DELETE FROM `creature` WHERE `guid`=20556627;
DELETE FROM `creature` WHERE `guid`=20556626;
DELETE FROM `creature` WHERE `guid`=20556625;
DELETE FROM `creature` WHERE `guid`=20556624;
DELETE FROM `creature` WHERE `guid`=20556623;
DELETE FROM `creature` WHERE `guid`=20556622;
DELETE FROM `creature` WHERE `guid`=20556621;
DELETE FROM `creature` WHERE `guid`=20556620;
DELETE FROM `creature` WHERE `guid`=20556602;
DELETE FROM `creature` WHERE `guid`=20556601;
DELETE FROM `creature` WHERE `guid`=20556600;
DELETE FROM `creature` WHERE `guid`=20556599;
DELETE FROM `creature` WHERE `guid`=20556598;
DELETE FROM `creature` WHERE `guid`=20556597;
DELETE FROM `creature` WHERE `guid`=20556596;
DELETE FROM `creature` WHERE `guid`=20556586;
DELETE FROM `creature` WHERE `guid`=20556585;
DELETE FROM `creature` WHERE `guid`=20556583;
DELETE FROM `creature` WHERE `guid`=20556582;
DELETE FROM `creature` WHERE `guid`=20556581;
DELETE FROM `creature` WHERE `guid`=20556580;
DELETE FROM `creature` WHERE `guid`=20556579;
DELETE FROM `creature` WHERE `guid`=20556578;
DELETE FROM `creature` WHERE `guid`=20556577;
DELETE FROM `creature` WHERE `guid`=20556576;
DELETE FROM `creature` WHERE `guid`=20556575;
DELETE FROM `creature` WHERE `guid`=20556574;
DELETE FROM `creature` WHERE `guid`=20556572;
DELETE FROM `creature` WHERE `guid`=20556425;
DELETE FROM `creature` WHERE `guid`=20556424;
DELETE FROM `creature` WHERE `guid`=20556413;
DELETE FROM `creature` WHERE `guid`=20556647;
DELETE FROM `creature` WHERE `guid`=20556573;
DELETE FROM `creature` WHERE `guid`=20556426;

-- fix - put npcs: 35077, 35124, 35081, 35123 in phase 170

DELETE FROM `creature` WHERE `guid`=20556540;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES (20556540, 35077, 654, 4755, 4757, 1, 0, 170, 0, -1, 0, 0, -1679.73, 1442.12, 52.3705, 0.750492, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25383);
DELETE FROM `creature` WHERE `guid`=20556541;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (20556541, 35081, 654, 4755, 4757, 1, 0, 170, 0, -1, 0, 0, -1682.17, 1439.67, 52.3705, 0.837758, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25383);
DELETE FROM `creature` WHERE `guid`=20556536;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (20556536, 35123, 654, 4755, 4757, 1, 0, 170, 0, -1, 0, 0, -1682.8, 1441.26, 52.3705, 5.48033, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25383);
DELETE FROM `creature` WHERE `guid`=20556537;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (20556537, 35124, 654, 4755, 4757, 1, 0, 170, 0, -1, 0, 0, -1678.51, 1438.79, 52.3704, 6.25315, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25383);
