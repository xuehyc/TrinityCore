DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (30455, -30455, 44572, -44572);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (30455, -30455, 44572, -44572);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (-44572, 'spell_mage_fingers_of_frost');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (-30455, 'spell_mage_fingers_of_frost');