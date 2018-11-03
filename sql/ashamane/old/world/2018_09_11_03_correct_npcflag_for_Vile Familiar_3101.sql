-- fix - corect npcflag for Vile Familiar - 3101
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=3101;