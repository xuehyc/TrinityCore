-- Implement castle_log, Castle Log, Stasi Bot
DROP TABLE IF EXISTS `characters`.`castle_log`;
CREATE TABLE  `characters`.`castle_log` (
  `player_guid` int(10) unsigned NOT NULL DEFAULT '0',
  `player_name` varchar(12) NOT NULL DEFAULT '',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  `data1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `data2` int(10) unsigned NOT NULL DEFAULT '0',
  `data3` int(10) unsigned NOT NULL DEFAULT '0',
  `data4` char(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Castle Log System';

-- Fix NPC 19919, 19920 Thorn Lasher / Thorn Flayer / Dornpeitscher / Dornschinder - Bossfight Laj 17980 in Die Botanika / The Botanica
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` IN (19920, 19919, 21579, 21580);

-- Remove Spectral Gryphon 55164 from area 4197 Wintergrasp / 1KW / Tausendwinter
DELETE FROM `spell_area` WHERE `spell` = 55164 AND `area` = 4197;
-- Set spawntime of Turmkannone von Tausendwinter / Wintergrasp Tower cannon to 4 minutes (+1 minute despawn timer)
UPDATE `creature` SET `spawntimesecs` = 240 WHERE `id` = 28366;

-- Fix creature 32593 Skittering Swarmer / Huschender Schwärmer - set no xp at kill flag
UPDATE `creature_template` SET `flags_extra` = 64 WHERE `entry` = 32593;

-- Fix level bug for some creatures in icecrown - set no xp at kill flag
UPDATE `creature_template` SET `flags_extra` = 64 WHERE `entry` IN (31263, 31304, 31273);

-- Fix quest 13149 Illusionen bannen / Dispelling Illusions - CoT / HDZ 4 / Culling of Stratholme / Ausmerzen von Stratholme instance / Instanz
UPDATE `quest_template` SET `ReqCreatureOrGoId1` = 27827 WHERE `entry` = 13149;

-- Set Spirit Healer / Geistheiler for Zone Ironforge / Eisenschmiede for Alliance / Allianz
DELETE FROM `game_graveyard_zone` WHERE `id` = 852 AND `ghost_zone` = 1537 AND `faction` = 469;
INSERT INTO `game_graveyard_zone` (id, ghost_zone, faction) VALUES
(852, 1537, 469);

-- Apply immunities to all Draktharon instance / Instanz bosses
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (27483, 31349, 26630, 31362, 26632, 31360, 26631, 31350);

-- Disable achievement 2057 / Criteria 7361 Oh Novos! in Draktharon instance / Instanz
DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` = 7361;
INSERT INTO `disables` (sourceType, entry, flags, params_0, params_1, comment) VALUES
(4, 7361, 0, '', '', 'Disable Achievement 2057 / Criteria 7361 Oh Novos!');

-- Disable achievement 2151 / Criteria 7579 Verzehren in Ehren / Consumption Junction in Draktharon instance / Instanz
DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` = 7579;
INSERT INTO `disables` (sourceType, entry, flags, params_0, params_1, comment) VALUES
(4, 7579, 0, '', '', 'Disable Achievement 2151 / Criteria 7579 Verzehren in Ehren / Consumption Junction');

-- Fix dungeon browser boss identification in instance / Instanz Draktharon
DELETE FROM `instance_encounters` WHERE `creditEntry` = 61863 OR `entry` IN (375, 376);
INSERT INTO `instance_encounters` (entry, creditType, creditEntry, lastEncounterDungeon, comment) VALUES
(375, 0, 26632, 214, 'The Prophet Tharon\'ja'),
(376, 0, 26632, 215, 'The Prophet Tharon\'ja');

-- Insert Frozen Orb / Gefrorene Kugel into Prophet Tharon'ja loot in instance / Instanz Draktharon
DELETE FROM `creature_loot_template` WHERE `entry` = 31360 AND `item` = 43102;
INSERT INTO `creature_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(31360, 43102, 100, 1, 0, 1, 1);

-- Disable Spell 61717 - Hasenkostüm / Rabbit Costume - is not removable, although it should be
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 61717;
INSERT INTO `disables` (sourceType, entry, flags, params_0, params_1, comment) VALUES
(0, 61717, 1, '', '', 'Spell - Hasenkostuem, kann nicht entfernt werden');

-- Fix quest 11893 The Power of the Elements / Die Macht der Elemente - change kill quest requirement
UPDATE `quest_template` SET `ReqCreatureOrGoID1` = 24601 WHERE `entry` = 11893;

-- Fix quest 11899 Souls of the Decursed / Seelen der vom Fluch befreiten - Set correct target type and correct quest requirements for it
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 18 AND `SourceEntry` = 35401;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(18, 0, 35401, 0, 24, 2, 25814, 0, 0, 0, '');
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 25814, `ReqSpellCast1` = 46485 WHERE `entry` = 11899;

-- Fix NPC 5089 Balos Jacken - set change faction cap in event ai script to 50 percent of health instead of 20 percent
UPDATE `creature_ai_scripts` SET `event_param1` = 50 WHERE `id` = 508901 AND `creature_id` = 5089 AND `event_type` = 2;

-- Professor Putricide / Professor Seuchenmord in instance / Instanz ICC / Icecrown Citadel / Eiskronenzitadelle encounter fixes
-- Fix Malleable Ooze / Formbarer Schlamm ability
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0, `faction_A` = 14, `faction_H` = 14, `minlevel` = 80, `maxlevel` = 80, `speed_walk` = 0.82, `speed_run` = 0.82, `unit_flags` = 33554432, `type_flags` = 0, `InhabitType` = 3, `ScriptName` = 'npc_malleable_ooze' WHERE `entry` = 38556;
-- Fix Mutated Plague / Mutierte Seuche ability
DELETE FROM `spell_script_names` WHERE spell_id IN (72454, 72507, 72464, 72506);
INSERT INTO `spell_script_names` (spell_id, ScriptName) VALUES
(72454, 'spell_putricide_mutated_plague_effect'),
(72507, 'spell_putricide_mutated_plague_effect'),
(72464, 'spell_putricide_mutated_plague_effect'),
(72506, 'spell_putricide_mutated_plague_effect');
-- Fix stats and immunities
UPDATE `creature_template` SET `dmg_multiplier` = 35, `mechanic_immune_mask` = 650853247 WHERE `entry` = 36678;
-- Fix adds Gas Cloud / Volatile Ooze - Gaswolke / Flüchtiger Schlamm
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (37562, 37697, 38602, 38760, 38761, 38604, 38758, 38759);

-- Fix missing spawn of NPC 6491 Spirit Healer / Geistheiler in Eastern Plaguelands
DELETE FROM `creature` WHERE `map` = 0 AND `id` = 6491 AND `position_x` > 2050 AND `position_x` < 2085 AND `position_y` < -5010 AND `position_y` > -5030;
INSERT INTO `creature` (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(6491, 0, 1, 1, 0, 0, 2061.96, -5019.47, 73.6905, 3.23894, 300, 0, 0, 4120, 0, 0, 0, 0, 0, 0);

-- Set loot chance of PDK / ToCR / Trial of the Crusader recipes to 1,5 per run
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 25 WHERE `mincountOrRef` IN (-34300, -34314, -34328);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 25 WHERE `mincountOrRef` IN (-34300, -34314, -34328);

-- Remove NPC 27761 Kriegsross von Fordragon / Fordragon Battle Steed - could be bugused to ride with increased speed and pass all enemies without beeing seen
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 27761);
DELETE FROM `creature` WHERE `id` = 27761;

-- Cleanup spell_proc_event data - fix errors caused by an old fix attempt
DELETE FROM `spell_proc_event` WHERE `entry` IN (33953, 49622, 57352, 58901, 59787, 59818, 60487, 60537, 64764, 64786, 64792, 65013, 67702, 67771, 71571, 71573, 71576, 71578, 72415);
INSERT INTO `spell_proc_event` (entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown) VALUES
(33953, 0, 0, 0, 0, 0, 278528, 0, 0, 0, 45),
(49622, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60),
(57352, 0, 0, 0, 0, 0, 332116, 0, 0, 0, 45),
(58901, 0, 0, 0, 0, 0, 0, 2, 0, 0, 45),
(60487, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15),
(60537, 0, 0, 0, 0, 0, 0, 2, 0, 0, 45),
(64786, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15),
(64792, 0, 0, 0, 0, 0, 0, 2, 0, 0, 45),
(65013, 0, 0, 0, 0, 0, 0, 2, 0, 0, 45),
(67702, 1, 0, 0, 0, 0, 8720724, 3, 0, 35, 45),
(67771, 1, 0, 0, 0, 0, 8720724, 3, 0, 35, 45);

-- Set loot chance of item 35188 Nesingwary Lackey Ear / Ohr von Nesingwarys Lakai always to positive, needed for quest 11867 Can't Get Ear-nough... / Spitzt die Ohren
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -ChanceOrQuestChance WHERE `item` = 35188 AND `ChanceOrQuestChance` < 0;

-- Fix reputation gain for creatures 19964, 19958 Red Seedling / White Seedling, Roter Setzling / Weißer Setzling in instance / Instanz Botanika / Botanica
UPDATE `creature_onkill_reputation` SET `RewOnKillRepFaction1` = 935, `MaxStanding1` = 7, `TeamDependent` = 0 WHERE `creature_id` IN (19958, 19964);

-- Fixes for Blood Prince Council / Rat des Blutes and nearby trash in instance / Instanz Icecrown Citadel / Eiskronenzitadelle / ICC
-- Make all trigger creatures invisible to players
UPDATE `creature_template` SET `modelid2` = 0 WHERE `entry` IN (38008, 30298, 38369, 38332, 38451, 38458, 38454, 38422, 38463);
UPDATE `creature_template` SET `modelid1` = 11686 WHERE `entry` IN (30298, 38463);
-- Set unattackable and unselectable flags if possible
UPDATE `creature_template` SET `unit_flags` = 33554434 WHERE `entry` IN (38008, 38332, 38451, 38458, 38422, 38463);
-- Set default immunities for bosses and attackable adds
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (37970, 37972, 37973, 38454, 38369);
-- Trash AI and flags
UPDATE `creature_template` SET `flags_extra` = 0, `unit_flags` = 0, `type_flags` = 0, `AIName` = 'SmartAI' WHERE `entry` IN (37664, 37663, 37595, 37571, 37662, 37665, 37666);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (37664, 37663, 37595, 37571, 37662, 37665, 37666) AND `source_type` = 0;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
-- 37664: Darkfallen Archmage <The San'layn> / Sinistrer Erzmagier <Die San'layn>
(37664, 0, 0, 0, 0, 0, 60, 10, 10000, 15000, 35000, 45000, 11, 70408, 0, 0, 0, 0, 0, 11, 0, 50, 0, 0, 0, 0, 0, 'Cast Amplify Magic (10) to ally target'),
(37664, 0, 1, 0, 0, 0, 60, 20, 10000, 15000, 35000, 45000, 11, 72336, 0, 0, 0, 0, 0, 11, 0, 50, 0, 0, 0, 0, 0, 'Cast Amplify Magic (25) to ally target'),
(37664, 0, 2, 0, 0, 0, 90, 10, 8000, 12000, 8000, 12000, 11, 70407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Blast Wave (10) to self target'),
(37664, 0, 3, 0, 0, 0, 90, 20, 8000, 12000, 8000, 12000, 11, 71151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Blast Wave (25) to self target'),
(37664, 0, 4, 0, 0, 0, 100, 10, 3000, 6000, 4000, 8000, 11, 70409, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Fireball (10) to random target'),
(37664, 0, 5, 0, 0, 0, 100, 20, 3000, 6000, 4000, 8000, 11, 71153, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Fireball (25) to random target'),
(37664, 0, 6, 0, 0, 0, 80, 30, 10000, 15000, 15000, 25000, 11, 70410, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Polymorph:Spider to random target'),
-- 37663: Darkfallen Noble <The San'layn> / Sinistrer Adeliger <Die San'layn>
(37663, 0, 0, 0, 0, 0, 100, 10, 5000, 10000, 4000, 8000, 11, 72960, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Shadow Bolt (10) to current target'),
(37663, 0, 1, 0, 0, 0, 100, 20, 5000, 10000, 4000, 8000, 11, 72961, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Shadow Bolt (25) to current target'),
(37663, 0, 2, 0, 0, 0, 100, 30, 5000, 10000, 10000, 20000, 11, 70645, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Chains of Shadow to random target'),
-- 37595: Darkfallen Blood Knight <The San'layn> / Sinistrer Blutritter <Die San'layn>
(37595, 0, 0, 0, 0, 0, 90, 30, 5000, 10000, 5000, 10000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Unholy Strike to current target'),
(37595, 0, 1, 0, 4, 0, 100, 30, 0, 0, 0, 0, 11, 71736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Vampiric Aura on self target on aggro'),
-- 37571: Darkfallen Advisor <The San'layn> / Sinistrer Berater <Die San'layn>
(37571, 0, 0, 0, 0, 0, 100, 10, 5000, 10000, 4000, 8000, 11, 72057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Lich Slap (10) to current target'),
(37571, 0, 1, 0, 0, 0, 100, 20, 5000, 10000, 4000, 8000, 11, 72421, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Lich Slap (25) to current target'),
(37571, 0, 2, 0, 0, 0, 80, 30, 5000, 10000, 25000, 35000, 11, 72065, 0, 0, 0, 0, 0, 11, 0, 40, 0, 0, 0, 0, 0, 'Cast Shroud of Protection to ally target'),
(37571, 0, 3, 0, 0, 0, 80, 30, 5000, 10000, 25000, 35000, 11, 72066, 0, 0, 0, 0, 0, 11, 0, 40, 0, 0, 0, 0, 0, 'Cast Shroud of Spell Warding to ally target'),
-- 37662: Darkfallen Commander <The San'layn> / Sinistrer Kommandant <Die San'layn>
(37662, 0, 0, 0, 0, 0, 100, 10, 1000, 5000, 8000, 12000, 11, 70449, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Vampire Charge (10) to random target'),
(37662, 0, 1, 0, 0, 0, 100, 20, 1000, 5000, 8000, 12000, 11, 71155, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Vampire Charge (25) to random target'),
(37662, 0, 2, 0, 0, 0, 100, 30, 5000, 10000, 30000, 30000, 11, 70750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Battle Shout to self target'),
-- 37665: Darkfallen Lieutenant <The San'layn> / Sinistrer Leutnant <Die San'layn>
(37665, 0, 0, 0, 0, 0, 100, 10, 5000, 10000, 2000, 6000, 11, 70435, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Rend Flesh (10) to random target'),
(37665, 0, 1, 0, 0, 0, 100, 20, 5000, 10000, 2000, 6000, 11, 71154, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Rend Flesh (25) to random target'),
-- 37666: Darkfallen Tactican <The San'layn> / Sinistrer Taktiker <Die San'layn>
(37666, 0, 0, 0, 0, 0, 90, 30, 5000, 10000, 5000, 10000, 11, 70437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Unholy Strike to current target'),
(37666, 0, 1, 0, 0, 0, 100, 30, 3000, 8000, 10000, 15000, 11, 70432, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Blood Sap to random target');
-- Disable movement of some trashs, could attack during encounter
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (201501, 201001);
DELETE FROM `creature_addon` WHERE `guid` IN (201501, 201001);
DELETE FROM `waypoint_data` WHERE `id` IN (2015010, 2010010);
-- Link all creatures respawn
DELETE FROM `linked_respawn` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (37664, 37663, 37595, 37571, 37662, 37665, 37666));
INSERT INTO `linked_respawn` (guid, linkedGuid, linkType) VALUES
-- Link lower trash to Valanar
(201238, 201577, 0),
(201444, 201577, 0),
(201479, 201577, 0),
(201646, 201577, 0),
(201259, 201577, 0),
(201396, 201577, 0),
(201659, 201577, 0),
(201482, 201577, 0),
(201314, 201577, 0),
(201458, 201577, 0),
(201307, 201577, 0),
(201673, 201577, 0),
-- Link upper trash to Lanathel
(201275, 201246, 0),
(201589, 201246, 0),
(201296, 201246, 0),
(201530, 201246, 0),
(201604, 201246, 0),
(201446, 201246, 0),
(201640, 201246, 0),
(201218, 201246, 0),
(201306, 201246, 0),
(201553, 201246, 0),
(201335, 201246, 0),
(201385, 201246, 0),
(201595, 201246, 0),
(201630, 201246, 0),
(201001, 201246, 0),
(201501, 201246, 0),
(201346, 201246, 0),
(201550, 201246, 0);

-- Set spawntime for all Northrend herbs and minerals to 5 minutes
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` IN (189973,189978,189979,189980,189981,190169,190170,190171,190172,190173,190175,190176,191019,191133,191303);

-- Fix Item 36771 Stabile Kiste / Sturdy Crates with spell 47431 Capture Jormungar Spawn / Jormungarbrut einfangen
-- provided for quest 12078 Worm Wrangler / Wurmcowboy can only be used in area 4195
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 47431;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 47431, 0, 23, 4195, 0, 0, 0, '', 'Spell 47431 can only be cast in area 4195');

-- Fix combat reach for Anub'arak 34564 and Lord Marrowgar / Lord Mark'gar 36612
UPDATE `creature_model_info` SET `bounding_radius` = 4.5, `combat_reach` = 15 WHERE `modelid` IN (29268, 31119);

-- Fix immunities of Lord Jaraxxus 34780 boss in instance / Instanz PDK / Prüfung des Kreuzfahrers / Trial of the Crusader / ToCR - should be interruptable
UPDATE `creature_template` SET `mechanic_immune_mask` = 617298815 WHERE `entry` IN (34780, 35216, 35268, 35269);

-- Fix immunities of Gormok the Impaler / Gormok der Pfähler 34796 boss in instance / Instanz PDK / Prüfung des Kreuzfahrers / Trial of the Crusader / ToCR - should be weapon removable
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853243 WHERE `entry` IN (34796, 35438);

-- Fix a DB error for creature Xevozz
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `npcflag` = 0 WHERE `entry` = 29266;

-- Insert Feuerstuhl / Mechano-Hog 60866 - Chopper des Robogenieurs / Mekgineer's Chopper 60867 in factionchange / Fraktionswechsel
DELETE FROM `player_factionchange_spells` WHERE `alliance_id` = 60867 OR `horde_id` = 60866;
INSERT INTO `player_factionchange_spells` (alliance_id, horde_id) VALUES
(60867, 60866);

-- Fix missing spawn of NPC 6491 Spirit Healer / Geistheiler in Eastern Plaguelands
DELETE FROM `creature` WHERE `map` = 0 AND `id` = 6491 AND `position_x` > -1340 AND `position_x` < -1280 AND `position_y` < -3170 AND `position_y` > -3200;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(6491, 0, 1, 1, 0, 0, -1314.5, -3185.93, 37.4189, 5.47373, 300, 0, 0, 4120, 0, 0, 0, 0, 0, 0);

-- Fix npcs 24199, 23564, 24198 Verseuchter * der Drachenschinder / Plagued Dragonflayer * - no xp at kill, too less health
UPDATE `creature_template` SET `flags_extra` = 64 WHERE `entry` IN (24199, 23564, 24198);

-- Fix warlock / Hexenmeister ability 50589 Immolation Aura / Feuerbrandaura, should fade, when spell 47241 Metamorphosis / Metamorphose fades
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -47241 AND `spell_effect` = -50589;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(-47241, -50589, 0, 'Immolation Aura');

-- Erstelle und Spawne Meeting Stone 510100 fuer Archavons Kammer
DELETE FROM `gameobject_template` WHERE `entry` = 510100;
INSERT INTO `gameobject_template` (entry, type, displayId, name, IconName, castBarCaption, unk1, faction, flags, size, questItem1, questItem2, questItem3, questItem4, questItem5, questItem6, data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20, data21, data22, data23, ScriptName) VALUES
(510100, 23, 5492, 'Meeting Stone', '', '', '', 0, 0, 1.0, 0, 0, 0, 0, 0, 0, 80, 80, 4603, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `gameobject` WHERE `id` = 510100;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(510100, 571, 1, 1, 5473.01, 2858.08, 418.675, 3.09488, 0, 0, 0.999727, 0.0233539, 25, 0, 1);

-- Fix quest 12536 Ein holpriger Ritt / A Rough Ride set to autocomplete
UPDATE `quest_template` SET `Method` = 2, `SpecialFlags` = 2, `QuestFlags` = 130, `StartScript` = 12536 WHERE `entry` = 12536;
DELETE FROM `quest_start_scripts` WHERE `id` = 12536;
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(12536, 0, 7, 12536, 15, 0, 0, 0, 0, 0);

-- Fix quest 12259 Der Than von Voldrune / The Thane of Voldrune - was not acceptable because of wrong quest relations in quests
-- 12222 Secrets of the Flamebinders / Geheimnisse der Flammenbinder
-- 12223 Die Reihen lichten / Thinning the Ranks
UPDATE `quest_template` SET `ExclusiveGroup` = -12255 WHERE `entry` IN (12222, 12223);

-- Set low hp creatures 25295, 25284 give no xp
UPDATE `creature_template` SET `flags_extra` = 64 WHERE `entry` IN (25295, 25284);

-- Fix Item 34782 Magieerfülltes Tuch der Geißel / Imbued Scourge Shroud with spell 45614 Shroud of the Scourge / Seuchenschleier
-- provided for quest 11633 Blending In / Dabei sein ist alles can only be used in area 4125
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 45614;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionValue1, ConditionValue2, ConditionValue3, ErrorTextId, ScriptName, Comment) VALUES
(17, 0, 45614, 0, 23, 4125, 0, 0, 0, '', 'Spell 45614 can only be cast in area 4125');

-- VON DEN ANDEREN:
-- remove vyrkul scroll of ascension / Vrykulrolle des Aufstiegs 33346 from reference_loot_template because it doesn't belong there
DELETE FROM `reference_loot_template` WHERE `entry` = 35063 AND `item` = 33346;

-- Remove spawns of Drakkari Invader / Eindringling der Drakkari - Trollgore Script - Dark'Tharon
DELETE FROM `creature` WHERE `id` IN (27753, 27709);

-- Fix quest 11476 Ein Frosch und ein Messer / A Carver and a Croaker - add item to default loot
UPDATE `creature_template` SET `lootid` = 26503, `questItem1` = 35803 WHERE `entry` = 26503;
DELETE FROM `creature_loot_template` WHERE `entry` = 26503;
INSERT INTO `creature_loot_template` (entry,item,ChanceOrQuestChance,mincountOrRef,maxcount) VALUES
(26503, 35803, -100, 1, 1);

-- Fix NPC 21838 Terokk - infinite bubble (spell 40733) with a default paladin one (spell 642), because the bubble-remove-event is not implemented at all
UPDATE `creature_ai_scripts` SET `action1_param1` = 642 WHERE `id` =2183803 AND `creature_id` =21838;

-- Set the price and box_text for every dual talent spec teacher (option_id == 18)
UPDATE `gossip_menu_option` SET `box_money` = 10000000, `box_text` = 'Are you sure you wish to purchase a Dual Talent Specialization?' WHERE `option_id` = 18

-- Fix NPC 11382 Bloodlord Mandokir / Blutfürst Mandokir - make unit attackable by default, Boss in Zul'Gurub instance
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 11382;

-- Fix quest 12296 Life or Death! / Leben oder Tod! - NPC 27482 Wounded Infantry / Verwundeter Infanterist von Westfall needs script assigned
UPDATE `creature_template` SET `ScriptName` = 'npc_wounded_infantry' WHERE `entry` = 27482

-- Fix quests 14142 / 14096 Diesmal habt Ihr Euch wirklich selbst übertroffen, Kul / You've Really Done It This Time, Kul - fix respawn for gameobjects
-- Fix fuer Quest 14142 und 14096 by manitu
-- autoclose Zeit des Black Cage auf 3 Minuten setzen
UPDATE `gameobject_template` SET `data2` = 180000 WHERE `entry` = 195310;
UPDATE `gameobject` SET `state` = 1 WHERE `id` = 195310;
-- Respawn Zeit der Monster an Tul anpassen
UPDATE `creature` SET `spawntimesecs` = 120 WHERE id = 34716;

-- Fix quests 11399 / 11396 (Bring Down Those Shields / Die Schilde abschalten)
-- Modify Item 33960 (Scourging Crystal Controller / Steuerung des geißelnden Kristalls) and set correct spells
UPDATE `item_template` SET `spellid_1` = 43878 WHERE `entry` = 33960;
UPDATE `quest_template` SET `ReqSpellCast1` = 43878 WHERE `entry` = 11399;
UPDATE `quest_template` SET `ReqSpellCast1`= 43878 WHERE `entry` = 11396;

-- Fix quest 11705 Foolish Endeavors / Törichtes Unterfangen - remove external requirement, kill NPC 25618 Varidus the Flenser / Varidus den Flenser
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 25618, `ReqCreatureOrGOCount1` = 1, `SpecialFlags` = 0, `QuestFlags` = 128 WHERE `entry` = 11705;

-- Fix quest 11896, Weakness to Lightning / Eine Schwäche für Blitze - give questcredit via event ai scripts
DELETE FROM `creature_ai_scripts` WHERE id IN (2575803, 2575302, 2575202);
INSERT INTO `creature_ai_scripts` (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES
(2575803, 25758, 8, 0, 100, 1, 46432, -1, 0, 0, 33, 26082, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11896 Weakness to Lightning'),
(2575302, 25753, 8, 0, 100, 1, 46432, -1, 0, 0, 33, 26082, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11896 Weakness to Lightning'),
(2575202, 25752, 8, 0, 100, 1, 46432, -1, 0, 0, 33, 26082, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 11896 Weakness to Lightning');

-- Fix AI of NPC 1940 Rot Hide Plague Weaver / Seuchenwirker der Moderfelle - disable movement, caused LOS problems
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 1940 AND `id` in (194003,194004,194005);

-- Quests 7824 A Donation of Runecloth / Spendet Runenstoff, 7832 Noch mehr Runenstoff / More Runecloth should increase the reputation for the Darkspear Trolls (Faction 530) on fulfill, not for Orgrimmar (76).
UPDATE `quest_template` SET `RewRepFaction1` = 530 WHERE `entry` in (7824,7832);
-- Quests 7836 A Donation of Runecloth / Spendet Runenstoff, 7837 Noch mehr Runenstoff / More Runecloth should increase the reputation for Orgrimmar (Faction 76) on fulfill, not for the Darkspear Trolls (530).
UPDATE `quest_template` SET `RewRepFaction1` = 76 WHERE `entry` in (7836, 7837);

-- Fix quest 12277 Leave Nothing to Chance / Überlasst nichts dem Zufall
-- Assign script to NPC 27435 Wintergarde Mine Bomb / Minenbombe von Wintergarde
UPDATE `creature_template` SET `ScriptName` = 'npc_minebomb_of_wintergarde' WHERE `entry` = 27435;
-- Spawn triggers 27436 Upper Wintergarde Mine Shaft / Oberer Minenschacht von Wintergarde and 27437 Lower Wintergarde Mine Shaft / Unterer Minenschacht von Wintergarde
DELETE FROM `creature` WHERE `id` IN (27436, 27437);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(27436, 571, 1, 1, 11686, 0, 3891.55, -881.863, 119.658, 0.200862, 300, 0, 0, 42, 0, 0, 0, 0, 0, 0),
(27436, 571, 1, 1, 11686, 0, 3894.52, -886.543, 119.369, 1.69704, 300, 0, 0, 42, 0, 0, 0, 0, 0, 0),
(27437, 571, 1, 1, 11686, 0, 3881.75, -870.798, 111.51, 6.19345, 300, 0, 0, 42, 0, 0, 0, 0, 0, 0),
(27437, 571, 1, 1, 11686, 0, 3879.75, -865.894, 111.516, 6.19345, 300, 0, 0, 42, 0, 0, 0, 0, 0, 0),
(27437, 571, 1, 1, 11686, 0, 3882.8, -868.198, 111.188, 2.56563, 180, 5, 0, 42, 0, 0, 1, 0, 0, 0);
-- Spawn gameobject 188711 Wintergarde Mine Entrance / Eingang der Minen von Wintergarde
DELETE FROM `gameobject` WHERE `id` = 188711;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(188711, 571, 1, 1, 3899.18, -882.934, 119.511, 0.148233, 0, 0, 0.0740488, 0.997255, 300, 0, 1),
(188711, 571, 1, 1, 3882.71, -868.336, 111.043, 0, 0, 0, 0, 1, 180, 0, 1);

-- Fix for quest 5581 Portals of the Legion / Portale der Legion 
UPDATE `gameobject_template` SET `data5` = 1, `Scriptname` = 'go_demon_portal' WHERE `entry` IN (177243, 177365, 177366, 177367, 177368, 177369, 177397, 177398, 177399);
UPDATE `gameobject` SET `spawntimesecs` = 300, `state` = 1 WHERE `id` IN (177243, 177365, 177366, 177367, 177368, 177369, 177397, 177398, 177399);

-- Fix gameobject 188419 Ältester Mana'loa / Elder Mana'loa for quest 12030 Ältester Mana'loa / Elder Mana'loa
UPDATE `gameobject_template` SET `size` = 0.3 WHERE `entry` = 188419;

-- Fix quest 11613 Karuk's Oath / Karuks Schwur by removing quest dependencies of quest 11662 Seek Out Karuk! / Sucht nach Karuk! and quest 12141 A Diplomatic Mission / Eine diplomatische Mission
UPDATE `quest_template` SET `NextQuestId` = 0, `NextQuestInChain` = 0 WHERE `entry` IN (11662, 12141);

-- Fix quest 14107 The Fate Of The Fallen / Das Schicksal der Gefallenen - change requirements to spellcasting
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 32149, `ReqSpellCast1` = 66719 WHERE `entry` = 14107;

-- Insert a whole bunch of Skinning Loot into Northrends Instances + Raids
SET @LEATHER := 33568;
SET @DRAGONSCALE := 38557;
SET @CHITIN := 38558;
SET @FUR := 44128;
-- Azure Warden (26716)
SET @NPC := 26716; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 7),
(@NPC, @FUR, 0.9, 1, 1, 1, 1);
-- Azure Magus (26722)
SET @NPC := 26722; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 7),
(@NPC, @FUR, 0.9, 1, 1, 1, 2);
-- Keristrasza (26723)
SET @NPC := 26723; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 75, 1, 1, 1, 6),
(@NPC, @DRAGONSCALE, 24, 1, 1, 1, 5),
(@NPC, @FUR, 1.4, 1, 1, 1, 2);
-- Mage Slayer (26730)
SET @NPC := 26730; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 7),
(@NPC, @FUR, 1.4, 1, 1, 1, 2);
-- Azure Scale-Binder (26735)
SET @NPC := 26735; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 6),
(@NPC, @FUR, 1.1, 1, 1, 1, 2);
-- Sartharion (28860)
SET @NPC := 28860; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @DRAGONSCALE, 100, 1, 1, 8, 15),
(@NPC, @LEATHER, 99, 1, 2, 1, 2);
-- Lavanthor (29312)
SET @NPC := 29312; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 100, 1, 1, 5, 12);
-- Savage Worg (29735)
SET @NPC := 29735; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 7),
(@NPC, @FUR, 0.9, 1, 1, 1, 2);
-- Unyielding Constrictor (29768)
SET @NPC := 29768; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 7),
(@NPC, @FUR, 1, 1, 1, 1, 2);
-- Spitting Cobra (29774)
SET @NPC := 29774; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 8),
(@NPC, @FUR, 1.1, 1, 1, 1, 2);
-- Drakkari Rhino (29838)
SET @NPC := 29838; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 8),
(@NPC, @FUR, 0.9, 1, 1, 1, 2);
-- Drakkari Rhino (29931)
SET @NPC := 29931; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 1, 1, 5),
(@NPC, @FUR, 0.9, 1, 1, 1, 2);
-- Cyanigosa (31134)
SET @NPC := 31134; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 75, 1, 1, 1, 6),
(@NPC, @DRAGONSCALE, 24, 1, 1, 1, 6),
(@NPC, @FUR, 0.9, 1, 1, 1, 2);
-- Nerub'ar Broodkeeper (36725)
SET @NPC := 36725; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 74, 1, 1, 1, 6),
(@NPC, @CHITIN, 25, 1, 1, 1, 6),
(@NPC, @FUR, 0.8, 1, 1, 1, 6);
-- Stinky (37025)
-- http://www.wowhead.com/npc=37025#skinning
SET @NPC := 37025; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 0, 1, 20),
(@NPC, @FUR, 26, 1, 0, 1, 2);
-- Precious (37217)
-- http://www.wowhead.com/npc=37217#skinning
SET @NPC := 37217; -- set npc id
SET @SID = (SELECT skinloot FROM creature_template WHERE entry = @NPC); -- acquire skinloot id
DELETE FROM `skinning_loot_template` WHERE entry = @SID; -- clean up old skinning loot (that probably didnt exist in first place)
UPDATE creature_template SET skinloot = @NPC WHERE entry = @NPC; -- overwrite skinloot id with creature_template.entry value
INSERT INTO `skinning_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(@NPC, @LEATHER, 99, 1, 0, 12, 19),
(@NPC, @FUR, 26, 1, 0, 1, 2);
-- Set values for empty heroic entries too
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31669;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31215;
UPDATE `creature_template` SET `skinloot` = 26716 WHERE `entry` = 30459;
UPDATE `creature_template` SET `skinloot` = 26722 WHERE `entry` = 30457;
UPDATE `creature_template` SET `skinloot` = 26723 WHERE `entry` = 30540;
UPDATE `creature_template` SET `skinloot` = 26730 WHERE `entry` = 30473;
UPDATE `creature_template` SET `skinloot` = 70211 WHERE `entry` = 30516;
UPDATE `creature_template` SET `skinloot` = 26735 WHERE `entry` = 30517;
UPDATE `creature_template` SET `skinloot` = 70205 WHERE `entry` = 31187;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31202;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31206;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31203;
UPDATE `creature_template` SET `skinloot` = 70205 WHERE `entry` = 31188;
UPDATE `creature_template` SET `skinloot` = 28860 WHERE `entry` = 31311;
UPDATE `creature_template` SET `skinloot` = 29312 WHERE `entry` = 31509;
UPDATE `creature_template` SET `skinloot` = 29735 WHERE `entry` = 31678;
UPDATE `creature_template` SET `skinloot` = 29768 WHERE `entry` = 30942;
UPDATE `creature_template` SET `skinloot` = 29774 WHERE `entry` = 30941;
UPDATE `creature_template` SET `skinloot` = 29838 WHERE `entry` = 30935;
UPDATE `creature_template` SET `skinloot` = 29931 WHERE `entry` = 30936;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31535;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31520;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31534;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31501;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31486;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31493;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31490;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 31503;
UPDATE `creature_template` SET `skinloot` = 31134 WHERE `entry` = 31506;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 32192;
UPDATE `creature_template` SET `skinloot` = 70210 WHERE `entry` = 32313;
UPDATE `creature_template` SET `skinloot` = 36725 WHERE `entry` = 38058;
UPDATE `creature_template` SET `skinloot` = 37025 WHERE `entry` = 38064;
UPDATE `creature_template` SET `skinloot` = 37217 WHERE `entry` = 38103;

-- fix quests giving too low reputation reward for sporeggar (repeatable) quests, corresponding to wowwiki/sporeggar
UPDATE `quest_template` SET `RewRepValue1` = 75000, `RewRepValueId1` = 0 WHERE `entry` IN (9714, 9715, 9726, 9727, 9806, 9807);

-- Fix quest Elfische Legenden / Elven Legends 7481 Horde / 7482 Alliance
-- Change gameobject_template, so gameobject 179544 Skeletal Remains of Kariel Winthalus / Die sterblichen Ueberreste von Kariel Winthalus can have db script
UPDATE `gameobject_template` SET `type` = 1, `data0` = 0, `data1` = 0, `data2` = 1000, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0 WHERE `entry` = 179544;
-- Insert new db scripts for gameobject, satisfy external quest requirement
DELETE FROM `gameobject_scripts` WHERE `id` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 179544);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`)
SELECT guid, 0, 7, 7481, 20, 0, 0, 0, 0, 0 FROM `gameobject` WHERE `id` = 179544;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`)
SELECT guid, 0, 7, 7482, 20, 0, 0, 0, 0, 0 FROM `gameobject` WHERE `id` = 179544;

-- Fix Quest 11905 Postponing the Inevitable / Das Unvermeidliche hinauszoegern
-- Modify event scripts triggered by item 35479 Interdimensional Refabricator / Interdimensionaler Refabrikator
-- due to spell 46547 Activate Interdimensional Refabricator / Interdimensionalen Refabrikator aktivieren
DELETE FROM `event_scripts` WHERE `id` = 17364;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(17364, 0, 8, 26105, 0, 0, 0, 0, 0, 0);
-- Set trigger creature 26105 Quest Invisman - Buying Time flags and visibility
UPDATE `creature_template` SET `modelid1` = 19595, `modelid2` = 0, `unit_flags` = 33554434, `flags_extra` = 128 WHERE `entry` = 26105;

-- Fix quest 10111 Bring me the egg! / Bringt mir das Ei!
-- NPC 19055 Windroc Matriach / Windroc Matriachin should be attackable out of combat
UPDATE `creature_template` SET `unit_flags` = 0, `dynamicflags` = 0 WHERE `entry` = 19055;
-- NPC 19041 Jump-a-tron 4000 / Spring-o-Mat 4000 should be invisible
UPDATE `creature_template` SET `modelid1` = 17188, `modelid2` = 0 WHERE `entry` = 19041;

-- Fix creature 24210 Riven Widow Cocoon / Bruchwitwenkokon - should not move and award EP
UPDATE `creature_template` SET `flags_extra` = 64, `MovementType` = 0 WHERE `entry` = 24210;
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `id` = 24210;