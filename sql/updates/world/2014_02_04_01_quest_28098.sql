
--
-- quest 28098 The Twilight Skymaster
--
update creature_template set AIName="",ScriptName="npc_paoka_swiftmountain" where entry=47471;
-- ToDo: npc Heartrazor 47508 you should mount the windrider
update creature_template set npcflag=1,AIName="",ScriptName="npc_heartrazor_2b" where entry=47508;
-- richtofens windrider is spawned from script
delete from creature where guid=117686 and id=47509;
update creature_template set minlevel=44,maxlevel=44,faction_A=7,faction_H=7,InhabitType=7,AIName="",ScriptName="npc_richtofens_wind_rider" where entry=47509;

-- script for richtofen
update creature_template set AIName="",ScriptName="npc_twilight_skymaster_richtofen" where entry=47510;
-- richtofens yells (wowhead)
delete from creature_text where entry=47510 and groupid=0; -- and id between 0 and 1;
delete from creature_text where entry=47510 and groupid=1; -- and id between 0 and 2;
delete from creature_text where entry=47510 and groupid=2; -- and id=0;
insert into creature_text values (47510,0,0,"Aaaaaiiiiiiiiiiiiii......!",14,0,100,0,0,0,"");
insert into creature_text values (47510,0,1,"It will be a pleasure shooting you down!",14,0,100,0,0,0,"");
insert into creature_text values (47510,1,0,"No! Get away! Get off of me!",14,0,100,0,0,0,"");
insert into creature_text values (47510,1,1,"NOOOOOO!",14,0,100,0,0,0,"");
insert into creature_text values (47510,1,2,"What's this? Shoo!",14,0,100,0,0,0,"");
insert into creature_text values (47510,2,0,"Useless wind rider! I don't need you anyway!",14,0,100,0,0,0,"");



