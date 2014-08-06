

-- http://www.wowhead.com/item=41426  Magically Wrapped Gift 
-- has now lootmode 0 so it is disbled
update item_loot_template set lootmode=1 where entry=41426;

-- http://www.wowhead.com/npc=6780 Porthannius  double spawn on same place
 delete from creature where guid=15455055 and id=6780;  -- guid by ArkDB
 
-- http://www.wowhead.com/npc=57684  Image of Tyrygosa 
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87 WHERE `entry` = 57684;

