-- @DorianGrey
-- Fix for Q10273: Troublesome Distractions.
-- Enables a gossip-based interaction with Wind Trader Marid, which makes him attackable to the player,
-- i.e. removes his unit_flags and changes his faction temporarily. Also resets these changes when leaving combat.
-- May lack of some style things, like a screaming Wind Trader etc. ...

-- Add gossip-menu and SmartAI-usage.
UPDATE `creature_template` SET `gossip_menu_id`=20071, `AIName`='SmartAI' WHERE `entry`=20071;

-- Create gossip.
DELETE FROM `gossip_menu_option` WHERE `menu_id`=20071;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`) VALUES (20071, 0, 0, 'Marid, we need to talk about some... details...', 1, 1, 0, 0, 0, 0, NULL);

-- Create smart_scripts.
DELETE FROM `smart_scripts` WHERE `entryorguid`=20071;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(20071, 0, 0, 1, 62, 0, 100, 0, 20071, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - Remove unit flag on gossip'),
(20071, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - Set faction to hostile'),
(20071, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - Attack player after gossip'),
(20071, 0, 3, 4, 7, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - Reset unit-flags when leaving combat'),
(20071, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 1731, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wind Trader Marid - Reset faction when leaving combat');

-- Create condition - gossip should only be accessible while Q10273 is not completed yet.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=20071;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (15, 20071, 0, 0, 0, 9, 0, 10273, 0, 0, 0, 0, '', 'Wind Trader Marid gossip - should only be accessible with Troublesome Distractions active');
