-- Wanted Poster at Zabra'jin faction fix
UPDATE `gameobject_template` SET `faction` = 83 WHERE `entry` = 182165;

-- spawn Darkstone Tablet Container (Upper Blackrock Spire)
DELETE FROM `gameobject`WHERE `id` = 175385;
INSERT INTO `gameobject` (`id` ,`map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(175385 ,229, 1, 1, 65.677, -281.64, 93.8493, 3.02213, 0, 0, 0.998217, 0.0596968, 300, 0, 1); 
