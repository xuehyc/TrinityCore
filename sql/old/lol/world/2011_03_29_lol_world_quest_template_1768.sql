-- Fix Quest 'The Tome of Divinity' part 7 (1768)
-- Cleanup NPC
DELETE FROM `creature` WHERE `id` = 6172;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(81163, 6172, 0, 1, 1, 0, 0, -9129.59, -984.313, 76.1811, 2.05949, 180, 0, 0, 186, 191, 0, 0, 0, 0, 0);
-- quest_template Changes 
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 6172, `ReqCreatureOrGOCount1` = 1, `ReqSpellCast1` = 8593 WHERE `entry` = 1786; 
-- creature_template - disable move
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 4 WHERE `entry` = 6172;