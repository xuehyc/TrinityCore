-- criteria for achievement My Girl Loves To Skadi All The Time (2156)
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 7595;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7595, 11, 0, 0, 'achievement_skadi_all_the_time'),
(7595, 12, 1, 0, '');

DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` = 7595;

-- remove trigger model for spirit fount
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0 WHERE `entry` IN (27339, 30808);

-- correct factions for ymiron encounter (avenging spirits, spirit fountain)
UPDATE `creature_template` SET `faction_A` = '14', `faction_H` = '14' WHERE `entry` IN (27339,30808, 27386, 30756);
