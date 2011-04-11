-- Fix Quest 12204 'In the Name of Loken'
-- Workaround  (missing creature_text of Hugh Glass - copied of Gavrock)

-- Gavrock SAI
SET @GAV_ENTRY := 26420;
-- Template
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@GAV_ENTRY;
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@GAV_ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@GAV_ENTRY,0,0,'Ah, yes. Loken is well known to me.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@GAV_ENTRY,1,0,'It is he who commands the sons of iron in their ways against us.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@GAV_ENTRY,2,0,'From his hiding place, he oversees their preparations for war with the goal of exterminating the stone giants!',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken');
-- Script
DELETE FROM `smart_scripts` WHERE `entryorguid` in (@GAV_ENTRY,@GAV_ENTRY*100);
INSERT INTO `smart_scripts` 
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GAV_ENTRY,0,0,0,62,0,100,0,9485,0,0,0,80,@GAV_ENTRY*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Gavrock - Start Script'),
(@GAV_ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: close gossip menu'),
(@GAV_ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: say text 0'),
(@GAV_ENTRY*100,9,2,0,0,0,100,0,3000,3000,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: say text 1 after text 0'),
(@GAV_ENTRY*100,9,3,0,0,0,100,0,4000,4000,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: say text 2 after text 1'),
(@GAV_ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,33,@GAV_ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gavrock: credit for quest In the Name of Loken');
-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9485;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES (15,9485,0,0,9,12204,0,0,0,'','Gavrock: show gossip if player has quest 12204');

-- Hugh Glass SAI
-- ATTENTION: I haven't found any information about the texts used by this npc, so atm I used Gavarock texts.
-- Texts must be changed (and script must be modified accordingly if needed) when information from official servers are taken.
SET @HUGH_ENTRY := 26484;
-- Template
UPDATE `creature_template` SET `npcflag`=`npcflag`|1, `AIName`='SmartAI' WHERE `entry`=@HUGH_ENTRY;
-- Gossip Menu Option
DELETE from `gossip_menu_option` WHERE `menu_id`=9484 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES (9484,0,0,'What can you tell me about Loken and the iron dwarves?',1,1,0,0,0,0,0,'');
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@HUGH_ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@HUGH_ENTRY,0,0,'Ah, yes. Loken is well known to me.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@HUGH_ENTRY,1,0,'It is he who commands the sons of iron in their ways against us.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@HUGH_ENTRY,2,0,'From his hiding place, he oversees their preparations for war with the goal of exterminating the stone giants!',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken');
-- Script
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@HUGH_ENTRY,@HUGH_ENTRY*100);
INSERT INTO `smart_scripts` 
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@HUGH_ENTRY,0,0,0,62,0,100,0,9484,0,0,0,80,@HUGH_ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Hugh Glass - Start Script'),
(@HUGH_ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: close gossip menu'),
(@HUGH_ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: say text 0'),
(@HUGH_ENTRY*100,9,2,0,0,0,100,0,3000,3000,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: say text 1 after text 0'),
(@HUGH_ENTRY*100,9,3,0,0,0,100,0,4000,4000,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: say text 2 after text 1'),
(@HUGH_ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,33,@HUGH_ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,'Hugh Glass: credit for quest In the Name of Loken');
-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9484 AND `SourceEntry`=0;
	INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES (15,9484,0,0,9,12204,0,0,0,'','Hugh Glass: show gossip if player has quest 12204');

	
	
