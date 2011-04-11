-- Fix Quest 6129 Curing the Sick
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=12296 WHERE `entry`=6129 LIMIT 1;