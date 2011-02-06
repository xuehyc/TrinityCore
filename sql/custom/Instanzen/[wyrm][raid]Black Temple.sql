-- ++++ Prequest ++++
-- Title ID
update quest_template set CharTitleId = 64 where entry = 10985;
-- Einige Anpassungen
update creature_Template set scriptname = 'npc_xiri' where entry = 18528
UPDATE `creature_template` SET `modelid_A` = 21349  , `modelid_H` = 21349  , `minlevel` = 73  , `maxlevel` = 73  , `minhealth` = 500000  , `maxhealth` = 500000  , `mindmg` = 3000  , `maxdmg` = 4000  , `attackpower` = 16125  , `baseattacktime` = 2000  , `faction_A` = 1866  , `faction_H` = 1866 , `armor` = 6000 , `equipment_id` = 2182 , scriptname = 'npc_preeven_maiev' WHERE `entry` = 22989;
UPDATE `creature_template` SET `attackpower` = 6540  , `speed` = 1.1 , `type_flags` WHERE `entry` = 23191;
UPDATE `creature_template` SET `minlevel` = 72  , `maxlevel` = 72  , `minhealth` = 147600  , `maxhealth` = 147600  , `mindmg` = 3003  , `maxdmg` = 6139  , `attackpower` = 31997  , `baseattacktime` = 1400  , `rangeattacktime` = 1900  , `rangedattackpower` = 100  , `rank` = 3  , `faction_A` = 14  , `faction_H` = 14  , `type_flags` = 0  , `armor` = 7387  , `speed` = 1.48  , `mechanic_immune_mask` = 617299803 WHERE `entry` = 23152;

-- ***********
-- ++++ Trashmobs++++
-- ***********
update creature_template set scriptname = 'npc_black_temple' where entry = 22878;
UPDATE `creature_template` SET `mechanic_immune_mask` = 648249343 WHERE `entry` = 22878;
update creature_template set scriptname = 'npc_black_temple' where entry = 22883;
update creature_template set scriptname = 'npc_black_temple' where entry = 22873;
UPDATE `creature_template` SET `mechanic_immune_mask` = 111362047 WHERE `entry` = 22873;
update creature_template set scriptname = 'npc_black_temple' where entry = 22877;
update creature_template set scriptname = 'npc_black_temple' where entry = 22884;
update creature_template set scriptname = 'npc_black_temple' where entry = 22875;
UPDATE `creature_template` SET `mechanic_immune_mask` = 33561923 WHERE `entry` = 22875;
update creature_template set minlevel = 73  , maxlevel = 73  , faction_A = 1813  , faction_H = 1813  , unit_flags = 33554434, scriptname = 'mob_coilskar_geyser' where entry = 23080;
update creature_template set scriptname = 'npc_black_temple' where entry = 22876;
update creature_template set scriptname = 'npc_black_temple' where entry = 22885;
update creature_template set scriptname = 'npc_black_temple' where entry = 22874;
update creature_template set scriptname = 'npc_black_temple' where entry = 23028;
insert into spell_script_target values (40851,1,22963);
update creature_template set scriptname = 'npc_black_temple' where entry = 22963;
update creature_template set scriptname = 'npc_black_temple' where entry = 23030;
update creature_template set scriptname = 'npc_black_temple' where entry = 23330;
update creature_template set scriptname = 'npc_black_temple' where entry = 22960;
UPDATE `creature_template` SET `mechanic_immune_mask` = 614678523 WHERE `entry` = 22960;
update creature_template set scriptname = 'npc_black_temple' where entry = 22954;
update creature_template set scriptname = 'npc_black_temple' where entry = 22855;
update creature_template set scriptname = 'npc_black_temple' where entry = 22844;
update creature_template set scriptname = 'npc_black_temple' where entry = 22849;
update creature_template set scriptname = 'npc_black_temple' where entry = 22847;
update creature_template set scriptname = 'npc_black_temple' where entry = 22845;
update creature_template set scriptname = 'npc_black_temple' where entry = 22896;
update creature_template set scriptname = 'npc_black_temple' where entry = 22894;
update creature_template set scriptname = 'npc_black_temple' where entry = 23374;
update creature_template set scriptname = 'npc_black_temple' where entry = 22846;
update creature_template set scriptname = 'npc_black_temple' where entry = 22848;
update creature_template set scriptname = 'npc_black_temple' where entry = 23337;
update creature_template set scriptname = 'npc_black_temple' where entry = 22853;
UPDATE `creature_template` SET `mechanic_immune_mask` = 33554689 WHERE `entry` = 22853;
update creature_template set scriptname = 'npc_black_temple' where entry = 23339;
update creature_template set scriptname = 'npc_black_temple' where entry = 22869;
update creature_template set scriptname = "npc_black_temple" where entry = 22957;
update `creature_template` SET `minlevel` = 72  , `maxlevel` = 72  , `faction_A` = 1813  , `faction_H` = 1813 WHERE `entry` = 23436;
update creature_template set scriptname = "npc_black_temple" where entry = 22962;
update creature_template set scriptname = 'npc_black_temple' where entry = 22956;
update creature_template set scriptname = 'npc_black_temple' where entry = 22964;
update creature_template set scriptname = 'npc_black_temple' where entry = 22955;
update creature_template set scriptname = 'npc_black_temple' where entry = 22939;
update creature_template set scriptname = 'npc_black_temple' where entry = 22965;
update creature_template set scriptname = 'npc_black_temple' where entry = 22959;

update creature_template set scriptname = 'npc_black_temple' where entry = 23399;
update creature_template set scriptname = 'npc_black_temple' where entry = 23398;
update creature_template set scriptname = 'npc_black_temple' where entry = 23401;

update creature_template set scriptname = 'npc_black_temple' where entry = 23402;
update creature_template set scriptname = 'npc_black_temple' where entry = 23397;
update creature_template set scriptname = 'npc_black_temple' where entry = 23403;
update creature_template set scriptname = 'npc_black_temple' where entry = 23400;
update creature_template set scriptname = 'npc_black_temple' where entry = 23394;
update creature_template set scriptname = 'npc_black_temple' where entry = 23429;
update `creature_template` SET `minlevel` = 72  , `maxlevel` = 72  , `faction_A` = 16  , `faction_H` = 16, `unit_flags` = 33554818 WHERE `entry` = 23429;

update creature_template set scriptname = 'npc_black_temple' where entry = 23172;
update creature_template set scriptname = 'npc_black_temple' where entry = 22945;
update creature_template set scriptname = 'npc_black_temple' where entry = 23047;
update creature_template set scriptname = 'npc_black_temple' where entry = 22879;
update spell_proc_event set procFlags = 131072, procEx = 0 where entry = 41034;
update creature_template set scriptname = 'npc_black_temple' where entry = 22882;
update creature_template set scriptname = 'npc_black_temple' where entry = 22880;
update creature_template set scriptname = 'npc_black_temple' where entry = 23369;
update `creature_template` SET `minlevel` = 72  , `maxlevel` = 72  , `faction_A` = 1813  , `faction_H` = 1813 WHERE `entry` = 23436;
update creature_template set scriptname = 'npc_black_temple' where entry = 23018;
update creature_template set scriptname = 'npc_black_temple' where entry = 23083;
update creature_template set scriptname = 'npc_black_temple' where entry = 22953;
update creature_template set scriptname = 'npc_black_temple' where entry = 23049;
delete from creature_loot_template where item in (32609,32592,32591,32590,32589,32526) and entry = 23147;
update creature_template set scriptname = 'npc_black_temple' where entry = 23196;
delete from spell_scripts where id = 41213;
insert into spell_scripts (id,delay,command,datalong) values (41213,0,15,41214);
update creature_template set scriptname = 'npc_black_temple' where entry = 23236;
update creature_template set scriptname = 'npc_black_temple' where entry = 23235;
update creature_template set scriptname = 'npc_black_temple' where entry = 23237;
update creature_template set scriptname = 'npc_black_temple' where entry = 23232;
update creature_template set scriptname = 'npc_black_temple' where entry = 23222;
update creature_template set scriptname = 'npc_black_temple' where entry = 23239;
update creature_template set scriptname = 'npc_black_temple' where entry = 23223;
-- ***********
-- ++++ Naj'entus Damage ++++
-- update creature_template set mindmg = 4422, maxdmg = 9038, attackpower = 50110 where entry = 22887;
update creature_template set mindmg = 8780, maxdmg = 15580, attackpower = 36540 where entry = 22887;
-- ++++ Supremus Damage ++++
-- no crush
-- update creature_template set mindmg = 5923, maxdmg = 12105, attackpower = 63094 where entry = 22898;
update creature_template set mindmg = 10980, maxdmg = 21780, attackpower = 49140 where entry = 22898;
update creature_template set `flags_extra` = `flags_extra`|'32' where entry = 22898;
-- ++++ Shade of Akama ++++
-- update creature_template set mindmg = 2073, maxdmg = 4238, attackpower = 22087 where entry = 23216;
update creature_template set mindmg = 10073, maxdmg = 12238, attackpower = 42087 where entry = 23216;
-- update creature_template set mindmg = 1513, maxdmg = 3087, attackpower = 16096 where entry = 23523;
update creature_template set mindmg = 4513, maxdmg = 6087, attackpower = 26096 where entry = 23523;
-- update creature_template set mindmg = 1466, maxdmg = 2997, attackpower = 15619 where entry = 23318;
update creature_template set mindmg = 5466, maxdmg = 7997, attackpower = 30619 where entry = 23318;
-- update creature_template set mindmg = 1513, maxdmg = 3087, attackpower = 16096 where entry = 23524;
update creature_template set mindmg = 4513, maxdmg = 6087, attackpower = 26096 where entry = 23524;
-- ++++ Teron Damage ++++
-- update creature_template set mindmg = 7820, maxdmg = 15946, attackpower = 83177 where entry = 22871;
update creature_template set mindmg = 17000, maxdmg = 25000, attackpower = 63000 where entry = 22871;
UPDATE `creature_template` SET `baseattacktime` = 2000 WHERE `entry` = 22871;
-- UPDATE `creature_template` SET `minhealth` = 59000  , `maxhealth` = 59000  , `mindmg` = 0  , `maxdmg` = 0, `attackpower` = 0 WHERE `entry` = 23111;
UPDATE `creature_template` SET `minhealth` = 31000  , `maxhealth` = 31000  , `mindmg` = 160  , `maxdmg` = 260  , `attackpower` = 630 WHERE `entry` = 23111;
-- UPDATE `creature_template` SET `minhealth` = 5007750  , `maxhealth` = 5007750 WHERE `entry` = 22871;
UPDATE `creature_template` SET `minhealth` = 4507750  , `maxhealth` = 4507750 WHERE `entry` = 22871;
-- ++++ Gurtogg Damage ++++
-- update creature_template set mindmg = 4738, maxdmg = 9684, attackpower = 50477 where entry = 22948;
update creature_template set mindmg = 7304, maxdmg = 10120, attackpower = 26136 where entry = 22948;
-- ++++ Mother Shahraz Damage ++++
-- update creature_template set mindmg = 8797, maxdmg = 17938, attackpower = 93574 where entry = 22947;
update creature_template set mindmg = 13600, maxdmg = 25600, attackpower = 58800 where entry = 22947;
-- ++++ Souls Damage ++++
-- UPDATE `creature_template` SET `mindmg` = 4875 , `maxdmg` = 7375, `attackpower` = 42875, `baseattacktime`= 2000 WHERE `entry` = 23418;
UPDATE `creature_template` SET `mindmg` = 180, `maxdmg` = 780, `attackpower` = 5040, `baseattacktime`= 1000 WHERE `entry` = 23418;
-- UPDATE `creature_template` SET `mindmg` = 4875, `maxdmg` = 7375, `attackpower` = 42875 WHERE `entry` = 23419;
UPDATE `creature_template` SET `mindmg` = 10000, `maxdmg` = 18000, `attackpower` = 42000 WHERE `entry` = 23419;
-- UPDATE `creature_template` SET `mindmg` = 4875 , `maxdmg` = 7375 , `attackpower` = 42875 WHERE `entry` = 23420;
UPDATE `creature_template` SET `mindmg` = 12800  , `maxdmg` = 20800  , `attackpower` = 50400 WHERE `entry` = 23420;
-- ++++ Council Damage ++++
-- UPDATE `creature_template` SET `mindmg` = 7331  , `maxdmg` = 14949  , `attackpower` = 77976 WHERE `entry` = 22949;
UPDATE `creature_template` SET `mindmg` = 16020, `maxdmg` = 26820, `attackpower` = 64260 WHERE `entry` = 22949;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239 WHERE `entry` = 22949;
-- UPDATE `creature_template` SET `mindmg` = 1564 , `maxdmg` = 3189 , `attackpower` = 16634 WHERE `entry` = 22950;
UPDATE `creature_template` SET `mindmg` = 3564 , `maxdmg` = 5189 , `attackpower` = 17634 WHERE `entry` = 22950;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235 WHERE `entry` = 22950;
-- UPDATE `creature_template` SET `mindmg` = 2443  , `maxdmg` = 4983  , `attackpower` = 25991 WHERE `entry` = 22951;
UPDATE `creature_template` SET `mindmg` = 5680, `maxdmg` = 8880, `attackpower` = 21840 WHERE `entry` = 22951;
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854235 WHERE `entry` = 22951;
-- UPDATE `creature_template` SET `mindmg` = 4212 , `maxdmg` = 8608  , `attackpower` = 44866  , `baseattacktime` = 2000 WHERE `entry` = 22952;
UPDATE `creature_template` SET `mindmg` = 2700  , `maxdmg` = 12700  , `attackpower` = 46200  , `baseattacktime` = 1000 WHERE `entry` = 22952;
-- ++++ Illidan Damage ++++
-- update creature_template set mindmg = 7896, maxdmg = 16139, attackpower = 84124 where entry = 22917;
update creature_template set mindmg = 13180, maxdmg = 27980, attackpower = 61740 where entry = 22917;
update creature_template set `flags_extra` = `flags_extra`|'32' where entry = 22917;
-- update creature_template set mindmg = 3159, maxdmg = 6456, attackpower = 33651 where entry = 22997;
update creature_template set mindmg = 4800, maxdmg = 7800, attackpower = 18900 where entry = 22997;
update creature_template set `flags_extra` = `flags_extra`|'32' where entry = 22997;
-- ++++ Souls HP ++++
UPDATE `creature_template` SET `minhealth` = 3219151  , `maxhealth` = 3219151 WHERE `entry` = 23419;
UPDATE `creature_template` SET `minhealth` = 2414363  , `maxhealth` = 2414363 WHERE `entry` = 23418;
UPDATE `creature_template` SET `minhealth` = 3219151  , `maxhealth` = 3219151 WHERE `entry` = 23420;
-- **********************
-- ++++ Respawnzeit ++++
update creature,creature_template set creature.spawntimesecs = 604800 where creature.id = creature_template.entry and creature.map = 564 and creature_template.rank = 3;
update creature,creature_template set creature.spawntimesecs = 7200 where creature.id = creature_template.entry and creature.map = 564 and creature_template.rank = 1;

-- ++++ Linked Spawn ++++
-- Naj'Entus
delete from creature_linked_respawn where linkedGuid = 40527;
insert into creature_linked_respawn (guid,linkedGuid) (select guid,'40527'  from creature where id in (22878,22873,22874,22875,22876,22877,22885,22884));
-- Supremus
delete from creature_linked_respawn where linkedGuid = 52458;
insert into creature_linked_respawn (guid,linkedGuid) (select guid,'52458'  from creature where id in (23028,22963,23030,23330,22960,22954));
-- Shade of Akama
delete from creature_linked_respawn where linkedGuid = 12777;
insert into creature_linked_respawn (guid,linkedGuid) (select guid,'12777'  from creature where id in (22869,23337,22853,23339,22855,22848));
-- Gorefiend
delete from creature_linked_respawn where linkedGuid = 12843;
insert into creature_linked_respawn (guid,linkedGuid) (select guid,'12843'  from creature where id in (23172,22945,22880,22882,23147,23018,22879,23083,23047,23049,22953));
-- Bloodboil
delete from creature_linked_respawn where linkedGuid = 52761;
insert into creature_linked_respawn (guid,linkedGuid) (select guid,'52761'  from creature where id in (23196,23236,23235,23237,23232,23222,23239,23223));
-- Mother Shahraz
delete from creature_linked_respawn where linkedGuid = 52760;
insert into creature_linked_respawn (guid,linkedGuid) (select guid,'52760'  from creature where id in (22957,22962,22956,22964,22959,22939,22955,22965));
-- Illidary Council
delete from creature_linked_respawn where linkedGuid = 52479;
insert into creature_linked_respawn (guid,linkedGuid) (select guid,'52479'  from creature where id in (23400,23403,23402,23397,23394));

-- ****************************
-- remove Bossloot from BT
delete from creature_loot_template where entry in(22887,22898,22841,22871,22948,23420,22947,22917,22949,22950,22951,22952);

/*
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22841','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22841','34069','10','1','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22841','34072','100','1','-34072','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22841','190069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22871','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22871','34069','10','1','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22871','34073','100','1','-34073','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22871','190069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22887','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22887','34069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22887','34070','100','1','-34070','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22887','90069','10','1','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22898','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22898','34069','10','1','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22898','34071','100','1','-34071','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22898','190069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22917','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22917','32837','4','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22917','32838','4','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22917','34069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22917','34077','100','1','-34077','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22917','90069','10','1','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22917','90077','100','0','-34077','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','32365','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','32366','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','32367','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','32368','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','32369','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','32370','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','34069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','34076','100','1','-34076','3','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22947','90069','10','1','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22948','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22948','34069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22948','34074','100','1','-34074','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22948','90069','10','1','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22949','31098','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22949','31099','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22949','31100','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','31098','0','2','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','31099','0','2','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','31100','0','2','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','32331','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','32373','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','32376','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','32505','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','32518','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22950','32519','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22951','32227','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22951','32228','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22951','32229','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22951','32230','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22951','32231','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22951','32249','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22952','31098','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22952','31099','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('22952','31100','0','1','1','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('23420','29434','100','0','2','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('23420','34069','2','2','-34069','1','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('23420','34075','100','1','-34075','2','0','0','0');
insert into `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) values('23420','90069','10','1','-34069','1','0','0','0');
*/
