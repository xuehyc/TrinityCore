DELETE FROM achievement_criteria_data WHERE criteria_id IN (7704, 7705);
INSERT INTO achievement_criteria_data (criteria_id, type, value1, value2, ScriptName) VALUES
(7704, 6, 4197, 0, ''),
(7704, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter'),
(7705, 6, 4197, 0, ''), -- we activate only one though, because we make no difference between the two (who are probably used faction-wise on blizz)
(7705, 11, 0, 0, 'achievement_wg_vehicular_gnomeslaughter');