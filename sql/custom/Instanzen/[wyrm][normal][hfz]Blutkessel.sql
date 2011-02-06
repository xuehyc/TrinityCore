/* HP und LEVEL aller Mobs und Bosse auf Normalnivea */
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 15000, `maxhealth` = 15000 where `entry` = 17400;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 4100,  `maxhealth` = 4100  where `entry` = 17401;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 4200,  `maxhealth` = 4200  where `entry` = 17477;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 15000, `maxhealth` = 15000 where `entry` = 17370;
UPDATE `creature_template` SET `minlevel` = 60, `maxlevel`= 60, `minhealth` = 10000, `maxhealth` = 10000 where `entry` = 17416; /* Horde Freundlich */
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 12000, `maxhealth` = 12000 where `entry` = 17397;
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 6800,  `maxhealth` = 6800  where `entry` = 17653;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 10000, `maxhealth` = 10000 where `entry` = 17371;
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17624;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 7500,  `maxhealth` = 7500  where `entry` = 17491;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 15000, `maxhealth` = 15000 where `entry` = 17626;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 4100,  `maxhealth` = 4100  where `entry` = 17399;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 10000, `maxhealth` = 10000 where `entry` = 17395;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 10000, `maxhealth` = 19000 where `entry` = 17414;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 7100,  `maxhealth` = 7100  where `entry` = 17398;
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 10000, `maxhealth` = 10000 where `entry` = 17429;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 4200,  `maxhealth` = 42000 where `entry` = 19016;
UPDATE `creature_template` SET `minlevel` = 61, `maxlevel`= 61, `minhealth` = 15000, `maxhealth` = 15000 where `entry` = 18894;

UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 31000, `maxhealth` = 31000 where `entry` = 17380;
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 35000, `maxhealth` = 35000 where `entry` = 17377;
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 38000, `maxhealth` = 38000 where `entry` = 17381;

/* Loots Quelle WoWHead */
/*
-- Broggok
DELETE FROM `creature_loot_template` WHERE (`entry`=17380);
INSERT INTO `creature_loot_template` VALUES
(17380, 24389, 20, -1, 1, 1, 0, 0, 0, 0),
(17380, 24390, 20, -1, 1, 1, 0, 0, 0, 0),
(17380, 24391, 20, -1, 1, 1, 0, 0, 0, 0),
(17380, 24392, 20, -1, 1, 1, 0, 0, 0, 0),
(17380, 24393, 20, -1, 1, 1, 0, 0, 0, 0);

-- Kelidan
DELETE FROM `creature_loot_template` WHERE (`entry`=17377);
INSERT INTO `creature_loot_template` VALUES
(17377, 23894, 0, 100, 1, 1, 1, 0, 0, 0),
(17377, 24394, 20, -1, 1, 1, 0, 0, 0, 0),
(17377, 24395, 20, -1, 1, 1, 0, 0, 0, 0),
(17377, 24396, 20, -1, 1, 1, 0, 0, 0, 0),
(17377, 24397, 20, -1, 1, 1, 0, 0, 0, 0),
(17377, 24398, 20, -1, 1, 1, 0, 0, 0, 0);

-- Schöpfer
DELETE FROM `creature_loot_template` WHERE (`entry`=17381);
INSERT INTO `creature_loot_template` VALUES
(17381, 23894, 0, 100, 1, 1, 1, 0, 0, 0),
(17381, 24384, 20, -1, 1, 1, 0, 0, 0, 0),
(17381, 24385, 20, -1, 1, 1, 0, 0, 0, 0),
(17381, 24386, 20, -1, 1, 1, 0, 0, 0, 0),
(17381, 24387, 20, -1, 1, 1, 0, 0, 0, 0),
(17381, 24388, 20, -1, 1, 1, 0, 0, 0, 0);
*/
/* SpawnZeit Einstellen */
/*Bosse 2 Stunden normale Mobs 1 Stunde das wird sich hoffentlich auch bald ändern */
UPDATE `creature` SET `spawntimesecs`= 36000 where `map` = 542;
UPDATE `creature` SET `spawntimesecs`= 72000 where `id` in (17380,17377,17381);


update instance_template set Script = 'instance_blood_furnace' where map = 542;
update gameobject_template set faction = 14 where entry in (181766,181811,181812,181823);