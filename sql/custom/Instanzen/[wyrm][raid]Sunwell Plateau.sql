-- TestBot Teleporter and costfree repair
/*
DELETE FROM `creature_template` WHERE entry = 90000;
INSERT INTO `creature_template`
(`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `IconName`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`)
 VALUES('90000','0','15200','0','15200','0','Sunwell Testomatic 1000','Land of Legends',NULL,'70','70','15000','15000','0','0','0','35','35','1','1.1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','9','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','0','1','0','16384','0','npc_wyrm_sunwell_repairbot');
*/

-- Better handled in Eredar Twins Script (with Dark Flame)
delete from spell_linked_spell where spell_effect in (45347,45348,-45348,-45347);

-- AI Scripts Trashmobs
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25367;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25363;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25371;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25370;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25369;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25867;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25368;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25507;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25372;

update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25484;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25506;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25483;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25373;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25486;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25837;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25485;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25508;

update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25593;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25599;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25595;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25592;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25948;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25597;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25591;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25509;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25851;
update creature_template set scriptname = 'mob_sunwell_plateau_tash' where entry = 25598;

-- Felmyst spawn


insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) 
values('580000','25038','580','1','1','0','0','1463.83','611.512','51.57','1.62316','604800','0','0','1000000','0','0','0');



-- Waffen von Lady Sacrolash
DELETE FROM creature_equip_template WHERE entry = 25165;
INSERT INTO creature_equip_template VALUES
(25165,31381,31381,0,33490690,33490690,0,781,781,0);
Update creature set equipment_id = 25165 where id = 25165;

/*
-- DELETE FROM creature_loot_template WHERE entry IN (24882,25840,25038,25166,24892,25165,25315);


insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34083','100','1','-34083','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34176','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34177','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34178','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34179','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34180','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34181','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24882','34664','15','0','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34082','100','1','-34082','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34164','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34165','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34166','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34167','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34168','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34169','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34170','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('24892','34664','15','0','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34084','100','1','-34084','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34182','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34184','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34185','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34186','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34188','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34352','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25038','34664','15','0','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34085','100','1','-34085','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34664','100','0','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34848','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34851','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34852','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34853','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34854','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34855','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34856','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34857','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25165','34858','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34085','100','1','-34085','4','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34664','100','0','4','4','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34848','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34851','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34852','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34853','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34854','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34855','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34856','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34857','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25166','34858','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','29434','100','0','3','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34096','100','1','-34096','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34247','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34329','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34331','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34334','3','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34336','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34337','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25315','34664','100','0','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25840','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25840','34095','100','1','-34095','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25840','34664','40','0','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25840','35282','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25840','35283','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('25840','35284','0','1','1','1','0','0','0');
*/