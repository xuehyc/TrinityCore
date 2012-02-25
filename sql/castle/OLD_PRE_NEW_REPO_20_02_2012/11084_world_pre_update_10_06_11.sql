-- Fix quests 12083, 12084 Über den Waldländern / Ueber den Waldlaendern / Atop the Woodlands - set reqspellcast of item to cast on trigger creature
UPDATE `quest_template` SET `ReqSpellCast1` = 47469 WHERE `entry` IN (12083, 12084);

-- Fix quest 11796 Notfallprotokoll: Sektion 8,2. Paragraph D / Emergency Protocol: Section 8.2, Paragraph D
UPDATE `quest_template` SET `ReqSpellCast1` = 46171, `ReqSpellCast2` = 46171, `ReqSpellCast3` = 46171 WHERE `entry` = 11796;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 46171;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 46171, 0, 18, 1, 25845, 0, 0, '', 'Quest support 11796'),
(13, 0, 46171, 1, 18, 1, 25846, 0, 0, '', 'Quest support 11796'),
(13, 0, 46171, 2, 18, 1, 25847, 0, 0, '', 'Quest support 11796');
DELETE FROM `gameobject` WHERE `id` = 300181;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(300181, 571, 1, 1, 3604.6, 5065, 13.2919, 5.39233, 0, 0, 0.430845, -0.902426, 25, 0, 1),
(300181, 571, 1, 1, 3476.66, 4918.67, 13.8639, 4.62499, 0, 0, 0.737321, -0.675542, 25, 0, 1),
(300181, 571, 1, 1, 3355.87, 5049.47, 14.2951, 6.05756, 0, 0, 0.112572, -0.993644, 25, 0, 1),
(300181, 571, 1, 1, 3739.39, 5047.41, -0.865776, 2.14675, 0, 0, 0.878816, 0.477161, 25, 0, 1),
(300181, 571, 1, 1, 3390.86, 5135.81, 14.4616, 1.18682, 0, 0, 0.559191, 0.829039, 25, 0, 1),
(300181, 571, 1, 1, 3515.69, 5016.58, -0.550566, 1.84193, 0, 0, 0.796187, 0.605051, 25, 0, 1);

-- Fix quests 12065, 12066 Der Fokus am Strand / The Focus on the Beach - set reqspellcast of item to cast on trigger creature
UPDATE `quest_template` SET `ReqSpellCast1` = 47374 WHERE `entry` IN (12066, 12065);

-- Fix item 44115 Belobigung von Tausendwinter / Wintergrasp Commendation sold by
-- NPC 32294 Ritter Dameron / Knight Dameron and 32296 Steingardist Mutaha / Stone Guard Mukar
-- for 9 * Item 43589 Ehrenabzeichen von Tausendwinter / Wintergrasp Mark of Honor
DELETE FROM `npc_vendor` WHERE `entry` IN (32294, 32296) AND `item` = 44115 AND `ExtendedCost` = 2576;
INSERT INTO `npc_vendor` (entry, slot, item, maxcount, incrtime, ExtendedCost) VALUES
(32294, 0, 44115, 0, 0, 2576),
(32296, 0, 44115, 0, 0, 2576);

-- Fix NPC 26858 Sarathstra for quest 12097 Sarathstra, Geissel des Nordens / Sarathstra, Scourge of the North
DELETE FROM `waypoint_data` WHERE `id` = 1124010;
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 26858);
DELETE FROM `creature` WHERE `id` = 26858;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(26858, 571, 1, 1, 0, 0, 4340.48, 813.16, 72.9797, 0.742025, 300, 0, 0, 265875, 0, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `InhabitType` = 3 WHERE `entry` = 26858;

-- NPC Spirit Healer / Geistheiler (ID 6491) in DK Map 609 always visible in all phases
UPDATE `creature` SET `phaseMask` = 231 WHERE `id` = 6491 AND `map` = 609;

-- Fix quest 9164 (Gefangene der Todesfestung / Captives at Deatholme) - remove wrong reqspell requirement
UPDATE `quest_template` SET `ReqSpellCast1` = 0, `ReqSpellCast2` = 0, `ReqSpellCast4` = 0 WHERE `entry` = 9164;

-- Delete gameobjects 182582, 182583 Draenei Vessel / Draeneigefäß - Fake object triggering a trap, causes instant death at the moment
DELETE FROM `gameobject` WHERE `id` IN (182582, 182583);

-- Fix gameobject Twilight Tome / Zwielichtfoliant 12144 - Delete because it is an endless stunning trap;
DELETE FROM `gameobject` WHERE `id` = 12144;

-- Fix quest 12886 - Der Drakkensyrd / The Drakkensyrd - quest (working) autocomplete
UPDATE `quest_template` SET `Method` = 2, `SrcItemId` = 0, `SrcItemCount` = 0, `ReqSourceId2` = 0, `ReqSourceCount2` = 0, `ReqCreatureOrGoId1` = 0, `ReqCreatureOrGoCount1` = 0 WHERE `entry` = 12886;

-- Fix NPC Vortex (30090) from Malygos encounter, should not be targetable
UPDATE `creature_template` SET `unit_flags` = 33554432, `modelid2` = 0 WHERE `entry` = 30090;
-- Add Items Heroischer Schlüssel der fokussierenden Iris / Heroic Key to the Focusing Iris (44577)
-- and Schlüssel der fokussierenden Iris / Key to the Focusing Iris (44569) to Sapphiron (15989 / 29991) loot
-- needed for Das Auge der Ewigkeit / Eye of Eternity / EoE Instance / Instanz
DELETE FROM `creature_loot_template` WHERE `entry` IN (15989, 29991) AND `item` IN (44569, 44577);
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(15989, 44569, 100, 1, 0, 1, 1),
(29991, 44577, 100, 1, 0, 1, 1);
-- Fix NPC Power Spark / Energiefunke (30084, 32187) - Set lower speed for malygos encounter in instance / Instanz Eye of Eternity / EoE / Das Auge der Ewigkeit
UPDATE `creature_template` SET `speed_walk` = 1.44, `speed_run` = 0.514 WHERE `entry` IN (30084, 32187);
-- Fix Malygos templates EoE / Eye of Eternity / Das Auge der Ewigkeit instance / Instanz
UPDATE `creature_template` SET `difficulty_entry_1` = 31734, `mechanic_immune_mask` = 650853247 WHERE `entry` = 28859;
UPDATE `creature_template` SET `speed_walk` = 4, `speed_run` = 2.85714, `mindmg` = 496, `maxdmg` = 674, `attackpower` = 783, `dmg_multiplier` = 70, `unit_class` = 2, `minrangedmg` = 365, `maxrangedmg` = 529, `rangedattackpower` = 98, `flags_extra` = 1, `mechanic_immune_mask` = 650853247, `InhabitType` = 5 WHERE `entry` = 31734;
UPDATE `creature` SET `spawnMask` = 3, `spawntimesecs` = 604800 WHERE `id` = 28859;
-- Fix NPC 30249, Scion of Eternity / Abkömmling der Ewigkeit - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit - use script to simulate correct Arcane Barrage spellcasting
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_scion_of_eternity' WHERE `entry` = 30249;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30249 AND `source_type` = 0;
-- Fix spawning of gameobject 193960 Die fokussierende Iris / The focusing Iris in heroic mode - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
DELETE FROM `gameobject` WHERE `id` = 193960;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(193960, 616, 2, 1, 754.255, 1301.72, 266.17, 5.82666, 0, 0, 0.226287, -0.974061, 120, 0, 1);
-- Add spell linkings for heroic mode - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
DELETE FROM `spelldifficulty_dbc` WHERE `id` IN (8001, 8002, 8003);
INSERT INTO `spelldifficulty_dbc` (id, spellid0, spellid1, spellid2, spellid3) VALUES
(8001, 56272, 60072, 0, 0),
(8002, 57459, 61694, 0, 0),
(8003, 57058, 60073, 0, 0);
-- Assign scripts
DELETE FROM `spell_script_names` WHERE `spell_id` IN (57459, 61694);
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(57459, 'spell_malygos_arcane_storm'),
(61694, 'spell_malygos_arcane_storm');
-- Fix Surge of Power / Kraftsog NPC 30334  - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
UPDATE `creature_template` SET `unit_flags` = 33554434, `InhabitType` = 5 WHERE `entry` = 30334;
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 30334);
DELETE FROM `creature` WHERE `id` = 30334;
-- Fix NPC Wyrmrest Skytalon / Himmelsklaue des Wyrmruhtempels Heroic (31752) (Normal 30161) - set correct spells and flying vehicle - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
UPDATE `creature_template` SET `spell1` = 56091, `spell2` = 56092, `spell3` = 57090, `spell4` = 57143, `spell5` = 57108, `spell6` = 57092, `spell7` = 60534, `VehicleId` = 220, `InhabitType` = 5 WHERE `entry` = 31752;
-- Fix NPC Hover Disk / Fliegende Scheibe 30234, 30248, 31748, 31749 - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `npcflag` = 16777216, `VehicleId` = 224, `InhabitType` = 5 WHERE `entry` IN (30234, 30248, 31748, 31749);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (31749, 30248, 30234, 31748);
INSERT INTO `npc_spellclick_spells` (npc_entry, spell_id, quest_start, quest_start_active, quest_end, cast_flags, aura_required, aura_forbidden, user_type) VALUES
(30234, 61421, 0, 0, 0, 0, 0, 0, 0),
(31748, 61421, 0, 0, 0, 0, 0, 0, 0),
(31749, 61421, 0, 0, 0, 0, 0, 0, 0),
(30248, 61421, 0, 0, 0, 0, 0, 0, 0);
-- Modify NPC Scion of Eternity / Abkömmling der Ewigkeit - melee casters cannot cast their spells on flying disks, so reduce life in some kind - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
UPDATE `creature_template` SET `Health_mod` = 13 WHERE `entry` = 30249;
UPDATE `creature_template` SET `Health_mod` = 19.5 WHERE `entry` = 31751;
-- Custom emote for malygos 28859 - Surge of Power Ability - Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
DELETE FROM `creature_text` WHERE `entry` = 28859 AND `groupid` = 15;
INSERT INTO `creature_text` (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES
(28859, 15, 0, 'Malygos fixes his eyes on you!', 5, 0, 100, 0, 0, 0, 'Malygos - Surge');
-- Assign scripts
DELETE FROM `spell_script_names` WHERE `spell_id` IN (57459, 61694);
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(57459, 'spell_malygos_arcane_storm'),
(61694, 'spell_malygos_arcane_storm');

-- Fix creature 8035 Dunkeleisenlandmine / Dark Iron Land Mine - should not be able to move, explodes on range
UPDATE `creature_template` SET `unit_flags` = 4 WHERE `entry` = 8035;

-- Creature 27853, Projections and Plans Kill Credit Bunny, flymode and script for quest 12061, 12060 Projektionen und Plaene / Projections and Plans
UPDATE `creature_template` SET `InhabitType` = 4, `AIName` = 'EventAI', `flags_extra` = 0 WHERE `entry` = 27853;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 27853;
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(2785301, 27853, 10, 0, 100, 3, 1, 100, 1, 1, 33, 27853, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Projektionen und Plaene - Killed Moster at LOS Quest Credit');
DELETE FROM `creature` WHERE `id` = 27853;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES
(27853, 571, 1, 1, 0, 0, 3249.87, 2396.14, 58.1078, 0.90872, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3347.71, 2500.52, -15.5297, 3.58692, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3420.42, 2445.32, 46.0641, 3.24999, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3376.76, 2499.47, 2.10151, 5.96982, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3350.3, 2502.59, -10.9461, 0.00864434, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3300.64, 2464.1, 40.075, 4.28514, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3314.78, 2493.4, 12.267, 4.25372, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3323.15, 2515.63, 13.5134, 5.17657, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3319.85, 2524.64, 43.1429, 2.2007, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3358.73, 2473.47, 56.8333, 5.53235, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3344.73, 2406.84, 53.2554, 2.66486, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3362.9, 2421.4, 58.6577, 2.19362, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3405.73, 2410.41, 55.1432, 2.9963, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3433.7, 2471.75, 62.0922, 4.54746, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3389.31, 2512.65, 68.6283, 0.358928, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3355.87, 2556.68, 71.0185, 0.174361, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3308.83, 2567.36, 53.2878, 5.13415, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3271.19, 2516.42, 63.3918, 0.139011, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3339.89, 2516.4, 77.8983, 6.2714, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3269.92, 2463.65, 58.0265, 1.50953, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3316.78, 2429.3, 49.7021, 1.57158, 300, 0, 0, 42, 0, 0, 0),
(27853, 571, 1, 1, 0, 0, 3338.13, 2517.36, 199.666, 4.71239, 300, 0, 0, 42, 0, 0, 0);

-- Fix achievement Spring Fling / Fruehlingsgefuehle 2497 / 2419 - Nobelgartenfest / Noblegarden
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (9121, 9199, 9200, 9201, 9202, 9203, 9204, 9205);
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(9121, 6, 3576, 0, ''),
(9199, 6, 186, 0, ''),
(9200, 6, 87, 0, ''),
(9201, 6, 131, 0, ''),
(9202, 6, 222, 0, ''),
(9203, 6, 159, 0, ''),
(9204, 6, 3665, 0, ''),
(9205, 6, 362, 0, '');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 61725;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(61725, 61875, 0, 'Spring Rabbit => Spring Fling');

-- Fix achievement Hartgekocht / Hard Boiled 2416 - Nobelgartenfest / Noblegarden
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 9118;
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(9118, 5, 61716, 0, ''),
(9118, 16, 181, 0, ''),
(9118, 6, 543, 0, '');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 61820;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(61820, 61718, 0, 'Lay Noblegarden Egg');

-- Fix immunites of PdC / Prüfung des Champions / ToC5 / Trial of the Crusader - Blondlocke / Eadric / Paletress
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (35517, 35518);

-- Fix NPC Deathbound Ward / Todesgeweihter Waechter (30090) from ICC / Icecrown Citadel / Eiskronenzitadelle, should not be attackable
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` IN (37007,38031);

-- Instance / Instanz : Burg Utgarde / BU / Utgarde Keep : Ingvar the Plunderer / Ingvar der Plünderer (23980, 23954) - restore dungeon browser rewards
UPDATE `instance_encounters` SET `creditEntry` = 23980 WHERE `entry` IN (575, 576);

-- Fix NPC 28833 - Scarlet Cannon / Scharlachrote Kanone - Skeleton Gryphon Escape despawns canon => Disable spell
UPDATE `creature_template` SET `spell5` = 0 WHERE `entry` = 28833;

-- Fix NPC 30562 Crusader Bridenbrad / Kreuzfahrer Bridenbrad - should be visible
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 30562 AND `id` = 3056200;
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(3056200, 30562, 11, 0, 100, 0, 0, 0, 0, 0, 11, 57626, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Bridenbrad aura on spawn');

-- Disable A Poke in the Eye (25 player) / A Poke in the Eye (10 player) / Ein Stich ins Auge (10 Spieler) / Ein Stich ins Auge (25 Spieler) achievements (1870, 1869) from
-- Instance / Instanz EoE / Eye of Eternity / Das Auge der Ewigkeit
DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` IN (7174, 7175);
INSERT INTO `disables` (sourceType, entry, flags, params_0, params_1, comment) VALUES
(4, 7174, 0, 0, 0, 'Kriterium fehlerhaft, wird erst am Ende der Instanz festgestellt'),
(4, 7175, 0, 0, 0, 'Kriterium fehlerhaft, wird erst am Ende der Instanz festgestellt');


-- Fix bosses Hadronox (28921 / 31611), Anubarak (29120 / 31610), Krikthir the Gatewatcher / Kirkthir der Torwächter (28684, 31612) boss immunites and id giving flag - Instance / Instanz Azjol Nerub
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (28684, 28921, 29120, 31612, 31611, 31610);
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` IN (31612, 31611, 31610);
-- Fix creatures Ungeziefer der Anubar / Anubar Darter (29213), Waechter der Anubar / Anubar Guardian (29216), Giftmischer der Anubar / Anubar Venomancer (29217) - Instance / Instanz Azjol Nerub
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` IN (29216, 29217, 29213);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (29216, 29217, 29213);
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(2921601, 29216, 0, 0, 100, 3, 8000, 12000, 6000, 12000, 11, 53618, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - Cast Sunder Armor Normal'),
(2921602, 29216, 0, 0, 100, 5, 8000, 12000, 6000, 12000, 11, 59350, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - Cast Sunder Armor Heroic'),
(2921603, 29216, 0, 0, 100, 7, 10000, 13000, 4000, 9000, 11, 52532, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Guardian - Cast Strike'),
(2921701, 29217, 0, 0, 100, 3, 8000, 12000, 5000, 10000, 11, 53617, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - Cast Poison Bolt Normal'),
(2921702, 29217, 0, 0, 100, 5, 8000, 12000, 5000, 10000, 11, 59359, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - Cast Poison Bolt Heroic'),
(2921703, 29217, 0, 0, 100, 3, 2000, 5000, 10000, 18000, 11, 53616, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - Cast Poison Bolt Volley Normal'),
(2921704, 29217, 0, 0, 100, 5, 2000, 5000, 10000, 18000, 11, 59360, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Venomancer - Cast Poison Bolt Volley Heroic'),
(2921301, 29213, 0, 0, 100, 3, 2000, 5000, 3000, 6000, 11, 53602, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Darter - Cast Dart Normal'),
(2921302, 29213, 0, 0, 100, 5, 2000, 5000, 3000, 6000, 11, 59349, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Darter - Cast Dart Heroic');


-- Fix creature 38508 Blood Beast / Blutbestie health values in difficulties - Instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
UPDATE `creature_template` SET `Health_mod` = 6.75 WHERE `entry` IN (38508, 38596);
UPDATE `creature_template` SET `Health_mod` = 9.45 WHERE `entry` IN (38597, 38598);
-- Fix creatures
-- 37187, 'High Overlord Saurfang', 'Hochfürst Saurfang'
-- 37200, 'Muradin Bronzebeard', 'Muradin Bronzebart'
-- 37830, 'Skybreaker Marine', 'Marinesoldat der Himmelsbrecher'
-- 37920, 'Kor'kron Reaver', 'Häscher der Kor'kron'
-- Make friendly to all players and civilian
-- Instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35, `flags_extra` = 2 WHERE `entry` IN (37200, 37830, 37920, 37187);
-- Fix Deathbringer Saurfang / Todesbringer Saurfang - set immunites - Instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (37813, 38402, 38582, 38583);


-- Fix creature 30174 - Hyldsmeet Warbear, Kriegsbär des Hildarthings - set aggressive by removing vehicle id
UPDATE `creature_template` SET `VehicleId` = 0 WHERE `entry` = 30174;






-- TEMP ICC
-- Close doors to Frost and Blood wing - Instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
UPDATE `gameobject` SET `state` = 1, `spawntimesecs` = 604800 WHERE `id` IN (201920, 201919);
-- Make NPCs close to Frost and Blood wing door unattackable and civilian - Instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
UPDATE `creature_template` SET `unit_flags` = 2, `flags_extra` = 2 WHERE `entry` IN (38125, 37132, 37134, 37133, 37664, 37663, 37571, 37595, 37127);
-- Create NPC 50040, ICC Sperrung NPC - Avoid bugusing through closed doors => Instant Kill - Instance / Instanz ICC / Eiskronenzitadelle / Icecrown Citadel
DELETE FROM `creature_template` WHERE `entry` = 50040;
INSERT INTO `creature_template` (entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, modelid3, modelid4, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction_A, faction_H, npcflag, speed_walk, speed_run, scale, rank, mindmg, maxdmg, dmgschool, attackpower, dmg_multiplier, baseattacktime, rangeattacktime, unit_class, unit_flags, dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, minrangedmg, maxrangedmg, rangedattackpower, type, type_flags, lootid, pickpocketloot, skinloot, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, Health_mod, Mana_mod, Armor_mod, RacialLeader, questItem1, questItem2, questItem3, questItem4, questItem5, questItem6, movementId, RegenHealth, equipment_id, mechanic_immune_mask, flags_extra, ScriptName, WDBVerified) VALUES
(50040, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'ICC Sperrung NPC', '', '', 0, 80, 80, 0, 14, 14, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 33554434, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', 1);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 50040;
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(5004001, 50040, 0, 0, 100, 31, 500, 500, 500, 500, 11, 265, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ICC Sperrung NPC - Kill every player COMBAT'),
(5004002, 50040, 1, 0, 100, 31, 500, 500, 500, 500, 11, 265, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ICC Sperrung NPC - Kill every player OUT OF COMBAT');
DELETE FROM `creature` WHERE `id` = 50040;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(50040, 631, 15, 1, 0, 0, 4521.89, 2769.23, 351.102, 6.23323, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4357.09, 2578.3, 351.1, 4.69319, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4357.03, 2567.22, 351.513, 4.69319, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4501.3, 2769.33, 351.102, 3.15761, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4534.49, 2769.07, 351.102, 6.2725, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4547.13, 2769.29, 351.102, 6.2725, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4356.85, 2625.02, 351.1, 1.55239, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4357.12, 2606.62, 351.1, 4.71361, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4357.25, 2591.79, 351.1, 4.68063, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4356.9, 3094.5, 366.144, 4.75596, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4357.04, 3105.49, 370.656, 1.59081, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4356.73, 3125.15, 378.773, 1.58688, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0),
(50040, 631, 15, 1, 0, 0, 4356.48, 3140.48, 385.104, 1.58688, 25, 0, 0, 5342, 0, 0, 0, 0, 0, 0);

-- Bugfix for quest 11887(Emergency Supplies / Notrationen) and 11795 (Emergency Protocol: Section 8.2, Paragraph C / Notfallprotokoll: Sektion 8,2. Absatz C).
-- Relating to NPC 25841 Fizzcrank Recon Pilot / Aufklaerungspilot von Kurbelzisch
-- Both are now working using gossip-scripts, the SmartAI doesnt work properly and is too much for this purpose.
-- Remove useless SmartAI-reference and set back the correct npcflag.
UPDATE `creature_template` SET `npcflag`= 1, `AIName` = '' WHERE `entry` = 25841;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25841 AND `source_type` = 0;
-- Insert newly formed gossip-scripts. There is a delay before the despawn to prevent this to happen before the item-adding.
-- Note: Scripts 212481 -> Ally-Quest; Scripts 212482 -> Horde-Quest;
DELETE FROM `gossip_scripts` WHERE `id` IN (212481, 212482);
INSERT INTO `gossip_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(212481,0,17,35126,1,0,0,0,0,0),
(212481,1,18,0,0,0,0,0,0,0),
(212482,0,17,35276,1,0,0,0,0,0),
(212482,1,18,0,0,0,0,0,0,0);
-- Add the missing gossip-entry -> id=0=>Horde-Quest, id=1=>Ally-Quest
-- The entry for the horde-quest was already there and will only be updated.
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 21248;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(21248, 0, 0, 'Search the body for the pilot\'s emergency toolkit.', 1, 1, 0, 0, 212482, 0, 0, ''),
(21248,1,0,'Search the body for the pilots insignia.',1,1,0,0,212481,0,0,'');
-- Conditions, only make gossip available if player has correct quest active
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 21248;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,21248,0,0,9,11887,0,0,0,'','Gossip Option 21248 only available to Horde players with quest 11887 active'),
(15,21248,1,0,9,11795,0,0,0,'','Gossip Option 21248 only available to Alliance players with quest 11795 active');

-- Fix for Quest 9918 ("Not on my watch! | Nicht solange ich hier wache!")
-- Unit 18351 (Lump/Brocken) had UNIT_FLAG_OOC_NOT_ATTACKABLE (256) which prevented the gossip-options to appear. This flag is not necessary anyway, so we'll remove it.
UPDATE `creature_template` SET `unit_flags`= 528 WHERE `entry`= 18351;

-- Mobfix 26638 / 31351 - Auferstandener Fledermausreiter der Drakkari / Risen Drakkari Bat Rider in Instance / Instanz Drak'tharon Keep. Just remove the flag 33554432 which prevents the unit from being selectable.
UPDATE `creature_template` SET `unit_flags`= 64 WHERE `entry` IN (26638, 31351);

-- Fix quest Territorial Trespass / Territoriale Vergehen 13051
-- Questitem will now spawn creature Veranus (30393) as well
-- creature will spawn, switch faction (14), fight up to 3 seks, satisfy quest and despawn
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 56788;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(56788, 56649,0, 'Territorial Trespass 13051');
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 30393;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 30393;
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(3039300, 30393, 11, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Territorial Trespass 13051'),
(3039301, 30393, 0, 0, 100, 0, 2000, 3000, 0, 0, 33, 30393, 1, 0, 2, 0, 0, 0, 41, 0, 0, 0, 'Territorial Trespass 13051');
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 30393 WHERE `entry` = 13051;


-- Fix Quest Gefraessige Lauerer / Gluttonous Lurkers (12527) - Gluttonous Lurker / Gefraessiger Laurer casts spell 50919 on player for item
-- 38382 Basilisk Crystals / Basiliskenkristalle and makes itself disappear by using spell 7
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 28203;
INSERT INTO `npc_spellclick_spells` (npc_entry, spell_id, quest_start, quest_start_active, quest_end, cast_flags, aura_required, aura_forbidden, user_type) VALUES
(28203, 50919, 12527, 1, 12527, 2, 0, 0, 0);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 50919;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(50919, 7, 0, '');

-- Fix Quest Schwer zu schlucken / Hard to swallow (12049) -
-- Creature Bulliger Jormungar / Hulking Jormungar (26293) will despawn on spellhit Potent Explosive Charge / Maechtige Sprengladung (47305)
-- (Spellhit only possible if target is below 70% health)
-- and spawn GO Jormungarfleisch / Jormungar Meat (188434)
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 26293;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 26293;
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(2629300, 26293, 8, 0, 100, 0, 47305, -1, 0, 0, 104, 188434, 100, 0, 37, 0, 0, 0, 41, 0, 0, 0, 'Hard to swallow quest 12049'),
(2629301, 26293, 9, 0, 100, 1, 0, 30, 14000, 17000, 11, 50293, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hulking Jormungar - Cast Corrosive Poison');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 47305;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 47305, 0, 20, 70, 0, 0, 0, '','Hard to swallow quest 12049');

-- Questitem Everfrost Chip (44725) als Gameobject Loot zugänglich machen
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 18 WHERE `entry` = 26782 AND `item` = 44725;

-- Fix spell stacking of Leader of the Pack / Rudelführer (24932)(17007) and Rampage / Toben (29801)
DELETE FROM `spell_group` WHERE `id` = 5004;
INSERT INTO `spell_group` (id, spell_id) VALUES
(5004, 24932),
(5004, 17007),
(5004, 29801);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 5004;
INSERT INTO `spell_group_stack_rules` (group_id, stack_rule) VALUES
(5004, 1);

-- Fix item drop 44001 Blut des Gesichtslosen / Faceless One's Blood from NPC 31691 Gesichtsloser Schleicher / Faceless Lurker
DELETE FROM `creature_loot_template` WHERE `entry` = 31691 AND `item` = 44001;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (31691, 44001, -50, 1, 0, 1, 1);