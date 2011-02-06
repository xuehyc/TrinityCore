-- NPC
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 45000, `maxhealth` = 45000 where `entry` = 21694;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 20000, `maxhealth` = 20000 where `entry` = 17721;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 6200, `maxhealth` = 6200 where `entry` = 21338;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 20000, `maxhealth` = 20000 where `entry` = 17800;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17803;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 16000, `maxhealth` = 16000 where `entry` = 17801;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 20000, `maxhealth` = 20000 where `entry` = 17805;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 22000, `maxhealth` = 22000 where `entry` = 17722;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 20000, `maxhealth` = 20000 where `entry` = 17802;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 19000, `maxhealth` = 19000 where `entry` = 17917;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 20000, `maxhealth` = 20000 where `entry` = 17799;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 10000, `maxhealth` = 10000 where `entry` = 17954; -- Für 3ten Boss
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 21000, `maxhealth` = 21000 where `entry` = 22891;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 2800, `maxhealth` = 2800 where `entry` = 21696;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 7100, `maxhealth` = 7100 where `entry` = 17723; -- Für 2ten Boss
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 33000, `maxhealth` = 33000 where `entry` = 21695;

Delete From creature where id = 17723; -- Mechaniker werden von Script gespawnt

-- Bosse

UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 72, `minhealth` = 100000, `maxhealth` = 100000 where `entry` = 17797;
UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 72, `minhealth` = 100000, `maxhealth` = 100000 where `entry` = 17796;
UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 72, `minhealth` = 160000, `maxhealth` = 160000 where `entry` = 17798;


-- Bossloot
/*Tespia*/
/*
DELETE FROM `creature_loot_template` WHERE (`entry`=17797);
INSERT INTO `creature_loot_template` VALUES
(17797, 27508, 20, -1, 1, 1, 0, 0, 0, 0),
(17797, 27783, 20, -1, 1, 1, 0, 0, 0, 0),
(17797, 27787, 20, -1, 1, 1, 0, 0, 0, 0),
(17797, 27784, 20, -1, 1, 1, 0, 0, 0, 0),
(17797, 27789, 20, -1, 1, 1, 0, 0, 0, 0),
(17797, 30828, 0, 100, 1, 1, 1, 0, 0, 0),
(17797, 24462, 2, 0, 1, 1, 0, 0, 0, 0);

 -- Steamrigger
DELETE FROM `creature_loot_template` WHERE (`entry`=17796);
INSERT INTO `creature_loot_template` VALUES
(17796, 27794, 20, -1, 1, 1, 0, 0, 0, 0),
(17796, 27790, 20, -1, 1, 1, 0, 0, 0, 0),
(17796, 27791, 20, -1, 1, 1, 0, 0, 0, 0),
(17796, 27793, 20, -1, 1, 1, 0, 0, 0, 0),
(17796, 27792, 20, -1, 1, 1, 0, 0, 0, 0),
(17796, 23887, 2, 0, 1, 1, 0, 0, 0, 0);

 -- Kalithresh
DELETE FROM `creature_loot_template` WHERE (`entry`=17798);
INSERT INTO `creature_loot_template` VALUES
(17798, 27805, 20, -1, 1, 1, 0, 0, 0, 0),
(17798, 27799, 20, -1, 1, 1, 0, 0, 0, 0),
(17798, 27806, 20, -1, 1, 1, 0, 0, 0, 0),
(17798, 27795, 20, -1, 1, 1, 0, 0, 0, 0),
(17798, 27804, 20, -1, 1, 1, 0, 0, 0, 0),

(17798, 27737, 100/7, -2, 1, 1, 0, 0, 0, 0),
(17798, 27738, 100/7, -2, 1, 1, 0, 0, 0, 0),
(17798, 27510, 100/7, -2, 1, 1, 0, 0, 0, 0),
(17798, 27475, 100/7, -2, 1, 1, 0, 0, 0, 0),
(17798, 28203, 100/7, -2, 1, 1, 0, 0, 0, 0),
(17798, 27801, 100/7, -2, 1, 1, 0, 0, 0, 0),
(17798, 27874, 100/7, -2, 1, 1, 0, 0, 0, 0),

(17798, 23572, 6, 0, 1, 1, 0, 0, 0, 0),
(17798, 24313, 2, 0, 1, 1, 0, 0, 0, 0),
(17798, 31882, 1, 0, 1, 1, 0, 0, 0, 0),
(17798, 31901, 1, 0, 1, 1, 0, 0, 0, 0),
(17798, 31892, 1, 0, 1, 1, 0, 0, 0, 0);
*/
-- Spawnzeiten
UPDATE `creature` SET `spawntimesecs`= 36000 where `map` = 545;
UPDATE `creature` SET `spawntimesecs`= 72000 where `id` in (17797, 17796, 17798);


-- WICHTIG
update creature_template set RegenHealth = 0 where entry in (17954,20631);
