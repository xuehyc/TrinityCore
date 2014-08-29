
-- http://www.wowhead.com/object=194202		Potion of Wildfire

update gameobject_template set questItem1=0,data8=0 where entry=194202;

update gameobject_loot_template set ChanceOrQuestChance=100 where entry=194202;
