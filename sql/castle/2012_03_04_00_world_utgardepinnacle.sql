-- criteria for achievement My Girl Loves To Skadi All The Time (2156)
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 7595;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7595, 11, 0, 0, 'achievement_skadi_all_the_time'),
(7595, 12, 1, 0, '');

DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` = 7595;
