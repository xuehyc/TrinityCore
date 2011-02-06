-- NPC
UPDATE `creature_template` SET `minlevel` = 67, `maxlevel`= 68, `minhealth` = 9400, `maxhealth` = 9800 where `entry` = 18983;
UPDATE `creature_template` SET `minlevel` = 67, `maxlevel`= 68, `minhealth` = 5800, `maxhealth` = 6200 where `entry` = 17952;
UPDATE `creature_template` SET `minlevel` = 67, `maxlevel`= 68, `minhealth` = 9400, `maxhealth` = 9700 where `entry` = 18982;

UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 6900, `maxhealth` = 6900 where `entry` = 17835;
UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 72, `minhealth` = 120000, `maxhealth` = 120000 where `entry` = 21697;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 5500, `maxhealth` = 5500 where `entry` = 17892;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 14000, `maxhealth` = 14000 where `entry` = 18994;
UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 70, `minhealth` = 150000, `maxhealth` = 150000 where `entry` = 21698;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 11000, `maxhealth` = 11000 where `entry` = 18995;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 3100, `maxhealth` = 3100 where `entry` = 21818;
UPDATE `creature_template` SET `minlevel` = 71, `maxlevel`= 71, `minhealth` = 60000, `maxhealth` = 60000 where `entry` = 21104;
UPDATE `creature_template` SET `minlevel` = 71, `maxlevel`= 71, `minhealth` = 75000, `maxhealth` = 75000 where `entry` = 17839;

UPDATE `creature_template` SET `minlevel` = 70, `maxlevel`= 70, `minhealth` = 7000, `maxhealth` = 7000 where `entry` = 17918;


UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 72, `minhealth` = 200000, `maxhealth` = 200000 where `entry` = 17881;
UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 72, `minhealth` = 120000, `maxhealth` = 120000 where `entry` = 17879;
UPDATE `creature_template` SET `minlevel` = 72, `maxlevel`= 72, `minhealth` = 150000, `maxhealth` = 150000 where `entry` = 17880;

-- Spawnzeit setzen üblich 3600sekunden
update creature set spawntimesecs = '36000' where map = 269 ;
update creature set spawntimesecs = '72000' where map = 269  and id in (17879,17880,17881);


update creature_template set flags_extra = 0 where entry = 20201;
update creature_template set flags_extra = 1 where entry = 15608;
update creature_template set flags_extra = 0 where entry = 17918;