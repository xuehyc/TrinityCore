-- Clean Up NPC 'Rokhan' 26859
DELETE FROM `creature` WHERE `id` = 26859; 
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(203386, 26859, 571, 1, 1, 0, 0, 4339.94, 980.231, 91.9789, 5.51524, 120, 0, 0, 96100, 0, 0, 0, 0, 0, 0);
-- Clean Up NPC 'Kontokanis' 26979
DELETE FROM `creature` WHERE `id` = 26979;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(203387, 26979, 571, 1, 1, 0, 0, 4322.3, 1009.02, 95.6906, 2.56563, 120, 0, 0, 92910, 0, 0, 0, 0, 0, 0);