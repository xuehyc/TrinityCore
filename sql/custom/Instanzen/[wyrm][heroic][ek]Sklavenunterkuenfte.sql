insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) 
values
('100214','22421','547','2','0','0','-301.059','-465.959','3.03571','0.914176','25','0','0','14258','0','0','0');

-- id
update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(19893,19895,19894);

-- Quagmirran
delete from creature_loot_template where entry = 19894;
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values
('19894','3','100','1','-547001','1','0','0','0'),
('19894','4','100','1','-547001','1','0','0','0'),
('19894','29349','0','1','1','1','0','0','0'),
('19894','29242','0','1','1','1','0','0','0'),
('19894','30538','0','1','1','1','0','0','0'),
('19894','32078','0','1','1','1','0','0','0'),
('19894','33821','-100','0','1','1','0','0','0'), -- quest
('19894','23572','100','0','1','1','0','0','0'), -- Urnether
('19894','29434','100','0','1','1','0','0','0'), -- Heroic marke
('19894','1','60','1','-547000','1','0','0','0'), -- Gems
('19894','2','2','1','-43000','1','0','0','0'); -- Karten

-- mennu
delete from creature_loot_template where entry = 19893;
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('19893','27541','0','1','1','1','0','0','0'),
('19893','27542','0','1','1','1','0','0','0'),
('19893','27543','0','1','1','1','0','0','0'),
('19893','27544','0','1','1','1','0','0','0'),
('19893','27545','0','1','1','1','0','0','0'),
('19893','27546','0','1','1','1','0','0','0'),
('19893','29434','100','0','1','1','0','0','0'),
('19893','1','25','1','-547000','1','0','0','0');

-- Rokmar

delete from creature_loot_template where entry = 19895;
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values
('19895','27547','0','1','1','1','0','0','0'),
('19895','27548','0','1','1','1','0','0','0'),
('19895','27549','0','1','1','1','0','0','0'),
('19895','27550','0','1','1','1','0','0','0'),
('19895','27551','0','1','1','1','0','0','0'),
('19895','28124','0','1','1','1','0','0','0'),
('19895','29434','100','0','1','1','0','0','0'),
('19895','1','25','1','-547000','1','0','0','0');


-- gems

delete from reference_loot_template where entry = 547000;
insert into `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('547000','30603','0','1','1','1','0','0','0'),
('547000','30604','0','1','1','1','0','0','0'),
('547000','30605','0','1','1','1','0','0','0');

delete from reference_loot_template where entry = 547001;
insert into `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('547001','27672','0','1','1','1','0','0','0'),
('547001','27673','0','1','1','1','0','0','0'),
('547001','27683','0','1','1','1','0','0','0'),
('547001','27712','0','1','1','1','0','0','0'),
('547001','27713','0','1','1','1','0','0','0'),
('547001','27714','0','1','1','1','0','0','0'),
('547001','27740','0','1','1','1','0','0','0'),
('547001','27741','0','1','1','1','0','0','0'),
('547001','27742','0','1','1','1','0','0','0'),
('547001','27796','0','1','1','1','0','0','0'),
('547001','27800','0','1','1','1','0','0','0'),
('547001','28337','0','1','1','1','0','0','0');