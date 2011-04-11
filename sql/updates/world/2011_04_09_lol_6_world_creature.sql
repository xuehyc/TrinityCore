-- tempfix quest 3912
UPDATE `creature_template` SET `AIName`='' WHERE `entry`=9299;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=9299;
