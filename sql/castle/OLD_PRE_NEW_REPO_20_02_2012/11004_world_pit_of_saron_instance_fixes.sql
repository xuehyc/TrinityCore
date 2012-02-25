-- Pit of Saron / Grube von Saron instance / Instanz fixes

-- Visual creature 36794 Scourgelord Tyrannus, fix spawn and set flying
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 36794;
DELETE FROM `creature` WHERE `id` = 36794;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(36794, 658, 3, 1, 27982, 0, 743.167, 274.26, 591.361, 3.34059, 86400, 0, 0, 107848, 4169, 0, 0, 0, 0, 0);

-- Alliance and Horde depending npcs should be friendly to all players
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` IN (36993, 38188, 36990, 38189, 37583, 37774, 37779, 37582, 37584, 37496, 37587, 37497, 37588, 36770, 36764, 36771, 36765, 36772, 36766, 36773, 36767, 37645,37646,37647,37648,37649,37650,37651,37652,3699001,37604,37603,37628,37608,37624,37625,37623,37809,37797);

-- NPC 36891 Eisiger Protodrache, Iceborn Proto-Drake and NPC 31260 Ymirjar Skycaller, Himmelsrufer der Ymirjar, remove since respawn is wrong
DELETE FROM `vehicle_accessory` WHERE `entry` = 36891 AND `accessory_entry` = 31260;

-- NPC 36658, 36938 Scourgelord Tyrannus, Geißelfürst Tyrannus - Delete usual spawn, spawned with Rimefang
DELETE FROM `creature` WHERE `id` IN (36658, 36938);

-- NPC 38189 Lady Silvanas Windrunner - unnecessary spawn
DELETE FROM `creature` WHERE `id` = 38189;

-- Boss NPCs set immune mask and instance binding, fix their unit_flags
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247, `type_flags` = 0, `dynamicflags` = 0 WHERE `entry` IN (36494, 37613, 36476, 37627, 36477, 37629, 36658, 36938, 36661);
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` IN (37613, 37627, 37629, 36938);
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` IN (37627, 36476, 36661, 37613, 36494);
UPDATE `creature_template` SET `unit_flags` = 33554434 WHERE `entry` IN (36658, 36938);
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` IN (36477, 37629);

-- Fix spawns of NPC 36896, 37636 Gargoyle der Zornknochen, Stonespine Gargoyle
UPDATE `creature_template` SET `unit_flags` = 0, `dynamicflags` = 0, `type_flags` = 0 WHERE `entry` IN (36896, 37636);
DELETE FROM `creature` WHERE `id` = 36896;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(36896, 658, 3, 1, 0, 0, 665.632, 186.387, 513.774, 2.59901, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 702.799, 188.808, 514.842, 1.69344, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 719.681, 146.799, 516.29, 5.46492, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 767.508, 145.052, 513.523, 6.09874, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 675.466, 141.284, 518.117, 3.47944, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 633.818, 142.423, 512.322, 4.48553, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 593.487, 130.275, 515.106, 3.03961, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 618.419, 99.8709, 512.715, 5.41701, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 629.153, 67.6221, 513.459, 1.64475, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 768.226, 111.574, 514.677, 2.47884, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 740, 156.121, 515.141, 3.33885, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 798.052, -14.5616, 510.424, 3.9601, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 749.343, -40.7652, 510.424, 5.06123, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 746.104, -91.0982, 513.805, 3.61374, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 673.343, -78.6509, 516.853, 2.38931, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 638.156, -55.0167, 516.853, 0.941817, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 672.714, 159.618, 510.585, 2.71996, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0),
(36896, 658, 3, 1, 0, 0, 784.316, 130.311, 513.003, 4.99448, 86400, 0, 0, 189000, 0, 0, 0, 0, 0, 0);

-- FIX NPC 36830, 37638 Wrathbone Laborer, Arbeiter der Zornknochen, fix unit_flags
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` IN (36830, 37638);

-- Fix equipment - Needed for spellcasting
DELETE FROM `creature_equip_template` WHERE `entry` = 10048;
INSERT INTO `creature_equip_template` (entry, equipentry1, equipentry2, equipentry3) VALUES (10048, 39730, 41754, 0);
UPDATE `creature_template` SET `equipment_id` = 10048 WHERE `entry` = 36841;
UPDATE `creature` SET `equipment_id` = 0 WHERE `id` = 36841;

-- Spawn a new mob group on top of the hill
DELETE FROM `creature` WHERE `map` = 658 AND `position_x` < 964 AND `position_x` > 938 AND `position_y` < 53 AND `position_y` > 29;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(36892, 658, 3, 1, 0, 0, 950.43, 39.7003, 570.159, 1.3658, 86400, 0, 0, 163800, 79880, 0, 0, 0, 0, 0),
(36893, 658, 3, 1, 0, 0, 944.622, 41.3094, 569.966, 1.32575, 86400, 0, 0, 119700, 31952, 0, 0, 0, 0, 0),
(36893, 658, 3, 1, 0, 0, 956.085, 39.0215, 570.368, 1.49853, 86400, 0, 0, 119700, 31952, 0, 0, 0, 0, 0),
(36840, 658, 3, 1, 0, 0, 962.495, 36.2585, 571.593, 1.3658, 86400, 0, 0, 119700, 0, 0, 0, 0, 0, 0),
(36840, 658, 3, 1, 0, 0, 940.338, 45.2305, 569.553, 1.3658, 86400, 0, 0, 119700, 0, 0, 0, 0, 0, 0);

-- A bit trash movement
UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` IN (36788,36840,36841,36842,36877,36879,36881,36892,36896,36907,37592,37711,37712,37713,37728,36830,36891) AND `map` = 658;

-- Fix questchain ICC
UPDATE `creature_template` SET `npcflag` = `npcflag` + 2 WHERE !(`npcflag` & 2) AND `entry` IN (37597, 37596, 38160, 38161, 36990, 36993, 37591, 38189, 38188, 3699001, 37606, 3759601);
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` IN (37597, 37596, 38160, 38161, 36990, 36993, 37591, 38189, 38188, 3699001, 37606, 3759601);
DELETE FROM `creature_questrelation` WHERE `quest` IN (24499, 24683, 24498, 24710, 24711, 24511, 24682, 24507, 24712, 24713);
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (24510, 24499, 24683, 24498, 24710, 24506, 24511, 24682, 24507, 24712);
INSERT INTO `creature_questrelation` (id, quest) VALUES
(37596, 24499),
(37597, 24499),
(37596, 24511),
(37597, 24511),
(38160, 24683),
(38160, 24682),
(38161, 24683),
(38161, 24682),
(36990, 24498),
(36990, 24507),
(36993, 24498),
(36993, 24507),
(37591, 24710),
(37591, 24712),
(38189, 24711),
(38189, 24713),
(38188, 24711),
(38188, 24713);
INSERT INTO `creature_involvedrelation` (id, quest) VALUES
(37597, 24510),
(37597, 24506),
(37596, 24510),
(37596, 24506),
(38160, 24499),
(38160, 24511),
(38161, 24499),
(38161, 24511),
(36990, 24683),
(36990, 24682),
(36993, 24683),
(36993, 24682),
(37591, 24498),
(37591, 24507),
(38189, 24710),
(38189, 24712),
(38188, 24710),
(38188, 24712);
DELETE FROM `creature` WHERE `id` IN (37591, 38189);
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(37591, 658, 3, 1, 0, 0, 849.765, 48.6963, 512.844, 3.75418, 86400, 0, 0, 151200, 0, 0, 0, 0, 0, 0),
(38189, 658, 3, 1, 0, 1290, 1096.91, 125.891, 628.865, 2.38991, 86400, 0, 0, 6972500, 85160, 0, 0, 0, 0, 0);


-- Trash AI
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (36788,36840,36841,36842,36879,36892,36896,37711,37712,37713,37728);
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` IN (36788,36840,36841,36842,36879,36892,36896,37711,37712,37713,37728);
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(3678801, 36788, 0, 0, 100, 3, 5000, 10000, 8000, 12000, 11, 69577, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Necrolyte (Normal) - Cast Shadow Bolt'),
(3678802, 36788, 0, 0, 100, 5, 5000, 10000, 8000, 12000, 11, 70270, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Necrolyte (Heroic) - Cast Shadow Bolt'),
(3678803, 36788, 0, 0, 100, 3, 5000, 10000, 8000, 12000, 11, 69578, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Necrolyte (Normal) - Cast Conversion Beam'),
(3678804, 36788, 0, 0, 100, 5, 5000, 10000, 8000, 12000, 11, 70269, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Necrolyte (Heroic) - Cast Conversion Beam'),
(3684001, 36840, 0, 0, 100, 3, 5000, 10000, 8000, 15000, 11, 69603, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Wrathbringer (Normal) - Cast Blight'),
(3684002, 36840, 0, 0, 100, 5, 5000, 10000, 8000, 15000, 11, 70285, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Wrathbringer (Heroic) - Cast Blight'),
(3684101, 36841, 0, 0, 100, 7, 5000, 10000, 8000, 12000, 11, 69579, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Warrior - Cast Arcing Slice'),
(3684102, 36841, 0, 0, 100, 7, 5000, 10000, 8000, 12000, 11, 61044, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Warrior - Cast Demoralizing Shout'),
(3684103, 36841, 0, 0, 100, 7, 5000, 10000, 8000, 12000, 11, 69580, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallen Warrior - Cast Shield Block'),
(3684201, 36842, 0, 0, 100, 3, 5000, 10000, 8000, 12000, 11, 69573, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Coldwraith (Normal) - Cast Frostbolt'),
(3684202, 36842, 0, 0, 100, 5, 5000, 10000, 8000, 12000, 11, 70277, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Coldwraith (Heroic) - Cast Frostbolt'),
(3684203, 36842, 0, 0, 100, 7, 5000, 10000, 8000, 12000, 11, 34779, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Coldwraith - Cast Freezing Circle'),
(3687901, 36879, 0, 0, 100, 3, 5000, 10000, 7000, 12000, 11, 69581, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Plagueborn Horror (Normal) - Cast Pustulant Flesh'),
(3687902, 36879, 0, 0, 100, 5, 5000, 10000, 7000, 12000, 11, 70273, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Plagueborn Horror (Heroic) - Cast Pustulant Flesh'),
(3687903, 36879, 0, 0, 100, 7, 5000, 10000, 8000, 15000, 11, 70274, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Plagueborn Horror - Cast Toxic Waste'),
(3689201, 36892, 0, 0, 100, 3, 5000, 10000, 6000, 10000, 11, 69528, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer (Normal) - Cast Empowered Shadow Bolt'),
(3689202, 36892, 0, 0, 100, 5, 5000, 10000, 6000, 10000, 11, 70281, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirjar Deathbringer (Heroic) - Cast Empowered Shadow Bolt'),
(3689601, 36896, 0, 0, 100, 3, 5000, 10000, 8000, 12000, 11, 69520, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonespine Gargoyle (Normal) - Cast Gargoyle Strike'),
(3689602, 36896, 0, 0, 100, 5, 5000, 10000, 8000, 12000, 11, 70275, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonespine Gargoyle (Heroic) - Cast Gargoyle Strike'),
(3689603, 36896, 0, 0, 100, 7, 15000, 20000, 10000, 30000, 11, 69575, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonespine Gargoyle - Cast Stoneform'),
(3771101, 37711, 0, 0, 100, 7, 9000, 14000, 10000, 14000, 11, 70393, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hungering Ghoul - Cast Devour Flesh'),
(3771201, 37712, 0, 0, 100, 3, 5000, 10000, 8000, 12000, 11, 70386, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Shadowcaster (Normal) - Cast Shadow Bolt'),
(3771202, 37712, 0, 0, 100, 5, 5000, 10000, 8000, 12000, 11, 70387, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Shadowcaster (Heroic) - Cast Shadow Bolt'),
(3771203, 37712, 0, 0, 100, 7, 5000, 10000, 15000, 20000, 11, 70388, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Shadowcaster - Cast Seed of Corruption'),
(3771301, 37713, 0, 0, 100, 7, 5000, 10000, 8000, 12000, 11, 70392, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Torturer - Cast Black Brand'),
(3771302, 37713, 0, 0, 100, 7, 5000, 10000, 8000, 12000, 11, 70391, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Deathwhisper Torturer - Cast Curse of Agony'),
(3772801, 37728, 0, 0, 100, 3, 5000, 10000, 8000, 12000, 11, 75330, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Sorcerer (Normal) - Cast Shadow Bolt'),
(3772802, 37728, 0, 0, 100, 5, 5000, 10000, 8000, 12000, 11, 75331, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Sorcerer (Heroic) - Cast Shadow Bolt'),
(3772803, 37728, 0, 0, 100, 7, 10000, 14000, 15000, 20000, 11, 70388, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Sorcerer - Cast Seed of Corruption');