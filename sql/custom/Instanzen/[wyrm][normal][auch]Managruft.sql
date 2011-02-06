
/* Normale Instanz */

UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=1600,`maxhealth`=1600  WHERE `entry`= 18429; /*mana*/
UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 65,`minhealth`=8900,`maxhealth`=9000  WHERE `entry`= 19673; /*npc*/
UPDATE `creature_template` SET `minlevel`= 61,`maxlevel`= 64,`minhealth`=3100,`maxhealth`=5300  WHERE `entry`= 19672; /*npc*/
UPDATE `creature_template` SET `minlevel`= 66,`maxlevel`= 66,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 19671;/*npc mana*/
UPDATE `creature_template` SET `minlevel`= 65,`maxlevel`= 65,`minhealth`=7000,`maxhealth`=7000  WHERE `entry`= 18430; /* mana gescriptet*/
UPDATE `creature_template` SET `minlevel`= 65,`maxlevel`= 65,`minhealth`=4100,`maxhealth`=4100  WHERE `entry`= 18431; /*mana gescriptet*/
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 18311;
UPDATE `creature_template` SET `minlevel`= 65,`maxlevel`= 65,`minhealth`=12000,`maxhealth`=12000  WHERE `entry`= 18331;/*mana burn wordpain*/
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=11000 ,`maxhealth`=11000   WHERE `entry`= 18317; /*mana*/
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 18309;
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=11000, `maxhealth`=11000   WHERE `entry`= 18313; /*beschwörer bekommt spell 32353 oder 32352 oder 32349 oder 32348*/
UPDATE `creature_template` SET `minlevel`= 65,`maxlevel`= 65,`minhealth`=12000, `maxhealth`=12000   WHERE `entry`= 18312;
UPDATE `creature_template` SET `minlevel`= 66,`maxlevel`= 66,`minhealth`=12000, `maxhealth`=12000   WHERE `entry`= 18315; /*mana sheep*/
UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 63,`minhealth`=4100, `maxhealth`=4100   WHERE `entry`= 18394; /*mana shadowboltvolley*/
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=4700, `maxhealth`=4700   WHERE `entry`= 19306; /* mana burn*/
UPDATE `creature_template` SET `minlevel`= 65,`maxlevel`= 65,`minhealth`=17000, `maxhealth`=17000   WHERE `entry`= 18314;
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=30000, `maxhealth`=30000   WHERE `entry`= 19307;/* dot debuff mana */
UPDATE `creature_template` SET `minlevel`= 66,`maxlevel`= 66,`minhealth`=68000, `maxhealth`=68000   WHERE `entry`= 19666; /*mana npc*/

UPDATE `creature_template` SET `minlevel`= 66,`maxlevel`= 66,`minhealth`=87000,`maxhealth`=87000  WHERE `entry`= 18344; /*mana*/
UPDATE `creature_template` SET `minlevel`= 66,`maxlevel`= 66,`minhealth`=73000,`maxhealth`=73000  WHERE `entry`= 18341;
UPDATE `creature_template` SET `minlevel`= 66,`maxlevel`= 66,`minhealth`=91000,`maxhealth`=91000  WHERE `entry`= 18343;

/* Bossloots */
/*
DELETE FROM `creature_loot_template` WHERE (`entry`=18344);
INSERT INTO `creature_loot_template` VALUES
(18344, 28558, 40, 0, 1, 1, 1, 0, 0, 0),
(18344, 28490, 0, 46, 1, 1, 1, 0, 0, 0),
(18344, 25953, 16, -1, 1, 1, 0, 0, 0, 0),
(18344, 25962, 15, -1, 1, 1, 0, 0, 0, 0),
(18344, 25954, 14, -1, 1, 1, 0, 0, 0, 0),
(18344, 25955, 14, -1, 1, 1, 0, 0, 0, 0),
(18344, 25957, 14, -1, 1, 1, 0, 0, 0, 0),
(18344, 25956, 13, -1, 1, 1, 0, 0, 0, 0),
(18344, 22921, 1, 0, 1, 1, 0, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE (`entry`=18341);
INSERT INTO `creature_loot_template` VALUES
(18341, 28558, 40, 0, 1, 1, 1, 0, 0, 0),
(18341, 25943, 17, -1, 1, 1, 0, 0, 0, 0),
(18341, 25940, 16, -1, 1, 1, 0, 0, 0, 0),
(18341, 25942, 14, -1, 1, 1, 0, 0, 0, 0),
(18341, 25941, 13, -1, 1, 1, 0, 0, 0, 0),
(18341, 25939, 13, -1, 1, 1, 0, 0, 0, 0),
(18341, 28166, 12, -1, 1, 1, 0, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE (`entry`=18343);
INSERT INTO `creature_loot_template` VALUES
(18343, 28558, 40, 0, 1, 1, 1, 0, 0, 0),
(18343, 25952, 16, -1, 1, 1, 0, 0, 0, 0),
(18343, 25947, 14, -1, 1, 1, 0, 0, 0, 0),
(18343, 25946, 14, -1, 1, 1, 0, 0, 0, 0),
(18343, 25950, 14, -1, 1, 1, 0, 0, 0, 0),
(18343, 25944, 13, -1, 1, 1, 0, 0, 0, 0),
(18343, 25945, 12, -1, 1, 1, 0, 0, 0, 0);
*/
/* spawn time´s*/
UPDATE `creature` SET `spawntimesecs`= 36000 where `map` = 557;
UPDATE `creature` SET `spawntimesecs`= 72000 where `id` in (18341,18344,18343);
