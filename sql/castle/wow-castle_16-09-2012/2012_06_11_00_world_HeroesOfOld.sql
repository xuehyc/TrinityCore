-- Q2702: Heroes of Old.
-- Added missing quest_start_scripts-entry that summons the required target NPC.
UPDATE `quest_template` SET `StartScript`=2702 WHERE `Id`=2702;
DELETE FROM `quest_start_scripts` WHERE `id`=2702;
INSERT INTO `quest_start_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES (2702, 10, 7750, 180000, -10618.275391, -2997.868652, 28.966965, 5.069902);
