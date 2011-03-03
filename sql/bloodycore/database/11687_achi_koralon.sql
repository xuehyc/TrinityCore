-- Achievement Defeat Koralon the Flame Watcher
DELETE FROM achievement_criteria_data WHERE criteria_id IN (11478, 11479);
INSERT INTO achievement_criteria_data VALUES 
(11478, 12, 0, 0, ""), -- Koralon 10
(11479, 12, 1, 0, ""); -- Koralon 25