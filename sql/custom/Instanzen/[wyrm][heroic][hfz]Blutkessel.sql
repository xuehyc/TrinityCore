-- id
update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(18621,18601,18607);

update creature_template set mechanic_immune_mask = 113852251 where entry in (17377,18607);
update creature_template set mechanic_immune_mask = 113983323 where entry in (17381,18621,17380,18601);
update creature_template set flags_extra = 128, spell1 = 38462 where entry = 18602;
update gameobject set spawnMask = 3 where map = 542;
update gameobject_template set faction = 14 where entry = 181823;

update instance_template set Script = 'instance_blood_furnace' where map = 542;
update gameobject_template set faction = 14 where entry in (181766,181811,181812,181823);