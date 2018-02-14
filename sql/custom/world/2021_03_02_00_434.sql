UPDATE `creature_template` SET `speed_walk`=0.2, `speed_run`=1.142857 WHERE `entry`=49039; -- Glubtok Firewall Platter Creature Level 1b
UPDATE `creature_template` SET `speed_walk`=0.2, `speed_run`=1.142857 WHERE `entry`=48976; -- Glubtok Firewall Platter Creature Level 2a
UPDATE `creature_template` SET `minlevel`=86, `maxlevel`=86 WHERE `entry`=48829; -- Ogre Henchman
UPDATE `creature_template` SET `speed_walk`=0.2, `speed_run`=1.142857 WHERE `entry`=48975; -- Glubtok Firewall Platter Creature Level 1a
UPDATE `creature_template` SET `speed_walk`=0.2, `speed_run`=1.142857 WHERE `entry`=48974; -- Glubtok Firewall Platter
UPDATE `creature_template` SET `speed_walk`=0.2, `speed_run`=1.142857 WHERE `entry`=49041; -- Glubtok Firewall Platter Creature Level 2b
UPDATE `creature_template` SET `speed_walk`=0.2, `speed_run`=1.142857 WHERE `entry`=49040; -- Glubtok Firewall Platter Creature Level 1c
UPDATE `creature_template` SET `speed_walk`=0.2, `speed_run`=1.142857 WHERE `entry`=49042; -- Glubtok Firewall Platter Creature Level 2c
UPDATE `creature_template` SET `BaseAttackTime`=1000 WHERE `entry`=48229; -- Kobold Digger
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `BaseAttackTime`=1000 WHERE `entry`=48834; -- Kobold Digger
UPDATE `creature_template` SET `minlevel`=86, `maxlevel`=86 WHERE `entry`=48830; -- Ogre Bodyguard
UPDATE `creature_template` SET `minlevel`=85, `maxlevel`=85, `unit_flags2`=0 WHERE `entry`=48835; -- Mining Powder

DELETE FROM `creature` WHERE `id` IN (49039, 48976, 48975, 48974, 49041, 49040, 49042);
DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
UPDATE `creature_template` SET `flags_extra`= 131 WHERE `entry` IN (49039, 48976, 48975, 49041, 49040, 49042);

-- Conditions
DELETE FROM `conditions` WHERE `SourceEntry` IN (89769, 91063, 89697, 91066) AND `SourceTypeOrReferenceId` = 13;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ScriptName, Comment) VALUES
(13, 1, 89769, 0, 0, 31, 0, 3, 48230, 0, 0, 0, '', 'Explode - Target Ogre Henchman'),
(13, 1, 89769, 0, 1, 31, 0, 3, 48284, 0, 0, 0, '', 'Explode - Target Mining Powder'),
(13, 1, 89769, 0, 2, 31, 0, 3, 48229, 0, 0, 0, '', 'Explode - Target Kobold Digger'),
(13, 1, 89769, 0, 3, 31, 0, 3, 48279, 0, 0, 0, '', 'Explode - Target Goblin Overseer'),
(13, 1, 89769, 0, 4, 31, 0, 3, 48338, 0, 0, 0, '', 'Explode - Target Goblin Bunny'),
(13, 1, 89769, 0, 5, 31, 0, 3, 48278, 0, 0, 0, '', 'Explode - Target Mining Monkey'),
(13, 1, 89769, 0, 6, 31, 0, 3, 48445, 0, 0, 0, '', 'Explode - Target Oaf Lackey'),
(13, 1, 89697, 0, 7, 31, 0, 3, 48419, 0, 0, 0, '', 'Explode - Target Defias Miner'),
(13, 1, 89697, 0, 8, 31, 0, 3, 48418, 0, 0, 0, '', 'Explode - Target Defias Envoker'),
(13, 1, 89697, 0, 9, 31, 0, 3, 48421, 0, 0, 0, '', 'Explode - Target Defias Overseer'),
(13, 1, 89697, 0, 10, 31, 0, 3, 48502, 0, 0, 0, '', 'Explode - Target Defias Enforcer'),
(13, 1, 89697, 0, 11, 31, 0, 3, 48417, 0, 0, 0, '', 'Explode - Target Blood Wizard'),
(13, 1, 89697, 0, 12, 31, 0, 3, 48505, 0, 0, 0, '', 'Explode - Target Defias Shadowguard'),
--
(13, 1, 91063, 0, 0, 31, 0, 3, 48230, 0, 0, 0, '', 'Explode - Target Ogre Henchman'),
(13, 1, 91063, 0, 1, 31, 0, 3, 48284, 0, 0, 0, '', 'Explode - Target Mining Powder'),
(13, 1, 91063, 0, 2, 31, 0, 3, 48229, 0, 0, 0, '', 'Explode - Target Kobold Digger'),
(13, 1, 91063, 0, 3, 31, 0, 3, 48279, 0, 0, 0, '', 'Explode - Target Goblin Overseer'),
(13, 1, 91063, 0, 4, 31, 0, 3, 48338, 0, 0, 0, '', 'Explode - Target Goblin Bunny'),
(13, 1, 91063, 0, 5, 31, 0, 3, 48278, 0, 0, 0, '', 'Explode - Target Mining Monkey'),
(13, 1, 91063, 0, 6, 31, 0, 3, 48445, 0, 0, 0, '', 'Explode - Target Oaf Lackey'),
(13, 1, 91063, 0, 7, 31, 0, 3, 48419, 0, 0, 0, '', 'Explode - Target Defias Miner'),
(13, 1, 91063, 0, 8, 31, 0, 3, 48418, 0, 0, 0, '', 'Explode - Target Defias Envoker'),
(13, 1, 91063, 0, 9, 31, 0, 3, 48421, 0, 0, 0, '', 'Explode - Target Defias Overseer'),
(13, 1, 91063, 0, 10, 31, 0, 3, 48502, 0, 0, 0, '', 'Explode - Target Defias Enforcer'),
(13, 1, 91063, 0, 11, 31, 0, 3, 48417, 0, 0, 0, '', 'Explode - Target Defias Blood Wizard'),
(13, 1, 91063, 0, 12, 31, 0, 3, 48505, 0, 0, 0, '', 'Explode - Target Defias Shadowguard'),
--
(13, 1, 89697, 0, 0, 31, 0, 3, 45979, 0, 0, 0, '', 'Cannonball - Target General Purpose Bunny'),
--
(13, 1, 91066, 0, 0, 31, 0, 3, 45979, 0, 0, 0, '', 'Cannonball - Target General Purpose Bunny');

-- Creature Mining Powder 48284 SAI
SET @ENTRY := 48284;
UPDATE `creature_template` SET `AIName`="SmartAI", `flags_extra`= 2 WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 6, 0, 100, 0, 0, 0, 0, 0, 11, 90096, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On death - Self: Cast spell 90096 on Self // "),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 89769, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Cast spell 89769 on Self // "),
(@ENTRY, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 3, 0, 11686, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Morph to model 11686 // ");

-- Creature Kobold Digger 48229 SAI
SET @ENTRY := 48229;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
SET @ENTRY := -375926;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 60, 0, 100, 1, 100, 100, 0, 0, 11, 46598, 0, 0, 0, 0, 0, 10, 375931, 0, 0, 0, 0, 0, 0, "Every 0 and 0 ms (for the first time, timer between 100 and 100 ms) - Self: Cast spell 46598 on Creature Ogre Henchman 48230 (375931) // "),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Set react state to REACT_PASSIVE // ");

-- Creature Ogre Henchman 48230 SAI
SET @ENTRY := 48230;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
SET @ENTRY := -375931;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 1, 100, 0, 6500, 6500, 13000, 13000, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When out of combat and timer at the begining between 6500 and 6500 ms (and later repeats every 13000 and 13000 ms) - Self: Play emote 16 // "),
(@ENTRY, 0, 1, 0, 1, 1, 100, 0, 8000, 8000, 13000, 13000, 86, 89697, 0, 10, 375933, 0, 0, 10, 375992, 0, 0, 0, 0, 0, 0, "When out of combat and timer at the begining between 8000 and 8000 ms (and later repeats every 13000 and 13000 ms) - SMART_TARGET_CREATURE_GUID: Cast spell 89697 at Creature General Purpose Bunny JMF 45979 (375992) // "),
(@ENTRY, 0, 2, 0, 4, 0, 100, 1, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Set event phase to 2 // "),
(@ENTRY, 0, 3, 0, 27, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On passenger boarded (vehicle) - Self: Set event phase to 1 // "),
(@ENTRY, 0, 4, 0, 28, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On passenger removed (vehicle) - Action invoker: Set react state to REACT_AGGRESSIVE // ");

-- Template Updates
-- Glubtok
UPDATE `creature_template` SET `scriptname`= 'boss_glubtok' WHERE `entry`= 47162;
UPDATE `creature_template` SET `minlevel`=87, `maxlevel`=87 WHERE `entry`=48936;
-- General Purpose Bunny JMF Look 2
UPDATE `creature_template` SET `InhabitType`= 4 WHERE `entry`= 47242;
-- General Purpose Bunny JMF
UPDATE `creature_template` SET `InhabitType`= 4 WHERE `entry`= 45979;
-- Glubtok Firewall Platter
UPDATE `creature_template` SET `InhabitType`= 4 WHERE `entry`= 48974;

-- Texts
DELETE FROM `creature_text` WHERE `CreatureID`= 47162;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `Comment`) VALUES
(47162, 0, 0, 'Glubtok show you da power of de arcane!', 14, 0, 100, 0, 0, 21151, 47256, 'Glubtok to Player'),
(47162, 1, 0, 'Fists of flame!', 14, 0, 100, 0, 0, 21153, 47239, 'Glubtok'),
(47162, 2, 0, 'Fists of frost!', 14, 0, 100, 0, 0, 21156, 47238, 'Glubtok'),
(47162, 3, 0, 'Glubtok ready?', 14, 0, 100, 1, 0, 21154, 47361, 'Glubtok'),
(47162, 4, 0, 'Let''s do it!', 14, 0, 100, 15, 0, 21157, 47362, 'Glubtok'),
(47162, 5, 0, 'ARCANE POWER!!!', 14, 0, 100, 15, 0, 21146, 47363, 'Glubtok'),
(47162, 6, 0, '|TInterface\\Icons\\spell_holy_innerfire.blp:20|t Glubtok creates a moving |cFFFF0000|Hspell:91398|h[Fire Wall]|h|r!', 41, 0, 100, 0, 0, 0, 49155, 'Glubtok'),
(47162, 7, 0, 'TOO...MUCH...POWER!!!', 14, 0, 100, 15, 0, 21145, 47422, 'Glubtok');

-- Conditions
DELETE FROM `conditions` WHERE `SourceEntry` IN (88072, 88093) AND `SourceTypeOrReferenceId`= 13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ScriptName`, `Comment`) VALUES
(13, 1, 88072, 0, 0, 31, 0, 3, 47162, 0, 0, 0, '', 'Arcane Fire Beam - Target Glubtok'),
(13, 1, 88093, 0, 0, 31, 0, 3, 47162, 0, 0, 0, '', 'Arcane Frost Beam - Target Glubtok');

-- Spells
DELETE FROM `spell_proc` WHERE `SpellId` IN (87900, 87897);
INSERT INTO `spell_proc` (`SpellId`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `Cooldown`) VALUES
(87900, 0x00000004, 1, 0, 4000),
(87897, 0x00000004, 1, 0, 4000);

-- Spellclick spells
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (48974, 48975, 49039, 49040);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(48974, 46598, 1, 1),
(48975, 47020, 1, 1),
(49039, 47020, 1, 1),
(49040, 47020, 1, 1);

-- Vehicle Accessory
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (48974, 48975, 49039, 49040);
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(48974, 48975, 0, 1, 'Glubtok Firewall Platter', 5, 0),
(48974, 49039, 1, 1, 'Glubtok Firewall Platter', 5, 0),
(48974, 49040, 2, 1, 'Glubtok Firewall Platter', 5, 0),
(48974, 49040, 3, 1, 'Glubtok Firewall Platter', 5, 0),
(48974, 48975, 4, 1, 'Glubtok Firewall Platter', 5, 0),
(48974, 49039, 5, 1, 'Glubtok Firewall Platter', 5, 0),
(48974, 49040, 6, 1, 'Glubtok Firewall Platter', 5, 0),
(48974, 49040, 7, 1, 'Glubtok Firewall Platter', 5, 0),
(49040, 49042, 5, 1, 'Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c', 5, 0), -- Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c
(49040, 49042, 4, 1, 'Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c', 5, 0), -- Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c
(49040, 49042, 1, 1, 'Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c', 5, 0), -- Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c
(49040, 49042, 0, 1, 'Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c', 5, 0), -- Glubtok Firewall Platter Creature Level 1c - Glubtok Firewall Platter Creature Level 2c
(49039, 49041, 5, 1, 'Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b', 5, 0), -- Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b
(49039, 49041, 4, 1, 'Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b', 5, 0), -- Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b
(49039, 49041, 1, 1, 'Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b', 5, 0), -- Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b
(49039, 49041, 0, 1, 'Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b', 5, 0), -- Glubtok Firewall Platter Creature Level 1b - Glubtok Firewall Platter Creature Level 2b
(48975, 48976, 5, 1, 'Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a', 5, 0), -- Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a
(48975, 48976, 4, 1, 'Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a', 5, 0), -- Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a
(48975, 48976, 1, 1, 'Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a', 5, 0), -- Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a
(48975, 48976, 0, 1, 'Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a', 5, 0); -- Glubtok Firewall Platter Creature Level 1a - Glubtok Firewall Platter Creature Level 2a

DELETE FROM `spell_script_names` WHERE `ScriptName`= 'spell_glubtok_blossom_targeting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(88140, 'spell_glubtok_blossom_targeting');

-- Creature Fire Blossom 48957 SAI
SET @ENTRY := 48957;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, "On just summoned - Self: Attack Players in 30 yards // ");

-- Creature Frost Blossom 48957 SAI
SET @ENTRY := 48958;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, "On just summoned - Self: Attack Players in 30 yards // ");

-- Loot
DELETE FROM `creature_loot_template` WHERE `entry` IN (47162, 48936);
DELETE FROM creature_loot_template WHERE `entry` IN (47162, 48936);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(47162, 5195, 0, 1, 1, 1, 1),
(47162, 2169, 0, 1, 1, 1, 1),
(47162, 5194, 0, 1, 1, 1, 1);

UPDATE `creature_template` SET `lootid`= 48936 WHERE `entry`= 48936;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(48936, 63467, 0, 1, 1, 1, 1),
(48936, 63468, 0, 1, 1, 1, 1),
(48936, 63471, 0, 1, 1, 1, 1),
(48936, 63470, 0, 1, 1, 1, 1),
(48936, 65163, 0, 1, 1, 1, 1);

