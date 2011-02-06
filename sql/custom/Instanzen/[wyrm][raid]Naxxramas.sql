-- *******************************************************************************************
-- Naxxramas
-- Delete Copse Scarabs
delete from `creature` where `id`= 16698;
UPDATE `creature_template` SET `mindmg` = 400, `maxdmg` = 600, `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), `mindmg` = ROUND(`mindmg` - `attackpower` / 7), `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) WHERE `entry` = 16698;
-- Delete Gothik adds
delete from `creature` where `id`in (16124,16125,16126,16127,16148,16149,16150);
-- Faction Gothik adds
update `creature_template` set faction_A = 21, faction_H = 21 where `entry` in (16124,16125,16126,16127,16148,16149,16150);
-- Grobbulus Wolke
update `creature_template` set faction_A = 21, faction_H = 21 where `entry` in (16363);
-- Razevous Damage
UPDATE `creature_template` SET 
    `mindmg` = 13000, 
    `maxdmg` = 18000, 
    `attackpower` = ROUND((`mindmg` + `maxdmg`) / 4 * 7), 
    `mindmg` = ROUND(`mindmg` - `attackpower` / 7), 
    `maxdmg` = ROUND(`maxdmg` - `attackpower` / 7) 
  WHERE `entry` = 16061;
-- several mobs
delete from `creature` where `id` in (16983,16981,16982,16984);
update `creature_template` set faction_A = 21, faction_H = 21 where `entry` in (16983,16981,16982,16984); -- Noth Skelletions
delete from `creature` where `id` in (16286);
update `creature_template` set faction_A = 21, faction_H = 21 where `entry` in (16286); -- Lortheb Spores
delete from `creature` where `id` in (16486); -- Web Wrap
update `creature_template` set faction_A = 21, faction_H = 21 where `entry` in (16486,17055); -- Maexxna
-- loot ++
INSERT INTO `creature_loot_template` VALUES 
(15956, 1, 100, 1, -15956, 1, 0, 0, 0, 0), -- Anub
(15953, 1, 100, 1, -15953, 1, 0, 0, 0, 0),
(15952, 1, 100, 1, -90040, 1, 0, 0, 0, 0),
(16028, 1, 100, 1, -16028, 1, 0, 0, 0, 0), -- patch
(15931, 1, 100, 1, -15931, 1, 0, 0, 0, 0), 
(15932, 1, 100, 1, -15932, 1, 0, 0, 0, 0), 
(15928, 1, 100, 1, -90041, 1, 0, 0, 0, 0),
(16061, 1, 100, 1, -16061, 1, 0, 0, 0, 0),-- raze
(16060, 1, 100, 1, -16060, 1, 0, 0, 0, 0),
(181366, 2, 100, 1, -95002, 1, 0, 0, 0, 0),
(15954, 1, 100, 1, -15954, 1, 0, 0, 0, 0), -- noth
(15936, 1, 100, 1, -15936, 1, 0, 0, 0, 0),
(16011, 1, 100, 1, -90042, 1, 0, 0, 0, 0),
(15990, 1, 100, 0, -90044, 1, 0, 0, 0, 0);-- kel
update creature_loot_template set ChanceOrQuestChance = 100 where item = 22726;
update gameobject_loot_template set ChanceOrQuestChance = 100 where item = 22726;

-- controller
REPLACE INTO `creature_template` (`entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `IconName`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `civilian`, `flag1`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `ScriptName`) VALUES (1000001, 4629, 4629, 4629, 4629, 'Seele von Naxxramas', '', '', 60, 60, 1000, 1000, 1000, 1000, 1000, 35, 35, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, '', '', '', '', 0, 0, 0, 6, 1, 2, 1000001, 1000001, 1000001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 0, 10, 1000001, -1, 'npc_naxx_wyrm');
-- death state
update creature set deathState = 1 where id = 16381;

update areatrigger_teleport set target_map = 0, target_position_x = 3118.5715 , target_position_y = -3754.5629 , target_position_z = 133.6039, target_orientation = 4.1361 where id = 4156;

update creature set spawntimesecs = '72000' where map = 533;
update gameobject set spawntimesecs = '72000' where map = 533 and id = 181366;
update gameobject set spawntimesecs = '72000' where map = 533 and id in (181126,181195,181167,181235,181197,181209,181123,181120,181121,181124,181125,181170,181119,181200,181201,181202,181203,181241,181225,181228,181496,181366);

update `creature_template` set mechanic_immune_mask = 113983323 where `entry` in (15956,15953,15952,16028,15931,15932,15928,16061,16060,16064,16065,16062,16063,15954,15936,16011,15989,15990);
update `creature_template` set maxlevel = 63, minlevel = 63  where `entry` in (15956,15953,15952,16028,15931,15932,15928,15930,15929,16061,16060,16064,16065,16062,16063,15954,15936,16011,15989,15990);
update `creature_template` set maxlevel = 73, minlevel = 73 where `entry` = 16363;
-- *******************************************************************************************
-- Doors
-- *******************************************************************************************
-- Spawns
-- Delete existing Spawns
delete from gameobject where id in (181126,181195,181167,181235,181197,181209,181123,181120,181121,181124,181125,181170,181119,181200,181201,181202,181203,181241,181225,181228,181496);
insert into `gameobject` (`guid`, `id`, `map`,`spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values
-- 181126 Anub'Rekhan Door
('333000','181126','533','1','3202.7','-3476.08','287.061','0','0','0','0','0','6','0','1'),
-- 181195 Anub'Rekhan Gate
('333001','181195','533','1','3143.53','-3572.74','286','5.49778','0','0','0.382687','-0.923878','6','0','1'),
-- 181167 Grand Widow Faerlina Door
('333002','181167','533','1','3120.78','-3791','273.93','0','0','0','0','0','6','0','1'),
-- 181235 Grand Widow Faerlina - Web
('333003','181235','533','1','3322.53','-3695.4','259','3.14159','0','0','1','3.13916e-007','6','0','0'),
-- 181209 Maexxna - Outer Web Door 
('333004','181209','533','1','3425.68','-3846.1','309.109','3.14159','0','0','1','3.13916e-007','6','0','1'),
-- 181197 Maexxna - Inner Web Door
('333005','181197','533','1','3446.72','-3860.3','308.76','3.14159','0','0','0','0','6','0','1'),
-- 181124 Vaccuum - Enter Gate
('333006','181124','533','1','2765.75','-3384.38','267.685','0','0','0','0','1','6','0','1'),
-- 181125 Vaccuum - Exit Gate
('333007','181125','533','1','2617.74','-3336.81','267.684','0','0','0','0','1','25','0','1'),
-- 181170 Vaccuum - Combat Gate
('333008','181170','533','1','2692.04','-3361.4','267.684','0','0','0','0','1','6','0','1'),
-- 181119 Deathknight Door
('333009','181119','533','1','2587.76','-3017.16','240.5','3.14159','0','0','1','3.13916e-007','6','0','1'),
-- 181200 Noth - Entry Door
('333010','181200','533','1','2737.83','-3489.78','262.107','0','0','0','0','1','25','0','0'),
-- 181201 Noth - Exit Door
('333011','181201','533','1','2684.37','-3559.83','261.944','1.57079','0','0','0.707105','0.707109','25','0','1'),
-- 181202 Heigan the Unclean - Entry Door
('333012','181202','533','1','2823.47','-3685.07','274.079','0','0','0','0','1','25','0','0'),
-- 181203 Heigan the Unclean - Exit Door
('333013','181203','533','1','2771.42','-3737.02','273.619','1.57079','0','0','0.707105','0.707109','25','0','1'),
-- 181496 Heigan the Unclean - Exit Gate
('333020','181496','533','1','2909.82','-3817.88','273.926','0','0','0','0','1','6','0','1'),
-- 181241 Loatheb - Entrance Door
('333014','181241','533','1','2909.73','-3947.75','273.924','0','0','0','0','1','6','0','1'),
-- 181123 Patchwork - Exit Door
('333015','181123','533','1','3318.27','-3254.42','293.786','1.57079','0','0','0.707105','0.707109','6','0','1'),
-- 181120 Gluth - Exit Door
('333016','181120','533','1','3338.63','-3101.36','297.0','3.14159','0','0','1','1.26759e-006','6','0','1'),
-- 181121 Thaddius Door
('333017','181121','533','1','3424.77','-3014.72','295.608','0','0','0','0','1','25','0','1'),
-- 181225 Frostwyrm Waterfall Door
('333018','181225','533','1','3537.32','-5160.48','143.619','4.50667','0','0','0.775973','-0.630766','25','0','1'),
-- 181228 KelThuzad Door 
('333019','181228','533','1','3635.34','-5090.31','143.206','1.37','0','0','0.632673','0.774419','6','0','1');

-- aendere size ... Tuer Passt nicht und man konnte vorher an den Rand vorbei
update gameobject_template set size = 1.2 where entry = 181201;
-- Türen und Truhe auf Feindlich damit man sie nicht mit klick öffnen kann
update gameobject_template set faction = 14 where entry in (181126,181195,181167,181235,181197,181209,181123,181120,181121,181124,181125,181170,181119,181200,181201,181202,181203,181241,181225,181228,181496,181366);
-- *******************************************************************************************
/*
-- Script um Alle Naxxdrops zu löschen
delete from item_instance where guid in (select item from character_inventory where item_template in 
(22938,22939,22935,22936,22937,
22941,22942,22943,22940,22806,
22954,23220,22947,22807,22804,
22961,22815,22820,22960,22818,
22967,22803,22968,22988,22810,
22981,22983,22813,22994,23075,
23001,22808,23070,23000,22801,
23009,23014,23018,23017,23004,23219,
23073,23021,23020,23023,23032,
23025,23027,22809,23071,22691,22811,
23030,23028,22816,23006,23029,23031,23005,
23068,23033,23035,23036,23019,
23038,23042,23037,23039,22800,
23050,23045,23049,23048,23043,23242,23047,23041,23040,23046,23072,
22799,23064,23062,23056,22812,23067,22802,23063,23061,23066,23060,22821,23065,23053,23577,22798,22819,23059,23057,23054));

delete from character_inventory where item_template in 
(22938,22939,22935,22936,22937,
22941,22942,22943,22940,22806,
22954,23220,22947,22807,22804,
22961,22815,22820,22960,22818,
22967,22803,22968,22988,22810,
22981,22983,22813,22994,23075,
23001,22808,23070,23000,22801,
23009,23014,23018,23017,23004,23219,
23073,23021,23020,23023,23032,
23025,23027,22809,23071,22691,22811,
23030,23028,22816,23006,23029,23031,23005,
23068,23033,23035,23036,23019,
23038,23042,23037,23039,22800,
23050,23045,23049,23048,23043,23242,23047,23041,23040,23046,23072,
22799,23064,23062,23056,22812,23067,22802,23063,23061,23066,23060,22821,23065,23053,23577,22798,22819,23059,23057,23054);
*/
