
-- missing loot for quest
delete from gameobject_loot_template where entry=190584 and item=38607;
insert into gameobject_loot_template values (190584,38607,-100,1,0,1,1);



