
-- http://www.wowhead.com/npc=39020		Crazed Bilgewater Survivor

delete from creature_text where entry=39020 and groupid=0 and id between 0 and 5;
insert into creature_text values
(39020,0,0,"Monsters! Monsters come to take our gold!",12,0,50,0,0,0,"on Aggro Text",40525),
(39020,0,1,"Kill the pig! Spill its blood!!",12,0,50,0,0,0,"on Aggro Text",40528),
(39020,0,2,"Aaaaaaaaaahhh! AAAAAAAAAAAHHHHHH!!",12,0,50,0,0,0,"on Aggro Text",40527),
(39020,0,3,"Protect the wise one! Protect Meatface!",12,0,50,0,0,0,"on Aggro Text",40529),
(39020,0,4,"Where did we land that has such hideous creatures?!",12,0,50,0,0,0,"on Aggro Text",40526),
(39020,0,5,"You'll never take me alive!",12,0,50,0,0,0,"on Aggro Text",40530);

