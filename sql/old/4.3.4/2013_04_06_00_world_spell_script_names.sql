DELETE FROM `spell_script_names` WHERE `spell_id` = 23880;
DELETE FROM `spell_script_names` WHERE spell_id = -23881;
DELETE FROM `spell_script_names` WHERE spell_id = 23881;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (23881,"spell_warr_bloodthirst");
DELETE FROM `spell_linked_spell` WHERE  `spell_trigger`=23881 AND `spell_effect`=23880;
INSERT INTO `spell_linked_spell` VALUES (23881, 23880, 1, 'Bloodthirst heal');
