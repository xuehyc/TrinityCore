
SET @QUEST=2459; -- http://www.wowhead.com/quest=2459
SET @QUESTSTARTERENDER=3567;

DELETE FROM `creature_queststarter` WHERE `quest` = @QUEST;
DELETE FROM `gameobject_queststarter` WHERE `quest` = @QUEST;
DELETE FROM `creature_questender` WHERE `quest` = @QUEST;
DELETE FROM `gameobject_questender` WHERE `quest` = @QUEST;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@QUESTSTARTERENDER, @QUEST);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@QUESTSTARTERENDER, @QUEST);
UPDATE `item_template` SET `StartQuest`=0 WHERE `StartQuest` = @QUEST;
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` = @QUESTSTARTERENDER;
UPDATE `quest_template` SET `RequiredSourceItemId1` = 0, `RequiredSourceItemCount1` = 0, `RequiredSourceItemCount4` = 0 WHERE `Id` = @QUEST;
 
SET @Morchok=55265;
UPDATE `creature_template` SET `lootid` = @Morchok WHERE `entry` = @Morchok;
 
DELETE FROM `creature_loot_template` WHERE (`entry`=@Morchok);
INSERT INTO `creature_loot_template` VALUES
(@Morchok, 77952, 34, 1, 0, 1, 3),
(@Morchok, 71998, 31, 1, 0, 1, 3),
(@Morchok, 77262, 13, 1, 0, 1, 1),
(@Morchok, 77214, 12, 1, 0, 1, 1),
(@Morchok, 77268, 11, 1, 0, 1, 1),
(@Morchok, 77212, 11, 1, 0, 1, 1),
(@Morchok, 77270, 11, 1, 0, 1, 1),
(@Morchok, 77269, 11, 1, 0, 1, 1),
(@Morchok, 77271, 11, 1, 0, 1, 1),
(@Morchok, 77267, 10, 1, 0, 1, 1),
(@Morchok, 77266, 7, 1, 0, 1, 1),
(@Morchok, 77261, 7, 1, 0, 1, 1),
(@Morchok, 77265, 7, 1, 0, 1, 1),
(@Morchok, 77263, 7, 1, 0, 1, 1),
(@Morchok, 77210, 0.8, 1, 0, 1, 1),
(@Morchok, 77232, 0.8, 1, 0, 1, 1),
(@Morchok, 77230, 0.7, 1, 0, 1, 1),
(@Morchok, 77208, 0.7, 1, 0, 1, 1),
(@Morchok, 77228, 0.7, 1, 0, 1, 1),
(@Morchok, 77231, 0.7, 1, 0, 1, 1),
(@Morchok, 77229, 0.7, 1, 0, 1, 1),
(@Morchok, 77207, 0.7, 1, 0, 1, 1),
(@Morchok, 77209, 0.7, 1, 0, 1, 1),
(@Morchok, 77211, 0.6, 1, 0, 1, 1);

-- no creature exist that use this loot 
DELETE FROM `pickpocketing_loot_template` WHERE (`entry`=20051);
 
 -- wrong name Defias Cutpurse
UPDATE `creature_template` SET `name` = 'Cutpurse', `minlevel` = 5, `Health_mod` = 2 WHERE `entry` = 94;
 
 -- min max gold is now 0
UPDATE `creature_template` SET `mingold` = 6, `maxgold` = 7, `Health_mod` = 2 WHERE `entry` = 299;
 
 -- Goldtooth to week????
UPDATE `creature_template` SET `Health_mod` = 6 WHERE `entry` = 327;
 
SET @IronjawBehemoth=44113;
DELETE FROM `item_loot_template` WHERE `entry`=@IronjawBehemoth and item=0;
 
DELETE FROM `gameobject_loot_template` WHERE `entry` in (195447,195448);
INSERT INTO `gameobject_loot_template` VALUES
(195447, 48128, -100, 1, 0, 1, 5),
(195448, 48128, -100, 1, 0, 1, 5);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205582);
INSERT INTO `gameobject_loot_template` VALUES
(205582, 61376, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=207389);
INSERT INTO `gameobject_loot_template` VALUES
(207389, 65615, -87, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=204410);
INSERT INTO `gameobject_loot_template` VALUES
(204410, 59123, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=203129);
INSERT INTO `gameobject_loot_template` VALUES
(203129, 55151, -93, 1, 0, 1, 1),
(203129, 80315, -6, 1, 0, 1, 1);

DELETE FROM `gameobject_loot_template` WHERE (`entry`=203130);
INSERT INTO `gameobject_loot_template` VALUES
(203130, 55151, -100, 1, 0, 1, 1),
(203130, 117, 0.3, 1, 0, 1, 1),
(203130, 49751, 0.2, 1, 0, 1, 1),
(203130, 57544, 0.12, 1, 0, 5, 5),
(203130, 57541, 0.12, 1, 0, 1, 1),
(203130, 57543, 0.12, 1, 0, 3, 3);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=208802);
INSERT INTO `gameobject_loot_template` VALUES
(208802, 69860, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=206839);
INSERT INTO `gameobject_loot_template` VALUES
(206839, 63107, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=207382);
INSERT INTO `gameobject_loot_template` VALUES
(207382, 65507, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195686);
INSERT INTO `gameobject_loot_template` VALUES
(195686, 49162, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195448);
INSERT INTO `gameobject_loot_template` VALUES
(195448, 48128, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=202751);
INSERT INTO `gameobject_loot_template` VALUES
(202751, 52987, 100, 1, 0, 2, 9),
(202751, 52329, 39, 1, 0, 1, 3),
(202751, 63122, 10, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=207294);
INSERT INTO `gameobject_loot_template` VALUES
(207294, 64667, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195587);
INSERT INTO `gameobject_loot_template` VALUES
(195587, 49082, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=203373);
INSERT INTO `gameobject_loot_template` VALUES
(203373, 56185, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205534);
INSERT INTO `gameobject_loot_template` VALUES
(205534, 61306, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205195);
INSERT INTO `gameobject_loot_template` VALUES
(205195, 60791, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=113768); -- -100 ??
INSERT INTO `gameobject_loot_template` VALUES
(113768, 45072, 100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=181239);
INSERT INTO `gameobject_loot_template` VALUES
(181239, 22599, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=201706);
INSERT INTO `gameobject_loot_template` VALUES
(201706, 49754, -61, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=191533);
INSERT INTO `gameobject_loot_template` VALUES
(191533, 40603, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=206199);
INSERT INTO `gameobject_loot_template` VALUES
(206199, 62327, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=203182);
INSERT INTO `gameobject_loot_template` VALUES
(203182, 55233, -100, 1, 0, 1, 3);
 
DELETE FROM `skinning_loot_template` WHERE (`entry`=12899);
INSERT INTO `skinning_loot_template` VALUES
(12899, 4304, 30, 1, 0, 1, 1),
(12899, 8165, 10, 1, 0, 1, 1),
(12899, 8170, 50, 1, 0, 1, 2),
(12899, 15414, 35, 1, 0, 1, 2);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205538);
INSERT INTO `gameobject_loot_template` VALUES
(205538, 61319, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=206387);
INSERT INTO `gameobject_loot_template` VALUES
(206387, 62508, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=206203);
INSERT INTO `gameobject_loot_template` VALUES
(206203, 62317, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=202739);
INSERT INTO `gameobject_loot_template` VALUES
(202739, 53038, 100, 1, 0, 5, 10),
(202739, 52327, 19, 1, 0, 3, 4),
(202739, 52328, 4, 1, 0, 1, 2),
(202739, 52179, 0.9, 1, 0, 1, 1),
(202739, 52181, 0.9, 1, 0, 1, 1),
(202739, 52177, 0.8, 1, 0, 1, 1),
(202739, 52182, 0.8, 1, 0, 1, 1),
(202739, 52180, 0.8, 1, 0, 1, 1),
(202739, 52178, 0.7, 1, 0, 1, 1),
(202739, 52192, 0.18, 1, 0, 1, 1),
(202739, 52193, 0.17, 1, 0, 1, 1),
(202739, 52194, 0.16, 1, 0, 1, 1),
(202739, 52195, 0.15, 1, 0, 1, 1),
(202739, 52190, 0.15, 1, 0, 1, 1),
(202739, 52191, 0.15, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=204378);
INSERT INTO `gameobject_loot_template` VALUES
(204378, 58944, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject` WHERE `id`=402330;
DELETE FROM `gameobject` WHERE `id`=402328;
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=208576);
INSERT INTO `gameobject_loot_template` VALUES
(208576, 69807, -100, 1, 0, 1, 3);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=190542);
INSERT INTO `gameobject_loot_template` VALUES
(190542, 38563, -100, 1, 0, 1, 3);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=190543);
INSERT INTO `gameobject_loot_template` VALUES
(190543, 38563, -100, 1, 0, 1, 3);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=190584);
INSERT INTO `gameobject_loot_template` VALUES
(190584, 38607, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=203751);
INSERT INTO `gameobject_loot_template` VALUES
(203751, 57137, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205060);
INSERT INTO `gameobject_loot_template` VALUES
(205060, 60679, -96, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205884);
INSERT INTO `gameobject_loot_template` VALUES
(205884, 61975, -25, 1, 0, 1, 1),
(205884, 61044, -25, 1, 0, 1, 1),
(205884, 61976, -25, 1, 0, 1, 1),
(205884, 61977, -25, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=206586);
INSERT INTO `gameobject_loot_template` VALUES
(206586, 62818, -100, 1, 0, 1, 2);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205208);
INSERT INTO `gameobject_loot_template` VALUES
(205208, 58944, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=201979);
INSERT INTO `gameobject_loot_template` VALUES
(201979, 50237, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=203179);
INSERT INTO `gameobject_loot_template` VALUES
(203179, 55231, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=204346);
INSERT INTO `gameobject_loot_template` VALUES
(204346, 58888, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=196834);
INSERT INTO `gameobject_loot_template` VALUES
(196834, 49365, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195584);
INSERT INTO `gameobject_loot_template` VALUES
(195584, 49012, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195206);
INSERT INTO `gameobject_loot_template` VALUES
(195206, 46833, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=194204);
INSERT INTO `gameobject_loot_template` VALUES
(194204, 44968, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=203967);
INSERT INTO `gameobject_loot_template` VALUES
(203967, 57764, -100, 1, 0, 1, 1),
(203967, 2886, 0.18, 1, 0, 1, 1),
(203967, 117, 0.18, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=204253);
INSERT INTO `gameobject_loot_template` VALUES
(204253, 58500, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205097);
INSERT INTO `gameobject_loot_template` VALUES
(205097, 60739, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=204296);
INSERT INTO `gameobject_loot_template` VALUES
(204296, 58845, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=204376);
INSERT INTO `gameobject_loot_template` VALUES
(204376, 58944, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=196835);
INSERT INTO `gameobject_loot_template` VALUES
(196835, 49367, -99, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=205195);
INSERT INTO `gameobject_loot_template` VALUES
(205195, 60791, -100, 1, 0, 1, 1);
 
DELETE FROM `gameobject_loot_template` WHERE (`entry`=203224);
INSERT INTO `gameobject_loot_template` VALUES
(203224, 55989, -100, 1, 0, 1, 1);
 
UPDATE `quest_template` SET `Flags` = 2768 WHERE `Id` = 27612; -- quest is not weekly
 
UPDATE `quest_template` SET `Flags` = 0 WHERE `Id` = 28838; -- quest is not weekly
 
UPDATE `quest_template` SET `RequiredSourceItemCount2` = 0 WHERE `Id` = 13897; -- count without item
 
UPDATE `quest_template` SET `RequiredSourceItemCount2` = 0 WHERE `Id` = 13946; -- count without item
 
UPDATE `quest_template` SET `RequiredItemId1` = 31463, `RequiredItemId2` = 0, `RequiredItemCount1` = 1 WHERE `Id` = 10813; -- id on wrong place and without count
 
UPDATE `quest_template` SET `MinLevel` = 2, `RequiredSkillId` = 0 WHERE `Id` = 3120; -- skill not exist
 
UPDATE `quest_template` SET `RequiredSourceItemCount2` = 0 WHERE `Id` = 13892; -- count without item
 
UPDATE `quest_template` SET `RequiredSourceItemCount2` = 0 WHERE `Id` = 13948; -- count without item
 
UPDATE `quest_template` SET `RequiredSourceItemCount3` = 0 WHERE `Id` = 13565; -- count without item
 
UPDATE `quest_template` SET `RequiredSourceItemCount2` = 0 WHERE `Id` = 13642; -- count without item
 
UPDATE `quest_template` SET `SourceItemCount` = 1 WHERE `Id` = 10368; -- source item without count
 
UPDATE `quest_template` SET `RequiredSourceItemCount4` = 0 WHERE `Id` = 24813; -- count without item
 
UPDATE `quest_template` SET `Flags` = 0 WHERE `Id` = 28638; -- quest is not weekly
 
UPDATE `quest_template` SET `RequiredSourceItemCount2` = 0 WHERE `Id` = 13580; -- count without item
 
DELETE FROM `creature_equip_template` WHERE (`entry`=35566);
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (35566, 1, 0, 1899, 3042); -- value from mangos
 
DELETE FROM `creature_equip_template` WHERE (`entry`=35618);
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (35618, 1, 0, 1899, 53243); -- value from mangos
 
DELETE FROM `creature_equip_template` WHERE (`entry`=99998);
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (99998, 1, 59474, 0, 0); -- value unknown
 
DELETE FROM `creature_equip_template` WHERE (`entry`=99997);
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (99997, 1, 59330, 0, 0); -- value unknown
 
DELETE FROM `creature_equip_template` WHERE (`entry`=30012);
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (30012, 1, 40542, 39288, 0); -- value from trinity
 
DELETE FROM `creature_equip_template` WHERE (`entry`=30924);
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES (30924, 1, 43296, 43295, 0); -- value from mangos
 
UPDATE `creature_template` SET `npcflag` = 1048576 WHERE `entry` = 35027; -- battlemaster
 
UPDATE `creature_template` SET `npcflag` = 1048577 WHERE `entry` = 35007; -- battlemaster
 
UPDATE `creature_template` SET `npcflag` = 1048577 WHERE `entry` = 34991; -- battlemaster
 
UPDATE `creature_template` SET `npcflag` = 1048577 WHERE `entry` = 50668; -- battlemaster
 
UPDATE `creature_template` SET `npcflag` = 65665 WHERE `entry` = 48886; -- innkeeper
 
UPDATE `creature_template` SET `Health_mod` = 0.7 WHERE `entry` = 48518; -- old value 32248,0000 :-)
 
-- i remark this : there is in fact only delete's one entry.. but wowhead says there are only 2 guards in stormwind and 2 in Tol Barad so here is to look more 
-- DELETE FROM `creature` WHERE `id`=47325; 
-- INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
-- (49527, 47325, 0, 1, 1, 35540, 0, -8206.11, 453.738, 117.414, 5.21853, 500, 0, 0, 77490, 0, 0, 0, 0, 0),
-- (257837, 47325, 732, 1, 1, 0, 0, -303.601, 1059.43, 22.5556, 1.13954, 500, 0, 0, 1, 0, 0, 0, 0, 0),
-- (257838, 47325, 732, 1, 1, 0, 0, -319.658, 1070.76, 22.1777, 1.12776, 500, 0, 0, 1, 0, 0, 0, 0, 0),
-- (257957, 47325, 732, 1, 1, 0, 0, -336.354, 1081.29, 21.9467, 1.46941, 500, 0, 0, 1, 0, 0, 0, 0, 0),
-- (258129, 47325, 732, 1, 1, 0, 0, -340.923, 1035.77, 22.0587, 2.39227, 500, 0, 0, 1, 0, 0, 0, 0, 0),
-- (258131, 47325, 732, 1, 1, 0, 0, -329.961, 1034.91, 22.0497, 2.38364, 500, 0, 0, 1, 0, 0, 0, 0, 0),
-- (258142, 47325, 732, 1, 1, 0, 0, -384.194, 1064.77, 22.2213, 5.26996, 500, 0, 0, 1, 0, 0, 0, 0, 0);
 
UPDATE `creature_template` SET `name` = 'Ancient Water Lord', `subname` = '', `rank` = 1, `mingold` = 134920, `maxgold` = 156761, `Health_mod` = 9 WHERE `entry` = 57160;
 
UPDATE `creature_template` SET `mingold` = 123949, `maxgold` = 140758 WHERE `entry` = 57159;
 
UPDATE `creature_template` SET `mingold` = 75920, `maxgold` = 95840 WHERE `entry` = 57280;
 
UPDATE `creature_template` SET `mingold` = 5845029, `maxgold` = 7443975 WHERE `entry` = @Morchok;
 
UPDATE `creature_template` SET `mingold` = 3290000, `maxgold` = 7099032 WHERE `entry` = 55308;
 
UPDATE `creature_template` SET `minlevel` = 28, `maxlevel` = 28 WHERE `entry` = 2776;
 
UPDATE `creature_template` SET `minlevel` = 27, `maxlevel` = 27 WHERE `entry` = 2595;
 
UPDATE `creature_template` SET `faction` = 15 WHERE `entry` = 42405;
 
UPDATE `creature_template` SET `mingold` = 4932010, `maxgold` = 7306597 WHERE `entry` = 55312;
 
UPDATE `creature_template` SET `mingold` = 4932100, `maxgold` = 6631018 WHERE `entry` = 55689;
 
DELETE FROM `pickpocketing_loot_template` WHERE (`entry`=55689);
INSERT INTO `pickpocketing_loot_template` VALUES
(55689, 74246, 75, 1, 0, 1, 1);
 
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85 WHERE `entry` = 57259;
 
UPDATE `creature_template` SET `mingold` = 4382019, `maxgold` = 6901324 WHERE `entry` = 56427;
 
UPDATE `creature_template` SET `mingold` = 9528, `maxgold` = 19897 WHERE `entry` = 54590;
 
UPDATE `creature_template` SET `mingold` = 9529, `maxgold` = 19902 WHERE `entry` = 54968;
 
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `faction` = 14 WHERE `entry` = 54646; -- trinity has 2257
 
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `faction` = 14 WHERE `entry` = 54696;
 
UPDATE `creature_template` SET `lootid` = 54938 WHERE `entry` = 54938;
UPDATE `creature_template` SET `mingold` = 42940, `maxgold` = 87673 WHERE `entry` = 54938;
DELETE FROM `creature_loot_template` WHERE (`entry`=54938);
INSERT INTO `creature_loot_template` VALUES
(54938, 72870, 17, 1, 0, 1, 1),
(54938, 72867, 15, 1, 0, 1, 1),
(54938, 72868, 13, 1, 0, 1, 1),
(54938, 72869, 10, 1, 0, 1, 1),
(54938, 72862, 29, 1, 0, 1, 1),
(54938, 72865, 15, 1, 0, 1, 1),
(54938, 72864, 11, 1, 0, 1, 1),
(54938, 72861, 11, 1, 0, 1, 1),
(54938, 72901, 26, 1, 0, 1, 1),
(54938, 72863, 18, 1, 0, 1, 1),
(54938, 72866, 19, 1, 0, 1, 1),
(54938, 72900, 14, 1, 0, 1, 1),
(54938, 52078, 67, 2, 0, 1, 1),
(54938, 71637, 12, 2, 0, 1, 1),
(54938, 71715, 1.8, 2, 0, 1, 1);
 
UPDATE `creature_template` SET `speed_walk` = 8, `speed_run` = 12, `scale` = 0.3 WHERE `entry` = 28511;
 
UPDATE `creature_template` SET `lootid` = 55085, `mingold` = 5839, `maxgold` = 19939 WHERE `entry` = 55085;
DELETE FROM `creature_loot_template` WHERE (`entry`=55085);
INSERT INTO `creature_loot_template` VALUES
(55085, 72831, 13, 1, 0, 1, 1),
(55085, 72832, 12, 1, 0, 1, 1),
(55085, 72830, 12, 1, 0, 1, 1),
(55085, 72828, 11, 1, 0, 1, 1),
(55085, 72827, 10, 1, 0, 1, 1),
(55085, 72829, 10, 1, 0, 1, 1);
 
DELETE FROM `gameobject` WHERE `id`=207692;
 
DELETE FROM `gameobject` WHERE `id`=208227;
 
UPDATE `creature_template` SET `npcflag` = 65665 WHERE `entry` = 49406; -- innkeeper
 
UPDATE `creature_template` SET `dynamicflags` = 0 WHERE `entry` = 47719; -- not dead
 
UPDATE `creature_template` SET `dynamicflags` = 0 WHERE `entry` = 47721; -- not dead
 
DELETE FROM `creature_loot_template` WHERE (`entry`=44035);
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 44035;
 
UPDATE `creature_template` SET `mingold` = 1340, `maxgold` = 2525 WHERE `entry` = 45190;
 
UPDATE `creature_template` SET `mingold` = 1420, `maxgold` = 2643 WHERE `entry` = 48627;
 
UPDATE `creature_template` SET `dmg_multiplier` = 1 WHERE `entry` = 51671;
 
UPDATE `gameobject_template` SET `data1` = 2843 WHERE `entry` = 2843;
DELETE FROM `gameobject_loot_template` WHERE (`entry`=2843);
INSERT INTO `gameobject_loot_template` VALUES
(2843, 61959, -20, 1, 0, 1, 1),
(2843, 61962, -20, 1, 0, 1, 1),
(2843, 61960, -20, 1, 0, 1, 1),
(2843, 61961, -20, 1, 0, 1, 1),
(2843, 1179, 5, 1, 0, 1, 5),
(2843, 118, 4, 1, 0, 1, 7),
(2843, 858, 3, 1, 0, 1, 7),
(2843, 2318, 3, 1, 0, 1, 8),
(2843, 2455, 3, 1, 0, 1, 8),
(2843, 414, 2, 1, 0, 1, 4),
(2843, 4541, 2, 1, 0, 1, 4),
(2843, 2287, 2, 1, 0, 1, 4),
(2843, 4605, 2, 1, 0, 1, 4),
(2843, 4537, 2, 1, 0, 1, 4),
(2843, 159, 1.5, 1, 0, 1, 5),
(2843, 2835, 1.5, 1, 0, 1, 7),
(2843, 2842, 1.4, 1, 1, 1, 4),
(2843, 2770, 1.3, 1, 1, 1, 6),
(2843, 2996, 1.2, 1, 1, 1, 6),
(2843, 2070, 0.8, 1, 1, 1, 4),
(2843, 2449, 0.8, 1, 1, 1, 5),
(2843, 2447, 0.8, 1, 1, 1, 6),
(2843, 4604, 0.7, 1, 1, 1, 4),
(2843, 4536, 0.7, 1, 1, 1, 4),
(2843, 765, 0.7, 1, 1, 1, 8),
(2843, 4540, 0.7, 1, 1, 1, 4),
(2843, 117, 0.7, 1, 1, 1, 4),
(2843, 2450, 0.5, 1, 1, 1, 4),
(2843, 785, 0.5, 1, 1, 1, 4),
(2843, 818, 0.4, 1, 1, 1, 1),
(2843, 783, 0.4, 1, 1, 1, 2),
(2843, 3577, 0.3, 1, 1, 1, 2),
(2843, 774, 0.3, 1, 1, 1, 1);
 
UPDATE `gameobject_template` SET `data1` = 74448 WHERE `entry` = 74448;
DELETE FROM `gameobject_loot_template` WHERE (`entry`=74448);
INSERT INTO `gameobject_loot_template` VALUES
(74448, 1708, 21, 1, 0, 1, 7),
(74448, 4607, 10, 1, 0, 1, 5),
(74448, 1205, 10, 1, 0, 1, 6),
(74448, 4544, 10, 1, 0, 1, 4),
(74448, 1707, 10, 1, 0, 1, 6),
(74448, 3771, 10, 1, 0, 1, 5),
(74448, 4539, 9, 1, 0, 1, 5),
(74448, 2319, 9, 1, 0, 1, 8),
(74448, 4234, 7, 1, 0, 1, 7),
(74448, 3385, 6, 1, 0, 1, 7),
(74448, 4306, 6, 1, 0, 1, 10),
(74448, 2592, 6, 1, 0, 1, 8),
(74448, 2997, 5, 1, 0, 1, 5),
(74448, 2836, 5, 1, 0, 2, 8),
(74448, 422, 5, 1, 0, 1, 5),
(74448, 929, 5, 1, 0, 1, 9),
(74448, 4542, 5, 1, 0, 1, 4),
(74448, 8766, 5, 1, 0, 1, 8),
(74448, 3770, 5, 1, 0, 1, 6),
(74448, 4538, 5, 1, 0, 1, 5),
(74448, 4606, 5, 1, 0, 1, 5),
(74448, 2771, 5, 1, 0, 2, 8),
(74448, 1710, 4, 1, 0, 1, 8),
(74448, 2838, 4, 1, 0, 1, 7),
(74448, 2772, 4, 1, 0, 1, 7),
(74448, 3827, 4, 1, 0, 1, 7),
(74448, 8932, 3, 1, 0, 1, 4),
(74448, 2453, 3, 1, 0, 1, 9),
(74448, 3356, 3, 1, 0, 1, 9),
(74448, 1725, 3, 1, 0, 1, 1),
(74448, 2318, 3, 1, 0, 2, 8),
(74448, 8952, 3, 1, 0, 1, 4),
(74448, 2452, 3, 1, 0, 1, 8),
(74448, 3355, 3, 1, 0, 1, 8),
(74448, 4305, 2, 1, 0, 1, 5),
(74448, 2450, 2, 1, 0, 2, 9),
(74448, 8953, 2, 1, 0, 1, 6),
(74448, 8948, 2, 1, 0, 1, 5),
(74448, 3818, 2, 1, 0, 1, 8),
(74448, 8950, 2, 1, 0, 1, 5),
(74448, 3357, 2, 1, 0, 1, 8);

UPDATE `gameobject_template` SET `data1` = 2850 WHERE `entry` = 2850;
DELETE FROM `gameobject_loot_template` WHERE (`entry`=2850);
INSERT INTO `gameobject_loot_template` VALUES
(2850, 1645, 9, 1, 0, 1, 4),
(2850, 1710, 7, 1, 0, 1, 6),
(2850, 3727, 7, 1, 0, 1, 6),
(2850, 6149, 6, 1, 0, 2, 6),
(2850, 1708, 6, 1, 0, 1, 4),
(2850, 4599, 5, 1, 0, 1, 3),
(2850, 3927, 5, 1, 0, 1, 4),
(2850, 1205, 5, 1, 0, 1, 4),
(2850, 4608, 5, 1, 0, 1, 4),
(2850, 6037, 4, 1, 0, 1, 2),
(2850, 3385, 4, 1, 0, 1, 4),
(2850, 4602, 4, 1, 0, 1, 3),
(2850, 4601, 4, 1, 0, 1, 4),
(2850, 3928, 4, 1, 0, 2, 5),
(2850, 4607, 3, 1, 0, 1, 2),
(2850,  422, 3, 1, 0, 1, 2),
(2850, 4234, 3, 1, 0, 1, 5),
(2850, 2838, 3, 1, 0, 2, 4),
(2850, 4542, 3, 1, 0, 1, 2),
(2850, 4544, 3, 1, 0, 1, 3),
(2850, 4306, 3, 1, 0, 1, 4),
(2850, 1707, 3, 1, 0, 1, 3),
(2850, 3771, 3, 1, 0, 1, 2),
(2850, 4305, 2, 1, 0, 1, 1),
(2850, 4539, 2, 1, 0, 1, 2),
(2850, 2772, 2, 1, 0, 1, 4),
(2850, 2319, 2, 1, 0, 1, 5),
(2850, 3770, 2, 1, 0, 1, 3),
(2850, 4606, 2, 1, 0, 1, 4);
  
DELETE FROM `item_loot_template` WHERE (`entry`=12339);
INSERT INTO `item_loot_template` VALUES
(12339, 12300, -99, 1, 0, 1, 1),
(12339, 12323, -100, 1, 0, 1, 1);
 
DELETE FROM `item_loot_template` WHERE (`entry`=21363);
INSERT INTO `item_loot_template` VALUES
(21363, 21328, -100, 1, 0, 1, 1);
 
DELETE FROM `item_loot_template` WHERE (`entry`=43347);
INSERT INTO `item_loot_template` VALUES
(43347, 43345, 0.01, 1, 0, 1, 1);
 
DELETE FROM `item_loot_template` WHERE (`entry`=24336);
INSERT INTO `item_loot_template` VALUES
(24336, 23682, -100, 1, 0, 1, 1),
(24336, 24335, 100, 1, 0, 1, 1);
 
DELETE FROM `item_loot_template` WHERE (`entry`=16883);
INSERT INTO `item_loot_template` VALUES 
(16883, 1710, 11, 1, 0, 1, 1),
(16883, 24231, 10, 1, 0, 2, 3),
(16883, 3864, 1.2, 1, 0, 1, 1),
(16883, 1529, 1.2, 1, 0, 1, 1),
(16883, 24232, 1, 1, 0, 2, 2),
(16883, 24281, 0.7, 1, 0, 1, 1),
(16883, 24282, 0.6, 1, 0, 1, 1),
(16883, 27729, 0.5, 1, 0, 1, 1),
(16883, 5756, 0.01, 1, 0, 1, 1),
(16883, 776, 0.01, 1, 0, 1, 1);
 
DELETE FROM `item_loot_template` WHERE (`entry`=7870);
INSERT INTO `item_loot_template` VALUES 
(7870, 7866, -80, 1, 0, 1, 1);
 
