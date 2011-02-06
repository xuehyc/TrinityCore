INSERT INTO creature VALUES (97347,18956,556,1,0,0,-158.2,187.943,0.010781,4.859,25,0,0,8700,0,0,0);
INSERT INTO gameobject_template VALUES (181783,3,1787,'Cage','open',0,32,1.3,57,3598,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'go_lakka');
INSERT INTO gameobject VALUES ( 100055, 181783, 556, 1, -158.338, 188.133, 0.010791, 3.39175, 0, 0, 0.992188, -0.124752, 25, 0, 1);


/* Normale Instanz */
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 19429;
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=4400,`maxhealth`=4400  WHERE `entry`= 21891;
UPDATE `creature_template` SET `minlevel`= 68,`maxlevel`= 68,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 21904;
UPDATE `creature_template` SET `minlevel`= 68,`maxlevel`= 68,`minhealth`=31000,`maxhealth`=31000  WHERE `entry`= 19428;
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=7800,`maxhealth`=7800  WHERE `entry`= 18701;

UPDATE `creature_template` SET `minlevel`= 63,`maxlevel`= 63,`minhealth`=6553,`maxhealth`=6553  WHERE `entry`= 18496; /*NPC*/
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=10000,`maxhealth`=10000  WHERE `entry`= 23136; /*NPC*/
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=9400 ,`maxhealth`=9400   WHERE `entry`= 23135; /*NPC*/
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=9600,`maxhealth`=9600  WHERE `entry`= 23135; /*NPC*/
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=9500, `maxhealth`=9500   WHERE `entry`= 18956; /*NPC*/

UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=18000, `maxhealth`=18000   WHERE `entry`= 18323;
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=18000, `maxhealth`=18000   WHERE `entry`= 18318;
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=13000, `maxhealth`=13000   WHERE `entry`= 18328;
UPDATE `creature_template` SET `minlevel`= 68,`maxlevel`= 68,`minhealth`=13000, `maxhealth`=13000   WHERE `entry`= 18325;
UPDATE `creature_template` SET `minlevel`= 68,`maxlevel`= 68,`minhealth`=19000, `maxhealth`=19000   WHERE `entry`= 18322;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=15000, `maxhealth`=15000   WHERE `entry`= 18326;
UPDATE `creature_template` SET `minlevel`= 68,`maxlevel`= 68,`minhealth`=15000, `maxhealth`=15000   WHERE `entry`= 18321;
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=13000, `maxhealth`=13000   WHERE `entry`= 18327;
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=13000, `maxhealth`=13000   WHERE `entry`= 18319;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=14000, `maxhealth`=14000   WHERE `entry`= 18320;

UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=2700, `maxhealth`=2700   WHERE `entry`= 19205;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=2700, `maxhealth`=2700   WHERE `entry`= 19203;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=2700, `maxhealth`=2700   WHERE `entry`= 19204;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=2700, `maxhealth`=2700   WHERE `entry`= 19206;

DELETE FROM creature WHERE id in (19205,19204,19203,19206); /* 7 Mobs die durch eine Script gespawnt werden */

UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 66,`minhealth`=84000,`maxhealth`=84000  WHERE `entry`= 18472;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=80000,`maxhealth`=80000  WHERE `entry`= 18473;

/* boss loot*/
/*
DELETE FROM `creature_loot_template` WHERE (`entry`=18472);
INSERT INTO `creature_loot_template` VALUES
(18472, 24160, 0.5, 0, 1, 1, 0, 0, 0, 0),
(18472, 27633, 0, 100, 1, 1, 1, 0, 0, 0),
(18472, 27914, 15, -1, 1, 1, 0, 0, 0, 0),
(18472, 27915, 13, -1, 1, 1, 0, 0, 0, 0),
(18472, 27916, 13, -1, 1, 1, 0, 0, 0, 0),
(18472, 27917, 15, -1, 1, 1, 0, 0, 0, 0),
(18472, 27918, 14, -1, 1, 1, 0, 0, 0, 0),
(18472, 27919, 15, -1, 1, 1, 0, 0, 0, 0),
(18472, 28558, 40, 0, 2, 2, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE (`entry`=18473);
INSERT INTO `creature_loot_template` VALUES
(18473, 23572, 10, 0, 1, 1, 0, 0, 0, 0),
(18473, 27632, 0, 100, 1, 1, 1, 0, 0, 0),
(18473, 27776, 20, -1, 1, 1, 0, 0, 0, 0),
(18473, 27838, 20, -1, 1, 1, 0, 0, 0, 0),
(18473, 27875, 20, -1, 1, 1, 0, 0, 0, 0),
(18473, 27936, 20, -1, 1, 1, 0, 0, 0, 0),
(18473, 27948, 20, -1, 1, 1, 0, 0, 0, 0),
(18473, 27925, 100/6, -2, 1, 1, 0, 0, 0, 0),
(18473, 27946, 100/6, -2, 1, 1, 0, 0, 0, 0),
(18473, 27980, 100/6, -2, 1, 1, 0, 0, 0, 0),
(18473, 27981, 100/6, -2, 1, 1, 0, 0, 0, 0),
(18473, 27985, 100/6, -2, 1, 1, 0, 0, 0, 0),
(18473, 27986, 100/6, -2, 1, 1, 0, 0, 0, 0),
(18473, 28558, 40, 0, 2, 2, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE (`entry`=23035);
INSERT INTO `creature_loot_template` VALUES
(23035, 28558, 10, 0, 2, 2, 1, 0, 0, 0),
(23035 ,32768 ,1, 0, 1, 1, 0, 0, 0, 0);
*/
/*spawn time 556*/
UPDATE `creature` SET `spawntimesecs`= 36000 where `map` = 556;/*mobs*/
UPDATE `creature` SET `spawntimesecs`= 72000 where `id` in (18472,18473); /* bosse*/