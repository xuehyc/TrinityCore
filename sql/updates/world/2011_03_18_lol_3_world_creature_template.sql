-- QUEST 12957 "Slaves of the Stormforged"
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=29384;
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=29384 WHERE `entry`=12957;

DELETE FROM `gossip_menu` WHERE `entry`=9871 AND `text_id`=13682;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9871,13682);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=9871;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9871,0,0,'I''m not a laborer. I''m here to free you from servitude in the mines.',1,1,0,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 OR `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9871;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,9871,13682,0,9,12957,0,0,0,'','Show gossip text only if player has quest 12957'),
(15,9871,0,0,9,12957,0,0,0,'','Show gossip menu option only if player has quest 12957');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (29384,2938400);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29384,0,0,0,62,0,100,0,9871,0,0,0,80,2938400,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On gossip option select run script'),
(2938400,9,0,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Turn off Gossip'),
(2938400,9,1,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say random text'),
(2938400,9,2,0,0,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Set movement speed to walk'),
(2938400,9,3,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,21,0,0,0,0,0,0,0, 'Walk forward'),
(2938400,9,4,0,0,0,100,0,0,0,0,0,33,29384,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Give quest credit'),
(2938400,9,5,0,0,0,100,0,1000,1000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn');

DELETE FROM `creature_text` WHERE `entry`=29384;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(29384,0,0,'Does not compute. Unit malfunctioning. Directive: Shut down.',0,0,100,1,0,0,'Captive Mechagnome text 0'),
(29384,0,1,'New directive: Leave mine and return to Inventor''s Library.',0,0,100,1,0,0,'Captive Mechagnome text 1'),
(29384,0,2,'New directive: Assist in the defeat of the iron dwarves.',0,0,100,1,0,0,'Captive Mechagnome text 2'),
(29384,0,3,'Free again? Keeper Mimir''s work awaits.',0,0,100,1,0,0,'Captive Mechagnome text 3'),
(29384,0,4,'Thank you, $r. I will join your struggle against the stormforged.',0,0,100,1,0,0,'Captive Mechagnome text 4');