UPDATE `creature_template` SET `minlevel`=80  , `maxlevel`=80  , `faction_A`=14  , `faction_H`=14  , `Health_mod`=1  , `Mana_mod`=1 WHERE `entry` = 23545;
UPDATE `creature_template` SET `modelid2`=0 WHERE `entry` = 23775;
UPDATE `creature_template` SET `dmg_multiplier`=10  , `baseattacktime`=1500  , `mechanic_immune_mask`=646688727 WHERE `entry` = 23682;
UPDATE `creature_template` SET `RegenHealth`=0 WHERE `entry` = 23775;

/*
delete from creature_loot_template where entry = 23682;
insert into `creature_loot_template` 
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('23682','34073','0','1','1','1','0','0','0'),
('23682','34074','0','1','1','1','0','0','0'),
('23682','34075','0','1','1','1','0','0','0'),

('23682','1','100','2','-23682','3','0','0','0'),
('23682','37011','100','3','1','1','0','0','0'),

('23682','33292','7','5','1','1','0','0','0'),
('23682','33154','5','6','1','1','0','0','0'),
('23682','33808','4','7','1','1','0','0','0'),
('23682','38175','3','8','1','1','0','0','0');

delete from reference_loot_template where entry = 23682;
insert into reference_loot_template 
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('23682','33277','0','3','1','1','9','11242','0'),
('23682','34068','0','2','3','6','0','0','0');


delete from item_loot_template where entry = 20393;
insert into `item_loot_template` 
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('20393','20388','0','1','4','6','0','0','0'),
('20393','20389','0','1','4','6','0','0','0'),
('20393','20390','0','1','4','6','0','0','0'),
('20393','20397','0','3','1','1','0','0','0'),
('20393','20398','0','3','1','1','0','0','0'),
('20393','20399','0','3','1','1','0','0','0'),
('20393','20409','0','3','1','1','0','0','0'),
('20393','20410','0','3','1','1','0','0','0'),
('20393','20411','0','3','1','1','0','0','0'),
('20393','20413','0','3','1','1','0','0','0'),
('20393','20414','0','3','1','1','0','0','0'),
('20393','20561','0','2','1','1','0','0','0'),
('20393','20562','0','2','1','1','0','0','0'),
('20393','20563','0','2','1','1','0','0','0'),
('20393','20564','0','2','1','1','0','0','0'),
('20393','20565','0','2','1','1','0','0','0'),
('20393','20566','0','2','1','1','0','0','0'),
('20393','20567','0','2','1','1','0','0','0'),
('20393','20568','0','2','1','1','0','0','0'),
('20393','20569','0','2','1','1','0','0','0'),
('20393','20570','0','2','1','1','0','0','0'),
('20393','20571','0','2','1','1','0','0','0'),
('20393','20572','0','2','1','1','0','0','0'),
('20393','20573','0','2','1','1','0','0','0'),
('20393','20574','0','2','1','1','0','0','0'),
('20393','20391','0','2','1','1','0','0','0'),
('20393','20392','0','2','1','1','0','0','0'),
('20393','34068','100','0','4','8','0','0','0'),
('20393','33154','1','0','1','1','0','0','0'),
('20393','33292','5','0','1','1','0','0','0');


insert into creature_template 
	(entry, heroic_entry, modelid_A, modelid_A2, modelid_H, 
	modelid_H2, 
	name, 
	subname, 
	IconName, 
	minlevel, 
	maxlevel, 
	minhealth, 
	maxhealth, 
	minmana, 
	maxmana, 
	armor, 
	faction_A, 
	faction_H, 
	npcflag, 
	speed, 
	scale, 
	rank, 
	mindmg, 
	maxdmg, 
	dmgschool, 
	attackpower, 
	baseattacktime, 
	rangeattacktime, 
	unit_flags, 
	dynamicflags, 
	family, 
	trainer_type, 
	trainer_spell, 
	class, 
	race, 
	minrangedmg, 
	maxrangedmg, 
	rangedattackpower, 
	type, 
	type_flags, 
	lootid, 
	pickpocketloot, 
	skinloot, 
	resistance1, 
	resistance2, 
	resistance3, 
	resistance4, 
	resistance5, 
	resistance6, 
	spell1, 
	spell2, 
	spell3, 
	spell4, 
	PetSpellDataId, 
	mingold, 
	maxgold, 
	AIName, 
	MovementType, 
	InhabitType, 
	RacialLeader, 
	RegenHealth, 
	equipment_id, 
	mechanic_immune_mask, 
	flags_extra, 
	ScriptName
	)
	values
	(1000102, 0, 10700, 10700, 10700, 
	10700, 
	'LoL Halloween Geist', 
	'Land of Legends', 
	'', 
	70, 
	70, 
	1000, 
	1000, 
	0, 
	0, 
	0, 
	35, 
	35, 
	1, 
	1, 
	1, 
	1, 
	900000, 
	900000, 
	0, 
	1000, 
	1, 
	1, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	1000, 
	1000, 
	1000, 
	6, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	0, 
	'', 
	0, 
	1, 
	0, 
	1, 
	0, 
	1073741823, 
	0, 
	'npc_innkeeper'
	);


insert into game_event_creature values 
(2141403,12),
(2140738,12),
(2140701,12),
(2140694,12),
(2140562,12),
(2139173,12),
(2140325,12),
(2140106,12);



insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2141403','1000102','530','1','0','0','9689.79','-7364.86','11.9285','4.6144','25','0','0','1000','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2140738','1000102','530','1','0','0','-3792.91','-11690.6','-105.243','3.50837','25','0','0','1000','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2140701','1000102','1','1','0','0','9923.81','2504.77','1318.07','4.79558','25','0','0','1000','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2140694','1000102','0','1','0','0','-4919.71','-982.791','501.456','2.15072','25','0','0','1000','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2140562','1000102','1','1','0','0','-1261.37','63.5786','127.542','1.70337','25','0','0','1000','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2140325','1000102','0','1','0','0','1557.9','259.662','-43.1026','5.61341','25','0','0','1000','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2139173','1000102','1','1','0','0','1650.93','-4432.37','17.0622','1.75925','25','0','0','1000','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('2140106','1000102','0','1','0','0','-8826.47','636.969','94.2457','3.74905','25','0','0','1000','0','0','0');


-- Headless Horseman Quests
insert ignore into gameobject_involvedrelation values (186314, 11392);
insert ignore into creature_involvedrelation values (24519,11242),(23973,11403);
insert ignore into gameobject_questrelation values (186267,11392);
update quest_template set type = 81,SuggestedPlayers = 5  where entry = 11392;
update quest_template set NextQuestId = 11405 where entry in (11403,11242);
insert ignore into creature_questrelation values (23904,11403),(23904,11242);
UPDATE `creature_template` SET `npcflag` = 3 WHERE `entry` = 23904;
update quest_template set PrevQuestId = 11392, ExclusiveGroup = 11242 where entry in (11242,11403);
update quest_template set RequiredRaces = 1101 where entry = 11242;
update quest_template set RequiredRaces = 690 where entry = 11403;


-- Mounts Items
insert into `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `IconName`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`)
values('27153','0','25958','0','25958','0','Headless Horseman Mount, Player, Ground','','','1','1','1','1','0','0','0','35','35','0','1','1','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','6','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','0','1','0','0','0','');
insert into `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `IconName`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) 
values('27152','0','25159','0','25159','0','Headless Horseman Mount, Player, Flying','','','1','1','1','1','0','0','0','35','35','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','6','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','0','1','0','0','0','');
insert into `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) 
values('38175','2','7','-1','The Horseman\'s Blade','31419','4','0','1','0','119893','21','-1','-1','115','70','0','0','0','0','0','0','0','1','1','0','3','14','7','16','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','165','308','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','2700','0','0','15811','1','0','0','-1','0','-1','50070','0','0','0','600000','0','-1','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','1','Soldiers arise, stand and fight!','0','0','0','0','0','1','3','0','0','0','0','105','0','0','0','0','0','0','0','0','0','0','0','0','300','0','','0','0','0','0','0');
insert into `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) 
values('37012','15','5','-1','The Horseman\'s Reins','49561','4','64','1','1000000','0','0','-1','-1','60','30','762','75','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','48025','0','0','0','-1','330','3000','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','1','','0','0','0','0','0','-1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','-1','0','','0','0','0','0','0');
insert into `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) 
values('37011','15','5','-1','Magic Broom','47504','3','192','1','0','0','0','-1','-1','1','30','762','75','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','500','0','0','47977','0','0','0','-1','330','3000','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','0','0','0','0','-1','0','-1','3','','0','0','0','0','0','2','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','-1','0','','0','0','0','0','-1209600');
*/