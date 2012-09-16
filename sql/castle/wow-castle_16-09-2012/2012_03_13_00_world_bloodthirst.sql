-- Fix Bloodthirst / Blutdurst ability of warrior / Krieger - 23880, 23881, 23885
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_warr_bloodthirst';
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(23880, 'spell_warr_bloodthirst');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 23881 AND `spell_effect` = 23885;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(23881, 23885, 0, 'Bloodthirst');