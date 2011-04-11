DELETE FROM `creature_loot_template` WHERE `entry`=31311 AND `item` IN (40628,40629,40630);

DELETE FROM `creature_loot_template` WHERE `entry`=31311 AND `item`=50105;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`)
VALUES
(31311,50105,100,1,0,-50105,2);

DELETE FROM `reference_loot_template` WHERE `entry`=50105;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`)
VALUES
(50105,40628,0,1,1,1,1),
(50105,40629,0,1,1,1,1),
(50105,40630,0,1,1,1,1);
