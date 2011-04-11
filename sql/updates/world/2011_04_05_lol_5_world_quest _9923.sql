-- Fix Quest 9923 Free Corki
UPDATE `quest_template` SET `ReqSpellCast1`=32249, `ReqCreatureOrGOId1`=-182349 WHERE `entry`=9923 LIMIT 1;
UPDATE `gameobject_template` SET `data2`=300000 WHERE `entry`=182349;