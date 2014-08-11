
-- some critters missing random movement..
update creature set spawndist=10,MovementType=1 where id in (442,547,43083,43106,505,43533);
 
-- some npc missing random movement..
-- http://www.wowhead.com/npc=423
update creature set spawndist=10,MovementType=1 where id in (423,712);
 
-- http://www.wowhead.com/npc=423
update creature_template set KillCredit1=423 where entry in (424,426,712);
 
-- http://www.wowhead.com/quest=26503
delete from creature_queststarter where id=464 and quest=26503;
insert into creature_queststarter values (464,26503);
delete from creature_questender where id=464 and quest=26503;
insert into creature_questender values (464,26503);
UPDATE quest_template SET Method=2 WHERE Id=28563;
UPDATE quest_template SET ObjectiveText1="Gnoll Battle Plans",ObjectiveText2="Gnoll Orders",ObjectiveText3="Gnoll Strategy Guide" WHERE Id=26503;
update gameobject_template set data2=1,data8=26503 where entry=204345;
update gameobject_template set flags=4,data8=26503 where entry=204346;
update gameobject_template set data8=26503 where entry=204347;
delete from gameobject_loot_template where entry=204346 and item=58888;
insert into gameobject_loot_template values (204346,58888,-100,1,0,1,1);

-- http://www.wowhead.com/quest=26570
UPDATE quest_template SET QuestGiverTextWindow="Blackrock Orcs ",QuestGiverTargetName="Blackrock Orcs " WHERE Id=26570;



-- some german text
update locales_quest set QuestGiverTextWindow_loc3="Rotkammgnolle",QuestGiverTargetName_loc3="Rotkammgnolle" where Id=26504;
update locales_quest set EndText_loc3="Kehrt zu Magistrat Solomon in Seenhain im Rotkammgebirge zurück.",CompletedText_loc3=NULL where Id=169;
update locales_quest set QuestGiverTextWindow_loc3="Orc vom Schwarzfelsklan",QuestGiverTargetName_loc3="Orc vom Schwarzfelsklan" where Id=26504;








