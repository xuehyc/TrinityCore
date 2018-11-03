-- Ol Emma - 3520

SET @CREATURE  	:= 'Ol\' Emma';
SET @ENTRY 		:= '3520';

DELETE FROM `creature_template` WHERE `entry` = @ENTRY;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `HealthScalingExpansion`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `HealthModifierExtra`, `ManaModifier`, `ManaModifierExtra`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES 
(@ENTRY,  '0',  '0',  '0',  '0',  '0',  '1544',  '0',  '0',  '0',   @CREATURE,  '',  '',  '',  '',  '0',  '2',  '2',  '0',  '0',  '0',  '12',  '2',  '1',  '1.14286',  '1',  '0',  '0',  '2000',  '2000',  '1',  '1',  '1',  '512',  '2048',  '0',  '0',  '0',  '0',  '0',  '0',  '7',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  'SmartAI',  '0',  '3',  '1',  '1',  '1',  '1',  '1',  '1',  '1',  '1',  '0',  '0',  '1',  '0',  '2',  '',  '25549');

DELETE FROM creature_template_addon WHERE  `entry` = @ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`aiAnimKit`,`movementAnimKit`,`meleeAnimKit`,`auras`) VALUES 
(@ENTRY, '0', '0', '0', '257', '0', '0', '0', '0', ''); 

DELETE FROM  `creature_text` WHERE `CreatureID`= @ENTRY;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(@ENTRY, '0', '0', 'Seems like a hundred times a day I walk all the way to the well to get more water. No respect for their elders I tell ya.', '12', '7', '100', '0', '0', '0', '1107', '0', 'Ol\' Emma'), 
(@ENTRY, '0', '1', 'Jack and Jill my wrinkled patoot! I do all the water luggin\' \'round here.', '12', '7', '100', '0', '0', '0', '1110', '0', 'Ol\' Emma'), 
(@ENTRY, '0', '2', 'Think I\'m starting to wear a rut in the paving stones.', '12', '7', '100', '0', '0', '0', '1111', '0', 'Ol\' Emma'), 
(@ENTRY, '0', '3', 'One of these days I\'m gonna drown him in that blue robe. And all his brooms too.', '12', '0', '100', '0', '0', '0', '1109', '0', 'Ol\' Emma'), 
(@ENTRY, '1', '0', 'O\'course I\'m talkin to myself. Only way to get decent conversation in this city.', '12', '7', '100', '0', '0', '0', '1108', '0', 'Ol\' Emma'), 
(@ENTRY, '1', '1', 'As if I don\'t have better things to do in my old age than carry buckets of water.', '12', '7', '100', '0', '0', '0', '1106', '0', 'Ol\' Emma'), 
(@ENTRY, '1', '2', 'Where\'s the water, Emma? Get the water, Emma? If\'n it weren\'t fer me, that lot wouldn\'t know what water looks like.', '12', '7', '100', '0', '0', '0', '1105', '0', 'Ol\' Emma'), 
(@ENTRY, '1', '3', 'Deja vu.  For a moment, I thought I was back home... before the plague...', '12', '0', '100', '0', '0', '0', '1112', '0', 'Ol\' Emma'); 

DELETE FROM smart_scripts WHERE `entryorguid` = 3520 AND `source_type`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
('3520', '0', '0', '0', '1', '0', '100', '0', '0', '0', '180000', '180000', '', '1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Ol\' Emma - Out of Combat - Say Line 0 (No Repeat)'), 
('3520', '0', '1', '0', '1', '0', '100', '0', '60000', '60000', '180000', '180000', '', '1', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Ol\' Emma - Out of Combat - Say Line 1 (No Repeat)'); 

DELETE FROM creature WHERE  `id` = @ENTRY;
INSERT INTO `creature` ( `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`,`VerifiedBuild`) VALUES 
(188529, @ENTRY, '0', '1519', '5148', '1', '0', '0', '0', '-1', '1544', '0', '-8774.43', '666.457', '103.414', '3.91594', '120', '0', '0', '1', '0', '2', '0', '0', '0', '0', '0', '', '0'); 

SET @GUID := (SELECT `guid` FROM `creature` WHERE `position_x` REGEXP '-8774.43' AND `position_y` REGEXP '666.457' AND `position_z` REGEXP '103.414' AND `PhaseId` = '0' AND `map` = '0');
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`aiAnimKit`,`movementAnimKit`,`meleeAnimKit`,`auras`) VALUES 
(@GUID, @GUID, '0', '0', '1', '0', '0', '0', '0', ''); 

SET @GUID := (SELECT `guid` FROM `creature` WHERE `position_x` REGEXP '-8774.43' AND `position_y` REGEXP '666.457' AND `position_z` REGEXP '103.414' AND `PhaseId` = '0' AND `map` = '0');
DELETE FROM  `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES 
(@GUID, '1', '-8774.43', '666.457', '103.414', '0', '0', '0', '0', '100', '0'), 
(@GUID, '2', '-8768.53', '658.816', '103.789', '0', '0', '0', '0', '100', '0'), 
(@GUID, '3', '-8762.69', '650.005', '104.054', '0', '0', '0', '0', '100', '0'), 
(@GUID, '4', '-8759.12', '637.812', '103.452', '0', '0', '0', '0', '100', '0'), 
(@GUID, '5', '-8759.07', '625.349', '101.584', '0', '0', '0', '0', '100', '0'), 
(@GUID, '6', '-8763.57', '616.547', '98.8167', '0', '0', '0', '0', '100', '0'), 
(@GUID, '7', '-8778.38', '602.059', '97.4001', '0', '0', '0', '0', '100', '0'), 
(@GUID, '8', '-8793.39', '591.901', '97.7748', '0', '0', '0', '0', '100', '0'), 
(@GUID, '9', '-8810.4', '578.696', '95.5106', '0', '0', '0', '0', '100', '0'), 
(@GUID, '10', '-8819.73', '566.627', '94.551', '0', '0', '0', '0', '100', '0'), 
(@GUID, '11', '-8807.33', '581.896', '96.4704', '0', '0', '0', '0', '100', '0'), 
(@GUID, '12', '-8790.9', '593.734', '97.8092', '0', '0', '0', '0', '100', '0'), 
(@GUID, '13', '-8773.19', '607.477', '97.4001', '0', '0', '0', '0', '100', '0'), 
(@GUID, '14', '-8768.8', '606.753', '97.1501', '0', '0', '0', '0', '100', '0'), 
(@GUID, '15', '-8755.16', '593.688', '97.3963', '0', '0', '0', '0', '100', '0'), 
(@GUID, '16', '-8738.8', '576.608', '97.6463', '0', '0', '0', '0', '100', '0'), 
(@GUID, '17', '-8731.15', '577.865', '97.5449', '0', '0', '0', '0', '100', '0'), 
(@GUID, '18', '-8723.39', '587.139', '98.2635', '0', '0', '0', '0', '100', '0'), 
(@GUID, '19', '-8718.67', '592.391', '98.7159', '0', '0', '0', '0', '100', '0'), 
(@GUID, '20', '-8711.37', '594.538', '98.7635', '0', '0', '0', '0', '100', '0'), 
(@GUID, '21', '-8705.67', '604.686', '99.3996', '0', '0', '0', '0', '100', '0'), 
(@GUID, '22', '-8703.11', '614.602', '100.026', '0', '0', '0', '0', '100', '0'), 
(@GUID, '23', '-8704.33', '627.67', '100.481', '0', '0', '0', '0', '100', '0'), 
(@GUID, '24', '-8707.98', '641.729', '100.243', '0', '0', '0', '0', '100', '0'), 
(@GUID, '25', '-8713.06', '657.767', '99.3841', '0', '0', '0', '0', '100', '0'), 
(@GUID, '26', '-8719.23', '670.274', '98.9862', '0', '0', '0', '0', '100', '0'), 
(@GUID, '27', '-8726.87', '681.608', '98.9862', '0', '0', '0', '0', '100', '0'), 
(@GUID, '28', '-8731.86', '692.639', '98.9862', '0', '0', '0', '0', '100', '0'), 
(@GUID, '29', '-8739.58', '703.972', '98.7243', '0', '0', '0', '0', '100', '0'), 
(@GUID, '30', '-8742.36', '713.561', '98.3736', '0', '0', '0', '0', '100', '0'), 
(@GUID, '31', '-8731.73', '721.743', '101.666', '0', '0', '0', '0', '100', '0'), 
(@GUID, '32', '-8718.94', '732.882', '98.1662', '0', '0', '0', '0', '100', '0'), 
(@GUID, '33', '-8714.42', '734.029', '97.8885', '0', '0', '0', '0', '100', '0'), 
(@GUID, '34', '-8705.8', '722.955', '97.2075', '0', '0', '0', '0', '100', '0'), 
(@GUID, '35', '-8690.24', '703.174', '97.3892', '0', '0', '0', '0', '100', '0'), 
(@GUID, '36', '-8681.62', '692.165', '98.1385', '0', '0', '0', '0', '100', '0'), 
(@GUID, '37', '-8674.4', '686.163', '98.6209', '0', '0', '0', '0', '100', '0'), 
(@GUID, '38', '-8668.17', '676.721', '99.7635', '0', '0', '0', '0', '100', '0'), 
(@GUID, '39', '-8665.34', '670.142', '100.164', '0', '0', '0', '0', '100', '0'), 
(@GUID, '40', '-8661.47', '669.281', '100.547', '0', '0', '0', '0', '100', '0'), 
(@GUID, '41', '-8658.97', '671.416', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '42', '-8654.99', '675.823', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '43', '-8646.61', '681.797', '102.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '44', '-8640.98', '678.503', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '45', '-8640.93', '675.002', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '46', '-8648.7', '669.484', '108.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '47', '-8650.83', '669.851', '108.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '48', '-8652.89', '673.26', '108.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '49', '-8656.45', '676.938', '108.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '50', '-8653.12', '673.701', '108.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '51', '-8650.46', '670.218', '108.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '52', '-8647.85', '669.823', '108.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '53', '-8640.59', '674.87', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '54', '-8641.32', '677.918', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '55', '-8646.12', '681.251', '102.195', '0', '0', '0', '0', '100', '0'), 
(@GUID, '56', '-8654.25', '676.411', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '57', '-8658.89', '671.289', '101.795', '0', '0', '0', '0', '100', '0'), 
(@GUID, '58', '-8661.98', '669.271', '100.547', '0', '0', '0', '0', '100', '0'), 
(@GUID, '59', '-8666.41', '672.788', '100.172', '0', '0', '0', '0', '100', '0'), 
(@GUID, '60', '-8670.1', '681.295', '99.221', '0', '0', '0', '0', '100', '0'), 
(@GUID, '61', '-8679.13', '690.898', '98.3885', '0', '0', '0', '0', '100', '0'), 
(@GUID, '62', '-8687.36', '699.792', '97.4295', '0', '0', '0', '0', '100', '0'), 
(@GUID, '63', '-8692.52', '705.878', '97.2075', '0', '0', '0', '0', '100', '0'), 
(@GUID, '64', '-8706.67', '723.715', '97.3539', '0', '0', '0', '0', '100', '0'), 
(@GUID, '65', '-8715.25', '734.154', '97.8885', '0', '0', '0', '0', '100', '0'), 
(@GUID, '66', '-8719.42', '732.855', '98.2929', '0', '0', '0', '0', '100', '0'), 
(@GUID, '67', '-8730.27', '723.823', '101.541', '0', '0', '0', '0', '100', '0'), 
(@GUID, '68', '-8742.44', '713.74', '98.3606', '0', '0', '0', '0', '100', '0'), 
(@GUID, '69', '-8743.1', '708.812', '98.6385', '0', '0', '0', '0', '100', '0'), 
(@GUID, '70', '-8739.37', '703.108', '98.8281', '0', '0', '0', '0', '100', '0'), 
(@GUID, '71', '-8740.24', '697.868', '99.1405', '0', '0', '0', '0', '100', '0'), 
(@GUID, '72', '-8760.75', '681.898', '101.766', '0', '0', '0', '0', '100', '0'), 
(@GUID, '73', '-8773.58', '671.474', '103.355', '0', '0', '0', '0', '100', '0'); 

SET @GUID := (SELECT `guid` FROM `creature` WHERE `position_x` REGEXP '-8774.43' AND `position_y` REGEXP '666.457' AND `position_z` REGEXP '103.414' AND `PhaseId` = '0' AND `map` = '0');
DELETE FROM  `creature_formations` WHERE `leaderGUID` = @GUID;

DELETE FROM creature_onkill_reputation WHERE `creature_id` = @ENTRY;

DELETE FROM pickpocketing_loot_template WHERE  `entry` = @ENTRY;

DELETE FROM skinning_loot_template WHERE  `entry` = @ENTRY;

DELETE FROM  `creature_summon_groups` WHERE `summonerId` = @ENTRY AND `summonerType` = 0;

DELETE FROM `creature_equip_template` WHERE `CreatureID`= 3520;
DELETE FROM npc_trainer WHERE `ID` = @ENTRY;
DELETE FROM npc_vendor WHERE  `entry` = @ENTRY;

DELETE FROM  `creature_queststarter` WHERE `id`= @ENTRY;

DELETE FROM  `creature_questender` WHERE `id`= @ENTRY;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES 
('3520', '5048');  /* Quest(5048): Good Natured Emma ,QuestMinLevel: 50 ,QuestProfession ID: 0[THIS SKILL DONT EXIST] */ 

DELETE FROM waypoints WHERE  `entry` = @ENTRY;
DELETE FROM npc_spellclick_spells WHERE  `npc_entry` = @ENTRY;
DELETE FROM creature_default_trainer WHERE  `CreatureId` = @ENTRY;