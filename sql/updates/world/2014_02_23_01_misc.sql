
-- crater un'goro

-- missing creature_questender
delete from creature_questender where id=9119 and quest=4141;
insert into creature_questender values (9119,4141);

-- autocomplete
UPDATE quest_template SET Flags=2097160 WHERE Id=24706;
UPDATE quest_template SET Flags=1048584 WHERE Id=24707;

-- object not set to quest
update gameobject_template set data8=24705 where entry=202065;

-- creature_text for entry 38240
delete from creature_text where entry=38240 and groupid = 0 and id=0;
insert into creature_text values (38240,0,0,"Squawky...",12,0,100,0,0,0,"");

-- creature_text for entry 38238
delete from creature_text where entry=38238 and groupid = 0  and id=0;
insert into creature_text values (38238,0,0,"What? Yes, that's my... crate. And I'm not a...",12,0,100,0,0,0,"");

-- wrong lootmode
update gameobject_loot_template set lootmode=1 where entry=202065;

-- quest 24705
update creature_template  set npcflag=1,AIName="",ScriptName="npc_damsel_by_the_shore" where entry=38238;
update creature_template  set npcflag=1,AIName="",ScriptName="npc_damsel_in_the_cliffs" where entry=38239;
update creature_template  set npcflag=1,AIName="",ScriptName="npc_damsel_by_the_north" where entry=38240;

-- wrong portrait
update quest_template set QuestGiverPortrait=8411 where Id=24704;

-- missing killcredit for quest 24704
update creature_template set KillCredit1=38252 where entry in (6498,6499,6500,6501,6502,6503,6504,6505,6506,6507,6508);
update creature_template set KillCredit1=38252 where entry in (6581,6584,9162,9163,9164,9165,9166,9167,9683,9684);

-- append pool
delete from pool_template where entry in (14649,14650);
insert into pool_template values (14649,1,"Group 31, Elder Diemetradon, crater un'goror");
insert into pool_template values (14650,1,"Group 32, Elder Diemetradon, crater un'goror");

delete from pool_pool where pool_id in (14649,14650);
insert into pool_pool values (14649,14518,0,"group31: Elder Diemetradon, crater un'goror");
insert into pool_pool values (14650,14518,0,"group32: Elder Diemetradon, crater un'goror");

delete from pool_creature where guid in (105991,74399,113884,74413);
insert into pool_creature values (105991,14649,0,"Elder Diemetradon group 31");
insert into pool_creature values (74399,14649,0,"Elder Diemetradon group 31");
insert into pool_creature values (113884,14650,0,"Elder Diemetradon group 32");
insert into pool_creature values (74413,14650,0,"Elder Diemetradon group 32");

-- wrong portrait
update quest_template set QuestGiverPortrait=25654 where Id=24706;



