-- Fix for Quest 4788 The Final Tablets
-- Spawn Fifth Mosh'aru Tablet and Sixth Mosh'aru Tablet
DELETE FROM `gameobject` WHERE `id` IN (175949, 175950);
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(175949, 229, 1, 1, -128.202, -482.001, 25.4587, 0.0125299, 0, 0, 0.00626493, 0.99998, 300, 0, 1),
(175950, 229, 1, 1, -10.0497, -465.8, -17.016, 1.57548, 0, 0, 0.70876, 0.70545, 300, 0, 1);