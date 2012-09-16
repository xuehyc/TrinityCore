-- Set NPC 38490 Rotting Frost Giant / Verrottender Frostriese to scripted AI again, implement anti fall down code
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 38490;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_rotting_frost_giant' WHERE `entry` = 38490;

-- Misc fixes for svalna encounter
DELETE FROM `creature` WHERE `id` = 50040;
DELETE FROM `gameobject` WHERE `id` = 201919;
INSERT INTO `gameobject` (guid, id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(150352, 201919, 631, 15, 1, 4356.45, 2653.27, 350.888, -1.5708, 0, 0, 1, 0, 6000, 255, 0);
UPDATE `creature_template` SET `unit_flags` = 32768, `flags_extra` = 0 WHERE `entry` IN (38125, 38130);
UPDATE `creature_template` SET `unit_flags` = 32832, `flags_extra` = 0 WHERE `entry` IN (37134, 37133, 37132, 37127, 38126, 38132, 38133, 38131);
UPDATE `creature_template` SET `unit_flags` = 66, `mechanic_immune_mask` = 650853247, `flags_extra` = 1 WHERE `entry` IN (37126, 38258);
UPDATE `creature_addon` SET `auras` = '70203' WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 37126);

-- SAI scripts for trash, taken from http://pastebin.com/GJ71J5Pw and modified
-- Ymirjar Huntress : 37134 / 38131
DELETE FROM `smart_scripts` WHERE `entryorguid` = 37134 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37134, 0, 1, 2, 11, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Prevent Combat Movement on Spawn'),
(37134, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Prevent Melee on Spawn'),
(37134, 0, 3, 4, 4, 0, 100, 0, 0, 0, 0, 0, 11, 71705, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Cast Summon Warhawk on Aggro'),
(37134, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Set Ranged Weapon Model (Phase 1)'),
(37134, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 71253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Cast Shoot on Aggro'),
(37134, 0, 6, 0, 0, 0, 100, 0, 5, 30, 2300, 3900, 11, 71253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Cast Shoot (Phase 1)'),
(37134, 0, 7, 0, 0, 0, 100, 0, 7000, 11000, 16000, 22000, 11, 71252, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Cast Volley (Phase 1)'),
(37134, 0, 8, 0, 0, 0, 100, 0, 16000, 22000, 25000, 40000, 11, 71251, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Cast Rapid Shot (Phase 1)'),
(37134, 0, 9, 0, 0, 0, 100, 0, 12000, 16000, 16000, 22000, 11, 71249, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Cast Ice Trap (Phase 1)'),
(37134, 0, 10, 11, 9, 0, 100, 0, 25, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Start Combat Movement at 25 Yards (Phase 1)'),
(37134, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Start Melee at 25 Yards (Phase 1)'),
(37134, 0, 12, 13, 9, 0, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Start Combat Movement Below 5 Yards (Phase 1)'),
(37134, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Set Ranged Weapon Model Below 5 Yards (Phase 1)'),
(37134, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Start Melee Below 5 Yards (Phase 1)'),
(37134, 0, 15, 16, 9, 0, 100, 0, 5, 15, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Prevent Combat Movement at 15 Yards (Phase 1)'),
(37134, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Prevent Melee at 15 Yards (Phase 1)'),
(37134, 0, 17, 0, 7, 0, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Set Melee Weapon Model on Evade'),
(37134, 0, 18, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Huntress - Cast Soul Feast On Death');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37134;
-- Warhawk : 38154
DELETE FROM `smart_scripts` WHERE `entryorguid` = 38154 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(38154, 0, 0, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Decaying Colossus - Cast Soul Feast On Death');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 38154;
-- Ymirjar Warlord : 37133 / 38133
DELETE FROM `smart_scripts` WHERE `entryorguid` = 37133 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37133, 0, 0, 0, 0, 0, 100, 30, 7000, 10000, 20000, 25000, 11, 41056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Warlord - Cast Whirlwind'),
(37133, 0, 1, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Warlord - Cast Soul Feast On Death');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37133;
-- Ymirjar Battle-Maiden : 37132 / 38132
DELETE FROM `smart_scripts` WHERE `entryorguid` = 37132 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37132, 0, 0, 0, 0, 0, 100, 30, 7000, 10000, 9000, 14000, 11, 71257, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Battle-Maiden - Cast Barbaric Strike'),
(37132, 0, 1, 0, 2, 0, 100, 30, 0, 30, 45000, 60000, 75, 71258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Battle-Maiden - Cast Adrenaline Rush'),
(37132, 0, 2, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Battle-Maiden - Cast Soul Feast On Death');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37132;
-- Ymirjar Deathbringer : 38125 / 38130                                 Interruptable
DELETE FROM `smart_scripts` WHERE `entryorguid` = 38125 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(38125, 0, 0, 0, 0, 0, 100, 30, 3000, 6000, 6000, 9000, 11, 71296, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Cast Shadow Bolt'),
(38125, 0, 1, 0, 0, 0, 100, 30, 9000, 12000, 20000, 26000, 11, 71298, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Cast Banish'),
(38125, 0, 2, 0, 2, 0, 100, 30, 0, 30, 60000, 65000, 11, 71299, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Cast Death Embrace'),
(38125, 0, 3, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Cast Soul Feast On Death');
-- (38125, 0, 4, 0, 0, 0, 100, 30, 12000, 15000, 20000, 25000, 11, 69929, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer - Cast Spirit Stream');                     -- To script
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 38125;
-- Ymirjar Frostbinder : 37127 / 38126
DELETE FROM `smart_scripts` WHERE `entryorguid` = 37127 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37127, 0, 0, 0, 0, 0, 100, 30, 3000, 6000, 12000, 18000, 11, 71270, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Cast Arctic Chill'),
(37127, 0, 1, 0, 6, 0, 100, 30, 0, 0, 0, 0, 11, 71203, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Cast Soul Feast On Death');
-- (37127, 0, 2, 0, 0, 0, 100, 30, 12000, 15000, 20000, 25000, 11, 69929, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Cast Spirit Stream'),                      -- To script
-- (37127, 0, 3, 0, 0, 0, 100, 30, 9000, 12000, 20000, 26000, 11, 71274, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Cast Frozen Orb'),
-- (37127, 0, 4, 0, 2, 0, 100, 30, 0, 50, 20000, 25000, 11, 71306, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Frostbinder - Cast Twisted Winds');                                     -- To script
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37127;


-- Misc fixes for Valithria encounter
DELETE FROM `creature_template_addon` WHERE `entry` IN (37907, 38168, 38726, 38736);
UPDATE `creature_template` SET `ScriptName` = 'npc_rot_worm' WHERE `entry` = 37907;
DELETE FROM `spell_script_names` WHERE `spell_id` = 70914 AND `ScriptName` = 'spell_dreamwalker_decay_periodic_timer';
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(70914, 'spell_dreamwalker_decay_periodic_timer');