
-- dk
-- first quest.. you can't take a sword..
update gameobject_template set flags=0 where entry=190584; -- enable it
delete from gameobject_loot_template where entry=190584 and item=38607; -- insert loot for the chest-sword
insert into gameobject_loot_template values (190584,38607,-100,1,0,1,1);

-- azuremyst isle
-- npc 17495.. wrong movement
update creature set spawndist=0,MovementType=0 where guid=162003;

-- npc 17199 there are 91 spawned, wowhead says its are 53.. so i delete some.. standing all as double :-)
delete from creature where id=17199 and guid in(177287,177297,177288,177328,177321,177330,177336,177334,177333,177264);
delete from creature where id=17199 and guid in(177338,177331,177305,177307,177337,177303,177301,177345,177350,177276);
delete from creature where id=17199 and guid in(177273,177341,177346,177269,177299,177347,177348,177271,177352,177281);
delete from creature where id=17199 and guid in(177279,177286,177335,177389,177323,177290,177295,177310,177292,177312);
delete from creature where id=17199 and guid in(177314,177296,177313,177282,177280);

delete from creature_addon where guid in(177287,177297,177288,177328,177321,177330,177336,177334,177333,177264);
delete from creature_addon where guid in(177338,177331,177305,177307,177337,177303,177301,177345,177350,177276);
delete from creature_addon where guid in(177273,177341,177346,177269,177299,177347,177348,177271,177352,177281);
delete from creature_addon where guid in(177279,177286,177335,177389,177323,177290,177295,177310,177292,177312);
delete from creature_addon where guid in(177314,177296,177313,177282,177280);

-- quest 9544 is autocomplete and disabled
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=9544;

-- npc 17184 double spawns..
delete from creature where id=17184 and guid in(177830,177812,177843,177809,177846,177840,177808,177825,177843,177828);
delete from creature where id=17184 and guid in(177822,177847,177823);

delete from creature_addon where guid in(177830,177812,177843,177809,177846,177840,177808,177825,177843,177828);
delete from creature_addon where guid in(177822,177847,177823);

-- gobject Bristlelimb cage -- all cages has other cages inside.. the correct cage are gameobject_template 181714..  
delete from gameobject_template where entry between 181720 and 181733;  -- (thanks to ladel.. i use between)

-- wrong quest starter
delete from creature_queststarter where quest=9622;
insert into creature_queststarter value(17440,9622);

-- wrong quest starter cowlen
delete from creature_queststarter where id=17311 and quest=9528;

-- quest..  no timer on kessel run, we have no critter help so, i set 1 hour
UPDATE quest_template SET LimitTime=3600 WHERE Id=9663;

-- wrong ppsition. npc is not complete in cage..
update creature set position_x=-2521.19,position_y=-12300.9 where guid=175271;

-- npc 17704 double spawns..
delete from creature where id=17704 and guid in(157169,157170,157172);
delete from creature_addon where guid in(157169,157170,157172);

-- npc 17704 double spawns..
delete from creature where id=17704 and guid in(176450,176424,176435,176436,176454,176453,176445,176444,176443,176441,176419);
delete from creature_addon where guid in(176450,176424,176435,176436,176454,176453,176445,176444,176443,176441,176419);

-- npc 18031 2 different npc's on same place
update creature set position_x=-1900.55,position_y=-11888,position_z=40.2904,orientation=1.06222 where guid=162652; 
-- same as for 18023	
update creature set position_x=-2065.84,position_y=-11865.6,position_z=49.5606,orientation=0.339658 where guid=174994; 

-- npc 17606 double spawns..
delete from creature where id=17606 and guid in(175423,175427,175433);		

-- loot for chest 181898
delete from gameobject_loot_template where entry=181898 and item=24236;
insert into gameobject_loot_template values (181898,24236,-100,1,0,1,1);
update gameobject_template set data1=181898 where entry=181898;

-- quest is autocomplete, wrong portrait, wrong credit
UPDATE quest_template SET Flags=128,QuestGiverPortrait=17267,RequiredNpcOrGo1=17974 WHERE Id=9756;

-- ToDo
-- quest 9711 matis the cruel 
-- somewhere in the code, are the events for matis captured.. the script npc_matis_the_cruel is never fired
-- and the script npc_tracker_of_the_hand is called, but maybe a other thread is periodic set some properties to zero values..
UPDATE quest_template SET RequiredNpcOrGo1=17664,RequiredNpcOrGoCount1=1,RequiredItemId1=24278,RequiredItemCount1=1 WHERE Id=9711;
update creature set spawntimesecs=300 where guid=175323;
-- npc 17664 matis the cruel
delete from creature_text where entry=17664;
insert into creature_text value (17664,0,0,"To the death!",12,0,100,0,0,0,"");
insert into creature_text value (17664,1,0,"Matis the Cruel says: You will regret this, maggot.",12,0,100,0,0,0,"");
-- update creature_template set AIName="",ScriptName="npc_matis_the_cruel" where entry=17664;
-- this is the helper in the quest.. has his own script..
-- update creature_template set AIName="",ScriptName="npc_tracker_of_the_hand" where entry=17853;
delete from creature_text where entry=17853;
insert into creature_text value (17853,0,0,"We've got you now, Matis the Cruel!",12,0,100,0,0,0,"");
insert into creature_text value (17853,1,0,"Return to Kuros. I will bring him to Blood Watch.",12,0,100,0,0,0,"");
 
 










