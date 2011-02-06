
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 17356;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=4500,`maxhealth`=4500  WHERE `entry`= 17357;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=10000,`maxhealth`=10000  WHERE `entry`= 17083;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=8900,`maxhealth`=8900  WHERE `entry`= 17621;
UPDATE `creature_template` SET `minlevel`= 67,`maxlevel`= 67,`minhealth`=9400,`maxhealth`=9400  WHERE `entry`= 17669;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=8800,`maxhealth`=8800  WHERE `entry`= 17623;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=14000,`maxhealth`=14000  WHERE `entry`= 16594;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=14000,`maxhealth`=14000  WHERE `entry`= 17694;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=8700,`maxhealth`=8700  WHERE `entry`= 17622;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=9300,`maxhealth`=9300  WHERE `entry`= 17427;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=20000,`maxhealth`=20000  WHERE `entry`= 17695;
UPDATE `creature_template` SET `minlevel`= 71,`maxlevel`= 71,`minhealth`=28000,`maxhealth`=28000  WHERE `entry`= 17461;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=20000,`maxhealth`=20000  WHERE `entry`= 16593;
UPDATE `creature_template` SET `minlevel`= 71,`maxlevel`= 71,`minhealth`=28000,`maxhealth`=28000  WHERE `entry`= 17465;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=28000,`maxhealth`=28000  WHERE `entry`= 17671;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=27000,`maxhealth`=27000  WHERE `entry`= 17301;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=20000,`maxhealth`=20000  WHERE `entry`= 17464;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 17420;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=20000,`maxhealth`=20000  WHERE `entry`= 17670;
UPDATE `creature_template` SET `minlevel`= 70,`maxlevel`= 70,`minhealth`=27000,`maxhealth`=27000  WHERE `entry`= 16700;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 16699;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 16523;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=8600,`maxhealth`=8600  WHERE `entry`= 17693;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 16507;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=19000,`maxhealth`=19000  WHERE `entry`= 16704;
UPDATE `creature_template` SET `minlevel`= 69,`maxlevel`= 69,`minhealth`=6800,`maxhealth`=6800  WHERE `entry`= 17462;

UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=110000,`maxhealth`=110000  WHERE `entry`= 16807;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=150000,`maxhealth`=150000  WHERE `entry`= 16809;
UPDATE `creature_template` SET `minlevel`= 72,`maxlevel`= 72,`minhealth`=180000,`maxhealth`=180000  WHERE `entry`= 16808;


-- Spawnzeit setzen üblich 3600sekunden
update creature set spawntimesecs = '36000' where map = 540;
update creature set spawntimesecs = '72000' where map = 540 and id in (16807,16809,16808);
/*
-- Netherkurse loot
DELETE FROM `creature_loot_template` WHERE (`entry`=16807);
INSERT INTO `creature_loot_template` VALUES
(16807, 27519, 20, -1, 1, 1, 0, 0, 0, 0),
(16807, 27520, 20, -1, 1, 1, 0, 0, 0, 0),
(16807, 27518, 20, -1, 1, 1, 0, 0, 0, 0),
(16807, 27517, 20, -1, 1, 1, 0, 0, 0, 0),
(16807, 27521, 20, -1, 1, 1, 0, 0, 0, 0),
(16807, 23735, 0, 100, 1, 1, 1, 0, 0, 0),
(16807, 24312, 1, 0, 1, 1, 0, 0, 0, 0);

-- Omrogg loot
DELETE FROM `creature_loot_template` WHERE (`entry`=16809);
INSERT INTO `creature_loot_template` VALUES
(16809, 27525, 20, -1, 1, 1, 0, 0, 0, 0),
(16809, 27524, 20, -1, 1, 1, 0, 0, 0, 0),
(16809, 27526, 20, -1, 1, 1, 0, 0, 0, 0),
(16809, 27868, 20, -1, 1, 1, 0, 0, 0, 0),
(16809, 27802, 20, -1, 1, 1, 0, 0, 0, 0),
(16809, 30829, 0, 100, 1, 1, 1, 0, 0, 0);

-- Bladefist loot
DELETE FROM `creature_loot_template` WHERE (`entry`=16808);
INSERT INTO `creature_loot_template` VALUES
(16808, 23723, 0, 100, 1, 1, 0, 0, 0, 0),
(16808, 27534, 50/3, -1, 1, 1, 0, 0, 0, 0),
(16808, 27528, 50/3, -2, 1, 1, 0, 0, 0, 0),
(16808, 27540, 50/3, -1, 1, 1, 0, 0, 0, 0),
(16808, 27536, 50/3, -2, 1, 1, 0, 0, 0, 0),
(16808, 27527, 50/3, -1, 1, 1, 0, 0, 0, 0),
(16808, 27537, 50/3, -2, 1, 1, 0, 0, 0, 0),
(16808, 27474, 50/3, -2, 1, 1, 0, 0, 0, 0),
(16808, 27529, 50/3, -1, 1, 1, 0, 0, 0, 0),
(16808, 27531, 50/3, -2, 1, 1, 0, 0, 0, 0),
(16808, 27535, 50/3, -2, 1, 1, 0, 0, 0, 0),
(16808, 27533, 50/3, -1, 1, 1, 0, 0, 0, 0),
(16808, 27538, 50/3, -1, 1, 1, 0, 0, 0, 0),
(16808, 23572, 7, 0, 1, 1, 0, 0, 0, 0),
(16808, 31910, 1, 0, 1, 1, 0, 0, 0, 0),
(16808, 31901, 1, 0, 1, 1, 0, 0, 0, 0),
(16808, 31892, 1, 0, 1, 1, 0, 0, 0, 0);
*/
update creature_template set scriptname = "boss_grand_warlock_nethekurse" where entry = 16807;
update creature_template set scriptname = "mob_nethe_shadowfissure" where entry = 17471;

/* special spawns */
update creature set spawntimesecs = 240 where id = 17356;
update creature set spawntimesecs = 30 where id = 17357;

/* Tür */

DELETE FROM `gameobject` Where guid in (540000,540001);
insert into gameobject 
(guid,id,map,spawnMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state)
values(540000,182539,540,3,142.516,266.37,-11.600,3.15959,0, 0, 0.99996, -0.00899712,25, 0, 1);

update gameobject_template set flags = 2 where entry = 182539;
update gameobject_template set faction = 14 where entry =182540;


insert into `gameobject` 
(`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) 
values
('540001','182540','540','3','215','266.1','-11.5','0','0','0','0','1','25','0','1');


/*
/* Falls Ruf Verbuggt sein sollte */
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 0,`RewOnKillRepValue2`= 0  WHERE `creature_id`= 17356;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 0,`RewOnKillRepValue2`= 0  WHERE `creature_id`= 17357;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17083;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17621;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17669;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17623;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 16594;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17694;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17622;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17427;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17695;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17461;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 16593;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17465;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17671;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17301;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17464;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17420;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17670;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 16700;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 16699;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 16523;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17693;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 16507;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 16704;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= 12,`RewOnKillRepValue2`= 12  WHERE `creature_id`= 17462; 
*/
