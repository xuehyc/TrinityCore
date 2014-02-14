-- 6474 Earthbind Totem Passive
UPDATE `creature_template` SET `spell1`=6474, `spell2`=0 WHERE `entry`=2630;

DELETE FROM `spell_proc_event` WHERE `entry` IN (51483,51485);
INSERT INTO `spell_proc_event` (`entry`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`CustomChance`) VALUES
(51483, 11, 0x20000000, 0, 0x20, 0x4000, 50),
(51485, 11, 0x20000000, 0, 0x20, 0x4000, 100);