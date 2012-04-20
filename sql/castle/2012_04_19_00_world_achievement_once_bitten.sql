-- bloodqueen lana'thel: once bitten, twice shy
-- handle raid difficulty in achievement script
DELETE FROM achievement_criteria_data WHERE type = 12 AND criteria_id IN (12780, 13011, 13012, 13013);
UPDATE achievement_criteria_data SET ScriptName = 'achievement_once_bitten_twice_shy_n25' WHERE criteria_id = 13012 AND type = 11;
UPDATE achievement_criteria_data SET ScriptName = 'achievement_once_bitten_twice_shy_v25' WHERE criteria_id = 13013 AND type = 11;
