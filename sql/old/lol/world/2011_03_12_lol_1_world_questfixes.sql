-- stormforged Wargolem
DELETE FROM `creature_loot_template` WHERE (`entry`=29380);
INSERT INTO `creature_loot_template` VALUES
(29380, 22926, 0.0032, 0, -22926, 1, 0, 0, 0),
(29380, 33365, 10, 0, -33365, 1, 0, 0, 0),
(29380, 33422, 10, 0, -33422, 1, 0, 0, 0),
(29380, 36027, 0.29, 0, -36027, 1, 0, 0, 0),
(29380, 36035, 0.63, 0, -36035, 1, 0, 0, 0),
(29380, 36043, 0.66, 0, -36043, 1, 0, 0, 0),
(29380, 36051, 0.25, 0, -36051, 1, 0, 0, 0),
(29380, 37254, 0.0032, 0, -37254, 1, 0, 0, 0),
(29380, 37704, 0.0035, 0, 1, 1, 0, 0, 0),
(29380, 37760, 0.0211, 0, -37760, 1, 0, 0, 0),
(29380, 37761, 0.0349, 0, -37761, 1, 0, 0, 0),
(29380, 37769, 0.0096, 0, -37769, 1, 0, 0, 0),
(29380, 41777, 0.007, 0, -41777, 1, 0, 0, 0),
(29380, 42203, 13.64, 0, 1, 1, 0, 0, 0),
(29380, 42204, 34.548, 0, 1, 1, 0, 0, 0),
(29380, 42780, 33.1297, 0, 1, 1, 0, 0, 0),
(29380, 42930, 79.5346, 0, 1, 1, 0, 0, 0),
(29380, 42931, 19.1167, 0, 1, 1, 0, 0, 0),
(29380, 43624, 0.0032, 0, 1, 1, 0, 0, 0);

-- Teron Blutschatten
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
`KillCredit1`, `KillCredit2`, `modelid_1`, `modelid_2`, `modelid_3`, `modelid_4`, `name`, `subname`,
`IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`,
`armor`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`,
`maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`,
`unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`,
`minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
`skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`,
`spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`,
`InhabitType`, `unk16`, `unk17`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`,
`questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`,
`flags_extra`, `ScriptName`) VALUES (21867, 0, 0, 0, 0, 0, 21576, 0, 0, 0, 'Teron Blutschatten', '', '', 0,
72, 72, 17709, 17709, 19854, 19854, 7265, 14, 14, 0, 1, 1.14286, 1, 1, 407, 611, 0, 153, 2, 3000, 3000, 2,
16777216, 0, 0, 0, 0, 0, 0, 326, 489, 122, 6, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3,
3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 1, 321, 1, 0, '');

-- the heart of the storm
DELETE FROM `gameobject` WHERE `id`=192181;
INSERT INTO `gameobject`

(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(47643, 192181, 571, 1, 1, 7308.94, -727.916, 791.608, 1.53589, 0, 0, 0.690772, 0.723073, 30, 100, 1);