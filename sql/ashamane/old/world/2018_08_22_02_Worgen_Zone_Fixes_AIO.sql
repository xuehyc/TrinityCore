-- Save Krennan Aranas (14293)
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (35550);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (35550);
INSERT INTO `smart_scripts` VALUES
(35550, 0, 0, 0, 1, 0, 100, 0, 0, 0, 30000, 30000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'King Genn Greymane - Out Of Combat - Say Text'),
(35550, 0, 1, 0, 19, 0, 100, 0, 14293, 0, 0, 0, 0, 11, 68232, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'King Genn Greymane - Accepted Quest - Cast Gilneas Prison Periodic');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='', `unit_flags`=33280, `flags_extra`=2 WHERE `entry` IN (35753);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (35753);
INSERT INTO `smart_scripts` VALUES
(35753, 0, 0, 0, 1, 0, 100, 0, 0, 0, 60000, 60000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Krennan Aranas - Out Of Combat - Say Text'),
(35753, 0, 1, 0, 8, 0, 100, 1, 68219, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Krennan Aranas - On Spellhit - Forced Despawn');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='', `spell1`=68219, `unit_flags`=10 WHERE `entry` IN (35905);
UPDATE creature_template SET speed_run = 2.50 WHERE entry = 35905;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (35905, 3590500);
INSERT INTO `smart_scripts` VALUES
(35905, 0, 0, 1, 27, 0, 100, 1, 0, 0, 0, 0, 0, 80, 3590500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'King Greymane\'s Horse - On Passanger Boarded - Start Timed Action Script'),
(35905, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'King Greymane\'s Horse - On Link - Allow Combat Movement'),
(35905, 0, 2, 0, 40, 0, 100, 0, 6, 0, 0, 0, 0, 97, 25, 10, 0, 0, 0, 0, 1, 0, 0, 0, -1674.46, 1344.95, 15.1352, 0, 'King Greymane\'s Horse - On WP Reached - Jump to PoS'),
(35905, 0, 3, 4, 40, 0, 100, 0, 16, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 35907, 10, 0, 0, 0, 0, 0, 'King Greymane\'s Horse - On WP Reached - Set Data'),
(35905, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'King Greymane\'s Horse - On WP Reached - Despawn'),
(3590500, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 53, 1, 35905, 0, 14293, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'King Greymane\'s Horse - Script - Start WP Movement');
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (35907);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (35907);
INSERT INTO `smart_scripts` VALUES
(35907, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 11, 46598, 0, 0, 0, 0, 0, 11, 35905, 10, 0, 0, 0, 0, 0, 'Krennan Aranas - On Respawn - Cast Spell'),
(35907, 0, 1, 2, 38, 0, 100, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Krennan Aranas - on Data Set - Say Text'),
(35907, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Krennan Aranas - on Data Set - Prevent Combat Movement'),
(35907, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Krennan Aranas - on Data Set - Forced Despawn');
DELETE FROM `creature_text` WHERE `creatureid` IN (35550, 35753, 35907);
INSERT INTO `creature_text` VALUES
(35550, 0, 0, 'Fire!', 14, 0, 100, 0, 0, 0, 0, 0, ''),
(35550, 0, 1, 'Hold the barricades! Do not give them an inch!', 14, 0, 100, 0, 0, 0, 0, 0, ''),
(35550, 0, 2, 'Keep them back!', 14, 0, 100, 0, 0, 0, 0, 0, ''),
(35753, 0, 0, 'Help! Up here!', 14, 0, 100, 0, 0, 0, 0, 0, ''),
(35907, 1, 0, 'Thank you! I owe you my life.', 12, 0, 100, 0, 0, 0, 0, 0, '');

DELETE FROM `waypoints` WHERE `entry` IN (35905);
INSERT INTO `waypoints` VALUES 
(35905, 16, -1771.46, 1430.1, 19.8183, ''),
(35905, 15, -1766.16, 1404.17, 19.8109, ''),
(35905, 14, -1746.3, 1375.96, 19.97, ''),
(35905, 13, -1725.38, 1356.36, 19.8184, ''),
(35905, 12, -1705.86, 1350.95, 19.8964, ''),
(35905, 11, -1685.27, 1355.4, 15.1356, ''),
(35905, 10, -1672.07, 1362.12, 15.135, ''),
(35905, 9, -1666.29, 1355.75, 15.135, ''),
(35905, 8, -1668.71, 1348.29, 15.1366, ''),
(35905, 7, -1674.46, 1344.95, 15.1352, ''),
(35905, 6, -1707.42, 1345.95, 19.896, ''),
(35905, 5, -1728.55, 1351.81, 19.6012, ''),
(35905, 4, -1755.42, 1368.4, 19.7833, ''),
(35905, 3, -1777.13, 1369.23, 19.8021, ''),
(35905, 2, -1790.45, 1383.17, 19.8166, ''),
(35905, 1, -1800.37, 1407.18, 20.0265, '');

-- Keep it until fully tested:
-- Save Krennan Spell Focus
-- DELETE FROM gameobject_template WHERE entry = 195660;
-- INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) 
-- VALUES (195660, 8, 299, 'Krennan Aranas Spell Focus', '', '', '', 1, 1630, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 1);

-- fix - gameobject spell focus 301027 for save krennan
DELETE FROM `gameobject` WHERE `guid`=905000;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (905000, 301027, 654, 1, 1, 1, 0, 171, 0, -1, -1674.46, 1344.95, 15.1352, 0, 0, 0, 0, 0, 300, 0, 0, 1, '', 0);

DELETE FROM `gameobject_addon` WHERE `guid`=905000;
INSERT INTO `gameobject_addon` (`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`, `WorldEffectID`)
 VALUES (905000, 0, 0, 0, 1, 8, 1000, 0);

DELETE FROM spell_area WHERE spell = 49416 AND area = 4757;
INSERT INTO spell_area (`spell`, `area`, `quest_start`, `quest_end`, `quest_start_status`, `quest_end_status`) 
VALUES (49416, 4757, 14293, 14294, 74, 64);

-- Lord Godfrey 35906 Quest Ender for Save Krennan Aranas
UPDATE creature SET PhaseID = 172 where GUID = 210115272 and PhaseID = 171;
UPDATE creature SET PhaseID = 170 where GUID = 210115271 and PhaseID = 0;

-- NPC commandered Cannon
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_commandeered_cannon_35914' WHERE `entry` IN (35914);

-- End of SAVE KRENNAN ARANAS QUEST FIX
--

-- fix - corect emotes 35369 josiah avery
UPDATE creature_addon SET emote=375 WHERE guid=20556362;
UPDATE creature_addon SET emote=431 WHERE guid=20556546;

-- fix - Celestine of the Harvest 35873 corect spell 13236 cast
UPDATE `creature_template` SET `AIName`='SmartAI', `scriptname`='' WHERE entry = 35873;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 35873 AND `id` = 0 AND `source_type` = 0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (35873,0,0,0,1,0,100,257,500,500,500,500,11,13236,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Cast nature channeling");

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

-- fix - horsed and phased lord godfrey 35906 near cellar 
DELETE FROM `creature_addon` WHERE `guid`=210115271;
DELETE FROM `creature_addon` WHERE `guid`=210115272;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES 
(210115271, 0, 2410, 0, 0, 0, 0, 0, 0, NULL),
(210115272, 0, 2410, 0, 0, 0, 0, 0, 0, NULL);
DELETE FROM `creature` WHERE `guid`=210115271;
DELETE FROM `creature` WHERE `guid`=210115272;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(210115271, 35906, 654, 0, 0, 1, 0, 171, 0, -1, 0, 1, -1785.53, 1437.74, 20.2669, 6.02249, 300, 0, 0, 130, 115, 0, 0, 0, 0, 0, 0, '', 0),
(210115272, 35906, 654, 0, 0, 1, 0, 172, 0, -1, 0, 1, -1785.82, 1437.63, 20.2474, 6.19842, 300, 0, 0, 130, 115, 0, 0, 0, 0, 0, 0, '', 0);

-- fix - wrong queststrarters in gilneas
DELETE FROM `creature_queststarter` WHERE `id`=35118 AND `quest`=24930;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (35118, 24930);

-- fix - endquest texts for gilneas class trainers, quests given by gwen armstead npc: 35840

DELETE FROM `quest_offer_reward` WHERE `ID`=14277;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14277, 0, 0, 0, 0, 0, 0, 0, 0, 'A disciple of the arcane always finds a way forward. I\'m glad to see you, $N.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14278;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14278, 0, 0, 0, 0, 0, 0, 0, 0, 'The Light is with you, $N. It\'s still quite a relief to see you.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14273;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14273, 0, 0, 0, 0, 0, 0, 0, 0, 'A darkness has descended over our lands. And not our kind of darkness, if you know what I mean.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14275;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14275, 0, 0, 0, 0, 0, 0, 0, 0, '$N! I knew you had to be around here.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14269;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14269, 0, 0, 0, 0, 0, 0, 0, 0, 'Oh, hey! There you are!', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14272;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14272, 0, 0, 0, 0, 0, 0, 0, 0, 'Don\'t get ahead of yourself now.  Just remember who taught you everything you know. And now let\'s see if we can get out of this city with our skins attached.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14280;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14280, 0, 0, 0, 0, 0, 0, 0, 0, 'We have been blessed today! You are alive and well!', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14265;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14265, 0, 0, 0, 0, 0, 0, 0, 0, '<name>!  Where have you been? Anyway... it\'s great to see you in one piece.', 0);

-- fix - 35112 king genn greymane endquests texts
DELETE FROM `quest_offer_reward` WHERE `ID`=14291;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14291, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14290;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14290, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14289;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14289, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14288;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14288, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14287;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14287, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14286;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14286, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14285;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14285, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);