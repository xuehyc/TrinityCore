-- Fix for "love is in the air" - Trigger-Bunnies & holiday id.
-- https://github.com/TrinityCore/TrinityCore/commit/c6f8f23616d468d9a761d7f5f6762fdca208e66f
UPDATE `achievement_criteria_data` SET `value1`=423 WHERE `value1` IN (335,355) AND `type`=16;
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` IN (38340,38341,38342);

-- Fix for "love is in the air" event-length.
-- https://github.com/TrinityCore/TrinityCore/commit/1479a3e51809b62795c364a2ed4bb6f46e4deb73
UPDATE `game_event` SET `length`=20160 WHERE `eventEntry`=8;

-- Fix for "love is in the air" - Achiev. "I Pitied The Fool"
-- https://github.com/TrinityCore/TrinityCore/commit/ca770e5a310adfd6e5a3c405cbef007c506cf11f
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (6343, 6344, 6345, 6346, 6347);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(6343,6,4197,0,''), -- Wintergrasp
(6343,1,16111,0,''), -- target Love Fool
(6344,6,2177,0,''), -- Battle Ring
(6344,1,16111,0,''), -- target Love Fool
(6345,6,3421,0,''), -- Blacksmith
(6345,1,16111,0,''), -- target Love Fool
(6346,6,4100,0,''), -- The Culling of Stratholme	
(6346,1,16111,0,''), -- target Love Fool	
(6347,6,3456,0,''), -- Naxxramas
(6347,1,16111,0,''); -- target Love Fool

-- Fix for "There's something in the air (and it ain't love)" - missing creature relation for alliance part.
DELETE FROM `creature_involvedrelation` WHERE `quest` = 24745;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (38066, 24745);
-- update quest item drop chance - 100% due to http://de.wowhead.com/quest=24745#english-comments (Patch 3.3.2)
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = '100' WHERE `entry`=36296 AND `item` =50320;

-- Fix for achiev. "Lonely?" - Scripts for Item "Romantic Picnic Basket"
-- https://github.com/TrinityCore/TrinityCore/commit/32b2fccf331e545b83e8e584a0eb4804539173c4
-- Slightly modified - removed column "SourceId" from the conditions-entry.
UPDATE `gameobject_template` SET `flags` = `flags` | 32, `AIName` = 'SmartGameObjectAI' WHERE `entry` = 187267;
DELETE FROM `spell_script_names` WHERE `spell_id` = 45102;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45102, 'spell_love_is_in_the_air_romantic_picnic');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (45119, 45103, 45114);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 45119, 0, 18, 0, 187267, 0, 0, '', 'Holiday - Valentine - Romantic Picnic Near Basket Check - Target Romantic Basket'),
(13, 0, 45103, 0, 18, 1, 0, 0, 0, '', 'Holiday - Valentine - Romantic Picnic Meal Periodic - Target Players'),
(13, 0, 45114, 0, 18, 1, 0, 0, 0, '', 'Holiday - Valentine - Romantic Picnic Meal Particle - Target Players');
DELETE FROM `smart_scripts` WHERE `entryorguid`=187267 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(187267, 1, 0, 0, 60, 0, 100, 0, 3*60*1000, 3*60*1000, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Picnic Basket - Despawn after 3 minutes');
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (1291,5787,4071);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(5787, 6, 4395, 0, ''), -- Lonely? - Dalaran
(4071, 6, 4395, 0, ''); -- Lonely? - Dalaran	

-- Public Relations Agent - Quest-Pooling
-- Source: http://www.wowhead.com/quest=24636#comments:id=968417
SET @pool_id := 352;
-- create new pool, allowing only 1 out of 3 dailys per day
DELETE FROM `pool_template` WHERE `entry` = @pool_id;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@pool_id, 1, 'Public Relations Agent - Daily Quests');
-- fill pools with the daily quests
DELETE FROM `pool_quest` WHERE `entry` IN (24629, 24635, 24636) AND `pool_entry` = @pool_id;
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(24629, @pool_id, 'A Perfect Puff of Perfume'),
(24635, @pool_id, 'A Cloudlet of Classy Cologne'),
(24636, @pool_id, 'Bonbon Blitz');