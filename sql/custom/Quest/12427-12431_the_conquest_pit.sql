## The Conquest Pit - Grizzly Hills
-- delete spawns just in case they exist...
DELETE FROM `creature` WHERE `id` IN (27715, 27716, 27717, 27718, 27727);

-- set startscripts for Quests
UPDATE `quest_template` SET `StartScript` = 12427 WHERE entry = 12427; -- Bear Wrestling!
UPDATE `quest_template` SET `StartScript` = 12428 WHERE entry = 12428; -- Mad Furbolg Fighting
UPDATE `quest_template` SET `StartScript` = 12429 WHERE entry = 12429; -- Blood and Metal
UPDATE `quest_template` SET `StartScript` = 12430 WHERE entry = 12430; -- Death Is Likely
UPDATE `quest_template` SET `StartScript` = 12431 WHERE entry = 12431; -- Final Showdown

-- If coords wrong, just replace these...
SET @coord_x = 3246.057129;
SET @coord_y = -2341.465820;
SET @coord_z = 91.956734;
SET @coord_o = 4.192369;
-- despawntime in milliseconds...
SET @despawn = 300000;

-- spawn mobs on taking quest
DELETE FROM `quest_start_scripts` WHERE `id` IN (12427, 12428, 12429, 12430, 12431);
INSERT INTO `quest_start_scripts` VALUES (12427, 10, 10, 27715, @despawn, 0, @coord_x, @coord_y, @coord_z, @coord_o); -- Ironhide
INSERT INTO `quest_start_scripts` VALUES (12428, 10, 10, 27716, @despawn, 0, @coord_x, @coord_y, @coord_z, @coord_o); -- Torgg Thundertotem
INSERT INTO `quest_start_scripts` VALUES (12429, 10, 10, 27717, @despawn, 0, @coord_x, @coord_y, @coord_z, @coord_o); -- Rustblood
INSERT INTO `quest_start_scripts` VALUES (12430, 10, 10, 27718, @despawn, 0, @coord_x, @coord_y, @coord_z, @coord_o); -- Horgrenn Hellcleave
INSERT INTO `quest_start_scripts` VALUES (12431, 10, 10, 27727, @despawn, 0, @coord_x, @coord_y, @coord_z, @coord_o); -- Conqueror Krenna

-- set correct factions
UPDATE `creature_template` SET `faction_A`= 14, `faction_H` = 14 WHERE `entry` IN (27715, 27716, 27717, 27718, 27727);

-- Set KillCredits via EventAI
REPLACE INTO `creature_ai_scripts` VALUES
(2771599, 27715, 6, 0, 100, 0, 0, 0, 0, 0, 26, 12427, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- Ironhide QuestComplete on Death
(2771699, 27716, 6, 0, 100, 0, 0, 0, 0, 0, 26, 12428, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- Torgg Thundertotem QuestComplete on Death
(2771799, 27717, 6, 0, 100, 0, 0, 0, 0, 0, 26, 12429, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- Rustblood QuestComplete on Death
(2771899, 27718, 6, 0, 100, 0, 0, 0, 0, 0, 26, 12430, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), -- Horgrenn Hellcleave QuestComplete on Death
(2772799, 27727, 6, 0, 100, 0, 0, 0, 0, 0, 26, 12431, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0); -- Conqueror Krenna QuestComplete on Death

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` IN (27715, 27716, 27717, 27718, 27727);

-- Add phasing Aura for last quest
DELETE FROM `spell_area` WHERE `spell` = 70889;
INSERT INTO `spell_area` VALUES
(70889, 4206, 12431, 0, 0, 0, 0, 2, 1),
(70889, 4248, 12431, 0, 0, 0, 0, 2, 1);

-- Phase NPCs/GOs to additional Phasemask 2
UPDATE `creature` SET `phaseMask` = `phaseMask`|2 WHERE `position_x` < 3474 AND `position_x` > 3045 AND `position_y` < -1972 AND `position_y` > -3194 AND `guid` <> 118183;
UPDATE `gameobject` SET `phaseMask` = `phaseMask`|2 WHERE `position_x` < 3474 AND `position_x` > 3045 AND `position_y` < -1972 AND `position_y` > -3194;

-- UNSet Kill-Credits for NPCs in Quest-Template
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0 WHERE `entry` = 12427;
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0 WHERE `entry` = 12428;
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0 WHERE `entry` = 12429;
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0 WHERE `entry` = 12430;
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0 WHERE `entry` = 12431;