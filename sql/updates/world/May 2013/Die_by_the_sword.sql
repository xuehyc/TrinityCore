-- Die by the Sword cooldown fix
-- (81913) Die by the Sword (Rank 1)
DELETE FROM `spell_proc_event` WHERE `entry` IN (81913);
INSERT INTO `spell_proc_event` VALUES (81913, 0x00, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00100000, 0x00000000, 0, 100, 120);

-- (81912) Die by the Sword (Rank 2)
DELETE FROM `spell_proc_event` WHERE `entry` IN (81914);
INSERT INTO `spell_proc_event` VALUES (81914, 0x00, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00100000, 0x00000000, 0, 100, 120);

