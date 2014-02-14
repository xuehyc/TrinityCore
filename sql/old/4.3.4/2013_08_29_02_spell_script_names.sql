DELETE FROM `spell_script_names` WHERE `spell_id` IN (1943, 79133, 79134);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (1943, 'spell_rog_rupture');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (79133, 'spell_rog_venomous_wounds');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (79134, 'spell_rog_venomous_wounds');

-- (79133) Venomous Wounds (Rank 1)
DELETE FROM `spell_proc_event` WHERE `entry` IN (79133);
INSERT INTO `spell_proc_event` VALUES (79133, 0x01, 0x08, 0x00100100, 0x00000000, 0x00000000, 0x00040000, 0x00000000, 0, 30, 0);

-- (79134) Venomous Wounds (Rank 2)
DELETE FROM `spell_proc_event` WHERE `entry` IN (79134);
INSERT INTO `spell_proc_event` VALUES (79134, 0x01, 0x08, 0x00100100, 0x00000000, 0x00000000, 0x00040000, 0x00000000, 0, 60, 0);