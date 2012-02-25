-- Fix Brewfest / Braufest
-- Fix items 33977, 37828 Swift Brewfest Ram / Great Brewfest Kodo - Schneller Braufestwidder / Großer Braufestkodo, 37863 Düsterbräus Fernbedienung / Direbrew's Remote
-- Make alliance / horde dependent and add to loot of creature
-- Coren Direbrew / Coren Düsterbräu 23872
UPDATE `item_template` SET `FlagsExtra` = 0, `AllowableRace` = -1 WHERE `entry` IN (33977, 37828);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 23872 AND `SourceEntry` IN (37828, 33977, 37863);
DELETE FROM `creature_loot_template` WHERE `entry` = 23872 AND `item` IN (37828, 33977, 37863);
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(23872, 37828, 5, 1, 0, 1, 1),
(23872, 37863, 10, 1, 0, 1, 1);
DELETE FROM `npc_vendor` WHERE `item` IN (33977, 37828);
INSERT INTO `npc_vendor` (entry, slot, item, maxcount, incrtime, ExtendedCost) VALUES
(24510, 0, 33977, 0, 0, 0),
(24468, 0, 33977, 0, 0, 0);
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 8958 AND `id` = 7;
INSERT INTO `gossip_menu_option` (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, box_coded, box_money, box_text) VALUES
(8958, 7, 1, 'I want to browse your goods', 3, 128, 0, 0, 0, 0, '');

-- PDC / ToC5 / Trial of the Champion / Prüfung des Champions instance / Instanz fix heroic NPCs
-- 35305 Argent Monk / Argentummönch
-- 35307 Argent Priestess / Argentumpriesterin
-- 35309 Argent Lightwielder / Argentumlichtwirker
UPDATE `creature_template` SET `difficulty_entry_1` = 12439 WHERE `entry` = 35309;
UPDATE `creature_template` SET `difficulty_entry_1` = 12448 WHERE `entry` = 35307;
UPDATE `creature_template` SET `difficulty_entry_1` = 12488 WHERE `entry` = 35305;

-- Fix custom Acherus Teleporters
UPDATE `npc_spellclick_spells` SET `cast_flags` = 2, `user_type` = 1 WHERE `npc_entry` IN (50001, 50002, 50003, 50004);

-- Fix boss Icehowl / Eisheuler 34797, 35447, 35448, 35449 in instance / Instanz PDK / Prüfung des Kreuzfahrers / ToCR / Trial of the Crusader
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` IN (34797, 35447, 35448, 35449);

-- Fix boss Lord Jaraxxus 34780, 35216, 35268, 35269 in instance / Instanz PDK / Prüfung des Kreuzfahrers / ToCR / Trial of the Crusader
UPDATE `creature_template` SET `unit_flags` = 512 WHERE `entry` IN (34780, 35216, 35268, 35269);

-- Fix Brewfest / Braufest NPCs, closes #385, #400, #403, #686
-- Spawndata
-- 24495 Blix Fixtand / Blix Fixwidget
-- 27489 Ray'ma
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (24495, 27489));
DELETE FROM `creature` WHERE `id` IN (24495, 27489);
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(24495, 1, 1, 1, 0, 0, 1175.25, -4292.68, 21.2735, 6.28157, 300, 0, 0, 3524, 0, 0, 0, 0, 0),
(27489, 1, 1, 1, 22492, 0, 1477.08, -4202.16, 43.812, 4.33693, 300, 0, 0, 2215, 0, 0, 0, 0, 0);
INSERT INTO `game_event_creature` (eventEntry, guid)
SELECT 24, `guid` FROM `creature` WHERE `id` IN (24495, 27489);
-- spawn creature 28329 Slurpo Fizzykeg <Brewfest Agent> / Schlürfo Blubberfass <Beauftragter des Braufests>
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 28329);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 28329);
DELETE FROM `creature` WHERE `id` = 28329;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(28329, 1, 1, 1, 21856, 0, 1201.05, -4272.82, 21.2194, 4.80895, 300, 0, 0, 4050, 0, 0, 0, 0, 0);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`)
SELECT 24, `guid` FROM `creature` WHERE `id` = 28329;
-- spawn gameobject 189989 Zerstörte Maulwurfmaschine der Dunkeleisenzwerge (Alliance)
-- spawn gameobject 189990 Zerstörte Maulwurfmaschine der Dunkeleisenzwerge (Horde)
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (189989, 189990));
DELETE FROM `gameobject` WHERE `id` IN (189989, 189990);
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(189990, 1, 1, 1, 1189.5, -4309.92, 21.2949, 5.73505, 0, 0, 0.270649, -0.962678, 300, 0, 1),
(189989, 0, 1, 1, -5186.89, -559.179, 397.176, 1.14968, 0, 0, 0.543699, 0.83928, 300, 0, 1);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`)
SELECT 24, `guid` FROM `gameobject` WHERE `id` IN (189989, 189990);

-- Fix Brewfest / Braufest Quests, closes #382, #383, #375
-- Fix quests 13931, 13932 Another Year, Another Souvenir. / Ein neues Jahr, ein neues Souvernir for achievement 4782
DELETE FROM `creature_questrelation` WHERE `quest` IN (12193,12194,13931,13932,11321,11413);
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (12193,12194,13931,13932,11321,11413);
INSERT INTO `creature_questrelation` (id, quest) VALUES
(24468, 13932),
(24510, 13931);
INSERT INTO `creature_involvedrelation` (id, quest) VALUES
(23710, 13932),
(24495, 13931);
UPDATE `quest_template` SET `RequiredRaces` = 690, `PrevQuestId` = 0 WHERE `entry` = 13931;
UPDATE `quest_template` SET `RequiredRaces` = 1101, `PrevQuestId` = 0 WHERE `entry` = 13932;

-- Set spawntime for all herbs and minerals to 5 minutes
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` IN (324,1619,1620,1621,1622,1623,1624,1628,1732,1733,1734,1735,2040,2041,2042,2043,2044,2045,2046,2047,2866,3726,3727,3729,3730,3764,73940,73941,103711,123309,123310,123848,142140,142141,142142,142143,142144,142145,150079,150080,165658,175404,176583,176584,176586,176587,176588,176589,177388,181249,181270,181271,181275,181276,181277,181279,181280,181281,181555,181556,181557,181569,181570,183043,183044,183045,183046,2054,150081,150082,176636,176637,176638,176639,176640,176641,176642,176643,176645,181108,189973,189978,189979,190169,190173,191303,189980,189981,190170,190172,190175,191019,191133,190171,190176);

-- Fix NPC Arthas in instance / Instanz HDZ 4 / Höhlen der Zeit 4 / Caverns of Time 4 / CoT 4 / CoS / Culling of Stratholme / Ausmerzen von Stratholme
UPDATE `creature_template` SET `faction_A` = 113, `faction_H` = 113, `unit_flags` = 0 WHERE `entry` IN (26499, 31210);

-- Fix NPCs in instance / Instanz PdC / Prüfung des Champions / ToC / Trial of the Champion, closes #427
UPDATE `creature_template` SET `difficulty_entry_1` = 12445 WHERE `entry` = 35038;
UPDATE `creature_template` SET `difficulty_entry_1` = 12482 WHERE `entry` = 35043;
UPDATE `creature_template` SET `difficulty_entry_1` = 12455 WHERE `entry` = 35049;
UPDATE `creature_template` SET `difficulty_entry_1` = 12451 WHERE `entry` = 35046;
UPDATE `creature_template` SET `difficulty_entry_1` = 12487 WHERE `entry` = 35051;
UPDATE `creature_template` SET `difficulty_entry_1` = 12441 WHERE `entry` = 35031;
UPDATE `creature_template` SET `difficulty_entry_1` = 12446 WHERE `entry` = 35052;
UPDATE `creature_template` SET `difficulty_entry_1` = 12450 WHERE `entry` = 35050;
UPDATE `creature_template` SET `difficulty_entry_1` = 12486 WHERE `entry` = 35041;
UPDATE `creature_template` SET `difficulty_entry_1` = 12449 WHERE `entry` = 35048;
UPDATE `creature_template` SET `difficulty_entry_1` = 12456 WHERE `entry` = 35047;
UPDATE `creature_template` SET `difficulty_entry_1` = 12443 WHERE `entry` = 35036;
UPDATE `creature_template` SET `difficulty_entry_1` = 12437 WHERE `entry` = 35037;
UPDATE `creature_template` SET `difficulty_entry_1` = 350320 WHERE `entry` = 35032;
UPDATE `creature_template` SET `difficulty_entry_1` = 12454 WHERE `entry` = 35030;
UPDATE `creature_template` SET `difficulty_entry_1` = 12725 WHERE `entry` = 35039;
UPDATE `creature_template` SET `difficulty_entry_1` = 12452 WHERE `entry` = 35040;
UPDATE `creature_template` SET `difficulty_entry_1` = 12484 WHERE `entry` = 34942;
UPDATE `creature_template` SET `difficulty_entry_1` = 12485 WHERE `entry` = 35028;
UPDATE `creature_template` SET `difficulty_entry_1` = 12438 WHERE `entry` = 35033;
UPDATE `creature_template` SET `difficulty_entry_1` = 12483 WHERE `entry` = 35045;
UPDATE `creature_template` SET `difficulty_entry_1` = 12440 WHERE `entry` = 35044;
UPDATE `creature_template` SET `difficulty_entry_1` = 12447 WHERE `entry` = 35029;
UPDATE `creature_template` SET `difficulty_entry_1` = 12453 WHERE `entry` = 35034;
UPDATE `creature_template` SET `difficulty_entry_1` = 12442 WHERE `entry` = 35042;
UPDATE `creature_template` SET `faction_A` = 83, `faction_H` = 83 WHERE `entry` = 36558;
UPDATE `creature_template` SET `faction_A` = 84, `faction_H` = 84 WHERE `entry` = 35644;

-- Fix gossip of NPC 6735, Gastwirtin Saelienne / Innkeeper Saelienne - wrong locale information, closes #423
UPDATE `locales_gossip_menu_option` SET `option_text_loc3` = 'Ich möchte dieses Gasthaus zu meinem Heimatort machen.' WHERE `menu_id` = 1581 AND `id` = 2;
UPDATE `locales_gossip_menu_option` SET `option_text_loc3` = 'Ich möchte ein wenig in Euren Waren stöbern.' WHERE `menu_id` = 1581 AND `id` = 3;

-- Fix Call to Arms; Isle of Conquest! / Ruf zu den Waffen: Insel der Eroberung - change holiday id to arathi, since battleground is locked
UPDATE `game_event` SET `holiday` = 285 WHERE `eventEntry` = 54;

-- Fix NPC 18931, Amish Wildhammer - enable flight master in gossip again, closes #412
UPDATE `gossip_menu_option` SET `option_id` = 4, `npc_option_npcflag` = 8192 WHERE `menu_id` = 7939;

-- Fix NPC 34606, 34649 Frost Sphere / Frostsphäre and 34660 Anub'arak Spike - set all npcs in encounter Anub'arak in instance / Instanz PDK / ToCR / Trial of the Crusader / Prüfung des Kreuzfahrers
-- to faction 14, so they wont attack each other, closes #462
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` IN (34606, 34660, 34649);

-- Merge trinity cdb4f60a147b7d9a180eaa5e20ab898fda96a5c3, closes #310
DELETE FROM `spell_script_names` WHERE `spell_id` IN (53475,53487,54015);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(53475, 'spell_gen_oracle_wolvar_reputation'), -- Set Oracle Faction Friendly
(53487, 'spell_gen_oracle_wolvar_reputation'), -- Set Wolvar Faction Honored
(54015, 'spell_gen_oracle_wolvar_reputation'); -- Set Oracle Faction Honored

-- Fix quest 12238 Cleansing Drak'Tharon, Die Reinigung Drak'Tharons, closes #470
-- Require 5x item 38303 Enduring Mojo, Ausdauermojo for the quest completion
UPDATE `quest_template` SET `ReqItemId1` = 38303, `ReqItemCount1` = 5 WHERE `entry` = 12238;
-- Enduring Mojo (i38303); Loot chances and mobs were totally screwed up, so we fix it :)
-- Source: http://www.wowhead.com/item=38303
-- This item drops in both Normal and Heroic modes.
DELETE FROM `creature_loot_template` WHERE `item` = 38303;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(26639, 38303, -40, 1, 0, 1, 1),
(31345, 38303, -40, 1, 0, 1, 1),
(26620, 38303, -37, 1, 0, 1, 1),
(31339, 38303, -37, 1, 0, 1, 1),
(27431, 38303, -9, 1, 0, 1, 1),
(31338, 38303, -9, 1, 0, 1, 1);
-- Spawn NPC 28016 Drakuru in instance / Instanz Drak'Tharon
DELETE FROM `creature` WHERE `id` = 28016;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(28016, 600, 3, 1, 0, 0, -236.769, -617.988, 116.477, 4.71945, 300, 0, 0, 6986, 0, 0, 0, 0, 0);
-- Spawn some more creatures of entries 26639, 27431 Drakkari Shaman, Drakkari Commander, Kommandant der Drakkari, Schamane der Drakkari
DELETE FROM `creature` WHERE `guid` > 200000 AND `id` IN (26639, 27431) AND `map` = 600;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(26639, 600, 3, 1, 0, 0, -323.611, -702.21, 27.2919, 0.748781, 3600, 0, 0, 63000, 23964, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -318.642, -707.476, 27.2919, 0.748781, 3600, 0, 0, 63000, 23964, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -425.281, -706.704, 28.5764, 4.7166, 3600, 0, 0, 63000, 23964, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -420.262, -706.663, 28.5764, 4.72053, 3600, 0, 0, 65165, 24486, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -474.569, -682.466, 43.2598, 4.70954, 3600, 0, 0, 63000, 23964, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -482.969, -682.442, 43.2598, 4.70954, 3600, 0, 0, 65165, 24486, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -475.785, -634.848, 72.6051, 4.70953, 3600, 0, 0, 63000, 23964, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -482.925, -634.828, 72.6051, 4.70953, 3600, 0, 0, 65165, 24486, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -304.195, -651.658, 87.2345, 1.58364, 3600, 0, 0, 65165, 24486, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -296.985, -651.565, 87.2346, 1.58364, 3600, 0, 0, 65165, 24486, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -303.904, -676.047, 101.906, 1.56322, 3600, 0, 0, 65165, 24486, 0, 0, 0, 0),
(26639, 600, 3, 1, 0, 0, -297.884, -676.092, 101.899, 1.56322, 3600, 0, 0, 65165, 24486, 0, 0, 0, 0),
(27431, 600, 3, 1, 0, 1739, -321.077, -704.856, 27.2919, 0.748781, 3600, 0, 0, 65165, 0, 0, 0, 0, 0),
(27431, 600, 3, 1, 0, 1739, -422.922, -706.589, 28.5764, 4.73467, 3600, 0, 0, 65165, 0, 0, 0, 0, 0),
(27431, 600, 3, 1, 0, 1739, -479.189, -682.453, 43.2598, 4.70954, 3600, 0, 0, 65165, 0, 0, 0, 0, 0),
(27431, 600, 3, 1, 0, 1739, -479.355, -634.838, 72.6051, 4.70953, 3600, 0, 0, 65165, 0, 0, 0, 0, 0),
(27431, 600, 3, 1, 0, 1739, -300.549, -652.123, 87.2345, 1.58364, 3600, 0, 0, 65165, 0, 0, 0, 0, 0),
(27431, 600, 3, 1, 0, 1739, -300.334, -676.074, 101.905, 1.56322, 3600, 0, 0, 65165, 0, 0, 0, 0, 0);

-- Fix Dark Runed Chest / Mit dunklen Runen beschriebene Kiste in instance / Instanz HDZ4 / Culling of Stratholme / CoS / Das Ausmerzen von Stratholme
-- set correct spawntime, closes #251
UPDATE `gameobject` SET `spawntimesecs` = 86400 WHERE `id` IN (193597, 190663);

-- Fix internal cooldown of Waffe - Schwarzmagie / Enchant Weapon - Black Magic enchantment / Verzauberung
UPDATE `spell_proc_event` SET `Cooldown` = 35 WHERE `entry` = 59630;

-- Fix quest 12326 Steamtank Surprise / Dampfpanzerüberraschung, closes #510
-- Set to auto complete due to complex scripting
UPDATE `quest_template` SET `ReqCreatureOrGoId1` = 0, `ReqCreatureOrGoId2` = 0, `ReqCreatureOrGoCount1` = 0, `ReqCreatureOrGoCount2` = 0 WHERE `entry` = 12326;

-- Fix creature 28781, 32796 Battleground Demolisher / Schlachtfeldverwüster from BG / Battleground SoTA / Strand of the Ancient / Strand der Uralten, set correct immunites and speed, closes #544
UPDATE `creature_template` SET `mechanic_immune_mask` = 919551871, `speed_run` = 1, `speed_walk` = 1 WHERE `entry` IN (28781, 32796);
UPDATE `creature_template` SET `Health_Mod` = 14.975692308 WHERE `entry` = 32796;

-- Fix Brannbronze / Bronzebeard encounter in instance / Instanz Halls of Stone / HoS / Hallen des Steins, closes #592, #593
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 28234;
UPDATE `creature_template` SET `faction_A` = 113, `faction_H` = 113 WHERE `entry` IN (28070, 31366);

-- Fix gameobject 201969 Ball and Chain / Kugel und Kette in instance / Instanz PoS / Pit of Saron / Grube von Saron
-- Required for quest 24498 / 24507 Der Pfad zur Zitadelle / The Path to the Citadel
UPDATE `gameobject_template` SET `data1` = 0 WHERE `entry` = 201969;

-- Schlotternächte / Schlotternaechte / Hallow's End
-- Fix quest 1657 Stinking Up Southshore / Die Verpestung von Süderstade, closes #658
-- Item 20387 Stinkbomben der Verlassenen / Forsaken Stink Bomb Cluster
-- triggers spell 24706 Toss Stink Bomb / Stinkbombe werfen
-- which triggers event 9417 and gives kill credit 15415 Southshore Stink Bomb Counter / Stinkbombenzähler von Süderstade for quest
DELETE FROM `event_scripts` WHERE `id` = 9417;
INSERT INTO `event_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(9417, 0, 8, 15415, 0, 0, 0, 0, 0, 0);

-- Schlotternächte / Schlotternaechte / Hallow's End
-- Fix 11219, 11131 quests Stop the Fires! / Löscht das Feuer!, closes #657
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (24519, 23973));
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (24519, 23973));
DELETE FROM `creature` WHERE `id` IN (24519, 23973);
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(24519, 0, 1, 1, 22504, 0, -9429.92, 56.1355, 56.7913, 2.98451, 5, 0, 0, 247, 0, 0, 0, 0, 0),
(23973, 1, 1, 1, 22499, 0, 356.121, -4742.24, 9.82812, 0.558505, 5, 0, 0, 247, 0, 0, 0, 0, 0);
INSERT INTO `game_event_creature` (eventEntry, guid)
SELECT 12, `guid` FROM `creature` WHERE `id` IN (24519, 23973);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 42339;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 42339, 0, 18, 1, 23537, 0, 0, '', 'Spell 42339 casted on creature 23537 quests ');
DELETE FROM `creature_questrelation` WHERE `quest` IN (12135, 12139);
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (12135, 12139);
UPDATE `creature_template` SET `modelid1` = 11686, `modelid3` = 11686, `faction_A` = 35, `faction_H` = 35, `flags_extra` = 2, `unit_flags` = 33554432 WHERE `entry` = 23537;
UPDATE `item_template` SET `Flags` = 2, `spellcharges_1` = 0, `spellcooldown_1` = 5000, `bonding` = 1, `spellid_2` = 0, `spelltrigger_2` = 0, `spellcharges_2` = 0, `spellppmRate_2` = 0, `Duration` = -360 WHERE `entry` = 32971;
DELETE FROM `creature_template_addon` WHERE `entry` = 23537;
INSERT INTO `creature_template_addon` (entry, path_id, mount, bytes1, bytes2, emote, auras) VALUES (23537, 0, 0, 0, 0, 0, '42075');
UPDATE `quest_template` SET `RequiredRaces` = 1101, `Minlevel` = 1, `Questlevel` = -1, `QuestFlags` = 4098, `SpecialFlags` = 3, `PrevQuestId` = 0, `NextQuestInChain` = 0, `SrcItemId` = 32971, `SrcItemCount` = 1, `EndText` = '', `ObjectiveText1` = 'Fires put out', `ReqSourceId2` = 32971, `ReqSourceCount2` = 0, `ReqCreatureOrGoId1` = 23537, `ReqCreatureOrGoCount1` = 50, `ReqSpellCast1` = 42339, `StartScript` = 11131 WHERE `entry` = 11131;
UPDATE `locales_quest` SET `EndText_loc3` = '', `ObjectiveText1_loc3` = 'Feuer gelöscht' WHERE `entry` = 11131;
UPDATE `quest_template` SET `RequiredRaces` = 690, `Minlevel` = 1, `Questlevel` = -1, `QuestFlags` = 4098, `SpecialFlags` = 3, `PrevQuestId` = 0, `NextQuestInChain` = 0, `SrcItemId` = 32971, `SrcItemCount` = 1, `EndText` = '', `ObjectiveText1` = 'Fires put out', `ReqSourceId2` = 32971, `ReqSourceCount2` = 0, `ReqCreatureOrGoId1` = 23537, `ReqCreatureOrGoCount1` = 50, `ReqSpellCast1` = 42339, `StartScript` = 11219 WHERE `entry` = 11219;
UPDATE `locales_quest` SET `EndText_loc3` = '', `ObjectiveText1_loc3` = 'Feuer gelöscht' WHERE `entry` = 11219;
DELETE FROM `quest_start_scripts` WHERE `id` IN (11131, 11219);
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(11131, 0, 7, 11131, 10, 0, 0, 0, 0, 0),
(11131, 2, 10, 23537, 7000, 0, -9442.77, 78.0061, 56.7631, 3.20163),
(11131, 7, 10, 23537, 7000, 0, -9469.14, 75.0716, 56.7912, 2.98957),
(11131, 12, 10, 23537, 7000, 0, -9496.23, 74.2204, 56.4181, 4.14646),
(11131, 17, 10, 23537, 7000, 0, -9499.24, 62.2597, 56.5025, 3.84016),
(11131, 22, 10, 23537, 7000, 0, -9486.06, 45.9185, 57.2408, 6.07461),
(11131, 27, 10, 23537, 7000, 0, -9471.04, 46.4314, 56.6617, 6.08875),
(11131, 32, 10, 23537, 7000, 0, -9458.32, 51.7335, 56.4362, 4.60906),
(11131, 37, 10, 23537, 7000, 0, -9460.65, 36.5405, 56.95, 3.43175),
(11131, 42, 10, 23537, 7000, 0, -9469.41, 35.5726, 56.9645, 4.41743),
(11131, 47, 10, 23537, 7000, 0, -9476.9, 22.7472, 56.3395, 4.54937),
(11131, 52, 10, 23537, 7000, 0, -9475.97, 13.2178, 60.1873, 5.71412),
(11131, 57, 10, 23537, 7000, 0, -9471.39, 21.6196, 63.8213, 1.76985),
(11131, 62, 10, 23537, 7000, 0, -9473.22, 28.8616, 63.8213, 1.44312),
(11131, 67, 10, 23537, 7000, 0, -9469.92, 35.2707, 63.8212, 2.19161),
(11131, 72, 10, 23537, 7000, 0, -9475.48, 38.0978, 63.8211, 3.62967),
(11131, 77, 10, 23537, 7000, 0, -9474.62, 32.2013, 63.8211, 5.06695),
(11131, 82, 10, 23537, 7000, 0, -9472.18, 17.9448, 62.355, 4.70174),
(11131, 87, 10, 23537, 7000, 0, -9475.59, 13.1619, 60.1898, 2.77751),
(11131, 92, 10, 23537, 7000, 0, -9473.6, 25.7685, 56.34, 0.516351),
(11131, 97, 10, 23537, 7000, 0, -9467.94, 20.4396, 56.5475, 4.90751),
(11131, 102, 10, 23537, 7000, 0, -9466.54, 10.5936, 56.9635, 0.357701),
(11131, 107, 10, 23537, 7000, 0, -9463.05, 11.8951, 58.1268, 0.357701),
(11131, 112, 10, 23537, 7000, 0, -9460.87, 17.1197, 56.9626, 1.52245),
(11131, 117, 10, 23537, 7000, 0, -9460.03, 24.4152, 56.3395, 1.52245),
(11131, 122, 10, 23537, 7000, 0, -9462.53, 31.9524, 56.9669, 2.78537),
(11131, 127, 10, 23537, 7000, 0, -9467.49, 35.5331, 56.9669, 0.808519),
(11131, 132, 10, 23537, 7000, 0, -9459.77, 38.4315, 56.9497, 1.42427),
(11131, 137, 10, 23537, 7000, 0, -9454.39, 51.1203, 56.5669, 0.627878),
(11131, 142, 10, 23537, 7000, 0, -9452.73, 71.7613, 56.6345, 1.9552),
(11131, 147, 10, 23537, 7000, 0, -9459.36, 81.817, 58.2314, 2.22302),
(11131, 152, 10, 23537, 7000, 0, -9463.69, 88.7593, 58.3441, 2.54582),
(11131, 157, 10, 23537, 7000, 0, -9456.21, 97.0438, 58.3444, 0.877635),
(11131, 162, 10, 23537, 7000, 0, -9462.6, 102.746, 58.3377, 2.36125),
(11131, 167, 10, 23537, 7000, 0, -9461.12, 111.263, 57.8214, 1.28526),
(11131, 172, 10, 23537, 7000, 0, -9456.39, 120.684, 58.3725, 0.293298),
(11131, 177, 10, 23537, 7000, 0, -9448.78, 126.871, 58.3701, 0.51478),
(11131, 182, 10, 23537, 7000, 0, -9453.5, 135.793, 57.9307, 1.94499),
(11131, 187, 10, 23537, 7000, 0, -9456.52, 144.786, 56.5346, 3.1977),
(11131, 192, 10, 23537, 7000, 0, -9465.21, 144.101, 57.8229, 3.52992),
(11131, 197, 10, 23537, 7000, 0, -9474.07, 153.878, 56.5822, 2.30941),
(11131, 202, 10, 23537, 7000, 0, -9486.94, 148.683, 56.7357, 4.48261),
(11131, 207, 10, 23537, 7000, 0, -9474.2, 133.204, 56.9504, 5.45415),
(11131, 212, 10, 23537, 7000, 0, -9488.41, 123.474, 57.0994, 4.06792),
(11131, 217, 10, 23537, 7000, 0, -9508.3, 112.915, 58.9063, 4.52267),
(11131, 222, 10, 23537, 7000, 0, -9511.54, 101.316, 58.8004, 3.74984),
(11131, 227, 10, 23537, 7000, 0, -9500.52, 91.2097, 58.0315, 5.76517),
(11131, 232, 10, 23537, 7000, 0, -9491.28, 86.3758, 56.2695, 3.66894),
(11131, 237, 10, 23537, 7000, 0, -9475.14, 85.03, 56.9449, 6.03692),
(11131, 242, 10, 23537, 7000, 0, -9464.97, 75.9966, 56.7962, 5.76517),
(11131, 247, 10, 23537, 7000, 0, -9449.73, 51.9942, 56.6641, 5.27822),
(11131, 252, 10, 23537, 7000, 0, -9437.26, 39.8895, 57.0247, 5.35362),
(11131, 257, 10, 23537, 7000, 0, -9417.55, 49.189, 57.7001, 0.543056),
(11131, 262, 10, 23537, 7000, 0, -9418.51, 56.7052, 59.0292, 1.16902),
(11131, 267, 10, 23537, 7000, 0, -9408.03, 81.7509, 58.0986, 1.61355),
(11131, 272, 10, 23537, 7000, 0, -9416.34, 95.1492, 57.9222, 2.33769),
(11131, 277, 10, 23537, 7000, 0, -9423.99, 109.13, 58.4287, 1.98112),
(11131, 282, 10, 23537, 7000, 0, -9438.63, 103.732, 56.9971, 3.5904),
(11131, 287, 10, 23537, 7000, 0, -9438.12, 86.0747, 57.1893, 4.85332),
(11131, 292, 10, 23537, 7000, 0, -9436.26, 69.1085, 56.2425, 4.85332),
(11131, 297, 10, 23537, 7000, 0, -9431.52, 56.7068, 56.6429, 5.9089),
(11219, 0, 7, 11219, 10, 0, 0, 0, 0, 0),
(11219, 2, 10, 23537, 7000, 0, 351.138, -4727.38, 10.2415, 1.7286),
(11219, 7, 10, 23537, 7000, 0, 345.309, -4714.54, 14.1394, 2.63967),
(11219, 12, 10, 23537, 7000, 0, 332.248, -4710.43, 14.8067, 2.60982),
(11219, 17, 10, 23537, 7000, 0, 329.471, -4702.91, 16.7717, 1.11364),
(11219, 22, 10, 23537, 7000, 0, 339.633, -4695.69, 16.4579, 0.0454981),
(11219, 27, 10, 23537, 7000, 0, 352.822, -4690.58, 16.4579, 0.99583),
(11219, 32, 10, 23537, 7000, 0, 353.128, -4679.16, 16.4579, 1.83228),
(11219, 37, 10, 23537, 7000, 0, 345.279, -4676.55, 16.4579, 2.71585),
(11219, 42, 10, 23537, 7000, 0, 332.876, -4677.77, 16.4579, 3.69367),
(11219, 47, 10, 23537, 7000, 0, 330.926, -4687.29, 16.4579, 4.71469),
(11219, 52, 10, 23537, 7000, 0, 331.46, -4699.97, 16.8718, 4.7304),
(11219, 57, 10, 23537, 7000, 0, 323.34, -4705.34, 15.4315, 3.24992),
(11219, 62, 10, 23537, 7000, 0, 318.194, -4712.77, 13.2253, 3.48554),
(11219, 67, 10, 23537, 7000, 0, 303.777, -4713.89, 10.9797, 2.99074),
(11219, 72, 10, 23537, 7000, 0, 295.475, -4715.31, 12.7959, 3.57586),
(11219, 77, 10, 23537, 7000, 0, 283.53, -4715.29, 12.65, 2.48023),
(11219, 82, 10, 23537, 7000, 0, 271.874, -4707.35, 12.3008, 2.49987),
(11219, 87, 10, 23537, 7000, 0, 265.624, -4703.13, 17.4888, 2.5627),
(11219, 92, 10, 23537, 7000, 0, 266.238, -4710.47, 17.4888, 5.51579),
(11219, 97, 10, 23537, 7000, 0, 274.224, -4710.98, 17.4888, 0.756277),
(11219, 102, 10, 23537, 7000, 0, 274.734, -4701.94, 17.4888, 2.47237),
(11219, 107, 10, 23537, 7000, 0, 266.323, -4700.87, 17.4888, 3.99212),
(11219, 112, 10, 23537, 7000, 0, 270.129, -4707.55, 13.3911, 5.70821),
(11219, 117, 10, 23537, 7000, 0, 276.146, -4711.12, 11.6264, 5.72392),
(11219, 122, 10, 23537, 7000, 0, 286.149, -4718.52, 13.9065, 5.59826),
(11219, 127, 10, 23537, 7000, 0, 292.074, -4726.02, 12.2145, 4.86392),
(11219, 132, 10, 23537, 7000, 0, 294.493, -4739.48, 9.33025, 4.95817),
(11219, 137, 10, 23537, 7000, 0, 298.387, -4752, 9.3976, 4.99351),
(11219, 142, 10, 23537, 7000, 0, 300.072, -4760.79, 9.40091, 4.93461),
(11219, 147, 10, 23537, 7000, 0, 306.96, -4776.75, 10.3257, 4.95424),
(11219, 152, 10, 23537, 7000, 0, 309.275, -4795.09, 10.5242, 4.84429),
(11219, 157, 10, 23537, 7000, 0, 315.912, -4800.98, 10.523, 5.7632),
(11219, 162, 10, 23537, 7000, 0, 326.678, -4809.2, 10.5198, 4.98566),
(11219, 167, 10, 23537, 7000, 0, 325.193, -4813.29, 10.5229, 3.28527),
(11219, 172, 10, 23537, 7000, 0, 313.048, -4812.14, 10.0386, 2.99467),
(11219, 177, 10, 23537, 7000, 0, 301.086, -4817.06, 10.5194, 3.66226),
(11219, 182, 10, 23537, 7000, 0, 295.834, -4824.9, 10.5236, 4.76574),
(11219, 187, 10, 23537, 7000, 0, 303.38, -4836.23, 10.5238, 5.80246),
(11219, 192, 10, 23537, 7000, 0, 313.711, -4837.78, 10.5243, 0.29289),
(11219, 197, 10, 23537, 7000, 0, 325.913, -4829.67, 10.5243, 0.921209),
(11219, 202, 10, 23537, 7000, 0, 329.116, -4820.37, 10.5244, 2.07574),
(11219, 207, 10, 23537, 7000, 0, 325.496, -4807.93, 10.5161, 1.76944),
(11219, 212, 10, 23537, 7000, 0, 317.142, -4802.46, 10.5228, 3.08105),
(11219, 217, 10, 23537, 7000, 0, 309.237, -4800.2, 10.5215, 1.60843),
(11219, 222, 10, 23537, 7000, 0, 308.224, -4787.46, 10.5227, 1.6909),
(11219, 227, 10, 23537, 7000, 0, 306.978, -4772.12, 9.45788, 1.56524),
(11219, 232, 10, 23537, 7000, 0, 315.434, -4767.35, 11.0967, 0.277182),
(11219, 237, 10, 23537, 7000, 0, 328.406, -4765.71, 12.4819, 6.03415),
(11219, 242, 10, 23537, 7000, 0, 340.362, -4771.26, 12.6349, 5.51186),
(11219, 247, 10, 23537, 7000, 0, 345.672, -4778.41, 12.5316, 4.68327),
(11219, 252, 10, 23537, 7000, 0, 344.034, -4796.52, 10.7065, 4.80108),
(11219, 257, 10, 23537, 7000, 0, 352.582, -4797.7, 11.3369, 0.355722),
(11219, 262, 10, 23537, 7000, 0, 363.12, -4793.43, 13.0288, 0.438189),
(11219, 267, 10, 23537, 7000, 0, 370.9, -4782.55, 12.7108, 1.50633),
(11219, 272, 10, 23537, 7000, 0, 365.187, -4773.49, 12.4702, 2.2289),
(11219, 277, 10, 23537, 7000, 0, 372.374, -4765.35, 12.2961, 1.06651),
(11219, 282, 10, 23537, 7000, 0, 366.619, -4754.34, 11.891, 1.84405),
(11219, 287, 10, 23537, 7000, 0, 370.591, -4744.42, 9.67848, 1.18039),
(11219, 292, 10, 23537, 7000, 0, 364.925, -4737.64, 9.67329, 3.21065),
(11219, 297, 10, 23537, 7000, 0, 356.402, -4742.16, 9.73819, 3.75257);

-- Schlotternächte / Schlotternaechte / Hallow's End
-- Fix quest 1658 Bespitzelt das Fest des Weidenmanns / Crashing the Wickerman Festival (Alliance / Allianz), closes #637
-- assign area trigger to quest for credit
DELETE FROM `areatrigger_involvedrelation` WHERE `id` = 3991;
INSERT INTO `areatrigger_involvedrelation` (`id`, `quest`) VALUES
(3991, 1658);

-- Schlotternächte / Schlotternaechte / Hallow's End
-- Spawn several NPCs and GO for event
-- Creature 15199 Sergeant Hartman / Unteroffizier Hartman
-- Creature 15197 Ruferin der Dunkelheit Yanka / Darkcaller Yanka
-- Gameobject 181672 Wickerman Effigy / Weidenmann
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (15197, 15199));
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 181672);
DELETE FROM `gameobject` WHERE `id` = 181672;
DELETE FROM `creature` WHERE `id` IN (15197, 15199);
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(181672, 0, 1, 1, 1731.53, 508.761, 41.3752, 1.18826, 0, 0, 0.559787, 0.828637, 300, 0, 1);
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(15197, 0, 1, 1, 0, 0, 1733.32, 510.052, 40.9765, 2.01292, 300, 0, 0, 15260, 0, 0, 0, 0, 0),
(15199, 0, 1, 1, 0, 0, -823.846, -549.262, 15.1569, 1.5427, 300, 0, 0, 15260, 0, 0, 0, 0, 0);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`)
SELECT 12, `guid` FROM `gameobject` WHERE `id` = 181672;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(181672, 530, 1, 1, -5027.12, -10966, 20.562, 1.2391, 0, 0, 1, 1, 121, 100, 1);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`)
SELECT 12, `guid` FROM `creature` WHERE `id` IN (15197, 15199);

-- Schlotternächte / Schlotternaechte / Hallow's End
-- Fix achievement 288 Raus Damit / Out With It, closes #647
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (48889, 48890, 48891, 48892);
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(48889, 42966, 0, 'Schlotternaechte Achievement 288'),
(48890, 42966, 0, 'Schlotternaechte Achievement 288'),
(48891, 42966, 0, 'Schlotternaechte Achievement 288'),
(48892, 42966, 0, 'Schlotternaechte Achievement 288');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 42966;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 42966, 0, 1, 48889, 0, 0, 0, '', 'Schlotternaechte Achievement 288'),
(17, 0, 42966, 0, 1, 48890, 0, 0, 0, '', 'Schlotternaechte Achievement 288'),
(17, 0, 42966, 0, 1, 48891, 0, 0, 0, '', 'Schlotternaechte Achievement 288'),
(17, 0, 42966, 0, 1, 48892, 0, 0, 0, '', 'Schlotternaechte Achievement 288');

-- Modify NPC 29375 Stormforged Iron Giant / Sturmgeschmiedeter Eisenriese - set damage and health to half of original values, since spawning helping adds does not work
-- Related to quest 12915 Zäune reparieren / Mending Fences
UPDATE `creature_template` SET `Health_Mod` = 2, `dmg_multiplier` = 2.3 WHERE `entry` = 29375;

-- Instance / Instanz PDK / Prüfung des Kreuzfahrers / Trial of the Crusader / ToCR - remove dual item looting, does not really make any difference, closes #673
DELETE FROM `gameobject_loot_template` WHERE `item` IN (47864,47289,49236,47278,47872,47849,47903,47272,47850,47267,47855,47862,47892,47889,47879,47261,47896,47870,47885,47260,47304,49232,47856,47860,47858,47913,47253,47330,47868,47883,47851,47854,47888,47875,47867,47279,47901,47311,47257,47307,47325,47295,47280,47895,47284,47313,47300,47255,47852,47265,47880,47853,47869,47881,47905,47251,47296,47282,47898,47871,47890,47873,47874,47258,47293,47276,47882,47861,47316,47256,47884,47904,47266,47859,47286,47906,47865,47900,47894,47320,47285,47306,48030,47326,48013,47292,47308,47318,47327,47271,47995,47988,47319,47281,47893,47891,47262,47277,47288,47268,47887,47305,48024,47323,47287,47254,47321,47309,47283,47290,47275,47877,47301,47291,47264,47886,47909,48019,48011,47299,47992,47302,47910,47899,47273,47907,47866,47908,47324,47857,47863,47878,48026,47993,48021,48056,47897,47252,47911,47902,47297,47322,47303,47876,47298,47310,47994,47294,47312,48007,48003,47269,47991,48012,48001,47274,47259,47263,47420,47314,47427,47423,49237,47328,47999,47413,47989,47416,48028,48036,47470,49046,47465,47444,47640,47450,47457,47638,47468,47653,47641,47643,47429,47462,47449,47647,47456,47425,47438,47440,47434,47646,47417,47469,47459,48667,48666,48670,48669,48668,47422,47636,47637,47436,47648,48042,47454,47451,47458,47467,47463,47464,47639,48703,47443,48693,47431,47435,48049,47412,47424,47419,48046,47460,47466,47651,48045,47439,47441,47645,48053,47426,48047,48010,47448,47452,48052,48041,47428,47442,48697,47453,48043,48050,48025,48015,48008,48054,47418,47433,48014,48005,47437,48705,47445,48038,48048,48018,47446,47414,49233,47447,48695,47996,47270,48040,47455,48006,47315,47432,48022,47317,48020,48004,47990,48017,47421,48699,47430,47415,48016,47329,47650,47649,47652,47644,48044,48027,47997,48009,48701,48034,47998,48055,48002,48032,48051,48039,48023,48000,47492,47471,47485,47461,47480,47479,47476,47473,47486,47489,47490,47487,47482,47483,47546,47525,47642,47523,47516,47520,47477,47484,47474,47472,47491,47481,47548,47528,47475,47478,47518,47554,47551,47513,47550);
DELETE FROM `reference_loot_template` WHERE `item` IN (47864,47289,49236,47278,47872,47849,47903,47272,47850,47267,47855,47862,47892,47889,47879,47261,47896,47870,47885,47260,47304,49232,47856,47860,47858,47913,47253,47330,47868,47883,47851,47854,47888,47875,47867,47279,47901,47311,47257,47307,47325,47295,47280,47895,47284,47313,47300,47255,47852,47265,47880,47853,47869,47881,47905,47251,47296,47282,47898,47871,47890,47873,47874,47258,47293,47276,47882,47861,47316,47256,47884,47904,47266,47859,47286,47906,47865,47900,47894,47320,47285,47306,48030,47326,48013,47292,47308,47318,47327,47271,47995,47988,47319,47281,47893,47891,47262,47277,47288,47268,47887,47305,48024,47323,47287,47254,47321,47309,47283,47290,47275,47877,47301,47291,47264,47886,47909,48019,48011,47299,47992,47302,47910,47899,47273,47907,47866,47908,47324,47857,47863,47878,48026,47993,48021,48056,47897,47252,47911,47902,47297,47322,47303,47876,47298,47310,47994,47294,47312,48007,48003,47269,47991,48012,48001,47274,47259,47263,47420,47314,47427,47423,49237,47328,47999,47413,47989,47416,48028,48036,47470,49046,47465,47444,47640,47450,47457,47638,47468,47653,47641,47643,47429,47462,47449,47647,47456,47425,47438,47440,47434,47646,47417,47469,47459,48667,48666,48670,48669,48668,47422,47636,47637,47436,47648,48042,47454,47451,47458,47467,47463,47464,47639,48703,47443,48693,47431,47435,48049,47412,47424,47419,48046,47460,47466,47651,48045,47439,47441,47645,48053,47426,48047,48010,47448,47452,48052,48041,47428,47442,48697,47453,48043,48050,48025,48015,48008,48054,47418,47433,48014,48005,47437,48705,47445,48038,48048,48018,47446,47414,49233,47447,48695,47996,47270,48040,47455,48006,47315,47432,48022,47317,48020,48004,47990,48017,47421,48699,47430,47415,48016,47329,47650,47649,47652,47644,48044,48027,47997,48009,48701,48034,47998,48055,48002,48032,48051,48039,48023,48000,47492,47471,47485,47461,47480,47479,47476,47473,47486,47489,47490,47487,47482,47483,47546,47525,47642,47523,47516,47520,47477,47484,47474,47472,47491,47481,47548,47528,47475,47478,47518,47554,47551,47513,47550);

-- Bugfix for quest 11658 (Plan B) and 11593 (The Honored Dead / Die geehrten Toten) now using SmartAI and a gossip, closes #535, #303
-- @DorianGrey: Based upon clean TDB42. Any modifications on the parameters below should be checked before using this fix.
-- Step 1: Use the same gossip for Workers and Guards - doe not require more complex things...
UPDATE `creature_template` SET `gossip_menu_id` = 9155 WHERE `entry` = 25343;
-- Step 1.1: Enable the usage of SmartAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (25342, 25343);
-- Step 2: Create gossip - curiously, the link already existed, but not the entry that it was pointing to...
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 9155;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(9155, 0, 0, 'Take the dead one\'s clothes...', 1, 1, 0, 0, 0, 0, '');
-- Step 3: Create smart-scripts.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (25342, 25343);
-- Step 3.1: Scripts for quest 11658.
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25342, 0, 0, 1, 62, 0, 100, 0, 9155, 0, 0, 0, 56, 34842, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan guard - create item on gossip selection'),
(25342, 0, 1, 0, 62, 0, 100, 0, 9155, 0, 0, 0, 41, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan guard - despawn after granting the item'),
(25343, 0, 1, 0, 62, 0, 100, 0, 9155, 0, 0, 0, 41, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan worker - despawn after granting the item'),
(25343, 0, 0, 1, 62, 0, 100, 0, 9155, 0, 0, 0, 56, 34842, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan worker - create item on gossip selection');
-- Step 3.2: Scripts for quest 11593.
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25342, 0, 2, 3, 8, 0, 100, 0, 45474, 0, 0, 0, 33, 25342, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan guard - grant kill credit on using spell on it'),
(25343, 0, 2, 3, 8, 0, 100, 0, 45474, 0, 0, 0, 33, 25342, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan worker - grant kill credit on using spell on it'),
(25342, 0, 3, 0, 8, 0, 100, 0, 45474, 0, 0, 0, 41, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan guard - despawn on using spell on it'),
(25343, 0, 3, 0, 8, 0, 100, 0, 45474, 0, 0, 0, 41, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead caravan worker - despawn on using spell on it');
-- Step 4: Create access - condition.
DELETE FROM `conditions` WHERE `SourceGroup` = 9155;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9155, 0, 0, 9, 11658, 0, 0, 0, '', 'Quest 11658 - Gossip should only be accessible for players having this quest');
-- Step 4.1: Modify conditions to enable the availability of the spell used in Q 11593.
UPDATE `conditions` SET `ConditionValue1` = 1 WHERE `SourceEntry` = 45474 AND `ConditionValue2` IN (25342, 25343);
-- Step 5: Cleanup.
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (25342, 25343);
-- Backup.
-- INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (2534201, 25342, 8, 0, 100, 0, 45474, -1, 0, 0, 33, 25342, 6, 0, 41, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Quest Credit and Despawn on Ragefist\'s Torch Spellhit (Quest: 11593)');
-- INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (2534301, 25343, 8, 0, 100, 0, 45474, -1, 0, 0, 33, 25342, 6, 0, 41, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - Quest Credit and Despawn on Ragefist\'s Torch Spellhit (Quest: 11593)');

-- Fix quest 12150 Reclusive Runemaster / Der zurückgezogene Runenmeister, closes #181
-- NPC 27003 Dregmar Runebrand / Dregmar Runenbrand needs some fixes for event AI, so events will work as intended
UPDATE `creature_ai_scripts` SET `action3_param1` = 16 WHERE `id` = 2700301 AND `creature_id` = 27003;
UPDATE `creature_ai_scripts` SET `event_type` = 1 WHERE `id` IN (2700305, 2700306) AND `creature_id` = 27003;

-- Add some player faction change data
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (24579, 40476) OR `horde_id` IN (40477, 24581);
INSERT INTO `player_factionchange_items` (race_A, alliance_id, commentA, race_H, horde_id, commentH) VALUES
(0, 24579, 'Mark of Honor Hold', 0, 24581, 'Mark of Thrallmar'),
(0, 40476, 'Insignia of the Alliance', 0, 40477, 'Insignia of the Horde');

-- Fix issues with encounter Professor Putricide / Professor Seuchenmord in instance / Instanz ICC / Icecrown Citadel / Eiskronenzitadelle, closes #709, #669
-- #1) Use old spellscript version of Expunge Gas, revert https://github.com/TrinityCore/TrinityCore/commit/240534ba2fa3cc51e8e6fa5ecce8dbe03bab5c67
-- #2) Pull https://github.com/TrinityCore/TrinityCore/commit/12c30b0c98d7bebb2a47ff8748e2554bd72e332c and https://github.com/TrinityCore/TrinityCore/commit/8540b367de5ada283b42080049132b40fe80bc51
-- #3) Automatic self-despawn of slime puddles, if putricide is dead
DELETE FROM `spell_proc_event` WHERE `entry` IN (70215, 72858, 72859, 72860, 70672, 72455, 72832, 72833);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (70701, 70346, 72456, 72868, 72869, 70343);
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(70701, 'spell_putricide_expunged_gas'),
(70346,'spell_putricide_slime_puddle'),
(72456,'spell_putricide_slime_puddle'),
(72868,'spell_putricide_slime_puddle_aura'),

(72869,'spell_putricide_slime_puddle_aura');
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 37690; -- Growing Ooze Puddle

-- Fix NPC 22423 Druide des ewigen Hains / Evergrove Druid - make NPC visual and ready for questgiver interaction, closes #765
UPDATE `creature_template` SET `modelid1` = 20997, `modelid2` = 0, `unit_flags` = 512, `flags_extra` = 2 WHERE `entry` = 22423;
UPDATE `creature` SET `modelid` = 20997 WHERE `id` = 22423;

-- Fix NPC 9988 Xon'cha, add stable master flag - closes #740
UPDATE `creature_template` SET `npcflag` = `npcflag` | 4194304 WHERE `entry` = 9988;

-- Fix quest 13007 Der Eisenkoloss / The Iron Colossus, pull https://github.com/TrinityCore/TrinityCore/issues/2781, closes #61, #267
-- Iron Colossus - Jormungar not working yet, so make it a bit easier
UPDATE `creature_template` SET `Health_Mod` = 5 WHERE `entry` = 30300;
-- Jormunger Control Orb
DELETE FROM `gameobject` WHERE `id`=192262;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(173, 192262, 571, 1, 0x8, 8497.219, -90.90104, 789.2875, 0.1396245, 0, 0, 0.06975555, 0.9975641, 0, 0, 0);
DELETE FROM `creature` WHERE `id` IN (30301,30322,30300);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(4089, 30301, 571, 1, 0x8, 0, 0, 8497.78, -99.0251, 786.528, 3.01942, 120, 0, 0, 1, 0, 0, 0, 0, 0), -- Tamed Jormungar
(4090, 30322, 571, 1, 0x8, 0, 0, 8505.47, -86.2532, 787.339, 3.28122, 120, 0, 0, 1, 0, 0, 0, 0, 0), -- Earthen Jormungar Handler
(4765, 30322, 571, 1, 0x8, 0, 0, 8502.62, -111.308, 790.176, 3.05433, 120, 0, 0, 1, 0, 0, 0, 0, 0),
(6095, 30322, 571, 1, 0x8, 0, 0, 8498.78, -46.0375, 788.895, 2.53073, 120, 0, 0, 1, 0, 0, 0, 0, 0),
(6096, 30300, 571, 1, 0x8, 0, 0, 8015.63, -126.515, 865.719, 3.39914, 120, 0, 0, 1, 0, 0, 0, 0, 0); -- Iron Colossus
-- Template updates
UPDATE `gameobject_template` SET `flags`=0x4 WHERE `entry`=192262; -- Jormungar Control Orb
UPDATE `creature_template` SET `faction_A`=1771,`faction_H`=1771,`unit_flags`=0x8040,`speed_walk`=2.8,`speed_run`=1.5873 WHERE `entry`=30300; -- Iron Colossus
UPDATE `creature_template` SET `faction_A`=1770,`faction_H`=1770,`npcflag`=0x1,`unit_flags`=0x300,`equipment_id`=1003,`speed_run`=0.99206 WHERE `entry`=30322; -- Earthen Jormungar Handler
UPDATE `creature_template` SET `faction_A`=113,`faction_H`=113,`unit_flags`=0x300,`speed_walk`=6,`speed_run`=2.14286,`VehicleId`=227 WHERE `entry`=30301; -- Tamed Jormungar
-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=3.1,`combat_reach`=50,`gender`=0 WHERE `modelid`=27093; -- Iron Colossus
UPDATE `creature_model_info` SET `bounding_radius`=0.31,`combat_reach`=1,`gender`=0 WHERE `modelid`=26091; -- Earthen Jormungar Handler
UPDATE `creature_model_info` SET `bounding_radius`=1.55,`combat_reach`=5,`gender`=2 WHERE `modelid`=26935; -- Tamed Jormungar
-- Addon data for creature 30300 (Iron Colossus)
DELETE FROM `creature_template_addon` WHERE `entry` IN (30300,30322,30301);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(30300,0,0,1,0, NULL), -- Iron Colossus
(30322,0,0,1,0, NULL), -- Earthen Jormungar Handler
(30301,0,0,1,0, NULL); -- Tamed Jormungar
DELETE FROM `spell_area` WHERE spell=56526;
INSERT INTO `spell_area`(`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES
(56526,4436,13007,1,13007,0,0,2,1), -- Snowdrift Plains
(56526,4435,13007,1,13007,0,0,2,1); -- Navirs Cradle

-- Fix NPC 22441 Teribus the Cursed / Teribus der Verfluchte, make NPC attackable
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 22441;

-- Fix achievement 7363 Snakes, whyd it have to be snakes / Schlangen, ich hasse Schlangen!
DELETE FROM `disables` WHERE entry = 7363 AND sourceType = 4;
DELETE FROM `achievement_criteria_data` WHERE `type` = 11 AND `criteria_id` = 7363;
INSERT INTO `achievement_criteria_data` VALUES
(7363, 11, 0, 0, 'achievement_snakes_whyd_it_have_to_be_snakes');

-- Fix NPC 37955 Bloodqueen Lana'thel / Blutkönigin Lana'thel in instance / Instanz ICC / Icecrown Citadel / Eiskronenzitadelle - set correct immunities
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (37955, 38434, 38435, 38436);

-- Sparktouched Murlocs + Frenzyheart Typen in Sholozarbecken, keine EP und Neutral - Angreifbar, koennen mit Bombe massengekillt werden, closes #772
UPDATE `creature_template` SET `flags_extra` = 64, `faction_A` = 25, `faction_H` = 25 WHERE `entry` IN (28079, 28111, 28078, 28112, 28080, 28081);

-- Fixes for Winterhauchfest / Feast of Winter Veil, closes #780, #788
-- Fix achievements 4436, 4437 BB King / Boss auf der Erbse
-- Add item 47625 Rotes Erbsengewehr / Red Rider Air Rifle to vendors 29478 Jepetto Spaßbrumm / Jepetto Joybuzz, 29716 Clockwork Assistant / Aufziehgehilfe, closes #781
-- Set creatures 7937, 16802 Lor'thermar Theron / Hochtüftler Mekkadrill / High Tinker Mekkatorque pvp attackable
DELETE FROM `npc_vendor` WHERE `item` = 46725;
DELETE FROM `game_event_npc_vendor` WHERE `item` = 46725;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`)
SELECT 2, guid, 0, 46725, 0, 0, 0 FROM `creature` WHERE `id` IN (29478, 29716);
UPDATE `creature_template` SET `faction_A` = 23, `faction_H` = 23, `unit_flags` = 0 WHERE `entry` = 7937;
UPDATE `creature_template` SET `faction_A` = 1603, `faction_H` = 1603, `unit_flags` = 0 WHERE `entry` = 16802;
-- Fix achievements 1685, 1686 Brüderliche Weihnacht / Bros. Before Ho Ho Ho's
-- Set all relevant creatures pvp attackble
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (739,927,1351,1444,5484,5489,5661,8140,12336,26044,31261,1182)) AND `bytes2` != 0;
DELETE FROM `creature_template_addon` WHERE `entry` IN (SELECT `guid` FROM `creature` WHERE `id` IN (739,927,1351,1444,5484,5489,5661,8140,12336,26044,31261,1182)) AND `bytes2` != 0;
UPDATE `creature_template` SET `faction_A` = 11, `faction_H` = 11 WHERE `entry` IN (739,927,1351,1444,5484,5489,12336,1182);
UPDATE `creature_template` SET `faction_A` = 1096, `faction_H` = 1096 WHERE `entry` = 8140;
UPDATE `creature_template` SET `faction_A` = 85, `faction_H` = 85 WHERE `entry` IN (5661,26044,31261);
-- Fix achievement 277 Alle Jahre Wieder / 'Tis the Season
-- Add required item 21215 Graccus hausgemachte Früchtepastete / Graccu's Mince Meat Fruitcake to vendors
UPDATE `item_template` SET `BuyPrice` = 100000 WHERE `entry` = 21215;
DELETE FROM `npc_vendor` WHERE `item` = 21215;
INSERT INTO `npc_vendor` (entry, slot, item, maxcount, incrtime, ExtendedCost) VALUES
(13420, 0, 21215, 0, 0, 0),
(13429, 0, 21215, 0, 0, 0),
(13432, 0, 21215, 0, 0, 0),
(13433, 0, 21215, 0, 0, 0),
(13435, 0, 21215, 0, 0, 0),
(23064, 0, 21215, 0, 0, 0),
(23010, 0, 21215, 0, 0, 0),
(23012, 0, 21215, 0, 0, 0);
-- Fix achievement 1282 Tra-la-la-la-Ogri'la / Fa-la-la-la-Ogri'la
-- By fixing quests 11010, 11023 Bombing Run / Bomberangriff, Und wieder ein Bombenangriff! / Bomb Them Again!
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23118;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23118 AND `source_type` = 0;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(23118, 0, 0, 1, 8, 0, 100, 0, 40160, 0, 0, 0, 33, 23118, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bombing Run Target Bunny - On Spellhit - Cast spell on invoker'),
(23118, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bombing Run Target Bunny - On Spellhit - Despawn');
DELETE FROM `creature` WHERE `id` = 23118;
DELETE FROM `gameobject` WHERE `id` = 185861;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(23118, 530, 1, 1, 0, 0, 2871.25, 7134.79, 365.87, 3.14351, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2755.86, 6996.17, 364.927, 5.95131, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2757.6, 7045.62, 365.312, 4.41978, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2823.77, 7095.28, 365.48, 3.96425, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2886.51, 7025.05, 364.626, 0.249318, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2929.96, 7092.98, 367.336, 1.91044, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2823.96, 6977.17, 364.899, 0.901198, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2835.63, 6904.85, 362.623, 2.46807, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2913.61, 6880.22, 363.943, 0.724484, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2832.54, 6986.15, 364.85, 0.402468, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2866.13, 7020.46, 364.271, 0.775532, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2905.5, 7051.49, 365.458, 0.657722, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2942.84, 7088.68, 366.143, 0.253242, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2982.45, 7094.89, 365.27, 6.13587, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2950.9, 7115.27, 365.438, 2.33062, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2897.6, 7136.56, 366.836, 4.14882, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2890.35, 7079.02, 365.553, 5.19339, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2904.98, 7010.84, 365.064, 4.91458, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2945.27, 6956.83, 364.505, 5.46828, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2998.74, 6952.87, 364.911, 0.245383, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3026.76, 6986.07, 364.34, 0.869774, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3025.76, 7029.41, 365.106, 1.3685, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3067.64, 7037.86, 364.082, 0.107938, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3063.73, 7001.13, 365.195, 4.7575, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3062.21, 6968.52, 364.283, 4.51403, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3021.15, 6944.91, 364.346, 3.6658, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3022.11, 6920.89, 365.632, 4.98919, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3046.1, 6906.42, 365.403, 6.00628, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3049.63, 6880.64, 365.972, 4.6711, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3072.19, 6870.68, 364.222, 4.71037, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3070.2, 6822.7, 365.207, 3.95639, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3017.03, 6776.4, 364.837, 2.88432, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2959.5, 6794.98, 367.244, 2.53875, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2963.23, 6836.03, 369.41, 1.45097, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3001.98, 6874.88, 370.779, 5.3544, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2999.09, 6809.52, 372.074, 2.83328, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2917.28, 6832.45, 365.286, 2.30706, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2845.81, 6891.65, 361.89, 2.69976, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2814.96, 6942.02, 364.177, 0.79124, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2855.23, 7026.27, 365.273, 1.89865, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2836.53, 7065.31, 363.916, 2.4445, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2788.88, 6963.36, 364.815, 4.84782, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2881.43, 6943.33, 366.703, 0.316068, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2953.54, 7001.37, 364.158, 0.543834, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3030.36, 7057.97, 365.726, 1.29389, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 3016.27, 7103.65, 364.889, 2.03609, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2985.75, 7120.5, 364.716, 2.63692, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2975.34, 7162.22, 365.584, 0.983657, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2946.65, 7181.79, 364.074, 3.29273, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 2865.6, 7066.61, 365.126, 4.54543, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1745.36, 7403.19, 365.396, 4.49831, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1688.51, 7316.32, 363.999, 3.70506, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1620.21, 7315.29, 363.892, 2.55445, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1575.44, 7341.78, 365.199, 2.9982, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1519.28, 7338.63, 363.974, 2.96678, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1481.31, 7344.67, 364.031, 3.55583, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1396.33, 7300.27, 364.213, 3.57939, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1390.95, 7240.75, 363.671, 5.76673, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1382.85, 7160.62, 364.019, 4.49831, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1420.04, 7141.84, 366.193, 0.571316, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1517.61, 7180.23, 364.079, 5.90417, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1564.45, 7194.11, 363.207, 1.45882, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1562.81, 7235.29, 364.233, 2.05965, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1509, 7290.44, 366.647, 3.3045, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1476.06, 7281.6, 369.925, 4.25876, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1451.56, 7244.72, 369.133, 4.56978, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1418.06, 7196.71, 363.819, 5.18239, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1384.52, 7140.09, 364.409, 2.81442, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1372.5, 7250.59, 363.607, 2.80657, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1315.3, 7263.2, 364.034, 2.8262, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1316.81, 7312.14, 364.052, 1.49495, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1314.57, 7386.93, 364.887, 0.886269, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1369.21, 7375.97, 364.213, 5.77537, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1409.73, 7395.34, 367.611, 4.44412, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1413.81, 7365.31, 370.299, 4.87217, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1442.89, 7331.88, 362.844, 5.91674, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1481.58, 7317.03, 364.487, 5.91674, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1568.64, 7313.1, 364.258, 0.0773015, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1627.34, 7386.3, 364.154, 0.693839, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1681.34, 7402.97, 369.979, 5.66148, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1688.03, 7362.66, 368.843, 4.23206, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1653.72, 7325.93, 364.978, 3.83543, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1591.95, 7249.71, 364.919, 4.17708, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1518.83, 7180.7, 364.761, 3.7294, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1473.6, 7157.12, 365.863, 2.17039, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1438.75, 7156.03, 364.236, 3.25031, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1380.49, 7138.45, 364.042, 3.84329, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1390.23, 7181.3, 364.832, 1.3575, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1353.76, 7253.69, 363.638, 2.36674, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1305.3, 7276.97, 365.124, 3.10501, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1287.41, 7229.82, 371.555, 4.46375, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1263.61, 7146.68, 371.392, 5.39838, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1285.44, 7138.6, 372.174, 0.0773001, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1358.65, 7291.23, 364.742, 2.40993, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1335.14, 7348.68, 367.808, 0.729179, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1438.55, 7286.56, 373.621, 4.61691, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1482.1, 7243.54, 374.679, 0.0026865, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1631.08, 7220.06, 368.868, 4.92321, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1611.65, 7154.3, 369.043, 5.87354, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(23118, 530, 1, 1, 0, 0, 1629.37, 7271.88, 364.229, 5.01745, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(185861, 530, 1, 1, 2823.96, 6977.17, 364.899, 0.901198, 0, 0, 0.435505, 0.900186, 300, 0, 1),
(185861, 530, 1, 1, 2835.63, 6904.85, 362.623, 2.46807, 0, 0, 0.943829, 0.330433, 300, 0, 1),
(185861, 530, 1, 1, 2913.61, 6880.22, 363.943, 0.724484, 0, 0, 0.354372, 0.935105, 300, 0, 1),
(185861, 530, 1, 1, 2886.51, 7025.05, 364.626, 0.249318, 0, 0, 0.124336, 0.99224, 300, 0, 1),
(185861, 530, 1, 1, 2929.96, 7092.98, 367.336, 1.91044, 0, 0, 0.816439, 0.577431, 300, 0, 1),
(185861, 530, 1, 1, 2871.25, 7134.79, 365.87, 3.14351, 0, 0, 1, -0.000959082, 300, 0, 1),
(185861, 530, 1, 1, 2823.77, 7095.28, 365.48, 3.96425, 0, 0, 0.91659, -0.399829, 300, 0, 1),
(185861, 530, 1, 1, 2757.6, 7045.62, 365.312, 4.41978, 0, 0, 0.802636, -0.596469, 300, 0, 1),
(185861, 530, 1, 1, 2755.86, 6996.17, 364.927, 5.95131, 0, 0, 0.165178, -0.986264, 300, 0, 1),
(185861, 530, 1, 1, 2832.54, 6986.15, 364.85, 0.402468, 0, 0, 0.199879, 0.979821, 300, 0, 1),
(185861, 530, 1, 1, 2866.13, 7020.46, 364.271, 0.775532, 0, 0, 0.378121, 0.925756, 300, 0, 1),
(185861, 530, 1, 1, 2905.5, 7051.49, 365.458, 0.657722, 0, 0, 0.322965, 0.946411, 300, 0, 1),
(185861, 530, 1, 1, 2942.84, 7088.68, 366.143, 0.253242, 0, 0, 0.126283, 0.991994, 300, 0, 1),
(185861, 530, 1, 1, 2982.45, 7094.89, 365.27, 6.13587, 0, 0, 0.0735887, -0.997289, 300, 0, 1),
(185861, 530, 1, 1, 2950.9, 7115.27, 365.438, 2.33062, 0, 0, 0.918911, 0.394465, 300, 0, 1),
(185861, 530, 1, 1, 2897.6, 7136.56, 366.836, 4.14882, 0, 0, 0.875845, -0.482593, 300, 0, 1),
(185861, 530, 1, 1, 2890.35, 7079.02, 365.553, 5.19339, 0, 0, 0.518329, -0.855182, 300, 0, 1),
(185861, 530, 1, 1, 2904.98, 7010.84, 365.064, 4.91458, 0, 0, 0.632133, -0.77486, 300, 0, 1),
(185861, 530, 1, 1, 2945.27, 6956.83, 364.505, 5.46828, 0, 0, 0.39627, -0.918134, 300, 0, 1),
(185861, 530, 1, 1, 2998.74, 6952.87, 364.911, 0.245383, 0, 0, 0.122384, 0.992483, 300, 0, 1),
(185861, 530, 1, 1, 3026.76, 6986.07, 364.34, 0.869774, 0, 0, 0.421308, 0.906918, 300, 0, 1),
(185861, 530, 1, 1, 3025.76, 7029.41, 365.106, 1.3685, 0, 0, 0.632093, 0.774893, 300, 0, 1),
(185861, 530, 1, 1, 3067.64, 7037.86, 364.082, 0.107938, 0, 0, 0.053943, 0.998544, 300, 0, 1),
(185861, 530, 1, 1, 3063.73, 7001.13, 365.195, 4.7575, 0, 0, 0.69098, -0.722874, 300, 0, 1),
(185861, 530, 1, 1, 3062.21, 6968.52, 364.283, 4.51403, 0, 0, 0.773649, -0.633614, 300, 0, 1),
(185861, 530, 1, 1, 3021.15, 6944.91, 364.346, 3.6658, 0, 0, 0.965848, -0.259111, 300, 0, 1),
(185861, 530, 1, 1, 3022.11, 6920.89, 365.632, 4.98919, 0, 0, 0.602794, -0.797897, 300, 0, 1),
(185861, 530, 1, 1, 3046.1, 6906.42, 365.403, 6.00628, 0, 0, 0.138012, -0.990431, 300, 0, 1),
(185861, 530, 1, 1, 3049.63, 6880.64, 365.972, 4.6711, 0, 0, 0.721552, -0.692361, 300, 0, 1),
(185861, 530, 1, 1, 3072.19, 6870.68, 364.222, 4.71037, 0, 0, 0.707819, -0.706394, 300, 0, 1),
(185861, 530, 1, 1, 3070.2, 6822.7, 365.207, 3.95639, 0, 0, 0.918154, -0.396223, 300, 0, 1),
(185861, 530, 1, 1, 3017.03, 6776.4, 364.837, 2.88432, 0, 0, 0.991738, 0.12828, 300, 0, 1),
(185861, 530, 1, 1, 2959.5, 6794.98, 367.244, 2.53875, 0, 0, 0.954915, 0.296879, 300, 0, 1),
(185861, 530, 1, 1, 2963.23, 6836.03, 369.41, 1.45097, 0, 0, 0.663499, 0.748177, 300, 0, 1),
(185861, 530, 1, 1, 3001.98, 6874.88, 370.779, 5.3544, 0, 0, 0.447879, -0.894094, 300, 0, 1),
(185861, 530, 1, 1, 2999.09, 6809.52, 372.074, 2.83328, 0, 0, 0.988141, 0.153549, 300, 0, 1),
(185861, 530, 1, 1, 2917.28, 6832.45, 365.286, 2.30706, 0, 0, 0.9142, 0.405263, 300, 0, 1),
(185861, 530, 1, 1, 2845.81, 6891.65, 361.89, 2.69976, 0, 0, 0.975697, 0.219125, 300, 0, 1),
(185861, 530, 1, 1, 2814.96, 6942.02, 364.177, 0.79124, 0, 0, 0.38538, 0.922758, 300, 0, 1),
(185861, 530, 1, 1, 2855.23, 7026.27, 365.273, 1.89865, 0, 0, 0.813023, 0.582231, 300, 0, 1),
(185861, 530, 1, 1, 2836.53, 7065.31, 363.916, 2.4445, 0, 0, 0.939871, 0.34153, 300, 0, 1),
(185861, 530, 1, 1, 2788.88, 6963.36, 364.815, 4.84782, 0, 0, 0.65764, -0.753332, 300, 0, 1),
(185861, 530, 1, 1, 2881.43, 6943.33, 366.703, 0.316068, 0, 0, 0.157377, 0.987539, 300, 0, 1),
(185861, 530, 1, 1, 2953.54, 7001.37, 364.158, 0.543834, 0, 0, 0.268578, 0.963258, 300, 0, 1),
(185861, 530, 1, 1, 3030.36, 7057.97, 365.726, 1.29389, 0, 0, 0.602751, 0.797929, 300, 0, 1),
(185861, 530, 1, 1, 3016.27, 7103.65, 364.889, 2.03609, 0, 0, 0.851083, 0.525031, 300, 0, 1),
(185861, 530, 1, 1, 2985.75, 7120.5, 364.716, 2.63692, 0, 0, 0.968332, 0.249667, 300, 0, 1),
(185861, 530, 1, 1, 2975.34, 7162.22, 365.584, 0.983657, 0, 0, 0.472238, 0.881471, 300, 0, 1),
(185861, 530, 1, 1, 2946.65, 7181.79, 364.074, 3.29273, 0, 0, 0.997146, -0.0754956, 300, 0, 1),
(185861, 530, 1, 1, 2865.6, 7066.61, 365.126, 4.54543, 0, 0, 0.763603, -0.645686, 300, 0, 1),
(185861, 530, 1, 1, 1745.36, 7403.19, 365.396, 4.49831, 0, 0, 0.778604, -0.627515, 300, 0, 1),
(185861, 530, 1, 1, 1688.51, 7316.32, 363.999, 3.70506, 0, 0, 0.960575, -0.27802, 300, 0, 1),
(185861, 530, 1, 1, 1620.21, 7315.29, 363.892, 2.55445, 0, 0, 0.957216, 0.289373, 300, 0, 1),
(185861, 530, 1, 1, 1575.44, 7341.78, 365.199, 2.9982, 0, 0, 0.997431, 0.0716358, 300, 0, 1),
(185861, 530, 1, 1, 1519.28, 7338.63, 363.974, 2.96678, 0, 0, 0.996183, 0.0872939, 300, 0, 1),
(185861, 530, 1, 1, 1481.31, 7344.67, 364.031, 3.55583, 0, 0, 0.978627, -0.205642, 300, 0, 1),
(185861, 530, 1, 1, 1396.33, 7300.27, 364.213, 3.57939, 0, 0, 0.976137, -0.217156, 300, 0, 1),
(185861, 530, 1, 1, 1390.95, 7240.75, 363.671, 5.76673, 0, 0, 0.255369, -0.966844, 300, 0, 1),
(185861, 530, 1, 1, 1382.85, 7160.62, 364.019, 4.49831, 0, 0, 0.778604, -0.627516, 300, 0, 1),
(185861, 530, 1, 1, 1420.04, 7141.84, 366.193, 0.571316, 0, 0, 0.281789, 0.959476, 300, 0, 1),
(185861, 530, 1, 1, 1517.61, 7180.23, 364.079, 5.90417, 0, 0, 0.188375, -0.982097, 300, 0, 1),
(185861, 530, 1, 1, 1564.45, 7194.11, 363.207, 1.45882, 0, 0, 0.666429, 0.745569, 300, 0, 1),
(185861, 530, 1, 1, 1562.81, 7235.29, 364.233, 2.05965, 0, 0, 0.857208, 0.51497, 300, 0, 1),
(185861, 530, 1, 1, 1509, 7290.44, 366.647, 3.3045, 0, 0, 0.996684, -0.0813657, 300, 0, 1),
(185861, 530, 1, 1, 1476.06, 7281.6, 369.925, 4.25876, 0, 0, 0.848006, -0.529987, 300, 0, 1),
(185861, 530, 1, 1, 1451.56, 7244.72, 369.133, 4.56978, 0, 0, 0.755687, -0.654933, 300, 0, 1),
(185861, 530, 1, 1, 1418.06, 7196.71, 363.819, 5.18239, 0, 0, 0.523024, -0.852318, 300, 0, 1),
(185861, 530, 1, 1, 1384.52, 7140.09, 364.409, 2.81442, 0, 0, 0.98665, 0.162856, 300, 0, 1),
(185861, 530, 1, 1, 1372.5, 7250.59, 363.607, 2.80657, 0, 0, 0.986003, 0.16673, 300, 0, 1),
(185861, 530, 1, 1, 1315.3, 7263.2, 364.034, 2.8262, 0, 0, 0.987592, 0.157042, 300, 0, 1),
(185861, 530, 1, 1, 1316.81, 7312.14, 364.052, 1.49495, 0, 0, 0.67979, 0.733407, 300, 0, 1),
(185861, 530, 1, 1, 1314.57, 7386.93, 364.887, 0.886269, 0, 0, 0.428773, 0.903412, 300, 0, 1),
(185861, 530, 1, 1, 1369.21, 7375.97, 364.213, 5.77537, 0, 0, 0.251186, -0.967939, 300, 0, 1),
(185861, 530, 1, 1, 1409.73, 7395.34, 367.611, 4.44412, 0, 0, 0.795317, -0.606194, 300, 0, 1),
(185861, 530, 1, 1, 1413.81, 7365.31, 370.299, 4.87217, 0, 0, 0.648422, -0.761281, 300, 0, 1),
(185861, 530, 1, 1, 1442.89, 7331.88, 362.844, 5.91674, 0, 0, 0.1822, -0.983261, 300, 0, 1),
(185861, 530, 1, 1, 1481.58, 7317.03, 364.487, 5.91674, 0, 0, 0.1822, -0.983261, 300, 0, 1),
(185861, 530, 1, 1, 1568.64, 7313.1, 364.258, 0.0773015, 0, 0, 0.0386411, 0.999253, 300, 0, 1),
(185861, 530, 1, 1, 1627.34, 7386.3, 364.154, 0.693839, 0, 0, 0.340002, 0.940425, 300, 0, 1),
(185861, 530, 1, 1, 1681.34, 7402.97, 369.979, 5.66148, 0, 0, 0.305869, -0.952074, 300, 0, 1),
(185861, 530, 1, 1, 1688.03, 7362.66, 368.843, 4.23206, 0, 0, 0.855007, -0.518617, 300, 0, 1),
(185861, 530, 1, 1, 1653.72, 7325.93, 364.978, 3.83543, 0, 0, 0.940424, -0.340003, 300, 0, 1),
(185861, 530, 1, 1, 1591.95, 7249.71, 364.919, 4.17708, 0, 0, 0.868938, -0.494921, 300, 0, 1),
(185861, 530, 1, 1, 1518.83, 7180.7, 364.761, 3.7294, 0, 0, 0.95712, -0.289693, 300, 0, 1),
(185861, 530, 1, 1, 1473.6, 7157.12, 365.863, 2.17039, 0, 0, 0.884394, 0.466741, 300, 0, 1),
(185861, 530, 1, 1, 1438.75, 7156.03, 364.236, 3.25031, 0, 0, 0.998523, -0.0543325, 300, 0, 1),
(185861, 530, 1, 1, 1380.49, 7138.45, 364.042, 3.84329, 0, 0, 0.939082, -0.343693, 300, 0, 1),
(185861, 530, 1, 1, 1390.23, 7181.3, 364.832, 1.3575, 0, 0, 0.627821, 0.778358, 300, 0, 1),
(185861, 530, 1, 1, 1353.76, 7253.69, 363.638, 2.36674, 0, 0, 0.925884, 0.377808, 300, 0, 1),
(185861, 530, 1, 1, 1305.3, 7276.97, 365.124, 3.10501, 0, 0, 0.999833, 0.0182891, 300, 0, 1),
(185861, 530, 1, 1, 1287.41, 7229.82, 371.555, 4.46375, 0, 0, 0.789329, -0.61397, 300, 0, 1),
(185861, 530, 1, 1, 1263.61, 7146.68, 371.392, 5.39838, 0, 0, 0.428114, -0.903725, 300, 0, 1),
(185861, 530, 1, 1, 1285.44, 7138.6, 372.174, 0.0773001, 0, 0, 0.0386404, 0.999253, 300, 0, 1),
(185861, 530, 1, 1, 1358.65, 7291.23, 364.742, 2.40993, 0, 0, 0.933827, 0.357725, 300, 0, 1),
(185861, 530, 1, 1, 1335.14, 7348.68, 367.808, 0.729179, 0, 0, 0.356566, 0.93427, 300, 0, 1),
(185861, 530, 1, 1, 1438.55, 7286.56, 373.621, 4.61691, 0, 0, 0.740045, -0.672557, 300, 0, 1),
(185861, 530, 1, 1, 1482.1, 7243.54, 374.679, 0.0026865, 0, 0, 0.00134325, 0.999999, 300, 0, 1),
(185861, 530, 1, 1, 1631.08, 7220.06, 368.868, 4.92321, 0, 0, 0.628785, -0.777579, 300, 0, 1),
(185861, 530, 1, 1, 1611.65, 7154.3, 369.043, 5.87354, 0, 0, 0.203394, -0.979097, 300, 0, 1),
(185861, 530, 1, 1, 1629.37, 7271.88, 364.229, 5.01745, 0, 0, 0.591458, -0.806336, 300, 0, 1);
-- Add item 17712 Winter Veil Disguise Kit / Winterhauchverkleidungsset to vendors
UPDATE `item_template` SET `BuyPrice` = 100000 WHERE `entry` = 17712;
DELETE FROM `npc_vendor` WHERE `item` = 17712;
INSERT INTO `npc_vendor` (entry, slot, item, maxcount, incrtime, ExtendedCost) VALUES
(13420, 0, 17712, 0, 0, 0),
(13429, 0, 17712, 0, 0, 0),
(13432, 0, 17712, 0, 0, 0),
(13433, 0, 17712, 0, 0, 0),
(13435, 0, 17712, 0, 0, 0),
(23064, 0, 17712, 0, 0, 0),
(23010, 0, 17712, 0, 0, 0),
(23012, 0, 17712, 0, 0, 0);

-- Fix difficulty selection for several achievements
-- Normal / 10 Man Normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7573, 12764, 12780, 13011) AND `type` IN (0, 12);
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(7573, 12, 0, 0, ''),
(12764, 12, 0, 0, ''),
(12780, 12, 0, 0, ''),
(13011, 12, 0, 0, '');
-- Heroic / 25 Man Normal
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7574, 7590, 7593, 12909, 13012, 13013) AND `type` IN (0, 12);
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(7574, 12, 1, 0, ''),
(7590, 12, 1, 0, ''),
(7593, 12, 1, 0, ''),
(12909, 12, 1, 0, ''),
(13012, 12, 1, 0, ''),
(13013, 12, 1, 0, '');
-- 10 Man Heroic
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12825) AND `type` IN (0, 12);
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(12825, 12, 2, 0, '');
-- 25 Man Heroic
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (12826) AND `type` IN (0, 12);
INSERT INTO `achievement_criteria_data` (criteria_id, type, value1, value2, ScriptName) VALUES
(12826, 12, 3, 0, '');

-- Fix NPCs 15649, 15650 Feral Dragonhawk Hatchling / Wildes Drachenfalkenjunges - Crazed Dragonhawk / Wahnsinniger Drachenfalke - fix wrong arcane resistance
UPDATE `creature_template` SET `resistance6` = 0 WHERE `entry` IN (15650, 15649);

-- Fix quest 12630 Narsch treten und Haare krümmen / Kickin' Nass and Takin' Manes, closes #263
-- Give required kill credit 28519 on kill of target NPC 28519 Siechender Troll / Withered Troll
UPDATE `creature_template` SET `KillCredit1` = 28523 WHERE `entry` = 28519;

-- Fix quest 12673 Nach oben buckeln, nach unten treten / It Rolls Downhill, closes #144
-- Give required kill credit 28740 on kill of target NPC 28750 Seuchenspuk / Blight Geist
UPDATE `creature_template` SET `KillCredit1` = 28740 WHERE `entry` = 28750;

-- Disable spell 23789, Stoneclaw Totem TEST, prevent crashes
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 23789;
INSERT INTO `disables` (sourceType, entry, flags, params_0, params_1, comment) VALUES
(0, 23789, 1, '', '', 'Spell - Stoneclaw Totem TEST - Prevent crashes');

-- Fix spell 20154 / 25742 SoR / Seal of Righeousness / Siegel der Rechtschaffenheit, closes #309
DELETE FROM `spell_bonus_data` WHERE `entry`=25742;
INSERT INTO `spell_bonus_data` (entry, direct_bonus, ap_bonus, comments) VALUES
(25742,0,0,'Paladin - Seal of Righteousness Dummy Proc');

-- Fix Brewfest / Braufest NPCs, closes #385, #400, #403
-- Vendordata
-- 23710 Belbi Quikswitch / Belbi Blitzknips
-- 24495 Blix Fixwidget / Blix Fixtand
DELETE FROM `npc_vendor` WHERE `item` IN (33864, 33967, 33968, 33969, 33862, 33863, 33966, 33868, 37816, 37750, 39477, 33047, 37736, 39476, 34008, 37737, 32233, 33927, 46707) AND `entry` IN (23710, 24495);
INSERT INTO `npc_vendor` (entry, slot, item, maxcount, incrtime, ExtendedCost) VALUES
(23710, 0, 32233, 0, 0, 0),
(23710, 0, 33047, 0, 0, 2275),
(23710, 0, 33862, 0, 0, 2276),
(23710, 0, 33863, 0, 0, 2276),
(23710, 0, 33864, 0, 0, 2274),
(23710, 0, 33868, 0, 0, 2275),
(23710, 0, 33927, 0, 0, 2275),
(23710, 0, 33966, 0, 0, 2275),
(23710, 0, 33967, 0, 0, 2274),
(23710, 0, 33968, 0, 0, 2274),
(23710, 0, 33969, 0, 0, 2274),
(23710, 0, 37736, 0, 0, 2276),
(23710, 0, 37750, 0, 0, 2398),
(23710, 0, 37816, 0, 0, 2399),
(23710, 0, 39477, 0, 0, 2424),
(23710, 0, 46707, 0, 0, 2275),
(24495, 0, 32233, 0, 0, 0),
(24495, 0, 33862, 0, 0, 2276),
(24495, 0, 33863, 0, 0, 2276),
(24495, 0, 33864, 0, 0, 2274),
(24495, 0, 33868, 0, 0, 2275),
(24495, 0, 33927, 0, 0, 2275),
(24495, 0, 33966, 0, 0, 2275),
(24495, 0, 33967, 0, 0, 2274),
(24495, 0, 33968, 0, 0, 2274),
(24495, 0, 33969, 0, 0, 2274),
(24495, 0, 34008, 0, 0, 2275),
(24495, 0, 37737, 0, 0, 2276),
(24495, 0, 37750, 0, 0, 2398),
(24495, 0, 37816, 0, 0, 2399),
(24495, 0, 39476, 0, 0, 2424),
(24495, 0, 46707, 0, 0, 2275);

-- Fix Brewfest / Braufest NPCs, closes #397
-- Fix creature 36021 The Brewmaiden / Die Schankmaid, react on emote
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 36021;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 36021;
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(3602100, 36021, 22, 0, 100, 1, 101, 0, 0, 0, 11, 48249, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Fix spell stacking of several abilities, closes #428
-- create spell ranks for simpler stacking rules
DELETE FROM `spell_ranks` WHERE `first_spell_id` IN (51726, 60431);
INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES
(51726, 51726, 1), -- Ebon Plaguebringer (4% Spell-Damage)
(51726, 51734, 2), -- Ebon Plaguebringer (8% Spell-Damage)
(51726, 51735, 3), -- Ebon Plaguebringer (13% Spell-Damage)
(60431, 60431, 1), -- Earth and Moon (4% Spell-Damage)
(60431, 60432, 2), -- Earth and Moon (8% Spell-Damage)
(60431, 60433, 3); -- Earth and Moon (13% Spell-Damage)
-- and assemble them as a spell group
DELETE FROM `spell_group` WHERE `id` = 5005;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(5005, 1490), -- Curse of the Elements (Warlock)
(5005, 51726), -- Ebon Plaguebringer (Unholy DK)
(5005, 60431); -- Earth and Moon (Moonkin)
-- regulate spell stacking; exclusive per group
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 5005;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(5005, 1);

-- Fix quest 8575 Azuregos' magisches Buch / Azuregos's Magical Ledger, closes #295
UPDATE `creature_template` SET `ScriptName` = 'npc_spirit_of_azuregos' WHERE `entry` = 15481;

-- Fix quest relations for Skybreaker Alliance, closes #438
-- remove Watts My Target from questgivers as the quest was never used (cmp. http://www.wowhead.com/quest=13381)
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13381;
DELETE FROM `creature_questrelation` WHERE `quest` = 13381;
-- Mind Tricks, Slaves To Saronite, Get To Ymirheim, Blood of the Chosen, Joining The Assault, The Broken Front, Finish Me! all depend on The Skybreaker
UPDATE `quest_template` SET `PrevQuestId` = 13225 WHERE `entry` IN (13308, 13300, 13296, 13336, 13341, 13231, 13232);
-- Joining The Assault opens up two dailys (Assault By Air, Assault By Ground)
UPDATE `quest_template` SET `PrevQuestId` = 13341 WHERE `entry` IN (13309, 13284);
-- No Mercy depends on the Broken Front
UPDATE `quest_template` SET `PrevQuestId` = 13231 WHERE `entry` = 13233;
-- The Solution Solution depends on Borrowed Technology
UPDATE `quest_template` SET `PrevQuestId` = 13291 WHERE `entry` = 13292;
-- Killohertz depends on Borrowed Technology
UPDATE `quest_template` SET `PrevQuestId` = 13291 WHERE `entry` = 13383;
-- Your Attention, Please and ...All the Help We Can Get both depend on The Broken Front
UPDATE `quest_template` SET `PrevQuestId` = 13231 WHERE `entry` IN (13290, 13286);
-- Quest-Chain beginnig At Your Attention, Please
UPDATE `quest_template` SET `NextQuestInChain` = 13291 WHERE `entry` = 13290; -- Borrowed Technology
UPDATE `quest_template` SET `NextQuestInChain` = 13383 WHERE `entry` = 13291; -- Killohertz
UPDATE `quest_template` SET `NextQuestInChain` = 13380 WHERE `entry` = 13383; -- Killohertz
-- [D] Static Shock Troops: the Bombardment
-- [D] Putting the Hertz: The Valley of Lost Hope both depend on Leading the Charge (replaces Watts My Target dependency)
UPDATE `quest_template` SET `PrevQuestId` = 13380 WHERE `entry` IN (13404, 13382);
-- Thats Abominable! depends on Poke and Prod and opens itself as a daily afterwards
UPDATE `quest_template` SET `PrevQuestId` = 13287 WHERE `entry` = 13288;
UPDATE `quest_template` SET `PrevQuestId` = 13288 WHERE `entry` = 13289;
-- Against the Giants depends on Poke and Prod
UPDATE `quest_template` SET `PrevQuestId` = 13287 WHERE `entry` = 13294;
-- Coprous the Defiled depends on Against the Giants
UPDATE `quest_template` SET `PrevQuestId` = 13294 WHERE `entry` = 13298;
-- [D] Neutralizing the Plague only after Basic Chemistry
UPDATE `quest_template` SET `PrevQuestId` = 13295 WHERE `entry` = 13297;
-- Sneak Preview only after Thats Abominable + QuestChain
UPDATE `quest_template` SET `PrevQuestId` = 13288, `NextQuestInChain` = 13319 WHERE `entry` = 13315;
-- Chain Of Command depends on Sneak Preview + QuestChain
UPDATE `quest_template` SET `PrevQuestId` = 13315, `NextQuestInChain` = 13320 WHERE `entry` = 13319;
-- Cannot Reproduce depends on Chain Of Command + QuestChain
UPDATE `quest_template` SET `PrevQuestId` = 13319, `NextQuestInChain` = 13321 WHERE `entry` = 13320;
-- Retest Now only after Cannot Reproduce; daily only after non-daily
UPDATE `quest_template` SET `PrevQuestId` = 13320 WHERE `entry` = 13321;
UPDATE `quest_template` SET `PrevQuestId` = 13321 WHERE `entry` = 13322;
-- Drag and Drop only after Sneak Preview; daily only after non-daily; QuestChain
UPDATE `quest_template` SET `PrevQuestId` = 13315, `NextQuestInChain` = 13342 WHERE `entry` = 13318;
UPDATE `quest_template` SET `PrevQuestId` = 13318 WHERE `entry` = 13323;
-- Not a Bug: daily after non-daily
UPDATE `quest_template` SET `PrevQuestId` = 13342 WHERE `entry` = 13344;
-- Need More Info after Drag and Drop
UPDATE `quest_template` SET `PrevQuestId` = 13318 WHERE `entry` = 13345;
-- No Rest For The Wicked after Need More Info + Daily after Non-Daily; QuestChain to Ironwall Rampart
UPDATE `quest_template` SET `PrevQuestId` = 13345, `NextQuestInChain` = 13337 WHERE `entry` = 13346;
UPDATE `quest_template` SET `PrevQuestId` = 13346 WHERE `entry` = 13350;
-- The Ironwall Rampart only after No Rest For The Wicked; QuestChain to Before The Gate Of Horror
UPDATE `quest_template` SET `PrevQuestId` = 13346, `NextQuestInChain` = 13335  WHERE `entry` = 13337;
-- Raise the Barricade only after Need More Info; QuestChain to Get the Message
UPDATE `quest_template` SET `PrevQuestId` = 13345, `NextQuestInChain` = 13314 WHERE `entry` = 13332;
-- Get The Message; Capture More Dispatches [D] after Raise The Barricades
UPDATE `quest_template` SET `PrevQuestId` = 13332 WHERE `entry` IN (13314, 13333);
-- Bloodspattered Banners after Raise The Barricades
UPDATE `quest_template` SET `PrevQuestId` = 13332 WHERE `entry` = 13334;
-- Before THe Gate Of Horror depends on Bloodspattered Banners
UPDATE `quest_template` SET `PrevQuestId` = 13334 WHERE `entry` = 13335;
-- Shattered Shards, The Guardians of Corprethar both depend on Before The Gate Of Horror
UPDATE `quest_template` SET `PrevQuestId` = 13335 WHERE `entry` IN (13338, 13339);


-- Fix quest relations on Orgrims Hammer Horde, #439
-- remove Amped for Revolt! from questgivers as the quest was never used (cmp. http://www.wowhead.com/quest=13374)
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13374;
DELETE FROM `creature_questrelation` WHERE `quest` = 13374;
-- Quests depending on Orgrims Hammer: The Broken Front, Mind Tricks, Slaves to Saronite, Get to Ymirheim, Blood of the Chosen, Joining the Assault, Avenge Me!, Opportunity
UPDATE `quest_template` SET `PrevQuestId` = 13224 WHERE `entry` IN (13228, 13308, 13302, 13293, 13330, 13340, 13230, 13258);
-- Assault by Air/Ground both depend on Joining the Assault
UPDATE `quest_template` SET `PrevQuestId` = 13340 WHERE `entry` IN (13310, 13301);
-- Make Them Pay depends on the Broken Front
UPDATE `quest_template` SET `PrevQuestId` = 13228 WHERE `entry` = 13233;
-- Good For Something; Quest-Chain leading to Fringe Science Benefits
UPDATE `quest_template` SET `PrevQuestId` = 13228, `NextQuestInChain` = 13239 WHERE `entry` = 13238; -- Good For Something
UPDATE `quest_template` SET `PrevQuestId` = 13238, `NextQuestInChain` = 13379 WHERE `entry` = 13239; -- Volatility
UPDATE `quest_template` SET `PrevQuestId` = 13239, `NextQuestInChain` = 13373 WHERE `entry` = 13379; -- Green Technology
UPDATE `quest_template` SET `PrevQuestId` = 13379 WHERE `entry` = 13373; -- Fringe Science Benefits
-- Fringe Science Benefits opens Riding the Wavelength: The Bombardment [D], Total Ohmage: The Valley of Lost Hope! [D]
UPDATE `quest_template` SET `PrevQuestId` = 13373 WHERE `entry` IN (13406, 13376);
-- Takes One To Know One depends on The Broken Front
UPDATE `quest_template` SET `PrevQuestId` = 13228 WHERE `entry` = 13260;
-- Poke and Prod depends on Takes One To Know One
UPDATE `quest_template` SET `PrevQuestId` = 13260 WHERE `entry` = 13237;
-- Thats Abominable and Against the Giants both depend on Poke and Prod
UPDATE `quest_template` SET `PrevQuestId` = 13237 WHERE `entry` IN (13264, 13277);
-- Against the Giants opens Coprous the Defiled
UPDATE `quest_template` SET `PrevQuestId` = 13277 WHERE `entry` = 13278;
-- [D] Neutralizing the Plague only after Basic Chemistry
UPDATE `quest_template` SET `PrevQuestId` = 13279 WHERE `entry` = 13281;
-- Thats Abominable opens its daily
UPDATE `quest_template` SET `PrevQuestId` = 13264 WHERE `entry` = 13276;
-- Sneak Preview is opened by Thats Abominable
UPDATE `quest_template` SET `PrevQuestId` = 13264 WHERE `entry` = 13351;
-- Chain Of Command depends on Sneak Preview
UPDATE `quest_template` SET `PrevQuestId` = 13351 WHERE `entry` = 13354;
-- Cannot Reproduce depends on Chain Of Command + QuestChain
UPDATE `quest_template` SET `PrevQuestId` = 13351, `NextQuestInChain` = 13356 WHERE `entry` = 13355;
-- Retest Now only after Cannot Reproduce; daily only after non-daily
UPDATE `quest_template` SET `PrevQuestId` = 13355 WHERE `entry` = 13356;
UPDATE `quest_template` SET `PrevQuestId` = 13356 WHERE `entry` = 13357;
-- Drag and Drop depends on Sneak Preview; opens daily
UPDATE `quest_template` SET `PrevQuestId` = 13351 WHERE `entry` = 13352;
UPDATE `quest_template` SET `PrevQuestId` = 13352 WHERE `entry` = 13353;
-- Not A Bug depends on Drag and Drop; opens daily
UPDATE `quest_template` SET `PrevQuestId` = 13352 WHERE `entry` = 13358;
UPDATE `quest_template` SET `PrevQuestId` = 13358 WHERE `entry` = 13365;
-- Need More Info depends on Drag and Drop; opens Raise the Barricades and No Rest For THe Wicked
UPDATE `quest_template` SET `PrevQuestId` = 13352 WHERE `entry` = 13366;
UPDATE `quest_template` SET `PrevQuestId` = 13366 WHERE `entry` IN (13367, 13306);
-- No Rest For The Wicked opens daily after non-daily
UPDATE `quest_template` SET `PrevQuestId` = 13367 WHERE `entry` =13368;
-- The Ironwall Rampart depends on No Rest For The Wicked; Quest-Chain to  Before The Gate of Horror
UPDATE `quest_template` SET `PrevQuestId` = 13367, `NextQuestInChain` = 13329 WHERE `entry` = 13312;
-- Raise the Barricades opens Blinding the Eyes in the Sky, which then opens Keeping the Alliance Blind [D]
UPDATE `quest_template` SET `PrevQuestId` = 13306 WHERE `entry` = 13313;
UPDATE `quest_template` SET `PrevQuestId` = 13313 WHERE `entry` = 13331;
-- Bloodspattered Banners depends on Raise The Barricades and openes Before The Gate of Horror
UPDATE `quest_template` SET `PrevQuestId` = 13306, `NextQuestId` = 13329 WHERE `entry` = 13307;
-- Before the Gate of Horror depends on Bloodspattered Banners and opens Shatterd Shards, The Guardians of Corp Rethar
-- Shattered Shards, The Guardians of Corprethar both depend on Before The Gate Of Horror
UPDATE `quest_template` SET `PrevQuestId` = 13307 WHERE `entry` = 13329;
UPDATE `quest_template` SET `PrevQuestId` = 13329 WHERE `entry` IN (13328, 13316);

-- Fix creature 26045, Sturmbö / Storm Tempest - remove out of combat unattackable flag, closes #454
UPDATE `creature_template` SET `unit_flags` = 537133072 WHERE `entry` = 26045;

-- Fix creature 22454, Höllengeist / Fel Spirit - remove out of combat unattackable flag, closes #441
UPDATE `creature_template` SET `unit_flags` = 32768 WHERE `entry` = 22454;

-- Fix quest 11595 The Defense of Warsong Hold / Die Verteidigung der Kriegshymnenfeste, closes #468
-- Depends on quest 7783 The Lord of Blackrock / Der Herrscher des Schwarzfels
UPDATE `quest_template` SET `PrevQuestId` = 7783 WHERE `entry` = 11595;
-- Fix quest 11597 The Defense of Warsong Hold / Die Verteidigung der Kriegshymnenfeste, closes #468
-- Depends on quest 8743 Bang a Gong! / Schlagt den Gong!
UPDATE `quest_template` SET `PrevQuestId` = 8743 WHERE `entry` = 11597;

-- Fix quest 11586 Hellscream's Vigil / Höllschreis Wacht, closes #466
-- Depends on quest 10011 Forge Camp: Annihilated / Konstruktionslager: zerstört
UPDATE `quest_template` SET `PrevQuestId` = 10011 WHERE `entry` = 11586;
-- Fix quest 11585 Hellscream's Vigil / Höllschreis Wacht, closes #466
-- 11585 only acceptable without Mag'har quest chain
UPDATE `quest_template` SET `ExclusiveGroup` = 10011 WHERE `entry` IN (10011, 11585);

-- Remove UNIT_FLAG_OOC_NOT_ATTACKABLE to make NPC 23789 Glutschwinge / Smolderwing attackable
UPDATE `creature_template` SET `unit_flags` = 512 WHERE `entry` = 23789;

-- Lock the Etymidian Vehicle (28222) to The Avalanche (Area 4282), closes #469
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceEntry` = 28222;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(16, 0, 28222, 0, 23, 4282, 0, 0, 0, '', 'Lock Etymidian to zone The Avalanche');
-- Remove Experience gain for NPCs located in The Avalanche / Die Lawine, all of them had flags_extra = 0 in original state.
UPDATE `creature_template` SET `flags_extra` = 64 WHERE `entry` IN (28220, 28218, 28242, 28103, 28208, 28207, 28211, 28212);

-- Fix NPC 18754 Barim Spilthoof, Barim Spalthuf - fix gossip so npc will train again, closes #472
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 7816 AND `id` = 0;
INSERT INTO `gossip_menu_option` (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, box_coded, box_money, box_text) VALUES
(7816, 0, 3, 'I would like to train.', 5, 16, 0, 0, 0, 0, '');

-- Implement healing for paladin ability Divine Storm / Göttlicher Sturm 53385, closes #364
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-53385, 53385);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-53385, 'spell_pal_divine_storm');

-- Fix NPCs 20677, 20678, 20679 for quest 10368 The Dreghood Elders / Die Ältesten des Lumpenpacks - give credit via gossip + SAI, closes #437
-- Step 1: Delete maybe-existing former values.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (20677, 20678, 20679) AND `event_type` = 62;
-- Step 2: Create new script-entries:
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(20677, 0, 0, 0, 62, 0, 100, 0, 8162, 0, 0, 0, 33, 20677, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Credit for quest 10368'),
(20678, 0, 0, 0, 62, 0, 100, 0, 8163, 0, 0, 0, 33, 20678, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Credit for quest 10368'),
(20679, 0, 0, 0, 62, 0, 100, 0, 8161, 0, 0, 0, 33, 20679, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Credit for quest 10368');
-- Step3: Update AI to SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (20677, 20678, 20679);

-- Remove OOC NON_ATTACKBLE FLAG from Valduran the Stormborn / Valduran der Sturmgeborene 29368 for Quest 12984. Previous unit_flags=768
UPDATE `creature_template` SET `unit_flags` = 512 WHERE `entry` = 29368;

-- Fix Toxic Tolerance / Gifttoleranz questchain, closes #484
-- Source: http://www.wowhead.com/quest=13917/gorishi-grub#comments:id=829822
-- create new pools, each allowing only 1 out of 4 dailys per day
DELETE FROM `pool_template` WHERE `entry` IN (20100, 20101);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(20100, 1, 'Toxic Tolerance Daily-Quests'),
(20101, 1, 'Toxic Tolerance Daily-Quests');
-- fill pools with the daily quests, starting from creature 34320 Venomhide Hatchling / Gifthautjunges
DELETE FROM `pool_quest` WHERE `pool_entry` IN (20100, 20101);
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(13889, 20100, 'Hungry, Hungry Hatchling'),
(13903, 20100, 'Gorishi Grub'),
(13904, 20100, 'Poached, Scrambled, Or Raw?'),
(13905, 20100, 'Searing Roc Feathers'),
(13915, 20101, 'Hungry, Hungry Hatchling'),
(13917, 20101, 'Gorishi Grub'),
(13916, 20101, 'Poached, Scrambled, Or Raw?'),
(13914, 20101, 'Searing Roc Feathers');

-- Instance / Instanz Violet Hold: Championing Support; Add Standard Reputation for Alliance Vanguard (f1037) and Horde Expedition (f1052), closes #384
-- Boss Reputation: 250; Trash: 15; MaxStanding 7 (Exalted), Fac1 Alliance, Fac2 Horde
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (31134, 31506, 29315, 31507, 29313, 31508, 29312, 31509, 29316, 31510, 29266, 31511, 29314, 31512); -- Bosses
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (
30663, 30918, 31007, 31483, 31484, 31485,
30661, 30961, 31008, 31487, 31488, 31489,
30666, 31486,
30664, 30963, 31010, 31497, 31498, 31499,
30668, 31118, 31490, 31491,
31079, 31492,
30667, 31493,
30662, 30962, 31009, 31494, 31495, 31496,
32191, 32192,
30660, 30892, 31501, 31502,
30695, 30893, 31503, 31504); -- Trash

INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
-- Bosses
(31134, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Cyanigosa nh
(31506, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- hc
(29315, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Erekem nh
(31507, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- hc
(29313, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Ichoron nh
(31508, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- hc
(29312, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Lavanthor nh
(31509, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- hc
(29316, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Moragg nh
(31510, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- hc
(29266, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Xevozz nh
(31511, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- hc
(29314, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- Zuramat nh
(31512, 1037, 1052, 7, 0, 250, 7, 0, 250, 1), -- hc
-- Trash
-- Azure Binder
(30663, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #1
(30918, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #2
(31007, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #3
(31483, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #1
(31484, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #2
(31485, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #3
-- Azure Invader
(30661, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #1
(30961, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #2
(31008, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #3
(31487, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #1
(31488, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #2
(31489, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #3
-- Azure Captain
(30666, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh
(31486, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc
-- Azure Mage Slayer
(30664, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #1
(30963, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #2
(31010, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #3
(31497, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #1
(31498, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #2
(31499, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #3
-- Azure Raider
(30668, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #1
(31118, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #2
(31490, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #1
(31491, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #2
-- Azure Saboteur
(31079, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh
(31492, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc
-- Azure Sorceror
(30667, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh
(31493, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc
-- Azure Spellbreaker
(30662, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #1
(30962, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #2
(31009, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #3
(31494, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #1
(31495, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #2
(31496, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #3
-- Azure Stalker
(32191, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh
(32192, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc
-- Portal Guardian
(30660, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #1
(30892, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #2
(31501, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #1
(31502, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #2
-- Portal Keeper
(30695, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #1
(30893, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- nh #2
(31503, 1037, 1052, 7, 0, 15, 7, 0, 15, 1), -- hc #1
(31504, 1037, 1052, 7, 0, 15, 7, 0, 15, 1); -- hc #2

-- Fix quest 11096 Bedrohung von oben / Threat from Above - npcs gave kill credit twice, closes #485
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (22143, 22144, 22148, 23022) AND `event_type` = 6 AND `action1_type` = 33 AND `action1_param1` = 23450;

-- Fix quest 12253 (Rettung vom Marktplatz / Rescue from Town Square), closes #473
-- We add a gossip to the NPC that grants a the kill credit (as it's already used) and despawns himself.
-- Respawn should be handled properly, since a forced-despawn causes the NPC to die.
-- Positive side-effect is that you cannot talk to the NPC while infight ;)
-- Step 1: Cleaup.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 27359;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 27359;
-- Step 2: Create Smart-scripts.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27359;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27359, 0, 0, 1, 62, 0, 100, 0, 27359, 0, 0, 0, 33, 27359, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rescue from Town Square - Kill-Credit-Organisation'),
(27359, 0, 1, 0, 62, 0, 100, 0, 27359, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rescue from Town Square - Temporary Despawn');
-- Step3: Create gossip-entry.
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(27359, 0, 0, 'You should better run and hide before they return. NOW!', 1, 1, 0, 0, 0, 0, '');
-- Step 4: Relate entry to NPC.
UPDATE `creature_template` SET `gossip_menu_id` = 27359, `npcflag` = 1, `AIName` = 'SmartAI' WHERE `entry` = 27359;
-- Step 5: Insert conditions for the gossip_menu_option - Only shown when quests active
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(15, 27359, 0, 0, 9, 12253, 0, 0, 0, '', 'Gossip Option 27359 only available to players with quest 12253 active');

-- Add some more quest pools, closes #492
-- 24370, Netherpirscher Mah'duun / Nether Stalker Mah'duun: non-heroic dungeon daily pool
DELETE FROM `pool_template` WHERE `entry` = 20200;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
VALUES (20200, 1, 'Quest Pool: Nether-Stalker Mah\'duun');
DELETE FROM `pool_quest` WHERE `pool_entry` = 20200 AND `entry` IN (11389, 11371, 11376, 11383, 11364, 11500, 11385, 11387);
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(11389, 20200, 'Wanted: Arcatraz Sentinels'),
(11371, 20200, 'Wanted: Coilfang Myrmidons'),
(11376, 20200, 'Wanted: Malicious Instructors'),
(11383, 20200, 'Wanted: Rift Lords'),
(11364, 20200, 'Wanted: Shattered Hand Centurions'),
(11500, 20200, 'Wanted: Sisters of Torment'),
(11385, 20200, 'Wanted: Sunseeker Channelers'),
(11387, 20200, 'Wanted: Tempest-Forge Destroyers');
-- 24369, Windhändler Zhareem / Wind Trader Zhareem: heroic dungeon daily pool
DELETE FROM `pool_template` WHERE `entry` = 20201;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
VALUES (20201, 1, 'Quest Pool: Wind Trader Zhareem');
DELETE FROM `pool_quest` WHERE `pool_entry` = 20201 AND `entry` IN (11369, 11384, 11382, 11363, 11362, 11375, 11354, 11386, 11373, 11378, 11374, 11372, 11368, 11388, 11499, 11370);
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(11369, 20201, 'Wanted: A Black Stalker Egg'),
(11384, 20201, 'Wanted: A Warp Splinter Clipping'),
(11382, 20201, 'Wanted: Aeonus\'s Hourglass'),
(11363, 20201, 'Wanted: Bladefist\'s Seal'),
(11362, 20201, 'Wanted: Keli\'dan\'s Feathered Stave'),
(11375, 20201, 'Wanted: Murmur\'s Whisper'),
(11354, 20201, 'Wanted: Nazan\'s Riding Crop'),
(11386, 20201, 'Wanted: Pathaleon\'s Projector'),
(11373, 20201, 'Wanted: Shaffar\'s Wondrous Pendant'),
(11378, 20201, 'Wanted: The Epoch Hunter\'s Head'),
(11374, 20201, 'Wanted: The Exarch\'s Soul Gem'),
(11372, 20201, 'Wanted: The Headfeathers of Ikiss'),
(11368, 20201, 'Wanted: The Heart of Quagmirran'),
(11388, 20201, 'Wanted: The Scroll of Skyriss'),
(11499, 20201, 'Wanted: The Signet Ring of Prince Kael\'thas'),
(11370, 20201, 'Wanted: The Warlord\'s Treatise');

-- Fix quest 12204 In the Name of Loken / In Lokens Namen, closes #262
-- Fix Npc 26420 Gavrock SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=26420;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26420,26420*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26420,0,0,0,62,0,100,0,9485,0,0,0,80,26420*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gavrock - On Gossip Select - Run Script'),
(26420*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gavrock - On Script - Close Gossip'),
(26420*100,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gavrock - On Script - Remove Gossip & Quest Flags'),
(26420*100,9,2,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gavrock - On Script - Say Text 0'),
(26420*100,9,3,0,0,0,100,0,10000,10000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gavrock - On Script - Say Text 1'),
(26420*100,9,4,0,0,0,100,0,15000,15000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gavrock - On Script - Say Text 2'),
(26420*100,9,5,0,0,0,100,0,0,0,0,0,33,26420,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gavrock - On Script - Quest Credit'),
(26420*100,9,6,0,0,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gavrock - On Script - Add Gossip & Quest Flags');
-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=26420;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26420,0,0,'Ah, yes. Loken is well known to me.',12,0,100,0,0,0,'Gavrock'),
(26420,1,0,'It is he who commands the sons of iron in their war against us.',12,0,100,0,0,0,'Gavrock'),
(26420,2,0,'From his hiding place, he oversees their preparations for war with the goal of exterminating the stone giants!',12,0,100,0,0,0,'Gavrock');
-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9485;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,9485,0,9,12204);
-- Fix Npc 26484 Hugh Glass SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=26484;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26484,26484*100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26484,0,0,0,62,0,100,0,9484,0,0,0,80,26484*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hugh Glass - On Gossip Select - Run Script'),
(26484*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Hugh Glass - On Script - Close Gossip'),
(26484*100,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hugh Glass - On Script - Remove Gossip & Quest Flags'),
(26484*100,9,2,0,0,0,100,0,5000,5000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hugh Glass - On Script - Say Text 0'),
(26484*100,9,3,0,0,0,100,0,10000,10000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hugh Glass - On Script - Say Text 1'),
(26484*100,9,5,0,0,0,100,0,0,0,0,0,33,26484,0,0,0,0,0,7,0,0,0,0,0,0,0,'Hugh Glass - On Script - Quest Credit'),
(26484*100,9,6,0,0,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Hugh Glass - On Script - Add Gossip & Quest Flags');
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9484 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES
(9484, 0, 0, 'Calm down, I want to ask you about the Iron Dwarves and Loken.', 1, 1, 0, 0, 0, 0, NULL);
-- NPC talk text insert from sniff
DELETE FROM `creature_text` WHERE `entry`=26484;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`TEXT`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26484,0,0,'He\'s out to get me, too! I\'d be careful around here if I was you, traveler. You never know which tree he\'s hiding behind!',12,0,100,0,0,0,'Hugh Glass'),
(26484,1,0,'That\'s not something Limpy Joe would ask! But yeah, I know Loken.',12,0,100,0,0,0,'Hugh Glass');
-- Add gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9484;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`) VALUES
(15,9484,0,9,12204);

-- Questfix 12032 - Conversing with the depths / Gespräche mit den Tiefen, closes #445
-- Step 1: Create missing event linked from the gameobject (188422).
DELETE FROM `event_scripts` WHERE `id`=17612;
INSERT INTO `event_scripts`(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(17612,0,10,26648,45000,0,2447.308883,1609.395996,4.827743,1.196764);
-- Step 2:
-- Remove dependancy to a non-existing area-trigger.
-- Switch quest-needs to a single kill-credit for Oacha'noa.
UPDATE `quest_template` SET  `ReqCreatureOrGOId1`=26648,`ReqCreatureOrGOCount1`=1,`QuestFlags`=136,`SpecialFlags`=0 WHERE `entry`=12032;
-- Step 3: Activate Oacha'noa 's gossip.
UPDATE `creature_template` SET `gossip_menu_id`=26648,`npcflag`=1,`AIName`='SmartAI' WHERE `entry`=26648;
-- Step 4: Create gossip for the talk with Oacha'noa.
DELETE FROM `gossip_menu` WHERE `entry`=26648;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES (26648, 1);
DELETE FROM `gossip_menu_option` WHERE `menu_id`=26648;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)
VALUES(26648,1,0,'Oacha\'noa, the Kalu\'ak need your help, and I am here to pray for it.',1,1,0,0,0,0,NULL);
-- Step 5: Create scripts for the gossip.
DELETE FROM `smart_scripts` WHERE `entryorguid`=26648;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26648, 0, 0, 1, 62, 0, 100, 0, 26648, 1, 0, 0, 33, 26648, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Oacha\'noa - Grant kill credit'),
(26648, 0, 1, 0, 62, 0, 100, 0, 26648, 1, 0, 0, 84, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oacha\'noa - Yell');
-- Step 6: Create text for Oacha'noa 's call-out.
DELETE FROM `creature_text` WHERE `entry`=26648 AND `groupid`=0 AND `id`=0;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(26648, 0, 0, 'The Kalu\'ak know what has be done, and you know either. So do it, or the tortured souls will destroy everything you are fighting for.', 14, 0, 100, 0, 0, 0, 'Oacha\'noa - Quest text');

-- Fix creature 18707 Torgos: Remove OOC_NOT_ATTACKABLE flag, closes #493
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 18707;

-- Fix quest 11466 Jack Likes His Drink / Jack hebt gern' mal einen, closes #304
-- Add item 34116 Jack Adams' Debt / Jack Adams Schulden to loot
-- of creature 24788 Jack Adams
DELETE FROM `creature_loot_template` WHERE `entry` = 24788 AND `item` = 34116;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(24788, 34116, -100, 1, 0, 1, 1);

-- Fix questchain, closes #509
-- Quest 11157 The Clutches of Evil / Das Gelege des Bösen will now require
-- quest 11475 Tools to Get the Job Done / Das nötige Werkzeug für den Job instead of
-- quest 11501 News From the East / Neues aus dem Osten
-- people won't get sent to Westguard Keep but still the quests over there will be completable.
-- remove NextQuestId depency from old prequest
UPDATE `quest_template` SET `NextQuestId` = 0 WHERE `entry` = 11501;
-- and set PrevQuestId for the new one
UPDATE `quest_template` SET `PrevQuestId` = 11475 WHERE `entry` = 11157;

-- Fix loot item 38551 Drakkari Offerings / Drakkariopfergaben should drop independently of quests, closes #511
-- keep chance, just remove the quest relationship from item drop
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = ABS(`ChanceOrQuestChance`) WHERE `item` = 38551;

-- Fix quest 13654 Etwas ist mit dem Knappen / There's Something About the Squire, closes #512
-- Source: https://github.com/TrinityCore/TrinityCore/commit/e38453991bea16a021cb6c5cfc057caf321fc44a
-- add quest item to Skeletal Woodcutter
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=33499;
DELETE FROM `creature_loot_template` WHERE `entry`=33499;
INSERT INTO `creature_loot_template` VALUES
(33499,45080,-100,1,0,1,1); -- 100% drop
-- set visual effects on the skeletons
DELETE FROM `creature_template_addon` WHERE `entry`=33499;
INSERT INTO `creature_template_addon` (`entry`,`emote`) VALUES
(33499,234); -- chopping wood
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=33498;
DELETE FROM `smart_scripts` WHERE `entryorguid`=33498 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(33498,0,0,0,23,0,100,0,63124,1,0,0,81,16777216,0,0,0,0,0,1,0,0,0,0,0,0,0,'Maloric - on Aura: Incapacitate Maloric - set npcflag: Spellclick'),
(33498,0,1,0,23,0,100,0,63124,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Maloric - on NoAura: Incapacitate Maloric - set npcflag: none');
-- conditions for Large Femur and Maloric
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=45080;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=63126;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,45080,0,24,1,33498,0,0,'','Item:Large Femur only target Maloric'),
(17,0,63126,0,9,13654,0,0,0,'','Needs taken Quest 13654 to perform Spell: Search Maloric');
-- cast search Maloric, get quest item, quest completed
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=33498;
INSERT INTO `npc_spellclick_spells` VALUES
(33498,63126,13654,1,13654,2,0,0,0);

-- Fix creature 30081 Efrem the Faithful / Efrem der Getreue, remove ooc unattackable flag, closes #514
UPDATE `creature_template` SET `unit_flags` = 32768 WHERE `entry` = 30081;

-- Fix creature 9699 Fire Beetle / Feuerkäfer, remove wrong reputation gain for thrallmar 947 / honor hold 946, closes #522
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 9699;

-- Fix creatures Krallenpriester Ishaal / Talonpriest Ishaal / Krallenpriester Skizzik / Talonpriest Skizzik
-- Krallenpriester Zellek / Talonpriest Zellek 23066 23067 23068, closes #518
-- Set faction from 1860 to 1862, so they become attackable for players
UPDATE `creature_template` SET `faction_A` = 1862, `faction_H` = 1862 WHERE `entry` IN (23066, 23067, 23068);

-- Remove two inactive and duplicate quests Troll Patrol / Trollpatrouille 12501, 12563 from start/end tables, closes #537
DELETE FROM `creature_involvedrelation` WHERE `quest` IN (12501, 12563);
DELETE FROM `creature_questrelation` WHERE `quest` IN (12501, 12563);

-- Bugfix for quest 11887 (Emergency Supplies / Notrationen) and 11795 (Emergency Protocol: Section 8.2, Paragraph C / Notfallprotokoll: Sektion 8,2. Absatz C), closes #533, #579
-- Both are now working using SmartAI.
-- @DorianGrey: This fix is based upon TDB42. It's a reimplementation of the former fix that used gossip-scripts.
-- Update NPC-template - missing flag for enabling gossip.
UPDATE `creature_template` SET `npcflag`= 1, `AIName` = 'SmartAI' WHERE `entry` = 25841;
-- Add the missing gossip-entry -> id=0=>Horde-Quest, id=1=>Ally-Quest
DELETE FROM `gossip_menu_option` WHERE `menu_id`= 21248;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(21248, 0, 0, 'Search the body for the pilot\'s emergency toolkit.', 1, 1, 0, 0, 0, 0, ''),
(21248, 1, 0, 'Search the body for the pilots insignia.', 1, 1, 0, 0, 0, 0, '');
-- Update conditions:
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 21248;
INSERT INTO `conditions`(`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`)VALUES
(15, 21248, 0, 0, 9, 11887, 0, 0, 0, '', 'Gossip Option 21248 only available to Horde players with quest 11887 active'),
(15, 21248, 1, 0, 9, 11795, 0, 0, 0, '', 'Gossip Option 21248 only available to Alliance players with quest 11795 active');
-- Create new smart-ai-scripts. The old ones relied on a spellcast, which is far more complicated than necessary for this quest.
-- Delete old smart_scripts.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25841;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25841, 0, 0, 1, 62, 0, 100, 0, 21248, 0, 0, 0, 56, 35276, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzlecrank Recon Pilot - Give emergency kit on gossip selection (Horde Q)'),
(25841, 0, 1, 0, 62, 0, 100, 0, 21248, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fizzlecrank Recon Pilot - Despawn after spending emergency kit (Horde Q)'),
(25841, 0, 2, 3, 62, 0, 100, 0, 21248, 1, 0, 0, 56, 35126, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzlecrank Recon Pilot - Give insignia on gossip selection (Alliance Q)'),
(25841, 0, 3, 0, 62, 0, 100, 0, 21248, 1, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fizzlecrank Recon Pilot - Despawn after spending insignia (Alliance Q)');

-- Bugfix for Maim / Bash / Hammer of Justice / Hammer der Gerechtigkeit / Hieb / Zerfleddern, closes #521
-- @DorianGrey, 2011/10/06
-- All of these spells should interrupt spellcasting on NPCs.
-- At the moment, this is only possible if those are not immune to stun, but the interrupt should also work on those who are.
-- Therefore, we are using the appropriate spell "Interrupt" (id 32747) for all of these spells and their ranks.
-- Maybe this could be combined with spell_ranks ? As I'm not sure about it, I've inserted all ranks of the spells manually.
-- Step 1: Delete propably old entries.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (22570,49802,5211,6798,8983,853,5588,5589,10308) AND `spell_effect` = 32747;
-- Step 2: Insert the new links.
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(5211, 32747, 0, 'Bash (Feral) - Interrupt Effect on Rank 1'),
(6798, 32747, 0, 'Bash (Feral) - Interrupt Effect on Rank 2'),
(8983, 32747, 0, 'Bash (Feral) - Interrupt Effect on Rank 3'),
(853, 32747, 0, 'Hammer of Justice - Interrupt Effect on Rank 1'),
(5588, 32747, 0, 'Hammer of Justice - Interrupt Effect on Rank 2'),
(5589, 32747, 0, 'Hammer of Justice - Interrupt Effect on Rank 3'),
(10308, 32747, 0, 'Hammer of Justice - Interrupt Effect on Rank 4'),
(22570, 32747, 0, 'Maim (Feral) - Interrupt Effect on Rank 1'),
(49802, 32747, 0, 'Maim (Feral) - Interrupt Effect on Rank 2');
-- Step 3: Add condition for only targetting any creature - interrupt should not apply to players
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `ConditionTypeOrReference` = 19 AND `SourceEntry` = 32747;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 32747, 0, 19, 0, 0, 0, 0, '', 'Interrupt can only target any creature - NEEDS CORE SUPPORT!');

-- Insert some more missing player faction change / Fraktionswechsel data, closes #625
-- argent tournament achievements
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (2781, 2764, 2780, 2763, 2777, 2760, 2778, 2761, 2779, 2762, 3676, 2782, 2817);
INSERT INTO `player_factionchange_achievement` (`alliance_id`, `horde_id`) VALUES
(2781, 2783), -- Champion of Stormwind/Orgrimmar
(2764, 2765), -- Exalted [...]
(2780, 2786), -- Champion of Ironforge/Thunder Bluff
(2763, 2768), -- Exalted [...]
(2777, 2787), -- Champion of Darnassus/Undercity
(2760, 2769), -- Exalted [...]
(2778, 2786), -- Champion of Exodar/Silvermoon
(2761, 2767), -- Exalted [...]
(2779, 2784), -- Champion of Gnomeregan/Senjin
(2762, 2766), -- Exalted [...]
(3676, 3677), -- The Silver Covenant / The Sunreavers
(2782, 2788), -- Champion of the Alliance / Champion of the Horde
(2817, 2816); -- Exalted [...]
-- exchange alliance/horde mount from vault of archavon (item + spell)
DELETE FROM `player_factionchange_items` WHERE `alliance_id` = 43959 AND `horde_id` = 44083;
INSERT INTO `player_factionchange_items` (`race_A`, `alliance_id`, `commentA`, `race_H`, `horde_id`, `commentH`) VALUES
(0, 43959, 'Reins of the Grand Black War Mammoth(40)', 0, 44083, 'Reins of the Grand Black War Mammoth(40)');
DELETE FROM `player_factionchange_spells` WHERE `alliance_id` = 61465 AND `horde_id` = 61467;
INSERT INTO `player_factionchange_spells` (`alliance_id`, `horde_id`) VALUES
(61465, 61467);

-- Fix quest Guided by honor / Von Ehre geleitet (11289), closes #143, #624, #320
-- @DorianGrey
-- (1) Re-fixed the special-flags that indicated a quest-completion through a script.
-- (2) Added a start-script that fulfills this.
UPDATE `quest_template` SET `SpecialFlags`= 2, `StartScript` = 11289 WHERE `entry` = 11289;
-- Remove potentially existing entrys.
DELETE FROM `quest_start_scripts` WHERE `id` = 11289;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(11289, 0, 7, 11289, 30, 0, 0, 0, 0, 0);

-- More pool data for Shattrath City, closes #595
-- Shattrath Cooking Daily Pool
-- 11380, 11377, 11379, 11381
DELETE FROM `pool_template` WHERE `entry` = 11377;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(11377, 1, 'Shattrath Cooking Daily (1 of 4)');
DELETE FROM `pool_quest` WHERE `entry` IN (11380, 11377, 11379, 11381) AND `pool_entry` = 11377;
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(11380, 11377, 'Manalicious'),
(11377, 11377, 'Revenge is Tasty'),
(11381, 11377, 'Soup for the Soul'),
(11379, 11377, 'Super Hot Stew');
-- Shattrath Fishing Daily Pool
-- 11667, 11668, 11666, 11665, 11669
DELETE FROM `pool_template` WHERE `entry` = 11665;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(11665, 1, 'Shattrath Fishing Daily (1 of 5)');
DELETE FROM `pool_quest` WHERE `entry` IN (11667, 11668, 11666, 11665, 11669) AND `pool_entry` = 11665;
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(11667, 11665, 'The One That Got Away'),
(11668, 11665, 'Shrimpin\' Ain\'t Easy'),
(11666, 11665, 'Bait Bandits'),
(11665, 11665, 'Crocolisks in the City'),
(11669, 11665, 'Felblood Filet');

-- Fix loot of item 20393 Treat Bag, Schlotterbeutel closes #648
DELETE FROM `reference_loot_template` WHERE `entry` = 10024;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
-- group 0
(10024, 37606, 10, 1, 0, 1, 1), -- Penny Pouch
(10024, 37604, 10, 1, 0, 10, 10), -- Tooth Pick
(10024, 20390, 9, 1, 0, 4, 6), -- Candy Bar
(10024, 20388, 9, 1, 0, 4, 6), -- Lollipop
(10024, 20389, 8, 1, 0, 4, 6), -- Candy Corn
(10024, 37585, 8, 1, 0, 4, 6), -- Chewy Fel Taffy
(10024, 37584, 8, 1, 0, 4, 6), -- Soothing Spearmint Candy
(10024, 37583, 8, 1, 0, 4, 6), -- G.N.E.R.D.S.
(10024, 37582, 8, 1, 0, 4, 6), -- Pyroblast Cinnamon Ball
-- group 1 (pets)
(10024, 33292, 6, 1, 1, 1, 1), -- Hallowed Helm
(10024, 33154, 5, 1, 1, 1, 1), -- Sinister Squashling
-- group 2 (wands)
(10024, 20410, 3, 1, 2, 1, 1), -- Bat
(10024, 20409, 3, 1, 2, 1, 1), -- Ghost
(10024, 20399, 3, 1, 2, 1, 1), -- Leper Gnome
(10024, 20397, 3, 1, 2, 1, 1), -- Pirate
(10024, 20411, 3, 1, 2, 1, 1), -- Skeleton
(10024, 20414, 3, 1, 2, 1, 1), -- Wisp
(10024, 20398, 2, 1, 2, 1, 1), -- Ninja
-- group 3 (masks)
(10024, 20567, 2.0, 1, 3, 1, 1), -- troll female
(10024, 20392, 2.0, 1, 3, 1, 1), -- gnome female
(10024, 20562, 2.0, 1, 3, 1, 1), -- dwarf female
(10024, 20565, 2.0, 1, 3, 1, 1), -- human female
(10024, 34001, 2.0, 1, 3, 1, 1), -- draenai female
(10024, 20573, 2.0, 1, 3, 1, 1), -- undead male
(10024, 20561, 2.0, 1, 3, 1, 1), -- dwarf male
(10024, 20570, 2.0, 1, 3, 1, 1), -- orc male
(10024, 20564, 2.0, 1, 3, 1, 1), -- night elf male
(10024, 20572, 2.0, 1, 3, 1, 1), -- tauren male
(10024, 20563, 2.0, 1, 3, 1, 1), -- night elf female
(10024, 20568, 2.0, 1, 3, 1, 1), -- troll male
(10024, 20574, 2.0, 1, 3, 1, 1), -- undead female
(10024, 20566, 2.0, 1, 3, 1, 1), -- human male
(10024, 20569, 2.0, 1, 3, 1, 1), -- orc female
(10024, 20571, 2.0, 1, 3, 1, 1), -- tauren female
(10024, 34002, 2.0, 1, 3, 1, 1), -- blood elf male
(10024, 34000, 2.0, 1, 3, 1, 1), -- blood elf female
(10024, 34003, 2.0, 1, 3, 1, 1), -- draenai male
(10024, 20391, 2.0, 1, 3, 1, 1); -- gnome male

-- Fix creature 34800, 35442, 35443, 35441 Schneeboldvasall / Snobold Vassal, set correct level
UPDATE `creature_template` SET `minlevel` = 82, `maxlevel` = 82 WHERE entry IN (34800, 35442, 35443, 35441);

-- Fix for the arena-quest-chain Die Siegeswallgrube / The Conquest Pit in Grizzly Hills, closes #515
-- Remove all event-based things, they simply didn't work in any way. It's much easier this way :)
-- Step 1: Update quest templates.
UPDATE `quest_template` SET `SpecialFlags` = 0, `ReqCreatureOrGOId1` = 27715, `ReqCreatureOrGOCount1` = 1, `StartScript` = 12427 WHERE `entry` = 12427;
UPDATE `quest_template` SET `SpecialFlags` = 0, `ReqCreatureOrGOId1` = 27716, `ReqCreatureOrGOCount1` = 1, `StartScript` = 12428 WHERE `entry` = 12428;
UPDATE `quest_template` SET `SpecialFlags` = 0, `ReqCreatureOrGOId1` = 27717, `ReqCreatureOrGOCount1` = 1, `StartScript` = 12429 WHERE `entry` = 12429;
UPDATE `quest_template` SET `SpecialFlags` = 0, `ReqCreatureOrGOId1` = 27718, `ReqCreatureOrGOCount1` = 1, `StartScript` = 12430 WHERE `entry` = 12430;
UPDATE `quest_template` SET `SpecialFlags` = 0, `ReqCreatureOrGOId1` = 27727, `ReqCreatureOrGOCount1` = 1, `StartScript` = 12431 WHERE `entry` = 12431;
-- Step 2: Create the quest-start-scripts. They simply summon the combatant. Since the quest is offered to the whole group when taken, this already avoid duplicated spawns.
DELETE FROM `quest_start_scripts` WHERE `id` IN (12427, 12428, 12429, 12430, 12431);
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(12427, 2, 10, 27715, 180000, 0, 3250.152588, -2336.137939, 92.118881, 1.056488),
(12428, 2, 10, 27716, 180000, 0, 3250.152588, -2336.137939, 92.118881, 1.056488),
(12429, 2, 10, 27717, 180000, 0, 3250.152588, -2336.137939, 92.118881, 1.056488),
(12430, 2, 10, 27718, 180000, 0, 3250.152588, -2336.137939, 92.118881, 1.056488),
(12431, 2, 10, 27727, 180000, 0, 3250.152588, -2336.137939, 92.118881, 1.056488);
-- Step 3: Update the creature templates. Some of them have been friendly...
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` IN (27715, 27716, 27717, 27718, 27727);

-- Fix NPC 21815, Cleric of Karabor / Kleriker von Karabor - set faction from 1822 to 16 for creature to get them attackable, closes #517
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 21815;

-- Fix NPC 21264 Seeping Ooze / Sickerschlick - set faction to 16 (Montser) to get it attackable, closes #569
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 21264;

-- Event: Day of the Dead / Tag der Toten fixes, closes #684, #685
-- spawn event npcs
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (34382,34383,35256,35254));
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (34382,34383,35256,35254));
DELETE FROM `creature` WHERE `id` IN (34382,34383,35256,35254);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(34382, 0, 1, 1, 0, 0, -9334.37, 182.592, 61.5152, 4.18653, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 0, 1, 1, 0, 0, 1832.02, 208.17, 60.1884, 2.01563, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 530, 1, 1, 0, 0, -1789.75, 4932.35, -22.2325, 2.87687, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 530, 1, 1, 0, 0, 9416.49, -6851.74, 14.9969, 2.857, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 571, 1, 1, 0, 0, 5854.87, 765.859, 641.536, 3.76057, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 1, 1, 1, 0, 0, 1180.74, -4466.57, 21.3336, 1.07584, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 0, 1, 1, 0, 0, -5166.81, -878.786, 507.34, 0.876024, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 1, 1, 1, 0, 0, 10052.7, 2108.52, 1329.65, 1.78829, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34382, 530, 1, 1, 0, 0, -4320.23, -12437.3, 17.6771, 5.2661, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 0, 1, 1, 0, 0, 1828.87, 206.912, 59.979, 1.92924, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 571, 1, 1, 0, 0, 5853, 766.766, 641.264, 3.79748, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 0, 1, 1, 0, 0, -9330.14, 182.244, 61.6484, 4.16297, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 530, 1, 1, 0, 0, -1791.77, 4927.84, -22.0996, 2.90828, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 530, 1, 1, 0, 0, 9414.95, -6854.79, 14.8663, 2.50357, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 1, 1, 1, 0, 0, 1177.84, -4463.27, 21.3632, 1.03657, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 0, 1, 1, 0, 0, -5168.26, -875.948, 507.237, 0.715017, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 1, 1, 1, 0, 0, 10050.4, 2107.58, 1329.65, 1.64692, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(34383, 530, 1, 1, 0, 0, -4317.7, -12435.9, 17.6639, 5.25432, 300, 0, 0, 12600, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4312.65, -12438.2, 17.1094, 5.5567, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4308.54, -12433.4, 16.9223, 5.58419, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4314.56, -12429.1, 17.4271, 5.37998, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4309.29, -12427.4, 17.147, 5.58419, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10052.3, 2126.18, 1330.14, 2.42603, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10057.7, 2118.67, 1329.74, 3.09755, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10050.1, 2114.34, 1329.74, 2.93262, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10045.7, 2111.7, 1329.66, 2.25325, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10045.1, 2116.66, 1329.7, 2.25717, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4313.28, -12433.8, 17.1962, 5.32893, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1835.61, 207.184, 60.4635, 1.94966, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4318.31, -12440.4, 17.4721, 5.48994, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4316.94, -12444.7, 17.185, 5.53706, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4326.71, -12445.2, 17.2612, 4.79094, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4322.66, -12443.3, 17.2871, 5.14437, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4322.94, -12450.5, 16.8562, 4.91268, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4312.08, -12447.2, 17.4606, 5.33679, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -4317.66, -12450.1, 17.3148, 5.13652, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10054.2, 2120.75, 1329.96, 3.26641, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10058.2, 2127.63, 1329.66, 3.32139, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10063.5, 2126.02, 1329.66, 2.73627, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10062.3, 2119.87, 1329.66, 2.97974, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10059.8, 2114.96, 1329.66, 2.56741, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 10059.9, 2110.46, 1329.65, 2.25718, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5162.94, -874.298, 507.219, 0.820251, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5161.5, -873.015, 507.263, 0.859519, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5165.61, -872.202, 507.001, 1.09514, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 571, 1, 1, 0, 0, 5856.95, 766.282, 641.303, 3.60899, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 571, 1, 1, 0, 0, 5852.45, 772.412, 640.818, 4.34333, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5168.41, -870.759, 506.604, 1.09514, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5163.48, -870.186, 507.081, 1.00089, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5161.21, -875.98, 507.295, 1.03231, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5161.2, -881.148, 507.277, 1.5703, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5159.04, -876.208, 507.403, 1.58601, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 571, 1, 1, 0, 0, 5860.8, 766.14, 640.703, 3.66004, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -5164.16, -878.494, 507.29, 0.777052, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 1173.97, -4460.83, 21.4419, 1.15595, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 1183.17, -4468.67, 21.2838, 1.27768, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 1186.09, -4464.55, 21.2288, 1.32481, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 1188.18, -4461.08, 21.2119, 0.912472, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 571, 1, 1, 0, 0, 5854.83, 762.7, 641.099, 3.64434, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 571, 1, 1, 0, 0, 5859.75, 762.455, 640.624, 3.69146, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 1183.45, -4457.5, 21.3235, 0.943888, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 1178.06, -4454.25, 21.5348, 1.03813, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 1, 1, 1, 0, 0, 1177.17, -4460.06, 21.4376, 1.08133, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, 9415.06, -6845.79, 15.504, 2.40225, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, 9414.51, -6848.9, 15.1628, 2.70463, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, 9410.27, -6849.11, 15.327, 2.72819, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, 9411.46, -6852.36, 15.032, 2.71248, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 571, 1, 1, 0, 0, 5853.24, 768.719, 641.16, 3.68832, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 571, 1, 1, 0, 0, 5849.14, 769.914, 640.629, 3.87289, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, 9408.35, -6852.1, 15.1901, 2.69677, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, 9410.97, -6857.13, 14.7513, 2.72819, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, 9414.54, -6857.1, 14.7651, 2.64965, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -1794.32, 4935.35, -22.3583, 2.87294, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -1784.34, 4932.84, -22.4544, 3.08499, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -1789.71, 4937.96, -22.5818, 2.65695, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -1794.43, 4930.79, -22.2304, 2.57056, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -1795.88, 4928.06, -22.2072, 2.6923, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -1793.74, 4923.17, -21.6932, 2.59805, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 530, 1, 1, 0, 0, -1789.84, 4925.19, -21.7673, 2.68051, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1820.56, 207.093, 60.0095, 2.03998, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1824.69, 208.967, 60.0613, 2.03998, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1828.23, 210.597, 60.2566, 2.00856, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1832.88, 211.425, 60.3653, 1.83185, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1834.7, 215.117, 60.1636, 1.78865, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1825.53, 212.591, 60.2337, 1.86719, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1829.87, 213.916, 60.4118, 1.76116, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1821.81, 201.32, 73.3536, 1.56873, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1831.88, 199.262, 70.8723, 1.76508, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1835.27, 201.766, 73.3538, 2.05175, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, 1838.34, 209.78, 70.9343, 2.78217, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9330.38, 176.373, 61.7013, 4.18338, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9330.38, 176.373, 61.7013, 4.1873, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9335.71, 177.378, 61.602, 4.30904, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9334.67, 172.288, 61.5957, 4.27762, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9329.25, 167.76, 61.5994, 4.30511, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9321.91, 168.646, 61.6105, 4.1284, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9320.71, 174.485, 61.6464, 4.19123, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9324.67, 171.948, 61.6356, 4.17159, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9338.78, 182.05, 61.5502, 4.19908, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9340.89, 174.48, 61.5574, 4.07734, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9334.86, 163.566, 61.5597, 4.21479, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9329.27, 162.752, 61.8863, 4.14018, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9340.97, 168.514, 61.5587, 4.36401, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9345.92, 170.275, 61.5587, 4.37579, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9348.82, 174.894, 61.9821, 5.74238, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9341.32, 186.539, 61.5586, 4.45826, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35254, 0, 1, 1, 0, 0, -9343, 180.778, 61.5582, 4.51717, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 530, 1, 1, 0, 0, -4318.55, -12432.4, 17.8458, 5.48208, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 1, 1, 1, 0, 0, 10055, 2113.75, 1329.71, 2.18256, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 0, 1, 1, 0, 0, -5166.09, -875.999, 507.214, 0.753491, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 1, 1, 1, 0, 0, 1181.51, -4462.37, 21.2609, 1.04991, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 530, 1, 1, 0, 0, 9417.04, -6853.77, 14.9208, 2.82637, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 571, 1, 1, 0, 0, 5856.42, 768.523, 641.308, 3.73151, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 530, 1, 1, 0, 0, -1787.97, 4928.36, -22.06, 2.49595, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 0, 1, 1, 0, 0, 1824.08, 205.428, 59.8915, 1.46271, 300, 0, 0, 42, 0, 0, 0, 0, 0),
(35256, 0, 1, 1, 0, 0, -9325.73, 176.683, 61.6831, 4.14411, 300, 0, 0, 42, 0, 0, 0, 0, 0);
-- make them daaaaance!
DELETE FROM `creature_template_addon` WHERE `entry` IN (35254, 34383, 35256);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(35254, 0, 0, 0, 0, 10, '30628'), -- Ghostly Dalaran Celebrant
(35256, 0, 0, 0, 0, 0, '30628'), -- Cheerful Dalaran Spirit
(34383, 0, 0, 0, 0, 10, NULL); -- Catrina
-- link to event
INSERT INTO `game_event_creature` (`eventEntry`, `guid`)
SELECT 51, `guid`FROM `creature` WHERE `id` IN (34382,34383,35256,35254);
-- update quest text, fill in the gaps from wowwiki
UPDATE `quest_template` SET `OfferRewardText` = 'Ah, more delicious Bread of the Dead, thank you! Please, take this in return... a little something fun for the holiday.', `RequestItemsText` = 'You don''t have any Bread of the Dead, do you?' WHERE `entry` = 14166;
-- spawn gameobject 195087 Ghostly Cooking Fire
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 195087);
DELETE FROM `gameobject` WHERE `id` = 195087;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(195087, 571, 1, 1, 5853.54, 765.452, 641.404, 4.09089, 0, 0, 0.889453, -0.457026, 300, 0, 1),
(195087, 0, 1, 1, -9331.94, 183.193, 61.5498, 1.0512, 0, 0, 0.501734, 0.865022, 300, 0, 1),
(195087, 0, 1, 1, -5169.11, -878.781, 507.556, 3.6092, 0, 0, 0.972792, -0.231678, 300, 0, 1),
(195087, 0, 1, 1, 1831.28, 206.094, 60.0615, 5.25619, 0, 0, 0.491228, -0.871031, 300, 0, 1),
(195087, 530, 1, 1, 9418.35, -6856.12, 14.8843, 2.67478, 0, 0, 0.972885, 0.231291, 300, 0, 1),
(195087, 1, 1, 1, 1178.59, -4466.77, 21.3298, 4.3431, 0, 0, 0.824911, -0.565263, 300, 0, 1),
(195087, 530, 1, 1, -4323.28, -12440.2, 17.468, 2.61852, 0, 0, 0.965994, 0.258565, 300, 0, 1),
(195087, 530, 1, 1, -1785.04, 4935.12, -22.5792, 0.617283, 0, 0, 0.303765, 0.952747, 300, 0, 1),
(195087, 1, 1, 1, 10063.1, 2112.13, 1329.66, 5.3697, 0, 0, 0.441026, -0.897494, 300, 0, 1);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`)
SELECT 51, `guid` FROM `gameobject` WHERE `id` = 195087;

-- Fix Ashen Verdikt, Äschernes Verdikt faction reputation ring change, closes #588
UPDATE `quest_template` SET `PrevQuestId`=0 WHERE `entry` IN
-- Paths
(24827,24834,24835,24823,24828,24829,25239,25240,25242,24826,24832,24833,24825,24830,24831,
-- A Change of Heart
24819,24820,24821,24822,24836,24837,24838,24839,24840,24841,24842,24843,24844,24845,24846,24847,25246,25247,25248,25249);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry` IN
-- Paths
(24827,24834,24835,24823,24828,24829,25239,25240,25242,24826,24832,24833,24825,24830,24831,
-- A Change of Heart
24819,24820,24821,24822,24836,24837,24838,24839,24840,24841,24842,24843,24844,24845,24846,24847,25246,25247,25248,25249);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`Comment`) VALUES
-- Path of Courage
(19,0,24827,0,2,50375,1,0,'Path of Courage 1'),
(19,0,24834,0,2,50388,1,0,'Path of Courage 2'),
(19,0,24835,0,2,50403,1,0,'Path of Courage 3'),
-- Path of Destruction
(19,0,24823,0,2,50384,1,0,'Path of Destruction 1'),
(19,0,24828,0,2,50377,1,0,'Path of Destruction 2'),
(19,0,24829,0,2,50397,1,0,'Path of Destruction 3'),
-- Path of Might
(19,0,25239,0,2,52569,1,0,'Path of Might 1'),
(19,0,25240,0,2,52570,1,0,'Path of Might 2'),
(19,0,25242,0,2,52571,1,0,'Path of Might 3'),
-- Path of Vengeance
(19,0,24826,0,2,50376,1,0,'Path of Vengeance 1'),
(19,0,24832,0,2,50387,1,0,'Path of Vengeance 2'),
(19,0,24833,0,2,50401,1,0,'Path of Vengeance 3'),
-- Path of Wisdom
(19,0,24825,0,2,50378,1,0,'Path of Wisdom 1'),
(19,0,24830,0,2,50386,1,0,'Path of Wisdom 2'),
(19,0,24831,0,2,50399,1,0,'Path of Wisdom 3'),
-- A Change of Heart
(19,0,24819,0,2,50377,1,0,'A Change of Heart'),
(19,0,24820,0,2,50376,1,0,'A Change of Heart'),
(19,0,24821,0,2,50375,1,0,'A Change of Heart'),
(19,0,24822,0,2,50378,1,0,'A Change of Heart'),
(19,0,24836,0,2,50384,1,0,'A Change of Heart'),
(19,0,24837,0,2,50386,1,0,'A Change of Heart'),
(19,0,24838,0,2,50387,1,0,'A Change of Heart'),
(19,0,24839,0,2,50388,1,0,'A Change of Heart'),
(19,0,24840,0,2,50397,1,0,'A Change of Heart'),
(19,0,24841,0,2,50399,1,0,'A Change of Heart'),
(19,0,24842,0,2,50401,1,0,'A Change of Heart'),
(19,0,24843,0,2,50403,1,0,'A Change of Heart'),
(19,0,24844,0,2,50398,1,0,'A Change of Heart'),
(19,0,24845,0,2,50400,1,0,'A Change of Heart'),
(19,0,24846,0,2,50402,1,0,'A Change of Heart'),
(19,0,24847,0,2,50404,1,0,'A Change of Heart'),
(19,0,25246,0,2,52572,1,0,'A Change of Heart'),
(19,0,25247,0,2,52569,1,0,'A Change of Heart'),
(19,0,25248,0,2,52570,1,0,'A Change of Heart'),
(19,0,25249,0,2,52571,1,0,'A Change of Heart');

-- Add some more faction change data, closes #666
-- World Event
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (2144,1707,2797,1038,1656,1684,1692) AND `horde_id` IN (2145,1693,2798,1039,1657,1683,1691);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(2144,2145),    -- What A Long, Strange Trip It's Been
(1707,1693),    -- Fool For Love
(2797,2798),    -- Noble Gardener
(1038,1039),    -- The Flame Warden / Keeper
(1656,1657),    -- Hallowed Be Thy Name
(1684,1683),    -- Brewmaster
(1692,1691);    -- Merrymaker
-- World Event: Hallow's End
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (963,966,969,970,1040) AND `horde_id` IN (971,967,965,968,1041);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(970,971),      -- Tricks and Treats of Azeroth
(966,967),      -- Tricks and Treats of Eastern Kingdoms
(963,965),      -- Tricks and Treats of Kalimdor
(969,968),      -- Tricks and Treats of Outland
(1040,1041);    -- Rotten Hallow
-- World Event: Love is in the Air
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (1280,1697) AND `horde_id` IN (1279,1698);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(1280,1279),    -- Flirt With Disaster
(1697,1698);    -- Nation of Adoration
-- World Event: Noblegarden
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (2421,2419) AND `horde_id` IN (2420,2497);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(2421,2420),    -- Noble Garden
(2419,2497);    -- Spring Fling
-- World Event: Midsummer Fire Festival
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (1035,1028,1029,1030,1022,1023,1024,1034) AND `horde_id` IN (1037,1031,1032,1033,1025,1026,1027,1036);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(1035,1037),    -- Desecration of the Alliance / Horde
(1028,1031),    -- Extinguishing Eastern Kingdoms
(1029,1032),    -- Extinguishing Kalimdor
(1030,1033),    -- Extinguishing Outland
(1022,1025),    -- Flame Warden / Keeper of Eastern Kingdoms
(1023,1026),    -- Flame Warden / Keeper of Kalimdor
(1024,1027),    -- Flame Warden / Keeper of Outland
(1034,1036);    -- The Fires of Azeroth
-- World Event: Brewfest
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (1184) AND `horde_id` IN (1203);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(1184,1203);    -- Strange Brew
-- World Event: Pilgrim's Bounty
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (3576,3556,3580,3596) AND `horde_id` IN (3577,3557,3581,3597);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(3576,3577),    -- Now We're Cookin'
(3556,3557),    -- Pilgrim's Paunch
(3580,3581),    -- Pilgrim's Peril
(3596,3597);    -- Pilgrim's Progress
-- World Event: Feast of Winter Veil
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (4436,1686,1255) AND `horde_id` IN (4437,1685,259);
INSERT INTO `player_factionchange_achievement` (`alliance_id`,`horde_id`) VALUES
(4436,4437),    -- BB King
(1686,1685),    -- Bros. Before Ho Ho Ho's
(1255,259);     -- Scrooge

-- Fix some questchain relations, closes #497
-- Quests 13105, 13104 Once More Unto The Breach, Hero / Noch einmal in die Bresche, Held opens 4 quests...
-- Notice: One for Deathknights 13105 and every other class 13104
UPDATE `quest_template` SET `ExclusiveGroup` = 13104 WHERE `entry` IN (13104, 13105);
-- Conditions for quests
-- The Scourgestone / Der Geißelstein (13122)
-- The Purging Of Scourgeholme / Die Reinigung von Geißelholme (13118)
-- The Stone That Started A Revolution / Der Stein, der eine Revolution auslöste (13130)
-- The Restless Dead / Die rastlosen Toten (13110)
-- It Could Kill Us All / Es könnte uns alle umbringen (13135)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (13122, 13118, 13130, 13110, 13135);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13122, 0, 8, 13104, 0, 0, 0, '', 'Quest: The Scourgestone depending on quest 13104 or 13105'),
(19, 0, 13122, 1, 8, 13105, 0, 0, 0, '', 'Quest: The Scourgestone depending on quest 13104 or 13105'),
(19, 0, 13118, 0, 8, 13104, 0, 0, 0, '', 'Quest: The Purging Of Scourgeholme depending on quest 13104 or 13105'),
(19, 0, 13118, 1, 8, 13105, 0, 0, 0, '', 'Quest: The Purging Of Scourgeholme depending on quest 13104 or 13105'),
(19, 0, 13130, 0, 8, 13104, 0, 0, 0, '', 'Quest: The Stone That Started A Revolution depending on quest 13104 or 13105'),
(19, 0, 13130, 1, 8, 13105, 0, 0, 0, '', 'Quest: The Stone That Started A Revolution depending on quest 13104 or 13105'),
(19, 0, 13110, 0, 8, 13104, 0, 0, 0, '', 'Quest: The Restless Dead depending on quest 13104 or 13105'),
(19, 0, 13110, 1, 8, 13105, 0, 0, 0, '', 'Quest: The Restless Dead depending on quest 13104 or 13105'),
(19, 0, 13135, 0, 8, 13104, 0, 0, 0, '', 'Quest: It Could Kill Us All depending on quest 13104 or 13105'),
(19, 0, 13135, 1, 8, 13105, 0, 0, 0, '', 'Quest: It Could Kill Us All depending on quest 13104 or 13105');
-- Quest 13125 The Air Stands Still / Die Luft steht still needs both quests
-- The Scourgestone / Der Geißelstein (13122)
-- The Purging Of Scourgeholme / Die Reinigung von Geißelholme (13118)
UPDATE `quest_template` SET `ExclusiveGroup` = -13122, `NextQuestId` = 13125, `NextQuestInChain` = 13125 WHERE `entry` IN (13122, 13118);
-- Quest 13139 Into The Frozen Heart Of Northrend / Im gefrorenen Herzen Nordends depends on quests
-- The Stone That Started A Revolution / Der Stein, der eine Revolution auslöste (13130)
-- The Restless Dead / Die rastlosen Toten (13110)
-- It Could Kill Us All / Es könnte uns alle umbringen (13135)
-- The Air Stands Still / Die Luft steht still (13125)
UPDATE `quest_template` SET `ExclusiveGroup` = -13125, `NextQuestId` = 13139, `NextQuestInChain` = 13139 WHERE `entry` IN (13125, 13130, 13110, 13135);
-- Quests The Skybreaker / Die Himmelsbrecher (13225) and Orgrim's Hammer / Orgrims Hammer (13224) are only reachable
-- after completing The Crusader's Pinnacle / Der Kreuzfahrerturm (13157)
UPDATE `quest_template` SET `PrevQuestId` = 13157 WHERE `entry` IN (13225, 13224);

-- Fix quest 13654 There's something about the squire / Etwas ist mit dem Knappen, closes #525
-- Require item 45080 Großer Oberschenkelknochen / Large Femur as source
UPDATE `quest_template` SET `ReqSourceId1` = 45080, `ReqSourceCount1` = 1 WHERE `entry` = 13654;

-- Pull trinity DB fixes Naz'anak, closes #516
-- https://github.com/TrinityCore/TrinityCore/commit/3dac176f85b8db96a3e4c70fe3b86f77de6695e6
-- spell target position
DELETE FROM `spell_target_position` WHERE `id`=60905;
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(60905, 571, 6435, 2366.9, 465.7, 0); -- Portal Effect: Naz'anak Exit
-- templates
UPDATE `gameobject_template` SET `flags`=`flags`|32 WHERE `entry`=193991; -- Altar of the Ebon Depths
UPDATE `gameobject_template` SET `flags`=0,`AIName`='SmartGameObjectAI' WHERE `entry`=193195; -- Pulsing Crystal
UPDATE `creature_template` SET `AIName`='SmartAI',`lootid`=`entry` WHERE `entry`=31691; -- Faceless Lurker
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=31237; -- Matthias Lehner
-- addon
DELETE FROM `creature_template_addon` WHERE `entry` IN (31691,31237);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(31691,0,0,1,0, NULL), -- Faceless Lurker
(31237,0,0,1,0, '10848'); -- Matthias Lehner (Shroud of Death)
-- model info
UPDATE `creature_model_info` SET `bounding_radius`=1.3,`combat_reach`=1.3,`gender`=0 WHERE `modelid`=27522; -- Matthias Lehner
-- scripts
DELETE FROM `smart_scripts` WHERE `entryorguid`=31691 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=31237 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=193195 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(31691,0,0,0,0,0,100,1,0,0,0,0,11,52342,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Faceless Lurker - On aggro cast Seething Evil'),
(193195,1,0,0,19,0,100,0,13390,0,0,0,45,1,1,0,0,0,0,10,203360,31237,0,0,0,0,0, 'Pulsing Crystal - On A Voice in the Dark (A) quest accept set data to Matthias Lehner'),
(193195,1,1,0,19,0,100,0,13271,0,0,0,45,1,1,0,0,0,0,10,203360,31237,0,0,0,0,0, 'Pulsing Crystal - On A Voice in the Dark (H) quest accept set data to Matthias Lehner'),
(31237,0,0,0,38,0,100,0,1,1,0,0,1,0,0,0,0,0,0,21,60,0,0,0,0,0,0, 'Matthias Lehner - On data set (quest accepted at Pulsing Crystal) say text 0');
DELETE FROM `creature_text` WHERE `entry`=31237;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(31237,0,0, 'You shouldn''t have done that!  He''s not going to like it.',15,0,100,0,0,0, 'Matthias Lehner - On quest accept');
-- loot
-- WTB ZxBiohazardZx to do lootz
DELETE FROM `creature_loot_template` WHERE `entry`=31691;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(31691,45912,0.1,1,0,1,1), -- Book of Glyph Mastery
(31691,44001,-60,1,0,1,1), -- Faceless One's Blood
(31691,35063,100,1,0,-35063,1), -- trash
(31691,26041,100,1,0,-26041,1); -- frostweave
-- correct db errors recently found
UPDATE `smart_scripts` SET `target_param1`=40 WHERE `entryorguid`=1435404 AND `source_type`=9 AND `id`=10 AND `link`=0;
UPDATE `smart_scripts` SET `target_param1`=40 WHERE `entryorguid`=1905500 AND `source_type`=9 AND `id`=03 AND `link`=0;

-- Pull trinity DB fixes DB/SAI: Fix quest Adding Injury to Insult / Salz in die Wunde streuen 12481, closes #53
-- https://github.com/TrinityCore/TrinityCore/commit/b85e4eb72437fa3ecfa5be6f84dedbbd683a9db3
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=33581; -- item
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (43315,43371); -- spell
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=43315; -- spell2
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- (13, 0, 43315, 0, 18, 1, 24238, 5, 0, '', 'Only use Insult on Bjorn Halgurdsson'),
-- (18, 0, 33581, 0, 24, 1, 24238, 0, 0, '', 'Only use Insult on Bjorn Halgurdsson'),
(17, 0, 43315, 0, 19, 24238, 0, 0, 63, '', 'Vrykul Insult - Bjorn Halgurdsson'), -- "Invalid Target" trinity_string
(13, 0, 43371, 0, 18, 1, 0, 0, 0, '', 'Bjorn Kill Credit - Players');
DELETE FROM `creature_text` WHERE `entry`=24238;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(24238, 0, 0, 'Drive the invaders out! For Queen Angerboda!', 14, 0, 100, 0, 0, 0, 'Bjorn Halgurdsson - On aggro 1'),
(24238, 1, 0, 'No one speaks of my mother in that manner!', 14, 0, 100, 0, 0, 0, 'Bjorn Halgurdsson - On aggro 2'),
(24238, 2, 0, 'Fight without fear and the Val''kyr will reward you!', 14, 0, 100, 0, 0, 0, 'Bjorn Halgurdsson - Random 1'),
(24238, 2, 1, 'The Winterskorn tribe will prevail!', 14, 0, 100, 0, 0, 0, 'Bjorn Halgurdsson - Random 2');
DELETE FROM `smart_scripts` WHERE `entryorguid`=24238 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24238, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 43371, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On death cast Bjorn Kill Credit (Quest: Adding Injury to Insult)'),
(24238, 0, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - In combat (nr) say text 0'),
(24238, 0, 2, 0, 0, 0, 100, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - In combat (nr) say text 1'),
(24238, 0, 3, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - In combat cast Mortal Strike'),
(24238, 0, 4, 0, 0, 0, 100, 0, 0, 5000, 10000, 15000, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - In combat cast Crush Armor'),
(24238, 0, 5, 0, 0, 0, 100, 0, 10000, 150000, 10000, 15000, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 , 0, 0, 'Bjorn Halgurdsson - In combat say text 2');
UPDATE `creature_template` SET `AIName`='SmartAI', `mechanic_immune_mask`=`mechanic_immune_mask`|1|2|8|16|32|64|1024|2048|4096|16384|65536|131072|524288|2097152|8388608|536870912|67108864 WHERE `entry`=24238;

-- Set respawn time for northrend rare spawns to 8 hours, closes #634
UPDATE `creature` SET `spawntimesecs` = 60*60*8 WHERE `id` IN (32481, 32500, 32471, 32501, 32361, 32398, 32357, 32487, 32429, 32475, 32386, 32447, 32409, 32358, 32422, 32495, 32485, 32517, 32377, 32417, 32438, 32400, 32630);

-- Fix First Aid / Erste Hilfe abilities Netherweave Bandage / Heavy Netherweave Bandage / Netherstoffverband / Schwerer Netherstoffverband, closes #712
-- Remove Manual: Netherweave Bandage & and Manual: Heavy Netherweave Bandage from vendors (Patch 3.1.0)
DELETE FROM `npc_vendor` WHERE `item` IN (21992,21991);
-- Update reqskillvalue for Netherweave Bandage & Heavy Netherweave Bandage (Patch 3.1.0)
UPDATE `npc_trainer` SET `reqskillvalue` = 300 WHERE `spell` = 27032;
UPDATE `npc_trainer` SET `reqskillvalue` = 330 WHERE `spell` = 27033;

-- Fix instance / Instanz Magisters' Terrace / Terasse der Magister / TDM bosses, closes #707
-- allow diseases (2097152) for
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 2097152 WHERE `entry` IN
(24723, 25562, -- Selin Fireheart
 24744, 25573, -- Vexallus
 24560, 25560, -- Priestress Delrissa
 24664, 24857); -- Kael'thas Sunstrider

-- Fix Restricted Flight Area Dalaran - handled in core, closes #710
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -58600;

-- Add more player faction change / Fraktionswechsel data, closes #625, #701, #692
-- argent tournament achievements
DELETE FROM `player_factionchange_achievement` WHERE `alliance_id` IN (2781, 2764, 2780, 2763, 2777, 2760, 2778, 2761, 2779, 2762, 3676, 2782, 2817);
INSERT INTO `player_factionchange_achievement` (`alliance_id`, `horde_id`) VALUES
(2781, 2783), -- Champion of Stormwind/Orgrimmar
(2764, 2765), -- Exalted [...]
(2780, 2786), -- Champion of Ironforge/Thunder Bluff
(2763, 2768), -- Exalted [...]
(2777, 2787), -- Champion of Darnassus/Undercity
(2760, 2769), -- Exalted [...]
(2778, 2785), -- Champion of Exodar/Silvermoon
(2761, 2767), -- Exalted [...]
(2779, 2784), -- Champion of Gnomeregan/Senjin
(2762, 2766), -- Exalted [...]
(3676, 3677), -- The Silver Covenant / The Sunreavers
(2782, 2788), -- Champion of the Alliance / Champion of the Horde
(2817, 2816); -- Exalted [...]
-- some more item exchanges upon faction change
DELETE FROM `player_factionchange_items` WHERE `alliance_id` IN (44098, 18863, 18864, 29593, 40476, 18862, 18859, 18854, 18856, 18857, 18858, 30350, 30351, 30349, 38589, 28237, 28234, 28235, 28236, 30348, 37864, 42123, 42124, 51377, 24579, 17961, 17900, 17901, 17902, 17903, 17904);
INSERT INTO `player_factionchange_items` (`race_A`, `alliance_id`, `commentA`, `race_H`, `horde_id`, `commentH`) VALUES
(0, 44098, 'Inherited Insignia of the Alliance(1)', 0, 44097, 'Inherited Insignia of the Horde(1)'),
(0, 18863, 'Insignia of the Alliance(60)', 0, 18853, 'Insignia of the Horde(60)'), -- insignia: druid
(0, 18864, 'Insignia of the Alliance(60)', 0, 29592, 'Insignia of the Horde(60)'), -- insignia: paladin
(0, 29593, 'Insignia of the Alliance(60)', 0, 18845, 'Insignia of the Horde(60)'), -- insignia: shaman
(0, 40476, 'Insignia of the Alliance(60)', 0, 40477, 'Insignia of the Horde(60)'), -- insignia (hellfire fortifications)
(0, 18862, 'Insignia of the Alliance(60)', 0, 18851, 'Insignia of the Horde(60)'), -- insignia: priest
(0, 18859, 'Insignia of the Alliance(60)', 0, 18850, 'Insignia of the Horde(60)'), -- insignia: mage
(0, 18854, 'Insignia of the Alliance(60)', 0, 18834, 'Insignia of the Horde(60)'), -- insignia: warrior
(0, 18856, 'Insignia of the Alliance(60)', 0, 18846, 'Insignia of the Horde(60)'), -- insignia: hunter
(0, 18857, 'Insignia of the Alliance(60)', 0, 18849, 'Insignia of the Horde(60)'), -- insignia: rogue
(0, 18858, 'Insignia of the Alliance(60)', 0, 18852, 'Insignia of the Horde(60)'), -- insignia: warlock
(0, 30350, 'Medallion of the Alliance(115)', 0, 30344, 'Medallion of the Horde(115)'), -- medallion: warrior
(0, 30351, 'Medallion of the Alliance(115)', 0, 30345, 'Medallion of the Horde(115)'), -- medallion: shaman
(0, 30349, 'Medallion of the Alliance(115)', 0, 30346, 'Medallion of the Horde(115)'), -- medallion: priest
(0, 38589, 'Medallion of the Alliance(115)', 0, 38588, 'Medallion of the Horde(115)'), -- medallion: dk
(0, 28237, 'Medallion of the Alliance(115)', 0, 28243, 'Medallion of the Horde(115)'), -- medallion: hunter
(0, 28234, 'Medallion of the Alliance(115)', 0, 28240, 'Medallion of the Horde(115)'), -- medallion: rogue
(0, 28235, 'Medallion of the Alliance(115)', 0, 28241, 'Medallion of the Horde(115)'), -- medallion: druid
(0, 28236, 'Medallion of the Alliance(115)', 0, 28242, 'Medallion of the Horde(115)'), -- medallion: paladin
(0, 30348, 'Medallion of the Alliance(115)', 0, 30343, 'Medallion of the Horde(115)'), -- medallion: warlock
(0, 37864, 'Medallion of the Alliance(128)', 0, 37865, 'Medallion of the Horde(128)'), -- medallion generic
(0, 42123, 'Medallion of the Alliance(200)', 0, 42122, 'Medallion of the Horde(200)'), -- medallion generic
(0, 42124, 'Medallion of the Alliance(226)', 0, 42126, 'Medallion of the Horde(226)'), -- medallion generic
(0, 51377, 'Medallion of the Alliance(264)', 0, 51378, 'Medallion of the Horde(264)'), -- medallion generic
(0, 24579, 'Mark of Honor Hold(60)', 0, 24581, 'Mark of Thrallmar(60)'), -- hellfire tower tokens
(0, 17691, 'Stormpike Insignia Rank 1(60)', 0, 17690, 'Frostwolf Insignia Rank 1(60)'), -- frostwolf / stormpike insignia
(0, 17900, 'Stormpike Insignia Rank 2(60)', 0, 17905, 'Frostwolf Insignia Rank 2(60)'),
(0, 17901, 'Stormpike Insignia Rank 3(60)', 0, 17906, 'Frostwolf Insignia Rank 3(60)'),
(0, 17902, 'Stormpike Insignia Rank 4(60)', 0, 17907, 'Frostwolf Insignia Rank 4(60)'),
(0, 17903, 'Stormpike Insignia Rank 5(60)', 0, 17908, 'Frostwolf Insignia Rank 5(60)'),
(0, 17904, 'Stormpike Insignia Rank 6(60)', 0, 17909, 'Frostwolf Insignia Rank 6(60)');
-- exchange mammoth mounts (item + spell)
DELETE FROM `player_factionchange_items`WHERE `alliance_id` IN (43956, 43961, 43958, 44235, 44230, 43959) AND `horde_id` IN (44077, 44086, 44080, 44234, 44231, 44083);
INSERT INTO `player_factionchange_items` (`race_A`, `alliance_id`, `commentA`, `race_H`, `horde_id`, `commentH`) VALUES
(0, 43956, 'Reins of the Black War Mammoth(40)', 0, 44077, 'Reins of the Black War Mammoth(40)'),
(0, 43961, 'Reins of the Grand Ice Mammoth(40)', 0, 44086, 'Reins of the Grand Ice Mammoth(40)'),
(0, 43958, 'Reins of the Ice Mammoth(40)', 0, 44080, 'Reins of the Ice Mammoth(40)'),
(0, 44235, 'Reins of the Traveler''s Tundra Mammoth(40)', 0, 44234, 'Reins of the Traveler''s Tundra Mammoth(40)'),
(0, 44230, 'Reins of the Wooly Mammoth(40)', 0, 44231, 'Reins of the Wooly Mammoth(40)'),
(0, 43959, 'Reins of the Grand Black War Mammoth(40)', 0, 44083, 'Reins of the Grand Black War Mammoth(40)');
DELETE FROM `player_factionchange_spells` WHERE `alliance_id` IN (59785, 61470, 59799, 61425, 59791, 61465) AND `horde_id` IN (59788, 61469, 59797, 61447, 59793, 61467);
INSERT INTO `player_factionchange_spells` (`alliance_id`, `horde_id`) VALUES
(59785, 59788), -- black war
(61470, 61469), -- grand ice
(59799, 59797), -- ice
(61425, 61447), -- travelers tundra
(59791, 59793), -- wooly
(61465, 61467); -- grand black war

-- Fix ability 58597 / 53601 Sacred Shield / Geheiligter Schild cooldown -- https://github.com/TrinityCore/TrinityCore/issues/1711
DELETE FROM spell_proc_event WHERE entry = 58597;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(58597, 0, 0, 0x00000000, 0x00000000, 0x00000000, 0, 0, 0, 0, 6);