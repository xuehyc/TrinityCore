-- Fixes for Children's Week / Kinderwoche event 2012
-- Alliance, Stormwind
UPDATE `quest_template` SET `RequiredRaces` = 1101, `PrevQuestId` = 1468 WHERE `Id` = 558;
UPDATE `quest_template` SET `PrevQuestId` = 1468 WHERE `Id` = 4822;
DELETE FROM `creature_questrelation` WHERE `quest` = 171;
INSERT INTO `creature_questrelation` (id, quest) VALUES (14305, 171);
UPDATE `quest_template` SET `NextQuestId` = 171, `ExclusiveGroup` = -558 WHERE `Id` IN (558, 1687, 4822);
-- Horde, Orgrimmar
UPDATE `quest_template` SET `RequiredRaces` = 690, `PrevQuestId` = 172 WHERE `Id` = 915;
UPDATE `quest_template` SET `PrevQuestId` = 172 WHERE `Id` = 925;
UPDATE `quest_template` SET `PrevQuestId` = 910 WHERE `Id` = 1800;
UPDATE `quest_template` SET `PrevQuestId` = 0 WHERE `Id` = 5502;
UPDATE `quest_template` SET `NextQuestId` = 5502, `ExclusiveGroup` = -915 WHERE `Id` IN (925, 1800, 915);
-- Alliance, Outland
DELETE FROM `creature_involvedrelation` WHERE `quest` = 10942 AND `id` = 22818;
UPDATE `quest_template` SET `RequiredRaces` = 1101, `PrevQuestId` = 10943 WHERE `Id` IN (10950, 10956, 10962);
UPDATE `quest_template` SET `RequiredRaces` = 1101, `PrevQuestId` = 10950 WHERE `Id` = 10952;
UPDATE `quest_template` SET `RequiredRaces` = 1101, `PrevQuestId` = 10952 WHERE `Id` = 10954;
UPDATE `quest_template` SET `NextQuestId` = 10966, `ExclusiveGroup` = -10954 WHERE `Id` IN (10968, 10954, 10962);
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10952;
-- Horde, Outland
UPDATE `quest_template` SET `RequiredRaces` = 690, `PrevQuestId` = 10942 WHERE `Id` IN (11975, 10963, 10945);
UPDATE `quest_template` SET `RequiredRaces` = 690, `PrevQuestId` = 10945 WHERE `Id` = 10951;
UPDATE `quest_template` SET `RequiredRaces` = 690, `PrevQuestId` = 10951 WHERE `Id` = 10953;
UPDATE `quest_template` SET `RequiredRaces` = 690, `PrevQuestId` = 10953 WHERE `Id` = 10960;
UPDATE `quest_template` SET `NextQuestId` = 10967, `ExclusiveGroup` = -10960 WHERE `Id` IN (11975, 10963, 10960);
UPDATE `quest_template` SET `SpecialFlags` = 2 WHERE `Id` = 10951;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25149 AND `source_type` = 0;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(25149, 0, 0, 0, 10, 0, 100, 0, 1, 50, 1000, 1000, 15, 11975, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Complete Quest on 11975 LoS');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25149;
UPDATE `quest_template` SET `PointMapId` = 530, `PointX` = -1883.62, `PointY` = 5420.01 WHERE `Id` = 10960;
UPDATE `quest_poi` SET `WorldMapAreaId` = 481 WHERE `questId` = 10960;
UPDATE `quest_poi_points` SET `x` = -1883, `y` = 5420 WHERE `questId` = 10960;
-- Dalaran NPC spawn
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 34365);
DELETE FROM `creature` WHERE `id` = 34365;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(34365, 571, 1, 1, 0, 0, 5717, 642.346, 646.216, 5.79082, 300, 0, 0, 12600, 3994, 0, 0, 0, 0);
INSERT INTO `game_event_creature` (eventEntry, guid) SELECT 10, `guid` FROM `creature` WHERE `id` = 34365;
-- Oracles, Dalaran
UPDATE `quest_template` SET `PrevQuestId` = 13926 WHERE `Id` IN (13937, 13929, 13950);
UPDATE `quest_template` SET `PrevQuestId` = 13929 WHERE `Id` = 13933;
UPDATE `quest_template` SET `PrevQuestId` = 13950 WHERE `Id` = 13954;
UPDATE `quest_template` SET `PrevQuestId` = 13954 WHERE `Id` = 13956;
UPDATE `quest_template` SET `NextQuestId` = 13959, `ExclusiveGroup` = -13933 WHERE `Id` IN (13933, 13937, 13956);
UPDATE `quest_template` SET `RewardMailTemplateId` = 0, `RewardItemId1` = 46545, `RewardItemCount1` = 1 WHERE `Id` = 13959;
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 0, `RequiredNpcOrGoCount1` = 0 WHERE `Id` = 13926;
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 0, `RequiredNpcOrGoCount1` = 0, `RequiredItemId1` = 34494, `RequiredItemCount1` = 1 WHERE `Id` = 13937;
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 0, `RequiredNpcOrGoCount1` = 0, `RequiredItemId1` = 37251, `RequiredItemCount1` = 1, `StartScript` = 13929 WHERE `Id` = 13929;
DELETE FROM `quest_start_scripts` WHERE `id` = 13929;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13929, 0, 7, 13929, 10, 0, 0, 0, 0, 0);
UPDATE `quest_template` SET `StartScript` = 13933 WHERE `Id` = 13933;
DELETE FROM `quest_start_scripts` WHERE `id` = 13933;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13933, 0, 7, 13933, 10, 0, 0, 0, 0, 0);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13950;
INSERT INTO `creature_involvedrelation` (id, quest) VALUES (25199, 13950);
UPDATE `quest_template` SET `StartScript` = 13950 WHERE `Id` = 13950;
DELETE FROM `quest_start_scripts` WHERE `id` = 13950;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13950, 0, 7, 13950, 10, 0, 0, 0, 0, 0);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13954;
INSERT INTO `creature_involvedrelation` (id, quest) VALUES (26917, 13954);
UPDATE `quest_template` SET `StartScript` = 13954 WHERE `Id` = 13954;
DELETE FROM `quest_start_scripts` WHERE `id` = 13954;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13954, 0, 7, 13954, 10, 0, 0, 0, 0, 0);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13956;
INSERT INTO `creature_involvedrelation` (id, quest) VALUES (28092, 13956);
UPDATE `quest_template` SET `StartScript` = 13956 WHERE `Id` = 13956;
DELETE FROM `quest_start_scripts` WHERE `id` = 13956;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13956, 0, 7, 13956, 10, 0, 0, 0, 0, 0);
-- Wolvar, Dalaran
DELETE FROM `creature_questrelation` WHERE `quest` = 13938;
INSERT INTO `creature_questrelation` (id, quest) VALUES (33532, 13938);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13938;
INSERT INTO `creature_involvedrelation` (id, quest) VALUES (33532, 13938);
UPDATE `quest_template` SET `PrevQuestId` = 13927 WHERE `Id` IN (13930, 13951, 13938);
UPDATE `quest_template` SET `PrevQuestId` = 13930 WHERE `Id` = 13934;
UPDATE `quest_template` SET `PrevQuestId` = 13951 WHERE `Id` = 13955;
UPDATE `quest_template` SET `PrevQuestId` = 13955 WHERE `Id` = 13957;
UPDATE `quest_template` SET `NextQuestId` = 13960, `ExclusiveGroup` = -13934 WHERE `Id` IN (13934, 13938, 13957);
UPDATE `quest_template` SET `RewardMailTemplateId` = 0, `RewardItemId1` = 46544, `RewardItemCount1` = 1 WHERE `Id` = 13960;
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 0, `RequiredNpcOrGoCount1` = 0 WHERE `Id` = 13927;
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 0, `RequiredNpcOrGoCount1` = 0, `RequiredItemId1` = 34494, `RequiredItemCount1` = 1 WHERE `Id` = 13938;
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 0, `RequiredNpcOrGoCount1` = 0, `RequiredItemId1` = 37251, `RequiredItemCount1` = 1, `StartScript` = 13930 WHERE `Id` = 13930;
DELETE FROM `quest_start_scripts` WHERE `id` = 13930;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13930, 0, 7, 13930, 10, 0, 0, 0, 0, 0);
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 26198, `RequiredNpcOrGoCount1` = 1, `StartScript` = 13951 WHERE `Id` = 13951;
DELETE FROM `quest_start_scripts` WHERE `id` = 13951;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13951, 0, 7, 13951, 10, 0, 0, 0, 0, 0);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13955;
INSERT INTO `creature_involvedrelation` (id, quest) VALUES (26917, 13955);
UPDATE `quest_template` SET `StartScript` = 13955 WHERE `Id` = 13955;
DELETE FROM `quest_start_scripts` WHERE `id` = 13955;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13955, 0, 7, 13955, 10, 0, 0, 0, 0, 0);
UPDATE `quest_template` SET `StartScript` = 13934 WHERE `Id` = 13934;
DELETE FROM `quest_start_scripts` WHERE `id` = 13934;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13934, 0, 7, 13934, 10, 0, 0, 0, 0, 0);
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13957;
INSERT INTO `creature_involvedrelation` (id, quest) VALUES (27986, 13957);
UPDATE `quest_template` SET `StartScript` = 13957 WHERE `Id` = 13957;
DELETE FROM `quest_start_scripts` WHERE `id` = 13957;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(13957, 0, 7, 13957, 10, 0, 0, 0, 0, 0);
-- Cleanup queries
-- DELETE FROM `character_queststatus` WHERE `quest` IN (1468, 558, 1687, 1479, 1558, 4822, 171, 172, 5502, 925, 910, 911, 1800, 915, 10943, 10952, 10950, 10966, 10954, 10956, 10968, 10962, 10942, 10951, 10967, 10945, 11975, 10963, 10953, 10960, 13926, 13937, 13959, 13956, 13950, 13929, 13933, 13954, 13927, 13960, 13930, 13951, 13934, 13955, 13957, 13938);
-- DELETE FROM `character_queststatus_rewarded` WHERE `quest` IN (1468, 558, 1687, 1479, 1558, 4822, 171, 172, 5502, 925, 910, 911, 1800, 915, 10943, 10952, 10950, 10966, 10954, 10956, 10968, 10962, 10942, 10951, 10967, 10945, 11975, 10963, 10953, 10960, 13926, 13937, 13959, 13956, 13950, 13929, 13933, 13954, 13927, 13960, 13930, 13951, 13934, 13955, 13957, 13938);
-- DELETE FROM `character_queststatus_seasonal` WHERE `quest` IN (1468, 558, 1687, 1479, 1558, 4822, 171, 172, 5502, 925, 910, 911, 1800, 915, 10943, 10952, 10950, 10966, 10954, 10956, 10968, 10962, 10942, 10951, 10967, 10945, 11975, 10963, 10953, 10960, 13926, 13937, 13959, 13956, 13950, 13929, 13933, 13954, 13927, 13960, 13930, 13951, 13934, 13955, 13957, 13938);