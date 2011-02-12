-- [Event] Fix some creature flags
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` IN (2784, 29611, 38043, 38066, 37172);