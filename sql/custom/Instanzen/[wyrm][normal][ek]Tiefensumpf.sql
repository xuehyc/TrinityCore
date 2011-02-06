
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 36000, `maxhealth` = 36000 where `entry` = 17723;
UPDATE `creature_template` SET `minlevel` = 64, `maxlevel`= 64, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17731;
UPDATE `creature_template` SET `minlevel` = 64, `maxlevel`= 64, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 19632;
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17732;
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 13000, `maxhealth` = 13000 where `entry` = 17730;
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 13000, `maxhealth` = 13000 where `entry` = 17771;
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 13000, `maxhealth` = 13000 where `entry` = 17729;
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17728;

UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 6100, `maxhealth` = 6100 where `entry` = 22299;
-- NPC Heroic

UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 15000, `maxhealth` = 15000 where `entry` = 17724;
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 19000, `maxhealth` = 19000 where `entry` = 20465;
UPDATE `creature_template` SET `minlevel` = 64, `maxlevel`= 64, `minhealth` = 45000, `maxhealth` = 45000 where `entry` = 17734;
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 15000, `maxhealth` = 15000 where `entry` = 17725;
UPDATE `creature_template` SET `minlevel` = 62, `maxlevel`= 62, `minhealth` = 12000, `maxhealth` = 12000 where `entry` = 17871;

UPDATE `creature_template` SET `minlevel` = 65, `maxlevel`= 65, `minhealth` = 7300, `maxhealth` = 7900 where `entry` = 17894;
-- NPC

UPDATE `creature_template` SET `minlevel` = 64, `maxlevel`= 64, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17726;
UPDATE `creature_template` SET `minlevel` = 64, `maxlevel`= 64, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17727;
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel`= 63, `minhealth` = 13000, `maxhealth` = 13000 where `entry` = 17730;

-- Bosse

UPDATE `creature_template` SET `minlevel` = 65, `maxlevel`= 65, `minhealth` = 65000, `maxhealth` = 65000 where `entry` = 17770;
UPDATE `creature_template` SET `minlevel` = 65, `maxlevel`= 65, `minhealth` = 59000, `maxhealth` = 59000 where `entry` = 18105;

UPDATE `creature_template` SET `minlevel` = 65, `maxlevel`= 65, `minhealth` = 53000, `maxhealth` = 53000 where `entry` = 17826;
UPDATE `creature_template` SET `minlevel` = 65, `maxlevel`= 65, `minhealth` = 47000, `maxhealth` = 47000 where `entry` = 17827;

UPDATE `creature_template` SET `minlevel` = 65, `maxlevel`= 65, `minhealth` = 75000, `maxhealth` = 75000 where `entry` = 17882;

-- Bossloot
/*
-- Ghaz'an 
DELETE FROM `creature_loot_template` WHERE (`entry`=18105);
INSERT INTO `creature_loot_template` VALUES
(18105, 24246, 0, 32, 1, 1, 1, 0, 0, 0),
(18105, 24458, 20, -1, 1, 1, 0, 0, 0, 0),
(18105, 24461, 20, -1, 1, 1, 0, 0, 0, 0),
(18105, 24460, 20, -1, 1, 1, 0, 0, 0, 0),
(18105, 24459, 20, -1, 1, 1, 0, 0, 0, 0),
(18105, 24462, 20, -1, 1, 1, 0, 0, 0, 0);

-- Hungarfen
DELETE FROM `creature_loot_template` WHERE (`entry`=17770);
INSERT INTO `creature_loot_template` VALUES
(17770, 24413, 20, -1, 1, 1, 0, 0, 0, 0),
(17770, 24452, 20, -1, 1, 1, 0, 0, 0, 0),
(17770, 24451, 20, -1, 1, 1, 0, 0, 0, 0),
(17770, 27631, 20, -1, 1, 1, 0, 0, 0, 0),
(17770, 24450, 20, -1, 1, 1, 0, 0, 0, 0),
(17770, 24246, 0, 10, 1, 1, 1, 0, 0, 0);

-- Swamplord Musel'ek
DELETE FROM `creature_loot_template` WHERE (`entry`=17826);
INSERT INTO `creature_loot_template` VALUES
(17826, 24454, 20, -1, 1, 1, 0, 0, 0, 0),
(17826, 24453, 20, -1, 1, 1, 0, 0, 0, 0),
(17826, 24457, 20, -1, 1, 1, 0, 0, 0, 0),
(17826, 24455, 20, -1, 1, 1, 0, 0, 0, 0),
(17826, 24456, 20, -1, 1, 1, 0, 0, 0, 0);

-- Claw <Swamplord Musel'ek's Pet>
DELETE FROM `creature_loot_template` WHERE (`entry`=17827);

-- The Black Stalker
DELETE FROM `creature_loot_template` WHERE (`entry`=17882);
INSERT INTO `creature_loot_template` VALUES
(17882, 24248, 0, 46, 1, 1, 1, 0, 0, 0),
(17882, 24246, 0, 29, 1, 1, 1, 0, 0, 0),
(17882, 24464, 20, -1, 1, 1, 0, 0, 0, 0),
(17882, 24466, 20, -1, 1, 1, 0, 0, 0, 0),
(17882, 24463, 20, -1, 1, 1, 0, 0, 0, 0),
(17882, 24481, 20, -1, 1, 1, 0, 0, 0, 0),
(17882, 24465, 20, -1, 1, 1, 0, 0, 0, 0);
*/

-- Spawnzeiten
UPDATE `creature` SET `spawntimesecs`= 36000 where `map` = 546;
UPDATE `creature` SET `spawntimesecs`= 72000 where `id` in (17882, 17827, 17826, 17770, 18105);