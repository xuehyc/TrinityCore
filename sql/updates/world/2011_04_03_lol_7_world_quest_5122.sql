-- Fix for Quest 5122 The Medaillon of Faith
UPDATE `gameobject_template` SET `flags`=0 WHERE `entry`=176112 LIMIT 1;