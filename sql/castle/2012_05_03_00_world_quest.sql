-- set quest Across Transborea to auto-complete for the time being...
UPDATE quest_template SET Method = 2, StartScript = 11930 WHERE Id = 11930;
DELETE FROM quest_start_scripts WHERE id = 11930;
INSERT INTO quest_start_scripts (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(11930, 0, 7, 11930, 10, 0, 0, 0, 0, 0);