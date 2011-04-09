-- tempfix quest 3802
UPDATE `creature_template` SET `AIName`='' WHERE `entry`=8888;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=8888;
