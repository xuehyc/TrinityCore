-- Invisible NPC
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=38442;

-- https://www.wowhead.com/quest=24814/an-ancient-enemy
-- https://www.wowhead.com/npc=38306/zarjira
UPDATE `creature_template` SET `HealthModifier`=8 WHERE `entry`=38306;

UPDATE `gossip_menu_option` SET `OptionText`='Estoy listo, Vol''jin.', `OptionType`=1, `OptionNpcFlag`=1 WHERE `MenuId`=11020;
UPDATE `gossip_menu_option` SET `OptionText`='Vanira, si puedes, mándame de vuelta a la fortaleza de Darkspear.', `OptionType`=1, `OptionNpcFlag`=1 WHERE `MenuId`=11107;

-- https://www.wowhead.com/npc=38225/voljin
UPDATE `creature_template` SET `npcflag`=1 WHERE `entry`=38225;

-- Voljin SAI 38225
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (38225, 382250);
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,
`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(38225,0,0,0,62,0,100,512,11020,0,0,0,80,382250,2,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin Gossip Select - MenuId 11020 - Action List'),
(38225,0,1,0,0,0,100,0,2000,2000,5000,5000,11,20463,0,0,0,0,0,11,38306,25,0,0,0,0,0,'Voljin In Combat - Cast Spell Shoot - Target Zarjira 25 yards'),
(38225,0,2,0,8,0,100,513,46987,0,0,0,45,10,10,0,0,0,0,11,38423,15,0,0,0,0,0,'Voljin - Spell Hit Frostbolt - Zuni 15 yards'),
(38225,0,3,0,8,0,100,512,73255,0,0,0,45,11,11,0,0,0,0,11,38437,25,0,0,0,0,0,'Voljin - Spell Hit Earth Shock - Vanira 25 yards'),
(38225,0,4,0,0,0,100,513,500,500,500,500,18,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin - Set Unit Flag'),	
(38225,0,5,0,38,0,100,512,12,12,0,0,18,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin - Set Unit Flag'),
(38225,0,6,0,38,0,100,512,13,13,0,0,19,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin - Remove Unit Flag'),
(38225,0,7,0,0,0,100,0,200,5000,7000,7000,11,73087,0,0,0,0,0,11,38306,25,0,0,0,0,0,'Voljin - Cast Spell Shadow Shock - Target Zarjira 25 yards'),	
(38225,0,8,0,2,0,100,512,5,8,0,0,45,21,21,0,0,0,0,11,38423,50,0,0,0,0,0,'Voljin Healt PCT - Set Data - Zuni 50 yards'),	
(382250,9,0,0,0,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin In Combat - Run'),
(382250,9,1,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,-719.185,-5595.53,25.6,0.9404,'Voljin In Combat - Move Position'),
(382250,9,2,0,0,0,100,0,0,0,0,0,19,33024,0,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin In Combat - Remove Unit Flag'),
(382250,9,3,0,0,0,100,0,0,0,0,0,45,1,1,0,0,0,0,11,38437,10,0,0,0,0,0,'Voljin - Set Data - Vanira 10 yards'),
(382250,9,4,0,0,0,100,0,0,0,0,0,45,2,2,0,0,0,0,11,38437,10,0,0,0,0,0,'Voljin - Set Data - Vanira 10 yards'),
(382250,9,5,0,0,0,100,0,4000,4000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin - Talk0'),
(382250,9,6,0,0,0,100,0,6000,6000,0,0,45,3,3,0,0,0,0,11,38306,25,0,0,0,0,0,'Voljin - Set Data - Zarjira 25 yards'),
(382250,9,7,0,0,0,100,0,4000,4000,0,0,45,19,19,0,0,0,0,11,38437,50,0,0,0,0,0,'Voljin - Set Data - Vanira 50 yards'),
(382250,9,8,0,0,0,100,0,2000,2000,0,0,45,4,4,0,0,0,0,11,38423,50,0,0,0,0,0,'Voljin - Set Data - Zuni 50 yards'),
(382250,9,9,0,0,0,100,0,0,0,0,0,45,5,5,0,0,0,0,11,38423,50,0,0,0,0,0,'Voljin - Set Data - Zuni 50 yards'),
(382250,9,10,0,0,0,100,0,0,0,0,0,45,6,6,0,0,0,0,11,38306,25,0,0,0,0,0,'Voljin - Set Data - Zarjira 25 yards'),
(382250,9,11,0,0,0,100,0,0,0,0,0,18,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Voljin - Set Unit Flag'),
(382250,9,12,0,0,0,100,0,0,0,0,0,45,7,7,0,0,0,0,11,38306,25,0,0,0,0,0,'Voljin - Set Data - Zarjira 25 yards');

-- Voljin Text 38225
DELETE FROM `creature_text` WHERE `CreatureID`=38225;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(38225,0,0,'Ya fuiste tonto por venir aquí. Bruja del mar Ya escapaste de nuestra venganza una vez, pero la Tribu Darkspear no te tolerará otra vez.',14,0,100,0,0,0,0,0,'Voljin');

-- Zarjira SAI 38306
UPDATE `smart_scripts` SET `event_param1`=1000, `event_param2`=1000 WHERE `entryorguid`=38306 AND `id`=3;

-- Zarjira Text 38306
DELETE FROM `creature_text` WHERE `CreatureID`=38306;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(38306,0,0,'Eres débil Vol''jin, como tu padre era débil. Hoy terminaré lo que empecé hace mucho tiempo: ¡el Darkspear se borrará de la existencia!',14,0,100,0,0,0,0,0,'Zarjira');

-- Vanira SAI 38437
DELETE FROM `smart_scripts` WHERE `entryorguid`=38437 AND `id`=6 OR `entryorguid`=384370;
INSERT INTO `smart_scripts`(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,
`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(38437,0,6,0,62,0,100,512,11107,0,0,0,80,384370,2,0,0,0,0,1,0,0,0,0,0,0,0,'Vanira Gossip Select - MenuId 11107 - Action List'),
(384370,9,0,0,0,0,100,0,0,0,0,0,62,1,0,0,0,0,0,7,0,0,0,-1285.222900,-5564.873047,20.926844,3.967118,'Vanira - Teleport');

-- Vanira Text 38437 
DELETE FROM `creature_text` WHERE `CreatureID`=38437;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(38437,0,0,'¡Cuida sus espíritus! Estaremos en manos de Zar''jira.',14,0,100,0,0,0,0,0,'Vanira');

-- Zuni Text 38423 
DELETE FROM `creature_text` WHERE `CreatureID`=38423;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(38423,0,0,'Voy a conseguir que los incendios mueran a tiempo!',14,0,100,0,0,0,0,0,'Zuni');

-- Temporary solution for quest 25187 Lost in the floods.
-- https://www.wowhead.com/quest=25187/lost-in-the-floods
-- https://www.wowhead.com/npc=39323/thonk
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=39323;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (39323, 3932300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(39323,0,0,1,19,0,100,0,25187,0,0,0,80,3932300,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thonk - Quest Accept - Action List'),
(3932300,9,1,2,1,0,100,0,2000,3000,0,0,33,39357,0,0,0,0,0,7,0,0,0,0,0,0,0,'Action List - Quest KC - Raggaran'),
(3932300,9,2,3,1,0,100,0,2000,3000,0,0,33,39358,0,0,0,0,0,7,0,0,0,0,0,0,0,'Action List - Quest KC - Flooded Hut'),
(3932300,9,3,4,1,0,100,0,2000,3000,0,0,33,39359,0,0,0,0,0,7,0,0,0,0,0,0,0,'Action List - Quest KC - Misha'),
(3932300,9,4,5,1,0,100,0,2000,3000,0,0,33,39360,0,0,0,0,0,7,0,0,0,0,0,0,0,'Action List - Quest KC - Zen''Taji');

-- https://www.wowhead.com/quest=25188/watershed-patrol
DELETE FROM `quest_objectives_locale` WHERE `QuestId`=25188 and `StorageIndex`=0;
DELETE FROM `quest_objectives` WHERE `QuestID`=25188;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex` , `ObjectID`, `Amount`, `Flags`, `Flags2`, `ProgressBarWeight`, `Description`, `VerifiedBuild`) VALUES 
(256507, 25188, 0, 0, 0, 39332, 1, 0, 0, 0, 'Help Raggaran', 25996),
(256508, 25188, 0, 1, 1, 39333, 1, 0, 0, 0, 'Help Misha Tor''kren', 25996),
(256509, 25188, 0, 2, 2, 39334, 1, 0, 0, 0, 'Help Zen''Taji', 25996);

DELETE FROM `quest_poi` WHERE `QuestID`=25188;
INSERT INTO `quest_poi` (`QuestID`, `BlobIndex`, `Idx1`, `ObjectiveIndex`, `QuestObjectiveID` , `QuestObjectID`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `WorldEffectID`, `PlayerConditionID`, `WoDUnk1`, `AlwaysAllowMergingBlobs`, `VerifiedBuild`) VALUES 
(25188,	0, 1, 0, 256507, 39332, 1, 4, 0, 0, 1, 0, 0, 0, 0, 22908),
(25188,	0, 2, 1, 256508, 39333, 1, 4, 0, 0, 1, 0, 0, 0, 0, 22908),
(25188,	0, 3, 2, 256509, 39334, 1, 4, 0, 0, 1, 0, 0, 0, 0, 22908);

DELETE FROM `quest_poi_points` WHERE `QuestID`=25188 AND `Idx1`=0 AND `Idx2`=0;

-- https://www.wowhead.com/npc=39325/grandmatron-tekla
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=39325;
DELETE FROM `creature` WHERE `guid` IN (253489, 280000128);
INSERT INTO `creature`(`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(280000128, 39325, 1, 14, 4981, 0, 0, 0, 0, -1, 0, 0, 525.486, -4075.27, 20.3289, 2.89734, 300, 0, 0, 283, 178, 0, 0, 0, 0, 0, 0, 0, '');

-- https://www.wowhead.com/npc=3193/misha-torkren
-- https://www.wowhead.com/npc=39333/durotar-watershed-quest-kc-3
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=10, `maxlevel`=20 WHERE `entry`=3193;

DELETE FROM `smart_scripts` WHERE `entryorguid`=3193;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3193,0,0,0,20,0,100,512,25193,0,0,0,33,39333,0,0,0,0,0,21,10,0,0,0,0,0,0,'Misha Torkren Quest Reward - Quest Credit 39333 - Closest Player');

-- https://www.wowhead.com/npc=39326/raggaran
-- https://www.wowhead.com/npc=39332/durotar-watershed-quest-kc-2
UPDATE `creature_template` SET `AIName`='SmartAI', `minlevel`=10, `maxlevel`=20 WHERE `entry`=39326;
DELETE FROM `smart_scripts` WHERE `entryorguid`=39326;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(39326,0,0,0,20,0,100,512,25192,0,0,0,33,39332,0,0,0,0,0,21,10,0,0,0,0,0,0,'Raggaran Quest Reward - Quest Credit 39332 - Closest Player');

-- https://www.wowhead.com/npc=39324/zentaji
-- https://www.wowhead.com/npc=39334/durotar-watershed-quest-kc-4
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=39324;
DELETE FROM `smart_scripts` WHERE `entryorguid`=39324;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(39324,0,0,0,20,0,100,512,25195,0,0,0,33,39334,0,0,0,0,0,21,10,0,0,0,0,0,0,'Zen''taji Quest Reward - Quest Credit 39334 - Closest Player');
