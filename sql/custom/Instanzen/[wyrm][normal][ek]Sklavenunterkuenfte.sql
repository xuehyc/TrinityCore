
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=15000, `maxhealth`=15000  WHERE `entry`= 17816;
UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 63,`minhealth`=16000, `maxhealth`=16000  WHERE `entry`= 17957;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=15000, `maxhealth`=15000  WHERE `entry`= 17962;
UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 63,`minhealth`=16000, `maxhealth`=16000  WHERE `entry`= 17958;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=12000, `maxhealth`=12000  WHERE `entry`= 17961;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=12000, `maxhealth`=12000  WHERE `entry`= 17938;
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=16000, `maxhealth`=16000  WHERE `entry`= 21128;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=12000, `maxhealth`=12000  WHERE `entry`= 21126;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=16000, `maxhealth`=16000  WHERE `entry`= 17959;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=11000, `maxhealth`=11000  WHERE `entry`= 17960;
UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 63,`minhealth`=13000, `maxhealth`=13000  WHERE `entry`= 17940;
UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 63,`minhealth`=16000, `maxhealth`=16000  WHERE `entry`= 21127;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=15000, `maxhealth`=15000  WHERE `entry`= 17817;
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=4500, `maxhealth`=4500   WHERE `entry`= 17893;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=11000, `maxhealth`=11000  WHERE `entry`= 22421;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=3700, `maxhealth`=3700  WHERE `entry`= 17963;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 62,`minhealth`=5300, `maxhealth`=5300  WHERE `entry`= 17964; /*NPC*/
UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 63,`minhealth`=2620, `maxhealth`=2620  WHERE `entry`= 17890; /*NPC*/

-- Bosse
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=79000, `maxhealth`=79000  WHERE `entry`= 17941;
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64,`minhealth`=100000, `maxhealth`=100000 WHERE `entry`= 17942;
UPDATE `creature_template` SET `minlevel`= 62,`maxlevel`= 64,`minhealth`=97000, `maxhealth`=97000 WHERE `entry`= 17991;

-- Mennue Totems
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64, `minhealth`=5700, `maxhealth`=5700   WHERE `entry`= 18177;
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64, `minhealth`=7700, `maxhealth`=7700   WHERE `entry`= 18179;
UPDATE `creature_template` SET `minlevel`= 64,`maxlevel`= 64, `minhealth`=6500, `maxhealth`=6500   WHERE `entry`= 20208;

-- Bossloot
/*
-- Mennu the Betrayer
DELETE FROM `creature_loot_template` WHERE (`entry`=17941);
INSERT INTO `creature_loot_template` VALUES
(17941, 24357, 20, -1, 1, 1, 0, 0, 0, 0),
(17941, 24361, 20, -1, 1, 1, 0, 0, 0, 0),
(17941, 24356, 20, -1, 1, 1, 0, 0, 0, 0),
(17941, 24360, 20, -1, 1, 1, 0, 0, 0, 0),
(17941, 24359, 20, -1, 1, 1, 0, 0, 0, 0),
(17941, 29674, 0.5, 0, 1, 1, 0, 0, 0, 0);

-- Rokmar the Crackler
DELETE FROM `creature_loot_template` WHERE (`entry`=17991);
INSERT INTO `creature_loot_template` VALUES
(17991, 24376, 20, -1, 1, 1, 0, 0, 0, 0),
(17991, 24380, 20, -1, 1, 1, 0, 0, 0, 0),
(17991, 24381, 20, -1, 1, 1, 0, 0, 0, 0),
(17991, 24379, 20, -1, 1, 1, 0, 0, 0, 0),
(17991, 24378, 20, -1, 1, 1, 0, 0, 0, 0);

-- Quagmirran
DELETE FROM `creature_loot_template` WHERE (`entry`=17942);
INSERT INTO `creature_loot_template` VALUES
(17942, 24364, 20, -1, 1, 1, 0, 0, 0, 0),
(17942, 24365, 20, -1, 1, 1, 0, 0, 0, 0),
(17942, 24363, 20, -1, 1, 1, 0, 0, 0, 0),
(17942, 24366, 20, -1, 1, 1, 0, 0, 0, 0),
(17942, 24362, 20, -1, 1, 1, 0, 0, 0, 0);
*/
-- Spawnzeit
UPDATE `creature` SET `spawntimesecs`= 36000 where `map` = 547;
UPDATE `creature` SET `spawntimesecs`= 72000 where `id` in (17942, 17991, 17941);

