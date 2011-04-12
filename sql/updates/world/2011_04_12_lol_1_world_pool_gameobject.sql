-- missing pool
DELETE FROM `pool_template` WHERE `entry` BETWEEN 5217 AND 5238;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(5217,1,'ZulDrak'),
(5218,1,'ZulDrak'),
(5219,1,'ZulDrak'),
(5220,1,'ZulDrak'),
(5221,1,'ZulDrak'),
(5222,1,'ZulDrak'),
(5223,1,'ZulDrak'),
(5224,1,'ZulDrak'),
(5225,1,'ZulDrak'),
(5226,1,'ZulDrak'),
(5227,1,'ZulDrak'),
(5228,1,'ZulDrak'),
(5229,1,'ZulDrak'),
(5230,1,'ZulDrak'),
(5231,1,'ZulDrak'),
(5232,1,'ZulDrak'),
(5233,1,'ZulDrak'),
(5234,1,'ZulDrak'),
(5235,1,'ZulDrak'),
(5236,1,'ZulDrak'),
(5237,1,'ZulDrak'),
(5238,25,'ZulDrak Mineral MASTER');

-- missing motherpool
DELETE FROM `pool_pool` WHERE `pool_id` BETWEEN 5217 AND 5237;
INSERT INTO `pool_pool` (`pool_id`,`mother_pool`,`chance`,`description`) VALUES
(5217,5238,0,'ZulDrak'),
(5218,5238,0,'ZulDrak'),
(5219,5238,0,'ZulDrak'),
(5220,5238,0,'ZulDrak'),
(5221,5238,0,'ZulDrak'),
(5222,5238,0,'ZulDrak'),
(5223,5238,0,'ZulDrak'),
(5224,5238,0,'ZulDrak'),
(5225,5238,0,'ZulDrak'),
(5226,5238,0,'ZulDrak'),
(5227,5238,0,'ZulDrak'),
(5228,5238,0,'ZulDrak'),
(5229,5238,0,'ZulDrak'),
(5230,5238,0,'ZulDrak'),
(5231,5238,0,'ZulDrak'),
(5232,5238,0,'ZulDrak'),
(5233,5238,0,'ZulDrak'),
(5234,5238,0,'ZulDrak'),
(5235,5238,0,'ZulDrak'),
(5236,5238,0,'ZulDrak'),
(5237,5238,0,'ZulDrak');

-- gobject
DELETE FROM `pool_gameobject` WHERE `pool_entry` BETWEEN 5217 AND 5237;
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES

(64922,5217,5,'Saronite'),
(64009,5217,45,'Cobalt, Rich'),
(56158,5217,0,'Cobalt'),

(64954,5218,5,'Saronite'),
(64013,5218,45,'Cobalt, Rich'),
(56185,5218,0,'Cobalt'),

(64956,5219,5,'Saronite'),
(64017,5219,45,'Cobalt, Rich'),
(56186,5219,0,'Cobalt'),

(64972,5220,5,'Saronite'),
(64024,5220,45,'Cobalt, Rich'),
(56187,5220,0,'Cobalt'),

(64980,5221,5,'Saronite'),
(64030,5221,45,'Cobalt, Rich'),
(56188,5221,0,'Cobalt'),

(64981,5222,5,'Saronite'),
(64052,5222,45,'Cobalt, Rich'),
(56189,5222,0,'Cobalt'),

(64982,5223,5,'Saronite'),
(64068,5223,45,'Cobalt, Rich'),
(56190,5223,0,'Cobalt'),

(64986,5224,5,'Saronite'),
(64087,5224,45,'Cobalt, Rich'),
(56191,5224,0,'Cobalt'),

(64987,5225,5,'Saronite'),
(64088,5225,45,'Cobalt, Rich'),
(56192,5225,0,'Cobalt'),

(65000,5226,5,'Saronite'),
(64145,5226,45,'Cobalt, Rich'),
(56211,5226,0,'Cobalt'),

(65001,5227,5,'Saronite'),
(64811,5227,45,'Cobalt, Rich'),
(56238,5227,0,'Cobalt'),

(65002,5228,5,'Saronite'),
(64827,5228,45,'Cobalt, Rich'),
(56239,5228,0,'Cobalt'),

(65034,5229,5,'Saronite'),
(64837,5229,45,'Cobalt, Rich'),
(56529,5229,0,'Cobalt'),

(65035,5230,5,'Saronite'),
(64840,5230,45,'Cobalt, Rich'),
(57962,5230,0,'Cobalt'),

(65039,5231,5,'Saronite'),
(64868,5231,45,'Cobalt, Rich'),
(58107,5231,0,'Cobalt'),

(65050,5232,5,'Saronite'),
(64894,5232,45,'Cobalt, Rich'),
(58108,5232,0,'Cobalt'),

(65057,5233,5,'Saronite'),
(64910,5233,45,'Cobalt, Rich'),
(59284,5233,0,'Cobalt'),

(65075,5234,5,'Saronite'),
(64915,5234,45,'Cobalt, Rich'),
(59539,5234,0,'Cobalt'),

(65096,5235,5,'Saronite'),
(64917,5235,45,'Cobalt, Rich'),
(60171,5235,0,'Cobalt'),

(65097,5236,5,'Saronite'),
(64919,5236,45,'Cobalt, Rich'),
(60178,5236,0,'Cobalt'),

(65109,5237,5,'Saronite'),
(64920,5237,45,'Cobalt, Rich'),
(60450,5237,0,'Cobalt');

-- fix guids 56529,64837,65034 spawned into wall
UPDATE `gameobject` SET `position_x`=5909.37, `position_y`=-1264.63, `position_z`=260.596 WHERE `guid` IN (56529,64837,65034);

-- set spawntime
UPDATE `gameobject` SET `spawntimesecs`=180 WHERE `guid` IN
(66963,66943,66890,
66954,66917,66864,
66948,66909,66856,
64981,64052,56189,
65001,64811,56238,
64954,64013,56185,
65039,64868,58107,
64980,64030,56188,
65057,64910,59284,
65035,64840,57962,
65034,64837,56529,
64972,64024,56187,
66956,66925,66872,
66947,66906,66853,
66949,66910,66857,
66945,66898,66845,
64987,64088,56192,
66958,66934,66881,
65097,64919,60178,
65000,64145,56211,
65002,64827,56239,
65075,64915,59539,
66957,66927,66874,
66959,66937,66884,
64982,64068,56190,
66953,66916,66863,
64956,64017,56186,
64986,64087,56191,
66962,66942,66889,
65050,64894,58108,
66950,66913,66860,
65109,64920,60450,
66961,66939,66886,
66946,66900,66847,
66960,66938,66885,
66952,66915,66862,
66955,66918,66865,
66944,66895,66842,
66964,66933,66891,
65096,64917,60171,
64922,64009,56158,
66951,66914,66861);
