
-- darkshire

-- npc 32937 is not present always.. is only spawnet from script
delete from creature where id=32937;

-- npc 32890 smartscript is wrong.. 
update creature_template set AIName="", ScriptName="" where entry=32890;
 
-- ToDo the core is wrong to.. now the credit is given by kill the 32890.. 
-- correct is: credit is given on a dead 32890 and then using spell 9613 
-- event for core script is not firing.. 

delete from creature where guid=79546;
insert into creature values(79546,32899,1,1,1,28367,2,6870.92,194.564,10.5461,5.35816,500,10,0,276,295,1,0,0,0);

-- wrong loot quest chance -1
update creature_loot_template set ChanceOrQuestChance=-100 where entry=32888 and item=44968;
update creature set spawndist=5 where id=32888;

-- 13565 autocomplete
UPDATE quest_template SET Method=2,RequiredSourceItemId1=45911,RequiredSourceItemId3=0,RequiredSourceItemCount1=1 WHERE Id=13565;

-- npc 34009 is not present always.. is only spawnet from script
delete from creature where id=34009;

-- npc 32890 smartscript is wrong.. 
delete from smart_scripts where entryorguid=34009;
update creature_template set minlevel=12,maxlevel=13,AIName="", ScriptName="npc_withered_ent" where entry=34009;

-- gameobject with missing loot
update gameobject_template set data0=57,data1=194208 where entry=194209;




