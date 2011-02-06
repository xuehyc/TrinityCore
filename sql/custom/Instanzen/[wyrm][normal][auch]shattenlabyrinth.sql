

UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 18633;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 18636;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=17000,`maxhealth`=17000  WHERE `entry`= 18631;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=20000,`maxhealth`=20000  WHERE `entry`= 18635;
UPDATE `creature_template` SET `minlevel`= 71,`maxlevel`= 71,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 18632;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=5300,`maxhealth`=5300  WHERE `entry`= 18641;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 18633;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 18794;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 18637;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=17000,`maxhealth`=17000  WHERE `entry`= 18639;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=17000,`maxhealth`=17000  WHERE `entry`= 18634;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 18640;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=18000,`maxhealth`=18000  WHERE `entry`= 18638;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=8200,`maxhealth`=8200  WHERE `entry`= 18642;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=83000,`maxhealth`=83000  WHERE `entry`= 18796;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=21000,`maxhealth`=21000  WHERE `entry`= 22890;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=8200,`maxhealth`=8200  WHERE `entry`= 18663;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=68000,`maxhealth`=68000  WHERE `entry`= 18848;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=16000,`maxhealth`=16000  WHERE `entry`= 19208;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=20000,`maxhealth`=20000  WHERE `entry`= 19209;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=3700,`maxhealth`=3700  WHERE `entry`= 18797;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=2700,`maxhealth`=2700  WHERE `entry`= 19226;

UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=130000,`maxhealth`=130000  WHERE `entry`= 18731;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=140000,`maxhealth`=140000  WHERE `entry`= 18667;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=110000,`maxhealth`=110000  WHERE `entry`= 18732;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=410000,`maxhealth`=410000  WHERE `entry`= 18708;

-- Spawnzeit setzen üblich 3600sekunden
update creature set spawntimesecs = '36000' where map = 555;
update creature set spawntimesecs = '72000' where map = 555 and id in (18731,18667,18732,18708);
