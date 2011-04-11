-- Fix for Quest 10852 Missing Friends

UPDATE `gameobject_template` SET `data2`=300000 WHERE `entry`=185202;
UPDATE `gameobject` SET `id`=185202 WHERE `guid`=26089;
UPDATE `gameobject` SET `id`=185202 WHERE `guid`=26090;
UPDATE `gameobject` SET `id`=185202 WHERE `guid`=26091;

UPDATE `quest_template` SET `ReqCreatureOrGOId1`=-185202 , `ReqSpellCast1`=38779, `ReqCreatureOrGOCount1`=6 WHERE `entry`=10852;