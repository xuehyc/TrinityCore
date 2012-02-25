-- Fix Love is in the Air / Liebe ist in der Luft Event - Item 49927 / 21815 Love Token / Zeichen der Liebe - Correct ID should be sold
DELETE FROM `npc_vendor` WHERE `item` = 21815;
DELETE FROM `npc_vendor` WHERE `item` = 49927;
INSERT INTO `game_event_npc_vendor` (event, guid, slot, item, maxcount, incrtime, ExtendedCost) VALUES
(8, 4603, 0, 49927, 10, 900, 0),
(8, 6727, 0, 49927, 10, 900, 0),
(8, 6734, 0, 49927, 10, 900, 0),
(8, 6737, 0, 49927, 10, 900, 0),
(8, 6738, 0, 49927, 10, 900, 0),
(8, 6740, 0, 49927, 10, 900, 0),
(8, 6741, 0, 49927, 10, 900, 0),
(8, 6746, 0, 49927, 10, 900, 0),
(8, 6928, 0, 49927, 10, 900, 0),
(8, 6929, 0, 49927, 10, 900, 0);

-- Fix quests 14444, 24555 What The Dragons Know, Das Wissen der Drachen
-- Step 1: Set correct menu_id for NPC 27990 Krasus
UPDATE `creature_template` SET `gossip_menu_id` = 10199 WHERE `entry` = 27990;
-- Step 2: Insert the gossip_menu_options
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (10199, 10200);
INSERT INTO `gossip_menu_option` (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text) VALUES
(10199,0,0,'Was koennt ihr mir ueber diesen Gegenstand verraten?',1,1,10200,0,0,0,0,''),
(10200,0,0,'Sonst noch etwas?',1,1,0,0,10200,0,0,'');
-- Step 3: Insert the gossip_scripts for quest completing
DELETE FROM `gossip_scripts` WHERE `id` = 10200;
INSERT INTO `gossip_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(10200,0,8,36715,0,0,0,0,0,0),
(10200,0,33,0,0,0,0,0,0,0);
-- Step 4: Insert conditions for the gossip_menu_option - Only shown when quests active
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 10199;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(15, 10199, 0, 0, 9, 24555, 0, 0, 0, '', 'Gossip Option 10199 only available to Horde players with quest 24555 active'),
(15, 10199, 0, 1, 9, 14444, 0, 0, 0, '', 'Gossip Option 10199 only available to Alliance players with quest 14444 active');

-- Spell 63746 (Boots - Minor Accuracy) / (Stiefel - Geringe Präzision)
-- Make the Enchant learnable from 27 trainers worldwide
-- Source: http://www.wowhead.com/spell=63746#taught-by-npc
DELETE FROM `npc_trainer` WHERE `spell` = 63746;
INSERT INTO `npc_trainer` (entry, spell, spellcost, reqskill, reqskillvalue, reqlevel) VALUES
(201009, 63746, 5000, 333, 225, 0);

-- Fix Portal to Dalaran / Dalaran Portal in ICC / Eiskronenzitadelle / Icecrown Citadel - use correct spell id
UPDATE `gameobject_template` SET `data0` = 53360 WHERE `entry` = 202079;

-- Fix quest 3446 In die Tiefen / Into the Depths - Delete and Backup useless gossip menu of gameobject 148836 Altar von Hakkar / Altar of Hakkar and fix quest accepting with it
-- REPLACE INTO `gossip_menu_option` (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text) VALUES (1288, 0, 0, 'How could the altar and the statues be related?', 1, 1, 0, 0, 0, 0, 0, '');
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 1288;

-- Add Item 50450 Leggings of Dubious Charms, Gamaschen der zweifelhaften Reize to ICC trashloot
DELETE FROM `reference_loot_template` WHERE `entry` = 35071 AND `item` = 50450;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (35071, 50450, 0, 1, 1, 1, 1);

-- Add item 50406 Formula: Enchant Gloves - Angler / Formel: Handschuhe - Angler to creature drops
DELETE FROM `creature_loot_template` WHERE `item` = 50406;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(26336, 50406, 1, 1, 1, 0, 1), -- Indu'le Fisherman
(26343, 50406, 1.1, 1, 1, 0, 1), -- Indu'le Warrior
(26344, 50406, 1, 1, 1, 0, 1); -- Indu'le Mystic

-- Add items 45094 (Muster: Gürtel der Drachen / Pattern: Belt of Dragons), 45095 (Pattern: Boots of Living Scale / Muster: Stiefel aus lebendigen Schuppen), 45099 (Muster: Schleicher der Stille / Pattern: Footpads of Silence) into loot of item 45878 (Großer Sack mit Schätzen von Ulduar / Large Sack of Ulduar Spoils). Item 45295 (Gilded Steel Legplates / Vergoldete Stahlbeinplatten) was totally wrong in the loot
DELETE FROM `item_loot_template` WHERE `entry` = 45878 AND `item` IN (45295, 45094, 45095, 45099);
INSERT INTO `item_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(45878, 45094, 0, 1, 1, 1, 1),
(45878, 45095, 0, 1, 1, 1, 1),
(45878, 45099, 0, 1, 1, 1, 1);

-- update the four different fragments of nightmare corruption / Verderbnisfragment des Alptraums to a 100% dropchance (quest inhabitors only)
UPDATE `creature_loot_template` SET ChanceOrQuestChance = '-100' WHERE item IN (21147, 21149, 21148, 21146);

-- Adds the missing key 41843 (Schlüssel zu Vaelens Ketten / Key to Vaelen's Chains) for quest 12949 (Get the key / Besorgt den Schlüssel) to NPC 29915 (Instructor Hroegar / Instrukteur Hroegar) loot-template.
DELETE FROM `creature_loot_template` WHERE `item` = 41843 AND `entry` = 29915;
INSERT INTO `creature_loot_template`(`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`)VALUES(29915,41843,-100,1,0,1,1);
UPDATE `creature_template` SET `faction_A` = 1885, `faction_H` = 1885 WHERE `entry` = 29915;

-- As long as "Shroud of Death" (Spell 10848 / Tuch des Todes) doesn't work properly, we should avoid its usage. Otherwise, Franclorn  Forgewright (8888 / Franclorn Schmiedevater) cannot be reached by players.
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 8888;
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 8888;

-- Fix spell 66211, 66209 - Touch of Jaraxxus / Jaraxxus Beruehrung / Curse of the Nether / Fluch des Nethers - Do not apply debuff on unit carrying the sharing aura
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 66211;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 66211, 0, 11, 66209, 0, 0, 0, '', 'Jaraxxus - Touch of Jaraxxus');

-- Fix NPC 12429, Sentinel Shaya, Schildwache Shaya, needs to be healable for Priest class quest
UPDATE `creature_template` SET `unit_flags` = 8 WHERE `entry` = 12429;

-- Fix quest 12536 Ein holpriger Ritt / A Rough Ride
UPDATE `quest_template` SET `SrcItemId`=38512,`SrcItemCount`=1 WHERE `entry`=12536;

-- Fix creature 33687 Chillmaw / Frostschlund - remove passangers and make it aggro-able in flight
DELETE FROM `vehicle_accessory` WHERE `entry` = 33687;
UPDATE `creature_template` SET `AIName` = '', `VehicleId` = 0, `dmg_multiplier` = 20 WHERE `entry` = 33687;

-- Quest-Fix 12253 (Rettung vom Marktplatz / Rescue from Town Square).
-- This is more a workaround, since killing a mob with a particular GUID doesn't fit the quest's requirement.
-- So, we add a gossip to the NPC that grants a the kill credit (as it's already used) and despawns himself.
-- Respawn should be handled properly, since a forced-despawn causes the NPC to die.
-- Positive side-effect is that you cannot talk to the NPC while infight ;)
-- Step 1: Cleaup.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 27359;
DELETE FROM `gossip_scripts` WHERE `id`=27359;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=27359;
-- Step 2: Create gossip-scripts.
INSERT INTO `gossip_scripts`(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(27359,0,8,27359,0,0,0,0,0,0),
(27359,0,18,0,0,0,0,0,0,0);
-- Step3: Create gossip-entry.
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(27359,0,0,'You should better run and hide before they return. NOW!',1,1,0,0,27359,'0','0',NULL);
-- Step 4: Relate entry to NPC.
UPDATE `creature_template` SET `gossip_menu_id`=27359,`npcflag`=1 WHERE `entry`=27359;
-- Step 5: Insert conditions for the gossip_menu_option - Only shown when quests active
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(15, 27359, 0, 0, 9, 12253, 0, 0, 0, '', 'Gossip Option 27359 only available to players with quest 12253 active');

-- Fix quests 4293 Eine Schleimprobe... / A Sample of Slime... - 4294 ... and a Batch of Ooze / ...und eine Menge Schlamm - 4642 Vereinigung von Einfluessen / Melding of Influences
-- Only allow quest 4642 to be shown when 4293 and 4294 are completed - the other way with exclusive group caused some errors in quest accepting
UPDATE `quest_template` SET `ExclusiveGroup` = 0 WHERE `entry` IN (4293, 4294);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (19, 20) AND `SourceEntry` = 4642;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(19, 0, 4642, 0, 8, 4293, 0, 0, 0, '', 'Quest 4642 only shown when 4293 and 4294 completed'),
(19, 0, 4642, 0, 8, 4294, 0, 0, 0, '', 'Quest 4642 only shown when 4293 and 4294 completed'),
(20, 0, 4642, 0, 8, 4293, 0, 0, 0, '', 'Quest 4642 only shown when 4293 and 4294 completed'),
(20, 0, 4642, 0, 8, 4294, 0, 0, 0, '', 'Quest 4642 only shown when 4293 and 4294 completed');

-- fix issue where creatures are not attacking
-- NPCs Backup VehicleId:
-- 27131, 'Grizzly Bear', 53
-- 29351, 'Niffelem Frost Giant', 176
-- 29358, 'Frostworg', 177
-- 29753, 'Stormpeak Wyrm', 207
-- 31139, 'Pustulent Horror', 263
-- Closes: http://www.wow-castle.de/bboard/7062-b-ren-in-grizzlyh-gel.html
-- Override Vehicle Id
UPDATE `creature_template` SET `VehicleId`=0 WHERE `entry` IN (27131, 29358, 29351, 29753, 31139);

-- Fix for quest 12145: Canyon Chase / Jagd durch die Schluchten
-- There was a duplicate entry for the same creature. Fulfilling one of the requirements blocks the other, so we'll remove its duplicate.
UPDATE `quest_template` SET `ReqCreatureOrGOId2`=0,`ReqCreatureOrGOCount2`=0 WHERE `entry`=12145;

-- Fix for quest 13232: Finish me! / Tötet mich!
-- There was already a gossip-option for this, but no gossip-script yet. Therefore, we add it and rebuild the relation to the NPC.
-- Step 1: Create new gossip_scripts . `id` corresponds to the NPCs id.
DELETE FROM `gossip_scripts` WHERE `id`=31304;
INSERT INTO `gossip_scripts`(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(31304,0,8,31304,0,0,0,0,0,0),
(31304,0,18,0,0,0,0,0,0,0);
-- Step 2: Bind the scripts to the gossip_menu_option.
UPDATE `gossip_menu_option` SET `action_script_id`=31304 WHERE `menu_id`=10040 AND `id`=1;
-- Step 3: Change the required NPC from the stupid kill-bunny to the real npc.
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=31304 WHERE `entry`=13232;

-- Questfix 12032 - Conversing with the depths / Gespräche mit den Tiefen.
-- Step 1: Create missing event linked from the gameobject (188422).
DELETE FROM `event_scripts` WHERE `id`=17612;
INSERT INTO `event_scripts`(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(17612,0,10,26648,30000,0,0,0,0,0);
-- Step 2:
-- Remove dependancy to a non-existing area-trigger.
-- Switch quest-needs to a single kill-credit for Oachanoa.
UPDATE `quest_template` SET  `ReqCreatureOrGOId1`=26648,`ReqCreatureOrGOCount1`=1,`QuestFlags`=136,`SpecialFlags`=0 WHERE `entry`=12032;
-- Step 3: Activate Oachanoa s gossip.
UPDATE `creature_template` SET `gossip_menu_id`=26648,`npcflag`=1 WHERE `entry`=26648;
-- Step 4: Create gossip for the talk with Oachanoa.
DELETE FROM `gossip_menu_option` WHERE `menu_id`=26648;
INSERT INTO `gossip_menu_option`(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(26648,1,0,'Oacha\noa, the Kalu\ak need your help, and I am here to pray for it.',1,1,0,0,266480,0,0,NULL);
-- Step 5: Grant kill-credit for the talk and yell out her answer.
DELETE FROM `gossip_scripts` WHERE `id`=266480;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(266480,0,0,1,0,2000009999,0,0,0,0),
(266480,0,8,26648,0,0,0,0,0,0);
-- Step 6: Create text for Oachanoa s call-out.
DELETE FROM `db_script_string` WHERE `entry`=2000009999;
INSERT INTO `db_script_string`(`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES
(2000009999,'The Kalu\ak know what has be done, and you know either. So do it, or the tortured souls will destroy everything you are fighting for.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- hackfix for quest Junkboxes Needed (Plunderkisten benötigt) (8249) by updating ZoneOrSort from -162 to 45, making the quest available to non-rogue players too
UPDATE `quest_template` SET `ZoneOrSort` = 45 WHERE `entry` = 8249;

-- Northrend / Icecrown
-- fixes several recipe drops
-- Source: Wowhead
-- Closes: http://www.wow-castle.de/bboard/6862-alchemie-rezepte-in-eiskrone-fehlen.html
DELETE FROM `creature_loot_template` WHERE `item` IN (37330, 44568, 44567, 44566, 44565, 44564);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
-- Formula: Enchant Cloak - Superior Arcane Resistance
(31702, 37330, 0.8, 1, 0, 1, 1), -- from Frostbrood Spawn
(32297, 37330, 0.8, 1, 0, 1, 1), -- from Cult Researcher
-- Recipe: Mighty Shadow Protection Potion
(32349, 44568, 0.5, 1, 0, 1, 1), -- from Cultist Shard Watcher
-- Recipe: Mighty Nature Protection Potion
(32290, 44567, 0.2, 1, 0, 1, 1), -- from Cult Alchemist
-- Recipe: Mighty Frost Protection Potion
(32289, 44566, 0.2, 1, 0, 1, 1), -- from Damned Apothecary
-- Recipe: Mighty Fire Protection Potion
(31321, 44565, 0.8, 1, 0, 1, 1), -- from Skeletal Runesmith (I)
(30921, 44565, 0.5, 1, 0, 1, 1), -- from Skeletal Runesmith (II)
-- Recipe: Mighty Arcane Protection Potion
(32297, 44564, 0.6, 1, 0, 1, 1); -- from Cult Researcher

-- Fix quests 20438, 24556 A Suitable Disguise, Eine passende Verkleidung
-- Step 1: Set correct menu_id for NPC 36856 Shandy Glossgleam, Shandy Lackglanz
UPDATE `creature_template` SET `gossip_menu_id` = 10197 WHERE `entry` = 36856;
-- Step 2: Insert the gossip_menu_options
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (10197, 10198);
INSERT INTO `gossip_menu_option` (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, action_script_id, box_coded, box_money, box_text) VALUES
(10197, 0, 0, 'I\'m looking for a suitable disguise', 1, 1, 10198, 0, 0, 0, 0, ''),
(10198, 0, 0, 'Can you help me?', 1, 1, 0, 0, 10198, 0, 0, '');
-- Step 3: Insert the gossip_scripts for quest completing
DELETE FROM `gossip_scripts` WHERE `id` = 10198;
INSERT INTO `gossip_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(10198, 0, 17, 49648, 1, 0, 0, 0, 0, 0),
(10198, 0, 33, 0, 0, 0, 0, 0, 0, 0);
-- Step 4: Insert conditions for the gossip_menu_option - Only shown when quests active
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 10197;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(15, 10197, 0, 0, 9, 24556, 0, 0, 0, '', 'Gossip Option 10197 only available to Horde players with quest 24556 active'),
(15, 10197, 0, 1, 9, 20438, 0, 0, 0, '', 'Gossip Option 10197 only available to Alliance players with quest 20438 active');

-- Fix spell stacking of Unleashed Rage / Entfesselte Wut (30802) and Abomination's Might / Staerke der Monstrosität (53137) and Trueshot Aura / Aura des Volltreffers (19506)
DELETE FROM `spell_group` WHERE `id` = 5003;
INSERT INTO `spell_group` (id, spell_id) VALUES
(5003, 19506),
(5003, 30802),
(5003, 53137);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 5003;
INSERT INTO `spell_group_stack_rules` (group_id, stack_rule) VALUES
(5003, 1);

-- Fix quest Verlorene Geister / The Lost Spirits 11607 - quest credit on spellhit repetable
UPDATE `creature_ai_scripts` SET `event_flags` = 1 WHERE `id` IN (2532101, 2532201);

-- Fix spell stacking of Heroic Presence / Heroische Praesenz (6562, 28878) - Melee and caster version are the same, so do not apply both auras anymore
DELETE FROM `spell_group` WHERE `id` = 5002;
INSERT INTO `spell_group` (id, spell_id) VALUES
(5002, 6562),
(5002, 28878);
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 5002;
INSERT INTO `spell_group_stack_rules` (group_id, stack_rule) VALUES
(5002, 1);

-- Fix quests 13679, 13680 The Aspirant's Challenge / Die Herausforderung des Streiters - Set correct kill credit
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 33448 WHERE `entry` IN (13679, 13680);

-- Fix for Quest 10368 - The Dreghood Elders.
-- Someone obviously removed the gossip-scripts for it, so we have to rebuild them.
-- Step 1: Delete maybe-existing former values.
DELETE FROM `gossip_scripts` WHERE `id` IN (20677,20678,20679,816200,816300,816100);
-- Step 2: Create new script-entries:
INSERT INTO `gossip_scripts`(`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`)VALUES
(20677,0,8,20677,0,0,0,0,0,0),
(20678,0,8,20678,0,0,0,0,0,0),
(20679,0,8,20679,0,0,0,0,0,0);
-- Step 3: Link them to the gossip.
UPDATE `gossip_menu_option` SET `action_script_id`=20679 WHERE `menu_id`=8161 AND `id`=0;
UPDATE `gossip_menu_option` SET `action_script_id`=20677 WHERE `menu_id`=8162 AND `id`=0;
UPDATE `gossip_menu_option` SET `action_script_id`=20678 WHERE `menu_id`=8163 AND `id`=0;

-- Fix Kalu Ak Dailies - Give 500 reputation
UPDATE `quest_template` SET `RewRepValueId1` = 0, `RewRepValue1` = 50000 WHERE `entry` IN (11472, 11945, 11960);

-- Fix portal Sholazar - Ungoro and Ungoro - Sholazar, needed for a quest chain starting in Sholazar
DELETE FROM `areatrigger_teleport` WHERE `id` IN (5046, 5460, 5461, 5047, 5462, 5464);
INSERT INTO `areatrigger_teleport` (`id`,`name`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(5046, 'Shola_UnGoro_Portal', 1, -6167.552246, -1326.307594, -172.399933, 2.367187),
(5460, 'Shola_UnGoro_Portal', 1 ,-6167.552246, -1326.307594, -172.399933, 2.367187),
(5461, 'Shola_UnGoro_Portal', 1, -6167.552246, -1326.307594, -172.399933, 2.367187),
(5047, 'UnGoro_Shola_Portal', 571, 4904.198242, 5184.370606, -93.161057, 82.064903),
(5462, 'UnGoro_Shola_Portal', 571, 4904.198242, 5184.370606, -93.161057, 82.064903),
(5464, 'UnGoro_Shola_Portal', 571, 4904.198242, 5184.370606, -93.161057, 82.064903);

-- Anatoly will talk (12330) workaround. As long as the escort doesn't work, we'll change that to only kill the corresponding NPC.
-- Step 1: Relate 'Tatjana' (27627) with this quest.
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=27627,`ReqCreatureOrGOCount1`=1 WHERE `entry`=12330;
-- Step 2: Remove the escort-dependancy from the quest-templates.
UPDATE `quest_template` SET `QuestFlags`=128,`SpecialFlags`=0 WHERE `entry`=12330;
-- Step 3: Remove their twin near Sasha. (Whoever has spawned this one...)
DELETE FROM `creature` WHERE `id` = 27627;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(27627, 571, 1, 1, 24715, 0, 4032.89, -4375.6, 263.873, 4.31096, 300, 5, 0, 10282, 0, 0, 1, 0, 0, 0);

-- Set Quest 12308 (Escape from Silverbrook) to autocomplete.
-- Something seems to distract the correct quest_start and event.
-- As long as it's unknown what prevents this quest from opening a longer questchain, it should be finished automatically.
UPDATE `quest_template` SET `Method` = 2, `ReqCreatureOrGoID1` = 0, `ReqCreatureOrGoCount1` = 0 WHERE `entry` = 12308;

-- Fix 28781, 32796 Battleground Demolisher / Schlachtfeldverwüster in Sota / Strand der Uralten / Strand of the Ancients Battleground / BG / Schlachtfeld - Do not regenerate health and immunities
UPDATE `creature_template` SET `RegenHealth` = 0, `mechanic_immune_mask` = 650853247 WHERE `entry` IN (28781, 32796);

-- Fix instance / Instanz PDK (Prüfung des Kreuzfahrers) / ToC (Trial of the Crusader) - Adds in Jaraxxus fight immune
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (34825, 35278, 35279, 35280, 34813, 35265, 35266, 35267);

-- Fix Item - Coliseum 25 Normal Caster Trinket used by Reign of the Dead / Reign of the Unliving / Herrschaft der Leblosen / Herrschaft der Toten 47316, 47182
DELETE FROM `spell_proc_event` WHERE `entry` = 67712;
INSERT INTO `spell_proc_event` (entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown) VALUES
(67712, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2);

-- Putridius the Ancient 32487 (Putridus der Uralte) is an Icecrown Rare Elite Mob necessary for the Northern Exposure Achievemnt
-- he is currently missing his waypoints making him too easy to find
-- Cleanup queries
DELETE FROM `waypoint_data` WHERE `id` IN (SELECT ca.`path_id` FROM `creature_addon` ca, `creature` c WHERE ca.`guid` = c.`guid` and c.`id` = 32487);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 32487);
DELETE FROM `creature` WHERE `id` = 32487;
-- Variables
SELECT MAX(`guid`)+1 FROM `creature` INTO @GUID;
SET @WPID := @GUID * 10;
-- link creature to waypath
INSERT INTO `creature_addon` (guid, path_id, mount, bytes1, bytes2, emote, auras) VALUES
(@GUID, @WPID, 0, 0, 0, 0, '');
-- import waypoints
DELETE FROM `waypoint_data` WHERE `id` = @WPID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(@WPID, 1, 6472.82, 1171.58, 282.808, 0, 0, 0, 100, 0),
(@WPID, 2, 6657.61, 1171.97, 273.034, 0, 0, 0, 100, 0),
(@WPID, 3, 6588.96, 1123.06, 272.534, 0, 0, 0, 100, 0),
(@WPID, 4, 6658.37, 1132.78, 273.673, 0, 0, 0, 100, 0),
(@WPID, 5, 6720.29, 1161.65, 274.212, 0, 0, 0, 100, 0),
(@WPID, 6, 6797.09, 1183.24, 276.882, 0, 0, 0, 100, 0),
(@WPID, 7, 6830.66, 1143.71, 282.184, 0, 0, 0, 100, 0),
(@WPID, 8, 6870.01, 1170.74, 283.116, 0, 0, 0, 100, 0),
(@WPID, 9, 6895.33, 1192.27, 286.125, 0, 0, 0, 100, 0),
(@WPID, 10, 6940.92, 1199.21, 291.651, 0, 0, 0, 100, 0),
(@WPID, 11, 6975.74, 1206.62, 305.215, 0, 0, 0, 100, 0),
(@WPID, 12, 7004.1, 1213.86, 307.13, 0, 0, 0, 100, 0),
(@WPID, 13, 6994.54, 1211.39, 307.47, 0, 0, 0, 100, 0),
(@WPID, 14, 6994.54, 1211.39, 307.47, 0, 0, 0, 100, 0),
(@WPID, 15, 6994.54, 1211.39, 307.47, 0, 0, 0, 100, 0),
(@WPID, 16, 7207.23, 1284.83, 306.16, 0, 0, 0, 100, 0),
(@WPID, 17, 7293.52, 1353.98, 306.613, 0, 0, 0, 100, 0),
(@WPID, 18, 7501.44, 1387.31, 319.167, 0, 0, 0, 100, 0),
(@WPID, 19, 7557.15, 1459.48, 327.205, 0, 0, 0, 100, 0),
(@WPID, 20, 7625.83, 1516.86, 331.225, 0, 0, 0, 100, 0),
(@WPID, 21, 7730.05, 1701.15, 343.392, 0, 0, 0, 100, 0),
(@WPID, 22, 7691.44, 1776.63, 349.114, 0, 0, 0, 100, 0),
(@WPID, 23, 7691, 1820.01, 354.262, 0, 0, 0, 100, 0),
(@WPID, 24, 7802.65, 1886.33, 362.801, 0, 0, 0, 100, 0),
(@WPID, 25, 7806.46, 1980.97, 367.928, 0, 0, 0, 100, 0),
(@WPID, 26, 7810.19, 2036.07, 389.656, 0, 0, 0, 100, 0),
(@WPID, 27, 7810.32, 2068.88, 391.439, 0, 0, 0, 100, 0),
(@WPID, 28, 7811.31, 2146.49, 364.342, 0, 0, 0, 100, 0),
(@WPID, 29, 7718.19, 2289.38, 369.953, 0, 0, 0, 100, 0),
(@WPID, 30, 7423.34, 2466.26, 388.481, 0, 0, 0, 100, 0);
-- spawn in lower icecrown
INSERT INTO  `creature` (`guid` ,`id` ,`map` ,`spawnMask` ,`phaseMask` ,`modelid` ,`equipment_id` ,`position_x` ,`position_y` ,`position_z` ,`orientation` ,`spawntimesecs` ,`spawndist` ,`currentwaypoint` ,`curhealth` ,`curmana` ,`DeathState` ,`MovementType` ,`npcflag` ,`unit_flags` ,`dynamicflags`) VALUES
(@GUID,  32487,  571,  1,  1,  0,  0,  6472.82,  1171.58,  282.808,  3.30025,  300,  0,  @WPID,  75600,  0,  0,  2,  0,  0,  0);

-- Database-Fix for the 'Higher Learning' reward.
-- Cleanup possible old entries before.
DELETE FROM gossip_menu_option WHERE `menu_id`=19481;
DELETE FROM gossip_scripts WHERE `id`=194811;
-- Now, enter the values for the new menu.
INSERT INTO gossip_menu_option (`menu_id`, `id`, `option_icon`,`option_text`, `option_id`,
`npc_option_npcflag`,`action_script_id`,`box_text`) VALUES (19481,0,0,'Get you reward for Higher Learning.',1,1,194811,'');
INSERT INTO gossip_scripts(`id`,`command`,`datalong`, `datalong2`) VALUES (194811, 15, 1457, 1);
UPDATE creature_template SET `gossip_menu_id`=19481 WHERE `entry`=19481;


-- Skinning loot fix for scourgeholme inhabitants.
-- Step 1: Delete former entries.
DELETE FROM skinning_loot_template WHERE `entry` IN (30206,31037,30204,30205,31039);
-- Step 2: Create new ones.
INSERT INTO skinning_loot_template(`entry`,`item`,`ChanceOrQuestChance`,`lootmode`, `groupid`,`mincountOrRef`,`maxcount`) VALUES
(30206,33568,99.0,1,1,1,1),
(30206,44128, 1.0,1,1,1,1),
(31037,33568,75.0,1,1,1,1),
(31037,38558,24.0,1,1,1,1),
(31037,44128, 1.0,1,1,1,1),
(31039,33568,75.0,1,1,1,1),
(31039,38558,24.0,1,1,1,1),
(31039,44128, 1.0,1,1,1,1),
(30204,33568,72.0,1,1,1,1),
(30204,38558,26.0,1,1,1,1),
(30204,44128, 2.0,1,1,1,1),
(30205,33568,75.0,1,1,1,1),
(30205,38558,24.0,1,1,1,1),
(30205,44128, 1.0,1,1,1,1);
-- Step 3: Update skinloot-entries for corresponding creatures.
UPDATE creature_template SET `skinloot`=30206 WHERE `entry`=30206;
UPDATE creature_template SET `skinloot`=31037 WHERE `entry`=31037;
UPDATE creature_template SET `skinloot`=31039 WHERE `entry`=31039;
UPDATE creature_template SET `skinloot`=30204 WHERE `entry`=30204;
UPDATE creature_template SET `skinloot`=30205 WHERE `entry`=30205;

-- Horn of Winter (57330) should not stack with Strength of Earth Totem (8075)
DELETE FROM `spell_group` WHERE `id` = 5001;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(5001, 57330), -- Horn of Winter
(5001, 8075); -- Streng of Earth Totem
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 5001;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(5001, 1); -- can't stack in same grp/raid

-- Fix NPC 16978, Lieutenant Commander Thalvos, Feldkommandant Thalvos, do not get invisible on spawn
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 16978;
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(1697800, 16978, 0, 0, 50, 1, 4000, 4000, 8000, 8000, 11, 8242, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lieutenant Commander Thalvos - Cast Shield Slam'),
(1697801, 16978, 0, 0, 50, 1, 5000, 5000, 10000, 10000, 11, 11976, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lieutenant Commander Thalvos - Cast Strike');

-- Remove Focus Magic (54646) from spell stacking
DELETE FROM `spell_group` WHERE `spell_id` = 54646;

-- Fix Rogue T9 Spell 67209 - Should only proc on usage of "Blutung" - "Rupture"
DELETE FROM `spell_proc_event` WHERE `entry` = 67209;
INSERT INTO `spell_proc_event` (entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown) VALUES
(67209,1,8,1048576,0,0,16,0,0,100,0);

-- Set respawntime of all Northrend rare mobs to 10 minutes
UPDATE `creature` SET `spawntimesecs` = 600 WHERE `id` IN (32357,32500,32358,32422,32501,32398,32377,32417,32438,32400,32386,32429,32481,32361,32471,32495,32485,32517,32487,32447,32475,32409,32630);

-- Wintergrasp Vehicles, set immune mask
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (27881,28094,28312,28319,28366,32627,32629);

-- Devourer of Souls should be interuptable
UPDATE `creature_template` SET `mechanic_immune_mask` = 617298815 WHERE `entry` IN (36502, 37677);

-- Loot-configs for Northrend rares
DELETE FROM creature_loot_template WHERE `entry` IN (32481,32400,32438,32377,32485,32495,32422,32358,32447,32386,32475,32429,31471,32361,32398,32357);
INSERT INTO creature_loot_template (`entry`,`item`,`ChanceOrQuestChance`,`mincountOrRef`,`maxcount`) VALUES
(32481, 44691, 99.0, 1, 1),
(32481, 44663, 97.0, 1, 1), 
(31471, 44686, 99.0, 1, 1), 
(31471, 44663, 97.0, 1, 1),
(32400, 44673, 92.0, 1, 1), 
(32400, 44663, 92.0, 1, 1), 
(32438, 44676, 100.0, 1, 1), 
(32438, 44663, 98.0, 1, 1), 
(32377, 44669, 100.0, 1, 1), 
(32377, 44663, 97.0, 1, 1), 
(32495, 44697, 99.0, 1, 1), 
(32495, 44663, 99.0, 1, 1), 
(32485, 44683, 98.0, 1, 1), 
(32485, 44663, 95.0, 1, 1), 
(32422, 44675, 99.0, 1, 1), 
(32422, 44663, 98.0, 1, 1), 
(32358, 44666, 99.0, 1, 1), 
(32358, 44663, 97.0, 1, 1), 
(32447, 44677, 99.0, 1, 1),
(32447, 44663, 95.0, 1, 1), 
(32386, 44670, 99.0, 1, 1), 
(32386, 44663, 98.0, 1, 1), 
(32475, 44683, 100.0, 1, 1), 
(32475, 44663, 95.0, 1, 1), 
(32361, 44667, 100.0, 1, 1), 
(32361, 44663, 98.0, 1, 1), 
(32398, 44668, 100.0, 1, 1),
(32398, 44663, 97.0, 1, 1),
(32357, 44649, 100.0, 1, 1),
(32357, 44663, 98.0, 1, 1),
(32429, 44673, 99.0, 1, 1),
(32429, 44663, 99.0, 1, 1);

-- Erzmagier Vargoth 19481, Dalaran one should be gossip only, Netherstorm questgiver only
UPDATE `creature_template` SET `npcflag` = 0 WHERE `entry` = 19481;
UPDATE `creature` SET `npcflag` = 2 WHERE `id` = 19481 AND `map` = 530;
UPDATE `creature` SET `npcflag` = 1 WHERE `id` = 19481 AND `map` = 571;

-- Dmg-Rearrangements, spell-correspondings and loot-id's for Northrend Rares
-- mindmg scaled by 8,9592326139088729016786570743405 to get whole value for rare-elites
-- maxdmg scaled by 8,5446735395189003436426116838488 to get whole value for rare-elites
UPDATE creature_template SET `lootid`=32386 , `mindmg`=312.41514989293361884368308351178 , `maxdmg`=439.45505730947114417856424693344 WHERE `entry`=32386 ;
UPDATE creature_template SET `lootid`=32475 , `mindmg`=330.27382226980728051391862955032 , `maxdmg`=452.67967021918359139352503519003 WHERE `entry`=32475 ;
UPDATE creature_template SET `lootid`=32409 , `mindmg`=321.23286937901498929336188436831 , `maxdmg`=458.99939674240900864669213754273 WHERE `entry`=32409 ;
UPDATE creature_template SET `lootid`=32400 , `mindmg`=321.23286937901498929336188436831 , `maxdmg`=458.99939674240900864669213754273 WHERE `entry`=32400 ;
UPDATE creature_template SET `lootid`=32438 , `mindmg`=321.23286937901498929336188436831 , `maxdmg`=458.99939674240900864669213754273 WHERE `entry`=32438 ;
UPDATE creature_template SET `lootid`=32429 , `mindmg`=321.23286937901498929336188436831 , `maxdmg`=446.47697566861049668208324954756 WHERE `entry`=32429 ;
UPDATE creature_template SET `lootid`=32487 , `mindmg`=417 , `maxdmg`=582 WHERE `entry`=32487 ;
UPDATE creature_template SET `lootid`=32485 , `mindmg`=330.05058886509635974304068522484 , `maxdmg`=471.63884978885984315302634224814 WHERE `entry`=32485 ;
UPDATE creature_template SET `lootid`=31471 , `mindmg`=330.05058886509635974304068522484 , `maxdmg`=471.63884978885984315302634224814 , `spell1`=51334 WHERE `entry`=31471 ;
UPDATE creature_template SET `lootid`=32361 , `mindmg`=312.41514989293361884368308351178 , `maxdmg`=446.47697566861049668208324954756 , `spell1`=57468 WHERE `entry`=32361 ;
UPDATE creature_template SET `lootid`=32422 , `mindmg`=325.5859207708779443254817987152 , `maxdmg`=465.31912326563442589985923989544 , `spell1`=49676 , `spell2`=49675 WHERE `entry`=32422 ;
UPDATE creature_template SET `lootid`=32358 , `mindmg`=312.41514989293361884368308351178 , `maxdmg`=439.45505730947114417856424693344 , `spell1`=60906 , `spell2`=6660 WHERE `entry`=32358 ;
UPDATE creature_template SET `lootid`=32447 , `mindmg`=348.13249464668094218415417558887 , `maxdmg`=484.16127086265835511763523024331 , `spell1`=55196 , `spell2`=54565 WHERE `entry`=32447 ;
UPDATE creature_template SET `lootid`=32481 , `mindmg`=330.05058886509635974304068522484 , `maxdmg`=471.63884978885984315302634224814 , `spell1`=49865 , `spell2`=51144 WHERE `entry`=32481 ;
UPDATE creature_template SET `lootid`=32357 , `mindmg`=312.41514989293361884368308351178 , `maxdmg`=446.47697566861049668208324954756 , `spell1`=60903 , `spell2`=50506 WHERE `entry`=32357 ;
UPDATE creature_template SET `lootid`=32398 , `mindmg`=312.41514989293361884368308351178 , `maxdmg`=446.47697566861049668208324954756 , `spell1`=61115 , `spell2`=50169 WHERE `entry`=32398 ;
UPDATE creature_template SET `lootid`=32377 , `mindmg`=312.41514989293361884368308351178 , `maxdmg`=439.45505730947114417856424693344 , `spell1`=50046 , `spell2`=52071 WHERE `entry`=32377 ;
UPDATE creature_template SET `lootid`=32495 , `mindmg`=417 , `maxdmg`=582 , `spell1`=60991 , `spell2`=57547 WHERE `entry`=32495 ;
UPDATE creature_template SET `lootid`=32501 , `mindmg`=417 , `maxdmg`=582 , `spell1`=60950 , `spell2`=60945 , `spell3`=60953 , `spell4`=60949 , `spell5`=60951   WHERE `entry`=32501 ;

-- Bugfix Quest 11795 Notfallprotokoll: Sektion 8,2. Absatz C (11795)
-- Cleanup first.
DELETE FROM gossip_scripts WHERE `id`=212482;
DELETE FROM gossip_menu_option WHERE `menu_id`=21248 AND `id`=1;
-- Second, insert new values.
INSERT INTO gossip_scripts (`id`,`command`,`datalong`,`datalong2`) VALUES
(212482,15,46166,1);
INSERT INTO gossip_menu_option(`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,	`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(21248,1,0,'Search the body for the pilot\'s insignia.',1,1,0,0,212482,0,0,NULL);

-- Fix NPC 32471, 32481 Rare Spawns Griegen, Aotona - HP, level values and spawns
UPDATE creature_template SET `Health_Mod`=3.3940425531914893617021276595745, `minlevel`=75, `maxlevel`=75 WHERE `entry` IN (32471,32481);
DELETE FROM creature WHERE `id` in (32471,32481);
INSERT INTO creature (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,
`position_x`,`position_y`,`position_z`,`orientation`, `spawntimesecs`,`spawndist`,`currentwaypoint`, `curhealth`, `curmana`,
`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(32471, 571, 1, 1, 0, 0, 5015.17, -1635.05, 240.015, 3.12833, 300, 0, 0, 15952, 0, 0, 0, 0, 0, 0),
(32481, 571, 1, 1, 0, 0, 5801.36, 4672.84, -107.635, 4.5334, 300, 0, 0, 15952, 0, 0, 0, 0, 0, 0);
UPDATE creature_template SET `faction_A`=2068, `faction_H`=2068 WHERE `entry`=32471;
UPDATE creature_template SET `faction_A`=14, `faction_H`=14 WHERE `entry`=32481;

-- Spawn missing Horde Wintergrasp Portal
DELETE FROM `gameobject` WHERE `id` = 193772;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(193772, 571, 1, 1, 5686.8, 773.175, 647.752, 1.83259, 0, 0, 0, 1, 180, 255, 1),
(193772, 571, 1, 1, 5923.93, 570.409, 661.087, 5.96536, 0, 0, 0.158245, -0.9874, 300, 0, 1);

-- Fix quest 10866 Zuluhed der Geschlagene, Zuluhed the Whacked, Befreien von Karynaku auf Gameobjectbenutzung umgeleitet
UPDATE `quest_template` SET `ReqCreatureOrGoId1` = -185156, `ReqSpellCast1` = 0 WHERE `entry` = 10866;


-- Fix a lot of quests - forgotten * 100 multiplier by TrinityDB
UPDATE `quest_template` SET `RewRepValue1` = `RewRepValue1` * 100 WHERE `entry` IN (8467, 8469, 9138, 9139, 9140, 9147, 9149, 9150, 9152, 9155, 9156, 9157, 9160, 9163, 9164, 9169, 9170, 9171, 9173, 9175, 9176, 9192, 9193, 9199, 9207, 9220, 9275, 9281, 9315, 10285, 10298, 10552, 12801, 12915, 12956, 13006, 13188, 13432, 13559, 13846, 24549) AND `RewRepValue1` <= 22000;
UPDATE `quest_template` SET `RewRepValue2` = `RewRepValue2` * 100 WHERE `entry` IN (9174) AND `RewRepValue2` <= 1000;

-- Fix Pit of Saron Achievements 4520, 4517
UPDATE `achievement_criteria_data` SET `type` = 12, value1 = 1 WHERE `criteria_id` IN (12747, 12748, 12749);
UPDATE `achievement_criteria_data` SET `type` = 12 WHERE `criteria_id` IN (12740, 12741, 12744);


-- Boss Moorabi should be interruptable
UPDATE `creature_template` SET `mechanic_immune_mask` = 617298815 WHERE `entry` IN (29305, 30530);


-- Spawn creatures 29694 Drachenreiterin des Hildarthings, Hyldsmeet Drakerider for quest 12886, Der Drakkensryd, The Drakkensryd
DELETE FROM `creature` WHERE `id` = 29694;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(29694, 571, 1, 1, 0, 853, 7415.96, -476.242, 1897.5, 4.94811, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7393.25, -505.455, 1897.5, 4.55306, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7382.52, -548.787, 1897.5, 3.78965, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7396.96, -582.456, 1897.63, 6.07751, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7438.66, -591.248, 1897.5, 5.6534, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7476.5, -615.165, 1895.18, 1.0439, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7446.32, -621.511, 1895.12, 2.63826, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7400.61, -618.497, 1895.15, 1.9149, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7387.9, -600.896, 1895.66, 3.07965, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7359.45, -560.873, 1895.66, 2.3131, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7341.04, -542.913, 1895.18, 0.972432, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7346.58, -503.482, 1895.09, 6.23853, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7361.06, -499.659, 1895.66, 6.23853, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7398.69, -481.223, 1898.05, 5.65733, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7405.14, -461.833, 1896.57, 1.55598, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7416.64, -445.624, 1895.15, 0.474491, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7505.07, -579.368, 1894.84, 0.602511, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7515.82, -558.482, 1894.91, 3.13071, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7486.5, -560.762, 1898.05, 3.72133, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7457.66, -475.655, 1898.05, 1.46095, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7463.05, -450.244, 1895.12, 5.9927, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7488.2, -462.459, 1895.09, 5.79007, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7474.27, -488.514, 1898.05, 5.52696, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7487.58, -511.013, 1897.5, 6.20947, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7510.79, -495.373, 1894.8, 1.02349, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7507.48, -510.9, 1895.66, 4.37713, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0);

-- Fix quest 12701, Massaker am Lichtgipfel, Massacre At Light's Point, delete wrong spawns of 28887, fix creature template of 28833, Scharlachrote Kanone, Scarlet Cannon
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 28887);
DELETE FROM `creature` WHERE `id` = 28887;
UPDATE `creature_template` SET `VehicleId` = 116 WHERE `entry` = 28833;

SET @Event:=54; -- Pilgrim`s bounty event id
SELECT MAX(`guid`) FROM `creature` INTO @GUID; -- Guid for creatures - Set by TDB

DELETE FROM `game_event` WHERE `entry`=@Event;
INSERT INTO `game_event` (`entry`,`start_time`,`end_time`,`occurence`,`length`,`holiday`,`description`,`world_event`) VALUES
(@Event,'2010-11-21 01:00:00','2020-12-31 05:00:00',525600,10020,404, 'Pilgrim''s Bounty',0);

-- Commoners spawns (Data taken from Midsummer Fire Festival - id 1)
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+68;
INSERT INTO `creature`(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,
`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(@GUID+0,20102,1,1,1,16431,0,-924.656,-3715.91,9.13173,5.06145,300,0,0,42,0,0,0),
(@GUID+1,20102,1,1,1,16431,0,-924.099,-3718,9.18514,1.69297,300,0,0,42,0,0,0),
(@GUID+2,20102,1,1,1,16431,0,-898.024,-3765.59,11.868,1.25664,300,0,0,42,0,0,0),
(@GUID+3,20102,1,1,1,16431,0,-897.124,-3763.23,11.9882,4.32842,300,0,0,42,0,0,0),
(@GUID+4,20102,1,1,1,16431,0,-1030.97,-3678.41,23.2479,1.62316,300,0,0,42,0,0,0),
(@GUID+5,20102,1,1,1,16431,0,-1031.03,-3676.2,23.1851,4.69494,300,0,0,42,0,0,0),
(@GUID+6,20102,1,1,1,16431,0,-1031.03,-3676.2,23.1851,4.69494,300,0,0,42,0,0,0),
(@GUID+7,20102,1,1,1,16431,0,-898.024,-3765.59,11.868,1.25664,300,0,0,42,0,0,0),
(@GUID+8,20102,1,1,1,16431,0,-897.124,-3763.23,11.9882,4.32842,300,0,0,42,0,0,0),
(@GUID+9,20102,1,1,1,16431,0,-924.656,-3715.91,9.13173,5.06145,300,0,0,42,0,0,0),
(@GUID+10,20102,1,1,1,16431,0,-924.099,-3718,9.18514,1.69297,300,0,0,42,0,0,0),
(@GUID+11,20102,1,1,1,16431,0,6791.34,-4747.01,701.617,2.21657,300,0,0,42,0,0,0),
(@GUID+12,20102,1,1,1,16431,0,-7144.12,-3830.95,8.50543,3.26377,300,0,0,42,0,0,0),
(@GUID+13,20102,1,1,1,16431,0,-7147.06,-3830.22,8.51396,6.05629,300,0,0,42,0,0,0),
(@GUID+14,20102,1,1,1,16431,0,-7217.57,-3735.16,8.45314,2.28638,300,0,0,42,0,0,0),
(@GUID+15,20102,1,1,1,16431,0,-7219.66,-3731.91,8.4635,5.13127,300,0,0,42,0,0,0),
(@GUID+16,20102,1,1,1,16431,0,-7182.97,-3811.81,8.80395,2.3911,300,0,0,42,0,0,0),
(@GUID+17,20102,1,1,1,16431,0,-7185.2,-3809.25,9.01346,5.51524,300,0,0,42,0,0,0),
(@GUID+18,20102,1,1,1,16431,0,-7053.62,-3777.21,10.2047,5.25344,300,0,0,42,0,0,0),
(@GUID+19,20102,1,1,1,16431,0,-7053,-3779.9,10.1478,1.53589,300,0,0,42,0,0,0),
(@GUID+20,20102,1,1,1,16431,0,-7053,-3779.9,10.1478,1.53589,300,0,0,42,0,0,0),
(@GUID+21,20102,1,1,1,16431,0,-7217.57,-3735.16,8.45314,2.28638,300,0,0,42,0,0,0),
(@GUID+22,20102,1,1,1,16431,0,-7219.66,-3731.91,8.4635,5.13127,300,0,0,42,0,0,0),
(@GUID+23,20102,1,1,1,16431,0,-7144.12,-3830.95,8.50543,3.26377,300,0,0,42,0,0,0),
(@GUID+24,20102,1,1,1,16431,0,-7147.06,-3830.22,8.51396,6.05629,300,0,0,42,0,0,0),
(@GUID+25,20102,530,1,1,16431,0,-1818.99,5305.67,-12.3448,4.03171,300,0,0,42,0,0,0),
(@GUID+26,20102,530,1,1,16431,0,-1821.12,5303.35,-12.3448,0.767945,300,0,0,42,0,0,0),
(@GUID+27,20102,530,1,1,16431,0,-1748.08,5493.86,-12.3448,4.2586,300,0,0,42,0,0,0),
(@GUID+28,20102,530,1,1,16431,0,-1747.9,5492.11,-12.3448,1.3439,300,0,0,42,0,0,0),
(@GUID+29,20102,530,1,1,16431,0,-1978.82,5365.21,-12.3448,3.63029,300,0,0,42,0,0,0),
(@GUID+30,20102,530,1,1,16431,0,-1980.72,5364.88,-12.3225,0.226893,300,0,0,42,0,0,0),
(@GUID+31,20102,530,1,1,16431,0,-1875.93,5376.2,-12.3448,0.820305,300,0,0,42,0,0,0),
(@GUID+32,20102,530,1,1,16431,0,-1875.06,5378.04,-12.3448,4.36332,300,0,0,42,0,0,0),
(@GUID+33,20102,530,1,1,16431,0,-2175.76,5414.62,50.3112,5.60251,300,0,0,42,0,0,0),
(@GUID+34,20102,530,1,1,16431,0,-2174.14,5413.06,50.3112,2.56563,300,0,0,42,0,0,0),
(@GUID+35,20102,530,1,1,16431,0,-1809.92,5418.64,-12.3448,5.55015,300,0,0,42,0,0,0),
(@GUID+36,20102,530,1,1,16431,0,-1808.36,5417.01,-12.3448,2.32129,300,0,0,42,0,0,0),
(@GUID+37,20102,530,1,1,16431,0,-1917.81,5441.85,-12.3448,2.35619,300,0,0,42,0,0,0),
(@GUID+38,20102,530,1,1,16431,0,-1920.17,5443.52,-12.3448,5.86431,300,0,0,42,0,0,0),
(@GUID+39,20102,530,1,1,16431,0,-1883.61,5769.28,129.641,4.15388,300,0,0,42,0,0,0),
(@GUID+40,20102,530,1,1,16431,0,-1884.14,5766.55,129.641,1.309,300,0,0,42,0,0,0),
(@GUID+41,20102,0,1,1,16431,0,-14440.1,509.034,26.2717,1.3439,300,0,0,42,0,0,0),
(@GUID+42,20102,0,1,1,16431,0,-14440.2,510.301,26.2619,5.07891,300,0,0,42,0,0,0),
(@GUID+43,20102,0,1,1,16431,0,-14468.7,463.642,36.9241,4.13643,300,0,0,42,0,0,0),
(@GUID+44,20102,0,1,1,16431,0,-14469.6,462.223,36.9248,0.279253,300,0,0,42,0,0,0),
(@GUID+45,20102,0,1,1,16431,0,-14313.5,508.853,8.69121,4.27606,300,0,0,42,0,0,0),
(@GUID+46,20102,0,1,1,16431,0,-14314,507.109,8.68829,1.22173,300,0,0,42,0,0,0),
(@GUID+47,20102,0,1,1,16431,0,-14468.7,463.642,36.9241,4.13643,300,0,0,42,0,0,0),
(@GUID+48,20102,0,1,1,16431,0,-14469.6,462.223,36.9248,0.279253,300,0,0,42,0,0,0),
(@GUID+49,20102,0,1,1,16431,0,-14313.5,508.853,8.69121,4.27606,300,0,0,42,0,0,0),
(@GUID+50,20102,0,1,1,16431,0,-14314,507.109,8.68829,1.22173,300,0,0,42,0,0,0),
(@GUID+51,20102,0,1,1,16431,0,-14440.1,509.034,26.2717,1.3439,300,0,0,42,0,0,0),
(@GUID+52,20102,0,1,1,16431,0,-14440.2,510.301,26.2619,5.07891,300,0,0,42,0,0,0),
(@GUID+53,19148,0,1,1,16434,0,-4900.87,-957.314,501.541,4.17134,300,0,0,42,0,0,0),
(@GUID+54,19148,0,1,1,16434,0,-4901.8,-958.955,501.543,1.01229,300,0,0,42,0,0,0),
(@GUID+55,19173,1,1,1,16435,0,9921.56,2499.58,1317.77,5.61996,300,0,0,42,0,0,0),
(@GUID+56,19173,1,1,1,16414,0,9922.97,2498.76,1317.86,2.44346,300,0,0,42,0,0,0),
(@GUID+57,19175,1,1,1,16438,0,1623.41,-4402.24,12.7889,5.68977,300,0,0,42,0,0,0),
(@GUID+58,19175,1,1,1,16436,0,1625,-4402.88,13.1966,2.60054,300,0,0,42,0,0,0),
(@GUID+59,19176,1,1,1,16432,0,-1240.55,90.6357,129.002,4.83456,300,0,0,42,0,0,0),
(@GUID+60,19176,1,1,1,16432,0,-1240.74,88.4645,129.187,2.23402,300,0,0,42,0,0,0),
(@GUID+61,19178,0,1,1,16444,0,1627.8,224.57,-43.0193,4.15388,300,0,0,42,0,0,0),
(@GUID+62,19178,0,1,1,16444,0,1626.7,222.7,-43.0193,1.01229,300,0,0,42,0,0,0),
(@GUID+63,19178,0,1,1,16444,0,1573.04,265.955,-43.0193,0.593412,300,0,0,42,0,0,0),
(@GUID+64,19178,0,1,1,16444,0,1574.55,267.583,-43.0193,3.76991,300,0,0,42,0,0,0),
(@GUID+65,18927,0,1,1,16412,0,-8837.9,553.154,95.9797,0.15708,300,0,0,42,0,0,0),
(@GUID+66,18927,0,1,1,16433,0,-8837.23,554.917,95.7154,5.044,300,0,0,42,0,0,0),
(@GUID+67,18927,0,1,1,16433,0,-8854.78,649.83,96.7417,1.43117,300,0,0,42,0,0,0),
(@GUID+68,18927,0,1,1,16433,0,-8855.72,651.851,96.6895,5.70723,300,0,0,42,0,0,0);
-- Set them spawned only during Pilgrim`s bounty event
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+68;
INSERT INTO `game_event_creature`(`guid`,`event`) VALUES
(@GUID+0,@Event),
(@GUID+1,@Event),
(@GUID+2,@Event),
(@GUID+3,@Event),
(@GUID+4,@Event),
(@GUID+5,@Event),
(@GUID+6,@Event),
(@GUID+7,@Event),
(@GUID+8,@Event),
(@GUID+9,@Event),
(@GUID+10,@Event),
(@GUID+11,@Event),
(@GUID+12,@Event),
(@GUID+13,@Event),
(@GUID+14,@Event),
(@GUID+15,@Event),
(@GUID+16,@Event),
(@GUID+17,@Event),
(@GUID+18,@Event),
(@GUID+19,@Event),
(@GUID+20,@Event),
(@GUID+21,@Event),
(@GUID+22,@Event),
(@GUID+23,@Event),
(@GUID+24,@Event),
(@GUID+25,@Event),
(@GUID+26,@Event),
(@GUID+27,@Event),
(@GUID+28,@Event),
(@GUID+29,@Event),
(@GUID+30,@Event),
(@GUID+31,@Event),
(@GUID+32,@Event),
(@GUID+33,@Event),
(@GUID+34,@Event),
(@GUID+35,@Event),
(@GUID+36,@Event),
(@GUID+37,@Event),
(@GUID+38,@Event),
(@GUID+39,@Event),
(@GUID+40,@Event),
(@GUID+41,@Event),
(@GUID+42,@Event),
(@GUID+43,@Event),
(@GUID+44,@Event),
(@GUID+45,@Event),
(@GUID+46,@Event),
(@GUID+47,@Event),
(@GUID+48,@Event),
(@GUID+49,@Event),
(@GUID+50,@Event),
(@GUID+51,@Event),
(@GUID+52,@Event),
(@GUID+53,@Event),
(@GUID+54,@Event),
(@GUID+55,@Event),
(@GUID+56,@Event),
(@GUID+57,@Event),
(@GUID+58,@Event),
(@GUID+59,@Event),
(@GUID+60,@Event),
(@GUID+61,@Event),
(@GUID+62,@Event),
(@GUID+63,@Event),
(@GUID+64,@Event),
(@GUID+65,@Event),
(@GUID+66,@Event),
(@GUID+67,@Event),
(@GUID+68,@Event);
-- Now quests they give
-- Quests offered only during the event
DELETE FROM `game_event_creature_quest` WHERE `quest` IN(14022,14036);
INSERT INTO `game_event_creature_quest` (`id`,`quest`,`event`) VALUES
(18927,14022,@Event), -- Aliance quest
(19148,14022,@Event),
(19171,14022,@Event),
(19173,14022,@Event),
(20102,14022,@Event),
(19169,14036,@Event), -- Horde quest
(19175,14036,@Event),
(19176,14036,@Event),
(19178,14036,@Event),
(20102,14036,@Event);
-- Sets the dailys from the event: "Pilgrim's Bounty" for Horde.
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `entry` IN (14059,14061,14062,14060,14058);
-- Sets the dailys from the event: "Pilgrim's Bounty" for Alliance.
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (14053,14048,14051,14055,14054);
-- Sets all those NPC's that should have a quest giver and a trainer flag, A quest giver and a trainer flag.
UPDATE `creature_template` SET `npcflag`=`npcflag`|19 WHERE `entry` IN(
-- Horde
34712,
34713,
34714,
34768,
-- Alliance
34710,
34708,
34744,
34711);
-- Insert the creatures that starts and finish the dailys.
DELETE FROM `creature_involvedrelation` WHERE `id` IN (34712,34713,34714,34768,34710,34744,34708,34711);
INSERT INTO `creature_involvedrelation` (`id`,`quest`) VALUES 
-- Horde
(34712,14059),
(34713,14061),
(34713,14062),
(34714,14060),
(34768,14058),
-- Alliance
(34710,14053),
(34708,14048),
(34708,14051),
(34744,14055),
(34711,14054);
-- Insert the quests that they will be only available during the event.
DELETE FROM `game_event_creature_quest`WHERE  `id` IN (34712,34713,34714,34768,34710,34744,34708,34711);
INSERT INTO `game_event_creature_quest` (`id`,`quest`,`event`) VALUES
-- Horde
(34712,14059,@Event),
(34713,14061,@Event),
(34713,14062,@Event),
(34714,14060,@Event),
(34768,14058,@Event),
-- Alliance
(34710,14053,@Event),
(34708,14048,@Event),
(34708,14051,@Event),
(34744,14055,@Event),
(34711,14054,@Event);
-- Sets Wild Turkey and Lonely Turkey neutral.
UPDATE `creature_template` SET `faction_A`=31,`faction_H`=31 WHERE `entry` IN (32820,32956);
-- Adds the loot to those turkeys.
SET @turkey:=32820; -- Wild Turkey
SET @turkey2:=32956; -- Lonely Turkey
DELETE FROM `creature_loot_template` WHERE `entry` IN (32820,32956);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(@turkey,44834,100,1,0,1,1),
(@turkey2,44834,100,1,0,1,1);
-- Sets loot id for those turkeys.
UPDATE `creature_template` SET `lootid`=32820 WHERE `entry`=32820;
UPDATE `creature_template` SET `lootid`=32956 WHERE `entry`=32956;
-- Set Bountiful Table untargetable flag.
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry`=32823;
-- Sets the chains from the event: "Pilgrim's Bounty" for Horde.
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `entry` IN (14037,14040,14041,14043,14044,14047);
-- Sets the chains from the event: "Pilgrim's Bounty" for Alliance.
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (14023,14024,14028,14030,14033,14035);
-- Sets the quests in chain.
-- Alliance
UPDATE `quest_template` SET `PrevQuestId`=14023 WHERE `Entry`=14024;
UPDATE `quest_template` SET `PrevQuestId`=14024 WHERE `Entry`=14028;
UPDATE `quest_template` SET `PrevQuestId`=14028 WHERE `Entry`=14030;
UPDATE `quest_template` SET `PrevQuestId`=14030 WHERE `Entry`=14033;
UPDATE `quest_template` SET `PrevQuestId`=14033 WHERE `Entry`=14035;
-- Horde
UPDATE `quest_template` SET `PrevQuestId`=14037 WHERE `Entry`=14040;
UPDATE `quest_template` SET `PrevQuestId`=14040 WHERE `Entry`=14041;
UPDATE `quest_template` SET `PrevQuestId`=14041 WHERE `Entry`=14043;
UPDATE `quest_template` SET `PrevQuestId`=14043 WHERE `Entry`=14044;
UPDATE `quest_template` SET `PrevQuestId`=14044 WHERE `Entry`=14047;
-- Adds the creature involved for the Chain Quests of the event: "Pilgrim's Bounty".
DELETE FROM `creature_involvedrelation` WHERE `id` IN (34768,34677,34679,34678,34675,34744,34644,34676);
INSERT INTO `creature_involvedrelation` (`id`,`quest`) VALUES 
-- Horde
(34768,14037),
(34679,14040),
(34678,14041),
(34679,14043),
(34677,14047),
(34679,14047),
-- Alliance
(34744,14023),
(34644,14024),
(34744,14028),
(34676,14030),
(34675,14033),
(34676,14035);
 -- Insert the quest relation that are only available during the event
DELETE FROM `game_event_creature_quest` WHERE `id` IN (34768,34679,34678,34677,34644,34744,34675,34676);
INSERT INTO `game_event_creature_quest` (`id`,`quest`,`event`) VALUES
(34768,14037,@Event),
(34677,14037,@Event),
(34768,14040,@Event),
(34679,14040,@Event),
(34679,14041,@Event),
(34678,14041,@Event),
(34678,14043,@Event),
(34679,14043,@Event),
(34679,14044,@Event),
(34677,14044,@Event),
(34677,14047,@Event),
(34679,14047,@Event),
-- Alliance
(34675,14023,@Event),
(34744,14023,@Event),
(34744,14024,@Event),
(34644,14024,@Event),
(34644,14028,@Event),
(34744,14028,@Event),
(34744,14030,@Event),
(34676,14030,@Event),
(34676,14033,@Event),
(34675,14033,@Event),
(34675,14035,@Event),
(34676,14035,@Event);
-- Sets all those NPC's a quest giver flag.
-- Trainers and Quest-Givers.
UPDATE `creature_template` SET `npcflag`=`npcflag`|19 WHERE `entry` IN(
34708, -- Caitrin Ironkettle
34710, -- Ellen Moore
34714, -- Mahara Goldwheat
34711, -- Mary Allerton
34713, -- Ondani Greatmill
34712); -- Roberta Carter
-- Quest-Givers only.
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN(
-- Horde
34677,
34678,
34679,
34768,
-- Alliance
34675,
34733,
34644,
34744,
34676);
-- Sets vendor table for the vendors in the event: "Pilgrim's Bounty"
SET @Barrel:=35342; -- Bountiful Barrel <Pilgrim's Bounty Supplies>
SET @Barrel2:=35343;
SET @Barrel3:=35341;
SET @Barrel4:=35340;
SET @Barrel5:=35338;
SET @Barrel6:=35337;
DELETE FROM `npc_vendor` WHERE `entry` IN (35342,35343,35341,35340,35338,35337);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES 
-- Horde
(@Barrel,0,46810,0,0,0), -- Bountiful Cookbook
(@Barrel,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel,0,46888,0,0,0), -- Bountiful Basket
(@Barrel,0,44853,0,0,0), -- Honey
(@Barrel,0,2678,0,0,0), -- Mild Spices
(@Barrel,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel,0,30817,0,0,0), -- Simple Flour
(@Barrel,0,46793,0,0,0), -- Tangy Southfury Cranberries
(@Barrel2,0,46810,0,0,0), -- Bountiful Cookbook
(@Barrel2,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel2,0,46888,0,0,0), -- Bountiful Basket
(@Barrel2,0,44853,0,0,0), -- Honey
(@Barrel2,0,2678,0,0,0), -- Mild Spices
(@Barrel2,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel2,0,30817,0,0,0), -- Simple Flour
(@Barrel2,0,46797,0,0,0), -- Mulgore Sweet Potato
(@Barrel3,0,46810,0,0,0), -- Bountiful Cookbook
(@Barrel3,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel3,0,46888,0,0,0), -- Bountiful Basket
(@Barrel3,0,44853,0,0,0), -- Honey
(@Barrel3,0,2678,0,0,0), -- Mild Spices
(@Barrel3,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel3,0,30817,0,0,0), -- Simple Flour
(@Barrel3,0,46796,0,0,0), -- Ripe Tirisfal Pumpkin
-- Alliance
(@Barrel4,0,46809,0,0,0), -- Bountiful Cookbook
(@Barrel4,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel4,0,46888,0,0,0), -- Bountiful Basket
(@Barrel4,0,44853,0,0,0), -- Honey
(@Barrel4,0,2678,0,0,0), -- Mild Spices
(@Barrel4,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel4,0,30817,0,0,0), -- Simple Flour
(@Barrel4,0,44854,0,0,0), -- Tangy Wetlands Cranberries
(@Barrel5,0,46809,0,0,0), -- Bountiful Cookbook
(@Barrel5,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel5,0,46888,0,0,0), -- Bountiful Basket
(@Barrel5,0,44853,0,0,0), -- Honey
(@Barrel5,0,2678,0,0,0), -- Mild Spices
(@Barrel5,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel5,0,30817,0,0,0), -- Simple Flour
(@Barrel5,0,44855,0,0,0), -- Teldrassil Sweet Potato
(@Barrel6,0,46809,0,0,0), -- Bountiful Cookbook
(@Barrel6,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel6,0,46888,0,0,0), -- Bountiful Basket
(@Barrel6,0,44853,0,0,0), -- Honey
(@Barrel6,0,2678,0,0,0), -- Mild Spices
(@Barrel6,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel6,0,30817,0,0,0), -- Simple Flour
(@Barrel6,0,46784,0,0,0); -- Ripe Elwynn Pumpkin

-- Vendors:
SET @Dalni:=34685; -- Dalni Tallgrass
SET @Elizabeth:=34645; -- Elizabeth Barker Winslow
SET @Ikaneba:=34681; -- Ikaneba Summerset
SET @John:=34787; -- John Rigsdale
SET @Laha:=34684; -- Laha Farplain
SET @Ranisa:=34783; -- Ranisa Whitebough
SET @Rose:=34683; -- Rose Standish
SET @Wilmina:=34682; -- Wilmina Holbeck
DELETE FROM `npc_vendor` WHERE `entry` IN (34685,34645,34681,34787,34684,34783,34683,34682);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES 
-- Horde
(@Dalni,0,46810,0,0,0), -- Bountiful Cookbook
(@Dalni,0,44835,0,0,0), -- Autumnal Herbs
(@Dalni,0,46888,0,0,0), -- Bountiful Basket
(@Dalni,0,44853,0,0,0), -- Honey
(@Dalni,0,2678,0,0,0), -- Mild Spices
(@Dalni,0,159,0,0,0), -- Refreshing Spring Water
(@Dalni,0,30817,0,0,0), -- Simple Flour
(@Dalni,0,46793,0,0,0), -- Tangy Southfury Cranberries
(@John,0,46810,0,0,0), -- Bountiful Cookbook
(@John,0,44835,0,0,0), -- Autumnal Herbs
(@John,0,46888,0,0,0), -- Bountiful Basket
(@John,0,44853,0,0,0), -- Honey
(@John,0,2678,0,0,0), -- Mild Spices
(@John,0,159,0,0,0), -- Refreshing Spring Water
(@John,0,30817,0,0,0), -- Simple Flour
(@Laha,0,46810,0,0,0), -- Bountiful Cookbook
(@Laha,0,44835,0,0,0), -- Autumnal Herbs
(@Laha,0,46888,0,0,0), -- Bountiful Basket
(@Laha,0,44853,0,0,0), -- Honey
(@Laha,0,2678,0,0,0), -- Mild Spices
(@Laha,0,159,0,0,0), -- Refreshing Spring Water
(@Laha,0,30817,0,0,0), -- Simple Flour
(@Laha,0,46797,0,0,0), -- Mulgore Sweet Potato
(@Rose,0,46810,0,0,0), -- Bountiful Cookbook
(@Rose,0,44835,0,0,0), -- Autumnal Herbs
(@Rose,0,46888,0,0,0), -- Bountiful Basket
(@Rose,0,44853,0,0,0), -- Honey
(@Rose,0,2678,0,0,0), -- Mild Spices
(@Rose,0,159,0,0,0), -- Refreshing Spring Water
(@Rose,0,30817,0,0,0), -- Simple Flour
(@Rose,0,46796,0,0,0), -- Ripe Tirisfal Pumpkin
-- Alliance
(@Elizabeth,0,46809,0,0,0), -- Bountiful Cookbook
(@Elizabeth,0,44835,0,0,0), -- Autumnal Herbs
(@Elizabeth,0,46888,0,0,0), -- Bountiful Basket
(@Elizabeth,0,44853,0,0,0), -- Honey
(@Elizabeth,0,2678,0,0,0), -- Mild Spices
(@Elizabeth,0,159,0,0,0), -- Refreshing Spring Water
(@Elizabeth,0,30817,0,0,0), -- Simple Flour
(@Elizabeth,0,44854,0,0,0), -- Tangy Wetlands Cranberries
(@Ikaneba,0,46809,0,0,0), -- Bountiful Cookbook
(@Ikaneba,0,44835,0,0,0), -- Autumnal Herbs
(@Ikaneba,0,46888,0,0,0), -- Bountiful Basket
(@Ikaneba,0,44853,0,0,0), -- Honey
(@Ikaneba,0,2678,0,0,0), -- Mild Spices
(@Ikaneba,0,159,0,0,0), -- Refreshing Spring Water
(@Ikaneba,0,30817,0,0,0), -- Simple Flour
(@Ikaneba,0,44855,0,0,0), -- Teldrassil Sweet Potato
(@Ranisa,0,46810,0,0,0), -- Bountiful Cookbook
(@Ranisa,0,44835,0,0,0), -- Autumnal Herbs
(@Ranisa,0,46888,0,0,0), -- Bountiful Basket
(@Ranisa,0,44853,0,0,0), -- Honey
(@Ranisa,0,2678,0,0,0), -- Mild Spices
(@Ranisa,0,159,0,0,0), -- Refreshing Spring Water
(@Ranisa,0,30817,0,0,0), -- Simple Flour
(@Wilmina,0,46809,0,0,0), -- Bountiful Cookbook
(@Wilmina,0,44835,0,0,0), -- Autumnal Herbs
(@Wilmina,0,46888,0,0,0), -- Bountiful Basket
(@Wilmina,0,44853,0,0,0), -- Honey
(@Wilmina,0,2678,0,0,0), -- Mild Spices
(@Wilmina,0,159,0,0,0), -- Refreshing Spring Water
(@Wilmina,0,30817,0,0,0), -- Simple Flour
(@Wilmina,0,46784,0,0,0); -- Ripe Elwynn Pumpkin

-- Fix creature 19527, Schwingender Leerrufer, Vacillating Voidcaller, was unattackable
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 19527;

-- Sperre Instanzen ueber disable Funktion - 9.12.2010
DELETE FROM `disables` WHERE `sourceType` = 2;
INSERT INTO `disables` (sourceType, entry, flags, comment) VALUES
(2, 575, 3, 'Utgarde Pinnacle (entrance)'),
(2, 578, 3, 'The Oculus (entrance)'),
(2, 580, 1, 'Sunwell Plateau (Entrance)'),
(2, 600, 3, 'Drak\'Tharon Keep (entrance)'),
(2, 601, 3, 'Azjol-Nerub (entrance)'),
(2, 603, 3, 'Ulduar Raid entrance'),
(2, 616, 3, 'The Eye of Eternity (entrance)'),
(2, 619, 3, 'Ahn\'Kahet (entrance)'),
(2, 631, 15, 'IceCrown Citadel (Entrance)'),
(2, 658, 3, 'Pit of Saron (Entrance)'),
(2, 668, 3, 'Halls of Reflection (Entrance)'),
(2, 724, 15, 'The Ruby Sanctum (Entrance)');

-- Fix quest 7429, Rettet Knot! Free Knot!, fix reputation gain amount
UPDATE `quest_template` SET `RewRepFaction1` = 169, `RewRepFaction2` = 0, `RewRepFaction3` = 0, `RewRepFaction4` = 0, `RewRepValueId1` = 0, `RewRepValueId2` = 0, `RewRepValueId3` = 0, `RewRepValueId4` = 0, `RewRepValue1` = 35000, `RewRepValue2` = 0, `RewRepValue3` = 0, `RewRepValue4` = 0 WHERE `entry` = 7429;

-- Make gifts really lootable
UPDATE `item_template` SET `Flags` = 516 WHERE `entry` IN (5043, 5044, 17302, 17305, 17308);

-- Delete invisible attacking mobs in tausendwinter / 1kw / wintergrasp, ID 27869, Wintergrasp Detection Unit
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 27869);
DELETE FROM `creature` WHERE `id` = 27869;

-- Fix spirit guides in 1kw / Tausendwinter / Wintergrasp : Taunka Spirit Guide (31841) / Alliance Spirit Guide (31842)
UPDATE `creature_template` SET `unit_flags` = 2147484482, `flags_extra` = 2 WHERE `entry` IN (31841, 31842);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (31841, 31842));
DELETE FROM `creature` WHERE `id` IN (31841, 31842);
DELETE FROM `creature_template_addon` WHERE `entry` IN (31841, 31842);
INSERT INTO `creature_template_addon` (entry, path_id, mount, bytes1, bytes2, emote, auras) VALUES
(31841, 0, 0, 0, 1, 0, '58729 0'),
(31842, 0, 0, 0, 1, 0, '58729 0');
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(31841, 571, 1, 1, 0, 0, 5538, 2895.81, 517.055, 1.58009, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 5099.03, 3469.67, 368.485, 5.09316, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 4331.75, 3235.64, 390.251, 5.96887, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 4315.11, 2409.94, 392.64, 5.59188, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 5097.25, 2299.2, 368.485, 0.259043, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 5031.83, 3711.34, 372.43, 3.84281, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31842, 571, 1, 1, 0, 0, 5031.83, 3711.34, 372.43, 3.84281, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0);

-- All Training Dummies should not give a weapon skill gain
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 262144 WHERE `ScriptName` = 'npc_training_dummy';

-- Missing spawn Geistheiler / Spirit Healer 6491 in Grizzly Hills / Grizzlyhügel
DELETE FROM `creature` WHERE `id` = 6491 AND `map` = 571 AND `position_x` BETWEEN 4100 AND 4130 AND `position_y` BETWEEN -4830 AND -4800 AND `position_z` BETWEEN 65 AND 90;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(6491, 571, 1, 1, 0, 0, 4113.77, -4816.64, 76.0587, 0.0547746, 300, 0, 0, 4120, 0, 0, 0, 0, 0, 0);