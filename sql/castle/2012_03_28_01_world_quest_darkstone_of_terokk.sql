-- Fix quest 10839 Dunkelstein des Skithverstecks / Veil Skith: Darkstone of Terokk
-- Grant external event credit on LoS with creature 22288 Terokkar Quest Target
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22288;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22288 AND `source_type` = 0;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(22288, 0, 0, 0, 10, 0, 100, 0, 0, 15, 1000, 1000, 15, 10839, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Quest Target - Complete Quest 10839 on SpellHit');