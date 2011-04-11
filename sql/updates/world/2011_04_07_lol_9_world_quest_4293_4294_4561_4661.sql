-- Fix Quests 4293, 4294, 4561, 4661
UPDATE `quest_template` SET `ExclusiveGroup`=0 WHERE `entry`=4293 LIMIT 1;
UPDATE `quest_template` SET `ExclusiveGroup`=0 WHERE `entry`=4294 LIMIT 1;