UPDATE `script_texts` SET `content_loc3`='Lakaien, Diener, Soldaten der eisigen Finsternis! Folgt dem Ruf von Kel\'Thuzad!' WHERE `entry`=-1533105;

-- Fix Quest 11061 - The Plight of a Father
UPDATE gameobject SET position_x=4020.290039, position_y=5895.250000, position_z=267.871002, orientation=3.860500 WHERE guid=13355 ;
-- Fix for Quest 4768 The dark Rune Tablet
DELETE FROM `gameobject`WHERE `id` = 175385;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (175385, 229, 1, 1, 65.677, -281.64, 93.8493, 3.02213, 0, 0, 0.998217, 0.0596968, 300, 0, 1); 
-- Fix Quest 11023 Bomb them Again Reputation
UPDATE `quest_template` SET `RewRepValue1`=0, `RewRepValue2`=0 WHERE `entry`=11023;
-- Quest Feedin' Da Goolz should be for horde, too
UPDATE `quest_template` SET `RequiredRaces` = 0 WHERE `entry` = 12652;
-- Add more Cannonballs for Quests Bombing run and Bomb them again

INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(23118, 530, 1, 1, 0, 0, 1649.8, 7189.4, 369.5, 0, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1657.6, 7210.8, 368.9, 0, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1641.5, 7199.6, 370.7, 6, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1639.1, 7235.8, 369.0, 0, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1624.0, 7249.4, 368.9, 1, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1699.9, 7344.2, 370.1, 5, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1702.6, 7352.8, 370.8, 5, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1721.7, 7379.6, 370.1, 6, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1707.3, 7401.7, 370.0, 0, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 1617.4, 7156.7, 369.7, 0, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 2810.7, 7026.5, 370.0, 2, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 2939.8, 7119.7, 365.5, 3, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 2960.8, 7049.6, 370.5, 3, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8),
(23118, 530, 1, 1, 0, 0, 2971.3, 6891.3, 369.9, 2, 20, 0, 0, 42, 0, 0, 0, 35, 0, 8);

-- Fix for Quest 9446 NPC talking Draconic
UPDATE `script_texts` SET `language`=7 WHERE `npc_entry`=0 AND `entry`=-1800070 LIMIT 1;
UPDATE `script_texts` SET `language`=7 WHERE `npc_entry`=0 AND `entry`=-1800069 LIMIT 1;
UPDATE `script_texts` SET `language`=7 WHERE `npc_entry`=0 AND `entry`=-1800068 LIMIT 1;
UPDATE `script_texts` SET `language`=7 WHERE `npc_entry`=0 AND `entry`=-1800067 LIMIT 1;
UPDATE `script_texts` SET `language`=7 WHERE `npc_entry`=0 AND `entry`=-1800066 LIMIT 1;
UPDATE `script_texts` SET `language`=7 WHERE `npc_entry`=0 AND `entry`=-1800065 LIMIT 1;
UPDATE `script_texts` SET `language`=7 WHERE `npc_entry`=0 AND `entry`=-1800064 LIMIT 1;
-- Fix for Quest 9375 The Road to Falcon Watch

UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14 WHERE `entry`=16967 LIMIT 1;
-- Fix for Quest 5122 The Medaillon of Faith
UPDATE `gameobject_template` SET `flags`=0 WHERE `entry`=176112 LIMIT 1;
-- Majestic Dragon Figurine
DELETE FROM `spell_proc_event` WHERE `entry`=60524;
INSERT INTO `spell_proc_event` (`entry`,`procEx`) VALUES (60524,65536);

-- Lightweave Embroidery
UPDATE `spell_proc_event` SET `procEx`=65536 WHERE `entry`=55640;

-- spawn algalon
DELETE FROM `creature` WHERE `id`=32871;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('302616','32871','603','3','1','0','0','1632.36','-310.093','417.321','1.8445','604800','0','0','34862500','0','0','0','0','0','0');

-- set to friendly by default
UPDATE `creature_template` SET `faction_A`=35, `faction_H`=35, `flags_extra`=1 WHERE `entry` IN (32871,33070);

-- Fix for Quest 9948 Find the Survivors
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=-182484 WHERE `entry`=9948;

UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22915;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22916;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22917;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22918;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22919;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22920;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22921;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22922;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22923;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22924;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22925;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22926;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22927;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22928;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22929;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22930;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22931;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22932;
UPDATE `gameobject` SET `id`=182484 WHERE `guid`=22933;

DELETE FROM `gameobject_template` WHERE `entry`=182486;
DELETE FROM `gameobject_template` WHERE `entry`=182487;
DELETE FROM `gameobject_template` WHERE `entry`=182488;
DELETE FROM `gameobject_template` WHERE `entry`=182489;
DELETE FROM `gameobject_template` WHERE `entry`=182490;
DELETE FROM `gameobject_template` WHERE `entry`=182491;
DELETE FROM `gameobject_template` WHERE `entry`=182492;
DELETE FROM `gameobject_template` WHERE `entry`=182493;
DELETE FROM `gameobject_template` WHERE `entry`=182494;
DELETE FROM `gameobject_template` WHERE `entry`=182495;
DELETE FROM `gameobject_template` WHERE `entry`=182496;
DELETE FROM `gameobject_template` WHERE `entry`=182497;
DELETE FROM `gameobject_template` WHERE `entry`=182498;
DELETE FROM `gameobject_template` WHERE `entry`=182499;
DELETE FROM `gameobject_template` WHERE `entry`=182500;
DELETE FROM `gameobject_template` WHERE `entry`=182501;
DELETE FROM `gameobject_template` WHERE `entry`=182502;
DELETE FROM `gameobject_template` WHERE `entry`=182503;
DELETE FROM `gameobject_template` WHERE `entry`=182504;
-- Eishorn
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32361;
-- Aotona
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16, `minlevel`=75, `maxlevel`=75 WHERE `entry`=32481;
-- Tukemuth
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32400;
-- High Thane Jorfus
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32501;
-- Hildana Deathstealer
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32495;
-- Old Crystalbark
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32357;
-- Fumblub Gearwind
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32358;
-- Perobas the Bloodthirster
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32377;
-- Vigdis the War Maiden
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32386;
-- King Ping
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32398;
-- Crazed Indule Survivor
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32409;
-- Grocklar
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32422;
-- Seething Hate
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32429;
-- Syreian the Bonecarver
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32438;
-- Zuldrak Sentinel
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32447;
-- Griegen
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16, `minlevel`=75, `maxlevel`=75 WHERE `entry`=32471;
-- Terror Spinner
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry`=32475;

-- Fix Quest 11145 Prisoners of the Grimtotems
UPDATE `gameobject_template` SET `data2`=300000 WHERE `entry`=186287;
-- Fix for Quest 10852 Missing Friends

UPDATE `gameobject_template` SET `data2`=300000 WHERE `entry`=185202;
UPDATE `gameobject` SET `id`=185202 WHERE `guid`=26089;
UPDATE `gameobject` SET `id`=185202 WHERE `guid`=26090;
UPDATE `gameobject` SET `id`=185202 WHERE `guid`=26091;

UPDATE `quest_template` SET `ReqCreatureOrGOId1`=-185202 , `ReqSpellCast1`=38779, `ReqCreatureOrGOCount1`=6 WHERE `entry`=10852;
-- Fix Quest 9923 Free Corki
UPDATE `quest_template` SET `ReqSpellCast1`=32249, `ReqCreatureOrGOId1`=-182349 WHERE `entry`=9923 LIMIT 1;
UPDATE `gameobject_template` SET `data2`=300000 WHERE `entry`=182349;
-- Fix Item Brann's Communicator #40971
DELETE FROM spell_linked_spell WHERE spell_trigger = 61122;
INSERT INTO spell_linked_spell VALUES
(61122,55038,0,'summon Brann Bronzebeard on item use');
-- Update unit_flags of Brann
UPDATE creature_template SET unit_flags = unit_flags | 518 WHERE entry = 29579;
-- Fix Quest #7481(H) &  #7482(A)'Elven Legends'
SET @HQuest = 7481;
SET @AQuest = 7482;
SET @Gossip = 5743; 	-- gossip_menu id Kariel
SET @Kariel = 179544; 	-- GO Skeletal Remains of Kariel Winthalus
SET @Lydros = 14368; 	-- Lorekeeper Lydros
-- update
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@Kariel;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@Lydros;
-- creature_text
DELETE FROM creature_text WHERE entry = @Lydros;
INSERT INTO creature_text VALUES
(@Lydros,0,0,"I very much doubt that he will have anything to say, stranger...",0,0,0,1,0,0,'text0'),
(@Lydros,1,0,"I personally didn't mind him. It was the Prince who took exception to a high elf in his domain. Alas, I am not one to question the Prince. In his defense, he did not incinerate master Winthalus immediately.",0,0,0,1,0,0,'text1'),
(@Lydros,2,0,"We most definitely do not need any more attention drawn to us, stranger. Return to those that sent you in search of the lost master and tell them that nothing could be found. When this is done - and I will know when it is so - return and I shall reveal the secrets of the deceased.",0,0,0,1,0,0,'text2');
-- gossip_menu_option
DELETE FROM gossip_menu_option WHERE menu_id = @Gossip;
INSERT INTO gossip_menu_option VALUES
(@Gossip,0,0,"Please, give me your knowledge!",1,1,0,0,0,0,0,''),
(@Gossip,1,0,"Please, give me your knowledge!",1,1,0,0,0,0,0,'');
-- SmartAI
DELETE FROM smart_scripts WHERE entryorguid IN (@Kariel,@Kariel*100,@Lydros);
INSERT INTO smart_scripts VALUES
(@Kariel,1,0,1,62,0,100,0,@Gossip,0,0,0,80,@Kariel*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'on gossip0 select - start script'),
(@Kariel,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
(@Kariel,1,2,3,62,0,100,0,@Gossip,1,0,0,80,@Kariel*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'on gossip1 select - start script'),
(@Kariel,1,3,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
(@Kariel*100,9,1,0,0,0,100,0,1000,1000,0,0,45,0,1,0,0,0,0,9,@Lydros,0,15,0,0,0,0, 'set data 0 1'),
(@Kariel*100,9,2,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,9,@Lydros,0,30,0,0,0,0,'say text0'),
(@Kariel*100,9,3,0,0,0,100,0,4000,4000,0,0,1,1,0,0,0,0,0,9,@Lydros,0,30,0,0,0,0,'say text1'),
(@Kariel*100,9,4,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,9,@Lydros,0,30,0,0,0,0,'say text2'),
(@Kariel*100,9,5,7,0,0,100,0,4000,4000,0,0,15,@HQuest,0,0,0,0,0,7,0,0,0,0,0,0,0,'quest credit'),
(@Kariel*100,9,6,7,0,0,100,0,0,0,0,0,15,@AQuest,0,0,0,0,0,7,0,0,0,0,0,0,0,'quest credit'),
(@Kariel*100,9,7,0,0,0,100,0,2000,2000,0,0,45,0,2,0,0,0,0,9,@Lydros,0,15,0,0,0,0, 'set data  0 2'),
-- Lydros
(@Lydros,0,0,1,38,0,100,0,0,1,0,0,66,0,0,0,0,0,0,17,0,15,0,0,0,0,0, 'on dataset 0 1 - turn closest player'),
(@Lydros,0,1,0,38,0,100,0,0,2,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,3.12, 'on dataset 0 2 - turn to bookshelf');
-- conditions
DELETE FROM conditions WHERE SourceTypeOrReferenceId =15 AND SourceGroup = @Gossip;
DELETE FROM conditions WHERE SourceTypeOrReferenceId =20 AND SourceEntry IN (7483,7484,7485);
INSERT INTO conditions VALUES
(15,@Gossip,0,0,9,@HQuest,0,0,0,'','show gossip menu option if player has quest 7481'),
(15,@Gossip,1,0,9,@AQuest,0,0,0,'','show gossip menu option if player has quest 7482');
-- Fix Loot table for Clams

-- Giant Clam Object 2744
UPDATE `gameobject_template` SET `data2`=300 WHERE `entry`=2744 LIMIT 1;
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=65, `groupid`=0 WHERE `entry`=2264 AND `item`=4611 LIMIT 1;
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=24, `groupid`=0 WHERE `entry`=2264 AND `item`=4655 LIMIT 1;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`)
VALUES
(2264, 5504,  22, 1, 0, 1, 3),
(2264, 5503,  13, 1, 0, 1, 1),
(2264, 5500, 1.2, 1, 0, 1, 1),
(2264, 5498, 1.2, 1, 0, 1, 1);

-- Small Barnacled Clam Item 5523 lvl10 58172
DELETE FROM `spell_loot_template` WHERE `entry`=58172 AND `item`=4611 LIMIT 1;
DELETE FROM `spell_loot_template` WHERE `entry`=58172 AND `item`=5500 LIMIT 1;
-- Thick Shelled Clam Item 5524 lvl20 58168
DELETE FROM `spell_loot_template` WHERE `entry`=58168 AND `item`=4611 LIMIT 1;
UPDATE `spell_loot_template` SET `ChanceOrQuestChance`=50 WHERE `entry`=58168 AND `item`=5504 LIMIT 1;

-- Fix Quest 11026 Banish the Demons Reputation Value
UPDATE `quest_template` SET `RequiredMinRepValue`=9000 WHERE `entry`=11026 LIMIT 1;
-- Fix Quest 'A Dire Situation' #10506
UPDATE quest_template SET ReqCreatureOrGOId1 = 20058, ReqCreatureOrGOCount1 = 5, ReqSpellCast1=36310 WHERE entry = 10506;
-- Fix Quest 11676 Merciful Freedom
UPDATE `quest_template` SET `ReqSpellCast1`=45807 WHERE `entry`=11676 LIMIT 1;
-- Fix Quest 10855 Fel Reaver, No Thanks!
DELETE FROM `quest_end_scripts` WHERE `id` =10850;
INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`)
VALUES
(10850, 2, 8, 22293, 0, 0, 0, 0, 0, 0);

-- Fix NPC 26467 being rooted
UPDATE `creature_template` SET `dynamicflags`=0 WHERE `entry`=26467 LIMIT 1;
-- Fix Quests 10182,10305,10306,10307
UPDATE item_template SET ScriptName="item_belmara_luminrath_frostweaver_dathric" WHERE entry IN(28336,28352,28353,34144);
UPDATE quest_template SET questflags=130,ReqCreatureOrGOId1=0,ReqCreatureOrGOCount1=0 WHERE entry IN(10305,10306,10307,10182);

DELETE FROM spell_script_names WHERE spell_id IN(34140,34142,34144,34141);
INSERT INTO spell_script_names VALUES
(34140,"spell_belmara_luminrath_frostweaver_dathric"),
(34142,"spell_belmara_luminrath_frostweaver_dathric"),
(34144,"spell_belmara_luminrath_frostweaver_dathric"),
(34141,"spell_belmara_luminrath_frostweaver_dathric");

-- Fix Item 33450 Carved Horn to prevent Mass-spawning of NPC
UPDATE `item_template` SET `spellcooldown_1`=300000 WHERE `entry`=33450 LIMIT 1; 
-- Fix Quest 6129 Curing the Sick
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=12296 WHERE `entry`=6129 LIMIT 1;
-- Fix Quest 11730 Master and Servant
UPDATE `quest_template` SET `ReqSpellCast1`=46023 WHERE `entry`=11730 LIMIT 1;
-- Fix Quest 2203 Badlands Reagent Run II
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (9712, 21029, 'Thaumaturgy Channel');
-- Workaround for Quest 12243 Fire on the Water

INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (48455, 50290, 'Apothecary\'s Burning Water');

UPDATE `creature_template` SET `lootid`=27232 WHERE `entry`=27232 LIMIT 1;

DELETE FROM `creature_loot_template` WHERE `entry` =27232;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`)
VALUES
(27232, 45912, 0.1, 1, 0, 1, 1),
(27232, 37304, -100, 1, 0, 1, 1),
(27232, 43851, 27, 1, 0, 1, 1),
(27232, 33470, 14, 1, 0, 1, 3),
(27232, 33443, 4, 1, 0, 1, 1),
(27232, 22829, 2, 1, 0, 1, 1),
(27232, 33444, 2, 1, 0, 1, 1);

-- Workaround for Quest 12066 The Focus on the Beach

INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (47374, 47391, 'Ley Line Information');
-- Fix for Quest 12805 Salvaging Life's Strength

UPDATE `quest_template` SET `ReqCreatureOrGOId1`=29124, `ReqSpellCast1`=54191 WHERE `entry`=12805 LIMIT 1;

-- Fix Quests 4293, 4294, 4561, 4661
UPDATE `quest_template` SET `ExclusiveGroup`=0 WHERE `entry`=4293 LIMIT 1;
UPDATE `quest_template` SET `ExclusiveGroup`=0 WHERE `entry`=4294 LIMIT 1;
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
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `exp` = 2, `mindmg` = 422, `maxdmg` = 586, `attackpower` = 642, `dmg_multiplier` = 7.5, `minrangedmg` = 345, `maxrangedmg` = 509, `rangedattackpower` = 103, `AIName` = 'SmartAI' WHERE `entry` = @Brann;
/* UPDATE `quest_template` SET `SrcSpell` = @PAura WHERE `entry` = @Quest; -- Player get Aura 'See Quest Brann Bronzebeard (TOI)' on quest accept
-- apply aura See Quest Brann Bronzebeard (TOI) in stormpeaks
DELETE FROM `spell_area` WHERE `spell` = @PAura;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_start_active`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`) VALUES 
(60963,67,13285,1,13285,0,0,2,1);
-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = @Brann;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(@Brann,0,0,0,4097,0,'49414 0'); -- Generic Quest Invisibility 1*/
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
DELETE FROM `creature_loot_template` WHERE `entry`=31311 AND `item` IN (40628,40629,40630);

DELETE FROM `creature_loot_template` WHERE `entry`=31311 AND `item`=50105;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`)
VALUES
(31311,50105,100,1,0,-50105,2);

DELETE FROM `reference_loot_template` WHERE `entry`=50105;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`)
VALUES
(50105,40628,0,1,1,1,1),
(50105,40629,0,1,1,1,1),
(50105,40630,0,1,1,1,1);

-- make Garwal tameable (24277 normal - 24278 worgen)
UPDATE creature_template SET type_flags = type_flags | 1 WHERE entry IN (24277,24278); 
-- Quest 11879 'Kaw the Mammoth Destroyer' spawn Kaw's War Halberd (188066) after Kaws Dead
-- use SmartAI instead of EventAI
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = 25802;
DELETE FROM creature_ai_scripts WHERE creature_id = 25802;
-- create SmartAI
DELETE FROM smart_scripts WHERE entryorguid = 25802;
INSERT INTO smart_scripts VALUES
(25802, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 46310, 0x02, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'on death cast spell');
