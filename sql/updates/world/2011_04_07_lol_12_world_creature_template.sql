-- Fix NPC 26467 being rooted
UPDATE `creature_template` SET `dynamicflags`=0 WHERE `entry`=26467 LIMIT 1;