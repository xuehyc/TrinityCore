-- Set script name
UPDATE `creature_template` SET `ScriptName` = 'npc_icc_gauntlet_controller' WHERE `entry` = 37503;

-- Add creature
DELETE FROM `creature` WHERE `guid` = 247100;
INSERT INTO `creature`(`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`) VALUES
(247100, 37503, 631, 15, 4181.5, 2483.99, 211.033, 2.18341, 1209600, 0);

-- Add text
DELETE FROM `creature_text` WHERE `CreatureID` = 37503 AND `GroupID` = 0 AND `ID` = 0;
INSERT INTO `creature_text`(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(37503, 0, 0, 'You must not approach the Frost Queen! Quickly, stop them!', 14, 0, 100, 0, 0, 17167, 37105, 1, 'Sindragosa\'s Ward SAY_INIT');

-- Nerub'ar Champion
UPDATE `creature_template` SET `ScriptName` = 'npc_icc_nerubar_champion' WHERE `entry` = 37501;

-- Nerub'ar Webweaver
UPDATE `creature_template` SET `ScriptName` = 'npc_icc_nerubar_webweaver' WHERE `entry` = 37502;

-- Nerub'ar Broodling
UPDATE `creature_template` SET `ScriptName` = 'npc_icc_nerubar_broodling' WHERE `entry` = 37232;

UPDATE `creature_template` SET `flags_extra` = 512 WHERE `entry` IN (37501, 37502);
UPDATE `creature_template` SET `flags_extra` = `flags_extra`^512 WHERE `entry` IN(38197, 38198);
UPDATE `creature_template` SET `unit_flags` = 64 WHERE `entry` IN (37501, 37502);

-- Frostwarden Warrior
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37228;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 37228);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37228, 0, 0, 0, 0, 0, 100, 0, 6000, 9000, 12000, 15000, 0, 11, 71316, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - In Combat - Cast \'Glacial Strike\''),
(37228, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 30000, 45000, 0, 11, 71325, 0, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - In Combat - Cast \'Frostblade\''),
(37228, 0, 2, 0, 25, 0, 100, 0, 1, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Warrior - On Reset - Set In Combat With Zone');

-- Frostwarden Sorceress
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37229;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 37229);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37229, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2500, 0, 11, 71318, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - In Combat - Cast \'Frostbolt\''),
(37229, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 15000, 22000, 0, 11, 71320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - In Combat - Cast \'Frost Nova\''),
(37229, 0, 2, 0, 0, 0, 100, 20, 9000, 15000, 22000, 35000, 0, 11, 71330, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - In Combat - Cast \'Ice Tomb\' (Heroic Dungeon) (Heroic Raid)'),
(37229, 0, 3, 0, 25, 0, 100, 0, 1, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwarden Sorceress - On Reset - Set In Combat With Zone');

-- Frostblade
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 38199;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 38199);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(38199, 0, 0, 0, 60, 0, 100, 0, 0, 0, 9000, 9000, 0, 11, 71323, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostblade - On Update - Cast \'Frostblade\'');

-- Area Trigger
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5623;
INSERT INTO `areatrigger_scripts`(`entry`, `ScriptName`) VALUES 
(5623, 'at_icc_gauntlet_event');
