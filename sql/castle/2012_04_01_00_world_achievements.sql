DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7326, 7327);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7326, 12, 0, 0, ''),
(7326, 11, 0, 0, 'achievement_volcano_blows'),
(7327, 12, 1, 0, ''),
(7327, 11, 0, 0, 'achievement_volcano_blows');

DELETE FROM `disables` WHERE `SourceType` = 4 AND `entry` IN (7326, 7327);