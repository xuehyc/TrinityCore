-- ICC Lich King
-- Ice Spheres immunities
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299839 WHERE `entry` IN (36633, 39305, 39306, 39307);
-- Val'kyr Shadowguard immunities
UPDATE `creature_template` SET `speed_walk` = 0.642857, `mechanic_immune_mask` = 617296767 WHERE `entry` IN (36609, 39120, 39121, 39122);
-- Unattackable trigger creature
UPDATE `creature_template` SET `unit_flags` = 33554946 WHERE `entry` IN (38757, 36598);
-- Vile Ghosts set script and add damage search aura to database
UPDATE `creature_template` SET `ScriptName` = 'npc_vile_spirit' WHERE `entry` = 37799;
DELETE FROM `creature_template_addon` WHERE `entry` IN (37799, 39284, 39285, 39286);
INSERT INTO `creature_template_addon` (entry, path_id, mount, bytes1, bytes2, emote, auras) VALUES
(37799, 0, 0, 50331648, 0, 0, '70502'),
(39284, 0, 0, 50331648, 0, 0, '70502'),
(39285, 0, 0, 50331648, 0, 0, '70502'),
(39286, 0, 0, 50331648, 0, 0, '70502');
-- Create spellscript for overwriting speed values
DELETE FROM `spell_script_names` WHERE `spell_id` = 74352;
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(74352, 'spell_the_lich_king_wings_of_the_damned');