
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=6300,`maxhealth`=6300  WHERE `entry`= 20478;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 19510;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 20990;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=28000,`maxhealth`=28000  WHERE `entry`= 19167;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 19231;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 19712;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=10000,`maxhealth`=10000  WHERE `entry`= 19716;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=28000,`maxhealth`=28000  WHERE `entry`= 19713;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=11000,`maxhealth`=11000  WHERE `entry`= 21062;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=11000,`maxhealth`=11000  WHERE `entry`= 21062;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=11000,`maxhealth`=11000  WHERE `entry`= 20481;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 19168;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 20988;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 20059;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=120000,`maxhealth`=120000  WHERE `entry`= 19735;
UPDATE `creature_template` SET `minlevel`= 71,`maxlevel`= 71,`minhealth`=48000,`maxhealth`=48000  WHERE `entry`= 19166;


UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=150000,`maxhealth`=150000  WHERE `entry`= 19219;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=120000,`maxhealth`=120000  WHERE `entry`= 19218;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=110000,`maxhealth`=110000  WHERE `entry`= 19221;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=130000,`maxhealth`=130000  WHERE `entry`= 19220;


update creature set id = 19713 where id = 21532;
update creature set id = 19220 where guid = 83241;
update creature set id = 19221 where guid = 83230; 


-- Spawnzeit setzen üblich 3600sekunden
update creature set spawntimesecs = '36000' where map = 554;
update creature set spawntimesecs = '72000' where map = 554 and id in (19219,19218,19221,19220);
/*
-- Mechano-Lord Capacitus loot
DELETE FROM `creature_loot_template` WHERE (`entry`=19219);
INSERT INTO `creature_loot_template` VALUES
(19219, 28254, 20, -1, 1, 1, 0, 0, 0, 0),
(19219, 28253, 20, -1, 1, 1, 0, 0, 0, 0),
(19219, 28255, 20, -1, 1, 1, 0, 0, 0, 0),
(19219, 28256, 20, -1, 1, 1, 0, 0, 0, 0),
(19219, 28257, 20, -1, 1, 1, 0, 0, 0, 0);

-- Nethermancer Sepethrea loot
DELETE FROM `creature_loot_template` WHERE (`entry`=19221);
INSERT INTO `creature_loot_template` VALUES
(19221, 28259, 20, -1, 1, 1, 0, 0, 0, 0),
(19221, 28260, 20, -1, 1, 1, 0, 0, 0, 0),
(19221, 28258, 20, -1, 1, 1, 0, 0, 0, 0),
(19221, 28262, 20, -1, 1, 1, 0, 0, 0, 0),
(19221, 28263, 20, -1, 1, 1, 0, 0, 0, 0);

-- Pathaleon the Calculator loot
DELETE FROM `creature_loot_template` WHERE (`entry`=19220);
INSERT INTO `creature_loot_template` VALUES
(19220, 31086, 0, 100, 1, 1, 1, 0, 0, 0),
(19220, 28278, 20, -1, 1, 1, 0, 0, 0, 0),
(19220, 28202, 20, -1, 1, 1, 0, 0, 0, 0),
(19220, 28204, 20, -1, 1, 1, 0, 0, 0, 0),
(19220, 28275, 20, -1, 1, 1, 0, 0, 0, 0),
(19220, 28285, 20, -1, 1, 1, 0, 0, 0, 0),
(19220, 28266, 100/7, -2, 1, 1, 0, 0, 0, 0),
(19220, 28286, 100/7, -2, 1, 1, 0, 0, 0, 0),
(19220, 28269, 100/7, -2, 1, 1, 0, 0, 0, 0),
(19220, 28288, 100/7, -2, 1, 1, 0, 0, 0, 0),
(19220, 28265, 100/7, -2, 1, 1, 0, 0, 0, 0),
(19220, 28267, 100/7, -2, 1, 1, 0, 0, 0, 0),
(19220, 27899, 100/7, -2, 1, 1, 0, 0, 0, 0),
(19220, 23572, 8.5, 0, 1, 1, 0, 0, 0, 0),
(19220, 21907, 2, 0, 1, 1, 0, 0, 0, 0),
(19220, 31910, 1, 0, 1, 1, 0, 0, 0, 0),
(19220, 31901, 1, 0, 1, 1, 0, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE (`entry`=19218) AND (`item`=30436);
INSERT INTO `creature_loot_template`  VALUES (19218, 30436, 100, 0, 1, 1, 0, 0, 0, 0);
DELETE FROM `creature_loot_template` WHERE (`entry`=19710) AND (`item`=30437);
INSERT INTO `creature_loot_template`  VALUES (19710, 30437, 100, 0, 1, 1, 0, 0, 0, 0);
*/