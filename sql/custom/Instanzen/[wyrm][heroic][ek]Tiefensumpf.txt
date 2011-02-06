-- id
update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(20169,20168,20183,20184);

-- Hungarfen
delete from creature_loot_template where entry = 20169;
insert into `creature_loot_template` 
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('20169','27746','0','1','1','1','0','0','0'),
('20169','27744','0','1','1','1','0','0','0'),
('20169','27748','0','1','1','1','0','0','0'),
('20169','27747','0','1','1','1','0','0','0'),
('20169','27743','0','1','1','1','0','0','0'),
('20169','27745','0','1','1','1','0','0','0'),
('20169','24246','10','0','1','1','0','0','0'),
('20169','22575','10','0','1','3','0','0','0'), -- bluthibiskus
('20169','29434','100','0','1','1','0','0','0'), -- heroic badge
('20169','1','25','1','-546000','1','0','0','0'); -- Gem

-- Ghaz'an
delete from creature_loot_template where entry = 20168;
insert into `creature_loot_template` 
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('20168','27760','0','1','1','1','0','0','0'),
('20168','27757','0','1','1','1','0','0','0'),
('20168','27755','0','1','1','1','0','0','0'),
('20168','27759','0','1','1','1','0','0','0'),
('20168','27761','0','1','1','1','0','0','0'),
('20168','27758','0','1','1','1','0','0','0'),
('20168','24476','10','0','1','1','0','0','0'),
('20168','24246','25','0','1','1','0','0','0'), -- bluthibiskus
('20168','29434','100','0','1','1','0','0','0'), -- heroic badge
('20168','1','25','1','-546000','1','0','0','0'); -- Gem

-- Swamplord Musel'ek

delete from creature_loot_template where entry = 20183;
insert into `creature_loot_template` 
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('20183','27762','0','1','1','1','0','0','0'),
('20183','27767','0','1','1','1','0','0','0'),
('20183','27764','0','1','1','1','0','0','0'),
('20183','27766','0','1','1','1','0','0','0'),
('20183','27763','0','1','1','1','0','0','0'),
('20183','27765','0','1','1','1','0','0','0'),
('20183','21877','7','0','1','3','0','0','0'), -- netherstoff
('20183','29434','100','0','1','1','0','0','0'), -- heroic badge
('20183','1','25','1','-546000','1','0','0','0'); -- Gem

-- The Black Stalker

delete from creature_loot_template where entry = 20184;
insert into `creature_loot_template` 
(`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('20184','3','100','1','-546001','1','0','0','0'),
('20184','4','100','1','-546001','1','0','0','0'),
('20184','29265','0','1','1','1','0','0','0'),
('20184','30541','0','1','1','1','0','0','0'),
('20184','29350','0','1','1','1','0','0','0'),
('20184','32081','0','1','1','1','0','0','0'),
('20184','33826','-100','0','1','1','0','0','0'), -- quest
('20184','24248','-100','0','1','1','0','0','0'), -- quest
('20184','24246','25','0','1','1','0','0','0'), -- bluthibiskus
('20184','27676','15','0','1','1','0','0','0'), -- seltsame Sporen
('20184','23572','100','0','1','1','0','0','0'), -- Urnether
('20184','29434','100','0','1','1','0','0','0'), -- Heroic marke
('20184','2','2','1','-43000','1','0','0','0'), -- Karten
('20184','1','60','1','-546000','1','0','0','0'); -- Gem

-- gems

delete from reference_loot_template where entry = 546000;
insert into `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('546000','30608','0','1','1','1','0','0','0'),
('546000','30606','0','1','1','1','0','0','0'),
('546000','30607','0','1','1','1','0','0','0');

delete from reference_loot_template where entry = 546001;
insert into `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`)
values
('546001','27781','0','1','1','1','0','0','0'),
('546001','27773','0','1','1','1','0','0','0'),
('546001','27896','0','1','1','1','0','0','0'),

('546001','27772','0','1','1','1','0','0','0'),
('546001','27779','0','1','1','1','0','0','0'),
('546001','27780','0','1','1','1','0','0','0'),

('546001','27769','0','1','1','1','0','0','0'),
('546001','27771','0','1','1','1','0','0','0'),
('546001','27768','0','1','1','1','0','0','0'),
('546001','27770','0','1','1','1','0','0','0');