-- Fix Quest 10855 Fel Reaver, No Thanks!
DELETE FROM `quest_end_scripts` WHERE `id` =10850;
INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`)
VALUES
(10850, 2, 8, 22293, 0, 0, 0, 0, 0, 0);
