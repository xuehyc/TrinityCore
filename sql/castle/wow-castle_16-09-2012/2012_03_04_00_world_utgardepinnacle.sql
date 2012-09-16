-- criteria for achievement My Girl Loves To Skadi All The Time (2156)
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 7595;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7595, 11, 0, 0, 'achievement_skadi_all_the_time'),
(7595, 12, 1, 0, '');

DELETE FROM `disables` WHERE `sourceType` = 4 AND `entry` = 7595;

-- remove trigger model for spirit fount
UPDATE `creature_template` SET `modelid1` = 11686, `modelid2` = 0 WHERE `entry` IN (27339, 30808);

-- correct factions for ymiron encounter (avenging spirits, spirit fountain)
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` IN (27339, 30808, 27386, 30756);

-- Set Statis Orb for Palehoof encounter to invisible model
UPDATE `creature_template` SET `modelid1` = 11686, `modelid3` = 0 WHERE `entry` = 26688;

-- Set mechanic immune masks and flags_extra for bosses in Utgarde Pinnacle
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` IN (26683, 30772, 26684, 30803, 26685, 30790, 26686, 30770, 26687 ,30774 ,26693, 30807, 26861, 30788 ,29281, 30809, 26668, 30810);
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` IN (30770, 30772, 30790, 30803);

-- Condition for looting item 41797 Design: Austere Earthsiege Diamond / Vorlage: Strenger Erdringdiamant
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` IN (26861, 30788) AND `SourceEntry` = 41797;
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(1, 26861, 41797, 0, 0, 7, 0, 755, 1, 0, 0, 0, '', ''),
(1, 30788, 41797, 0, 0, 7, 0, 755, 1, 0, 0, 0, '', '');