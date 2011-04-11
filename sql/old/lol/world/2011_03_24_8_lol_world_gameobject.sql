-- Fix Quest 4764 Doomrigger's Clasp
DELETE FROM `gameobject` WHERE `id` = 175382;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES (175382, 229, 1, 1, 67.128304, -297.420990, 91.425499, -0.034906, 0, 0, 0, 300, 0, 1);
