-- Achievement: Stayin buffed all winter.
-- Moved check to script.
-- 10 man handling.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10223, 10240, 10241);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10223, 11, 0, 0, 'achievement_staying_buffed_all_winter'), 
(10223, 12, 0, 0, ''), 
(10240, 11, 0, 0, 'achievement_staying_buffed_all_winter'), 
(10240, 12, 0, 0, ''), 
(10241, 11, 0, 0, 'achievement_staying_buffed_all_winter'), 
(10241, 12, 0, 0, '');

-- 25 man handling.
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10229, 10238, 10239);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10229, 12, 1, 0, ''), 
(10229, 11, 0, 0, 'achievement_staying_buffed_all_winter_25'), 
(10238, 12, 1, 0, ''), 
(10238, 11, 0, 0, 'achievement_staying_buffed_all_winter_25'), 
(10239, 12, 1, 0, ''), 
(10239, 11, 0, 0, 'achievement_staying_buffed_all_winter_25');

/*
-- Backup.
-- 10m achievs.
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10223, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10223, 18, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10240, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10240, 18, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10241, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10241, 18, 0, 0, '');
-- 20m achievs.
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10229, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10229, 18, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10238, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10238, 18, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10239, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10239, 18, 0, 0, '');

*/