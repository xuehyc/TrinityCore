-- Add script to arms.
UPDATE `creature_template` SET `ScriptName`='npc_kologarn_arm' WHERE `entry` IN (32933,32934);
-- Add achievement scripts to corresponding criterias
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10284, 10722, 10285, 10095, 10290, 10133);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10284, 11, 0, 0, 'achievement_disarmed'),
(10722, 11, 0, 0, 'achievement_disarmed_25'),
(10285, 11, 0, 0, 'achievement_with_open_arms'),
(10095, 11, 0, 0, 'achievement_with_open_arms_25'),
(10290, 11, 0, 0, 'achievement_rubble_and_roll'),
(10133, 11, 0, 0, 'achievement_rubble_and_roll_25');
