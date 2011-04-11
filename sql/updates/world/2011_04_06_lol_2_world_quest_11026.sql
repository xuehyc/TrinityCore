-- Fix Quest 11026 Banish the Demons Reputation Value
UPDATE `quest_template` SET `RequiredMinRepValue`=9000 WHERE `entry`=11026 LIMIT 1;