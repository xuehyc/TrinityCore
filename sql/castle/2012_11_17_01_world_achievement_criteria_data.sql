-- remove from disables
DELETE FROM `disables` WHERE sourceType = 4 AND entry = 7666;

-- add achievementscript as criteria_data
DELETE FROM `achievement_criteria_data` WHERE criteria_id = 7666;
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(7666, 11, 0, 0, 'achievement_wg_within_our_grasp');
