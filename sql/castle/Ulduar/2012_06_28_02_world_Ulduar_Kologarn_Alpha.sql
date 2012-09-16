-- Add script to arms.
UPDATE `creature_template` SET `ScriptName`='npc_kologarn_arm' WHERE `entry` IN (32933,32934);
-- Prevent NPC_ARM_SWEEP_STALKER from attacking players.
UPDATE `creature_template` SET `unit_flags`=33554432|256 WHERE `entry`=33661;
-- Update inhabit-type.
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (32930,33909);
-- Add achievement scripts to corresponding criterias
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (10284, 10722, 10285, 10095, 10290, 10133);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES 
(10284, 11, 0, 0, 'achievement_disarmed'),
(10284, 12, 0, 0, ''),
(10722, 11, 0, 0, 'achievement_disarmed_25'),
(10722, 12, 1, 0, ''),
(10285, 11, 0, 0, 'achievement_with_open_arms'),
(10285, 12, 0, 0, ''),
(10095, 11, 0, 0, 'achievement_with_open_arms_25'),
(10095, 12, 1, 0, ''),
(10290, 11, 0, 0, 'achievement_rubble_and_roll'),
(10290, 12, 0, 0, ''),
(10133, 11, 0, 0, 'achievement_rubble_and_roll_25'),
(10133, 12, 1, 0, '');
