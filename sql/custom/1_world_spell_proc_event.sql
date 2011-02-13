-- Item - Hunter T10 2P Bonus
DELETE FROM `spell_proc_event` WHERE `entry` = 70727;
INSERT INTO `spell_proc_event` VALUES (70727, 0, 9, 0, 0, 0, 64, 0, 0, 5, 0); 

-- Item - Hunter T10 4P Bonus
DELETE FROM `spell_proc_event` WHERE `entry` = 70730;
INSERT INTO `spell_proc_event` VALUES (70730, 0, 9, 16384, 4096, 0, 262144, 0, 0, 5, 0);