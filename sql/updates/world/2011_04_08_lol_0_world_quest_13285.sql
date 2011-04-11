-- Fix Quest 'Forging the Keystone' #13285 
-- (Workaround - Missing Symboleffects and AreaGroupId bug of s#60963 in Spell.dbc instead of 923 (Temple Of Invention)it has to be The Storm Peaks - commented out to make the fix working)
SET @Brann  = 31810;
SET @Voice  = 31814;
SET @Quest  = 13285;
SET @PAura  = 60963; -- See Quest Brann Bronzebeard (TOI)
-- creatures to spawn
DELETE FROM `creature` WHERE `id` IN (@Voice,@Brann);
INSERT INTO `creature`(`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@Brann,571,1,1,0,0,7848.97,-1392.95,1534.06,6.02204,120,0,0,132,0,0,0,0,0,0),
(@Voice,571,1,1,0,0,7859.68,-1396.07,1534.06,5.99062,300,0,0,42,0,0,0,0,0,0);
-- update creature_template and quest_template
UPDATE `creature_template` SET `AIName` = 'SmartAI', `flags_extra` = `flags_extra`| 128 WHERE `entry` = @Voice;
UPDATE `creature_template` SET `npcflag` = 1, `minlevel` = 80, `maxlevel` = 80, `exp` = 2, `mindmg` = 422, `maxdmg` = 586, `attackpower` = 642, `dmg_multiplier` = 7.5, `minrangedmg` = 345, `maxrangedmg` = 509, `rangedattackpower` = 103, `AIName` = 'SmartAI' WHERE `entry` = @Brann;
-- UPDATE `quest_template` SET `SrcSpell` = @PAura WHERE `entry` = @Quest; -- Player get Aura 'See Quest Brann Bronzebeard (TOI)' on quest accept
-- apply aura See Quest Brann Bronzebeard (TOI) in stormpeaks
-- DELETE FROM `spell_area` WHERE `spell` = @PAura;
-- INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES 
-- (60963,67,13285,1,13285,0,0,2,1);
-- creature_template_addon
-- DELETE FROM `creature_template_addon` WHERE `entry` = @Brann;
-- INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
-- (@Brann,0,0,0,4097,0,'49414 0'); -- Generic Quest Invisibility 1*/
-- creature text
DELETE FROM `creature_text` WHERE `entry` IN (@Voice,@Brann);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@Brann,1,0,"Right. Let's see if we can finish this keystone.",0,0,100,1,0,0,'Brann Bronzebeard - TempleOfInnovation - text1'),
(@Brann,2,0,"The keystone is completed! We've done it, $n!",0,0,100,1,5,0,'Brann Bronzebeard - TempleOfInnovation - text2'),
(@Brann,3,0,"Who knows what secrets await within Ulduar's archives? I'm off to discover them. Thank you again for your help, $n. Without it, I'd still be searching for that key.",0,0,100,1,0,0,'Brann Bronzebeard - TempleOfInnovation - text3'),
(@Voice,1,0,"Welcome, Brann Bronzebeard. I am all that remains of this temple's guardian.",0,0,100,1,0,0,'A Distant Voice - TempleOfInnovation - text1'),
(@Voice,2,0,"You have proven yourself as an explorer and seeker of knowledge.",0,0,100,1,0,0,'A Distant Voice - TempleOfInnovation - text2'),
(@Voice,3,0,"You have been a steadfast ally of the Earthen.",0,0,100,1,0,0,'A Distant Voice - TempleOfInnovation - text3'),
(@Voice,4,0,"You and your companions have proven yourselves in combat and in the pursuit of keystone.",0,0,100,1,0,0,'A Distant Voice - TempleOfInnovation - text4'),
(@Voice,5,0,"Your motives are pure. The keystone's parts shall be reunited. Go to Ulduar and learn the answers to your questions, Brann Bronzebeard.",0,0,100,1,0,0,'A Distant Voice - TempleOfInnovation - text5');
-- npc_text
DELETE FROM `npc_text` WHERE `ID` = @Brann;
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`lang0`,`prob0`,`em0_0`,`em0_1`,`em0_2`,`em0_3`,`em0_4`,`em0_5`,`text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,`text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,`text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,`text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,`text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,`text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,`text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,`WDBVerified`) VALUES
(@Brann, '<Brann looks at you expectantly.>','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,1);
-- gossip_menu
DELETE FROM `gossip_menu` WHERE `entry`= @Brann;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@Brann,@Brann);
-- gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `menu_id` = @Brann;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@Brann,0,0,"I'm ready, Brann. Let's make the keystone.",1,1,0,0,0,0,0,'');
-- waypoints
DELETE FROM `waypoints` WHERE `entry` = @Brann;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(@Brann,1,7848.97,-1392.95,1534.06,'ToI Brann Bronzebeard wp1'),
(@Brann,2,7859.68,-1396.07,1534.06,'ToI Brann Bronzebeard wp2'),
(@Brann,3,7800.47,-1409.72,1534.56,'ToI Brann Bronzebeard wp3');
-- SmartAI
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` = @Brann;
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid` IN (@Brann*100,@Brann*100+1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@Brann,0,0,0,62,0,100,0,@Brann,0,0,0,80,@Brann*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'on gossip select - start script1'),
(@Brann,0,1,2,40,0,100,0,2,@Brann,0,0,54,35000,0,0,0,0,0,1,0,0,0,0,0,0,0,'reached wp2 - pause'),
(@Brann,0,2,0,61,0,100,0,0,0,0,0,80,@Brann*100+1,0,0,0,0,0,1,0,0,0,0,0,0,0,'start script2'),
(@Brann,0,3,0,40,0,100,0,3,@Brann,0,0,55,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,'stop at wp3 - after 3sec despawn'),
-- script1
(@Brann*100,9,0,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'turn off gossip flag'),
(@Brann*100,9,1,0,0,0,100,0,1000,1000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'say text1'),
(@Brann*100,9,2,0,0,0,100,0,1000,1000,0,0,53,0,@Brann,0,0,0,0,1,0,0,0,0,0,0,0,'wp start'),
-- script2
(@Brann*100+1,9,0,0,0,0,100,0,0,0,0,0,5,467,0,0,0,0,0,1,0,0,0,0,0,0,0,'emote mining'),
(@Brann*100+1,9,1,0,0,0,100,0,2000,2000,0,0,1,1,0,0,0,0,0,9,@Voice,0,10,0,0,0,0,'Voice say text1'),
(@Brann*100+1,9,2,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,9,@Voice,0,10,0,0,0,0,'Voice say text2'),
(@Brann*100+1,9,3,0,0,0,100,0,5000,5000,0,0,1,3,0,0,0,0,0,9,@Voice,0,10,0,0,0,0,'Voice say text3'),
(@Brann*100+1,9,4,0,0,0,100,0,5000,5000,0,0,1,4,0,0,0,0,0,9,@Voice,0,10,0,0,0,0,'Voice say text4'),
(@Brann*100+1,9,5,0,0,0,100,0,5000,5000,0,0,1,5,0,0,0,0,0,9,@Voice,0,10,0,0,0,0,'Voice say text5'),
(@Brann*100+1,9,6,0,0,0,100,0,5000,5000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Brann say text2'),
(@Brann*100+1,9,7,0,0,0,100,0,0,0,0,0,33,@Brann,0,0,0,0,0,7,0,0,0,0,0,0,0,'give quest credit'),
(@Brann*100+1,9,8,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.33754,'turn'),
(@Brann*100+1,9,9,0,0,0,100,0,5000,5000,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Brann say text3'),
(@Brann*100+1,9,10,0,0,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'set run');
-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = @Brann;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@Brann,0,0,9,@Quest,0,0,0,'', 'show gossip menu option if player has quest 13285');