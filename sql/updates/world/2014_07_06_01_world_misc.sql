
update creature_template set AIName="", ScriptName="npc_rockjaw_invader" where entry=37070;
update creature_template set AIName="", ScriptName="npc_coldridge_defender" where entry=37177;
update creature_template set AIName="", ScriptName="npc_wounded_coldridge_mountaineer" where entry=37080;
update creature_template set AIName="", ScriptName="npc_soothsayer_shikala" where entry=37108;
update creature_template set AIName="", ScriptName="npc_soothsayer_rikkari" where entry=37173;
update creature_template set AIName="", ScriptName="npc_soothsayer_mirimkoa" where entry=37174;
update creature_template set AIName="", ScriptName="npc_hands_springsprocket" where entry=6782;
UPDATE creature_template SET AIName="",ScriptName="npc_rockjaw_scavenger" WHERE entry=37105;
UPDATE creature_template SET AIName="",ScriptName="npc_joren_ironstock" WHERE entry=37081;

update creature_loot_template set ChanceOrQuestChance=-50 where entry=37105 and item=49751;

UPDATE creature_template SET questItem1=49748 WHERE entry=704;
UPDATE creature_template SET questItem1=49747 WHERE entry=708;

update gameobject_template set data8=24492 where entry=201704;
update gameobject_template set data8=24492 where entry=201705;
update gameobject_template set data0=43, data6=-1, data8=24492, data14=0 where entry=201706;

delete from gameobject_loot_template where entry=201706;
insert into gameobject_loot_template values (201706,49754,100,1,0,1,1);

update creature_template set AIName="", ScriptName="npc_trainings_dummy" where entry=44389;

update creature_template set AIName="", ScriptName="npc_milos_gyro_spawned" where entry=37518;
UPDATE creature_template SET npcflag=33554432,InhabitType=7 WHERE entry=37198;
update creature_template set unit_flags=0 where entry=37070;
update creature_template set unit_flags=0 where entry=37177;

delete from creature_text where entry=37198 and groupid between 0 and 6;
insert into creature_text values (37198,0,0,"<static> Is this thing on? Hello?",12,0,100,0,0,0,"Text during flying",0);
insert into creature_text values (37198,1,0,"Ahh, there you are. Hello! I figured that, while you're flying to Kharanos, I'd give you some data about what's going on outside of Coldridge Valley.",12,0,100,0,0,0,"Text during flying",0);
insert into creature_text values (37198,2,0,"And if you'll look to your left, you'll see that the gnomes have retaken Gnomeregan. Hooray for us!",12,0,100,0,0,0,"Text during flying",0);
insert into creature_text values (37198,3,0,"If you thought you had problems with trolls in Coldridge, wait 'til you get to Kharanos! That big cataclysm got the trolls all stirred up out here.",12,0,100,0,0,0,"Text during flying",0);
insert into creature_text values (37198,4,0,"It seems you Coldridge folks are dreadfully under-informed about the events of the last few days.",12,0,100,0,0,0,"Text during flying",0);
insert into creature_text values (37198,5,0,"There's plenty else going on out here, too. We've opened up the path to the airport, there's rumors of Dark Irons in the east... oh, and I think something weird is going on with that dwarf king, Magni. Might want to check it out.",12,0,100,0,0,0,"Text during flying",0);
insert into creature_text values (37198,6,0,"And here we are! Welcome to Kharanos! Watch your step on the way out.",12,0,100,0,0,0,"Text during flying",0);

delete from creature_text where entry=37081 and groupid = 0;
insert into creature_text values (37081,0,0,"Eat dwarven lead!",12,0,100,0,0,0,"",0);
insert into creature_text values (37081,0,1,"For Ironforge!",12,0,100,0,0,0,"",0);
insert into creature_text values (37081,0,2,"Get back, ye filthy beast!",12,0,100,0,0,0,"",0);


