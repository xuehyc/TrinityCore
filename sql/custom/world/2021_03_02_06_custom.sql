UPDATE `creature` SET `spawnDifficulties` = '2' WHERE `map` = 940;
UPDATE `creature` SET `spawnDifficulties` = '1,2' WHERE `map`= 643;
UPDATE `creature` SET `spawnDifficulties` = '0' WHERE `map` IN (0,1,870,1220,1116,1464,1064,646);

UPDATE `gameobject` SET `spawnDifficulties` = '2' WHERE `map` = 940;
UPDATE `gameobject` SET `spawnDifficulties` = '1,2' WHERE `map` = 643;
UPDATE `gameobject` SET `spawnDifficulties` = '0' WHERE `map` IN (0,1,870,1220,1116,1464,1064,646);

UPDATE `gameobject` SET `spawnDifficulties` = '3,4,5,6' WHERE `guid` IN
(211120,
211119,
211118,
211117,
211116,
211115,
211114,
211113,
211112,
211111,
211110,
211109,
211108,
211107,
211106,
211105,
211104,
211103,
211102,
211101,
211100,
211099,
211098,
211097,
211096,
211095,
211094,
211093,
211092,
211091,
211090,
211089,
211088,
211087,
211086,
211085,
211084,
211083,
211082);
