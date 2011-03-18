-- Fix NPC 'Gino' (29432)
DELETE FROM `creature` WHERE `guid` = 203055; 
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(203055, 29432, 571, 1, 1, 0, 0, 6317.91, -1726.57, 455.974, 1.55527, 300, 0, 0, 12600, 0, 0, 0, 0, 0, 0);