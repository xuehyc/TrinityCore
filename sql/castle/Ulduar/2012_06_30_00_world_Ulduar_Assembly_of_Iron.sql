DELETE FROM `spell_script_names` WHERE `spell_id` IN (61902, 61911, 63495, 61920);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(61902, 'spell_steelbreaker_electrical_charge'),
(61911, 'spell_steelbreaker_static_disruption'),
(63495, 'spell_steelbreaker_static_disruption'),
(61920, 'spell_supercharge');

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10084,10087,10088,10418,10419,10089,10420,10421,10090,10422,10423,10091,10424,10425);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10084, 11, 0, 0, 'achievement_i_choose_you'), -- achievement 2941
(10084, 12, 0, 0, ''),
(10087, 11, 0, 0, 'achievement_i_choose_you_25'), -- achievement 2944
(10087, 12, 1, 0, ''),
-- Check if the following works: Due to AchievmentCriteria.dbc, there are three criterias, but... there's only one check.
(10088, 11, 0, 0, 'achievement_but_i_am_on_your_side'), -- achievement 2945
(10088, 12, 0, 0, ''),
(10418, 11, 0, 0, 'achievement_but_i_am_on_your_side'), -- achievement 2945
(10418, 12, 0, 0, ''),
(10419, 11, 0, 0, 'achievement_but_i_am_on_your_side'), -- achievement 2945
(10419, 12, 0, 0, ''),
(10089, 11, 0, 0, 'achievement_but_i_am_on_your_side_25'), -- achievement 2946
(10089, 12, 1, 0, ''),
(10420, 11, 0, 0, 'achievement_but_i_am_on_your_side_25'), -- achievement 2946
(10420, 12, 1, 0, ''),
(10421, 11, 0, 0, 'achievement_but_i_am_on_your_side_25'), -- achievement 2946
(10421, 12, 1, 0, ''),
(10090, 11, 0, 0, 'achievement_cant_do_that_while_stunned'), -- achievement 2947
(10090, 12, 0, 0, ''),
(10422, 11, 0, 0, 'achievement_cant_do_that_while_stunned'), -- achievement 2947
(10422, 12, 0, 0, ''),
(10423, 11, 0, 0, 'achievement_cant_do_that_while_stunned'), -- achievement 2947
(10423, 12, 0, 0, ''),
(10091, 11, 0, 0, 'achievement_cant_do_that_while_stunned_25'), -- achievement 2948
(10091, 12, 1, 0, ''),
(10424, 11, 0, 0, 'achievement_cant_do_that_while_stunned_25'), -- achievement 2948
(10424, 12, 1, 0, ''),
(10425, 11, 0, 0, 'achievement_cant_do_that_while_stunned_25'), -- achievement 2948
(10425, 12, 1, 0, '');

-- Backup
/*
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10084, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10087, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10088, 5, 58501, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10088, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10089, 5, 58501, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10089, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10090, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10091, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10418, 5, 58501, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10418, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10419, 5, 58501, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10419, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10420, 5, 58501, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10420, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10421, 5, 58501, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10421, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10422, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10423, 12, 0, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10424, 12, 1, 0, '');
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES (10425, 12, 1, 0, '');
*/