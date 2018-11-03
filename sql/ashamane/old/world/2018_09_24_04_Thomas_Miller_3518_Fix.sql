-- Thomas Miller - 3518

SET @CREATURE  	:= 'Thomas Miller';
SET @ENTRY 		:= '3518';

DELETE FROM `creature_template` WHERE `entry` = @ENTRY;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `HealthScalingExpansion`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `HealthModifierExtra`, `ManaModifier`, `ManaModifierExtra`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES 
(@ENTRY,  '0',  '0',  '0',  '0',  '0',  '1541',  '0',  '0',  '0',   @CREATURE,  '',  'Baker',  '',  '',  '685',  '15',  '15',  '0',  '0',  '0',  '12',  '643',  '1',  '1.14286',  '1',  '0',  '0',  '2000',  '2000',  '1',  '1',  '1',  '512',  '2048',  '0',  '0',  '0',  '0',  '0',  '0',  '7',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '',  '0',  '3',  '1',  '1',  '1',  '1',  '1',  '1',  '1',  '1',  '0',  '0',  '1',  '0',  '2',  '',  '25549');

DELETE FROM creature_template_addon WHERE  `entry` = @ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`aiAnimKit`,`movementAnimKit`,`meleeAnimKit`,`auras`) VALUES 
(@ENTRY, '0', '0', '0', '257', '0', '0', '0', '0', ''); 

DELETE FROM  `creature_text` WHERE `CreatureID`= @ENTRY;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(@ENTRY, '0', '0', 'Freshly baked bread for sale!', '12', '7', '100', '0', '0', '0', '1104', '0', 'Thomas Miller'), 
(@ENTRY, '0', '1', 'Fresh bread for sale!', '12', '7', '100', '0', '0', '0', '1101', '0', 'Thomas Miller'), 
(@ENTRY, '0', '2', 'Warm, wholesome bread!', '12', '0', '100', '0', '0', '0', '1102', '0', 'Thomas Miller'), 
(@ENTRY, '0', '3', 'Rolls, buns and bread. Baked fresh!', '12', '0', '100', '0', '0', '0', '1103', '0', 'Thomas Miller'); 



DELETE FROM smart_scripts WHERE `entryorguid` = 3518 AND `source_type`= 0;

DELETE FROM creature WHERE  `id` = @ENTRY;
INSERT INTO `creature` ( `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`,`VerifiedBuild`) VALUES 
(188779, @ENTRY, '0', '1519', '5148', '1', '0', '0', '0', '-1', '0', '1', '-8815.82', '581.509', '95.6585', '0.635725', '120', '0', '0', '1', '0', '2', '0', '0', '0', '0', '0', '', '0'); 

SET @GUID := (SELECT `guid` FROM `creature` WHERE `position_x` REGEXP '-8815.82' AND `position_y` REGEXP '581.509' AND `position_z` REGEXP '95.6585' AND `PhaseId` = '0' AND `map` = '0');
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`aiAnimKit`,`movementAnimKit`,`meleeAnimKit`,`auras`) VALUES 
(@GUID, @GUID, '0', '0', '1', '0', '0', '0', '0', ''); 

SET @GUID := (SELECT `guid` FROM `creature` WHERE `position_x` REGEXP '-8815.82' AND `position_y` REGEXP '581.509' AND `position_z` REGEXP '95.6585' AND `PhaseId` = '0' AND `map` = '0');
DELETE FROM  `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES 
(@GUID, '1', '-8815.82', '581.509', '95.6585', '0', '0', '0', '0', '100', '0'), 
(@GUID, '2', '-8821.13', '571.116', '94.3151', '0', '0', '0', '0', '100', '0'), 
(@GUID, '3', '-8830.8', '559.092', '95.0839', '0', '0', '0', '0', '100', '0'), 
(@GUID, '4', '-8834.43', '549.628', '96.3309', '0', '0', '0', '0', '100', '0'), 
(@GUID, '5', '-8831.72', '543.04', '96.8852', '0', '0', '0', '0', '100', '0'), 
(@GUID, '6', '-8824.97', '553.653', '95.4203', '0', '0', '0', '0', '100', '0'), 
(@GUID, '7', '-8816.54', '562.648', '94.3624', '0', '0', '0', '0', '100', '0'), 
(@GUID, '8', '-8812.61', '575.165', '95.0223', '0', '0', '0', '0', '100', '0'), 
(@GUID, '9', '-8798.55', '587.634', '97.5127', '0', '0', '0', '0', '100', '0'), 
(@GUID, '10', '-8788.76', '593.309', '97.8092', '0', '0', '0', '0', '100', '0'), 
(@GUID, '11', '-8776.41', '603.918', '97.4001', '0', '0', '0', '0', '100', '0'), 
(@GUID, '12', '-8762.69', '617.311', '99.1734', '0', '0', '0', '0', '100', '0'), 
(@GUID, '13', '-8758.29', '627.458', '102.116', '0', '0', '0', '0', '100', '0'), 
(@GUID, '14', '-8759.38', '641.92', '103.859', '0', '0', '0', '0', '100', '0'), 
(@GUID, '15', '-8770.59', '661.321', '103.789', '0', '0', '0', '0', '100', '0'), 
(@GUID, '16', '-8779.11', '672.498', '103.176', '0', '0', '0', '0', '100', '0'), 
(@GUID, '17', '-8787.32', '680.436', '102.453', '0', '0', '0', '0', '100', '0'), 
(@GUID, '18', '-8804.33', '683.759', '101.026', '0', '0', '0', '0', '100', '0'), 
(@GUID, '19', '-8815.25', '680.689', '98.5599', '0', '0', '0', '0', '100', '0'), 
(@GUID, '20', '-8831.31', '674.418', '98.5225', '0', '0', '0', '0', '100', '0'), 
(@GUID, '21', '-8844.65', '666.432', '97.6743', '0', '0', '0', '0', '100', '0'), 
(@GUID, '22', '-8853.11', '657.971', '96.9886', '0', '0', '0', '0', '100', '0'), 
(@GUID, '23', '-8848.72', '646.945', '96.5236', '0', '0', '0', '0', '100', '0'), 
(@GUID, '24', '-8842.51', '637.998', '95.8391', '0', '0', '0', '0', '100', '0'), 
(@GUID, '25', '-8834.66', '634.193', '94.7602', '0', '0', '0', '0', '100', '0'), 
(@GUID, '26', '-8823.59', '639.309', '94.6514', '0', '0', '0', '0', '100', '0'), 
(@GUID, '27', '-8818.34', '641.126', '94.6514', '0', '0', '0', '0', '100', '0'), 
(@GUID, '28', '-8811.45', '634.478', '94.5264', '0', '0', '0', '0', '100', '0'), 
(@GUID, '29', '-8813.91', '625.365', '94.3282', '0', '0', '0', '0', '100', '0'), 
(@GUID, '30', '-8827.42', '620.417', '94.4532', '0', '0', '0', '0', '100', '0'), 
(@GUID, '31', '-8837.02', '613.516', '93.4709', '0', '0', '0', '0', '100', '0'), 
(@GUID, '32', '-8845.9', '602.016', '93.1543', '0', '0', '0', '0', '100', '0'), 
(@GUID, '33', '-8854.5', '591.471', '92.982', '0', '0', '0', '0', '100', '0'), 
(@GUID, '34', '-8863.73', '582.434', '93.6525', '0', '0', '0', '0', '100', '0'), 
(@GUID, '35', '-8875.35', '571.854', '93.7725', '0', '0', '0', '0', '100', '0'), 
(@GUID, '36', '-8883.44', '571.865', '93.1875', '0', '0', '0', '0', '100', '0'), 
(@GUID, '37', '-8888.38', '578.182', '93.2697', '0', '0', '0', '0', '100', '0'), 
(@GUID, '38', '-8889.48', '585.276', '93.5129', '0', '0', '0', '0', '100', '0'), 
(@GUID, '39', '-8880.29', '592.134', '93.5029', '0', '0', '0', '0', '100', '0'), 
(@GUID, '40', '-8867.21', '597.932', '92.8125', '0', '0', '0', '0', '100', '0'), 
(@GUID, '41', '-8849.51', '608.005', '92.8503', '0', '0', '0', '0', '100', '0'), 
(@GUID, '42', '-8835.44', '618.398', '93.4097', '0', '0', '0', '0', '100', '0'), 
(@GUID, '43', '-8828.32', '620.059', '94.4532', '0', '0', '0', '0', '100', '0'), 
(@GUID, '44', '-8819.85', '613.238', '95.2064', '0', '0', '0', '0', '100', '0'), 
(@GUID, '45', '-8809.67', '603.627', '96.4555', '0', '0', '0', '0', '100', '0'), 
(@GUID, '46', '-8806.91', '593.153', '97.298', '0', '0', '0', '0', '100', '0'); 


SET @GUID := (SELECT `guid` FROM `creature` WHERE `position_x` REGEXP '-8815.82' AND `position_y` REGEXP '581.509' AND `position_z` REGEXP '95.6585' AND `PhaseId` = '0' AND `map` = '0');
DELETE FROM  `creature_formations` WHERE `leaderGUID` = @GUID;

DELETE FROM creature_onkill_reputation WHERE `creature_id` = @ENTRY;

DELETE FROM pickpocketing_loot_template WHERE  `entry` = @ENTRY;

DELETE FROM skinning_loot_template WHERE  `entry` = @ENTRY;

DELETE FROM  `creature_summon_groups` WHERE `summonerId` = @ENTRY AND `summonerType` = 0;

DELETE FROM `creature_equip_template` WHERE `CreatureID`= 3518;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES 
('3518', '1', '2197', '0', '0', '0', '0', '0', '0', '0', '18019');

DELETE FROM npc_trainer WHERE `ID` = @ENTRY;
DELETE FROM npc_vendor WHERE  `entry` = @ENTRY;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`OverrideGoldCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES 
(@ENTRY, '1', '4540', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(4540): Tough Hunk of Bread, ItemLevel: 1, RequiredLevel: 1, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '2', '4541', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(4541): Freshly Baked Bread, ItemLevel: 5, RequiredLevel: 5, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '3', '4542', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(4542): Moist Cornbread, ItemLevel: 15, RequiredLevel: 15, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '4', '4544', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(4544): Mulgore Spice Bread, ItemLevel: 25, RequiredLevel: 25, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '5', '4601', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(4601): Soft Banana Bread, ItemLevel: 35, RequiredLevel: 35, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '6', '8950', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(8950): Homemade Cherry Pie, ItemLevel: 45, RequiredLevel: 45, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '7', '27855', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(27855): Mag'har Grainbread, ItemLevel: 60, RequiredLevel: 60, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '8', '33449', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(33449): Crusty Flatbread, ItemLevel: 60, RequiredLevel: 60, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '9', '35950', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(35950): Sweet Potato Bread, ItemLevel: 75, RequiredLevel: 75, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '10', '58260', '0', '0', '0', '-1', '1', '', '0', '0', '0'),   /* Item(58260): Pine Nut Bread, ItemLevel: 80, RequiredLevel: 80, ItemQuality: WAIHT_COMMON     */
(@ENTRY, '11', '58261', '0', '0', '0', '-1', '1', '', '0', '0', '0');   /* Item(58261): Buttery Wheat Roll, ItemLevel: 85, RequiredLevel: 85, ItemQuality: WAIHT_COMMON     */

DELETE FROM  `creature_queststarter` WHERE `id`= @ENTRY;

DELETE FROM  `creature_questender` WHERE `id`= @ENTRY;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES 
('3518', '27675');  /* Quest(27675): Forged Documents ,QuestMinLevel: 1 ,QuestProfession ID: 0[THIS SKILL DONT EXIST] */ 


DELETE FROM waypoints WHERE  `entry` = @ENTRY;
DELETE FROM npc_spellclick_spells WHERE  `npc_entry` = @ENTRY;
DELETE FROM creature_default_trainer WHERE  `CreatureId` = @ENTRY;