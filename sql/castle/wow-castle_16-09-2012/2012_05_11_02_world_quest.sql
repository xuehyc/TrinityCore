-- Fix quest Drag and Drop / Gefährliche Gewandung 13318
-- Creature 32236 Dark Subjugator / Dunkler Unterwerfer grants credit on spellhit
DELETE FROM `smart_scripts` WHERE `entryorguid` = 32236;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(32236, 0, 1, 2, 8, 0, 100, 0, 5513, 0, 0, 0, 33, 32229, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dark Subjugator - On spellhit 5513 give credit for quest 13318'),
(32236, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Subjugator - On spellhit 5513 despawn');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32236;