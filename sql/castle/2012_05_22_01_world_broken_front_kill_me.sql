-- @DorianGrey
-- Fix for "The Broken Front" [H13228],[A13231] and "Kill me!" [A13232]
-- Just some gossip-entries and smart_scripts that lack a bit of style, but ... it works.

-- [Alliance]: Dying soldier - enable SmartAI.
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=31304;

-- [Horde]: Dying berserker - enable gossip-menu and SmartAI.
DELETE FROM `gossip_menu_option` WHERE `menu_id`=31273 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES (31273, 0, 0, 'Stay with me, friend. I must know what happened here.', 1, 1, 0, 0, 0, 0, '');

-- Required creature update.
UPDATE `creature_template` SET `gossip_menu_id`=31273, `AIName`='SmartAI' WHERE `entry`=31273;

-- [Both]: Create the required smart_scripts.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (31304, 31273) AND `id` IN (0, 1, 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(31304, 0, 0, 0, 62, 0, 100, 0, 10040, 0, 0, 0, 33, 31312, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dying soldier - bunny credit on gossip'),
(31304, 0, 1, 2, 62, 0, 100, 0, 10040, 1, 0, 0, 33, 31304, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dying soldier - bunny credit on gossip'),
(31304, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dying soldier - despawn after credit'),
(31273, 0, 0, 0, 62, 0, 100, 0, 31273, 0, 0, 0, 33, 31272, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Dying berserker - bunny credit on gossip');

-- Conditions.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` IN (10040, 31273);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 10040, 0, 0, 0, 9, 0, 13231, 0, 0, 0, 0, '', 'Dying soldier - gossip prohibition aside from being on the corresponding quest'),
(15, 10040, 1, 0, 0, 9, 0, 13232, 0, 0, 0, 0, '', 'Dying soldier - gossip prohibition aside from being on the corresponding quest'),
(15, 31273, 0, 0, 0, 9, 0, 13228, 0, 0, 0, 0, '', 'Dying beserker - gossip prohibition aside from being on the corresponding quest');

-- Just to keep the overview, this has been changed some time before.
-- UPDATE `quest_template` SET `RequiredNpcOrGo1`=31304 WHERE `Id`=13232; 
