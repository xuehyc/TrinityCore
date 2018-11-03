-- Gilneas city - Worgen Start Zone by Wormogo and Monad
--
-- remove aura 49414 from npc 34936 gwen armstead

UPDATE creature_addon SET auras=null WHERE guid=20556362;

-- fix - quest orders gilneas start area merchant square

UPDATE quest_template SET RewardNextQuest = 14099 WHERE id = 14094;
UPDATE quest_template SET RewardNextQuest = 0 WHERE id = 14093;
UPDATE quest_template SET RewardNextQuest = 0 WHERE id = 14098;
UPDATE quest_template_addon SET PrevQuestID = 14078 WHERE id = 14094;
UPDATE quest_template_addon SET NextQuestID = 14099 WHERE id = 14094;
UPDATE quest_template_addon SET NextQuestID = 0 WHERE id = 14093;
UPDATE quest_template_addon SET NextQuestID = 0 WHERE id = 14098;
UPDATE quest_template_addon SET PrevQuestID = 14094 WHERE id = 14099;

-- fix - corect emotes for npc 34946 gwen armstead and 35369 josiah avery

UPDATE creature_addon SET emote=375 WHERE guid=20556362;
UPDATE creature_addon SET emote=431 WHERE guid=20556546;

-- fix - emotes gilneas guards fighting worgen

DELETE FROM `creature_addon` WHERE `guid` in (20556412, 20556411, 20556410, 20556409, 20556408, 20556407, 20556406, 20556405, 20556404, 
20556403, 20556402, 20556401, 20556400, 20556398, 20556396, 20556394, 20556393, 20556392, 20556389, 20556385, 20556384, 20556382, 
20556375, 20556374, 20556369, 20556360, 20556347, 20556345, 20556341, 20556335);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(20556412, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556411, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556410, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556409, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556408, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556407, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556406, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556405, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556404, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556403, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556402, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556401, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556400, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556398, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556396, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556394, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556393, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556392, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556389, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556385, 0, 0, 0, 0, 45, 0, 0, 0, NULL), 
(20556384, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556382, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556375, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556374, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556369, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556360, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556347, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556345, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556341, 0, 0, 0, 0, 45, 0, 0, 0, NULL),
(20556335, 0, 0, 0, 0, 45, 0, 0, 0, NULL);

-- fix - horsed lord godfrey 35906 near cellar 
DELETE FROM `creature_addon` WHERE `guid`=210115272;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES (210115272, 0, 2410, 0, 0, 0, 0, 0, 0, NULL);


-- Sacrifices 14212
-- Crowley's horse seat definition with Lord Crowley on it - Tested and works - 2 NPC exists in Script 35552, 35230 - Need to check

DELETE FROM vehicle_template_accessory WHERE entry = 35231;
INSERT INTO vehicle_template_accessory (entry, accessory_entry, seat_id, minion, description, summontype, summontimer) VALUES 
(35231, 35552, 2, 1, 'Lord Darius Crowley', 8, 0),
(35231, 35230, 1, 1, 'Lord Darius Crowley Blizz NPC', 8, 0); -- the blizz like NPC!!

-- Spawned horse summon quest horse

UPDATE npc_spellclick_spells SET spell_id = 67001 WHERE npc_entry = 44427 AND spell_id = 82992;

-- Click to spawn on Crowley's Horse, need to change to vehicle
UPDATE creature_template SET VehicleId = 463  WHERE entry = 44427;
UPDATE creature_template SET IconName='vehicleCursor' WHERE entry = 44427;

-- Remove SmartAI from 35231
UPDATE creature_template SET AIName ='' WHERE entry = 35231;

DELETE FROM `smart_scripts` WHERE (`entryorguid`=44427);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(44427, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 67001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Summon Crowleys Horse');

