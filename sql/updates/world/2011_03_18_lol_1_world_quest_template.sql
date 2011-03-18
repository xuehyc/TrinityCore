-- QUEST 12512 "Leave no one behind"
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry` IN (28133,28141,28143,28136,28142,28148,28137);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (28133,28141,28143,28136,28142,28148,28137,2813600,2814200,2814800);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Leave No One Behind Bunny
(28137,0,0,0,60,0,100,0,0,0,0,0,75,50670,0,0,0,0,0,11,28136,15,0,0,0,0,0, 'Apply aura when in range'),
(28137,0,1,0,60,0,100,0,0,0,0,0,75,50670,0,0,0,0,0,11,28142,15,0,0,0,0,0, 'Apply aura when in range'),
(28137,0,2,0,60,0,100,0,0,0,0,0,75,50670,0,0,0,0,0,11,28148,15,0,0,0,0,0, 'Apply aura when in range'),
-- Injured Crusader Jonathan
(28133,0,0,1,8,0,100,0,50662,0,0,0,85,50664,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit revive Crusader Jonathan'),
(28133,0,1,2,61,0,100,0,0,0,0,0,11,50666,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Apply timed debuff to player'),
(28133,0,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn injured Crusader Jonathan'),
-- Crusader Jonathan
(28136,0,0,1,54,0,100,0,0,0,0,0,29,0,0,28044,28136,0,0,7,0,0,0,0,0,0,0, 'On spawn start follow'),
(28136,0,1,2,61,0,100,0,0,0,0,0,11,50665,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Apply timed debuff to Crusader Jonathan'),
(28136,0,2,0,61,0,100,0,0,0,0,0,80,2813600,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Start script Crusader Jonathan'),
(28136,0,3,4,8,0,100,0x01,50669,0,0,0,11,50671,0,0,0,0,0,18,15,0,0,0,0,0,0, 'On complete-bunny spellhit give quest credit'),
(28136,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Jonathan rescued'),
(28136,0,5,6,61,0,100,0,0,0,0,0,28,50666,0,0,0,0,0,18,15,0,0,0,0,0,0, 'Remove timed debuff from player'),
(28136,0,6,0,61,0,100,0,0,0,0,0,53,0,28136,0,0,0,0,1,0,0,0,0,0,0,0, 'Start waypoint movement'),
(2813600,9,0,1,60,0,100,0,180000,180000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On debuff fade Crusader Jonathan dies'),
(2813600,9,1,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Jonathan death'),
-- Injured Crusader Lamoof
(28141,0,0,1,8,0,100,0,50662,0,0,0,85,50678,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit revive Crusader Lamoof'),
(28141,0,1,2,61,0,100,0,0,0,0,0,11,50679,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Apply timed debuff to player'),
(28141,0,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn dead Crusader Lamoof'),
-- Crusader Lamoof
(28142,0,0,1,54,0,100,0,0,0,0,0,29,1,0,28044,28142,0,0,7,0,0,0,0,0,0,0, 'On spawn start follow'),
(28142,0,1,2,61,0,100,0,0,0,0,0,11,50681,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Apply timed debuff to Crusader Lamoof'),
(28142,0,2,0,61,0,100,0,0,0,0,0,80,2814200,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Start script Crusader Lamoof'),
(28142,0,3,4,8,0,100,0x01,50669,0,0,0,11,50683,0,0,0,0,0,18,15,0,0,0,0,0,0, 'On complete-bunny spellhit give quest credit'),
(28142,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Lamoof rescued'),
(28142,0,5,6,61,0,100,0,0,0,0,0,28,50679,0,0,0,0,0,18,15,0,0,0,0,0,0, 'Remove timed debuff from player'),
(28142,0,6,0,61,0,100,0,0,0,0,0,53,0,28142,0,0,0,0,1,0,0,0,0,0,0,0, 'Start waypoint movement'),
(2814200,9,0,1,60,0,100,0,90000,90000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On debuff fade Crusader Lamoof dies'),
(2814200,9,1,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Lamoof death'),
-- Injured Crusader Josephine
(28143,0,0,1,8,0,100,0,50662,0,0,0,85,50692,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit revive Crusader Josephine'),
(28143,0,1,2,61,0,100,0,0,0,0,0,11,50693,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Apply timed debuff to player'),
(28143,0,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn dead Crusader Josephine'),
-- Crusader Josephine
(28148,0,0,1,54,0,100,0,0,0,0,0,29,1,0,28044,28148,0,0,7,0,0,0,0,0,0,0, 'On spawn start follow'),
(28148,0,1,2,61,0,100,0,0,0,0,0,11,50695,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Apply timed debuff to Crusader Josephine'),
(28148,0,2,0,61,0,100,0,0,0,0,0,80,2814800,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Start script Crusader Josephine'),
(28148,0,3,4,8,0,100,0x01,50669,0,0,0,11,50698,0,0,0,0,0,18,15,0,0,0,0,0,0, 'On complete-bunny spellhit give quest credit'),
(28148,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Josephine rescued'),
(28148,0,5,6,61,0,100,0,0,0,0,0,28,50693,0,0,0,0,0,18,15,0,0,0,0,0,0, 'Remove timed debuff from player'),
(28148,0,6,0,61,0,100,0,0,0,0,0,53,0,28148,0,0,0,0,1,0,0,0,0,0,0,0, 'On follow completed say rescued text'),
(2814800,9,0,1,60,0,100,0,150000,150000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On debuff fade Crusader Josephine dies'),
(2814800,9,1,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Josephine death');

DELETE FROM `creature_text` WHERE `entry` IN (28136,28142,28148);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(28136,0,0,'Thank you, friend. Were it not for your aid I would be no more.',0,0,100,0,0,0,'Crusader Jonathan rescued text'),
(28136,1,0,'',0,0,100,1,0,0,'Crusader Jonathan death text'),
(28142,0,0,'<sigh>... Well, I suppose it could be worse.',0,0,100,1,0,0,'Crusader Lamoof rescued text'),
(28142,1,0,'<sigh>... This is the end of me.',0,0,100,1,0,0,'Crusader Lamoof death text'),
(28148,0,0,'I am in your debt, friend. Thank you for my life.',0,0,100,1,0,0,'Crusader Josephine rescued text'),
(28148,1,0,'',0,0,100,1,0,0,'Crusader Josephine death text');

UPDATE `creature_template` SET `faction_A`=2070,`faction_H`=2070,`npcflag`=`npcflag`|1,`unit_flags`=`unit_flags`|32770,`speed_run`=1.143 WHERE `entry` IN (28136,28142,28148);
UPDATE `creature_model_info` SET `bounding_radius`=0.306,`combat_reach`=1.5 WHERE `modelid` IN (25131,25140,25143); 

DELETE FROM `creature_template_addon` WHERE `entry` IN (28136,28137,28133,28141,28142,28143,28148);
INSERT INTO `creature_template_addon` (`entry`,`bytes1`,`bytes2`,`auras`) VALUES
(28133,7,0,NULL), -- Crusader Jonathan appear dead
(28136,0,1,NULL), -- Crusader Jonathan
(28141,7,0,NULL), -- Crusader Lamoof appear dead
(28142,0,1,NULL), -- Crusader Lamoof
(28143,7,0,NULL), -- Crusader Josephine appear dead
(28148,0,1,NULL), -- Crusader Josephine
(28137,0,1, '50670 0'); -- Leave No One Behind Bunny

UPDATE `creature` SET `MovementType`=0,`spawndist`=0 WHERE `id`=28137; -- Incorrect movement for Leave No One Behind Bunny

DELETE FROM `waypoints` WHERE `entry` IN (28136,28142,28148);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`) VALUES
(28136,0,5247.601,-3489.303,289.230),
(28136,1,5254.362,-3497.056,291.694),
(28142,0,5247.601,-3489.303,289.230),
(28142,1,5254.362,-3497.056,291.694),
(28148,0,5247.601,-3489.303,289.230),
(28148,1,5254.362,-3497.056,291.694);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (50671,50683,50698,50709,50723,50711,50710,50722,50712);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(50671,50680,1,'Crusader Jonathan kill credit'),
(50683,50684,1,'Crusader Lamoff kill credit'),
(50698,50699,1,'Crusader Josephine kill credit'),
(50709,50710,1,'Crusader Jonathan strip aura'),
(50723,50722,1,'Crusader Lamoof strip aura'),
(50711,50712,1,'Crusader Josephine strip aura'),
(50710,-50666,1,'Crusader Jonathan remove aura from player'),
(50722,-50679,1,'Crusader Lamoof remove aura from player'),
(50712,-50693,1,'Crusader Josephine remove aura from player');