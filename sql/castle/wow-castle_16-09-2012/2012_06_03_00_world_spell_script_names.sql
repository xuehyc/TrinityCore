-- Register spell-script for Sindragosa ability Permeating Chill / Durchdringende Kaelte 70107 in instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
DELETE FROM `spell_script_names` WHERE `spell_id` = 70107 AND `ScriptName` = 'spell_sindragosa_permeating_chill';
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(70107, 'spell_sindragosa_permeating_chill');