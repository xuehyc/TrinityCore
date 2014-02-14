
-- innkeeper keldamyr is not the queststarter
delete from creature_queststarter where id=6736 and quest=2159;

-- Corithras Moonrage  is the queststarter not the questender
delete from creature_questender where id=3515 and quest=933;

--  Corithras Moonrage  is not the queststarter and Arch Druid Fandral Stagelm not the questender
delete from creature_queststarter where id=3515 and quest=935;
delete from creature_questender where id=3516 and quest=935;

-- fix the quest chain
UPDATE quest_template SET PrevQuestId=28731,NextQuestId=7383,Flags=0 WHERE Id=929;
UPDATE quest_template SET PrevQuestId=929 WHERE Id=7383;
UPDATE quest_template SET PrevQuestId=28731 WHERE Id=6344;
UPDATE quest_template SET PrevQuestId=28731 WHERE Id=997;
UPDATE quest_template SET RequiredSkillPoints=1,PrevQuestId=28731 WHERE Id=1581;
UPDATE quest_template SET PrevQuestId=28731 WHERE Id=475;
UPDATE quest_template SET PrevQuestId=28731 WHERE Id=2438;
UPDATE quest_template SET PrevQuestId=2459 WHERE Id=932;
UPDATE quest_template SET PrevQuestId=28731 WHERE Id=13945;

-- nyoma is starter and fidelio is ender
delete from creature_queststarter where id=4241 and quest=6344;
delete from creature_queststarter where id=40553 and quest=6344;
delete from creature_questender where id=10118 and quest=6344;

-- quest 8715 autocomplete
UPDATE quest_template SET Method=2,Level=1 WHERE Id=8715;

-- quest 13946 wrong place for RequiredSourceItemId
UPDATE quest_template SET PrevQuestId=28731,RequiredSourceItemId1=46716,RequiredSourceItemId2=0,RequiredSourceItemCount1=1 WHERE Id=13946;

-- quest 1581 only for skill
UPDATE quest_template SET RequiredSkillPoints=1,PrevQuestId=28731 WHERE Id=1581;

-- quest 6341 to many queststarter and questender
delete from creature_queststarter where id=10118 and quest=6341;
delete from creature_questender where id=3838 and quest=6341;

-- quest 6342 to many queststarter and questender
delete from creature_queststarter where id=3838 and quest=6342;
delete from creature_queststarter where id=40552 and quest=6342;
delete from creature_questender where id=4200 and quest=6342;

-- quest 6343 to many queststarter and questender
delete from creature_queststarter where id=4200 and quest=6343;
delete from creature_queststarter where id=4265 and quest=6343;
delete from creature_questender where id=10118 and quest=6343;

-- quest 2459 wrong place for RequiredSourceItemId
UPDATE quest_template SET RequiredSourceItemId1=8049,RequiredSourceItemId4=0,RequiredSourceItemCount1=1,RequiredItemId1=8050,RequiredItemId2=0,RequiredItemCount1=1,RequiredItemCount2=0 WHERE Id=2459;

-- quest 929 autocomplete
UPDATE quest_template SET Method=2 WHERE Id=929;

-- quest 2399 autocomplete
UPDATE quest_template SET Method=2 WHERE Id=2399;

-- npc 2022  to match of them
delete from creature where guid=142184;
delete from creature_addon where guid=142184;
update creature set position_x=9551.88, position_y=679.20,position_z=1267.645 where guid=142178;

-- go 4608
update gameobject_loot_template set ChanceOrQuestChance=-100 where entry=4608 and item=5169;
update gameobject_template set data8=919 where entry=4608;

-- quest 13946
-- http://www.wowhead.com/npc=34440/fel-rock-grellkin-kill-credit
-- http://www.wowhead.com/npc=2003 Shadow Sprite
update creature_template set KillCredit1=34440 where entry=2003;
update creature_template set AIName="",ScriptName="npc_shadow_sprite" where entry=2003;



