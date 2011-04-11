-- Fix for Quest 9375 The Road to Falcon Watch

UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14 WHERE `entry`=16967 LIMIT 1;