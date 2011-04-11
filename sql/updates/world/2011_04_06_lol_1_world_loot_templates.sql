-- Fix Loot table for Clams

-- Giant Clam Object 2744
UPDATE `gameobject_template` SET `data2`=300 WHERE `entry`=2744 LIMIT 1;
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=65, `groupid`=0 WHERE `entry`=2264 AND `item`=4611 LIMIT 1;
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=24, `groupid`=0 WHERE `entry`=2264 AND `item`=4655 LIMIT 1;
DELETE FROM `gameobject_loot_template` WHERE `item` IN (5504,5503,5500,5498) AND `entry` = 2264;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`)
VALUES
(2264, 5504,  22, 1, 0, 1, 3),
(2264, 5503,  13, 1, 0, 1, 1),
(2264, 5500, 1.2, 1, 0, 1, 1),
(2264, 5498, 1.2, 1, 0, 1, 1);

-- Small Barnacled Clam Item 5523 lvl10 58172
DELETE FROM `spell_loot_template` WHERE `entry`=58172 AND `item`=4611 LIMIT 1;
DELETE FROM `spell_loot_template` WHERE `entry`=58172 AND `item`=5500 LIMIT 1;
-- Thick Shelled Clam Item 5524 lvl20 58168
DELETE FROM `spell_loot_template` WHERE `entry`=58168 AND `item`=4611 LIMIT 1;
UPDATE `spell_loot_template` SET `ChanceOrQuestChance`=50 WHERE `entry`=58168 AND `item`=5504 LIMIT 1;
