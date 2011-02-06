
/* Lebenspunkte und level aller Mobs und Bosse auf Normalnieveo angepasst */
UPDATE `creature_template` SET `minlevel`= 60,`maxlevel`= 60,`minhealth`=11000,`maxhealth`=11000  WHERE `entry`= 17270;
UPDATE `creature_template` SET `minlevel`= 60,`maxlevel`= 60,`minhealth`=10000,`maxhealth`=10000  WHERE `entry`= 17269; /*mana*/
UPDATE `creature_template` SET `minlevel`= 60,`maxlevel`= 60,`minhealth`=10000,`maxhealth`=10000  WHERE `entry`= 17478; /*mana*/

/*Bossloot*/
/*
-- Omor
DELETE FROM `creature_loot_template` WHERE (`entry`=17308);
INSERT INTO `creature_loot_template` VALUES
(17308, 23886, 0, 100, 1, 1, 1, 0, 0, 0),
(17308, 24069, 100/6, -1, 1, 1, 0, 0, 0, 0),
(17308, 24073, 100/6, -1, 1, 1, 0, 0, 0, 0),
(17308, 24090, 100/6, -1, 1, 1, 0, 0, 0, 0),
(17308, 24091, 100/6, -1, 1, 1, 0, 0, 0, 0),
(17308, 24094, 100/6, -1, 1, 1, 0, 0, 0, 0),
(17308, 24096, 100/6, -1, 1, 1, 0, 0, 0, 0);

-- Vazruden 
DELETE FROM `creature_loot_template` WHERE (`entry`=17537);
INSERT INTO `creature_loot_template` VALUES
(17537, 23890, 100, 0, 1, 1, 1, 6, 67, 0),
(17537, 23892, 100, 0, 1, 1, 1, 6, 469, 0),
(17537, 24150, 20, -1, 1, 1, 0, 0, 0, 0),
(17537, 24064, 20, -1, 1, 1, 0, 0, 0, 0),
(17537, 24046, 20, -1, 1, 1, 0, 0, 0, 0),
(17537, 24063, 20, -1, 1, 1, 0, 0, 0, 0),
(17537, 24083, 20, -1, 1, 1, 0, 0, 0, 0),
(17537, 24155, 20, -2, 1, 1, 0, 0, 0, 0),
(17537, 24045, 20, -2, 1, 1, 0, 0, 0, 0),
(17537, 24151, 20, -2, 1, 1, 0, 0, 0, 0),
(17537, 24044, 20, -2, 1, 1, 0, 0, 0, 0),
(17537, 24154, 20, -2, 1, 1, 0, 0, 0, 0);

-- Nazan
DELETE FROM `creature_loot_template` WHERE (`entry`=17536);
INSERT INTO `creature_loot_template` VALUES
(17536, 23901, 0, 100, 1, 1, 1, 0, 0, 0),
(17536, 29561, 10, 0, 1, 1, 0, 0, 0, 0),
(17536, 29562, 3, 0, 1, 1, 0, 0, 0, 0);

-- Gargomar
DELETE FROM `creature_loot_template` WHERE (`entry`=17306);
INSERT INTO `creature_loot_template` VALUES
(17306, 23881, 0, 100, 1, 1, 1, 0, 0, 0),
(17306, 24020, 20, -1, 1, 1, 0, 0, 0, 0),
(17306, 24021, 20, -1, 1, 1, 0, 0, 0, 0),
(17306, 24022, 20, -1, 1, 1, 0, 0, 0, 0),
(17306, 24023, 20, -1, 1, 1, 0, 0, 0, 0),
(17306, 24024, 20, -1, 1, 1, 0, 0, 0, 0);
*/
/* Spawnzeiten Normale Mobs 1 Stunden Bosse 2 Stunden */
UPDATE `creature` SET `spawntimesecs`= 36000 where `map` = 543;
UPDATE `creature` SET `spawntimesecs`= 72000 where `id` in (17537,17537,17308,17281);