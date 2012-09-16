-- Fix quest Norgannon's Shell / Norgannons Schale 12928
-- Spawning creature Archivist Mechaton / Archivar Mechaton 29775 temporarily attackable with event script
-- Insert quest item into loot
DELETE FROM `event_scripts` WHERE `id` = 19410 AND `command` = 10 AND `datalong` = 29775;
INSERT INTO `event_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(19410, 0, 10, 29775, 30000, 0, 7991.81, -827.7, 968.3, 0);
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 29775;
DELETE FROM `creature_loot_template` WHERE `item` = 41258 AND `entry` = 29775;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(29775, 41258, -100, 1, 0, 1, 1);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 29775);
DELETE FROM `creature` WHERE `id` = 29775;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `ConditionTypeOrReference` = 23 AND `SourceEntry` = 55197;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 55197, 0, 0, 23, 0, 4485, 0, 0, 0, 0, '', '');