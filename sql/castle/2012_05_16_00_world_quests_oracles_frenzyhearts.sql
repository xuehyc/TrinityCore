-- summon heros headgear on explosives hit (doesnt account for death yet, but who cares...honestly)
DELETE FROM creature_ai_scripts WHERE creature_id = 28877 AND event_type = 8 AND event_param1 = 53145;
INSERT INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES 
(2887702, 28877, 8, 0, 100, 0, 53145, 0, 0, 0, 11, 53162, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwatcher - Summon Headgear on Explosives Hit');

-- quest pooling oracle / frenzyheart
-- merge from trinitycore (commit 166e5d23bf87225a4af921165867c0accb1cf715)
-- by treak
DELETE FROM `pool_template` WHERE `entry` IN (12000,12001,12002,12003);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(12000,1,'Oracle Soo-nee - Oracle Dailies'),
(12001,1,'Oracle Soo-dow - Oracle Dailies'),
(12002,1,'Rejek - Frenzyheart Tribe Dailies'),
(12003,1,'Vekgar - Frenzyheart Tribe Dailies');

DELETE FROM `pool_quest` WHERE `entry` IN (12735,12736,12737,12726,12761,12762,12705,12758,12734,12741,12732,12703,12760,12759);
INSERT INTO `pool_quest` (`entry`,`pool_entry`,`description`) VALUES
-- ORACLE
-- Oracle Soo-nee
(12735,12000,'A Cleansing Song / Oracle Daily / Oracle Soo-nee'),
(12736,12000,'Song of Fecundity / Oracle Daily / Oracle Soo-nee'),
(12737,12000,'Song of Reflection / Oracle Daily / Oracle Soo-nee'),
(12726,12000,'Song of Wind and Water / Oracle Daily / Oracle Soo-nee'),
-- Oracle Soo-say
-- 12704|Appeasing the Great Rain Stone|everyday available
-- Oracle Soo-dow
(12761,12001,'Mastery of the Crystals / Oracle Daily / Oracle Soo-dow'),
(12762,12001,'Power of the Great Ones / Oracle Daily / Oracle Soo-dow'),
(12705,12001,'Will of the Titans / Oracle Daily / Oracle Soo-dow'),
-- FRENZYHEART TRIBE
-- Rejek
(12758,12002,'A Heros''s Headgear / Frenzyheart Tribe Daily / Rejek'),
(12734,12002,'Rejek: First Blood / Frenzyheart Tribe Daily / Rejek'),
(12741,12002,'Strength of the Tempest / Frenzyheart Tribe Daily / Rejek'),
(12732,12002,'The Heartblood''s Strength / Frenzyheart Tribe Daily / Rejek'),
-- Elder Harkek
-- 12702|Chicken Party|everyday available
-- Vekgar
(12703,12003,'Kartak''s Rampage / Frenzyheart Tribe Daily / Vekgar'),
(12760,12003,'Secret Strength of the Frenzyheart / Frenzyheart Tribe Daily / Vekgar'),
(12759,12003,'Tools of War / Frenzyheart Tribe Daily / Vekgar');

-- fix rejek: first blood
-- Rejek: First Blood
-- merge from trinitycore issue tracker (https://github.com/TrinityCore/TrinityCore/issues/6113)
-- author: Xanvial
SET @SPELL := 52992;
SET @WASP := 28086;
SET @HARDKNUCKLE := 28096;
SET @WARRIOR := 28109;
SET @ORACLE := 28110;
SET @CREDIT1 := 28040;
SET @CREDIT2 := 36189;
SET @CREDIT3 := 29043;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@WASP;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@WASP;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@WASP;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@WASP,0,0,0,2,0,100,0,0,30,7000,9000,11,34392,1,0,0,0,0,1,0,0,0,0,0,0,0,'Sapphire Hive Wasp - On HP 30% - Cast Stinger Rage'),
(@WASP,0,1,0,8,0,100,1,@SPELL,0,0,0,33,@CREDIT1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Sapphire Hive Wasp - On Spellhit - Give Quest Credit');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@HARDKNUCKLE;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@HARDKNUCKLE;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@HARDKNUCKLE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@HARDKNUCKLE,0,0,0,9,0,100,0,10,30,0,0,11,49758,1,0,0,0,0,2,0,0,0,0,0,0,0,'Hardknuckle Charger - On range - Cast Charge'),
(@HARDKNUCKLE,0,1,0,8,0,100,1,@SPELL,0,0,0,33,@CREDIT2,0,0,0,0,0,7,0,0,0,0,0,0,0,'Hardknuckle Charger - On Spellhit - Give Quest Credit');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@WARRIOR;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@WARRIOR;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@WARRIOR;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@WARRIOR,0,0,0,0,0,100,0,2000,6000,4000,7000,11,50533,1,0,0,0,0,2,0,0,0,0,0,0,0,'Mistwhisper Warrior - IC - Cast Flip Arrack'),
(@WARRIOR,0,1,0,8,0,100,1,@SPELL,0,0,0,33,@CREDIT3,0,0,0,0,0,7,0,0,0,0,0,0,0,'Mistwhisper Warrior - On Spellhit - Give Quest Credit');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ORACLE;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ORACLE;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ORACLE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ORACLE,0,0,0,0,0,100,0,0,0,60000,60000,11,54921,1,0,0,0,0,1,0,0,0,0,0,0,0,'Mistwhisper Oracle - IC - Cast Lightning Cloud'),
(@ORACLE,0,1,0,8,0,100,1,@SPELL,0,0,0,33,@CREDIT3,0,0,0,0,0,7,0,0,0,0,0,0,0,'Mistwhisper Oracle - On Spellhit - Give Quest Credit');

