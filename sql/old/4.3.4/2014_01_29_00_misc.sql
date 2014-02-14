
-- Darkshore

-- quest 13542 autocomplete
UPDATE quest_template SET Method=2,Flags=8,SpecialFlags=0,RequiredSourceItemId2=0,RequiredSourceItemCount2=0 WHERE Id=13542;

-- npc 32985  model id is not present in 434
update creature set modelid=0 where id=32985;

-- quest 8721
UPDATE quest_template SET Level=1 WHERE Id=8721;

-- item 44868 for quest 13542
delete from item_script_names where Id=44868;
insert into item_script_names values (44868,"item_frenzied_cyclone_bracers");

-- npc 33091
delete from creature_text where entry=33091 and groupid=0 and id in (0,1,2);
insert into creature_text values (33091,0,0,"It's over Azshara! You and your naga will return to the bottom of the seas where you belong!",14,0,100,0,0,0,"");
insert into creature_text values (33091,0,1,"It will be up to you to use the Horn of the Ancients and stop Soggoth's return.",12,0,100,0,0,0,"");
insert into creature_text values (33091,0,2,"She's not lying. Nordrassil is in danger. I must make haste and prepare for Hyjal's defense.",12,0,100,0,0,0,"");

-- wrong queststarter
delete from creature_queststarter where id=33091 and quest=13585;
delete from creature_queststarter where id=33091 and quest=13581;

-- quest autocomplete
UPDATE quest_template SET Method=2 WHERE Id=13588;

-- 13580 autocomplete
UPDATE quest_template SET Method=2,RequiredSourceItemId1=46546,RequiredSourceItemId2=0,RequiredSourceItemCount1=1 WHERE Id=13580;












