-- The Master's Terrace - Simple script that completes the quest.
-- Since the event is rather huge...
DELETE FROM `event_scripts` WHERE `id`=10951;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES (10951, 0, 7, 9645, 50, 0, 0, 0, 0, 0);
