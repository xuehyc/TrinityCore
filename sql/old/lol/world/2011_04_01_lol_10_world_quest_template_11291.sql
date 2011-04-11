-- Fix Taxi from Quest 'To Westguard Keep!' #11291 
SET @Emilune    = 27930; -- Emilune Winterwind
SET @Gossip     = 9618;   -- gossip_menu_id
SET @Quest      = 11291; -- Quest
SET @Spell      = 50028; -- Gryphon Taxi to Westguard Keep
-- Update creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI', `npcflag` = `npcflag` | 1 WHERE `entry` = @Emilune;
-- gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `menu_id` = @Gossip;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES 
(@Gossip,0,0,'Please, Take me to Westguard Keep!',1,1,0,0,0,0,0,'');
-- SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = @Emilune;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@Emilune,0,0,0,62,0,100,0,@Gossip,0,0,0,11,@Spell,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast taxi');
-- conditions
DELETE FROM `conditions` WHERE `SourceGroup` = @Gossip AND `SourceTypeOrReferenceId` = 15;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15,@Gossip,0,0,28,@Quest,0,0,0,'','show gossip menu option if player has completed 11291');