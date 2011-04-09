-- Fix gameobject_loot from GO 'The Thunderspike' #184729 (Quest 10526)
UPDATE `gameobject_template` SET `questItem1`=30435 WHERE `entry`=184729;