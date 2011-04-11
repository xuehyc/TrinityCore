-- CleanUp Captain Zorna
DELETE FROM `creature` WHERE `id` = 27511;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(107018, 27511, 571, 1, 1, 24683, 0, 2708.7, -1812.33, 4.8389, 5.53136, 300, 5, 0, 30846, 0, 0, 1, 0, 0, 0);
