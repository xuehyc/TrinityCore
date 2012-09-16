-- @DorianGrey
-- Fixed receiving of buff "Understanding Ravenspeech" for "Whispers of the Raven God" (Q10607).
-- Buff should be received on killing a Grishna Arakkoa, regardless of the player having this quest active or not.

-- Step 1: Enable SmartAI on all related creatures.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (19989, 19990, 20329, 22232);

-- Step 2: Add the corresponding smart_script entries.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19989, 19990, 20329, 22232) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19989, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, 37466, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Understanding Ravenspeech on Player'),
(19990, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, 37466, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Understanding Ravenspeech on Player'),
(20329, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, 37466, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Understanding Ravenspeech on Player'),
(22232, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, 37466, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Understanding Ravenspeech on Player');
