-- use criteria check hook to send mail for brew of the year, no real critera check happens in there
DELETE FROM achievement_criteria_data WHERE criteria_id IN (9859, 9860, 9861, 9862);
INSERT INTO achievement_criteria_data (criteria_id, type, value1, value2, ScriptName) VALUES
(9859, 11, 0, 0, 'achievement_brew_of_the_month_q12420'),
(9860, 11, 0, 0, 'achievement_brew_of_the_month_q12278'),
(9861, 11, 0, 0, 'achievement_brew_of_the_month_q12421'),
(9862, 11, 0, 0, 'achievement_brew_of_the_month_q12306');