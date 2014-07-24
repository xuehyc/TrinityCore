
-- creater un'goto

-- fix loot for quest 24701
update gameobject_template set questItem1=50443,data1=202158,data8=24701 where entry=202158;
update gameobject_template set questItem1=50443,data1=202159,data8=24701 where entry=202159;
update gameobject_template set questItem1=50443,data1=202160,data8=24701 where entry=202160;

delete from gameobject_loot_template where entry in (202158,202159,202160) and item=50443;
insert into gameobject_loot_template values(202158,50443,-100,1,0,1,1);
insert into gameobject_loot_template values(202159,50443,-100,1,0,1,1);
insert into gameobject_loot_template values(202160,50443,-100,1,0,1,1);

