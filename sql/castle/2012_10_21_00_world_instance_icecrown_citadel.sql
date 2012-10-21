-- Damage stuff
-- 10 NH => 10 HC bzw. 25 NH: 10NH / 10HC = 0.65
-- 10 HC bzw. 25 NH => 25 HC: 25NH / 25HC = 0.75
-- Melee damage modifications
UPDATE `creature_template` SET `baseattacktime` = 2000 WHERE `entry` = 36612; -- Lord Marrowgar 10 NH, Damage scaling via baseattacktime
UPDATE `creature_template` SET `baseattacktime` = 1500 WHERE `entry` = 37957; -- Lord Marrowgar 25 NH, Damage scaling via baseattacktime
UPDATE `creature_template` SET `baseattacktime` = 1500 WHERE `entry` = 37958; -- Lord Marrowgar 10 HC, Damage scaling via baseattacktime
UPDATE `creature_template` SET `dmg_multiplier` = 20 WHERE `entry` = 36855; -- Lady Deathwhisper 10 NH
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` IN (38625, 38628, 38634, 38632); -- Lady Deathwhisper adds 10HC
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` IN (38394, 38393, 38395, 38396); -- Lady Deathwhisper adds 25NH
UPDATE `creature_template` SET `dmg_multiplier` = 75 WHERE `entry` = 38494; -- Rotting Frost Giant, 25 modes
UPDATE `creature_template` SET `dmg_multiplier` = 70 WHERE `entry` = 38582; -- Deathbringer Saurfang 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 45 WHERE `entry` = 37813; -- Deathbringer Saurfang 10 NH
UPDATE `creature_template` SET `dmg_multiplier` = 15 WHERE `entry` = 38508; -- Blood Beasts 10 NH
UPDATE `creature_template` SET `dmg_multiplier` = 25 WHERE `entry` = 38596; -- Blood Beasts 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 25 WHERE `entry` = 38597; -- Blood Beasts 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` = 38585; -- Professor Putricide 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` = 38431; -- Professor Putricide 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` IN (38784, 38769, 38771); -- Blood Prince Council 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` IN (38401, 38399, 38400); -- Blood Prince Council 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` = 38435; -- Blood-Queen Lana'thel 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` = 38434; -- Blood-Queen Lana'thel 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38721; -- Blazing Skeleton 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38169; -- Blazing Skeleton 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38723; -- Blistering Zombie 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38170; -- Blistering Zombie 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38724; -- Gluttonous Abomination 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38166; -- Gluttonous Abomination 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38725; -- Risen Archmage 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38167; -- Risen Archmage 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38726; -- Rot Worm 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38168; -- Rot Worm 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38727; -- Suppresser 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38171; -- Suppresser 25 NH
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` = 38266; -- Sindragosa 10 HC
UPDATE `creature_template` SET `dmg_multiplier` = 50 WHERE `entry` = 38265; -- Sindragosa 25 NH

-- Loot stuff
DELETE FROM `creature_loot_template` WHERE `entry` = 38490; -- Loot template for Rotting Frost Giant, no longer used
DELETE FROM `reference_loot_template` WHERE `item` IN (52025, 52026, 52027) AND `entry` = 34279; -- Use one reference for normal Marks of Sanctification and one for heroic ones
UPDATE `gameobject_loot_template` SET `maxcount` = 1 WHERE `entry` = 28058 AND `item` = 2 AND `mincountOrRef` = -34278; -- Deathbringer Saurfang 10 HC, only drop one normal Mark of Sanctification
UPDATE `gameobject_loot_template` SET `maxcount` = 1 WHERE `entry` = 28088 AND `item` = 2 AND `mincountOrRef` = -34279; -- Deathbringer Saurfang, 25 HC, drop one heroic Mark of Sanctification
DELETE FROM `gameobject_loot_template` WHERE `item` = 3 AND `entry` = 28088;
INSERT INTO `gameobject_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(28088, 3, 100, 1, 0, -34278, 2); -- Deathbringer Saurfang, 25 HC, drop two normal Marks of Sanctification
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 38586 AND `item` = 1 AND `mincountOrRef` = -34279; -- Professor Putricide, 25 HC, drop one heroic Mark of Sanctification
DELETE FROM `creature_loot_template` WHERE `item` = 2 AND `entry` = 38586;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(38586, 2, 100, 1, 0, -34278, 2); -- Professor Putricide, 25 HC, drop two normal Marks of Sanctification
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 38436 AND `item` = 2 AND `mincountOrRef` = -34279; -- Blood-Queen Lana'thel, 25 HC, drop one heroic Mark of Sanctification
DELETE FROM `creature_loot_template` WHERE `item` = 3 AND `entry` = 38436;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(38436, 3, 100, 1, 0, -34278, 2); -- Blood-Queen Lana'thel, 25 HC, drop two normal Marks of Sanctification
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 38267 AND `item` = 2 AND `mincountOrRef` = -34279; -- Sindragosa, 25 HC, drop one heroic Mark of Sanctification
DELETE FROM `creature_loot_template` WHERE `item` = 3 AND `entry` = 38267;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(38267, 3, 100, 1, 0, -34278, 2); -- Sindragosa, 25 HC, drop two normal Marks of Sanctification
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 39168 AND `item` = 2 AND `mincountOrRef` = -34279; -- The Lich King, 25 HC, drop one heroic Mark of Sanctification
DELETE FROM `creature_loot_template` WHERE `item` = 3 AND `entry` = 39168;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(39168, 3, 100, 1, 0, -34278, 2); -- The Lich King, 25 HC, drop two normal Marks of Sanctification
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 38784 AND `item` = 1 AND `mincountOrRef` = -34259; -- Blood Prince Council, 10 HC, should only drop 2 equip items
UPDATE `gameobject_loot_template` SET `maxcount` = 2 WHERE `entry` = 28064 AND `item` = 1 AND `mincountOrRef` = -34265; -- Valithria should drop 2 equip items in 10 HC

-- Lady Deathwisper
UPDATE `creature_template` SET `baseattacktime` = 2000, `mingold` = 837154, `maxgold` = 900000, `rank` = 3 WHERE `entry` IN (36855, 38106, 38296, 38297);

-- Cult Fanatic, Cult Adherent, Deformed Fanatic, Empowered Adherent
UPDATE `creature_template` SET `mechanic_immune_mask` = 8388624 WHERE `entry` IN (37890, 38393, 38628, 38629, 37949, 38394, 38625, 38626, 38135, 38395, 38634, 38635, 38136, 38396, 38632, 38633);

-- Rotting Frost Giant, spawns gunship chest
UPDATE `gameobject_template` SET `flags` = 50 WHERE `entry` IN (201872, 201874, 201873, 201875, 202177, 202180, 202178, 202179);
DELETE FROM `gameobject` WHERE `id` IN (201872, 201874, 201873, 201875, 202177, 202180, 202178, 202179);
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(201875, 631, 8, 1, -209.678, 2211.54, 199.97, 3.13972, 0, 0, 1, 0.000936107, 604800, 0, 1),
(201874, 631, 2, 1, -209.678, 2211.54, 199.97, 3.13972, 0, 0, 1, 0.000936107, 604800, 0, 1),
(201872, 631, 1, 1, -209.678, 2211.54, 199.97, 3.13972, 0, 0, 1, 0.000936107, 604800, 0, 1),
(201873, 631, 4, 1, -209.678, 2211.54, 199.97, 3.13972, 0, 0, 1, 0.000936107, 604800, 0, 1);
UPDATE `creature` SET `spawnMask` = 15, `position_x` = -257.36, `position_y` = 2212.27, `position_z` = 199.98, `orientation` = 3.1397 WHERE `id` = 38490;
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83, `faction_A` = 16, `faction_H` = 16, `speed_run` = 1.3, `baseattacktime` = 2000, `unit_flags` = 33280, `lootid` = 0, `InhabitType` = 3, `mechanic_immune_mask` = 617298815 WHERE `entry` IN (38490, 38494);
UPDATE `creature_template` SET `difficulty_entry_1` = 38494 WHERE `entry` = 38490;

-- Deathbringer Saurfang should not add Scent of Blood aura to adds, damage increase will fail in that case
DELETE FROM `conditions` WHERE `SourceEntry` = 72771 AND `SourceTypeOrReferenceId` = 17;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 72771, 0, 0, 31, 0, 3, 38508, 0, 0, 0, '', 'Deathbringer Saurfang - Scent of Blood disabled for Saurfang, adds will use AddAura');

-- Rotface
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854271, `speed_walk` = 0.888888, `speed_run` =  1.5873 WHERE `entry` IN (36627, 38390, 38549, 38550);

-- Festergut
UPDATE `creature_template` SET `speed_walk` = 0.888888, `speed_run` = 1.5873 WHERE `entry` IN (36626, 37504, 37505, 37506);

-- Putricide
UPDATE `creature_template` SET `speed_walk` = 1.2, `speed_run` = 1.71429, `baseattacktime` = 1500, `rangeattacktime` = 0, `unit_flags` = 33554688, `VehicleId` = 587, `rank` = 3 WHERE `entry` IN (36678, 38431, 38585, 38586);

-- Volatile Ooze
UPDATE `creature_Template` SET `mechanic_immune_mask` = 650854271 WHERE `entry` IN (37697, 38604, 38758, 38759);

-- Gas Cloud
UPDATE `creature_Template` SET `mechanic_immune_mask` = 650854271 WHERE `entry` IN (37562, 38602, 38760, 38761);

-- Blood Orb Controller
UPDATE `creature_template` SET `mindmg` = 509, `maxdmg` = 683, `attackpower` = 805, `dmg_multiplier` = 35, `unit_flags` = 33554434, `dynamicflags` = 8, `minrangedmg` = 371, `maxrangedmg` = 535, `rangedattackpower` = 135 WHERE `entry` IN (38008, 38641, 38773, 38774);

-- Kinetic Bomb
UPDATE `creature_template` SET `dmg_multiplier` = 7.5, `mechanic_immune_mask` = 650854271 WHERE `entry` IN (38454, 38775, 38776, 38777);

-- Prince Valanar
UPDATE `creature_template` SET `baseattacktime` = 2000, `rangeattacktime` = 2000, `rangedattackpower` = 135 WHERE `entry` IN (37970, 38401, 38784, 38785);

-- Blood Queen Lana'Thel
-- Add spell script for heroic ability Presence of the Darkfallen
DELETE FROM `spell_script_names` WHERE `spell_id` = 71952;
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(71952, 'spell_blood_queen_presence_of_the_darkfallen');
UPDATE `creature_template` SET `rangeattacktime` = 0, `rangedattackpower` = 135 WHERE `entry` IN (37955, 38434, 38435, 38436);

-- Valithria
-- DB/Npcs: Fix heroic template references for 10/25 man for npc Blazing Skeleton 36791
UPDATE `creature_template` SET `difficulty_entry_2` = 38721, `difficulty_entry_3` = 38722 WHERE `entry` = 36791;

-- The Lich King (Trigger Valithria)
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83 WHERE `entry` = 16980;

-- Green Dragon Combat Trigger
UPDATE `creature_template` SET `minlevel` = 83, `maxlevel` = 83 WHERE `entry` = 38752;

-- The Lich King
-- Insert original TC spawn for Tirion Fordring again
DELETE FROM `creature` WHERE `id` = 38995;
INSERT INTO `creature` (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(150212, 38995, 631, 15, 1, 0, 0, 505.212, -2124.35, 840.94, 0, 3600, 0, 0, 0, 0, 0, 0, 0, 0);

-- Drudge Ghoul
UPDATE `creature_template` SET `dynamicflags` = 8 WHERE `entry` IN (37695, 39309, 39310, 39311);

-- The Lich King
UPDATE `creature_template` SET `rangeattacktime` = 2000, `minrangedmg` = 371, `maxrangedmg` = 535, `rangedattackpower` = 135, `type_flags` = 268435564 WHERE `entry` IN (36597, 39166, 39167, 39168);

-- Val'kyr Shadowguard
UPDATE `creature_template` SET `baseattacktime` = 2000 WHERE `entry` IN (36609, 39120, 39121, 39122);

-- Wicked Spirit and Vile Spirit
UPDATE `creature_template` SET `ScriptName` = 'npc_lich_king_spirit' WHERE `entry` IN (39190, 37799);
DELETE FROM `creature_template_addon` WHERE `entry` IN (39190, 39287, 39288, 39289, 37799, 39284, 39285, 39286);
INSERT INTO `creature_template_addon` (entry, path_id, mount, bytes1, bytes2, emote, auras) VALUES
(39190, 0, 0, 50331648, 0, 0, ''),
(39287, 0, 0, 50331648, 0, 0, ''),
(39288, 0, 0, 50331648, 0, 0, ''),
(39289, 0, 0, 50331648, 0, 0, ''),
(37799, 0, 0, 50331648, 0, 0, ''),
(39284, 0, 0, 50331648, 0, 0, ''),
(39285, 0, 0, 50331648, 0, 0, ''),
(39286, 0, 0, 50331648, 0, 0, '');

-- ICC Buff
DELETE FROM `disables` WHERE `entry` = 73824 AND `sourceType` = 0;
DELETE FROM `conditions` WHERE `SourceEntry` IN (73816, 73818, 73819, 73820, 73821, 73822, 73762, 73824, 73825, 73826, 73827, 73828) AND `SourceTypeOrReferenceId` = 17;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
-- (17, 0, 73816, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Horde 5, just allow specified modes'),
(17, 0, 73818, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Horde 10, just allow specified modes'),
-- (17, 0, 73819, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Horde 15, just allow specified modes'),
-- (17, 0, 73820, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Horde 20, just allow specified modes'),
-- (17, 0, 73821, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Horde 25, just allow specified modes'),
-- (17, 0, 73822, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Horde 30, just allow specified modes'),
-- (17, 0, 73762, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Alliance 5, just allow specified modes'),
(17, 0, 73824, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Alliance 10, just allow specified modes');
-- (17, 0, 73825, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Alliance 15, just allow specified modes'),
-- (17, 0, 73826, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Alliance 20, just allow specified modes'),
-- (17, 0, 73827, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Alliance 25, just allow specified modes'),
-- (17, 0, 73828, 0, 0, 19, 0, 1, 0, 0, 0, 0, '', 'ICC Buff - Alliance 30, just allow specified modes');
DELETE FROM `spell_area` WHERE `spell` IN (73824, 73818) AND `area` = 4812;
INSERT INTO `spell_area` (spell, area, quest_start, quest_start_active, quest_end, aura_spell, racemask, gender, autocast) VALUES
-- (73816, 4812, 0, 0, 0, 0, 690, 2, 1), -- Horde, 5
(73818, 4812, 0, 0, 0, 0, 690, 2, 1), -- Horde, 10
-- (73819, 4812, 0, 0, 0, 0, 690, 2, 1), -- Horde, 15
-- (73820, 4812, 0, 0, 0, 0, 690, 2, 1), -- Horde, 20
-- (73821, 4812, 0, 0, 0, 0, 690, 2, 1), -- Horde, 25
-- (73822, 4812, 0, 0, 0, 0, 690, 2, 1), -- Horde, 30
-- (73762, 4812, 0, 0, 0, 0, 1101, 2, 1), -- Alliance, 5
(73824, 4812, 0, 0, 0, 0, 1101, 2, 1); -- Alliance, 10
-- (73825, 4812, 0, 0, 0, 0, 1101, 2, 1), -- Alliance, 15
-- (73826, 4812, 0, 0, 0, 0, 1101, 2, 1), -- Alliance, 20
-- (73827, 4812, 0, 0, 0, 0, 1101, 2, 1), -- Alliance, 25
-- (73828, 4812, 0, 0, 0, 0, 1101, 2, 1); -- Alliance, 30