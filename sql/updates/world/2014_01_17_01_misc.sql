
-- set some npc in zone to core script

set @ENTRY=37080;
update creature_template set KillCredit1=37079,KillCredit2=0, unit_flags=768, AIName="", ScriptName="npc_wounded_coldridge_mountaineer" where entry=@entry;

set @ENTRY=37070;
update creature_template set unit_flags=768, AIName="",ScriptName="npc_rockjaw_invader" where entry=@entry;

set @ENTRY=37177;
update creature_template set unit_flags=768, AIName="",ScriptName="npc_coldridge_defender" where entry=@entry;

set @ENTRY=69855;
delete from spell_script_names where spell_id=@ENTRY;
insert into spell_script_names values (@ENTRY,"npc_wounded_coldridge_mountaineer");

set @ENTRY=37108;
update creature_template set unit_flags=768, AIName="",ScriptName="npc_soothsayer_shikala" where entry=@entry;

set @ENTRY=37173;
update creature_template set unit_flags=768, AIName="",ScriptName="npc_soothsayer_rikkari" where entry=@entry;

set @ENTRY=37174;
update creature_template set unit_flags=768, AIName="",ScriptName="npc_soothsayer_mirimkoa" where entry=@entry;

-- http://www.wowhead.com/quest=218 http://www.wowhead.com/npc=37514  loot missing, same as 37507
set @entry=37514;
delete from creature_loot_template where entry=@entry;

insert into creature_loot_template values (@entry,117,48.9,1,0,1,1);
insert into creature_loot_template values (@entry,159,22.2,1,0,1,1);
insert into creature_loot_template values (@entry,805,4.8,1,0,1,1);
insert into creature_loot_template values (@entry,828,7,1,0,1,1);
insert into creature_loot_template values (@entry,4496,7.2,1,0,1,1);
insert into creature_loot_template values (@entry,5571,4.5,1,0,1,1);
insert into creature_loot_template values (@entry,5572,5.6,1,0,1,1);

-- -- http://www.wowhead.com/quest=218  killcredit missing
update creature_template set KillCredit2=946 where entry=37507;

-- http://www.wowhead.com/npc=704  Ragged Timber Wolf
update creature_template set scale=1 where entry=704;

-- http://www.wowhead.com/npc=48935  Alpine Hare
update creature_template set scale=0.8 where entry=48935;

-- http://www.wowhead.com/object=201611  Keg of Gnomenbrau
update gameobject_template set size=2 where entry=201611;

-- http://www.wowhead.com/quest=3106 nextquest is missing
update quest_template set nextquestid=24531 where id=3106;
update quest_template set nextquestid=24475 where id=24474;

-- http://www.wowhead.com/quest=24489  Trolling for Information
UPDATE quest_template SET Flags=524288 WHERE Id=24489;









