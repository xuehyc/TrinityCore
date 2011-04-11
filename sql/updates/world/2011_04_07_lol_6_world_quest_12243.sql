-- Workaround for Quest 12243 Fire on the Water
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 48455;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (48455, 50290, 'Apothecary\'s Burning Water');

UPDATE `creature_template` SET `lootid`=27232 WHERE `entry`=27232 LIMIT 1;

DELETE FROM `creature_loot_template` WHERE `entry` =27232;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`)
VALUES
(27232, 45912, 0.1, 1, 0, 1, 1),
(27232, 37304, -100, 1, 0, 1, 1),
(27232, 43851, 27, 1, 0, 1, 1),
(27232, 33470, 14, 1, 0, 1, 3),
(27232, 33443, 4, 1, 0, 1, 1),
(27232, 22829, 2, 1, 0, 1, 1),
(27232, 33444, 2, 1, 0, 1, 1);
