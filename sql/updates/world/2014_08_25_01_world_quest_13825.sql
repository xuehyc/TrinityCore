
-- http://www.wowhead.com/quest=13825  Clamlette Surprise

update quest_template set Method=2, RequiredItemId1=12207,RequiredItemId2=7974,RequiredItemId3=3927,RequiredItemCount1=10,RequiredItemCount2=10,RequiredItemCount3=20 where Id=13825;
update quest_template set Objectives="Dirge Quikcleave wants you to get the following items:$B$B10 Giant Eggs. You will find those on the Rocs wandering Tanaris or any other species of large bird.$B$B10 pieces of Zesty Clam Meat. You can find those in clams, naturally!$B$B20 pieces of Alterac Swiss. Get thee to a cheesery!$B$BGather all of the items and return to Dirge." where Id=13825;
update quest_template set Details="Ever heard of a clamlette? Of course you haven't! It's my latest and greatest culinary masterpiece. Oh, $N, just thinking about a clamlette makes my mouth water.$B$BUnfortunately, I'm all out of supplies to make any! How about I make you a deal? You gather the supplies I need to make a clamlette and I'll teach you the finer points of exotic cuisine and I'll even throw in a couple of clamlettes to boot! Deal??$B$BHere's what I need:" where Id=13825;
update quest_template set EndText="Return to Dirge Quikcleave in Tanaris." where Id=13825;

delete from creature_loot_template where entry in (5429,5430,8207) and item=12207;
insert into creature_loot_template values
(5429,12207,-43,1,0,1,1),
(5430,12207,-43,1,0,1,1),
(8207,12207,-44,1,0,1,1);

delete from creature_loot_template where entry in (5431,14123,39022,40764) and item=7973;
insert into creature_loot_template values
(5431,7973,-26,1,0,1,1),
(14123,7973,-27,1,0,1,1),
(39022,7973,-91,1,0,1,1),
(40764,7973,-25,1,0,1,1);

delete from creature_loot_template where entry in (7855,40632,38998,40635,40636,40665,38749,44613,40593,44611,44612,38719,44759,44750) and item=3927;
insert into creature_loot_template values
(7855,3927,-10,1,0,1,1),
(40632,3927,-10,1,0,1,1),
(38998,3927,-9,1,0,1,1),
(40635,3927,-9,1,0,1,1),
(40636,3927,-8,1,0,1,1),
(40665,3927,-8,1,0,1,1),
(38749,3927,-7,1,0,1,1),
(44613,3927,-7,1,0,1,1),
(40593,3927,-6,1,0,1,1),
(44611,3927,-6,1,0,1,1),
(44612,3927,-5,1,0,1,1),
(38719,3927,-5,1,0,1,1),
(44759,3927,-5,1,0,1,1),
(44750,3927,-5,1,0,1,1);

update creature_template set questItem1=12207 where entry=8207;
update creature_template set questItem2=12207 where entry=5429;
update creature_template set questItem3=12207 where entry=5430;

update creature_template set questItem1=7974 where entry=39022;
update creature_template set questItem1=7974 where entry=14123;
update creature_template set questItem1=7974 where entry=5431;
update creature_template set questItem1=7974 where entry=40764;
update creature_template set questItem2=7973 where entry=39022;
update creature_template set questItem2=7973 where entry=14123;
update creature_template set questItem2=7973 where entry=5431;
update creature_template set questItem2=7973 where entry=40764;

update creature_template set questItem3=3927 where entry=7855;
update creature_template set questItem2=3927 where entry=40632;
update creature_template set questItem1=3927 where entry=38998;
update creature_template set questItem2=3927 where entry=40635;
update creature_template set questItem1=3927 where entry=40636;
update creature_template set questItem1=3927 where entry=40665;
update creature_template set questItem1=3927 where entry=38749;
update creature_template set questItem1=3927 where entry=44613;
update creature_template set questItem1=3927 where entry=40593;
update creature_template set questItem1=3927 where entry=44611;
update creature_template set questItem1=3927 where entry=44612;
update creature_template set questItem1=3927 where entry=38719;
update creature_template set questItem3=3927 where entry=44759;
update creature_template set questItem2=3927 where entry=44750;

delete from creature_text where entry=40665 and groupid=0 and id between 0 and 2;
insert into creature_text values 
(40665,0,0,"Ye'll not get around our blockade with scavengin'!",12,0,100,0,0,0,"on Aggro Text",40574),
(40665,0,1,"That be property 'o the Southsea Freebooters now, landlubber!",12,0,100,0,0,0,"on Aggro Text",40573),
(40665,0,2,"The Southsea Freebooters own this shore!",12,0,100,0,0,0,"on Aggro Text",40575);

update creature_template set minlevel=45,maxlevel=45,faction=778 where entry=40665;

update creature set spawndist=0,MovementType=0 where id in (38823,38824);

update creature_template set unit_flags=0 where entry=38719;










