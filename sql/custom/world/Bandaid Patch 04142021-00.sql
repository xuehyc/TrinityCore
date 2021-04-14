/* Quest Fix 14400
https://www.wowhead.com/quest=14400/i-cant-wear-this
https://www.wowhead.com/object=196472/grandmas-good-clothes
phase change for game object 196472 Grandma's Good Clothes
Original SQL to restore:
UPDATE `gameobject` SET `PhaseId`='181' WHERE  `guid`=236357;
*/

UPDATE `gameobject` SET `PhaseId`='183' WHERE  `guid`=236357;

/*Quest Fix 14465
Duplicate Gate Fix
https://www.wowhead.com/quest=14465/to-greymane-manor
Original sql to restore:
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `phaseMask`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES (235520, 196399, 654, 4714, 4714, 1, 0, 1, 0, 431, -1, -1817.84, 2333.37, 36.3445, 3.79899, 0, 0, -0.946463, 0.322813, 300, 255, 1, '', 25383);
*/

DELETE FROM `gameobject` WHERE  `guid`=236492;

/*Quest Fix 14465
NPCS Not Phased even with relog test.
https://www.wowhead.com/quest=14465/to-greymane-manor
Original SQL to restore:
UPDATE `creature` SET `PhaseId`='184' WHERE  `areaID`=4817;
*/

UPDATE `creature` SET `PhaseId`='183' WHERE  `areaID`=4817;

/* Quest Fix 24438
https://www.wowhead.com/quest=24438/exodus
https://www.wowhead.com/npc=44928/stagecoach-carriage
Added missing Stagecoach
Original SQL to Restore:
DELETE FROM `creature_template` WHERE  `entry`=198888;
DELETE FROM `creature` WHERE  `guid`=396668;
UPDATE `creature` SET `PhaseId`='186' WHERE  `guid`=256018;
UPDATE `world`.`creature` SET `PhaseId`='186' WHERE  `guid`=256108;
*/
DELETE FROM `creature_template` WHERE  `entry`=198888;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `femaleName`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `exp_unk`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `HealthModifierExtra`, `ManaModifier`, `ManaModifierExtra`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (198888, 0, 0, 0, 0, 0, 33315, 0, 0, 0, 'Stagecoach Carriage', '', '', NULL, 0, 85, 85, 2, 0, 35, 1, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 'stagecoach', 0);
DELETE FROM `creature` WHERE  `guid`=396668;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `phaseMask`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (396668, 198888, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -1668.98, 2529.46, 97.8474, 4.49717, 300, 0, 0, 14873, 0, 0, 0, 0, 0, NULL, 0);
UPDATE `creature` SET `PhaseId`='105' WHERE  `guid`=256018;
UPDATE `creature` SET `PhaseId`='105' WHERE  `guid`=256108;

/* Quest Fix 24468 
https://www.wowhead.com/quest=24468/stranded-at-the-marsh
Phasing Issues fixes
Added missing Crocs
Added Kill Credit
Original SQL TO Restore:
UPDATE `creature` SET `PhaseId`='186' WHERE  `guid`=256048;
UPDATE `creature` SET `PhaseId`='186' WHERE  `guid`=37067;
UPDATE `creature_template` SET `KillCredit1`='0' WHERE  `entry`=36882;
*/

UPDATE `creature` SET `PhaseId`='105' WHERE  `id`=36882;
UPDATE `creature` SET `PhaseId`='105' WHERE  `id`=37067;
UPDATE `creature` SET `PhaseId`='105' WHERE  `id`=37078;
UPDATE `creature_template` SET `KillCredit1`='37078' WHERE  `entry`=36882;
DELETE FROM `creature` WHERE  `guid` IN (396672, 396673, 396674, 396675, 396676, 396677, 396678, 396679, 396680);
Insert into `creature` values
(396672, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -2064.36, 1807.3, 6.46938, 1.89428, 300, 0, 0, 176, 0, 0, 0, 0, 0, NULL, 0),
(396680, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -2048.89, 1821.76, 6.52926, 6.19198, 300, 0, 0, 156, 0, 0, 0, 0, 0, NULL, 0),
(396679, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -1988.77, 1819.49, 5.53618, 3.28286, 300, 0, 0, 176, 0, 0, 0, 0, 0, NULL, 0),
(396678, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -1969.42, 1806.05, 6.89254, 4.06905, 300, 0, 0, 176, 0, 0, 0, 0, 0, NULL, 0),
(396677, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -1972.64, 1749.78, 5.3126, 2.20608, 300, 0, 0, 176, 0, 0, 0, 0, 0, NULL, 0),
(396676, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -2042.98, 1749.07, 6.73753, 1.17721, 300, 0, 0, 176, 0, 0, 0, 0, 0, NULL, 0),
(396675, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -2084.05, 1734.78, 5.80988, 1.61939, 300, 0, 0, 176, 0, 0, 0, 0, 0, NULL, 0),
(396674, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -2100.97, 1771.98, 4.83132, 0.00303936, 300, 0, 0, 176, 0, 0, 0, 0, 0, NULL, 0),
(396673, 36882, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 0, -2085.77, 1795.42, 4.84525, 1.13087, 300, 0, 0, 156, 0, 0, 0, 0, 0, NULL, 0);

/* Quest Fix 24472 
https://www.wowhead.com/quest=24472/introductions-are-in-order
Phasing Issues fixes
Original SQL TO Restore:
UPDATE `creature` SET `PhaseId`='186' WHERE  `id`=36294;
UPDATE `creature` SET `PhaseId`='186' WHERE  `id`=36293;
UPDATE `gameobject` SET `PhaseId`='186' WHERE  `guid`=236530;
*/

UPDATE `creature` SET `PhaseId`='105' WHERE  `id`=36294;
UPDATE `creature` SET `PhaseId`='105' WHERE  `id`=36293;
UPDATE `gameobject` SET `PhaseId`='105' WHERE  `guid`=236530;

/*
Stormglen Village phasing
Original SQL TO Restore:
UPDATE `creature` SET `PhaseId`='186' WHERE  `areaID`=4731;
*/
UPDATE `creature` SET `PhaseId`='105' WHERE  `areaID`=4731;

/* Quest 24495
Phasing Fixes
https://www.wowhead.com/quest=24495/pieces-of-the-past
https://www.wowhead.com/object=201607/old-journal-page
Original SQL to Restore:
UPDATE `gameobject` SET `PhaseId`='186' WHERE  `Id`=201607;
*/

UPDATE `gameobject` SET `PhaseId`='105' WHERE  `Id`=201607;

/* Quest 24578 and 24501
The blackwald
https://www.wowhead.com/quest=24578/the-blackwald
https://www.wowhead.com/quest=24501/queen-sized-troubles
Original SQL TO Restore:
UPDATE `creature` SET `PhaseId`='186' WHERE  `guid`=256318;
UPDATE `creature` SET `PhaseId`='186' WHERE  `areaID`=4730;
UPDATE `creature` SET `PhaseId`='186' WHERE  `areaID`=4868;
*/

UPDATE `world`.`creature` SET `PhaseId`='105' WHERE  `guid`=256318;
UPDATE `creature` SET `PhaseId`='105' WHERE  `areaID`=4730;
UPDATE `creature` SET `PhaseId`='105' WHERE  `areaID`=4868;

/* Quest 24616
Placement and NPC Recreate
https://www.wowhead.com/quest=24616/losing-your-tail
Original SQL TO Restore:
DELETE FROM `creature` WHERE  `guid`=396683;
DELETE FROM `creature_template` WHERE  `entry`=37953;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `femaleName`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `exp_unk`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `HealthModifierExtra`, `ManaModifier`, `ManaModifierExtra`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (37953, 0, 0, 0, 0, 0, 21746, 0, 0, 0, 'Dark Scout', '', '', '', 0, 1, 1, 0, 0, 35, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 7, 0, 0, 37953, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 15595);
*/

DELETE FROM `creature` WHERE  `guid`=396683;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `phaseMask`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (396683, 37953, 654, 0, 0, 1, 0, 1, 105, 0, -1, 0, 1, -2238.94, 1407.15, -23.4787, 1.64373, 300, 0, 0, 42, 0, 0, 0, 0, 0, NULL, 0);
DELETE FROM `creature_template` WHERE  `entry`=37953;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `femaleName`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `exp_unk`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `HealthModifierExtra`, `ManaModifier`, `ManaModifierExtra`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (37953, 0, 0, 0, 0, 0, 21746, 0, 0, 0, 'Dark Scout', '', '', '', 0, 9, 9, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 7, 0, 0, 37953, 0, 0, 0, 0, 0, 0, 0, 0, 70796, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 15595);

/* 
Tal'Doren 
Phase Fix
Moonleaf fix
Original SQL TO Restore:
UPDATE `creature` SET `PhaseId`='186' WHERE  `areaID`=4841;
UPDATE `gameobject` SET `PhaseId`='186' WHERE  `guid`=236622;
UPDATE `gameobject` SET `PhaseId`='186' WHERE  `guid`=236622;
UPDATE `gameobject` SET `PhaseId`='186' WHERE  `guid`=236623;
UPDATE `gameobject` SET `PhaseId`='186' WHERE  `id`=236523;
DELETE FROM `gameobject_loot_template` WHERE  `Entry`=201914;
DELETE FROM `creature_loot_template` WHERE  `Entry`=37757;
UPDATE `gameobject` SET `PhaseId`='186' WHERE  `guid`=236595;
*/
UPDATE `creature` SET `PhaseId`='105' WHERE  `areaID`=4841;
UPDATE `gameobject` SET `PhaseId`='105' WHERE  `guid`=236621;
UPDATE `gameobject` SET `PhaseId`='105' WHERE  `guid`=236622;
UPDATE `gameobject` SET `PhaseId`='105' WHERE  `guid`=236623;
UPDATE `gameobject` SET `PhaseId`='105' WHERE  `id`=201914;
DELETE FROM `gameobject_loot_template` WHERE  `Entry`=201914;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `IsCurrency`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (201914, 50017, 0, 100, 1, 0, 1, 0, 1, 4, NULL);
DELETE FROM `creature_loot_template` WHERE  `Entry`=37757;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `IsCurrency`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (37757, 50017, 0, 100, 0, 0, 1, 0, 1, 1, NULL);
UPDATE `gameobject` SET `PhaseId`='105' WHERE  `guid`=236595;