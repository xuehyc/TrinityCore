-- Remove custom drop Schematic: Jeeves / Bauplan: Jeeves from creature loot because salvaging works, closes #920
DELETE FROM `creature_loot_template` WHERE `item` = 49050;

-- Set quest 12641 Death Comes From On High / Tod kommt von ganz oben to autocomplete, broken by vehicle / control mechanics
-- BACKUP
-- UPDATE `quest_template` SET `RequiredNpcOrGo1` = 28525, `RequiredNpcOrGo2` = 28543, `RequiredNpcOrGo3` = 28542, `RequiredNpcOrGo1` = 28544, `RequiredNpcOrGoCount1` = 1, `RequiredNpcOrGoCount2` = 1, `RequiredNpcOrGoCount3` = 1, `RequiredNpcOrGoCount4` = 1, `RequiredSpellCast1` = 51858, `RequiredSpellCast2` = 51858, `RequiredSpellCast3` = 51858, `RequiredSpellCast4` = 51858 WHERE `Id` = 12641;
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 0, `RequiredNpcOrGo2` = 0, `RequiredNpcOrGo3` = 0, `RequiredNpcOrGo4` = 0, `RequiredNpcOrGo1` = 0, `RequiredNpcOrGoCount1` = 0, `RequiredNpcOrGoCount2` = 0, `RequiredNpcOrGoCount3` = 0, `RequiredNpcOrGoCount4` = 0, `RequiredSpellCast1` = 0, `RequiredSpellCast2` = 0, `RequiredSpellCast3` = 0, `RequiredSpellCast4` = 0 WHERE `Id` = 12641;

-- Fix some pools
DELETE FROM `pool_pool` WHERE `mother_pool` = 5238;
DELETE FROM `pool_template` WHERE `entry` = 11377;
INSERT INTO `pool_template` (entry,max_limit,description) VALUES
(11377,1,'Outland Cooking Daily');

-- Fix creature 28670 Frostbrood Vanquisher / Frostbrutbezwinger should be able to fly
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 28670;

-- Fix quests The Ring of Blood / Der Ring des Blutes quest chain in Nagrand
UPDATE `quest_template` SET `SpecialFlags` = 0 WHERE `Id` IN (9962, 9967, 9970, 9972, 9973, 9977);

-- MERGE TRINITY
-- https://github.com/TrinityCore/TrinityCore/commit/c892ad3f2cf09de381b20c67ea07e118c62846c0
-- https://github.com/TrinityCore/TrinityCore/commit/1479a3e51809b62795c364a2ed4bb6f46e4deb73
UPDATE `game_event` SET `start_time`= '2012-02-05 00:01:00', `holiday`=423 WHERE `eventEntry`=8; -- Love is in the Air
UPDATE `game_event` SET `length`=20160 WHERE `eventEntry`=8; -- Love is in the Air

-- MERGE TRINITY
-- https://github.com/TrinityCore/TrinityCore/commit/8a1f3a600fe28831c8653fe8261747118f0b5dba
DELETE FROM `conditions` WHERE `SourceEntry`=71599 AND `SourceTypeOrReferenceId`=13 AND `ConditionTypeOrReference`=18;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,71599,18,1,38035, 'Chemical Wagon - Cosmetic - Explosion (Chemical Wagon)');
DELETE FROM `smart_scripts` WHERE `entryorguid`=38035 AND `source_type`=0;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=38035;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(38035,0,0,1,8,0,100,0,71599,0,0,0,33,38035,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Chemical Wagon - Spell Hit - Credit"),
(38035,0,1,0,61,0,100,0,0,0,0,0,11,71597,2,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,"Chemical Wagon - Spell Hit - Cast Cosmetic - Low Poly Fire (with Sound)");

-- Fix quest 12906 Diziplin / Discipline by setting the correct spell id in reward smart script
UPDATE `smart_scripts` SET `event_param1` = 56033 WHERE `entryorguid` = 30146 AND `id` = 1;